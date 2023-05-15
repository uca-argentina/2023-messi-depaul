Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'amountOfCells',
		'rounds',
		'cellsEffects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> of: anAmountOfCells and: anAmountOfRounds with: aCollectionOfCellsEffects [
	self validateCanExistWith: anAmountOfCells and: anAmountOfRounds.
	^(self new) initializeOf: anAmountOfCells and: anAmountOfRounds with: aCollectionOfCellsEffects.
]

{ #category : #initialize }
Board class >> validateCanExistWith: anAmountOfCells and: anAmountOfRounds [ 
	anAmountOfCells > 1 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of cells' ].
	anAmountOfRounds  > 0 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of rounds' ].
]

{ #category : #action }
Board >> adaptAllPositions: spaceshipPositions [ 
	spaceshipPositions do: [ :spaceshipPosition | self adaptPosition: spaceshipPosition  ].
]

{ #category : #action }
Board >> adaptPosition: aSpaceshipPosition [

	| moveAmount|
	moveAmount := aSpaceshipPosition position.

	moveAmount > amountOfCells
		ifTrue: [ 
			[ moveAmount > amountOfCells ] whileTrue: [ 
				aSpaceshipPosition changeRound: 1.
				moveAmount := moveAmount - amountOfCells ].

			aSpaceshipPosition changePosition: (aSpaceshipPosition position % amountOfCells).
			aSpaceshipPosition position = 0 ifTrue: [ 
				aSpaceshipPosition changePosition: 1 ] ]
		ifFalse: [].
		
	[aSpaceshipPosition position <= 0]whileTrue:[
	(aSpaceshipPosition round = 1)
		ifTrue:[aSpaceshipPosition changePosition: 1]
		ifFalse:[
			aSpaceshipPosition changeRound: -1.
			aSpaceshipPosition changePosition: aSpaceshipPosition position + amountOfCells ].
		].
	
		
]

{ #category : #'instance creation' }
Board >> anAmountOfCells [

	^ amountOfCells
]

{ #category : #'instance variables' }
Board >> cellsEffect [
	^cellsEffects .
]

{ #category : #'instance creation' }
Board >> initializeOf: anAmountOfCells and: anAmountOfRounds with: aCollectionOfCellsEffects [
	amountOfCells:= anAmountOfCells .
	rounds:= anAmountOfRounds .
	cellsEffects := aCollectionOfCellsEffects.
]

{ #category : #'instance variable' }
Board >> rounds [
	^rounds.
]
