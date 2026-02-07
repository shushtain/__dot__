#import "/utils.typ"
#import "/reset.typ"

#let header(
  base: 6pt,
  margin: (
    left: 42pt,
    right: 42pt,
    top: 36pt,
    bottom: 36pt,
  ),
  ..children,
  body,
) = context {
  let margin = margin.top
  if content != none {
    set page(
      header: {
        set text(size: base / 0.6, top-edge: base)
        let content = stack(dir: ltr, spacing: 1fr, ..children)
        stack(spacing: base, content, line(length: 100%))
      },
      margin: (top: margin + base * 2),
    )
    body
  } else {
    set page(
      header: none,
      margin: (top: margin),
    )
    body
  }
}

#let footer(
  base: 6pt,
  margin: (
    left: 42pt,
    right: 42pt,
    top: 36pt,
    bottom: 36pt,
  ),
  ..children,
  body,
) = context {
  let margin = margin.bottom
  if content != none {
    set page(
      footer: {
        set text(size: base / 0.6, top-edge: base)
        let content = stack(dir: ltr, spacing: 1fr, ..children)
        stack(spacing: base, line(length: 100%), content)
      },
      margin: (bottom: margin + base * 2),
    )
    body
  } else {
    set page(
      footer: none,
      margin: (bottom: margin),
    )
    body
  }
}

#let setup(
  guides: false,
  body,
) = context {
  let base = 6pt
  let font-size = base * 2
  let margin = (
    left: 42pt,
    right: 42pt,
    top: 36pt,
    bottom: 36pt,
  )

  show: reset.reset.with(
    base: base,
    margin: margin,
    guides: guides,
  )

  show: utils.set-heading
  show: utils.set-title

  body
}
