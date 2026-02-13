#import "utils.typ": *
// #import "data.typ": *
#import "display.typ": *

#let jyutcitzi(input) = {
  show regex(" "): m => ""
  show regex(jp-initials): m => simple-jyutcitzi-display(m.text, none, tone: none)
  show regex-jyutping: m => {
    let (jp-initial, jp-final, jp-tone) = split-jyutping(m.text)
    simple-jyutcitzi-display(jp-initial, jp-final, tone: jp-tone)
  }
  // show regex-simple-jyutcitzi: m => {
  //   let (jc-initial, jc-final, jc-tone) = split-simple-jyutcit(m.text)
  //   display-from-simple-jc-tuple(jc-initial, jc-final, tone: jc-tone)
  // }
  // show regex(jc-initials-str): m => combine-parts("", m.text, "-", tone: none)
  input
}
