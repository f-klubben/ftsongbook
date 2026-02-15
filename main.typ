#import "template.typ": *

#show: songbook.with(
    title: "F-Klubbens Fabelagtige Sangbog"
)

//#set block(stroke: 2pt + red)

#forside

#forord

#indholdfortegnelse(cols: 2)

#meme_page_spacer

#kapitelside(titel: "F-Klub Sange")

#pagebreak()
// En målrettet vise
#include "sange/målrettetvise.typ"
#pagebreak()

// En meget nostalgisk vise
#include "sange/enmegetnostalgiskvise.typ"
#pagebreak()

// Tegning af Rudin
#v(2cm)
#align(center)[
    #image("assets/rudin.png")
]
#pagebreak()

// En introduktionsvise
#include "sange/introduktionsvise.typ"

// Masser af cc
#include "sange/masserafcc.typ"
#pagebreak()

// En kort en lang (billedsangen)
#include "sange/enkortenlang.typ"
#pagebreak()

// Livet (im a lumberjack and I'm okay)
#include "sange/livet.typ"

// Hvem sidder foran skærmen
#include "sange/hvemsidderforanskærmen.typ"
#pagebreak()

// C compiler
#include "sange/dumåfåminccompilernårjegdør.typ"

// Danskens sande glæade (tal/mad sangen)
#include "sange/danskernessaneglæde.typ"
#pagebreak()

// Fredagsfranskbrød
#include "sange/brødsangen.typ"

// Lilel grønen frø
#include "sange/denlillegrønnefrø.typ"

// Vi er ikek humanister
#include "sange/vierikkehumanister.typ"
#pagebreak()

// Regn-sangen (42)
#include "sange/regnsangen.typ"

// Kampsangen
#include "sange/dat62.typ"
#pagebreak()

// Mat'matik (Bubbi Bjørn)
#include "sange/matematik.typ"

// Fytteturssangen
#include "sange/fytteturssangen.typ"
#pagebreak()

// Jeg en nørd (Pokémon)
#include "sange/jegerennørd.typ"
#pagebreak()

// På Cassiopeia til Foobar
#include "sange/påcassiopeiatilfoobar.typ"

// Fit er Frit (bella chao)
#include "sange/fiterfrit.typ"
#pagebreak()

// Alle DAT'er er emget glade for Mini
#include "sange/miniblirbortført.typ"

// Veteranens nostalgiske vise (nyere version af FVJ variaent)
#include "sange/veteranensnostalgiskesang.typ"
#pagebreak()

// Hvorfor skal vi hejse et flag
#include "sange/flagsang.typ"

// CLRS 
#include "sange/clrs.typ"

// Drunken BoAnd
#include "sange/drunkenboand.typ"
#pagebreak()

// F-Luciasangen på normal
#include "sange/luciasangenikkeonsdag.typ"

// F-Luciasangen på onsdag
#include "sange/luciasangenfredagsfranskbrød.typ"

// Alle Dat'er er galde for poster
#include "sange/alledatererfladeforporter.typ"
#pagebreak()

// Havd skal vi kode i nat
#include "sange/hvadskalvikodeinat.typ"
#pagebreak()

// Eksaminandernes kort
#include "sange/eksaminanderneskort.typ"

// Meyers vise
#include "sange/meyersvise.typ"
#pagebreak()

// BoAnd Krabebsangen
#include "sange/krabbeboand.typ"
#pagebreak()

// En pædagogisk vise (same as en meget nostalgisk vise)
//#include "sange/enpædagogiskvise.typ"
//#pagebreak()

// Et sidte farvel
#include "sange/etsidstefarvel.typ"
#pagebreak()

// Resultater af klubbens afgangsprøve
#include "sange/resultateraffklubbensafgangsprøve.typ"
#pagebreak()

// Bingospillren
#include "sange/bingospilleren.typ"

// Fottesangen
#include "sange/fottesangen.typ"
#pagebreak()

// Der kan man C
#include "sange/derkanmanc.typ"
//#pagebreak()

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

// Kranie med kranier
#align(center)[
    #image("assets/eps2png/party.png", width: 70%)
]
#include "sange/unsorted/allesømændergladeforpiger.typ"
#align(center)[
    #image("assets/eps2png/calvinanswer.png",width: 80%)
]
#pagebreak()
#include "sange/engelske/brightsideoflife.typ"
#pagebreak()
#include "sange/unsorted/dervarenskikkeligbondemand.typ"
#align(center)[
    #image("assets/eps2png/bondemand.png",width: 80%)
]
#pagebreak()
#include "sange/unsorted/himmelhunden.typ"
#include "sange/unsorted/drunkensailor.typ"
#pagebreak()
#include "sange/unsorted/mcarine.typ"
#align(center)[
    #image("assets/eps2png/compiling.png",width: 80%)
]
#pagebreak()
#include "sange/engelske/imagine.typ"
#include "sange/unsorted/bubbibjørn.typ"
#pagebreak()
#include "sange/unsorted/puffdenmagiskedrage.typ"
#include "sange/unsorted/buster.typ"
#pagebreak()
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


/* 
mangler, som er til rådighed:

alleminevenner.typ
elskabssang.typ
forureningsvisen.typ
frujensenfratolne.typ
glædeligjul.typ
jegsåjulemandenkyssemor.typ
lanftfrahjemmeudenøl.typ
sandhans.typ
skipperklementsmorgensang.typ
tinepingvin.typ
vendelboensfestsang.typ
 */