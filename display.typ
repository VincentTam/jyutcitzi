#import "utils.typ": *
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
  box(baseline: 0.12em, stack(combined, tone-mapped, dir: ltr))
}

/// Transform Jyut6ping3 to Jyutcitzi
#let simple-jyutcitzi-display(jp-initial, jp-final, tone: none, merge-nasals: false) = {
  if jp-initial == none and jp-final == none { return }
  set text(bottom-edge: "descender", top-edge: "ascender")
  let part1
  let part2
  let combine-mode
  // handle syllabic nasal merge preference
  let finals-dict-key = if merge-nasals == true and (jp-final == "m" or jp-final == "ng") { "mng" } else { jp-final }
  // standalone syllabic nasal sounds
  if jp-initial == none and (finals-dict-key == "m" or finals-dict-key == "ng" or finals-dict-key == "mng") {
    let tone-mapped = if tone != none { tone-map.at(tone) } else { none }
    return box(baseline: 0.12em, stack(finals-dict.at(finals-dict-key).at(0), tone-mapped, dir: ltr))
  }
  if jp-initial == none {
    // no initial
    part1 = initials-dict.a.at(0)
    part2 = finals-dict.at(finals-dict-key).at(0)
    combine-mode = "-"
  } else if finals-dict-key == none {
    // no final
    part1 = initials-dict.a.at(0)
    part2 = initials-dict.at(jp-initial).at(0)
    combine-mode = "-"
  } else {
    // have both initial and final
    part1 = initials-dict.at(jp-initial).at(0)
    part2 = finals-dict.at(finals-dict-key).at(0)
    combine-mode = initials-dict.at(jp-initial).at(-1)
  }
  combine-parts(part1, part2, combine-mode, tone: tone)
}

/// Combine 3 parts using either '┫' or '┻' method
#let combine-3parts(part1, part2, part3, combine-mode, tone: none) = {
  set text(bottom-edge: "descender", top-edge: "ascender")
  let combined
  let tone-mapped = if tone != none { tone-map.at(tone) } else { none }
  let part12
  let combined
  // ┫ = Top, Bottom, Right
  if combine-mode == "tbr" {
    part12 = box(
      rotate(
        90deg,
        scale(
          [#box(rotate(-90deg, part1))#box(rotate(-90deg, part2))],
          origin: bottom+left,
          x: 50%,
          reflow: true
        )
      ),
      baseline: 0.12em
    )
    combined = scale(box[#part12#part3], x: 50%, reflow: true, origin: bottom + left)
  } else { // ┻ = Left, Right, Bottom
    part12 = scale([#part1#part2], origin: bottom+left, x: 50%, reflow: true)
    combined = rotate(
      90deg,
      scale(
        [#box(rotate(-90deg, part12))#box(rotate(-90deg, part3))],
        origin: bottom+left,
        x: 50%,
        reflow: true
      )
    )
  }
  box(baseline: 0.12em, stack(combined, tone-mapped, dir: ltr))
}

/// Transform simple Jyutcit alphabet sequence to Jyutcitzi
#let display-from-simple-jc-tuple(jc-initial, jc-final, tone: none, merge-nasals: false) = {
if jc-initial == none and jc-final == none { return }
  set text(bottom-edge: "descender", top-edge: "ascender")
  let part1
  let part2
  let combine-mode
  // Reverse lookup is necessary to allow alternative alphabets (e.g. 曷， 匃)
  let initials-dict-key = reverse-init-dict-lookup(jc-initial)
  let finals-dict-key
  // handle syllabic nasal merge preference
  if merge-nasals == true {
    if jc-final == "太" or jc-final == "犬" or jc-final == "乂" or jc-final == "㐅" {
      finals-dict-key = "mng"
    }
  } else {
    if jc-final == jc-final == "乂" or jc-final == "㐅" {
      finals-dict-key = "m"
    } else if jc-final != none {
      finals-dict-key = reverse-final-dict-lookup(jc-final)
    }
  }
  // standalone syllabic nasal sounds
  if jc-initial == none and (finals-dict-key == "m" or finals-dict-key == "ng" or finals-dict-key == "mng") {
    let tone-mapped = if tone != none { tone-map.at(tone) } else { none }
    return box(baseline: 0.12em, stack(finals-dict.at(finals-dict-key).at(0), tone-mapped, dir: ltr))
  }
  if initials-dict-key == none {
    // no initial
    part1 = initials-dict.a.at(0)
    part2 = finals-dict.at(finals-dict-key).at(0)
    combine-mode = "-"
  } else if finals-dict-key == none {
    // no final
    part1 = initials-dict.a.at(0)
    part2 = initials-dict.at(initials-dict-key).at(0)
    combine-mode = "-"
  } else {
    part1 = initials-dict.at(initials-dict-key).at(0)
    part2 = finals-dict.at(finals-dict-key).at(0)
    combine-mode = initials-dict.at(initials-dict-key).at(-1)
  }
  combine-parts(part1, part2, combine-mode, tone: tone)
}
