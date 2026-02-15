// A5 Sangbog template, made by naitsa/lorenzen, and the typst gods (some chat)
// Inspired by Tågekamemrt rus tempalte from the 90's and more modern work

//TODO:
//- forord
//- alternate covers

// =============
// CONFIGURATION
// =============

#let config = (
    // Font families (3 fonts)
    body-font: "Source Serif 4",      // For all body text, subtext, song text
    heading-font: "Source Sans 3",    // For all headings (Indholdsfortegnelse, chapter titles)
    title-font: "Source Sans 3",      // For song titles
    
    // Font sizes (4 sizes)
    body-size: 8pt,                   // Song lyrics, notes, subtext
    toc-size: 9pt,                    // Table of contents entries
    title-size: 14pt,                 // Song titles
    heading-size: 14pt,               // Section headings (Indholdsfortegnelse, chapters)
    
    // Weight
    body-weight: "medium",            // Song text weight
    subtext-weight: "regular",        // Subtext weight
    title-weight: "bold",             // Song title weight
    heading-weight: "bold",           // Section heading weight
    toc-weight: "regular",            // TOC entry weight
    
    // Page layout
    paper: "a5",
    margin-top: 1.5cm,
    margin-bottom: 1.5cm,
    margin-inside: 1cm,
    margin-outside: 1cm,
    
    // Song layout
    verse-indent: 0.5em,              // Space reserved for verse numbers
    verse-gutter: 0.75em,             // Space between verse number and text
    hanging-indent: 1.5em,            // Hanging indent for wrapped lines
    subtext-indent: 4em,              // Indent for subtext on new line
    
    // Spacing configuration
    par-spacing: 0.65em,              // Space between paragraphs within verses/chorus
    par-leading: 0.65em,              // Line height within verses/chorus
    song-element-spacing: 1em,        // Space between song elements (verses, chorus, notes)
    omkvæd-label-gap: 0.0em,          // Space from "Omkvæd:" label to its text
    song-title-spacing: 0.25em,       // Space between song title and first verse
    song-title-subtext-gap: 2em,      // Horizontal space between title and inline subtext
    
    // TOC layout
    toc-columns: 3,                   // Number of columns in table of contents
    toc-gutter: 0.5cm,                // Space between TOC columns
    toc-par-leading: 0.30em,          // Line height within TOC entries
    toc-par-spacing: 0.30em,          // Space between TOC entries
    toc-hanging-indent: 1em,          // Hanging indent for wrapped TOC entries
    toc-group-spacing: 1em,           // Space between letter groups in TOC
    toc-top-spacing: 0.5cm,           // Space between heading and TOC content
    
    // Cover page layout
    cover-top-spacing: 1cm,
    cover-title-spacing: 0.4cm,
    cover-image-spacing: 1.5cm,
    cover-image-width: 70%,
    
    // Chapter page layout
    chapter-top-spacing: 1cm,
    chapter-image-spacing: 2cm,
    chapter-image-width: 70%,
    
    // Document metadata
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

// =================
// UTILITY FUNCTIONS
// =================

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
    font: config.body-font,
    size: config.body-size,
    weight: config.body-weight,
)[#body]

// Song number prefix management
#let song-number-prefix = state("song-number-prefix", "")

#let nynummerpræfiks(prefix) = {
    song-number-prefix.update(prefix)
    counter("song").update(0)
}

// Helper function to display song number with prefix
#let display-song-number() = context {
    let prefix = song-number-prefix.get()
    let number = counter("song").get().first()
    if prefix != "" {
        [#prefix#number]
    } else {
        [#number]
    }
}

// Function to set the song counter to a specific number
#let sætsangnummer(number) = {
    counter("song").update(number)
}

// ==============
// LAYOUT HELPERS
// ==============

// Force a column break - moves to next column
#let csplit = colbreak()

// =========================
// TEXT FORMATTING UTILITIES
// =========================

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

// ===============
// SONG COMPONENTS
// ===============

// Note function - for annotations and instructions
#let note(cols: 1, body) = {
    block(
        width: 100%,
        spacing: 0em,
        {
            // Shift left to align with verse numbers
            pad(
                left: -(config.verse-indent + config.verse-gutter),
                if cols > 1 {
                    columns(cols, gutter: 1em, {
                        show linebreak: it => [ #parbreak() ]
                        set par(
                            first-line-indent: 0em,
                            hanging-indent: 0em,  // No hanging indent for notes
                            spacing: config.par-spacing,
                            leading: config.par-leading,
                        )
                        apply-song-text(body)
                    })
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
        }
    )
    v(config.song-element-spacing)
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
                    font: config.body-font,
                    size: config.body-size,
                    weight: config.body-weight,
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
                font: config.body-font,
                size: config.body-size,
                weight: config.body-weight,
            )[#body]
        }
    )
    
    v(config.song-element-spacing)
    counter("verse").step()
}

// Chorus function with hanging indent (default behavior)
#let omkvæd(inline: false, body) = {
    if inline {
        // Inline mode - behaves like note with "Omkvæd: " prefix
        block(
            width: 100%,
            spacing: 0em,
            {
                // Shift left to align with verse numbers
                pad(
                    left: -(config.verse-indent + config.verse-gutter),
                    {
                        show linebreak: it => [ #parbreak() ]
                        set par(
                            first-line-indent: 0em,
                            hanging-indent: 0em,
                            spacing: config.par-spacing,
                            leading: config.par-leading,
                        )
                        text(
                            font: config.body-font,
                            size: config.body-size,
                            weight: config.body-weight,
                        )[Omkvæd: #body]
                    }
                )
            }
        )
        v(config.song-element-spacing)
    } else {
        // Normal mode - full chorus with label on left
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
                                font: config.body-font,
                                size: config.body-size,
                                weight: config.body-weight,
                            )[Omkvæd:]
                        )
                        
                        // Invisible spacer to push content down past the label
                        v(1em)
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
                            font: config.body-font,
                            size: config.body-size,
                            weight: config.body-weight,
                        )[#body]
                    }
                )
            }
        )
        
        v(config.song-element-spacing)
    }
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
                    #text(font: config.title-font, size: config.title-size, weight: config.title-weight)[
                         #display-song-number(). #title
                    ] #song-label
                ]

                let title-width = measure(title-with-number).width
                let spacing-width = measure(h(2em)).width
                let subtext-content = if subtext != none {
                    text(
                        font: config.body-font,
                        size: config.body-size,
                        weight: config.subtext-weight,
                        style: "italic",
                    )[#subtext]
                } else { none }

                if subtext != none and title-width + spacing-width + measure(subtext-content).width > size.width {
                    // Title too long - put subtext on new line with indent
                    [#title-with-number #linebreak() #h(config.subtext-indent) #subtext-content]
                } else if subtext != none {
                    // Title fits - put subtext inline with 2em spacing
                    [#title-with-number #h(config.song-title-subtext-gap) #subtext-content]
                } else {
                    // No subtext
                    title-with-number
                }
                hide(place[#heading(level: 1, numbering: none, outlined: true)[#title]])
            })
            v(config.song-title-spacing)
            
            // Add left padding to align with song title
            if cols > 1 {
                pad(
                    left: config.verse-indent + config.verse-gutter,
                    columns(cols, gutter: 1em, body)  // Use native columns with manual breaks
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

// ==============
// DOCUMENT SETUP
// ==============

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
        paper: config.paper,
        margin: (
            top: config.margin-top,
            bottom: config.margin-bottom,
            inside: config.margin-inside,
            outside: config.margin-outside,
        ),
        numbering: none, // Disable default numbering
        footer: context {
            // Zero-indexed page numbers
            let page-num = here().page() - 1
            if calc.odd(here().page()) {
                align(right)[#text(font: config.heading-font, size: config.heading-size, weight: config.heading-weight)[#page-num]]
            } else {
                align(left)[#text(font: config.heading-font, size: config.heading-size, weight: config.heading-weight)[#page-num]]
            }
        },
    )

    // Initialize song counter to 0 (zero-indexed)
    counter("song").update(0)

    // Normal text appearance
    set text(
        font: config.body-font,
        size: config.body-size,
        weight: config.body-weight,
        lang: "dk",
    )

    show raw: set text(font: "Courier New")

    // Paragraph spacing
    set par(
        justify: false,
        leading: config.par-leading,
    )

    show link: it => {
        text(
            font: config.body-font,
            size: config.toc-size,
            weight: config.toc-weight,
            it,
        )
    }

    body
}

// ==============
// PAGE TEMPLATES
// ==============

#let forside = page[
    #set text(font: config.body-font, size: config.body-size, weight: config.body-weight)
    #align(center)[
        #v(config.cover-top-spacing)
        #text(size: 2.5em, weight: "regular")[#smallcaps[#config.title]]
        #v(config.cover-title-spacing)
        #text(size: 1em, weight: "regular")[
            Made by #format-authors(config.authors) - #config.date.year()
        ]
        #v(config.cover-image-spacing)
        #image("assets/fklubben.svg", width: config.cover-image-width)
    ]
]

#let forord = page()[
    \#fritfit\
    \#fritfor
]

#let meme_page_spacer = page()[
    *error*: unknown function `undefinedcontrolsequence`
]

#let indholdfortegnelse(cols: config.toc-columns) = page({
    heading(level: 1, numbering: none, outlined: false, text(
        font: config.heading-font,
        size: config.heading-size,
        weight: config.heading-weight,
    )[Indholdsfortegnelse])

    v(config.toc-top-spacing)

    columns(cols, gutter: config.toc-gutter, {
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

            // Set paragraph spacing for all entries
            set par(
                leading: config.toc-par-leading,
                spacing: config.toc-par-spacing,
                hanging-indent: config.toc-hanging-indent,
            )

            // Print each group
            let first_group = true
            for group_key in group_keys {
                // Add spacing between groups (except before first group)
                if not first_group {
                    v(config.toc-group-spacing)
                }
                first_group = false

                // Print all chapters in this group
                for chapter in groups.at(group_key) {
                    let loc = chapter.location()
                    // Zero-indexed page numbering (single subtraction)
                    let page-num = loc.page() - 1
                    
                    par[#link(loc, [#chapter.body, (*s. #page-num*)])]
                }
            }
        }
    })
})

#let kapitelside(titel: none, asset: "assets/fklubben.svg", spacing: config.chapter-image-spacing) = page[
    #set text(font: config.body-font, size: config.body-size, weight: config.body-weight)
    #align(center)[
        #v(config.chapter-top-spacing)
        #text(size: 2.5em, weight: "regular")[#smallcaps[#titel]]
        #v(spacing)
        #if asset != none [
            #image(asset, width: config.chapter-image-width)
        ]
    ]
]
