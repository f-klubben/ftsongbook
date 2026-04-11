#import "template.typ": *

// Gammel forside (ikke en forside her)
#place(
    center + bottom,
    dx: 0cm,
    dy: 0cm,
    image("assets/fklub-sange-forside.png", width: 70%),
)
// Futlandia
#include "sange/futlandia.typ"
#pagebreak()

// En målrettet vise
#include "sange/målrettetvise.typ"
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



#place(
  center,
  dx: 0cm,
  dy: 3.25cm,
  image("assets/franskbrod.png", width: 8cm),
)

// Fredagsfranskbrød
#include "sange/brødsangen.typ"

#v(3cm)

// Vi er ikek humanister
#include "sange/vierikkehumanister.typ"
#pagebreak()


// C compiler
#include "sange/dumåfåminccompilernårjegdør.typ"

#place(
  right,
  dx: 0cm,
  dy: -4cm,
  image("assets/amiga.png", width: 5cm),
)

// Danskens sande glæade (tal/mad sangen)
#include "sange/danskernessaneglæde.typ"
#pagebreak()


// En meget nostalgisk vise
#include "sange/enmegetnostalgiskvise.typ"
#pagebreak()



// Regn-sangen (42)
#include "sange/regnsangen.typ"

// Lilel grønen frø
#include "sange/denlillegrønnefrø.typ"

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

#v(-1em)
// Veteranens nostalgiske vise (nyere version af FVJ variaent)
#include "sange/veteranensnostalgiskesang.typ"
#pagebreak()


// Halvejs kylling
#place(
  right
  +bottom,
  dx: 0cm,
  dy: 0cm,
  image("assets/halvejs.png", width: 5cm),
)


// Hvorfor skal vi hejse et flag
#include "sange/flagsang.typ"
#pagebreak()

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
#include "sange/eksaminanderneskor.typ"

// Meyers vise
#include "sange/meyersvise.typ"
#pagebreak()

// BoAnd Krabebsangen
#include "sange/krabbeboand.typ"
#pagebreak()

// En pædagogisk vise (same as en meget nostalgisk vise)
//#include "sange/enpædagogiskvise.typ"
//#pagebreak()

#place(
  center+bottom,
  dx: 0cm,
  dy: 1cm,
  image("assets/eksamen.png", width: 100%),
)

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

#place(
  bottom + right,
  dx: 0cm,
  dy: 0cm,
  image("assets/fotte.png", width: 5cm),
)

#pagebreak()

// Der kan man C
#include "sange/derkanmanc.typ"

// F-nüt 1985 f-klub-sangkonkurence - vindersangen
#include "sange/fnut1985vindersangen.typ"
#pagebreak()


// F-nüt 1985 f-klub-sangkonkurence - hold 1
#include "sange/fnut1985rossethold1.typ"
// F-nüt 1985 f-klub-sangkonkurence - hold 2
#include "sange/fnut1985rossethold2.typ"
// F-nüt 1985 f-klub-sangkonkurence - hold 3
#include "sange/fnut1985rossethold3.typ"