#import "template.typ": *



#show: songbook.with(
    title: "F-Klubbens Fabelagtige Sangbog"
)

//#set block(stroke: 2pt + red)

//#jubiiiii


#page(
    footer: none, header: none, margin: 0pt
)[
    #image("assets/forside fuldbryllup.pdf", page: 1)
]

#page(
    footer: none, header: none, margin: 0pt
)[
    #image("assets/inderside_for.pdf", page: 1)
]

#pagebreak()

#text(font: config.song-title-font, size: config.song-title-size, weight: config.song-title-weight)[Et Tilbageblik]

#f50
#pagebreak()

#align(center)[
#text(font: config.song-title-font, size: config.song-title-size, weight: config.song-title-weight)[Tusind tak til Fuldbrylllupudvalget]: \
]
\
#align(center)[
Oliver Viller Neilsen (Foliver) \
Kresten Laust Faaborg Sckrel \
Jakob Topholt Jensen \
Anders Rask Sørensen \
Patrick Kaas Reiffenstein \
Theis Møller Nørby Jensen \
Emil Kristensen Vorre
]

#f50
#pagebreak()

//#jubiiiii

Værhilset til #smallcaps[F-Klubbens] 50-års-jubilæumssangbog!

Denne sangbog, (som nok ligner et "sanghæfte"), er et en kompilering af alle f-klub sange fundet i sangbogen i hvert i fald 20 år tilbage \~20 år. Jeg håber at den falder jer inde, og i for skråler jeres hjerter ud i sang.

PS. Hvis man er i besiddelse af ældre (eller nye!) sange. tag endeligt kontakt!

Med venlig hilsen den regerende for-mand, \
_Sebastian Haahr Lorenzen_

#place(
            top + right,
            dx: 0.5cm,
            dy: 8cm,
            image("assets/milepæl50.png", width: 4cm),
        )

#f50
#pagebreak()

#indholdfortegnelse(cols: 2)


#v(1cm)
#align(center)[
    #image("assets/foret.png", width: 100%)
]
#f50
#pagebreak()

#kapitelside(titel: "F-Klub Sange")
#pagebreak()

#include "fklub-sange.typ"

#pagebreak()
#align(center)[
#text(font: config.song-title-font, size: config.song-title-size, weight: config.song-title-weight)[Hilsner]]

#f50
#pagebreak()
#page(
    footer: none, header: none, margin: 0pt
)[
    #image("assets/bagside.pdf", page: 1)
]