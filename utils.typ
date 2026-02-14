#import "data.typ": *

/// Define the Jyutping initials, finals and the tone set
#let jp-initials = "(ng|gw|kw|[bpmfdtnlgkhzcsjw])"
#let jp-finals = "((aa|oe|eo|yu|[aeiou])(ng|[iumnptk])?|m|ng)"
#let jp-tones = "([1-6])"
// Regex for a Jyut6ping3
#let regex-jyutping = regex("\b" + jp-initials + "?" + jp-finals + jp-tones + "?\b")
// Regex for an "extended Jyutping" with compound initials (CCV)
#let regex-jp-ccv = regex("\b" + jp-initials + jp-initials + jp-finals + jp-tones + "?\b")
// Regex for an "extended Jyutping" with both initial & final consonant (CVC)
#let regex-jp-cvc = regex("\b" + jp-initials + "?" + jp-finals + jp-initials + jp-tones + "?\b")

/// Split (extended) `jyutping` into "Jyutping tuple"
/// - `jyutping`: jyut6ping3 input string, tones are optional
/// - `split-mode`:
///   - `"simple"`: consonant (initial) + vowel (final)
///   - `"CCV"`: compound initial (i.e. two consonants)
///   - `"CVC"`: both initial and final consonants
#let split-jyutping(jyutping, split-mode: "simple") = {
  let split-dict = (
    "simple": ((0, 1, -1), regex-jyutping),
    "CCV": ((0, 1, 2, 5), regex-jp-ccv),
    "CVC": ((0, 1, 4, 5), regex-jp-cvc),
  )
  let split-capture-grps = split-dict.at(split-mode).at(0)
  let split-regex = split-dict.at(split-mode).at(1)
  split-capture-grps.map(n => jyutping.match(split-regex).captures.at(n))
}

/// Define the Jyutcitzi initials & finals
#let jc-initials = (..initials-dict.values().map(v => v.slice(0, -1))).flatten().filter(val => type(val) == str)
#let jc-initials-str = "([" + jc-initials.join() + "])"
#let jc-finials = finals-dict.values().flatten().filter(val => type(val) == str)
#let jc-finals-str = "([" + jc-finials.join() + "])"
// Regex for a simple Jyutcitzi
#let regex-simple-jyutcitzi = regex("\b(" + jc-initials-str + "?" + jc-finals-str + jp-tones + "?|" + jc-initials-str + ")\b")

/// Split the Jyutcitzi input string into Jyutcitzi tuple
#let split-simple-jyutcit(jc-str) = {
  let jc-match = jc-str.match(regex-simple-jyutcitzi)
  if jc-match == none { return }
  if jc-match.captures.at(-1) == none {
    range(1, 4).map(n => jc-str.match(regex-simple-jyutcitzi).captures.at(n))
  } else {
    (jc-match.captures.at(-1), none, none)
  }
}

/// Reverse initial dict lookup
#let reverse-init-dict-lookup(jc-initial) = {
  let key-match = initials-dict.pairs().find(p => p.at(1).slice(0, -1).contains(jc-initial))
  if key-match != none { return key-match.at(0) }
}

/// Reverse final dict lookup
#let reverse-final-dict-lookup(jc-final) = {
  let key-match = finals-dict.pairs().find(p => p.at(1).contains(jc-final))
  if key-match != none { return key-match.at(0) }
}

/// Get Jyutcit alphabet from Jyutping initial
#let get-jc-from-jp-init(jp-initial) = {
  if jp-initial == none { return "" }
  if jp-initial != "ng" {
    initials-dict.at(jp-initial).at(0)
  } else {
    initials-dict.at(jp-initial).at(1)
  }
}

/// Get Jyutcit alphabet from Jyutping final
#let get-jc-from-jp-final(jp-final) = {
  if jp-final == none { return "" }
  if jp-final != "ng" and jp-final != "m" {
    finals-dict.at(jp-final).at(0)
  } else {
    finals-dict.at(jp-final).at(1)
  }
}
