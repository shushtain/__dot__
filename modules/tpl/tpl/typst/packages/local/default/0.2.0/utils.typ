#let ch(
  font-family: "Inter",
  font-size: 12pt,
) = {
  measure(text(
    font: font-family,
    size: font-size,
    [0],
  )).width
}

#let flush-margin(
  margin,
  page-height,
  baseline,
) = {
  let frame = page-height - margin
  let flush = calc.rem(frame / 1pt, baseline / 1pt) * 1pt
  margin + flush
}

// NOTE: how to modify content with body
// #let nontight(lst) = {
//   let fields = lst.fields()
//   fields.remove("children")
//   fields.tight = false
//   return (lst.func())(..fields, ..lst.children)
// }

// #let add-dicts(dict-a, dict-b) = {
//   let res = dict-a
//   for key in dict-b.keys() {
//     if (
//       key in res
//         and type(res.at(key)) == dictionary
//         and type(dict-b.at(key)) == dictionary
//     ) {
//       res.insert(key, add-dicts(res.at(key), dict-b.at(key)))
//     } else {
//       res.insert(key, dict-b.at(key))
//     }
//   }
//   return res
// }
