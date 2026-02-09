#import "utils.typ": split-jyutping
#import "data.typ": *
#import "display.typ": simple-jyutcitzi-display, combine-parts

#let jyutcitzi(input) = {
  show regex("\S+"): m => simple-jyutcitzi-display(m.text)
  show regex(" "): m => ""
  input
}
