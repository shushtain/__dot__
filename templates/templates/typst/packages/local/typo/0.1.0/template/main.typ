#import "@local/typo:0.1.0"

#let guides = false

// #show: typo.reset.reset
// #show: typo.utils.guides
#show: typo.doc.setup.with(guides: guides)

#title([Hello world])

#lorem(30)

= Hello World

#lorem(10)

== Hello World

#lorem(1000)

// #show: typo.default.setup
// #show: typo.default.guides
//
// #set document(
//   title: "My Document",
//   author: "John Doe",
//   date: datetime(year: 2023, month: 3, day: 5),
// )
//
// #show: typo.default.header.with(
//   context document.title,
//   context counter(page).display(),
// )
//
// #show: typo.default.footer.with(
//   context document.date.display(),
//   context document.author.first(),
// )
//
= #lorem(10)

#lorem(30)

== #lorem(10)

#lorem(30)

=== #lorem(15)

#lorem(30)

==== #lorem(20)

#lorem(40)

===== #lorem(20)

- Some
- Other

+ Something
+ Otherwise

#table(
  columns: 2,
  [Something], [Other],
  [Something], [Other],
  [Something], [Other],
)

#lorem(120)

#lorem(80) #footnote("Hello")

$ x + 1 / (13 + sigma_2^') $

#lorem(80) #footnote("Hello")
