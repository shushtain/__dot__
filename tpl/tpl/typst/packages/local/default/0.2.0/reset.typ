#let mod(
  font-size: 12pt,
  margin: (left: 42pt),
  body,
) = context {
  let base = font-size / 2

  set page(
    margin: margin,
    header: context {
      if counter(page).at(here()).first() == 1 { none } else { header }
    },
    header-ascent: font-size,
    footer: footer,
    footer-descent: font-size,
  )

  set page(background: context {
    place(
      top,
      block(width: 100%, height: 100%, fill: tiling(
        size: (page.width, font-size / 2),
        line(length: 100%, stroke: 0.5pt + luma(160)),
      )),
    )
    place(left, dx: margin.left, line(
      angle: 90deg,
      length: 100%,
      stroke: 0.5pt + blue,
    ))
    place(right, dx: -margin.right, line(
      angle: 90deg,
      length: 100%,
      stroke: 0.5pt + blue,
    ))
    place(top, dy: margin.top, line(
      length: 100%,
      stroke: 0.5pt + blue,
    ))
    place(bottom, dy: -margin.bottom, line(
      length: 100%,
      stroke: 0.5pt + blue,
    ))
  }) if guides


  set text(
    font: "Inter",
    size: font-size,
    top-edge: 12pt,
    lang: lang,
  )

  set par(leading: 0.5em, spacing: 1em)
  set block(spacing: 1em)

  show link: underline

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

  // show raw.where(block: false): it => {
  //   let content = text(
  //     it,
  //     size: font-size,
  //     top-edge: font-size,
  //   )
  //   (
  //     sym.space.narrow
  //       + underline(content, stroke: (dash: "dotted", paint: black))
  //       + sym.space.narrow
  //   )
  // }

  show heading: it => layout(size => {
    let levels = (
      (font-size * 2, base),
      (font-size * 5 / 3, base),
      (font-size * 4 / 3, base),
    )
    let (h_size, h_height) = levels.at(
      it.level - 1,
      default: (font-size, base),
    )
    let content = par(
      leading: h_height,
      text(size: h_size, top-edge: h_size, it.body),
    )
    let height = measure(block(content), width: size.width).height
    let rest = calc.rem(height / 1pt, base / 1pt) * 1pt
    let offset = base - rest
    if rest < 0.1pt { offset = 0pt }
    block(inset: (top: offset), content)
  })

  show heading: it => {
    let levels = (font-size * 1.5, font-size * 1.5)
    let h_space = levels.at(it.level - 1, default: font-size)
    block(spacing: h_space, it)
  }

  show raw.where(block: true): it => layout(size => {
    let content = text(
      size: font-size / 1.2,
      top-edge: font-size / 2,
      it,
    )
    let height = measure(block(content), width: size.width).height
    let rest = calc.rem(height / 1pt, font-size / 2pt) * 1pt
    let offset = font-size / 2 - rest
    if rest < 0.1pt { offset = 0pt }
    block(content, inset: (top: offset))
  })

  show raw.where(block: true): set block(spacing: base * 3)

  show quote.where(block: true): it => {
    let elems = (it.body,)
    if it.attribution != none {
      elems.push(text(size: font-size / 1.2, [--- #it.attribution]))
    }
    block(
      spacing: font-size * 1.5,
      stack(spacing: 0.5em, ..elems),
      inset: (left: 1em),
      stroke: (left: 1pt),
    )
  }

  set footnote.entry(
    separator: line(length: 100%),
    clearance: base * 2,
    indent: 0pt,
    gap: base,
  )

  show footnote.entry: it => {
    set text(size: 10pt, top-edge: base)
    it
  }

  set list(
    body-indent: 0.5em,
    marker: ([•],),
  )

  set enum(
    body-indent: 0.5em,
    numbering: n => {
      set text(number-width: "tabular")
      [#n.]
    },
  )

  set terms(
    separator: h(base * 2, weak: true),
    hanging-indent: base * 2,
  )

  show terms: it => {
    let elements = ()
    for child in it.children {
      elements.push(stack(
        spacing: 0.5em,
        strong(child.term),
        pad(left: 1em, child.description),
      ))
    }
    stack(spacing: 0.5em, ..elements)
  }

  set table(
    stroke: (x, y) => if y == 0 { (bottom: 1pt) },
    inset: (x, y) => {
      let out = (left: font-size, right: 0pt, top: 0pt, bottom: 0pt)
      if x == 0 { out.left = 0pt }
      if y == 0 { out.bottom = base }
      if y != 0 { out.top = base }
      out
    },
  )

  show table: it => block(it, spacing: font-size * 1.5)
  show table.cell.where(y: 0): strong

  show title: it => {
    block(spacing: base * 3, par(leading: base, text(
      size: font-size * 2.5,
      top-edge: font-size * 2.5,
      it.body,
    )))
  }

  set highlight(fill: rgb("#FFFF0099"))
  set underline(background: true)

  set document(date: none)

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
    let rest = calc.rem(height / 1pt, font-size / 2pt) * 1pt
    let offset = font-size / 2 - rest
    if rest < 0.1pt { offset = 0pt }
    block(it, inset: (top: offset))
  })

  // ---

  body
}
