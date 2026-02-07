#let count-offset(
  base: 6pt,
  height,
) = {
  let rest = calc.rem(height / 1pt, base / 1pt) * 1pt
  let offset = base - rest
  if rest < 0.1pt { offset = 0pt }
  offset
}

#let set-page-margin(
  margin: (
    left: 42pt,
    right: 42pt,
    top: 36pt,
    bottom: 36pt,
  ),
  body,
) = {
  let margin = margin
  let height = page.height - margin.bottom
  let offset = count-offset(height)
  margin.bottom += offset

  set page(margin: margin)
  body
}

#let set-heading(
  base: 6pt,
  factors: (2, 5 / 3, 4 / 3, 1),
  tighten: 3,
  body,
) = {
  show heading: it => layout(size => {
    let factor = factors.at(it.level - 1, default: factors.last())
    let fs = base * 2 * factor
    let content = par(leading: base, text(size: fs, top-edge: fs, it.body))
    let height = measure(block(content), width: size.width).height
    let offset = count-offset(height)
    block(inset: (top: offset), content)
  })

  show heading: it => {
    block(
      spacing: base * if it.level < tighten { 3 } else { 2 },
      sticky: true,
      it,
    )
  }

  body
}

#let set-title(
  base: 6pt,
  factor: 2.5,
  body,
) = {
  let fs = base * 2 * factor
  show title: it => {
    block(
      spacing: base * 3,
      sticky: true,
      par(leading: base, text(size: fs, top-edge: fs, it.body)),
    )
  }

  body
}

#let guides(
  enable: true,
  base: 6pt,
  margin: (
    left: 42pt,
    right: 42pt,
    top: 36pt,
    bottom: 36pt,
  ),
  body,
) = {
  set page(background: {
    place(top, block(width: 100%, height: 100%, fill: tiling(
      size: (page.width, base),
      line(length: 100%, stroke: 0.5pt + luma(160)),
    )))

    set line(length: 100%, stroke: 0.5pt + blue)
    place(top, dy: margin.top, line())
    place(bottom, dy: -margin.bottom, line())

    set line(angle: 90deg)
    place(left, dx: margin.left, line())
    place(right, dx: -margin.right, line())
  }) if enable
  body
}

