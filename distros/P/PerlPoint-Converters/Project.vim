
PerlPoint-Converters
====================
pp2html="/home/lorenz/pp/PerlPoint-Converters-1.0205" CD=. filter="*.pm pp2html pp2latex Makefile Makefile.PL Changes README README.gvim MANIFEST *.t *.pp" {
  pp2html
  pp2latex
  Makefile
  Makefile.PL
  Changes
  README
  README.gvim
  MANIFEST
 . # pragma keep
 Module=lib CD=. filter="*/*.pm */*/*.pm" {
   Bundle/PerlPoint.pm
   PerlPoint/Converters.pm
   PerlPoint/Tags/HTML.pm
   PerlPoint/Tags/LaTeX.pm
 }
 Styles=pp2html_styles CD=. {
  big_blue=big_blue CD=. filter="*.tpl *.htm *.cfg" {
    big_blue-bot.tpl
    big_blue-top.tpl
    big_blue.cfg
  }
  mixed-mode=mixed-mode CD=. filter="*.tpl *.htm *.cfg" {
    mixed-mode-frm.tpl
    mixed-mode-top.tpl
    mixed-mode-bot.htm
    mixed-mode-title.htm
    top_mixed-mode-title.htm
    mixed-mode.cfg
  }
  orange_slides=orange_slides CD=. filter="*.tpl *.htm *.cfg" {
    orange_slides-frm.tpl
    orange_slides-nav.tpl
    orange_slides-bot.htm
    orange_slides-top.htm
    orange_slides.cfg
  }
  pp_book=pp_book CD=. filter="*.tpl *.htm *.cfg" {
    pp_book-frm.tpl
    pp_book-nav.tpl
    pp_book-bot.htm
    pp_book-top.htm
    pp_book.cfg
  }
 }
 Docu=doc CD=. filter="*.pp */*.pp Makefile" {
   doc-functions.pp
   getting-started.pp
   parser-active-contents.pp
   parser-faq.pp
   parser-paragraphs.pp
   parser-tags.pp
   pp2html-faq.pp
   pp2html-ref.pp
   ppdoc.pp
   tagdoc-example.pp
   tagdoc-supported.pp
   writing-converters.pp
   faq-pp2html/faq-q1.pp
   tags/basic-tag-macros.pp
   tags/tag-A.pp
   tags/tag-B.pp
   tags/tag-BOXCOLORS.pp
   tags/tag-BR.pp
   tags/tag-C.pp
   tags/tag-F.pp
   tags/tag-FORMAT.pp
   tags/tag-HIDE.pp
   tags/tag-HR.pp
   tags/tag-I.pp
   tags/tag-IMAGE.pp
   tags/tag-L.pp
   tags/tag-LOCALTOC.pp
   tags/tag-PAGEREF.pp
   tags/tag-READY.pp
   tags/tag-REF.pp
   tags/tag-SECTIONREF.pp
   tags/tag-SEQ.pp
   tags/tag-STOP.pp
   tags/tag-SUB.pp
   tags/tag-SUP.pp
   tags/tag-TABLE.pp
   tags/tag-U.pp
   tags/tag-X.pp
   tags/tag-XREF.pp
   Makefile
  cfg-Files=. CD=. filter="*.cfg" {
    getting-started.cfg
    parser-faq.cfg
    pp2html-faq.cfg
    pp2html-ref.cfg
    writing-converters.cfg
  }
  pp-Files=. CD=. filter="*.pp */*.pp" {
    doc-functions.pp
    getting-started.pp
    parser-active-contents.pp
    parser-faq.pp
    parser-paragraphs.pp
    parser-tags.pp
    pp2html-faq.pp
    pp2html-ref.pp
    ppdoc.pp
    tagdoc-example.pp
    tagdoc-supported.pp
    writing-converters.pp
    faq-pp2html/faq-q1.pp
    tags/basic-tag-macros.pp
    tags/tag-A.pp
    tags/tag-B.pp
    tags/tag-BOXCOLORS.pp
    tags/tag-BR.pp
    tags/tag-C.pp
    tags/tag-F.pp
    tags/tag-FORMAT.pp
    tags/tag-HIDE.pp
    tags/tag-HR.pp
    tags/tag-I.pp
    tags/tag-IMAGE.pp
    tags/tag-L.pp
    tags/tag-LOCALTOC.pp
    tags/tag-PAGEREF.pp
    tags/tag-READY.pp
    tags/tag-REF.pp
    tags/tag-SECTIONREF.pp
    tags/tag-SEQ.pp
    tags/tag-STOP.pp
    tags/tag-SUB.pp
    tags/tag-SUP.pp
    tags/tag-TABLE.pp
    tags/tag-U.pp
    tags/tag-X.pp
    tags/tag-XREF.pp
 }
 }
 Test=t CD=. {
   pptest.pm
   README
   ltx_test_bullets.t
   ltx_test_escapes.t
   ltx_test_numlists.t
   ltx_test_ref.t
   ltx_test_sectioning.t
   ltx_test_tables.t
   ltx_test_tags.t
   ltx_test_txt_bgcolor.t
   test_bullets.t
   test_color_refs.t
   test_escapes.t
   test_escapes2.t
   test_localtoc.t
   test_numlists.t
   test_ref.t
   test_relative_path.t
   test_reverse.t
   test_styles.t
   test_tables.t
   test_tags.t
   test_txt_bgcolor.t
   test_verbatim.t
   test_bullets.pp
   test_color_refs.pp
   test_escapes.pp
   test_localtoc.pp
   test_numlists.pp
   test_ref.pp
   test_sections.pp
   test_styles.pp
   test_tables.pp
   test_tags.pp
   test_txt_bgcolor.pp
   test_verbatim.pp
 t-Files=. CD=. filter="*.t *.pm" {
    ltx_test_bullets.t
    ltx_test_escapes.t
    ltx_test_numlists.t
    ltx_test_ref.t
    ltx_test_sectioning.t
    ltx_test_tables.t
    ltx_test_tags.t
    ltx_test_txt_bgcolor.t
    test_bullets.t
    test_color_refs.t
    test_escapes.t
    test_escapes2.t
    test_localtoc.t
    test_numlists.t
    test_ref.t
    test_relative_path.t
    test_reverse.t
    test_styles.t
    test_tables.t
    test_tags.t
    test_txt_bgcolor.t
    test_verbatim.t
    pptest.pm
 }
 pp-Files=. CD=. filter="*.pp *.cfg" {
    test_bullets.pp
    test_color_refs.pp
    test_escapes.pp
    test_localtoc.pp
    test_numlists.pp
    test_ref.pp
    test_sections.pp
    test_styles.pp
    test_tables.pp
    test_tags.pp
    test_txt_bgcolor.pp
    test_verbatim.pp
    big_blue.cfg
    ltx-sections.cfg
    ltx.cfg
    orange_slides.cfg
    pp_book.cfg
  }
  d_bullets=d_bullets CD=. filter="*.ref" {
    bullets_0000.ref
    bullets_0001.ref
    bullets_0002.ref
    bullets_0003.ref
    ltx_bullets.ref
  }
  d_color_refs=d_color_refs CD=. filter="*.ref" {
    color_refs0000.ref
    color_refs0001.ref
    color_refs0002.ref
  }
  d_escapes=d_escapes CD=. filter="*.ref" {
    escapes_0000.ref
    escapes_0001.ref
    escapes_0002.ref
    escapes_0003.ref
    ltx_escapes.ref
  }
  d_escapes2=d_escapes2 CD=. filter="*.ref" {
    escapes_0000.ref
    escapes_0001.ref
    escapes_0002.ref
    escapes_0003.ref
  }
  d_localtoc=d_localtoc CD=. filter="*.ref" {
    localtoc_0000.ref
    localtoc_0001.ref
    localtoc_0002.ref
    localtoc_0003.ref
    localtoc_0004.ref
    localtoc_0005.ref
    localtoc_0006.ref
    localtoc_0007.ref
    localtoc_0008.ref
    localtoc_0009.ref
    localtoc_0010.ref
    localtoc_0011.ref
    localtoc_0012.ref
    localtoc_0013.ref
    localtoc_0014.ref
  }
  d_numlists=d_numlists CD=. filter="*.ref" {
    ltx_numlists.ref
    numlists_0000.ref
    numlists_0001.ref
  }
  d_refs=d_refs CD=. filter="*.ref" {
    ltx_ref.ref
    ref_0000.ref
    ref_0001.ref
    ref_0002.ref
    ref_0003.ref
    ref_0004.ref
    ref__idx.ref
  }
  d_styles=d_styles CD=. filter="*.ref" {
    big_blue0000.ref
    big_blue0001.ref
    big_blue0002.ref
    big_blue0003.ref
    big_blue_idx.ref
    orange_slides-bot.ref
    orange_slides-top.ref
    orange_slides0000.ref
    orange_slides0001.ref
    orange_slides0002.ref
    orange_slides0003.ref
    orange_slides_idx.ref
    pp_book-bot.ref
    pp_book-top.ref
    pp_book0000.ref
    pp_book0001.ref
    pp_book0002.ref
    pp_book0003.ref
    pp_book_idx.ref
    pp_book_start.ref
  }
  d_tables=d_tables CD=. filter="*.ref" {
    ltx_tables.ref
    tables_0000.ref
    tables_0001.ref
    tables_0002.ref
  }
  d_tags=d_tags CD=. filter="*.ref" {
    ltx_tags.ref
    tags_0000.ref
    tags_0001.ref
    tags_0002.ref
  }
  d_txt_bgcolor=d_txt_bgcolor CD=. filter="*.ref" {
    ltx_txt_bgcolor.ref
    txt_bgcolor_0000.ref
    txt_bgcolor_0001.ref
  }
  d_verbatim=d_verbatim CD=. filter="*.ref" {
    verbatim_0000.ref
    verbatim_0001.ref
  }
  d_changes=d_changes CD=. filter="*.ref" {
    changes0000.ref
    changes0001.ref
    changes0002.ref
    changes0003.ref
    changes0004.ref
    changes0005.ref
    changes0006.ref
    changes0007.ref
    changes0008.ref
    changes0009.ref
    changes0010.ref
    changes0011.ref
    changes0012.ref
    changes0013.ref
    changes0014.ref
    changes0015.ref
    changes0016.ref
    changes0017.ref
  }
 }
}

