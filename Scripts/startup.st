"This is set up for my personal system - a 27 inch Mac that 
 should display Cuis in a Window occupying the left half of 
 the screen; and a 14 Windows laptop that should have
 Cuis run as full screen.  Change to suit your own needs."

| world codeFont titleFont fontSize |

world := UISupervisor ui.

fontSize := 21.
titleSize := 18.

Preferences at: #defaultFontSize put: fontSize.
Preferences at: #balloonHelpEnabled put: false.
Preferences at: #askConfirmationOnQuit put: false.
Preferences at: #biggerCursors put: false.
Preferences at: #caseSensitiveFinds put: true.
Preferences at: #debugLogTimestamp put: false.
Preferences at: #focusFollowsMouse put: false.
Preferences at: #saveReleaseOptionsInWorldMenu put: false.
Preferences at: #transcriptLogVerbose put: false.
Preferences at: #highlightBlockNesting put: false.

TrueTypeFontFamily readAllTrueTypeFontsIn: DirectoryEntry trueTypeFontsDirectory / 'DejaVu' /  'DejaVuMono'.

codeFont := FontFamily familyName: 'DejaVu Sans Mono' pointSize: fontSize.

Preferences at: #standardCodeFont put: codeFont.

titleFont := FontFamily familyName: 'DejaVu Sans' pointSize:  titleSize.

Preferences at: #windowTitleFont put: titleFont.
Preferences at: #standardButtonFont put: titleFont.

"standardCodeFont = AbstractFont::TrueTypeFont('DejaVu Sans' 21)"
"standardListFont"
"standardMenuFont"
"standardButtonFont"
"windowTitleFont = AbstractFont::TrueTypeFont('DejaVu Sans' 25)"

(Smalltalk platformName = 'Mac OS')
    ifTrue: [
        Display fullScreenMode: false.
        DisplayScreen hostOSWindowTitle: 'Grey Smalltalk'.
        DisplayScreen hostOSWindowPosition: 0 @ 0.
        DisplayScreen hostOSWindowExtent: 3100 @ 2800.
    ]
    ifFalse: [
        Display fullScreenMode: true.
    ].



[
    UISupervisor whenUIinSafeState: [
        | area extent |

        world submorphs do: [:child | child delete].

        area := RealEstateAgent maximumUsableArea.
        extent := area extent // 2.

        Workspace open
            morphPosition: 0 @ (extent y);
            morphExtent:   (extent x) * 0.7 @ ((extent y) // 2).
        Transcript open
            morphPosition: 0 @ ((extent y) + ((extent y) // 2));
            morphExtent:   (extent x) * 0.7 @ ((extent y) // 2).
        Browser open
            morphPosition: (extent x) * 0.7 @ 0;
            morphExtent:   (extent x) * 1.3 @ ((extent y) * 2).

        Transcript show: (area asString); cr.
        Transcript show: (extent asString); cr.
    ]
] fork.
