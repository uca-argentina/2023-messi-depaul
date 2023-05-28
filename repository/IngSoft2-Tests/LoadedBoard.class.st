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

{ #category : #'instance creation' }
LoadedBoard >> anAmountOfCells [

	^ amountOfCells
]

{ #category : #'instance variables' }
LoadedBoard >> cellsEffect [
	^cellsEffects .
]

{ #category : #'instance creation' }
LoadedBoard >> initializeOf: collectionOfCellsEffect with: numberOfRounds and: amountOfParsecs [ 
	cellsEffects := collectionOfCellsEffect.
	rounds := numberOfRounds.
	parsecs := amountOfParsecs.
	amountOfCells := cellsEffects size.
]

{ #category : #'instance variable' }
LoadedBoard >> rounds [
	^rounds.
]
