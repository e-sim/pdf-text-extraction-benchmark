FUNCTION {hello}
{ "BibTeX bibliography style   L3 style    " top$
 %  "version 0.99a  for BibTeX 0.99c and LaTeX 2.09 " top$
  "laatste wijziging 10-10-91                     " top$
  "mostly copied from nucphys.bst                   " top$
}
% (C) Werenfried Spit    16-01-89
% 02-07-90  tijdschriftafkortingen verbeterd
 
ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
  }
  {}
  { label }
 
INTEGERS { output.state before.all mid.sentence after.sentence after.block }
 
FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}
 
STRINGS { s t }
 
FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
        { %  add.period$
          ", " * write$
          newline$
          "\newblock  " write$
        }
        { output.state before.all =
            'write$
            { % add.period$ " " *
             " " write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}
 
FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}
 
FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { top$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}
 
FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}
 
FUNCTION {fin.entry}
{ write$
   "\relax" write$
  newline$
   "\relax" write$
}
 
FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}
 
FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}
 
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}
 
FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}
 
FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}
 
FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}
 
FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}
 
FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}
 
FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}
 
FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}
 
FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}
 
INTEGERS { nameptr namesleft numnames }
 
FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            {                            %  numnames #2 >
                                         %      { "," * }
                                         %      'skip$
                                         %    if$
              t "others" =
                { " \etal" * }
                { " and " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
  "{" swap$ * "}" *
}
 
FUNCTION {format.authors}
{ author empty$
    { "" }
    { author }
  if$
}
 
FUNCTION {format.editors}
{ editor empty$
    { "" }
    { output.state mid.sentence =
      { "ed. " }
      { "ed. " }
      if$
      editor format.names * }
    if$
}
 
FUNCTION {format.title}
{ title empty$
    { "" }
                               %   { title "t" change.case$ }
    { title }                  %   { title emphasize } to get italics
  if$
}
 
FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}
 
FUNCTION {format.date}
{ year empty$
    { month empty$
        { "" }
        { "there's a month but no year in " cite$ * warning$
          month
        }
      if$
    }
    { month empty$
        'year
        { month " " * year * }
      if$
    }
  if$
}
 
FUNCTION {format.btitle}
{ title }
 
FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}
 
FUNCTION {either.or.check}
{ empty$
    'pop$
    { pop$ } % "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}
 
FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "volume" volume tie.or.space.connect
      series empty$
        'skip$
        { " of " * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}
 
FUNCTION {format.number.series}
{ volume empty$
    { number empty$
        { series field.or.null }
        { output.state mid.sentence =
            { "number" }
            { "Number" }
          if$
          number tie.or.space.connect
          series empty$
            { "there's a number but no series in " cite$ * warning$ }
            { " in " * series * }
            { " in " * series * }
          if$
        }
      if$
    }
    { "" }
  if$
}
 
FUNCTION {format.edition}
{ edition empty$
    { "" }
    { edition "1" =
        { "First" }
        { edition "2" =
            { "Second" }
            { edition "3" =
                { "Third" }
                { edition #-2 #1 substring$ "1" =
                    { edition "$^{\rm th}$ " * }
                    { edition #-1 #1 substring$
                      "1" =
                        { edition "$^{\rm st}$ " * }
                        { edition #-1 #1 substring$
                          "2" =
                            { edition "$^{\rm nd}$ " * }
                            { edition #-1 #1 substring$
                              "3" =
                                { edition "$^{\rm rd}$ " * }
                                { edition "$^{\rm th}$ " * }
                                if$
                            }
                            if$
                        }
                        if$
                    }
                    if$
                }
                if$
            }
            if$
        }
        if$
        output.state mid.sentence =
            { "l" change.case$ " edition" * }
            { "t" change.case$ " edition" * }
            if$
    }
    if$
}
 
INTEGERS { multiresult }
 
FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
        { #1 'multiresult := }
        { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}
 
FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
        { "pp." pages n.dashify tie.or.space.connect }
        { "p." pages tie.or.space.connect }
      if$
    }
  if$
}
 
FUNCTION {format.vol.date.pages}
{   volume empty$
       { "empty volume in " cite$ * warning$ }
       { " {\bf " * volume * "} " * }
    if$
    year empty$
      {"empty year in" cite$ * warning$ ", " * }
      { " (" * year * ")" * }
      if$
    pages empty$
       'skip$
      { duplicate$ empty$
        { pop$ format.pages }
        { " " * pages n.dashify * }
      if$
         }
      if$
}
 
FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    { "(" number * ")" * *
      volume empty$
        { "there's a number but no volume in " cite$ * warning$ }
        'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
        { pop$ format.pages }
        { ":" * pages n.dashify * }
      if$
    }
  if$
}
 
FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
        { "chapter" }
        { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
        'skip$
        { ", " * format.pages * }
      if$
    }
  if$
}
 
FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
       { output.state mid.sentence =
        { "in " booktitle * }
        { "in " booktitle * }
        if$ }
       { output.state mid.sentence =
        { "in " booktitle * ", " * format.editors * }
        { "in " booktitle * ", " * format.editors * }
        if$ }
      if$
    }
  if$
}
 
FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}
 
FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}
 
FUNCTION {format.preprint.number}
{ type empty$
    { "Preprint" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}
 
FUNCTION {format.tr.number}
{ type empty$
    { "Internal Report" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}
 
FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
        { "need key or journal for " cite$ * " to crossref " * crossref *
          warning$
          ""
        }
        { "In {\em " journal * "\/}" * }
      if$
    }
    { "In " key * }
  if$
  " \cite{" * crossref * "}" *
}
 
FUNCTION {institution.or.organization.output}
{institution empty$
 {organization empty$
  { "Both organization and institution are missing in " cite$ * warning$ }
  { organization output }
  if$
 }
 {institution output}
if$
}
 
FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
        'skip$
        { editor #2 "{ff }{vv }{ll}{, jj}" format.name$ "others" =
            { " et~al." * }
            { " and " * editor #2 "{vv~}{ll}" format.name$ * }
          if$
          if$
        }
      if$
    }
  if$
}
 
FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "In "
    }
    { "Volume" volume tie.or.space.connect
      " of " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { series empty$
            { "need editor, key, or series for " cite$ * " to crossref " *
              crossref * warning$
              "" *
            }
            { "{\em " * series * "\/}" * }
          if$
        }
        { key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}
 
FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
        { booktitle empty$
            { "need editor, key, or booktitle for " cite$ * " to crossref " *
              crossref * warning$
              ""
            }
            { "in " booktitle * }
          if$
        }
        { "in " booktitle * }
      if$
    }
    { "in " format.crossref.editor * }
  if$
  % " \cite{" * crossref * "}" *
}
 
FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check
  new.block
  crossref missing$
    { journal empty$
              { "empty journal in " cite$ * warning$ "" }
              { journal }
              if$
      format.vol.date.pages  output
    }
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  note output
  fin.entry
}
 
FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      new.block
      format.number.series output
      new.sentence
      "(" publisher * "publisher" output.check
      address output
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date ")" * "year" output.check
  new.block
  note output
  fin.entry
}
 
FUNCTION {booklet}
{ output.bibitem
  format.authors output
  new.block
  format.title "title" output.check
  howpublished address new.block.checkb
  howpublished output
  address output
  format.date output
  new.block
  note output
  fin.entry
}
 
FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull
      crossref missing$
        { "author and editor" editor either.or.check }
        'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      format.in.ed.booktitle output
      new.block
      format.number.series output
      new.sentence
      "(" publisher * "publisher" output.check
      address output
    }
    { format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date ")" * "year" output.check
  new.block
  note output
  fin.entry
}
 
FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      publisher "publisher" output.check
      address output
      format.edition output
      format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  new.block
  note output
  fin.entry
}
 
FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check
  new.block
%  format.title "title" output.check
%  new.block
   format.in.ed.booktitle output
      % format.bvolume output
      % format.number.series output
      % format.pages output
      address empty$
       {
%          organization institution new.sentence.checkb
%          institution.or.organization.output
          " (" publisher * output.nonnull
          format.date ")" * output
        }
        { " (" publisher * output.nonnull
          address output.nonnull
          format.date ")" * output
        }
      if$
    format.bvolume output
    format.pages output
%   new.block
%   note output
  fin.entry
}
 
FUNCTION {conference} { inproceedings }
 
FUNCTION {manual}
{ output.bibitem
  author empty$
 {institution.or.organization.output
  address output  }
 { format.authors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
  author empty$
    { organization empty$
        { address new.block.checka
          address output
        }
        'skip$
      if$
    }
    { organization institution new.block.checkb
      institution.or.organization.output
      address output
    }
  if$
  format.edition output
  format.date output
  new.block
  note output
  fin.entry
}
 
FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.btitle "title" output.check
  new.block
  "Master's thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  number empty$
         { skip$ }
         { " (Nr. " number * ")" * output }
         if$
  new.block
  note output
  fin.entry
}
 
FUNCTION {misc}
{ output.bibitem
  format.authors output
  title howpublished new.block.checkb
  format.title output
  howpublished new.block.checka
  howpublished output
  format.date output
  new.block
  note output
  fin.entry
  empty.misc.check
}
 
FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.btitle "title" output.check
  new.block
  "Ph.D. thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}
 
FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { institution.or.organization.output }
    { format.editors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
  format.bvolume output
  format.number.series output
  address empty$
    { editor empty$
        { publisher new.sentence.checka }
        { organization institution new.sentence.checkb
          institution.or.organization.output
        }
      if$
      publisher output
      format.date "year" output.check
    }
    { address output.nonnull
      format.date "year" output.check
      new.sentence
      editor empty$
        'skip$
        { institution.or.organization.output }
      if$
      publisher output
    }
  if$
  new.block
  note output
  fin.entry
}
 
FUNCTION {preprint}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  format.preprint.number output.nonnull
  institution.or.organization.output
  publisher output
  address output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  format.tr.number output.nonnull
  institution.or.organization.output
  address output
  format.date "year" output.check
  new.block
  note output
  fin.entry
}
 
FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check
  new.block
  format.title "title" output.check
  new.block
  note "note" output.check
  format.date output
  fin.entry
}
 
FUNCTION {default.type} { misc }
 
MACRO {jan} {"January"}
MACRO {feb} {"February"}
MACRO {mar} {"March"}
MACRO {apr} {"April"}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"August"}
MACRO {sep} {"September"}
MACRO {oct} {"October"}
MACRO {nov} {"November"}
MACRO {dec} {"December"}
 
 
MACRO {acmcs} {"ACM Computing Surveys"}
MACRO {acta} {"Acta Informatica"}
MACRO {cacm} {"Communications of the ACM"}
MACRO {ibmjrd} {"IBM Journal of Research and Development"}
MACRO {ibmsj} {"IBM Systems Journal"}
MACRO {ieeese} {"IEEE Transactions on Software Engineering"}
MACRO {ieeetc} {"IEEE Transactions on Computers"}
MACRO {ieeetcad} {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}
MACRO {ipl} {"Information Processing Letters"}
MACRO {jacm} {"Journal of the ACM"}
MACRO {jcss} {"Journal of Computer and System Sciences"}
MACRO {scp} {"Science of Computer Programming"}
MACRO {sicomp} {"SIAM Journal on Computing"}
MACRO {tocs} {"ACM Transactions on Computer Systems"}
MACRO {tods} {"ACM Transactions on Database Systems"}
MACRO {tog} {"ACM Transactions on Graphics"}
MACRO {toms} {"ACM Transactions on Mathematical Software"}
MACRO {toois} {"ACM Transactions on Office Information Systems"}
MACRO {poplas} {"ACM Transactions on Programming Languages and Systems"}
MACRO {tcs} {"Theoretical Computer Science"}
 
MACRO {Dokl}   {"Dokl. Akad. Nauk SSSR"}
MACRO {Usp}    {"Usp. Akad. Nauk SSSR"}
MACRO {FizElJa}{"Fiz. \`Elem. {\v}Castic At. Jadra"}
MACRO {ZETF}   {"\v{Z}. \`Eksp. Teor. Fiz."}
 
MACRO {AcP}    {"Acta Phys."}
MACRO {AcPP}   {"Acta Phys. Pol."}
MACRO {AcPA}   {"Acta Phys. Austriaca"}
MACRO {AdP}    {"Adv. Phys."}
MACRO {AdNP}   {"Adv. Nucl. Phys."}
MACRO {AmJP}   {"Am. J. Phys."}
MACRO {AnPDu}  {"Ann. Phys. (Leipzig)"}
MACRO {AnPFr}  {"Ann. Phys. (Paris)"}
MACRO {AnPNY}  {"Ann. Phys. (NY)"}
MACRO {ARevNS} {"Ann. Rev. Nucl. Sci."}
MACRO {ADNDT}  {"At. Data Nucl. Data Tables"}
MACRO {AusJP}  {"Austr. J. Phys."}
MACRO {CanJP}  {"Can. J. Phys."}
MACRO {CPC}    {"Comp. Phys. Comm."}
MACRO {EJP}    {"Eur. Jo. Phys."}
MACRO {EPL}    {"Europhys. Lett."}
MACRO {FBS}    {"Few Body Sys."}
MACRO {FBSSup} {"Few Body Sys. Suppl."}
MACRO {FortP}  {"Fortschr. Phys."}
MACRO {HePA}   {"Helv. Phys. Acta"}
MACRO {IEEE}   {"IEEE Trans."}
MACRO {IJMP}   {"Int. J. Mod. Phys."}
MACRO {JETP}   {"Sov. Phys. JETP"}
MACRO {JETPL}  {"JETP Lett."}
MACRO {JaFi}   {"Jad. Fiz."}
MACRO {JMP}    {"J. Math. Phys."}
MACRO {JPFr}   {"J. Phys. (Paris)"}
MACRO {JP}     {"J. Phys."}
MACRO {JPSJ}   {"J. Phys. Soc. Jap."}
MACRO {JPSJSup}{"J. Phys. Soc. Jap. Suppl."}
MACRO {MPL}    {"Mod. Phys. Lett."}
MACRO {NCim}   {"Nuovo Cimento"}
MACRO {NDS}    {"Nucl. Data Sh."}
MACRO {NIM}    {"Nucl. Inst. Meth."}
MACRO {NP}     {"Nucl. Phys."}
MACRO {PL}     {"Phys. Lett."}
MACRO {PRSLon} {"Proc. R. Soc. London"}
MACRO {PR}     {"Phys. Rev."}
MACRO {PRL}    {"Phys. Rev. Lett."}
MACRO {PRep}   {"Phys. Rep."}
MACRO {PScr}   {"Phys. Scr."}
MACRO {PToday} {"Phys. Today"}
MACRO {PTP}    {"Prog. Theor. Phys."}
MACRO {RMP}    {"Rev. Mod. Phys."}
MACRO {ScAm}   {"Sci. Am."}
MACRO {SSin}   {"Sci. Sin."}
MACRO {SovJNP} {"Sov. J. Nucl. Phys."}
MACRO {SovJPN} {"Sov. J. Part. Nucl."}
MACRO {SovPDo} {"Sov. Phys. Dokl."}
MACRO {SovPUs} {"Sov. Phys. Usp."}
MACRO {STS}    {"Bull. Sc. Tech. Soc. Aff."}
MACRO {ZfN}    {"Z. Naturforsch."}
MACRO {ZfP}    {"Z. Phys."}
 
MACRO {KUN} {"University of Nijmegen"}
MACRO {RUU} {"University of Utrecht"}
MACRO {UvA} {"University of Amsterdam"}
MACRO {RUG} {"University of Groningen"}
MACRO {RUL} {"University of Leiden"}
MACRO {VU}  {"Free University Amsterdam"}
MACRO {TUD} {"Technical University of Delft"}
 
MACRO {tbp} {"to be published"}

READ
 
FUNCTION {sortify}
{ purify$
  "l" change.case$
}
 
INTEGERS { len }
 
FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}
 
FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
      % sorteer alleen op eerste auteur:  Naam von I.N. jr
  s nameptr "{ll{ }}{  vv{ }}{ ff{ }}{  jj{ }}" format.name$ 't :=
  t sortify *
}
 
FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}
 
FUNCTION {author.sort}
{ author empty$
    { key empty$
        { "to sort, need author or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}
 
FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
        { key empty$
            { "to sort, need author, editor, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}
 
FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
        { key empty$
            { "to sort, need author, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}
 
FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
        { key empty$
            { "to sort, need editor, organization, or key in " cite$ * warning$
              ""
            }
            { key sortify }
          if$
        }
        { "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}
 
FUNCTION {presort}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
        'editor.organization.sort
        { type$ "manual" =
            'author.organization.sort
            'author.sort
          if$
        }
      if$
    }
  if$
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
 }
 
%  ITERATE {presort}
 
%  SORT
 
STRINGS { longest.label }
 
INTEGERS { number.label longest.label.width }
 
FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}
 
FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}
 
EXECUTE {initialize.longest.label}
 
ITERATE {longest.label.pass}
 
FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{mcbibliography}{"  longest.label  * "}" * write$ newline$
}
 
EXECUTE {hello}
 
EXECUTE {begin.bib}
 
EXECUTE {init.state.consts}
 
ITERATE {call.type$}
 
FUNCTION {end.bib}
{ newline$
  "\end{mcbibliography}" write$ newline$
}
 
EXECUTE {end.bib}
