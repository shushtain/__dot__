#import "/utils.typ"
#import "/reset.typ"

#let job(
  position: "<title>",
  place: "freelance",
  time: ("", ""),
  body,
) = {
  let sep = ", "
  let (stime, etime) = time
  if etime == "" {
    etime = "Present"
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

