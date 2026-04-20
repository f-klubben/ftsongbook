#import "template.typ": *

#show: songbook.with(
    title: "F-Klubbens Fabelagtige Sangbog"
)

//#set block(stroke: 2pt + red)

#jubiiiii

Værhilset til #smallcaps[F-Klubbens] 50-års-jubilæumssangbog!

Denne sangbog (som nok ligner et “sanghæfte”) er en samling af (næsten) alle de #smallcaps[F-Klub]-sange, som kunne findes i den moderne sangbog, tidligere sanghæfter (eller er det “sangskrifter”?), F-nüt og andre dokumenter. Jeg håber, at den falder jer i god jord, og at I får skrålet jeres hjerter ud i sang.

Tak til alle, der har skrevet eller været med til at skrive disse fabelagtige sange.

PS. Hvis man er i besiddelse af ældre (eller nye!) sange, må man meget gerne tage kontakt!

Med en umanerbar, lidt uhøflig, småarrogant, og kun delvist velovervejet, men trods alt andet oprigtigt varm, hjertelig og venskabelig hilsen den regerende for-mand (formand af Foret (#smallcaps[F-Klubbens] kor)), \
_Sebastian Haahr Lorenzen_

#pagebreak()


#indholdfortegnelse(cols: 2, block_height: 12cm)

#v(1cm)
#align(center)[
    #image("assets/foret.png", width: 100%)
]
#pagebreak()

#kapitelside(titel: "F-Klub Sange")

#pagebreak()

#include "fklub-sange.typ"

#kapitelside(titel: "Sange fra verden", asset: "assets/verden.png", spacing: 1cm)

#include "sange/unsorted/costadelsol.typ"

#include "sange/unsorted/hjemmebrænderiet.typ"

#pagebreak()

// Vendelbomanden
#place(
  bottom + right,
  dx: 0cm,
  dy: .25cm,
  image("assets/vendelbo.png", width: 5.5cm),
)

#include "sange/unsorted/vendelboensfestsang.typ"

#pagebreak()

#include "sange/unsorted/frujensenfratolne.typ"

#pagebreak()

#include "sange/unsorted/dervarenskikkeligbondemand.typ"

#align(center)[#image("assets/eps2png/bondemand.png", width: 12cm)]

#pagebreak()

#place(
  horizon + right,
  dx: .5cm,
  dy: -1.5cm,
  image("assets/nobeer.png", width: 10cm),
)

#include "sange/specielle/langtfrahjemmeudenøl.typ"

#v(4.5cm)

#include "sange/specielle/dereretølrigtland.typ"

#pagebreak()

#include "sange/tågekammeret/tågekamemret-feaster-2025.typ"

#pagebreak()

#include "sange/tågekammeret/tågekamemret-bestpåtur.typ"

#kapitelside(titel: "Julesange", asset: "assets/julemand.png", spacing: 1cm)

#place(
  bottom + center,
  dx: 0cm,
  dy: 1cm,
  image("assets/julemad.png", width: 5.5cm),
)

#include "sange/etbarnerfødtibethlehem.typ"

#include "sange/julemadogdrikke.typ"