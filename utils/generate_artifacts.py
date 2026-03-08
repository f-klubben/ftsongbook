import os
import re
import json
import sys
import base64
from pathlib import Path

CWD = Path.cwd()
JSON_PATH = CWD.joinpath("songs.json")


# =============================================================================
# UTILS
# =============================================================================

def encode_image(image_path: str) -> str:
    with open(image_path, "rb") as f:
        return base64.b64encode(f.read()).decode("utf-8")


def get_file_contents(path: str) -> str:
    with open(path, mode="r", encoding="utf-8") as f:
        return f.read()


def find_typ_files(root_dir: str) -> list[str]:
    """Recursively find all .typ files under root_dir."""
    results = []
    for dirpath, _, filenames in os.walk(root_dir):
        for fname in filenames:
            if fname.endswith(".typ"):
                results.append(os.path.join(dirpath, fname))
    return results


# =============================================================================
# TYPST BRACKET / PAREN EXTRACTION
# =============================================================================

def extract_bracket_content(text: str, start: int) -> tuple[str, int]:
    """
    Given text and the index of '[', return (inner_content, end_index).
    end_index points to the character after the closing ']'.
    Handles nesting.
    """
    assert text[start] == "[", f"Expected '[' at {start}, got {text[start]!r}"
    depth = 0
    i = start
    while i < len(text):
        if text[i] == "[":
            depth += 1
        elif text[i] == "]":
            depth -= 1
            if depth == 0:
                return text[start + 1:i], i + 1
        i += 1
    raise ValueError(f"Unmatched '[' starting at position {start}")


def extract_paren_content(text: str, start: int) -> tuple[str, int]:
    """
    Given text and the index of '(', return (inner_content, end_index).
    Handles nesting.
    """
    assert text[start] == "(", f"Expected '(' at {start}, got {text[start]!r}"
    depth = 0
    i = start
    while i < len(text):
        if text[i] == "(":
            depth += 1
        elif text[i] == ")":
            depth -= 1
            if depth == 0:
                return text[start + 1:i], i + 1
        i += 1
    raise ValueError(f"Unmatched '(' starting at position {start}")


# =============================================================================
# SONG HEADER PARSING
# =============================================================================

def parse_sang_header(content: str) -> tuple[str | None, str | None]:
    """
    Extract title and melody from a #sang(...) call.
    Returns (title, melody_or_None).

    Examples:
        #sang("Title")
        #sang("Title", subtext: "Mel: Something", cols: 2)
    """
    match = re.search(r'#sang\(', content)
    if not match:
        return None, None

    try:
        args_str, _ = extract_paren_content(content, match.end() - 1)
    except (ValueError, AssertionError):
        return None, None

    title_match = re.match(r'\s*"([^"]*)"', args_str)
    title = title_match.group(1).capitalize() if title_match else None

    subtext_match = re.search(r'subtext\s*:\s*"([^"]*)"', args_str)
    melody = None
    if subtext_match:
        raw = subtext_match.group(1)
        melody = re.sub(
            r'^(?:Mel(?:odi)?[\s:\-]+)', "", raw, flags=re.IGNORECASE
        ).strip().capitalize()

    return title, melody


# =============================================================================
# LYRIC TEXT CLEANING
# =============================================================================

# Inline style wrappers whose content should be kept but markup stripped
_UNWRAP_CMDS = (
    "bf", "sf", "sl", "sc", "em", "tt", "small", "strong", "emph",
    "big", "context",
)


def clean_typst_text(text: str) -> str:
    """
    Strip Typst markup from lyric text while preserving the actual words.

    - Inline style wrappers (#bf[...] etc.)  → unwrap content
    - #set ... lines                          → remove
    - #h(...) spacing                         → remove
    - $...$ math                              → strip delimiters, keep content
    - #LaTeX                                  → "LaTeX"
    - backslash at end of line                → newline
    - remaining unknown #cmd                  → remove
    - stray brackets from unwrapping          → remove
    """
    # Unwrap known style wrappers: mark opening tag, strip it, clean up ] later
    for cmd in _UNWRAP_CMDS:
        text = re.sub(rf'#{re.escape(cmd)}\s*\[', "\x00", text)
    text = text.replace("\x00", "")

    # Remove #set ... lines
    text = re.sub(r'#set\s+[^\n]*\n?', "", text)

    # Remove #h(...) horizontal spacing
    text = re.sub(r'#h\s*\([^)]*\)', "", text)

    # Strip $...$ math delimiters, keep content
    text = re.sub(r'\$([^$]*)\$', r'\1', text)

    # Named constants
    text = re.sub(r'#LaTeX\b', "LaTeX", text)

    # Typst line-break: backslash at end of line
    text = re.sub(r'\s*\\\s*\n', "\n", text)

    # Remove remaining unknown #word commands
    text = re.sub(r'#[A-Za-zÆæØøÅå]\w*\b', "", text)

    # Remove stray brackets left from unwrapping
    text = re.sub(r'\[', "", text)
    text = re.sub(r'\]', "", text)

    # Collapse excess blank lines
    text = re.sub(r'\n{3,}', "\n\n", text)

    return text.strip()


# =============================================================================
# SONG BODY BLOCK FINDER
# =============================================================================

# Matches #commandName — supports Danish letters in command names
_CMD_RE = re.compile(r'#([A-Za-zÆæØøÅå]\w*)')

# Commands that take a [...] body block
_BRACKET_CMDS = {"vers", "omkvæd", "note", "align"}


def find_all_blocks(content: str) -> list[tuple[int, str, str]]:
    """
    Scan the interior of a #sang[...] body and return all recognised blocks
    in source order:

        (line_number, block_type, raw_content)

    block_type ∈ {"vers", "omkvæd", "note", "image", "csplit"}
    """
    results = []
    i = 0
    line_at = lambda pos: content[:pos].count("\n")

    while i < len(content):
        m = _CMD_RE.match(content, i)
        if not m:
            i += 1
            continue

        cmd = m.group(1)
        cmd_start = i
        i = m.end()

        # csplit ──────────────────────────────────────────────────────────────
        if cmd == "csplit":
            results.append((line_at(cmd_start), "csplit", ""))
            continue

        # #vers[...] / #omkvæd[...] / #note[...] / #align[...] ──────────────
        if cmd in _BRACKET_CMDS:
            j = i
            while j < len(content) and content[j] in (" ", "\t", "\n"):
                j += 1
            if j < len(content) and content[j] == "[":
                try:
                    block_content, end = extract_bracket_content(content, j)
                    results.append((line_at(cmd_start), cmd, block_content))
                    i = end
                except ValueError:
                    pass
            continue

        # #image("/path", ...) ───────────────────────────────────────────────
        if cmd == "image":
            j = i
            while j < len(content) and content[j] in (" ", "\t"):
                j += 1
            if j < len(content) and content[j] == "(":
                try:
                    img_args, end = extract_paren_content(content, j)
                    path_match = re.match(r'\s*"([^"]*)"', img_args)
                    if path_match:
                        results.append((
                            line_at(cmd_start),
                            "image",
                            path_match.group(1),
                        ))
                    i = end
                except ValueError:
                    pass
            continue

        # Unknown command – advance past it
        continue

    return results


# =============================================================================
# SONG BODY PARSER
# =============================================================================

def get_song_body(content: str) -> list:
    """
    Parse a full .typ song file and return the body list:

        verses   → (line_no, "v", text)
        choruses → (line_no, "c", text)
        images   → (line_no, "i", width, rel_path, base64_data)
    """
    sang_match = re.search(r'#sang\(', content)
    if not sang_match:
        return []

    try:
        _, paren_end = extract_paren_content(content, sang_match.end() - 1)
    except (ValueError, AssertionError):
        return []

    # Find the body block '['
    i = paren_end
    while i < len(content) and content[i] in (" ", "\t", "\n"):
        i += 1

    if i >= len(content) or content[i] != "[":
        return []

    try:
        body_content, _ = extract_bracket_content(content, i)
    except ValueError:
        return []

    blocks = find_all_blocks(body_content)
    result = []

    for line_no, btype, raw in blocks:
        if btype == "vers":
            result.append((line_no, "v", clean_typst_text(raw)))

        elif btype == "omkvæd":
            result.append((line_no, "c", clean_typst_text(raw)))

        elif btype == "note":
            result.append((line_no, "v", clean_typst_text(raw)))

        elif btype == "image":
            # raw is the image path as written in source, e.g.
            # "/sange/assets/enkortenlang/enkortenlangs1.png"
            image_path = raw.lstrip("/")
            width = "1.0"
            try:
                b64 = encode_image(image_path)
            except FileNotFoundError:
                b64 = ""
            result.append((line_no, "i", width, image_path, b64))

        # csplit / align are layout hints – skip

    return result


# =============================================================================
# MAIN.TYP ORDER + SECTION PREFIX PARSING
# =============================================================================

def parse_main_order(main_path: str) -> list[tuple[str, str]]:
    """
    Parse main.typ and return an ordered list of (stem, prefix) pairs.

    Handles:
        #include "sange/unsorted/costadelsol.typ"  → stem "costadelsol"
        #nynummerpræfiks("G")                       → prefix changes to "G"
    """
    content = get_file_contents(main_path)
    order: list[tuple[str, str]] = []
    current_prefix = ""

    for line in content.splitlines():
        stripped = line.strip()

        # Section prefix reset
        prefix_match = re.match(
            r'#nynummerpr[æa]fiks\s*\(\s*"([^"]*)"\s*\)', stripped
        )
        if prefix_match:
            current_prefix = prefix_match.group(1)
            continue

        # Song include
        include_match = re.match(r'#include\s+"([^"]+)"', stripped)
        if include_match:
            stem = Path(include_match.group(1)).stem
            order.append((stem, current_prefix))

    return order


# =============================================================================
# COUNTER
# =============================================================================

class Counter:
    """
    Assigns song numbers matching the ordering and prefix scheme from main.typ.

    Songs are numbered per-section (prefix group), resetting to 1 when the
    prefix changes — mirroring #nynummerpræfiks + counter("song").update(0).

    Songs not found in the order list are appended at the end under the last
    active prefix.
    """

    def __init__(self, order: list[tuple[str, str]]):
        self._order = order

        # stem → (order_index, prefix)
        self._lookup: dict[str, tuple[int, str]] = {
            stem: (idx, prefix)
            for idx, (stem, prefix) in enumerate(order)
        }

        # Precompute per-section sequential numbers (1-indexed within prefix)
        self._section_numbers: dict[int, int] = {}
        section_counts: dict[str, int] = {}
        for idx, (stem, prefix) in enumerate(order):
            section_counts[prefix] = section_counts.get(prefix, 0) + 1
            self._section_numbers[idx] = section_counts[prefix]

        # For overflow (unknown) songs
        self._overflow_counts: dict[str, int] = dict(section_counts)
        self._last_prefix: str = order[-1][1] if order else ""

        self.last_number: int = 0
        self.last_prefix: str = ""

    def get(self, file_stem: str) -> tuple[str, int]:
        """Return (prefix, number) for the given file stem."""
        if file_stem in self._lookup:
            idx, prefix = self._lookup[file_stem]
            number = self._section_numbers[idx]
        else:
            prefix = self._last_prefix
            self._overflow_counts[prefix] = (
                self._overflow_counts.get(prefix, 0) + 1
            )
            number = self._overflow_counts[prefix]

        self.last_number = number
        self.last_prefix = prefix
        return prefix, number

    @staticmethod
    def format_number(prefix: str, number: int) -> str:
        return f"{prefix}{number}"


# =============================================================================
# MAIN
# =============================================================================

if __name__ == "__main__":
    songs_dir = "sange"
    main_typ = "main.typ"

    # Build ordering from main.typ
    if os.path.isfile(main_typ):
        order = parse_main_order(main_typ)
        print(f"Found {len(order)} songs listed in {main_typ}")
    else:
        print(f"Warning: {main_typ} not found – songs will be unordered", file=sys.stderr)
        order = []

    counter = Counter(order)

    # Collect all .typ files recursively under sange/
    all_typ_files = find_typ_files(songs_dir)
    print(f"Found {len(all_typ_files)} .typ files under '{songs_dir}/'")

    # Build stem → path map (last-wins if duplicate stems across subdirs)
    stem_to_path: dict[str, str] = {}
    for path in all_typ_files:
        stem_to_path[Path(path).stem] = path

    # Sort: main.typ order first, then any extras alphabetically
    ordered_paths: list[str] = []
    seen: set[str] = set()
    for stem, _ in order:
        if stem in stem_to_path and stem not in seen:
            ordered_paths.append(stem_to_path[stem])
            seen.add(stem)
    for path in sorted(all_typ_files):
        stem = Path(path).stem
        if stem not in seen:
            ordered_paths.append(path)
            seen.add(stem)

    # Parse each song
    json_res = []
    total = len(ordered_paths)

    for idx, song_path in enumerate(ordered_paths, start=1):
        sys.stdout.write("\rGenerating songbook %d%%" % ((idx / total) * 100))
        sys.stdout.flush()

        contents = get_file_contents(song_path)
        title, melody = parse_sang_header(contents)

        if title is None:
            continue

        prefix, number = counter.get(Path(song_path).stem)
        body = get_song_body(contents)

        json_res.append({
            "number": Counter.format_number(prefix, number),
            "title": title,
            "melody": melody,
            "body": body,
            "path": song_path,
        })

    print(f"\n\rWriting {len(json_res)} songs to {JSON_PATH}")
    with open(JSON_PATH, encoding="utf-8", mode="w") as f:
        f.write(json.dumps(json_res, ensure_ascii=False, indent=2))