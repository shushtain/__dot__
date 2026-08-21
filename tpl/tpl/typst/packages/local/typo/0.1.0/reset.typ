#import "/utils.typ"

#let reset(
  base: 6pt,
  margin: (
    left: 42pt,
    right: 42pt,
    top: 36pt,
    bottom: 36pt,
  ),
  guides: false,
  body,
) = context {
  let font-size = base * 2

  set page(
    paper: "a4",
    header-ascent: font-size,
    footer-descent: font-size,
  )
  show: utils.set-page-margin.with(margin: margin)
  show: utils.guides.with(enable: guides, base: base, margin: margin)

  set document(
    author: "Artem Shush",
    date: none,
  )

  set text(
    font: "Inter",
    size: font-size,
    features: (ss02: 1),
    top-edge: font-size,
    lang: "en",
  )

  set par(leading: base, spacing: font-size)
  set block(spacing: font-size)

  set highlight(fill: rgb("#FFFF0099"))
  set underline(background: true)
  show link: underline

  // show heading: it => par(
  //   leading: base,
  //   text(size: font-size, top-edge: font-size, it.body),
  // )
  show: utils.set-heading

  set raw(tab-size: 4)
  show raw: set text(font: "JetBrains Mono NL")

  show raw.where(block: false): it => {
    h(base, weak: true)
    underline(
      text(it, size: font-size, top-edge: font-size),
      stroke: (dash: "dotted", paint: black),
    )
    h(base, weak: true)
  }

  show raw.where(block: true): it => layout(size => {
    let content = text(size: font-size / 1.2, top-edge: base, it)
    let height = measure(block(content), width: size.width).height
    let offset = utils.count-offset(height)
    block(content, inset: (top: offset))
  })

  show raw.where(block: true): set block(spacing: base * 3)

  show quote.where(block: true): it => {
    let elems = (it.body,)
    if it.attribution != none {
      elems.push(text(size: font-size / 1.2, [— #it.attribution]))
    }
    block(
      spacing: base * 3,
      stack(spacing: base, ..elems),
      inset: (left: base * 2),
      stroke: (left: 1pt),
    )
  }

  set footnote.entry(
    separator: line(length: 100%),
    clearance: base * 2,
    indent: 0pt,
    gap: base,
  )

  show footnote.entry: set text(
    size: font-size / 1.2,
    top-edge: base,
  )

  set list(
    body-indent: base / 2,
    marker: text(font: "JetBrains Mono NL", "•"),
  )

  set enum(
    body-indent: base / 2,
    numbering: n => text(number-width: "tabular", [#n]) + ".",
  )

  set terms(
    separator: h(base * 2, weak: true),
    hanging-indent: base * 2,
  )

  show terms: it => {
    let elements = ()
    for child in it.children {
      elements.push(stack(
        spacing: base,
        strong(child.term),
        pad(left: 1em, child.description),
      ))
    }
    stack(spacing: base, ..elements)
  }

  set table(
    stroke: (x, y) => if y == 0 { (bottom: 1pt) },
    inset: (x, y) => {
      let out = (left: base * 2, right: 0pt, top: 0pt, bottom: 0pt)
      if x == 0 { out.left = 0pt }
      if y == 0 { out.bottom = base }
      if y != 0 { out.top = base }
      out
    },
  )

  show table: it => block(it, spacing: base * 3)
  show table.cell.where(y: 0): strong

  set figure(
    scope: "column",
    gap: base,
  )

  set columns(gutter: base * 2)
  set colbreak(weak: true)
  set pagebreak(weak: true)
  set place(clearance: 0pt)

  // ---

  show math.equation: set text(font: "Noto Sans Math")

  show math.equation.where(block: false): it => {
    h(base, weak: true)
    text(underline(it), size: font-size, top-edge: font-size)
    h(base, weak: true)
  }

  show math.equation.where(block: true): it => layout(size => {
    let height = measure(block(it), width: size.width).height
    let offset = utils.count-offset(height)
    block(it, inset: (top: offset))
  })

  // ---

  body
}
