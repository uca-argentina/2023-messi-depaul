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
	aSequence := (1 to: 4) collect: [ :i | 5].
	aSequence sort reverse.
	^(HyperJumpEffect with: aSequence).

	
]

{ #category : #'instance creation' }
Board >> initializeOf: anAmountOfCells with: anAmountOfRounds and: anAmountOfParsecs [ 
	amountOfCells := anAmountOfCells.
	rounds := anAmountOfRounds.
	parsecs := anAmountOfParsecs.
	cellsEffects := OrderedCollection new.
	self probabilities.
]

{ #category : #action }
Board >> moonWalkEffectRandom [
	| aNumber |
	aNumber:= 5.
	^(MoonWalkEffect with: aNumber).
]

{ #category : #action }
Board >> probabilities [
	1 to: amountOfCells do: [:index |
    | aNumber |
    aNumber := 100 atRandom.
    (aNumber > 0 and: aNumber < 40) ifTrue: [
        cellsEffects add: (CellEfect on: index of: NoEffect new).
    ].
    (aNumber > 40 and: aNumber < 60) ifTrue: [
        cellsEffects add: (CellEfect on: index of: WormHoleEffect new).
    ].
    (aNumber > 60 and: aNumber < 80) ifTrue: [
        cellsEffects add: (CellEfect on: index of: SpeedUpEffect new).
    ].
    (aNumber > 80 and: aNumber < 90) ifTrue: [
        cellsEffects add: (CellEfect on: index of: MoonWalkEffect new).
    ].
    (aNumber > 90 and: aNumber < 98) ifTrue: [
        cellsEffects add: (CellEfect on: index of: HyperJumpEffect new).
    ].
    (aNumber > 98 and: aNumber < 100) ifTrue: [
        cellsEffects add: (CellEfect on: index of: AtomicBombEffect new).
    ].
].

]
