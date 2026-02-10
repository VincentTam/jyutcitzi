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
#let syllabic-nasal-char(c) = {
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
  let (jp-initial, jp-final) = split-jyutping(jyutping)
  if jp-initial != none or jp-final != none {
    let part1
    let part2
    let combine-mode
    if jp-initial == none {
      part1 = initials-dict.a.at(0)
      part2 = finals-dict.at(jp-final)
      combine-mode = "-"
    } else if jp-final == none {
      part1 = initials-dict.a.at(0)
      part2 = initials-dict.at(jp-initial).at(0)
      combine-mode = "-"
    } else {
      part1 = initials-dict.at(jp-initial).at(0)
      part2 = finals-dict.at(jp-final).at(0)
      combine-mode = initials-dict.at(jp-initial).at(1)
    }
    combine-parts(part1, part2, combine-mode)
  }
}
