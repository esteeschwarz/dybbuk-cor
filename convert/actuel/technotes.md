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
