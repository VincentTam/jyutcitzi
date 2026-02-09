/// Regex patterns for jyutping beginnings and endings
#let jp-initials = regex("^(ng|gw|kw|[bpmfdtnlgkhzcsjw])")
#let jp-finals = regex("((aa|oe|eo|yu|[aeiou])(ng|[iumnptk])?)")

/// Split jyutping into beginning & ending
#let split-jyutping(jyutping) = (jp-initials, jp-finals).map(re => jyutping.find(re))
