Class {
	#name : #ProbabilityGenerator,
	#superclass : #Object,
	#instVars : [
		'noEffects',
		'wormHoles',
		'speedUps',
		'moonWalks',
		'atomicBombs',
		'hyperJumps',
		'amountOfCells'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
ProbabilityGenerator class >> setWithCellEffects: aNumber [

	^ self new initializeWithCellEffects: aNumber
]

{ #category : #'instance variables' }
ProbabilityGenerator >> atomicBombs [

	^ atomicBombs
]

{ #category : #'instance variables' }
ProbabilityGenerator >> hyperJumps [

	^ hyperJumps
]

{ #category : #'instance creation' }
ProbabilityGenerator >> initializeCells [

	1 to: amountOfCells do: [ :index | 
		| aNumber |
		aNumber := 100 atRandom.
		(aNumber > 0 and: aNumber <= 40) ifTrue: [ 
			noEffects := noEffects + 1 ].
		(aNumber > 40 and: aNumber <= 60) ifTrue: [ 
			wormHoles := wormHoles + 1 ].
		(aNumber > 60 and: aNumber <= 80) ifTrue: [ 
			speedUps := speedUps + 1 ].
		(aNumber > 80 and: aNumber <= 90) ifTrue: [ 
			moonWalks := moonWalks + 1 ].
		(aNumber > 90 and: aNumber <= 98) ifTrue: [ 
			hyperJumps := hyperJumps + 1 ].
		(aNumber > 98 and: aNumber <= 100) ifTrue: [ 
			atomicBombs := atomicBombs + 1 ] ]
]

{ #category : #'instance creation' }
ProbabilityGenerator >> initializeWithCellEffects: aNumber [

	amountOfCells := aNumber.
	noEffects := 0.
	wormHoles := 0.
	speedUps := 0.
	moonWalks := 0.
	atomicBombs := 0.
	hyperJumps := 0.
	self initializeCells
]

{ #category : #'instance variables' }
ProbabilityGenerator >> moonWalks [

	^ moonWalks
]

{ #category : #'instance variables' }
ProbabilityGenerator >> noEffects [

	^ noEffects
]

{ #category : #'instance variables' }
ProbabilityGenerator >> speedUps [

	^ speedUps
]

{ #category : #'instance variables' }
ProbabilityGenerator >> wormHoles [

	^ wormHoles
]
