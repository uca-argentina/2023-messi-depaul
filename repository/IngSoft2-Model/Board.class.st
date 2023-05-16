Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'amountOfCells',
		'rounds',
		'parsecs',
		'cellsEffects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> of: anAmountOfCells with: anAmountOfRounds and: anAmountOfParsecs [ 
	^ (self new) initializeOf: anAmountOfCells with: anAmountOfRounds and: anAmountOfParsecs.
]

{ #category : #'instance variable' }
Board >> cellsEffect [
	^cellsEffects.
]

{ #category : #action }
Board >> hyperJumpEffectRandom [

	|aSequence |
	aSequence := (1 to: 10) collect: [ :i | 100].
	aSequence sort reverse.
	^(HyperJumpEffect with: aSequence).

	
]

{ #category : #action }
Board >> initializeCells [
	
	1 to: amountOfCells do: [ :index | 
		| aNumber |
		aNumber := 100 atRandom.
		(aNumber > 0 and: aNumber < 40) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: NoEffect new)].
		(aNumber > 40 and: aNumber < 60) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: WormHoleEffect new)].
		(aNumber > 60 and: aNumber < 80) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: SpeedUpEffect new)].
		(aNumber > 80 and: aNumber < 90) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: self moonWalkEffectRandom).].
		(aNumber > 90 and: aNumber < 98) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: self hyperJumpEffectRandom).].
		(aNumber > 98 and: aNumber < 100) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: AtomicBombEffect new).
			]]
]

{ #category : #'instance creation' }
Board >> initializeOf: anAmountOfCells with: anAmountOfRounds and: anAmountOfParsecs [ 
	amountOfCells := anAmountOfCells.
	rounds := anAmountOfRounds.
	parsecs := anAmountOfParsecs.
	cellsEffects := OrderedCollection new.
	self initializeCells .
	
]

{ #category : #action }
Board >> moonWalkEffectRandom [
	| aNumber |
	aNumber:= 100 atRandom .
	^(MoonWalkEffect with: aNumber).
]

{ #category : #action }
Board >> probabilities: effectsProbabilities [
	
	1 to: amountOfCells do: [ :index | 
		| aNumber |
		aNumber := 100 atRandom.
		(aNumber > 0 and: aNumber < 40) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: NoEffect new).
			(effectsProbabilities collect: [ :effects | effects name = 'NoEffect']) addOne. ].
		(aNumber > 40 and: aNumber < 60) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: WormHoleEffect new).
			(effectsProbabilities collect: [ :effects | effects name = 'WormHoleEffect']) addOne ].
		(aNumber > 60 and: aNumber < 80) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: SpeedUpEffect new).
			(effectsProbabilities collect: [ :effects | effects name = 'SpeedUpEffect']) addOne ].
		(aNumber > 80 and: aNumber < 90) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: self moonWalkEffectRandom).
			(effectsProbabilities collect: [ :effects | effects name = 'MoonWalkEffect']) addOne].
		(aNumber > 90 and: aNumber < 98) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: self hyperJumpEffectRandom).
			(effectsProbabilities collect: [ :effects | effects name = 'MoonWalkEffect']) addOne ].
		(aNumber > 98 and: aNumber < 100) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: AtomicBombEffect new).
			(effectsProbabilities collect: [ :effects | effects name = 'MoonWalkEffect']) addOne.]]
]
