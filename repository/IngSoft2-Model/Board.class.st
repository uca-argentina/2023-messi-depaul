Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'amountOfCells',
		'rounds',
		'parsecs',
		'cellsEffects',
		'amountOfCellsEffect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> of: anAmountOfCells with: anAmountOfRounds and: anAmountOfParsecs [ 
	^ (self new) initializeOf: anAmountOfCells with: anAmountOfRounds and: anAmountOfParsecs.
]

{ #category : #action }
Board >> addOneAtomicBombEffect [
	|aProbabilityEffect|
	aProbabilityEffect:= amountOfCellsEffect at: 6.
	aProbabilityEffect addOneAmount.
]

{ #category : #action }
Board >> addOneHyperJumpEffect [
	|aProbabilityEffect|
	aProbabilityEffect:= amountOfCellsEffect at: 5.
	aProbabilityEffect addOneAmount.
]

{ #category : #action }
Board >> addOneMoonWalkEffect [
	|aProbabilityEffect|
	aProbabilityEffect:= amountOfCellsEffect at: 4.
	aProbabilityEffect addOneAmount.
]

{ #category : #action }
Board >> addOneNoEffect [
	|aProbabilityEffect|
	aProbabilityEffect:= amountOfCellsEffect at: 1.
	aProbabilityEffect addOneAmount.
]

{ #category : #action }
Board >> addOneSpeedUpEffect [
	|aProbabilityEffect|
	aProbabilityEffect:= amountOfCellsEffect at: 3.
	aProbabilityEffect addOneAmount.
]

{ #category : #action }
Board >> addOneWormHoleEffect [
	|aProbabilityEffect|
	aProbabilityEffect:= amountOfCellsEffect at: 2.
	aProbabilityEffect addOneAmount.
]

{ #category : #'instance creation' }
Board >> amountOfCellsEffect [
	^ amountOfCellsEffect
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

{ #category : #initialization }
Board >> initializeAmountOfCellsEffect [

	amountOfCellsEffect := OrderedCollection new.
	amountOfCellsEffect add: (ProbabilityEffects of: 'NoEffect').
	amountOfCellsEffect add: (ProbabilityEffects of: 'WormHoleEffect').
	amountOfCellsEffect add: (ProbabilityEffects of: 'SpeedUpEffect').
	amountOfCellsEffect add: (ProbabilityEffects of: 'MoonWalkEffect').
	amountOfCellsEffect add: (ProbabilityEffects of: 'HyperJumpEffect').
	amountOfCellsEffect add: (ProbabilityEffects of: 'AtomicBombEffect')
]

{ #category : #action }
Board >> initializeCells [
	
	1 to: amountOfCells do: [ :index | 
		| aNumber |
		aNumber := 100 atRandom.
		(aNumber > 0 and: aNumber <= 40) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: NoEffect new).
			self addOneNoEffect. ].
		(aNumber > 40 and: aNumber <= 60) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: WormHoleEffect new).
			self addOneWormHoleEffect.].
		(aNumber > 60 and: aNumber <= 80) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: SpeedUpEffect new).
			self addOneSpeedUpEffect.].
		(aNumber > 80 and: aNumber <= 90) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: self moonWalkEffectRandom).
			self addOneMoonWalkEffect.].
		(aNumber > 90 and: aNumber <= 98) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: self hyperJumpEffectRandom).
			self addOneHyperJumpEffect ].
		(aNumber > 98 and: aNumber <= 100) ifTrue: [ 
			cellsEffects add: (CellEfect on: index of: AtomicBombEffect new).
			self addOneAtomicBombEffect]].
]

{ #category : #'instance creation' }
Board >> initializeOf: anAmountOfCells with: anAmountOfRounds and: anAmountOfParsecs [ 
	amountOfCells := anAmountOfCells.
	rounds := anAmountOfRounds.
	parsecs := anAmountOfParsecs.
	cellsEffects := OrderedCollection new.
	self initializeAmountOfCellsEffect.
	self initializeCells .
	
	
]

{ #category : #action }
Board >> moonWalkEffectRandom [
	| aNumber |
	aNumber:= 100 atRandom .
	^(MoonWalkEffect with: aNumber).
]
