#import "utils.typ": split-jyutping
#import "data.typ": *

/// Combine 2 parts: combine mode
/// - "-" for stacking part 1 on top of part 2;
/// - "|" for combining them side-by-side
#let combine-parts(part1, part2, combine-mode, tone: none) = {
  let combined
  let tone-mapped = if tone != none { tone-map.at(tone) } else { none }

  if combine-mode == "-" {
    combined = rotate(
      90deg,
      scale(
        [#box(rotate(-90deg, part1))#box(rotate(-90deg, part2))],
        origin: bottom+left,
        x: 50%,
        reflow: true
      )
    )
  } else {
    combined = scale([#part1#part2], origin: bottom+left, x: 50%, reflow: true)
  }
  box(stack(combined, tone-mapped, dir: ltr))
}

// Return the Jyutcitzi for syllabic nasal sounds
#let syllabic-nasal-char(jp-initial, tone: none) = {
  let box-dy = if jp-initial == "m" { -0.2em } else if jp-initial == "ng" { -0.6em }
  let dot-pos = if jp-initial == "m" { bottom + right } else if jp-initial == "ng" { top + right }
  box(
    stack(
      text(top-edge: "ascender", bottom-edge: "descender")[
        #scale(stack("一", "乂", "一", spacing: -0.5em), y: 60%, reflow: true)
        #place(dot-pos, dy: box-dy, [ˎ])
      ],
      if tone != none { tone-map.at(tone) } else { none },
      dir: ltr
    ),
    height: 1em
  )
}

/// Transform jyutping (without digit) to jyutcitzi
#let simple-jyutcitzi-display(jp-initial, jp-final, tone: none) = {
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
    combine-parts(part1, part2, combine-mode, tone: tone)
  }
}
