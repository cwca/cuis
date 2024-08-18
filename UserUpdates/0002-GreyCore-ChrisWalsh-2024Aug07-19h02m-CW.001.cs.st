'From Cuis7.1 [latest update: #6541] on 7 August 2024 at 7:42:21 pm'!
"Change Set:		0002-GreyCore-ChrisWalsh-2024Aug07-19h02m
Date:			7 August 2024
Author:			Chris Walsh

Added Unicode versions for == ≡, ~~ ≢, ~= ≠, <= ≤, >= ≥, * ⋅ ×, / ÷"!


!ProtoObject methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:02:00'!
≡ anObject 
	"Primitive. Answer whether the receiver and the argument are the same 
	object (have the same object pointer). Do not redefine the message == in 
	any other class!! Essential. No Lookup. Do not override in any subclass. 
	See Object documentation whatIsAPrimitive."

	<primitive: 110>
	self primitiveFailed! !

!ProtoObject methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:02:15'!
≢ anObject
	"Answer whether the receiver and the argument are not the same object 
	(do not have the same object pointer)."

	self == anObject
		ifTrue: [^ false]
		ifFalse: [^ true]! !


!Object methodsFor: 'associating' stamp: 'CW 8/7/2024 19:02:44'!
→ anObject
	"Answer an Association between self and anObject"

	^Association key: self value: anObject! !

!Object methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:03:03'!
≠ anObject 
	"Answer true if the receiver and the argument do not represent the same 
	object and false otherwise."

	^self = anObject ≡ false! !


!Collection methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:14:59'!
× arg

	^ arg adaptToCollection: self andSend: #×! !

!Collection methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:15:15'!
÷ arg

	^ arg adaptToCollection: self andSend: #÷! !


!FloatArray methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:15:49'!
× anObject

	^self copy *= anObject! !

!FloatArray methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:16:06'!
×= anObject
	^anObject isNumber
		ifTrue:[self primMulScalar: anObject asFloat]
		ifFalse:[self primMulArray: anObject]! !

!FloatArray methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:16:21'!
÷ anObject

	^self copy /= anObject! !

!FloatArray methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:16:28'!
÷= anObject

	^self divideBy: anObject
		ifDivisorZero: [ZeroDivide new signalReceiver: self selector: #/= argument: anObject]
		ifBothZero: [ZeroDivide new signalReceiver: self selector: #/= argument: anObject]! !

!FloatArray methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:15:57'!
⋅ anObject

	^self copy *= anObject! !

!FloatArray methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:16:14'!
⋅= anObject
	^anObject isNumber
		ifTrue:[self primMulScalar: anObject asFloat]
		ifFalse:[self primMulArray: anObject]! !


!CharacterSequence methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:14:14'!
≤ another
	"Answer whether the receiver sorts after aString.
	The collation order is case sensitive."
	"Reduce all cases to #< and #= to simplify code."

	"Comparing for equality may is faster in most casts. Try it first."
	self = another ifTrue: [ ^true ].

	^self < another.! !

!CharacterSequence methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:14:20'!
≥ another
	"Answer whether the receiver sorts after or equal to aString.
	The collation order is case sensitive."
	"Reduce all cases to #< and #= to simplify code."

	^(self < another) not.! !

!CharacterSequence methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:13:50'!
× arg

	self shouldNotImplement.! !

!CharacterSequence methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:14:07'!
÷ arg
	"If working with file paths, just use $/
	Or better yet, use DirectoryEntry protocol"

	self shouldNotImplement! !

!CharacterSequence methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:13:58'!
⋅ arg

	self shouldNotImplement.! !


!Point methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:25:37'!
× arg 
	"Answer a Point that is the product of the receiver and arg."

	arg isPoint ifTrue: [^ (x * arg x) @ (y * arg y)].
	^ arg adaptToPoint: self andSend: #*! !

!Point methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:25:51'!
÷ arg 
	"Answer a Point that is the quotient of the receiver and arg."

	arg isPoint ifTrue: [^ (x / arg x) @ (y / arg y)].
	^ arg adaptToPoint: self andSend: #/! !

!Point methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:25:43'!
⋅ arg 
	"Answer a Point that is the product of the receiver and arg."

	arg isPoint ifTrue: [^ (x * arg x) @ (y * arg y)].
	^ arg adaptToPoint: self andSend: #*! !

!Point methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:25:58'!
≤ aPoint 
	"Answer whether the receiver is 'neither below nor to the right' of aPoint."

	^x <= aPoint x and: [y <= aPoint y]! !

!Point methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:26:07'!
≥ aPoint 
	"Answer whether the receiver is 'neither above nor to the left' of aPoint."

	^x >= aPoint x and: [y >= aPoint y]! !


!CharacterBlock methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:26:24'!
≤ aCharacterBlock 
	"Answer whether the string index of the receiver does not come after that of
	aCharacterBlock."
	^(self > aCharacterBlock) not! !

!CharacterBlock methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:26:31'!
≥ aCharacterBlock 
	"Answer whether the string index of the receiver does not precede that of
	aCharacterBlock."
	^(self < aCharacterBlock) not! !


!Boolean methodsFor: 'logical operations' stamp: 'CW 8/7/2024 19:03:38'!
∧ aBoolean 
	"Evaluating conjunction -- Evaluate the argument.  Then answer true if both the
	receiver and the argument are true."
	self subclassResponsibility! !

!Boolean methodsFor: 'logical operations' stamp: 'CW 8/7/2024 19:03:47'!
∨ aBoolean 
	"Evaluating disjunction (OR) -- Evaluate the argument.  Then answer true if
	either the receiver or the argument is true."
	self subclassResponsibility! !


!False methodsFor: 'logical operations' stamp: 'CW 8/7/2024 19:04:03'!
∧ alternativeObject 
	"Evaluating conjunction -- answer false since receiver is false."

	^self! !

!False methodsFor: 'logical operations' stamp: 'CW 8/7/2024 19:04:11'!
∨ aBoolean 
	"Evaluating disjunction (OR) -- answer with the argument, aBoolean."

	^aBoolean! !


!True methodsFor: 'logical operations' stamp: 'CW 8/7/2024 19:04:20'!
∧ alternativeObject 
	"Evaluating conjunction -- answer alternativeObject since receiver is true."

	^alternativeObject! !

!True methodsFor: 'logical operations' stamp: 'CW 8/7/2024 19:04:27'!
∨ aBoolean 
	"Evaluating disjunction (OR) -- answer true since the receiver is true."

	^self! !


!Magnitude methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:04:45'!
≤ aMagnitude 
	"Compare the receiver with the argument and answer with true if the 
	receiver is less than or equal to the argument. Otherwise answer false."

	^(self > aMagnitude) not! !

!Magnitude methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:04:54'!
≥ aMagnitude 
	"Answer whether the receiver is greater than or equal to the argument."

	^aMagnitude <= self! !


!Duration methodsFor: 'ansi protocol' stamp: 'CW 8/7/2024 19:11:16'!
× operand
	"operand is a Number" 	^ self class nanoSeconds: ( (self totalNanoSeconds * operand) asInteger).
! !

!Duration methodsFor: 'ansi protocol' stamp: 'CW 8/7/2024 19:11:32'!
÷ operand

	"operand is a Duration or a Number"


	^ operand isNumber
		ifTrue: [ self class nanoSeconds: (self totalNanoSeconds / operand) asInteger ]
		ifFalse: [
			self assert: operand class == Duration.
			self totalNanoSeconds / operand totalNanoSeconds ]
.
! !

!Duration methodsFor: 'ansi protocol' stamp: 'CW 8/7/2024 19:11:24'!
⋅ operand
	"operand is a Number" 	^ self class nanoSeconds: ( (self totalNanoSeconds * operand) asInteger).
! !


!Number methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:05:05'!
× aNumber 
	"Answer the result of multiplying the receiver by aNumber."
	self subclassResponsibility! !

!Number methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:05:20'!
÷ aNumber 
	"Answer the result of dividing receiver by aNumber."
	self subclassResponsibility! !

!Number methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:05:12'!
⋅ aNumber 
	"Answer the result of multiplying the receiver by aNumber."
	self subclassResponsibility! !


!BoxedFloat64 methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:06:07'!
× aNumber 
	"Primitive. Answer the result of multiplying the receiver by aNumber.
	Fail if the argument is not a Float. Essential. See Object documentation
	whatIsAPrimitive."

	<primitive: 49>
	^ aNumber adaptToFloat: self andSend: #*! !

!BoxedFloat64 methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:06:15'!
⋅ aNumber 
	"Primitive. Answer the result of multiplying the receiver by aNumber.
	Fail if the argument is not a Float. Essential. See Object documentation
	whatIsAPrimitive."

	<primitive: 49>
	^ aNumber adaptToFloat: self andSend: #*! !

!BoxedFloat64 methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:06:39'!
≠ aNumber 
	"Primitive. Compare the receiver with the argument and return true
	if the receiver is not equal to the argument. Otherwise return false.
	Fail if the argument is not a Float. Optional. See Object documentation
	whatIsAPrimitive."

	<primitive: 48>
	^super ~= aNumber! !

!BoxedFloat64 methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:06:22'!
≤ aNumber 
	"Primitive. Compare the receiver with the argument and return true
	if the receiver is less than or equal to the argument. Otherwise return
	false. Fail if the argument is not a Float. Optional. See Object
	documentation whatIsAPrimitive."

	<primitive: 45>
	^ aNumber adaptToFloat: self andSend: #<=! !

!BoxedFloat64 methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:06:33'!
≥ aNumber 
	"Primitive. Compare the receiver with the argument and return true
	if the receiver is greater than or equal to the argument. Otherwise return
	false. Fail if the argument is not a Float. Optional. See Object documentation 
	whatIsAPrimitive. "

	<primitive: 46>
	^ aNumber adaptToFloat: self andSend: #>=! !


!SmallFloat64 methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:06:53'!
× aNumber 
	"Primitive. Answer the result of multiplying the receiver by aNumber.
	Fail if the argument is not a Float. Essential. See Object documentation
	whatIsAPrimitive."

	<primitive: 549>
	^ aNumber adaptToFloat: self andSend: #*! !

!SmallFloat64 methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:07:06'!
÷ aNumber 
	"Primitive. Answer the result of dividing receiver by aNumber.
	Fail if the argument is not a Float.
	Essential. See Object clas >> whatIsAPrimitive."

	<primitive: 550>
	aNumber isZero ifTrue: [^ZeroDivide new signalReceiver: self selector: #/ argument: aNumber ].
	^ aNumber adaptToFloat: self andSend: #/! !

!SmallFloat64 methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:07:00'!
⋅ aNumber 
	"Primitive. Answer the result of multiplying the receiver by aNumber.
	Fail if the argument is not a Float. Essential. See Object documentation
	whatIsAPrimitive."

	<primitive: 549>
	^ aNumber adaptToFloat: self andSend: #*! !

!SmallFloat64 methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:07:27'!
≠ aNumber 
	"Primitive. Compare the receiver with the argument and return true
	if the receiver is not equal to the argument. Otherwise return false.
	Fail if the argument is not a Float. Optional. See Object documentation
	whatIsAPrimitive."

	<primitive: 548>
	^super ~= aNumber! !

!SmallFloat64 methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:07:13'!
≤ aNumber 
	"Primitive. Compare the receiver with the argument and return true
	if the receiver is less than or equal to the argument. Otherwise return
	false. Fail if the argument is not a Float. Optional. See Object
	documentation whatIsAPrimitive."

	<primitive: 545>
	^ aNumber adaptToFloat: self andSend: #<=! !

!SmallFloat64 methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:07:20'!
≥ aNumber 
	"Primitive. Compare the receiver with the argument and return true
	if the receiver is greater than or equal to the argument. Otherwise return
	false. Fail if the argument is not a Float. Optional. See Object documentation 
	whatIsAPrimitive. "

	<primitive: 546>
	^ aNumber adaptToFloat: self andSend: #>=! !


!Fraction methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:07:45'!
× aNumber 
	"Answer the result of multiplying the receiver by aNumber."
	| d1 d2 |
	aNumber isFraction ifTrue: 
		[d1 := numerator gcd: aNumber denominator.
		d2 := denominator gcd: aNumber numerator.
		(d2 = denominator and: [d1 = aNumber denominator])
			ifTrue: [^ numerator // d1 * (aNumber numerator // d2)].
		^ Fraction numerator: numerator // d1 * (aNumber numerator // d2)
				denominator: denominator // d2 * (aNumber denominator // d1)].
	^ aNumber adaptToFraction: self andSend: #*! !

!Fraction methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:07:58'!
÷ aNumber
	"Answer the result of dividing the receiver by aNumber."
	aNumber isFraction
		ifTrue: [^self * aNumber reciprocal].
	^ aNumber adaptToFraction: self andSend: #/! !

!Fraction methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:07:52'!
⋅ aNumber 
	"Answer the result of multiplying the receiver by aNumber."
	| d1 d2 |
	aNumber isFraction ifTrue: 
		[d1 := numerator gcd: aNumber denominator.
		d2 := denominator gcd: aNumber numerator.
		(d2 = denominator and: [d1 = aNumber denominator])
			ifTrue: [^ numerator // d1 * (aNumber numerator // d2)].
		^ Fraction numerator: numerator // d1 * (aNumber numerator // d2)
				denominator: denominator // d2 * (aNumber denominator // d1)].
	^ aNumber adaptToFraction: self andSend: #*! !

!Fraction methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:08:05'!
≤ aNumber
	aNumber isFraction ifTrue:
		[^ numerator * aNumber denominator <= (aNumber numerator * denominator)].
	^ aNumber adaptToFraction: self andSend: #<=! !


!Integer methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:08:36'!
× aNumber
	"Refer to the comment in Number * " 
	aNumber isInteger ifTrue: [
		^ self
			digitMultiply: aNumber
			neg: (self negative xor: aNumber negative) ].
	^ aNumber adaptToInteger: self andSend: #*! !

!Integer methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:08:49'!
÷ aNumber
	"Refer to the comment in Number / "
	| quoRem |
	aNumber isInteger ifTrue:
		[quoRem := self digitDiv: aNumber abs	"*****I've added abs here*****"
						neg: self negative ~= aNumber negative.
		(quoRem at: 2) = 0
			ifTrue: [^ (quoRem at: 1) normalize]
			ifFalse: [^ (Fraction numerator: self denominator: aNumber) reduced]].
	^ aNumber adaptToInteger: self andSend: #/! !

!Integer methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:08:43'!
⋅ aNumber
	"Refer to the comment in Number * " 
	aNumber isInteger ifTrue: [
		^ self
			digitMultiply: aNumber
			neg: (self negative xor: aNumber negative) ].
	^ aNumber adaptToInteger: self andSend: #*! !

!Integer methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:08:57'!
≤ aNumber
	aNumber isInteger ifTrue:
		[self negative == aNumber negative
			ifTrue: [self negative
						ifTrue: [^ (self digitCompare: aNumber) >= 0]
						ifFalse: [^ (self digitCompare: aNumber) <= 0]]
			ifFalse: [^ self negative]].
	^ aNumber adaptToInteger: self andSend: #<=! !

!Integer methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:09:04'!
≥ aNumber
	aNumber isInteger ifTrue:
		[self negative == aNumber negative
			ifTrue: [self negative
						ifTrue: [^(self digitCompare: aNumber) <= 0]
						ifFalse: [^(self digitCompare: aNumber) >= 0]]
			ifFalse: [^ aNumber negative]].
	^ aNumber adaptToInteger: self andSend: #>=! !


!LargePositiveInteger methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:09:41'!
× anInteger
	"Primitive is optional.
	See Object class >>  #whatIsAPrimitive. "

	<primitive: 29>
	^super * anInteger.! !

!LargePositiveInteger methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:09:54'!
÷ anInteger
	"Primitive is optional.
	See Object class >>  #whatIsAPrimitive. "

	<primitive: 30>
	^super / anInteger.! !

!LargePositiveInteger methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:09:48'!
⋅ anInteger
	"Primitive is optional.
	See Object class >>  #whatIsAPrimitive. "

	<primitive: 29>
	^super * anInteger.! !

!LargePositiveInteger methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:10:00'!
≤ anInteger
	"Primitive is optional.
	See Object class >>  #whatIsAPrimitive. "

	<primitive: 25>
	^super <= anInteger.! !

!LargePositiveInteger methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:10:06'!
≥ anInteger
	"Primitive is optional.
	See Object class >>  #whatIsAPrimitive. "

	<primitive: 26>
	^super >= anInteger.! !


!SmallInteger methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:10:20'!
× aNumber 
	"Primitive. Multiply the receiver by the argument and answer with the
	result if it is a SmallInteger. Fail if the argument or the result is not a
	SmallInteger. Essential. No Lookup. See Object documentation whatIsAPrimitive."

	<primitive: 9>
	^ super * aNumber! !

!SmallInteger methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:10:34'!
÷ aNumber 
	"Primitive. This primitive (for /) divides the receiver by the argument
	and returns the result if the division is exact. Fail if the result is not a
	whole integer. Fail if the argument is 0 or is not a SmallInteger. Optional.
	No Lookup. See Object documentation whatIsAPrimitive."

	<primitive: 10>
	aNumber isZero ifTrue: [^ZeroDivide new signalReceiver: self selector: #/ argument: aNumber ].
	^(aNumber isMemberOf: SmallInteger)
		ifTrue: [(Fraction numerator: self denominator: aNumber) reduced]
		ifFalse: [super / aNumber]! !

!SmallInteger methodsFor: 'arithmetic' stamp: 'CW 8/7/2024 19:10:26'!
⋅ aNumber 
	"Primitive. Multiply the receiver by the argument and answer with the
	result if it is a SmallInteger. Fail if the argument or the result is not a
	SmallInteger. Essential. No Lookup. See Object documentation whatIsAPrimitive."

	<primitive: 9>
	^ super * aNumber! !

!SmallInteger methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:10:53'!
≠ aNumber 
	"Compare the receiver with the argument and answer true if the receiver is not 
	equal to the argument.  Otherwise answer false.  Fail if the argument is not a 
	SmallInteger.  Essential.  No Lookup.  See Object documentation 
	whatIsAPrimitive. "

	<primitive: 8>
	^super ~= aNumber! !

!SmallInteger methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:10:41'!
≤ aNumber 
	"Compare the receiver with the argument and answer true if the receiver is less 
	than or equal to the argument.  Otherwise answer false.  Fail if the argument is 
	not a SmallInteger.  Optional.  No Lookup.  See Object documentation 
	whatIsAPrimitive. "

	<primitive: 5>
	^super <= aNumber! !

!SmallInteger methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:10:46'!
≥ aNumber 
	"Compare the receiver with the argument and answer true if the receiver is 
	greater than or equal to the argument.  Otherwise answer false.  Fail if the 
	argument is not a SmallInteger.  Optional.  No Lookup.  See Object 
	documentation whatIsAPrimitive."

	<primitive: 6>
	^super >= aNumber! !


!Color methodsFor: 'transformations' stamp: 'CW 8/7/2024 19:24:55'!
× aNumberOrColor
	"Answer this color with its RGB multiplied by the given number. "
	"
	(Color brown *2) display
	"
	(aNumberOrColor is: #Color) ifTrue: [
		^ (Color new
			setRed: (self red * aNumberOrColor red min: 1.0 max: 0.0)
			green: (self green * aNumberOrColor green min: 1.0 max: 0.0)
			blue: (self blue * aNumberOrColor blue min: 1.0 max: 0.0))
				alpha: self alpha * aNumberOrColor alpha
		].
	^ (Color new
		setRed: (self red * aNumberOrColor min: 1.0 max: 0.0)
		green: (self green * aNumberOrColor min: 1.0 max: 0.0)
		blue: (self blue * aNumberOrColor min: 1.0 max: 0.0))
			alpha: self alpha! !

!Color methodsFor: 'transformations' stamp: 'CW 8/7/2024 19:25:09'!
÷ aNumberOrColor
	"Answer this color with its RGB divided by the given number. "
	"
	(Color red / 2) display
	"
	(aNumberOrColor is: #Color) ifTrue: [
		^ Color new
			setRed: (self red / aNumberOrColor red min: 1.0 max: 0.0)
			green: (self green / aNumberOrColor green min: 1.0 max: 0.0)
			blue: (self blue / aNumberOrColor blue min: 1.0 max: 0.0)
		].
	^ Color new
		setRed: (self red / aNumberOrColor min: 1.0 max: 0.0)
		green: (self green / aNumberOrColor min: 1.0 max: 0.0)
		blue: (self blue / aNumberOrColor min: 1.0 max: 0.0)! !

!Color methodsFor: 'transformations' stamp: 'CW 8/7/2024 19:25:02'!
⋅ aNumberOrColor
	"Answer this color with its RGB multiplied by the given number. "
	"
	(Color brown *2) display
	"
	(aNumberOrColor is: #Color) ifTrue: [
		^ (Color new
			setRed: (self red * aNumberOrColor red min: 1.0 max: 0.0)
			green: (self green * aNumberOrColor green min: 1.0 max: 0.0)
			blue: (self blue * aNumberOrColor blue min: 1.0 max: 0.0))
				alpha: self alpha * aNumberOrColor alpha
		].
	^ (Color new
		setRed: (self red * aNumberOrColor min: 1.0 max: 0.0)
		green: (self green * aNumberOrColor min: 1.0 max: 0.0)
		blue: (self blue * aNumberOrColor min: 1.0 max: 0.0))
			alpha: self alpha! !


!Character methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:12:33'!
≤ aCharacter
	"Answer whether the receiver is less than or equal to the argument."
	"Reduce all cases to #< and #= to simplify code."

	self == aCharacter ifTrue: [ ^true ].
	^self < aCharacter.! !

!Character methodsFor: 'comparing' stamp: 'CW 8/7/2024 19:12:39'!
≥ aCharacter
	"Answer whether the receiver is greater than or equal to the argument."
	"Reduce all cases to #< and #= to simplify code."

	^(self < aCharacter) not.! !


!MethodReference methodsFor: 'comparisons' stamp: 'CW 8/7/2024 19:31:52'!
≤ anotherMethodReference
	"By default, sort by class"

	^self classSymbol = anotherMethodReference classSymbol
		ifTrue: [
			self methodSymbol == #Comment
				ifTrue: [ true ]
				ifFalse: [
					anotherMethodReference methodSymbol == #Comment
						ifTrue: [ false ]
						ifFalse: [
							self classIsMeta = anotherMethodReference classIsMeta
								ifTrue: [ self methodSymbol < anotherMethodReference methodSymbol ]
								ifFalse: [ self classIsMeta ]	]]]
		ifFalse: [ self classSymbol < anotherMethodReference classSymbol ]! !


!SequenceDifference methodsFor: 'testing' stamp: 'CW 8/7/2024 19:34:43'!
≤ sequence
	^lcs size <= sequence lcsSize
! !

