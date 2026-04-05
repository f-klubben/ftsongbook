#import "template.typ": *

#let f50 = {place(bottom + center, dy: 1.2cm, image("assets/50.png", width: 2cm))}

#show: songbook.with(
    title: "F-Klubbens Fabelagtige Sangbog"
)

//#set block(stroke: 2pt + red)

#jubiiiii

Værhilset til #smallcaps[F-Klubbens] 50-års-jubilæumssangbog!

Denne sangbog, (som nok ligner et "sanghæfte"), er et en kompilering af alle f-klub sange fundet i sangbogen i hvert i fald 20 år tilbage \~20 år. Jeg håber at den falder jer inde, og i for skråler jeres hjerter ud i sang.

PS. Hvis man er i besiddelse af ældre (eller nye!) sange. tag endeligt kontakt!

Med venlig hilsen den regerende for-mand, \
_Sebastian Haahr Lorenzen_

\

_Tusind tak til Fuldbrylllupudvalget_:
Oliver Viller Neilsen (Foliver)
Kresten Laust Faaborg Sckrel
Jakob Topholt Jensen
Anders Rask Sørensen
Patrick Kaas Reiffenstein
Theis Møller Nørby Jensen
Emil Kristensen Vorre


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
#f50
#pagebreak()

#include "fklub-sange.typ"