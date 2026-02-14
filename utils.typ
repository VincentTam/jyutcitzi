#import "data.typ": *

/// Define the Jyutping initials, finals and the tone set
#let jp-tones = "([1-6])"
#let jp-initials = "(ng|gw|kw|[bpmfdtnlgkhzcsjw])"
#let jp-finals = "((aa|oe|eo|yu|[aeiou])(ng|[iumnptk])?|m|ng)"
// Regex for a Jyutping
#let regex-jyutping = regex("\b" + jp-initials + "?" + jp-finals + jp-tones + "?\b")

/// Split Jyutping into beginning & ending
#let split-jyutping(jyutping) = {
  (0, 1, 4).map(n => jyutping.match(regex-jyutping).captures.at(n))
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
  if jp-final != "ng" {
    finals-dict.at(jp-final).at(0)
  } else {
    finals-dict.at(jp-final).at(1)
  }
}
