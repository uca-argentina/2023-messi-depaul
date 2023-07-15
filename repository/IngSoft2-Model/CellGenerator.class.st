Class {
	#name : #CellGenerator,
	#superclass : #Object,
	#instVars : [
		'noEffects',
		'wormHoles',
		'speedUps',
		'moonWalks',
		'atomicBombs',
		'hyperJumps',
		'amountOfCells',
		'cards',
		'cellEffects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
CellGenerator class >> setWithCellEffects: aNumber [

	^ self new initializeWithCellEffects: aNumber
]

{ #category : #'instance variables' }
CellGenerator >> atomicBombs [

	^ atomicBombs
]

{ #category : #'instance variables' }
CellGenerator >> cards [
	^cards
]

{ #category : #'instance creation' }
CellGenerator >> cellsEffect [

	^ cellEffects
]

{ #category : #'instance variables' }
CellGenerator >> hyperJumps [

	^ hyperJumps
]

{ #category : #'instance creation' }
CellGenerator >> initializeCells [

	1 to: amountOfCells do: [ :index | 
		| aNumber |
		aNumber := 100 atRandom.
		(aNumber > 0 and: aNumber <= 30) ifTrue: [ 
			cellEffects add: NoEffect new.
			noEffects := noEffects + 1 ].
		(aNumber > 30 and: aNumber <= 40) ifTrue: [ 
			cellEffects add: DrawCardEffect new.
			cards := cards + 1 ].
		(aNumber > 40 and: aNumber <= 60) ifTrue: [ 
			cellEffects add: WormHoleEffect new.
			wormHoles := wormHoles + 1 ].
		(aNumber > 60 and: aNumber <= 80) ifTrue: [ 
			cellEffects add: SpeedUpEffect new.
			speedUps := speedUps + 1 ].
		(aNumber > 80 and: aNumber <= 90) ifTrue: [ 
			cellEffects add: MoonWalkEffect new.
			moonWalks := moonWalks + 1 ].
		(aNumber > 90 and: aNumber <= 98) ifTrue: [ 
			cellEffects add: HyperJumpEffect new.
			hyperJumps := hyperJumps + 1 ].
		(aNumber > 98 and: aNumber <= 100) ifTrue: [ 
			cellEffects add: AtomicBombEffect new.
			atomicBombs := atomicBombs + 1 ] ]
]

{ #category : #'instance creation' }
CellGenerator >> initializeWithCellEffects: aNumber [
	cellEffects := OrderedCollection new.
	amountOfCells := aNumber.
	noEffects := 0.
	wormHoles := 0.
	speedUps := 0.
	moonWalks := 0.
	atomicBombs := 0.
	hyperJumps := 0.
	cards := 0.
	self initializeCells
]

{ #category : #'instance variables' }
CellGenerator >> moonWalks [

	^ moonWalks
]

{ #category : #'instance variables' }
CellGenerator >> noEffects [

	^ noEffects
]

{ #category : #'instance variables' }
CellGenerator >> speedUps [

	^ speedUps
]

{ #category : #'instance variables' }
CellGenerator >> wormHoles [

	^ wormHoles
]
