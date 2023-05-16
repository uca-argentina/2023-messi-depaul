Class {
	#name : #LoadedBoard,
	#superclass : #Object,
	#instVars : [
		'amountOfCells',
		'rounds',
		'cellsEffects',
		'parsecs'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
LoadedBoard class >> of: aCollectionOfCellsEffects with: anAmountOfParsecs and: anAmountOfRounds [
	self validateCanExistWith: aCollectionOfCellsEffects and: anAmountOfRounds.
	^(self new) initializeOf: aCollectionOfCellsEffects with: anAmountOfParsecs and: anAmountOfRounds.
	
]

{ #category : #initialization }
LoadedBoard class >> validateCanExistWith: cellsEffectsCollection and: anAmountOfRounds [

	| cells cellsOrdered cellsPosition |
	cellsEffectsCollection size > 1 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of cells' ].
	
	cellsPosition:= cellsEffectsCollection collect: [ : cell | cell number ].
	cells := cellsPosition asSet.
	cellsOrdered := (1 to: cellsPosition size) asSet.
	cells = cellsOrdered ifFalse: [ 
		Error signal: 'Cannot create board without all the cells' ].

	cellsPosition size = cells size ifFalse: [ 
		Error signal: 'Cannot create board with repeted cells' ].
	
	anAmountOfRounds > 0 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of rounds' ]
]

{ #category : #action }
LoadedBoard >> adaptAllPositions: spaceshipPositions [ 
	spaceshipPositions do: [ :spaceshipPosition | self adaptPosition: spaceshipPosition  ].
]

{ #category : #action }
LoadedBoard >> adaptNegativeParsecPosition: aSpaceshipPosition [

	| parsecsPerCell |
	parsecsPerCell := parsecs // amountOfCells.
	[ aSpaceshipPosition parsec < 0 ] whileTrue: [ 
		aSpaceshipPosition changePosition: aSpaceshipPosition position - 1.
		aSpaceshipPosition changeParsec:
			aSpaceshipPosition parsec + parsecsPerCell ].
		
	aSpaceshipPosition changeParsec: 1.
]

{ #category : #action }
LoadedBoard >> adaptParsec: aSpaceshipPosition [

	aSpaceshipPosition parsec > 1 ifTrue: [ 
		self adaptParsecPosition: aSpaceshipPosition ].

	aSpaceshipPosition parsec < 1 ifTrue: [ 
		self adaptNegativeParsecPosition: aSpaceshipPosition ].
]

{ #category : #action }
LoadedBoard >> adaptParsecPosition: aSpaceshipPosition [

	| parsecsPerCell |
	parsecsPerCell := parsecs // amountOfCells.
	[ aSpaceshipPosition parsec + 1 > parsecsPerCell ] whileTrue: [ 
		aSpaceshipPosition changePosition: aSpaceshipPosition position + 1.
		aSpaceshipPosition changeParsec:
			aSpaceshipPosition parsec - parsecsPerCell ].
	aSpaceshipPosition changeParsec: 1.
]

{ #category : #action }
LoadedBoard >> adaptPosition: aSpaceshipPosition [

	self adaptParsec: aSpaceshipPosition.
	
	(aSpaceshipPosition position > amountOfCells )ifTrue: [ 
	self moveForwardRound: aSpaceshipPosition].
	
	(aSpaceshipPosition position <= 0 )ifTrue: [ 
	self moveBackRound: aSpaceshipPosition.]
]

{ #category : #'instance creation' }
LoadedBoard >> anAmountOfCells [

	^ amountOfCells
]

{ #category : #'instance variables' }
LoadedBoard >> cellsEffect [
	^cellsEffects .
]

{ #category : #'instance creation' }
LoadedBoard >> initializeOf: anAmountOfCells and: anAmountOfRounds with: aCollectionOfCellsEffects [
	amountOfCells:= anAmountOfCells .
	rounds:= anAmountOfRounds .
	cellsEffects := aCollectionOfCellsEffects.
]

{ #category : #'instance creation' }
LoadedBoard >> initializeOf: collectionOfCellsEffect with: numberOfRounds and: amountOfParsecs [ 
	cellsEffects := collectionOfCellsEffect.
	rounds := numberOfRounds.
	parsecs := amountOfParsecs.
	amountOfCells := cellsEffects size.
]

{ #category : #'instance creation' }
LoadedBoard >> initializeOf: anAmountOfCells with: anAmountOfParsecs and: anAmountOfRounds with: aCollectionOfCellsEffects [
	amountOfCells:= anAmountOfCells .
	rounds:= anAmountOfRounds .
	cellsEffects := aCollectionOfCellsEffects.
	parsecs:= anAmountOfParsecs .
]

{ #category : #action }
LoadedBoard >> moveBackRound: aSpaceshipPosition [

	[ aSpaceshipPosition position <= 0 ] whileTrue: [ 
		aSpaceshipPosition round = 1
			ifTrue: [ aSpaceshipPosition changePosition: 1 ]
			ifFalse: [ 
				aSpaceshipPosition changeRound: -1.
				aSpaceshipPosition changePosition:
					aSpaceshipPosition position + amountOfCells ] ]
]

{ #category : #action }
LoadedBoard >> moveForwardRound: aSpaceshipPosition [

	| moveAmount |
	moveAmount := aSpaceshipPosition position.
	[ moveAmount > amountOfCells ] whileTrue: [ 
		aSpaceshipPosition changeRound: 1.
		moveAmount := moveAmount - amountOfCells ].
	aSpaceshipPosition changePosition:
		aSpaceshipPosition position % amountOfCells.
	aSpaceshipPosition position = 0 ifTrue: [ 
		aSpaceshipPosition changePosition: 1 ]
]

{ #category : #'instance variable' }
LoadedBoard >> rounds [
	^rounds.
]
