# 14322.editorial questions collection
#### yiddishe terms -- 04.08.2024
maybe to integrate/annotate

פראצענטניק: kredithai (deepL from russian)

cf. [דער נייער פראצענטניק / א מעשה פון י' גוידא | Book | גורין, ברנרד, 1868-1925 | The National Library of Israel](https://www.nli.org.il/en/books/NNL_ALEPH990021257600205171/NLI)

חזן: kantor

#### 14316.editorial notes
#### speaker inconsistencies
- פרעיידעדע statt פריידעלע , xml L40, 003.txt L437, digit 19.19, book 17: ist im druck vorhanden
- ירוחס statt ירוחם / transcriptionsfehler, 003.txt L694, digit 30.18
- rasa- : digit 35.30: bindestrich am letzten wort der zeile
- ראזע statt ראזא : digit 34.5/9 : zweimalig andere schreibweise im druck
- דבירה statt דבורה : digit 34.10 : schlechter druck (type nicht vollständig)
- גֶעאַנְטְוָוארטֶעט : digit 43.30: doppelpunkt im text (wiedergegebene rede)
- ירוהם : transkriptionsfehler
- פריידאלע : digit 8.16, einmalige andersschreibung im speaker, 3x im text
- פריידע : digit 9.30 1x andersschreibung

die transkriptionsfehler wurden korrigiert. andersschreibung wurde beibehalten, dafür die `<sp who="xxx">` angepasst und der mehrheitlich verwendeten `xml:id` für diesen speaker in der `<particDesc>` zugeordnet. falsch übertragene bindestriche (hyphenation) wurden entfernt und mit einer `<edit>verweis</edit>` note annotiert, welche noch dem dracor annotationsschema angepasst werden kann.

#### niqqud
1.  
the text is vocalised to a great extend i.e. besides the speakers every word is clearly annotated. we compared the rules to other texts (*Sholem bayis*, Yitskhok-Leybush Perets, <https://github.com/REYD-TTS/yiddish-tts-texts/blob/master/txt/sholem.txt>, cf. [yiddish book center](https://www.yiddishbookcenter.org/collections/yiddish-books/spb-nybc200014/peretz-isaac-leib-pinski-di-verk-fun-yitshak-leybush-perets-tsvelf-d-h-draytsn-bend-vol-3) or modern poems on [lyrikline](https://www.lyrikline.org/de/gedichte/14927)) and it seems that they used different rules for vocalisation spelling, like e.g. (patterns):   

נאך , דאס where the niqqud in *yudale* appear under the preceding consonant (like in hebrew script) while in Peret's text (which is generally annotated very rarely) they are placed under the vowel. this is a consistent rule.

# general
it would have been a good idea to instead of to deleting linebreaks in the source transcript to in the first stage replace them by a markup, as now in the working text any reference to the original source page is gone. the dracor scheme doesnt seem to support multiple \<p> elements in one speech act \<sp> besides for verse passages. for possible feedback of outside transkribus corrected text into transkribus and for editorial reasons it would now be nice to have the linebreaks preserved.