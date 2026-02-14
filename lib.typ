#import "data.typ"
#import "display.typ": *
#import "utils.typ": *

#let jyutcitzi(input) = {
  show regex(" "): m => ""
  // Render Jyutcitzi from Jyutci alphabets
  show regex-simple-jyutcitzi: m => {
    let (jc-initial, jc-final, jc-tone) = split-simple-jyutcit(m.text)
    display-from-simple-jc-tuple(jc-initial, jc-final, tone: jc-tone)
  }
  // Convert Jyut6ping3 to Jyutcit alphabets
  show regex-jyutping: m => {
    let (jp-initial, jp-final, jp-tone) = split-jyutping(m.text)
    let jc-initial = get-jc-from-jp-init(jp-initial)
    let jc-final = get-jc-from-jp-final(jp-final)
    jc-initial + jc-final + jp-tone
  }
  // Convert standalone Jyutping alphabet to Jyutcit alphabet
  show regex("\b" + jp-initials + "\b"): m => get-jc-from-jp-init(m.text)
  input
}
