# 14317.coding.info
#### TODO
- [x] pagebreak tagging
   - [ ] move \<pb> 1&2 to frontispiz and castlist
   - [ ] unwrap \<pb> if not in paragraph
- [x] castlist speaker:role & castgroups
- [x] stage directions remove `().`
- [x] speaker remove `:`
- [x] tag editorial notes
- [x] remove whitespace in speaker id's
- [ ] front: title page, frontispiz, STmarkup in .txt and convert
- [x] code verse passages in txt
- [x] validate .xml
- [ ] add play meta information according to: [sample.file.desc](TEI/sample.filedesc.xml)
  - [x] transliterate author/ play name
- [x] assign sex to personlist items
- [x] assign uniqe sp who="#id" to speakers
- [ ] outside task: restore linebreaks according to source transcript
- [ ] tag hebrew passages! \<foreign>
- [x] \<standoff> wikidata entity analogue: <https://www.wikidata.org/entity/Q125510805>
- [x] dracor id vergeben: yi000003
- [ ] extern: dracor entity (\<standoff>)


#### python for local ezdrama
`pip install html5lib`
`pip install lxml` for M2 xml tree building (bs4)
`pip install bs4`
`pip install transliterate`
`pip install yiddish`

#### xmlformat for prettify .xml
`brew install xmlformat` (Mac)

#### validation
- scheme: <https://dracor.org/schema.rng>

issues:
- \<comment> > \<note> (no \<comment> element allowed)
- xml:id = "jr kham" / remove spaces in xml:ids
- \<note type = "editorial"> : attribut [type] for \<note> not recognized though [recommended in dracor TEI documentation](https://dracor.org/doc/odd#TEI.note)
- \<note resp = "xxx"> : dito
- \<sp who = "#khr" line xml1293: empty line, not \<p>, chk in transcript /  textline was assigned $stage, txt557
- empty speaker in castlist (first) / solved with above

#### transkribus api
- [documentation](https://readcoop.eu/transkribus/docu/rest-api/)

#### general
- \<pb> are wrapped in \<p> or \<l> elements after ezd processing, better to stand single element if not within paragraph

#### transcript evaluation
using R package collostructions for computing ties of vocalised spelling variant (gold transcription) to token w/o nikkud. with this we calculate the most often used variant to vocalise (transcribed) a type. from that we find the most probable correction for the train set.

#### automate workflow
workflow to convert transkript.txt to TEI.xml via ezdrama and R refactoring script
- [ ] install R
- [ ] install packages
- [ ] cache all
- [ ] run script