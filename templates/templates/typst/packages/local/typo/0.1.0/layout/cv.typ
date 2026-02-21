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

#let job(
  position: "<title>",
  place: "freelance",
  time: (datetime.today(),),
  body,
) = {
  let sep = " ∙ "

  let stime = time.at(0)
  let etime = if time.len() == 1 { datetime.today() } else { time.at(1) }
  stime = stime.display("[month repr:short] [year]")
  etime = if time.len() == 1 { "Present" } else {
    etime.display("[month repr:short] [year]")
  }

  stack(
    dir: ltr,
    [=== #position],
    sep,
    [#place],
    sep,
    [#stime – #etime],
  )
  v(-0.5em)
  body
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

  show: utils.set-heading.with(
    base: base,
    factors: (2, 1.5, 1),
    tighten: 1,
  )

  body
}

