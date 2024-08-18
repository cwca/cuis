'From Cuis7.1 [latest update: #6541] on 7 August 2024 at 10:08:19 am'!
"Change Set:		6542-CuisCore-ChrisWalsh-2024Aug07-08h49m
Date:			7 August 2024
Author:			Chris Walsh

Modified editor input for second cord unicode entry using the single quote character, selected unicode characters for language extension"!

!classDefinition: 'Editor class' category: #'System-Text'!
Editor class
	instanceVariableNames: 'shortcuts cmdShortcuts secondChord '!

!Editor class methodsFor: 'accessing' stamp: 'CW 8/7/2024 08:50:20'!
secondChord
	
	secondChord ifNil: [ secondChord := false ].
	
	^secondChord! !

!Editor class methodsFor: 'accessing' stamp: 'CW 8/7/2024 08:50:32'!
secondChord: aBool

	secondChord := aBool.! !


!Editor methodsFor: 'typing/selecting keys' stamp: 'CW 8/7/2024 09:56:22'!
normalCharacter: aKeyboardEvent 
	"A nonspecial character is to be added to the stream of characters."

	| character i replacement |
	
	character := aKeyboardEvent keyCharacter.
	
	(self class secondChord) ifTrue: [
		replacement := character caseOf: {
		
			[ `Character codePoint: 16r0060` ] -> [ $₀ ]. 
			[ $~ ] -> [ $≈ ].
			
			[ $1 ] -> [ $‡ ].
			[ $!! ] -> [ $₁ ].
			
			[ $2 ] -> [ $ℕ ].
			[ $@ ] -> [ $₂ ].
			
			[ $3 ] -> [ $ℤ ].
			[ $# ] -> [ $‹ ].
			
			[ $4 ] -> [ $ℚ ].
			[ $$ ] -> [ $› ].
			
			[ $5 ] -> [ $ℝ ].
			[ $% ] -> [ $⟃ ].
			
			[ $6 ] -> [ $ℂ ].
			[ $^ ] -> [ $△ ].
			
			[ $7 ] -> [ $𝕌 ].
			[ $& ] -> [ $▽ ].
			
			[ $8 ] -> [ $⋅ ].
			[ $* ] -> [ $× ].
			
			[ $9 ] -> [ $“ ].
			[ `Character codePoint: 16r0028` ] -> [ $‘ ].  
			
			[ $0 ] -> [ $” ].
			[ `Character codePoint: 16r0029` ] -> [ $’ ].  
			
			[ `Character codePoint: 16r002D` ] -> [ $⌻ ].  
			[ `Character codePoint: 16r005F` ] -> [ $⎕ ]. 
			
			[ `Character codePoint: 16r003D` ] -> [ $≠ ].  
			[ `Character codePoint: 16r002B` ] -> [ $± ].  
			
			
			[ $q ] -> [ $∊ ].
			[ $Q ] -> [ $∍ ].
			
			[ $w ] -> [ $∈ ].
			[ $W ] -> [ $∉ ].
			
			[ $e ] -> [ $∋ ].
			[ $E ] -> [ $∌ ].
			
			[ $r ] -> [ $r ].
			[ $R ] -> [ $√ ].
			
			[ $t ] -> [ $ƭ ].
			[ $T ] -> [ $T ].
			
			[ $y ] -> [ $⟨ ].
			[ $Y ] -> [ $⟩ ].
			
			[ $u ] -> [ $≡ ].
			[ $U ] -> [ $≢ ].
			
			[ $i ] -> [ $i ].
			[ $I ] -> [ $∫ ].
			
			[ $o ] -> [ $∨ ].
			[ $O ] -> [ $↺ ].
			
			[ $p ] -> [ $ƥ ].
			[ $P ] -> [ $π ].
			
			[ `Character codePoint: 16r005B` ] -> [ $❲ ]. 
			[ `Character codePoint: 16r007B` ] -> [ $⟅ ].  
			
			[ `Character codePoint: 16r005D` ] -> [ $❳ ].  
			[ `Character codePoint: 16r007D` ] -> [ $⟆ ].  
			
			[ `Character codePoint: 16r005C` ] -> [ $« ].  
			[ `Character codePoint: 16r007C` ] -> [ $» ].  
			
			
			[ $a ] -> [ $∧ ].
			[ $A ] -> [ $A ].
			
			[ $s ] -> [ $s ].
			[ $S ] -> [ $S ].
			
			[ $d ] -> [ $∂ ].
			[ $D ] -> [ $° ].
			
			[ $f ] -> [ $ƒ ].
			[ $F ] -> [ $Ƒ ].
			
			[ $g ] -> [ $∩ ].
			[ $G ] -> [ $∪ ].
			
			[ $h ] -> [ $⊂ ].
			[ $H ] -> [ $⊆ ].
			
			[ $j ] -> [ $⌜ ].
			[ $J ] -> [ $⌝ ].
			
			[ $k ] -> [ $⌞ ].
			[ $K ] -> [ $⌟ ].
			
			[ $l ] -> [ $λ ].
			[ $L ] -> [ $⊃ ].
			
			"[ `Character codePoint: 16r003B` ] -> [ `Character codePoint: 16r2190` ]."
			[ `Character codePoint: 16r003A` ] -> [ $→ ]. 
			
			[ `Character codePoint: 16r0027` ] -> [ $' ]. 
			[ `Character codePoint: 16r0022` ] -> [ `Character codePoint: 16r2191` ]. 
			
			
			[ $z ] -> [ $α ].
			[ $Z ] -> [ $ω ].
			
			[ $x ] -> [ $⦻ ].
			[ $X ] -> [ $ₓ ].
			
			[ $c ] -> [ $◦ ].
			[ $C ] -> [ $⦾ ].
			
			[ $v ] -> [ $• ].
			[ $V ] -> [ $⦿ ].
			
			[ $b ] -> [ $⊤ ].
			[ $B ] -> [ $⊥ ].
			
			[ $n ] -> [ $¬ ].
			[ $N ] -> [ $∅ ].
			
			[ $m ] -> [ $ɱ ].
			[ $M ] -> [ $µ ].
			
			[ `Character codePoint: 16r002C` ] -> [ $… ].
			[ $< ] -> [ $≤ ].
			
			[ `Character codePoint: 16r002E` ] -> [ $‥ ].
			[ $> ] -> [ $≥ ].
			
			[ `Character codePoint: 16r002F` ] -> [ $÷ ].
			"[ `Character codePoint: 16r003F` ] -> [ `Character codePoint: 16r235D` ]."
			
		} otherwise: [ character ].
		character := replacement.
		self class secondChord: false.
	] ifFalse: [
		(character = $') ifTrue: [
				self class secondChord: true.
				^ false.
		]
	].

	"Convert strings like '\+161 ' (š) to unicode"
	
	aKeyboardEvent isSpace ifTrue: [ | string |
		string := self privateCurrentString.
		self pointIndex - 1 to: (self pointIndex - 7 max: 1) by: -1 do: [ :index |
		(string at: index) = $\ ifTrue: [ | key |
			key := string copyFrom: index + 1 to: self pointIndex - 1.
			(key size > 2 and: [ (key at: 1) = $+ ])
				ifTrue: [ | stream number value |
					stream := ReadStream on: key asUppercase from: 2 to: key size.
					[ number := Integer readFrom: stream  base: 16 ] on: Error do: [ ^ false ].
					value := Character codePoint: number.
					self
						selectFrom: index to: self pointIndex - 1;
						replaceSelectionWith: (UnicodeString with: value).
						^ false ] ] ] ].
	
	"Linux VMs don't automatically replace combining marks + space with ASCII,
	as Windows and Mac VMs do. It seems it is an app responsability to do that in Linux."
	
	character isDiacriticalMark ifTrue: [
		i := self pointIndex-1.
		(i > 0 and: [ (self privateCurrentString at: i) = $  ]) ifTrue: [
			replacement := character caseOf: {
				[ `Character codePoint: 16r300` ] -> [ '`' ].
				[ `Character codePoint: 16r301` ] -> [ '''' ].
				[ `Character codePoint: 16r302` ] -> [ '^' ].
				[ `Character codePoint: 16r303` ] -> [ '~' ].
				[ `Character codePoint: 16r308` ] -> [ '"' ].
			} otherwise: [].
			replacement notNil ifTrue: [
				self selectFrom: i to: i; replaceSelectionWith: replacement.
				^ false ]
			]
		].
	self addString: (UnicodeString with: character).
	^false! !

!classDefinition: 'Editor class' category: #'System-Text'!
Editor class
	instanceVariableNames: 'shortcuts cmdShortcuts secondChord'!

!Editor class reorganize!
('class initialization' basicInitialize collectCmdShortcutsSpecUsing: initialize initializeCmdShortcuts initializeShortcuts putIntoCmdShortcuts:)
('keyboard shortcut tables' allCmdShortcutsSpec allShiftShortcutsSpec basicCmdShortcutsSpec cmdShortcuts cmdShortcutsSpec shiftShortcutsSpec shortcuts)
('help' formatShortcutsUsingModifierKey:andSpecs: help)
('cached state access' releaseClassCachedState)
('accessing' secondChord secondChord:)
!

