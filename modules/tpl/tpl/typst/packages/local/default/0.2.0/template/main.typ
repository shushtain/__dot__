#import "@local/default:0.2.0"


#show: default.init

// #context {
//   [#default.ch() ] + [#default.CH.update(default.ch())]
// }

//
// // #ch()
// #set text(font: "Inter", size: 12pt)
// 0
// #context measure([0]).width
//
// #set text(font: "JetBrains Mono NL", size: 12pt)
// 0
// #context measure([0]).width
//
// #context {
//   default.ch(font-family: "JetBrains Mono NL", font-size: 10pt) * 2
// }
//
// #set text(font: "Inter", size: 12pt, top-edge: 12pt)
// #context 1em.to-absolute()
// #context measure([0]).height
// #show: setup.with(
//   // header: context [#document.title #h(1fr) #counter(page).display()],
//   // footer: context [\@author #h(1fr) \<year>],
//   guides: true,
// )
//
