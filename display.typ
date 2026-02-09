#import "utils.typ": split-jyutping
#import "data.typ": *

/// Combine 2 parts: combine mode
/// - "-" for stacking part 1 on top of part 2;
/// - "|" for combining them side-by-side
/// parts-gap is the amount of em for separation.  It defaults to 0.1em
/// only applies when two parts are stacked one on top of another
#let combine-parts(part1, part2, combine-mode, parts-gap: 0.1) = {
  let combined
  if combine-mode == "-" {
    set text(top-edge: "ascender", bottom-edge: "descender")
    let scaling-factor = 1/(2 + parts-gap * 2) * 100%
    combined = scale(
      stack(part1, part2, spacing: 2 * parts-gap * 1em),
      origin: bottom+left, y: scaling-factor, reflow: true
    )
  } else {
    combined = scale([#part1#part2], origin: bottom+left, x: 50%, reflow: true)
  }
  box(combined)
}

// Return the Jyutcitzi for syllabic nasal sounds
#let sn-char(c) = {
  let box-dy = if c == "m" { -0.2em } else if c == "ng" { -0.6em }
  let dot-pos = if c == "m" { bottom + right } else if c == "ng" { top + right }
  box(
    text(top-edge: "ascender", bottom-edge: "descender")[
      #scale(stack("一", "乂", "一", spacing: -0.5em), y: 60%, reflow: true)
      #place(dot-pos, dy: box-dy, [ˎ])
    ],
    height: 1em
  )
}

/// Transform jyutping (without digit) to jyutcitzi
#let simple-jyutcitzi-display = jyutping => {
  let (beginning, ending) = split-jyutping(jyutping)
  if beginning != "" or ending != "" {
    let part1
    let part2
    let combine-mode
    let result
    if ending == "" and (beginning == "m" or beginning == "ng") {
      result = sn-char(beginning)
    } else {
      if beginning == "" {
        part1 = beginnings-dict.a.at(0)
        part2 = endings-dict.at(ending)
        combine-mode = "-"
      } else if ending == "" {
        part1 = beginnings-dict.a.at(0)
        part2 = beginnings-dict.at(beginning).at(0)
        combine-mode = "-"
      } else {
        part1 = beginnings-dict.at(beginning).at(0)
        part2 = endings-dict.at(ending).at(0)
        combine-mode = beginnings-dict.at(beginning).at(1)
      }
      result = combine-parts(part1, part2, combine-mode)
    }
    result
  }
}
