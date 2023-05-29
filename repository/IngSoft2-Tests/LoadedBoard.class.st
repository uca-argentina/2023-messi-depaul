Class {
	#name : #LoadedBoard,
	#superclass : #Object,
	#instVars : [
		'amountOfCells',
		'cellsEffects',
		'parsecs'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialization }
LoadedBoard class >> of: aCollectionOfCellsEffects withLenght: anAmountOfParsecs [
	self validateCanExistWith: aCollectionOfCellsEffects.
	^(self new) initializeOf: aCollectionOfCellsEffects withLenght: anAmountOfParsecs.
	
]

{ #category : #initialization }
LoadedBoard class >> validateCanExistWith: cellsEffectsCollection [

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
LoadedBoard >> initializeOf: aCollectionOfCellsEffects withLenght: anAmountOfParsecs [
	cellsEffects := aCollectionOfCellsEffects.
	parsecs := anAmountOfParsecs.
	amountOfCells := cellsEffects size.
]

{ #category : #'instance variable' }
LoadedBoard >> parsecs [
	^ parsecs
]
