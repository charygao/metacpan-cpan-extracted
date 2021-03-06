#!perl -wT
# Win32::GUI::Constants test suite
# $Id: 52_tags.t,v 1.6 2008/02/08 18:47:18 robertemay Exp $
#
# - check a single constant export

use strict;
use warnings;

BEGIN { $| = 1 } # Autoflush

# Check that the rest of the tags don't change from release to release
# without us knowing. IF YOU HAVE CHANGED THE TAG DEFINITIONS, THEN UPDATE
# THIS TEST FILE TO REFLECT THE CHANGES.

use Test::More;

my @tags = qw( common customdraw stockobjects accelerator animation bitmap brush
button class combobox cursor datetime dc font header icon imagelist label listbox listview
mdi menu monthcal notifyicon pen progressbar rebar region richedit scrollbar slider
splitter statusbar tabstrip textfield timer toolbar tooltip treeview updown window );

plan tests => (2 * @tags);

my %RESULTS = (
  common => [ qw( CW_USEDEFAULT ) ],
  customdraw => [
qw( CDDS_ITEM CDDS_ITEMPOSTERASE CDDS_PREERASE CDDS_POSTERASE CDDS_ITEMPOSTPAINT
    CDDS_ITEMPREERASE CDDS_SUBITEM CDDS_ITEMPREPAINT CDDS_POSTPAINT CDDS_PREPAINT
    CDRF_NOTIFYITEMDRAW CDRF_NEWFONT CDRF_SKIPDEFAULT CDRF_NOTIFYPOSTPAINT
    CDRF_NOTIFYSUBITEMDRAW CDRF_DODEFAULT CDRF_NOTIFYPOSTERASE ) ],
  stockobjects => [
qw( WHITE_BRUSH LTGRAY_BRUSH GRAY_BRUSH DKGRAY_BRUSH BLACK_BRUSH NULL_BRUSH HOLLOW_BRUSH
    WHITE_PEN BLACK_PEN NULL_PEN OEM_FIXED_FONT ANSI_FIXED_FONT ANSI_VAR_FONT SYSTEM_FONT
    DEVICE_DEFAULT_FONT DEFAULT_PALETTE SYSTEM_FIXED_FONT DEFAULT_GUI_FONT DC_BRUSH
    DC_PEN ) ],
  accelerator => [
qw( VK_OEM_PERIOD VK_VOLUME_DOWN VK_NUMLOCK VK_NONAME VK_LMENU VK_KANA VK_OEM_FINISH VK_V
    VK_F16 VK_ADD VK_OEM_RESET VK_END VK_LCONTROL VK_OEM_FJ_ROYA VK_NUMPAD0 VK_NEXT VK_O
    VK_OEM_PA1 VK_CANCEL VK_SLEEP VK_RIGHT VK_RETURN VK_F2 VK_LAUNCH_MAIL VK_BACK VK_F20
    VK_Z VK_ESCAPE VK_CAPITAL VK_M VK_PRINT VK_NONCONVERT VK_H VK_SHIFT VK_SPACE VK_F19
    VK_EREOF VK_3 VK_I VK_EXSEL VK_KANJI VK_LAUNCH_APP2 VK_F9 VK_NUMPAD9 VK_CONTROL
    VK_RWIN VK_VOLUME_MUTE VK_F10 VK_CRSEL VK_PA1 VK_B VK_F4 VK_PLAY VK_DIVIDE
    VK_OEM_COPY VK_SUBTRACT VK_DELETE VK_8 VK_NUMPAD5 VK_OEM_WSCTRL VK_NUMPAD2 VK_F24
    VK_LAUNCH_MEDIA_SELECT VK_OEM_ATTN VK_OEM_1 VK_JUNJA VK_F17 VK_F12 VK_OEM_CUSEL VK_A
    VK_HANGUL VK_ICO_HELP VK_R VK_OEM_5 VK_APPS VK_OEM_FJ_TOUROKU VK_OEM_PA2
    VK_OEM_NEC_EQUAL VK_F6 VK_LBUTTON VK_PRIOR VK_OEM_3 VK_F8 VK_UP VK_NUMPAD3 VK_C
    VK_SEPARATOR VK_MENU VK_SELECT VK_HANGEUL VK_X VK_INSERT VK_HELP VK_1 VK_BROWSER_HOME
    VK_F22 VK_DECIMAL VK_XBUTTON2 VK_F13 VK_OEM_AX VK_F VK_OEM_7 VK_OEM_FJ_LOYA VK_P
    VK_ZOOM VK_E VK_OEM_COMMA VK_OEM_FJ_MASSHOU VK_RMENU VK_RBUTTON VK_MEDIA_NEXT_TRACK
    VK_ICO_00 VK_OEM_ENLW VK_EXECUTE VK_F7 VK_OEM_BACKTAB VK_XBUTTON1 VK_F15
    VK_BROWSER_FORWARD VK_4 VK_NUMPAD8 VK_6 VK_N VK_T VK_PAUSE VK_LEFT VK_U
    VK_BROWSER_STOP VK_F3 VK_SNAPSHOT VK_F1 VK_ACCEPT VK_PACKET VK_MULTIPLY VK_G VK_ATTN
    VK_PROCESSKEY VK_K VK_LWIN VK_BROWSER_FAVORITES VK_NUMPAD1 VK_CONVERT VK_HOME
    VK_OEM_AUTO VK_RCONTROL VK_SCROLL VK_OEM_FJ_JISHO VK_OEM_6 VK_ICO_CLEAR VK_5
    VK_OEM_MINUS VK_L VK_F5 VK_S VK_TAB VK_OEM_CLEAR VK_OEM_PA3 VK_OEM_102 VK_RSHIFT
    VK_OEM_PLUS VK_LAUNCH_APP1 VK_BROWSER_SEARCH VK_MEDIA_PLAY_PAUSE VK_OEM_2 VK_CLEAR
    VK_9 VK_NUMPAD7 VK_NUMPAD6 VK_FINAL VK_MEDIA_STOP VK_2 VK_F21 VK_Y VK_F18 VK_Q VK_D
    VK_DOWN VK_F23 VK_F11 VK_OEM_8 VK_7 VK_0 VK_J VK_MEDIA_PREV_TRACK VK_MBUTTON VK_F14
    VK_BROWSER_REFRESH VK_BROWSER_BACK VK_VOLUME_UP VK_OEM_JUMP VK_NUMPAD4 VK_HANJA VK_W
    VK_LSHIFT VK_OEM_4 VK_MODECHANGE ) ],
  animation => [ qw( ACS_CENTER ACS_TRANSPARENT ACS_AUTOPLAY ACS_TIMER
    ACM_OPEN ACM_PLAY ACM_STOP ACN_START ACN_STOP  ) ],
  bitmap => [
qw( OBM_DNARROWD OBM_UPARROWI OBM_DNARROWI OBM_CHECKBOXES OBM_RGARROWI OBM_DNARROW
    OBM_RGARROW OBM_ZOOMD OBM_CHECK OBM_BTNCORNERS OBM_RESTORED OBM_MNARROW
    OBM_REDUCE OBM_UPARROWD OBM_RESTORE OBM_LFARROWI OBM_BTSIZE OBM_RGARROWD
    OBM_REDUCED OBM_SIZE OBM_ZOOM OBM_LFARROW OBM_LFARROWD OBM_COMBO OBM_UPARROW
    OBM_CLOSE ) ],
  brush => [ qw(  ) ],
  button => [
qw( BS_PUSHBUTTON BS_DEFPUSHBUTTON BS_CHECKBOX BS_AUTOCHECKBOX BS_RADIOBUTTON BS_3STATE
    BS_AUTO3STATE BS_GROUPBOX BS_USERBUTTON BS_AUTORADIOBUTTON BS_PUSHBOX BS_OWNERDRAW
    BS_TYPEMASK BS_LEFTTEXT BS_TEXT BS_ICON BS_BITMAP BS_LEFT BS_RIGHT BS_CENTER BS_TOP
    BS_BOTTOM BS_VCENTER BS_PUSHLIKE BS_MULTILINE BS_NOTIFY BS_FLAT BS_RIGHTBUTTON
    IMAGE_CURSOR IMAGE_BITMAP IMAGE_ENHMETAFILE IMAGE_ICON
    BM_GETCHECK BM_SETCHECK BM_GETSTATE BM_SETSTATE BM_SETSTYLE BM_CLICK BM_GETIMAGE
    BM_SETIMAGE
    BCM_FIRST BCM_GETIDEALSIZE BCM_SETIMAGELIST BCM_GETIMAGELIST BCM_SETTEXTMARGIN
    BCM_GETTEXTMARGIN
    BN_CLICKED BN_PAINT BN_HILITE BN_UNHILITE BN_DISABLE BN_DOUBLECLICKED BN_PUSHED
    BN_UNPUSHED BN_DBLCLK BN_SETFOCUS BN_KILLFOCUS) ],
  class => [
qw( COLOR_WINDOW COLOR_BACKGROUND COLOR_3DHIGHLIGHT COLOR_MENUTEXT COLOR_WINDOWTEXT
    COLOR_BTNSHADOW COLOR_GRAYTEXT COLOR_INACTIVEBORDER COLOR_BTNHIGHLIGHT COLOR_INFOTEXT
    COLOR_BTNTEXT COLOR_SCROLLBAR COLOR_MENUHILIGHT COLOR_CAPTIONTEXT COLOR_3DSHADOW
    COLOR_HOTLIGHT COLOR_MENUBAR COLOR_INACTIVECAPTIONTEXT COLOR_HIGHLIGHTTEXT
    COLOR_BTNHILIGHT COLOR_HIGHLIGHT COLOR_GRADIENTINACTIVECAPTION COLOR_MENU
    COLOR_BTNFACE COLOR_ACTIVECAPTION COLOR_3DDKSHADOW COLOR_ACTIVEBORDER
    COLOR_WINDOWFRAME COLOR_INACTIVECAPTION COLOR_INFOBK COLOR_APPWORKSPACE
    COLOR_GRADIENTACTIVECAPTION COLOR_DESKTOP COLOR_3DFACE COLOR_3DHILIGHT COLOR_3DLIGHT
    CS_DROPSHADOW CS_PARENTDC CS_NOCLOSE CS_VREDRAW CS_BYTEALIGNCLIENT CS_OWNDC
    CS_CLASSDC CS_BYTEALIGNWINDOW CS_DBLCLKS CS_IME CS_HREDRAW CS_SAVEBITS
    CS_GLOBALCLASS ) ],
  combobox => [
qw( CBS_SIMPLE CBS_DROPDOWN CBS_DROPDOWNLIST CBS_OWNERDRAWFIXED CBS_OWNERDRAWVARIABLE
    CBS_AUTOHSCROLL CBS_OEMCONVERT CBS_SORT CBS_HASSTRINGS CBS_NOINTEGRALHEIGHT
    CBS_DISABLENOSCROLL CBS_UPPERCASE CBS_LOWERCASE CBES_EX_NOEDITIMAGE
    CBES_EX_NOEDITIMAGEINDENT CBES_EX_PATHWORDBREAKPROC CBES_EX_NOSIZELIMIT
    CBES_EX_CASESENSITIVE
    CB_OKAY CB_ERR CB_ERRSPACE
    CB_GETEDITSEL CB_LIMITTEXT CB_SETEDITSEL CB_ADDSTRING CB_DELETESTRING CB_DIR
    CB_GETCOUNT CB_GETCURSEL CB_GETLBTEXT CB_GETLBTEXTLEN CB_INSERTSTRING CB_RESETCONTENT
    CB_FINDSTRING CB_SELECTSTRING CB_SETCURSEL CB_SHOWDROPDOWN CB_GETITEMDATA CB_SETITEMDATA
    CB_GETDROPPEDCONTROLRECT CB_SETITEMHEIGHT CB_GETITEMHEIGHT CB_SETEXTENDEDUI
    CB_GETEXTENDEDUI CB_GETDROPPEDSTATE CB_FINDSTRINGEXACT CB_SETLOCALE CB_GETLOCALE
    CB_GETTOPINDEX CB_SETTOPINDEX CB_GETHORIZONTALEXTENT CB_SETHORIZONTALEXTENT
    CB_GETDROPPEDWIDTH CB_SETDROPPEDWIDTH CB_INITSTORAGE CB_MULTIPLEADDSTRING
    CB_GETCOMBOBOXINFO
    CBN_ERRSPACE CBN_SELCHANGE CBN_DBLCLK CBN_SETFOCUS CBN_KILLFOCUS CBN_EDITCHANGE
    CBN_EDITUPDATE CBN_DROPDOWN CBN_CLOSEUP CBN_SELENDOK CBN_SELENDCANCEL ) ],
  cursor => [
qw( IDC_ARROW IDC_IBEAM IDC_WAIT IDC_CROSS IDC_UPARROW IDC_SIZENWSE
    IDC_SIZENESW IDC_SIZEWE IDC_SIZENS IDC_SIZEALL IDC_NO IDC_HAND
    IDC_APPSTARTING IDC_HELP IDC_HSPLIT IDC_VSPLIT
    OCR_NORMAL OCR_IBEAM OCR_WAIT OCR_CROSS OCR_UP OCR_SIZENWSE
    OCR_SIZENESW OCR_SIZEWE OCR_SIZENS OCR_SIZEALL OCR_NO OCR_HAND
    OCR_APPSTARTING ) ],
  datetime => [
qw( DTS_LONGDATEFORMAT DTS_APPCANPARSE DTS_TIMEFORMAT DTS_SHORTDATEFORMAT DTS_UPDOWN
    DTS_RIGHTALIGN DTS_SHORTDATECENTURYFORMAT DTS_SHOWNONE ) ],
  dc => [
qw( OPAQUE TRANSPARENT BDR_OUTER BDR_INNER BDR_SUNKENOUTER BDR_RAISED BDR_SUNKEN
    BDR_SUNKENINNER BDR_RAISEDINNER BDR_RAISEDOUTER EDGE_SUNKEN EDGE_ETCHED EDGE_BUMP
    EDGE_RAISED BF_FLAT BF_DIAGONAL_ENDBOTTOMRIGHT BF_MIDDLE BF_DIAGONAL_ENDTOPLEFT
    BF_DIAGONAL_ENDTOPRIGHT BF_LEFT BF_DIAGONAL_ENDBOTTOMLEFT BF_SOFT BF_DIAGONAL
    BF_RECT BF_MONO BF_RIGHT BF_TOPLEFT BF_BOTTOM BF_ADJUST BF_TOP BF_TOPRIGHT
    BF_BOTTOMRIGHT BF_BOTTOMLEFT CLR_INVALID HWND_DESKTOP DFC_SCROLL DFC_CAPTION
    DFC_MENU DFC_BUTTON DFC_POPUPMENU DFCS_SCROLLSIZEGRIP DFCS_PUSHED DFCS_SCROLLDOWN
    DFCS_MENUARROWRIGHT DFCS_SCROLLRIGHT DFCS_SCROLLCOMBOBOX DFCS_FLAT DFCS_BUTTONRADIO
    DFCS_CAPTIONRESTORE DFCS_CAPTIONCLOSE DFCS_CHECKED DFCS_BUTTONRADIOMASK
    DFCS_BUTTON3STATE DFCS_BUTTONPUSH DFCS_ADJUSTRECT DFCS_SCROLLUP DFCS_MENUCHECK
    DFCS_HOT DFCS_CAPTIONHELP DFCS_BUTTONRADIOIMAGE DFCS_INACTIVE DFCS_CAPTIONMAX
    DFCS_TRANSPARENT DFCS_SCROLLLEFT DFCS_SCROLLSIZEGRIPRIGHT DFCS_MONO DFCS_MENUARROW
    DFCS_CAPTIONMIN DFCS_BUTTONCHECK DFCS_MENUBULLET DT_WORDBREAK DT_BOTTOM DT_SINGLELINE
    DT_CALCRECT DT_RIGHT DT_EXPANDTABS DT_TOP DT_INTERNAL DT_EDITCONTROL DT_MODIFYSTRING
    DT_PREFIXONLY DT_PATH_ELLIPSIS DT_NOPREFIX DT_EXTERNALLEADING DT_RTLREADING
    DT_NOCLIP DT_TABSTOP DT_HIDEPREFIX DT_WORD_ELLIPSIS DT_CENTER DT_LEFT
    DT_NOFULLWIDTHCHARBREAK DT_END_ELLIPSIS DT_VCENTER FLOODFILLBORDER FLOODFILLSURFACE
    OBJ_PEN OBJ_MEMDC OBJ_BRUSH OBJ_DC OBJ_METAFILE OBJ_METADC OBJ_ENHMETADC OBJ_REGION
    OBJ_COLORSPACE OBJ_BITMAP OBJ_EXTPEN OBJ_PAL OBJ_FONT OBJ_ENHMETAFILE R2_NOT R2_BLACK
    R2_MERGENOTPEN R2_NOTXORPEN R2_XORPEN R2_WHITE R2_NOTMERGEPEN R2_MASKPEN
    R2_MASKPENNOT R2_COPYPEN R2_MERGEPENNOT R2_NOTCOPYPEN R2_NOP R2_MASKNOTPEN
    R2_NOTMASKPEN R2_MERGEPEN SRCCOPY SRCPAINT SRCAND SRCINVERT SRCERASE NOTSRCCOPY
    NOTSRCERASE MERGECOPY MERGEPAINT PATCOPY PATPAINT PATINVERT DSTINVERT BLACKNESS
    WHITENESS NOMIRRORBITMAP CAPTUREBLT ERROR NULLREGION SIMPLEREGION COMPLEXREGION
    RGN_DIFF RGN_AND RGN_MIN RGN_MAX RGN_XOR RGN_COPY RGN_ERROR RGN_OR BS_SOLID BS_NULL
    BS_HOLLOW BS_HATCHED BS_PATTERN BS_INDEXED BS_DIBPATTERN BS_DIBPATTERNPT
    BS_PATTERN8X8 BS_DIBPATTERN8X8 BS_MONOPATTERN HS_VERTICAL HS_CROSS HS_HORIZONTAL
    HS_DIAGCROSS HS_FDIAGONAL HS_BDIAGONAL PS_JOIN_BEVEL PS_ENDCAP_MASK PS_DASHDOT
    PS_ENDCAP_FLAT PS_STYLE_MASK PS_DASHDOTDOT PS_COSMETIC PS_INSIDEFRAME PS_TYPE_MASK
    PS_SOLID PS_JOIN_MITER PS_ENDCAP_SQUARE PS_JOIN_ROUND PS_ENDCAP_ROUND PS_DASH
    PS_JOIN_MASK PS_GEOMETRIC PS_DOT PS_USERSTYLE PS_NULL PS_ALTERNATE BLACKONWHITE
    WHITEONBLACK COLORONCOLOR HALFTONE STRETCH_ORSCANS STRETCH_HALFTONE
    STRETCH_DELETESCANS STRETCH_ANDSCANS ) ],
  font => [ qw(  ) ],
  header => [
qw( HDS_HORZ HDS_BUTTONS HDS_HOTTRACK HDS_HIDDEN HDS_DRAGDROP HDS_FULLDRAG HDS_FILTERBAR
    HDS_FLAT ) ],
  icon => [
qw( IDI_EXCLAMATION IDI_ASTERISK IDI_APPLICATION IDI_HAND IDI_INFORMATION IDI_ERROR
    IDI_QUESTION IDI_WARNING IDI_WINLOGO IDI_DEFAULTICON
    OIC_WINLOGO OIC_BANG OIC_QUES OIC_INFORMATION OIC_NOTE OIC_SAMPLE OIC_WARNING
    OIC_ERROR OIC_HAND ) ],
  imagelist => [
qw( ILC_COLOR16 ILC_MIRROR ILC_COLOR24 ILC_COLORDDB ILC_COLOR8 ILC_COLOR
    ILC_PERITEMMIRROR ILC_MASK ILC_COLOR32 ILC_PALETTE ILC_COLOR4 ILD_ROP ILD_OVERLAYMASK
    ILD_BLEND25 ILD_PRESERVEALPHA ILD_DPISCALE ILD_SELECTED ILD_BLEND50 ILD_FOCUS
    ILD_BLEND ILD_TRANSPARENT ILD_SCALE ILD_NORMAL ILD_IMAGE ILD_MASK ILS_ALPHA
    ILS_SATURATE ILS_GLOW ILS_NORMAL ILS_SHADOW CLR_NONE CLR_DEFAULT IMAGE_CURSOR
    IMAGE_BITMAP IMAGE_ENHMETAFILE IMAGE_ICON ) ],
  label => [ qw( IMAGE_CURSOR IMAGE_BITMAP IMAGE_ENHMETAFILE IMAGE_ICON
    STM_SETICON STM_GETICON STM_SETIMAGE STM_GETIMAGE STM_MSGMAX
    STN_CLICKED STN_DBLCLK STN_ENABLE STN_DISABLE) ],
  listbox => [
qw( LBS_NOTIFY LBS_SORT LBS_NOREDRAW LBS_MULTIPLESEL LBS_OWNERDRAWFIXED LBS_OWNERDRAWVARIABLE
    LBS_HASSTRINGS LBS_USETABSTOPS LBS_NOINTEGRALHEIGHT LBS_MULTICOLUMN LBS_WANTKEYBOARDINPUT
    LBS_EXTENDEDSEL LBS_DISABLENOSCROLL LBS_NODATA LBS_NOSEL LBS_COMBOBOX LBS_STANDARD
    LB_OKAY LB_ERR LB_ERRSPACE
    LB_ADDSTRING LB_INSERTSTRING LB_DELETESTRING LB_SELITEMRANGEEX LB_RESETCONTENT
    LB_SETSEL LB_SETCURSEL LB_GETSEL LB_GETCURSEL LB_GETTEXT LB_GETTEXTLEN LB_GETCOUNT
    LB_SELECTSTRING LB_DIR LB_GETTOPINDEX LB_FINDSTRING LB_GETSELCOUNT LB_GETSELITEMS
    LB_SETTABSTOPS LB_GETHORIZONTALEXTENT LB_SETHORIZONTALEXTENT LB_SETCOLUMNWIDTH
    LB_ADDFILE LB_SETTOPINDEX LB_GETITEMRECT LB_GETITEMDATA LB_SETITEMDATA LB_SELITEMRANGE
    LB_SETANCHORINDEX LB_GETANCHORINDEX LB_SETCARETINDEX LB_GETCARETINDEX LB_SETITEMHEIGHT
    LB_GETITEMHEIGHT LB_FINDSTRINGEXACT LB_SETLOCALE LB_GETLOCALE LB_SETCOUNT LB_INITSTORAGE
    LB_ITEMFROMPOINT LB_MULTIPLEADDSTRING LB_GETLISTBOXINFO
    LBN_ERRSPACE LBN_SELCHANGE LBN_DBLCLK LBN_SELCANCEL LBN_SETFOCUS LBN_KILLFOCUS ) ],
  listview => [
qw( LVS_ICON LVS_REPORT LVS_SMALLICON LVS_LIST LVS_TYPEMASK LVS_SINGLESEL LVS_SHOWSELALWAYS
    LVS_SORTASCENDING LVS_SORTDESCENDING LVS_SHAREIMAGELISTS LVS_NOLABELWRAP LVS_AUTOARRANGE
    LVS_EDITLABELS LVS_OWNERDATA LVS_NOSCROLL LVS_TYPESTYLEMASK LVS_ALIGNTOP LVS_ALIGNLEFT
    LVS_ALIGNMASK LVS_OWNERDRAWFIXED LVS_NOCOLUMNHEADER LVS_NOSORTHEADER LVS_EX_GRIDLINES
    LVS_EX_SUBITEMIMAGES LVS_EX_CHECKBOXES LVS_EX_TRACKSELECT LVS_EX_HEADERDRAGDROP
    LVS_EX_FULLROWSELECT LVS_EX_ONECLICKACTIVATE LVS_EX_TWOCLICKACTIVATE LVS_EX_FLATSB
    LVS_EX_REGIONAL LVS_EX_INFOTIP LVS_EX_UNDERLINEHOT LVS_EX_UNDERLINECOLD
    LVS_EX_MULTIWORKAREAS LVS_EX_LABELTIP LVS_EX_BORDERSELECT LVS_EX_DOUBLEBUFFER
    LVS_EX_HIDELABELS LVS_EX_SINGLEROW LVS_EX_SNAPTOGRID LVS_EX_SIMPLESELECT LVIS_FOCUSED
    LVIS_SELECTED LVIS_CUT LVIS_DROPHILITED LVIS_GLOW LVIS_ACTIVATING LVIS_OVERLAYMASK
    LVIS_STATEIMAGEMASK LVSIL_NORMAL LVSIL_SMALL LVSIL_STATE LVIR_BOUNDS LVIR_ICON
    LVIR_LABEL LVIR_SELECTBOUNDS CLR_NONE ) ],
  mdi => [ qw(  ) ],
  menu => [
qw( MF_STRING MF_POPUP MF_BYCOMMAND MF_RIGHTJUSTIFY MF_USECHECKBITMAPS MF_MENUBREAK
    MF_SEPARATOR MF_BITMAP MF_HILITE MF_BYPOSITION MF_SYSMENU MF_APPEND MF_DELETE
    MF_DEFAULT MF_CHECKED MF_DISABLED MF_UNCHECKED MF_CHANGE MF_MOUSESELECT MF_GRAYED
    MF_REMOVE MF_OWNERDRAW MF_MENUBARBREAK MF_HELP MF_UNHILITE MF_ENABLED SC_VSCROLL
    SC_HOTKEY SC_MOUSEMENU SC_CONTEXTHELP SC_RESTORE SC_NEXTWINDOW SC_KEYMENU SC_MAXIMIZE
    SC_ARRANGE SC_CLOSE SC_MINIMIZE SC_MONITORPOWER SC_ZOOM SC_MOVE SC_TASKLIST
    SC_HSCROLL SC_ICON SC_DEFAULT SC_SEPARATOR SC_PREVWINDOW SC_SIZE SC_SCREENSAVE
    TPM_VERPOSANIMATION TPM_CENTERALIGN TPM_NONOTIFY TPM_HORPOSANIMATION TPM_NOANIMATION
    TPM_RETURNCMD TPM_HORNEGANIMATION TPM_HORIZONTAL TPM_TOPALIGN TPM_VERTICAL
    TPM_LAYOUTRTL TPM_RIGHTALIGN TPM_VERNEGANIMATION TPM_VCENTERALIGN TPM_BOTTOMALIGN
    TPM_LEFTBUTTON TPM_RIGHTBUTTON TPM_LEFTALIGN TPM_RECURSE ) ],
  monthcal => [
qw( MCS_DAYSTATE MCS_MULTISELECT MCS_WEEKNUMBERS MCS_NOTODAYCIRCLE MCS_NOTODAY
    MCSC_TITLEBK MCSC_BACKGROUND MCSC_TRAILINGTEXT MCSC_TITLETEXT MCSC_MONTHBK
    MCSC_TEXT ) ],
  notifyicon => [ qw(  ) ],
  pen => [
qw( PS_JOIN_BEVEL PS_ENDCAP_MASK PS_DASHDOT PS_ENDCAP_FLAT PS_STYLE_MASK PS_DASHDOTDOT
    PS_COSMETIC PS_INSIDEFRAME PS_TYPE_MASK PS_SOLID PS_JOIN_MITER PS_ENDCAP_SQUARE
    PS_JOIN_ROUND PS_ENDCAP_ROUND PS_DASH PS_JOIN_MASK PS_GEOMETRIC PS_DOT PS_USERSTYLE
    PS_NULL PS_ALTERNATE ) ],
  progressbar => [
qw( PBM_SETRANGE PBM_SETPOS PBM_DELTAPOS PBM_SETSTEP PBM_STEPIT PBM_SETRANGE32
    PBM_GETRANGE PBM_GETPOS PBM_SETBARCOLOR PBM_SETBKCOLOR PBM_SETMARQUEE
    PBS_SMOOTH PBS_VERTICAL PBS_MARQUEE
    CLR_DEFAULT ) ],
  rebar => [
qw( CLR_DEFAULT RBBS_GRIPPERALWAYS RBBS_FIXEDBMP RBBS_VARIABLEHEIGHT RBBS_BREAK
    RBBS_USECHEVRON RBBS_TOPALIGN RBBS_HIDETITLE RBBS_NOVERT RBBS_NOGRIPPER
    RBBS_FIXEDSIZE RBBS_CHILDEDGE RBBS_HIDDEN ) ],
  region => [ qw( RGN_DIFF RGN_AND RGN_MIN RGN_MAX RGN_XOR RGN_COPY RGN_ERROR RGN_OR ) ],
  richedit => [
qw( CP_MACCP CP_UTF8 CP_OEMCP CP_SYMBOL CP_ACP CP_UTF7 CP_THREAD_ACP EM_GETWORDBREAKPROC
    EM_LINEFROMCHAR EM_GETMARGINS EM_SETIMESTATUS EM_POSFROMCHAR EM_GETSEL EM_SETMODIFY
    EM_GETFIRSTVISIBLELINE EM_SETHANDLE EM_EMPTYUNDOBUFFER EM_GETMODIFY EM_FMTLINES
    EM_GETIMESTATUS EM_SETREADONLY EM_GETLIMITTEXT EM_LINESCROLL EM_GETLINE EM_SETSEL
    EM_LINEINDEX EM_REPLACESEL EM_GETPASSWORDCHAR EM_LIMITTEXT EM_SETPASSWORDCHAR
    EM_SCROLLCARET EM_UNDO EM_SETTABSTOPS EM_SETRECTNP EM_GETLINECOUNT EM_SETLIMITTEXT
    EM_GETHANDLE EM_SCROLL EM_LINELENGTH EM_SETWORDBREAKPROC EM_CHARFROMPOS EM_CANUNDO
    EM_SETMARGINS EM_GETTHUMB EM_GETRECT EM_SETRECT ENM_CHANGE ENM_MOUSEEVENTS
    ENM_KEYEVENTS ENM_PROTECTED ENM_PARAGRAPHEXPANDED ENM_LANGCHANGE ENM_UPDATE
    ENM_SCROLLEVENTS ENM_REQUESTRESIZE ENM_LINK ENM_SCROLL ENM_PAGECHANGE ENM_NONE
    ENM_OBJECTPOSITIONS ENM_CORRECTTEXT ENM_SELCHANGE ENM_LOWFIRTF ENM_DRAGDROPDONE
    ENM_DROPFILES ENM_IMECHANGE ES_AUTOHSCROLL ES_CENTER ES_OEMCONVERT ES_AUTOVSCROLL
    ES_NUMBER ES_RIGHT ES_READONLY ES_MULTILINE ES_PASSWORD ES_LOWERCASE ES_LEFT
    ES_NOHIDESEL ES_UPPERCASE ES_WANTRETURN GT_DEFAULT GT_RAWTEXT GT_NOHIDDENTEXT
    GT_USECRLF GT_SELECTION SF_NCRFORNONASCII SF_TEXT SF_TEXTIZED SF_RTFVAL SF_UNICODE
    SF_RTF SF_RTFNOOBJS SF_USECODEPAGE SFF_PLAINRTF SFF_PWD SFF_SELECTION
    SFF_WRITEXTRAPAR SFF_PERSISTVIEWSCALE SFF_KEEPDOCINFO
    EN_MSGFILTER EN_REQUESTRESIZE EN_SELCHANGE EN_DROPFILES EN_PROTECTED EN_CORRECTTEXT
    EN_STOPNOUNDO EN_IMECHANGE EN_SAVECLIPBOARD EN_OLEOPFAILED EN_OBJECTPOSITIONS
    EN_LINK EN_DRAGDROPDONE EN_PARAGRAPHEXPANDED EN_PAGECHANGE EN_LOWFIRTF EN_ALIGNLTR
    EN_ALIGNRTL EN_SETFOCUS EN_KILLFOCUS EN_CHANGE EN_UPDATE EN_ERRSPACE EN_MAXTEXT
    EN_HSCROLL EN_VSCROLL EN_ALIGN_LTR_EC EN_ALIGN_RTL_EC
    ) ],
  scrollbar => [
qw( SB_THUMBTRACK SB_LINEUP SB_BOTTOM SB_LEFT SB_ENDSCROLL SB_PAGEUP SB_HORZ SB_BOTH
    SB_THUMBPOSITION SB_PAGELEFT SB_LINERIGHT SB_LINELEFT SB_VERT SB_RIGHT SB_CTL
    SB_PAGEDOWN SB_TOP SB_LINEDOWN SB_PAGERIGHT
    SBM_SETPOS SBM_GETPOS SBM_SETRANGE SBM_SETRANGEREDRAW SBM_GETRANGE SBM_ENABLE_ARROWS
    SBM_SETSCROLLINFO SBM_GETSCROLLINFO SBM_GETSCROLLBARINFO
    SBS_HORZ SBS_VERT SBS_TOPALIGN SBS_LEFTALIGN SBS_BOTTOMALIGN SBS_RIGHTALIGN
    SBS_SIZEBOXTOPLEFTALIGN SBS_SIZEBOXBOTTOMRIGHTALIGN SBS_SIZEBOX SBS_SIZEGRIP) ],
  slider => [ qw( TBTS_BOTTOM TBTS_LEFT TBTS_RIGHT TBTS_TOP ) ],
  splitter => [ qw(  ) ],
  statusbar => [
qw( CLR_DEFAULT SBT_NOBORDERS SBT_POPOUT SBT_OWNERDRAW SBT_NOTABPARSING
    SBT_RTLREADING ) ],
  tabstrip => [ qw(  ) ],
  textfield => [
qw( EM_GETWORDBREAKPROC EM_LINEFROMCHAR EM_GETMARGINS EM_SETIMESTATUS EM_POSFROMCHAR
    EM_GETSEL EM_SETMODIFY EM_GETFIRSTVISIBLELINE EM_SETHANDLE EM_EMPTYUNDOBUFFER
    EM_GETMODIFY EM_FMTLINES EM_GETIMESTATUS EM_SETREADONLY EM_GETLIMITTEXT EM_LINESCROLL
    EM_GETLINE EM_SETSEL EM_LINEINDEX EM_REPLACESEL EM_GETPASSWORDCHAR EM_LIMITTEXT
    EM_SETPASSWORDCHAR EM_SCROLLCARET EM_UNDO EM_SETTABSTOPS EM_SETRECTNP EM_GETLINECOUNT
    EM_SETLIMITTEXT EM_GETHANDLE EM_SCROLL EM_LINELENGTH EM_SETWORDBREAKPROC
    EM_CHARFROMPOS EM_CANUNDO EM_SETMARGINS EM_GETTHUMB EM_GETRECT EM_SETRECT
    ES_AUTOHSCROLL ES_CENTER ES_OEMCONVERT ES_AUTOVSCROLL ES_NUMBER ES_RIGHT ES_READONLY
    ES_MULTILINE ES_PASSWORD ES_LOWERCASE ES_LEFT ES_NOHIDESEL ES_UPPERCASE
    ES_WANTRETURN ) ],
  timer => [ qw(  ) ],
  toolbar => [
qw( BTNS_WHOLEDROPDOWN BTNS_DROPDOWN BTNS_NOPREFIX BTNS_GROUP BTNS_SHOWTEXT
    BTNS_CHECKGROUP BTNS_SEP BTNS_AUTOSIZE BTNS_BUTTON BTNS_CHECK TBSTATE_CHECKED
    TBSTATE_ELLIPSES TBSTATE_WRAP TBSTATE_MARKED TBSTATE_HIDDEN TBSTATE_PRESSED
    TBSTATE_ENABLED TBSTATE_INDETERMINATE TBSTYLE_EX_HIDECLIPPEDBUTTONS
    TBSTYLE_TRANSPARENT TBSTYLE_CHECK TBSTYLE_FLAT TBSTYLE_LIST TBSTYLE_CHECKGROUP
    TBSTYLE_SEP TBSTYLE_BUTTON TBSTYLE_DROPDOWN TBSTYLE_ALTDRAG TBSTYLE_TOOLTIPS
    TBSTYLE_EX_DRAWDDARROWS TBSTYLE_REGISTERDROP TBSTYLE_GROUP TBSTYLE_EX_DOUBLEBUFFER
    TBSTYLE_AUTOSIZE TBSTYLE_NOPREFIX TBSTYLE_EX_MIXEDBUTTONS TBSTYLE_WRAPABLE
    TBSTYLE_CUSTOMERASE I_IMAGENONE I_IMAGECALLBACK CLR_DEFAULT TRANSPARENT OPAQUE
    HINST_COMMCTRL ) ],
  tooltip => [
qw( TTDT_AUTOMATIC TTDT_RESHOW TTDT_AUTOPOP TTDT_INITIAL TTF_IDISHWND TTF_CENTERTIP
    TTF_RTLREADING TTF_SUBCLASS TTF_TRACK TTF_ABSOLUTE TTF_TRANSPARENT TTF_PARSELINKS
    TTF_DI_SETITEM TTM_ACTIVATE TTM_SETDELAYTIME TTM_ADDTOOL TTM_DELTOOL TTM_NEWTOOLRECT
    TTM_RELAYEVENT TTM_GETTOOLINFO TTM_SETTOOLINFO TTM_HITTEST TTM_GETTEXT
    TTM_UPDATETIPTEXT TTM_GETTOOLCOUNT TTM_ENUMTOOLS TTM_GETCURRENTTOOL
    TTM_WINDOWFROMPOINT TTM_TRACKACTIVATE TTM_TRACKPOSITION TTM_SETTIPBKCOLOR
    TTM_SETTIPTEXTCOLOR TTM_GETDELAYTIME TTM_GETTIPBKCOLOR TTM_GETTIPTEXTCOLOR
    TTM_SETMAXTIPWIDTH TTM_GETMAXTIPWIDTH TTM_SETMARGIN TTM_GETMARGIN TTM_POP
    TTM_UPDATE TTM_GETBUBBLESIZE TTM_ADJUSTRECT TTM_SETTITLE TTN_GETDISPINFO
    TTN_NEEDTEXT TTN_SHOW TTN_POP ) ],
  treeview => [
qw( CLR_DEFAULT TVGN_PREVIOUS TVGN_DROPHILITE TVGN_PREVIOUSVISIBLE TVGN_CHILD TVGN_ROOT
    TVGN_NEXTVISIBLE TVGN_PARENT TVGN_LASTVISIBLE TVGN_FIRSTVISIBLE TVGN_NEXT
    TVGN_CARET TVHT_NOWHERE TVHT_ONITEMICON TVHT_ONITEMLABEL TVHT_ONITEM
    TVHT_ONITEMINDENT TVHT_ONITEMBUTTON TVHT_ONITEMRIGHT TVHT_ONITEMSTATEICON
    TVHT_ABOVE TVHT_BELOW TVHT_TORIGHT TVHT_TOLEFT ) ],
  updown => [ qw(  ) ],
  window => [
qw( DS_CENTERMOUSE DS_CENTER DS_FIXEDSYS DS_CONTROL DS_SETFOREGROUND
    DS_3DLOOK DS_NOIDLEMSG DS_SETFONT DS_LOCALEDIT DS_CONTEXTHELP DS_SHELLFONT
    DS_MODALFRAME DS_NOFAILCREATE DS_ABSALIGN DS_SYSMODAL IDYES IDABORT IDCONTINUE IDNO
    IDIGNORE IDTIMEOUT IDTRYAGAIN IDOK IDCLOSE IDHELP IDCANCEL IDRETRY MA_NOACTIVATE
    MA_NOACTIVATEANDEAT MA_ACTIVATEANDEAT MA_ACTIVATE MK_XBUTTON1 MK_LBUTTON MK_CONTROL
    MK_XBUTTON2 MK_RBUTTON MK_SHIFT MK_MBUTTON NM_RCLICK NM_RELEASEDCAPTURE NM_RDBLCLK
    NM_LDOWN NM_KILLFOCUS NM_TOOLTIPSCREATED NM_SETCURSOR NM_SETFOCUS NM_THEMECHANGED
    NM_OUTOFMEMORY NM_CUSTOMDRAW NM_CLICK NM_RDOWN NM_CHAR NM_HOVER NM_DBLCLK
    NM_NCHITTEST NM_RETURN NM_KEYDOWN RDW_NOINTERNALPAINT RDW_ERASENOW RDW_UPDATENOW
    RDW_NOCHILDREN RDW_NOFRAME RDW_VALIDATE RDW_ERASE RDW_INVALIDATE RDW_NOERASE
    RDW_FRAME RDW_INTERNALPAINT RDW_ALLCHILDREN SIZE_MAXIMIZED SIZE_RESTORED
    SIZE_MAXSHOW SIZE_MINIMIZED SIZE_MAXHIDE SW_SHOWNORMAL SW_HIDE SW_NORMAL
    SW_SHOWMINIMIZED SW_SHOWMAXIMIZED SW_SHOW SW_FORCEMINIMIZE SW_RESTORE SW_SHOWDEFAULT
    SW_MAXIMIZE SW_MINIMIZE SW_SHOWNOACTIVATE SW_SHOWMINNOACTIVE SW_SHOWNA WA_INACTIVE
    WA_ACTIVE WA_CLICKACTIVE WM_NCACTIVATE WM_SYSKEYUP WM_ERASEBKGND WM_CHANGEUISTATE
    WM_USERCHANGED WM_NOTIFYFORMAT WM_CHARTOITEM WM_MDIICONARRANGE WM_QUERYENDSESSION
    WM_APPCOMMAND WM_NCMOUSELEAVE WM_MOUSEMOVE WM_SETCURSOR WM_TIMER WM_WININICHANGE
    WM_MDINEXT WM_IME_CONTROL WM_COMPACTING WM_DRAWCLIPBOARD WM_FONTCHANGE WM_PRINTCLIENT
    WM_MDIMAXIMIZE WM_MDISETMENU WM_MDIREFRESHMENU WM_SHOWWINDOW WM_XBUTTONUP
    WM_SYSCOLORCHANGE WM_UNDO WM_CTLCOLORDLG WM_RBUTTONDBLCLK WM_INPUT WM_CTLCOLORSTATIC
    WM_MDICREATE WM_PAINTCLIPBOARD WM_CHILDACTIVATE WM_MEASUREITEM WM_DESTROY WM_NCCREATE
    WM_MOUSEFIRST WM_MOUSELAST WM_TABLET_LAST WM_QUIT WM_MENUCOMMAND
    WM_IME_STARTCOMPOSITION WM_MDIACTIVATE WM_SYSDEADCHAR WM_USER WM_SYNCPAINT
    WM_MOVING WM_NCMOUSEHOVER WM_KEYFIRST WM_MBUTTONDOWN WM_SYSCHAR WM_MBUTTONDBLCLK
    WM_CHANGECBCHAIN WM_PALETTECHANGED WM_GETTEXT WM_CLOSE WM_RENDERFORMAT WM_SETFONT
    WM_SIZING WM_RBUTTONUP WM_CTLCOLORBTN WM_INPUTLANGCHANGEREQUEST WM_CONTEXTMENU
    WM_WINDOWPOSCHANGING WM_CTLCOLORSCROLLBAR WM_KILLFOCUS WM_DROPFILES
    WM_WTSSESSION_CHANGE WM_MDIDESTROY WM_VSCROLLCLIPBOARD WM_NCHITTEST WM_ENDSESSION
    WM_IME_KEYLAST WM_HELP WM_TABLET_FIRST WM_IME_KEYDOWN WM_ACTIVATE WM_MOUSEHOVER
    WM_MOUSELEAVE WM_IME_CHAR WM_DISPLAYCHANGE WM_INPUTLANGCHANGE WM_NCLBUTTONUP
    WM_SETICON WM_NULL WM_AFXLAST WM_KEYUP WM_DELETEITEM WM_RENDERALLFORMATS
    WM_ICONERASEBKGND WM_MOUSEWHEEL WM_ACTIVATEAPP WM_NOTIFY WM_IME_COMPOSITION
    WM_THEMECHANGED WM_IME_COMPOSITIONFULL WM_SYSKEYDOWN WM_NCXBUTTONDBLCLK
    WM_XBUTTONDOWN WM_IME_SETCONTEXT WM_COMMAND WM_SIZE WM_LBUTTONDBLCLK WM_ENABLE
    WM_NEXTDLGCTL WM_MDITILE WM_KEYLAST WM_GETHOTKEY WM_CTLCOLOREDIT WM_PALETTEISCHANGING
    WM_DEVMODECHANGE WM_INITMENUPOPUP WM_WINDOWPOSCHANGED WM_SIZECLIPBOARD WM_INITDIALOG
    WM_PARENTNOTIFY WM_MDIGETACTIVE WM_QUEUESYNC WM_MOVE WM_DEADCHAR WM_NCLBUTTONDBLCLK
    WM_NCLBUTTONDOWN WM_MENUGETOBJECT WM_NCDESTROY WM_GETDLGCODE WM_HOTKEY
    WM_DESTROYCLIPBOARD WM_QUERYOPEN WM_IME_ENDCOMPOSITION WM_COPY WM_MENUCHAR
    WM_TIMECHANGE WM_IME_NOTIFY WM_HANDHELDFIRST WM_NCCALCSIZE WM_CTLCOLORMSGBOX
    WM_MENURBUTTONUP WM_LBUTTONUP WM_RBUTTONDOWN WM_EXITSIZEMOVE WM_SETTEXT WM_GETOBJECT
    WM_VKEYTOITEM WM_NCXBUTTONDOWN WM_EXITMENULOOP WM_SYSCOMMAND WM_COPYDATA WM_VSCROLL
    WM_LBUTTONDOWN WM_NEXTMENU WM_CLEAR WM_KEYDOWN WM_CUT WM_QUERYUISTATE
    WM_ASKCBFORMATNAME WM_QUERYDRAGICON WM_NCRBUTTONDBLCLK WM_PRINT WM_HSCROLLCLIPBOARD
    WM_CANCELJOURNAL WM_PENWINFIRST WM_MENUSELECT WM_UNINITMENUPOPUP WM_IME_SELECT
    WM_CREATE WM_UPDATEUISTATE WM_ENTERMENULOOP WM_SETREDRAW WM_PASTE WM_DRAWITEM
    WM_MOUSEACTIVATE WM_SETFOCUS WM_NCRBUTTONDOWN WM_ENTERSIZEMOVE WM_STYLECHANGING
    WM_INITMENU WM_CTLCOLORLISTBOX WM_GETICON WM_AFXFIRST WM_NCMOUSEMOVE WM_SETTINGCHANGE
    WM_STYLECHANGED WM_PAINT WM_NCMBUTTONUP WM_HSCROLL WM_XBUTTONDBLCLK
    WM_QUERYNEWPALETTE WM_MBUTTONUP WM_SETHOTKEY WM_APP WM_POWER WM_DEVICECHANGE WM_TCARD
    WM_GETMINMAXINFO WM_CANCELMODE WM_NCMBUTTONDOWN WM_GETFONT WM_POWERBROADCAST WM_CHAR
    WM_MDICASCADE WM_IME_KEYUP WM_COMPAREITEM WM_NCPAINT WM_NCMBUTTONDBLCLK
    WM_CAPTURECHANGED WM_UNICHAR WM_IME_REQUEST WM_NCXBUTTONUP WM_MENUDRAG
    WM_SPOOLERSTATUS WM_COMMNOTIFY WM_MDIRESTORE WM_PENWINLAST WM_NCRBUTTONUP
    WM_HANDHELDLAST WM_ENTERIDLE WM_PAINTICON WM_GETTEXTLENGTH WS_EX_TOPMOST
    WS_EX_ACCEPTFILES WS_CHILDWINDOW WS_EX_RIGHT WS_EX_LAYERED WS_EX_PALETTEWINDOW
    WS_EX_CLIENTEDGE WS_EX_WINDOWEDGE WS_EX_STATICEDGE WS_MAXIMIZE WS_EX_OVERLAPPEDWINDOW
    WS_TILEDWINDOW WS_EX_LEFT WS_CHILD WS_POPUP WS_TABSTOP WS_BORDER WS_CLIPSIBLINGS
    WS_HSCROLL WS_EX_TRANSPARENT WS_EX_LEFTSCROLLBAR WS_SYSMENU WS_DISABLED WS_TILED
    WS_CLIPCHILDREN WS_EX_CONTEXTHELP WS_EX_LAYOUTRTL WS_EX_NOINHERITLAYOUT
    WS_EX_APPWINDOW WS_CAPTION WS_EX_DLGMODALFRAME WS_MINIMIZEBOX WS_EX_CONTROLPARENT
    WS_VSCROLL WS_POPUPWINDOW WS_EX_TOOLWINDOW WS_EX_LTRREADING WS_VISIBLE
    WS_EX_COMPOSITED WS_EX_NOPARENTNOTIFY WS_EX_RIGHTSCROLLBAR WS_EX_RTLREADING
    WS_MAXIMIZEBOX WS_EX_NOACTIVATE WS_EX_MDICHILD WS_ICONIC WS_SIZEBOX
    WS_OVERLAPPEDWINDOW WS_THICKFRAME WS_DLGFRAME WS_OVERLAPPED WS_MINIMIZE WS_GROUP ) ],
);

require Win32::GUI::Constants::Tags;

for my $tag (@tags) {
	my @TAGS = @{Win32::GUI::Constants::Tags::tag($tag)};
	my @REQUIRED = @{$RESULTS{$tag}};

	#both lists the same size?
	ok(@TAGS == @REQUIRED, ":$tag is correct size");

	#both lists contain the same items?
	my %h;
	for my $item (@TAGS, @REQUIRED) {
		$h{$item}++;
	}
	my @errors;
	for my $item (keys %h) {
		next if $h{$item} == 2;
		push @errors, $item;
	}
	ok(!@errors, "Lists have no differing items (@errors)");
}
