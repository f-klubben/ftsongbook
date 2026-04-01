#import "template.typ": *

#show: songbook.with(
    title: "F-Klubbens Fabelagtige Sangbog"
)

//#set block(stroke: 2pt + red)

#forside

#fritfor

#indholdfortegnelse(cols: 2)

#v(1cm)
#align(center)[
    #image("assets/foret.png", width: 100%)
]
#pagebreak()

#kapitelside(titel: "F-Klub Sange")

#pagebreak()

#include "fklub-sange.typ"


// Veteranens nostalgiske sang, tideligere FVJ udgave
//#include "sange/veteranensnostalgiskesang-facology.typ"

// G Sektionen
#nynummerpræfiks("G")

#kapitelside(titel: "Lejerbålsange", asset: "assets/eps2png/lejrbaal.png")
#pagebreak()

#include "sange/unsorted/costadelsol.typ"
#include "sange/unsorted/ienlillebåddergynder.typ"
#pagebreak()
#include "sange/unsorted/kringsattaffiender.typ"
#pagebreak()
#include "sange/engelske/whiskeyinthejar.typ"
#pagebreak()
#include "sange/unsorted/svantenslykkeligedag.typ"
#include "sange/unsorted/denrødetråd.typ"
#pagebreak()
#include "sange/unsorted/derernogetgaltidanmark.typ"
#include "sange/unsorted/hjemmebrænderiet.typ"
#pagebreak()
#include "sange/unsorted/hvalenhvalborg.typ"
#align(center)[
    #image("assets/eps2png/calvinandhobbes.png", width: 80%)
]
#include "sange/unsorted/joanna.typ"
#pagebreak()
#include "sange/unsorted/viharlejrbålher.typ"
#include "sange/unsorted/sevenedigogdø.typ"

// H sektion
#nynummerpræfiks("H")


#kapitelside(titel: "Festsange", asset: "assets/eps2png/dream.png")
#pagebreak()

#include "sange/unsorted/allesømændergladeforpiger.typ"
#v(-1em)
#include "sange/engelske/brightsideoflife.typ"
#pagebreak()
#include "sange/unsorted/dervarenskikkeligbondemand.typ"
#align(center)[
    #image("assets/eps2png/bondemand.png",width: 80%)
]
#pagebreak()
#include "sange/unsorted/himmelhunden.typ"
#include "sange/unsorted/mcarine.typ"
#include "sange/unsorted/bubbibjørn.typ"
#include "sange/unsorted/puffdenmagiskedrage.typ"
#pagebreak()
#include "sange/unsorted/buster.typ"
#include "sange/specielle/dereretølrigtland.typ" // F-klub?

// J sektion
#nynummerpræfiks("J")

#kapitelside(titel: "Julesange", asset: "assets/eps2png/jule.png")
#pagebreak()

#include "sange/unsorted/sørenbanjomus.typ"
#pagebreak()
#include "sange/specielle/etbarnerfødtibethlehem.typ"
#include "sange/specielle/jegsåjulemandenkyssemor.typ"
#include "sange/specielle/julemadogdrikke.typ" // F-klub?
#pagebreak()
#include "sange/engelske/jinglebellrock.typ"
#include "sange/engelske/letitsnow.typ"
#include "sange/unsorted/påloftetsiddernissenmedsinjulegrød.typ"
#pagebreak()
#include "sange/engelske/santaclausiscomingtotown.typ"
#include "sange/unsorted/julebalinisseland.typ"

// K sektion
#nynummerpræfiks("K")

#kapitelside(titel: "Grå Sange", asset: "assets/eps2png/sex.png")
#pagebreak()

#include "sange/unsorted/enmandfaldtnedfraførstesal.typ"
#pagebreak()
#include "sange/unsorted/lilleprinsesse.typ"
