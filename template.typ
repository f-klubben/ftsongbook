// A5 Sangbog template, made by naitsa/lorenzen, and the typst gods (some chat)
// Refactored for better structure with consistent zero-indexing and working hanging indents

// ============================================================================
// CONFIGURATION
// ============================================================================

#let config = (
    // Font
    main-font: "Source Serif 4",
    song-title-font: "Source Sans 3",
    subtext-font: "Source Serif 4",
    song-text-font: "Source Serif 4",
    indhold-entry-font: "Source Serif 4",
    // Size
    main-text-size: 10pt,
    song-title-size: 14pt,
    subtext-text-size: 9pt,
    song-text-size: 8pt,
    indhold-entry-size: 8pt,
    // Weight
    main-text-weight: "regular",
    song-title-weight: "bold",
    subtext-text-weight: "regular",
    song-text-weight: "medium",
    indhold-entry-weight: "regular",
    // Layout
    verse-indent: 0.5em,
    verse-gutter: 0.75em,
    hanging-indent: 1.5em,
    // Spacing configuration
    par-spacing: 0.65em,            // Line spacing WITHIN verses/chorus
    par-leading: 0.65em,            // Line height WITHIN verses/chorus
    verse-to-verse: 0.5em,          // Space between verses
    verse-to-omkvæd: 0.5em,         // Space from verse to chorus
    omkvæd-to-verse: 0.5em,         // Space from chorus to verse
    omkvæd-label-gap: 0.0em,        // Space from "Omkvæd:" to its text
    // Document
    title: "F-Klubbens Sangbog",
    description: "F-Klubbens Fabelagtige Sangbog",
    authors: (
        (name: "BoAnd"),
        (name: "Simlau"),
        (name: "AI"),
        (name: "Jesus"),
        (name: "For-mændene"),
    ),
    date: datetime.today(),
    localisation: (
        lang: "dk",
        region: "dk",
    ),
)

// ============================================================================
// UTILITY FUNCTIONS
// ============================================================================

// Format authors list with proper grammar
#let format-authors(authors) = {
    let names = authors.map(a => a.name)
    if names.len() == 1 {
        names.first()
    } else if names.len() == 2 {
        names.at(0) + " and " + names.at(1)
    } else {
        let all-but-last = names.slice(0, -1).join(", ")
        all-but-last + " and " + names.last()
    }
}

// Helper to apply song text styling consistently
#let apply-song-text(body) = text(
    font: config.song-text-font,
    size: config.song-text-size,
    weight: config.song-text-weight,
)[#body]

// ============================================================================
// LAYOUT HELPERS
// ============================================================================

// Improved column balancing - measures content and distributes evenly
#let balanced-columns(cols, content, gutter: 1em) = {
    layout(size => {
        // Measure the full content height at full width first
        let full-measure = measure(block(width: size.width, content))
        let total-height = full-measure.height
        
        // Calculate the target height per column (with some buffer)
        let target-height = (total-height / cols) * 1.1  // 10% buffer for better flow
        
        // Render columns with calculated height and gutter
        block(height: target-height, columns(cols, gutter: gutter, content))
    })
}

// ============================================================================
// TEXT FORMATTING UTILITIES
// ============================================================================

// style: "oblique" laver bare fallback til itallic, and we dont want that
#let sl(content) = skew(ax: -12deg, reflow: true)[#content]
#let bf(content) = text(weight: "bold")[#content]
// emulere latex sf effekt fra latex sangbog (the best that a Sebastian can atm)
#let sf(content) = text(spacing: 0.5em, tracking: 0.05em, weight: 375)[#content]
#let sc(content) = smallcaps[#content]
#let tt(content) = text(font: "Courier New")[#content]
#let small(content) = text(size: 0.9em)[#content]
#let em(content) = emph[#content]
#let big(content) = text(size: 1.1em)[#content]

// https://gist.github.com/felsenhower/a975c137732e20273f47a117e0da3fd1
#let LaTeX = {
    let A = (
        offset: (
            x: -0.33em,
            y: -0.3em,
        ),
        size: 0.7em,
    )
    let T = (
        x_offset: -0.12em,
    )
    let E = (
        x_offset: -0.2em,
        y_offset: 0.23em,
        size: 1em,
    )
    let X = (
        x_offset: -0.1em,
    )
    [L#h(A.offset.x)#text(size: A.size, baseline: A.offset.y)[A]#h(T.x_offset)T#h(E.x_offset)#text(size: E.size, baseline: E.y_offset)[E]#h(X.x_offset)X]
}

// ============================================================================
// SONG COMPONENTS
// ============================================================================

// Note function - for annotations and instructions
#let note(cols: 1, body) = {
    v(config.verse-to-verse)
    block(
        width: 95%,
        spacing: 0em,
        if cols > 1 {
            balanced-columns(cols, {
                show linebreak: it => [ #parbreak() ]
                set par(
                    first-line-indent: 0em,
                    hanging-indent: 0em,  // No hanging indent for notes
                    spacing: config.par-spacing,
                    leading: config.par-leading,
                )
                apply-song-text(body)
            }, gutter: 1em)
        } else {
            show linebreak: it => [ #parbreak() ]
            set par(
                first-line-indent: 0em,
                hanging-indent: 0em,  // No hanging indent for notes
                spacing: config.par-spacing,
                leading: config.par-leading,
            )
            apply-song-text(body)
        }
    )
    v(config.verse-to-verse)
}

// Verse function with hanging indent (default behavior)
#let vers(body) = {    
    block(
        width: 95%,
        spacing: 0em,
        {
            // Place verse number to the left
            place(
                dx: -(config.verse-indent + config.verse-gutter),
                dy: 0em,
                text(
                    font: config.song-text-font,
                    size: config.song-text-size,
                    weight: config.song-text-weight,
                )[#context counter("verse").display().]
            )
            
            // Content with hanging indent - each \ creates new paragraph
            show linebreak: it => [ #parbreak() ]
            set par(
                hanging-indent: config.hanging-indent,
                spacing: config.par-spacing,
                leading: config.par-leading,
            )
            text(
                font: config.song-text-font,
                size: config.song-text-size,
                weight: config.song-text-weight,
            )[#body]
        }
    )
    
    v(config.verse-to-verse)
    counter("verse").step()
}

// Chorus function with hanging indent (default behavior)
#let omkvæd(body) = {    
    block(
        width: 95%,
        spacing: 0em,
        {
            // "Omkvæd:" label - positioned to the left like verse numbers
            block(
                width: 100%,
                spacing: 0em,
                {
                    place(
                        dx: -(config.verse-indent + config.verse-gutter),
                        dy: 0em,
                        text(
                            font: config.song-text-font,
                            size: config.song-text-size,
                            weight: config.song-text-weight,
                        )[Omkvæd:]
                    )
                    
                    // Invisible spacer to push content down past the label
                    v(1em)  // Height of one line to clear the "Omkvæd:" label
                }
            )
            
            v(config.omkvæd-label-gap)
            
            // Content with hanging indent - starts at same position as verse text
            block(
                width: 100%,
                spacing: 0em,
                {
                    show linebreak: it => [ #parbreak() ]
                    set par(
                        hanging-indent: config.hanging-indent,
                        spacing: config.par-spacing,
                        leading: config.par-leading,
                    )
                    text(
                        font: config.song-text-font,
                        size: config.song-text-size,
                        weight: config.song-text-weight,
                    )[#body]
                }
            )
        }
    )
    
    v(config.omkvæd-to-verse)
}

// Song function - main container for songs
#let sang(title, subtext: none, cols: 1, subtext-indent: 4em, body) = {
    // Initialize verse counter to 0 (zero-indexed)
    counter("verse").update(0)
    
    // Label for sangindex
    let song-label = label(repr(title).replace(" ", "-").replace(",", "").replace(".", ""))

    block(
        width: 100%,
        inset: (bottom: 0em),
        {
            layout(size => {
                let title-with-number = [
                    #text(font: config.song-title-font, size: config.song-title-size, weight: config.song-title-weight)[
                        #context counter("song").display(). #title
                    ] #song-label
                ]

                let title-width = measure(title-with-number).width
                let spacing-width = measure(h(2em)).width
                let subtext-content = if subtext != none {
                    text(
                        font: config.subtext-font,
                        size: config.subtext-text-size,
                        weight: config.subtext-text-weight,
                        style: "italic",
                    )[#subtext]
                } else { none }

                if subtext != none and title-width + spacing-width + measure(subtext-content).width > size.width {
                    // Title too long - put subtext on new line with indent
                    [#title-with-number #linebreak() #h(subtext-indent) #subtext-content]
                } else if subtext != none {
                    // Title fits - put subtext inline with 2em spacing
                    [#title-with-number #h(2em) #subtext-content]
                } else {
                    // No subtext
                    title-with-number
                }
                hide(place[#heading(level: 1, numbering: none, outlined: true)[#title]])
            })
            v(0.5em)
            
            // Add left padding to align with song title and reduce gutter
            if cols > 1 {
                pad(
                    left: config.verse-indent + config.verse-gutter,
                    balanced-columns(cols, body, gutter: 0.5em)  // Smaller gutter
                )
            } else {
                pad(
                    left: config.verse-indent + config.verse-gutter,
                    body
                )
            }
            
            // Increment song counter AFTER rendering (maintains zero-indexed display)
            counter("song").step()
        }
    )
}

// ============================================================================
// DOCUMENT SETUP
// ============================================================================

#let songbook(
    title: config.title,
    description: config.description,
    authors: config.authors,
    date: config.date,
    localisation: config.localisation,
    body,
) = {
    set document(
        title: title,
        description: description,
        author: authors.map(a => a.name),
        keywords: "Boobies",
        date: date,
    )

    // Page setup
    set page(
        paper: "a5",
        margin: (
            top: 1.5cm,
            bottom: 1.5cm,
            left: 1.2cm,
            right: 1.2cm,
        ),
        numbering: none, // Disable default numbering
        footer: context {
            // Zero-indexed page numbers
            let page-num = here().page() - 1
            if calc.odd(here().page()) {
                align(right)[#page-num]
            } else {
                align(left)[#page-num]
            }
        },
    )

    // Initialize song counter to 0 (zero-indexed)
    counter("song").update(0)

    // Normal text appearance
    set text(
        font: config.main-font,
        size: config.main-text-size,
        weight: config.main-text-weight,
        lang: "dk",
    )

    show raw: set text(font: "Courier New")

    // Paragraph spacing
    set par(
        justify: false,
        leading: 0.65em,
    )

    show link: it => {
        text(
            font: config.main-font,
            size: config.indhold-entry-size,
            weight: config.main-text-weight,
            it,
        )
    }

    body
}

// ============================================================================
// PAGE TEMPLATES
// ============================================================================

#let forside = page[
    #set text(font: config.main-font, size: config.main-text-size, weight: config.main-text-weight)
    #align(center)[
        #v(1cm)
        #text(size: 2.5em, weight: "regular")[#smallcaps[#config.title]]
        #v(0.4cm)
        #text(size: 1em, weight: "regular")[
            Made by #format-authors(config.authors) - #config.date.year()
        ]
        #v(1.5cm)
        #image("assets/fklubben.svg", width: 70%)
    ]
]

#let forord = page()[
    \#fritfit\
    \#fritfor
]

#let meme_page_spacer = page()[
    *error*: unknown function `undefinedcontrolsequence`
]

#let indholdfortegnelse(cols: 3) = page({
    heading(level: 1, numbering: none, outlined: false, text(
        font: config.song-title-font,
        size: config.song-title-size,
        weight: config.song-title-weight,
    )[Indholdsfortegnelse])

    v(0.5cm)
    set par(leading: 0.30em)

    columns(cols, gutter: 0.5cm, {
        context {
            let chapters = query(
                heading.where(
                    level: 1,
                    outlined: true,
                ),
            ).sorted(key: chapter => {
                lower(repr(chapter.body))
            })

            // Group all chapters by their starting character
            let groups = (:)

            for chapter in chapters {
                // Get the string representation and extract content
                let chapter_repr = repr(chapter.body)
                let actual_content = ""
                if chapter_repr.starts-with("[") and chapter_repr.ends-with("]") {
                    actual_content = chapter_repr.slice(1, -1)
                } else {
                    actual_content = chapter_repr
                }

                let chapter_text = lower(actual_content)

                // Determine group
                let group_key = "non-letter" // Default
                if chapter_text.len() > 0 {
                    let first_char = chapter_text.first()
                    if first_char >= "a" and first_char <= "z" {
                        group_key = first_char
                    }
                }

                // Add to groups
                if group_key in groups {
                    groups.at(group_key).push(chapter)
                } else {
                    groups.insert(group_key, (chapter,))
                }
            }

            // Sort group keys so non-letter comes first, then alphabetical
            let group_keys = groups
                .keys()
                .sorted(key: key => {
                    if key == "non-letter" { "0" } else { key }
                })

            // Print each group
            let first_group = true
            for group_key in group_keys {
                // Add spacing between groups (except before first group)
                if not first_group {
                    v(0.1em)
                }
                first_group = false

                // Print all chapters in this group
                for chapter in groups.at(group_key) {
                    let loc = chapter.location()
                    // Zero-indexed page numbering (single subtraction)
                    let page-num = loc.page() - 1
                    link(
                        loc,
                        [ #chapter.body #page-num \ ] ,
                    )
                }
            }
        }
    })
})

#let kapitelside(titel: none, asset: "assets/fklubben.svg", spacing: 2cm) = page[
    #set text(font: config.main-font, size: config.main-text-size, weight: config.main-text-weight)
    #align(center)[
        #v(1cm)
        #text(size: 2.5em, weight: "regular")[#smallcaps[#titel]]
        #v(spacing)
        #if asset != none [
            #image(asset, width: 70%)
        ]
    ]
]