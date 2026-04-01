#import "template.typ": *

#show: songbook.with(
    title: "F-Klubbens Fabelagtige Sangbog"
)

//#set block(stroke: 2pt + red)

#jubiiiii

#forord

#indholdfortegnelse(cols: 2)

#v(1cm)
#align(center)[
    #image("assets/foret.png", width: 100%)
]
#pagebreak()

#kapitelside(titel: "F-Klub Sange")

#pagebreak()

#include "fklub-sange.typ"