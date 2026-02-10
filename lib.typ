#import "utils.typ": *
#import "data.typ": *
#import "display.typ": *

#let jyutcitzi(input) = {
  show re-other: m => simple-jyutcitzi-display(m.text)
  show re-nasal: m => syllabic-nasal-char(m.text)
  show regex(" "): m => ""
  input
}
