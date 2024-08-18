| world factor initialSize initialScale |

world := UISupervisor ui.

Preferences at: #defaultFontSize put: 21.
Preferences at: #balloonHelpEnabled put: false.
Preferences at: #askConfirmationOnQuit put: false.
Preferences at: #biggerCursors put: false.
Preferences at: #caseSensitiveFinds put: true.
Preferences at: #debugLogTimestamp put: false.
Preferences at: #focusFollowsMouse put: false.
Preferences at: #saveReleaseOptionsInWorldMenu put: true.
Preferences at: #transcriptLogVerbose put: false.
Preferences at: #highlightBlockNesting put: false.

"Not correct way to do this - DisplayScreen not accurage until whenUiInSafeState.
 But, can only go full screen here and have the area be accurate in method below."
 
initialSize := (DisplayScreen actualScreenSize x).
initialScale :=  (DisplayScreen hostOSScaleFactor).
factor := initialSize / initialScale.

(factor > 800.0)
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

        Transcript show: initialSize; cr.
        Transcript show: initialScale; cr.
        Transcript show: factor asString; cr.

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
