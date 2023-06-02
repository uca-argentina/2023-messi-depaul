Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'amountOfCells',
		'cellsEffects',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> of: aCollectionOfCellsEffects withLenght: anAmountOfParsecs [

	self validateCanExistWith: aCollectionOfCellsEffects.
	^ self new
		  initializeOf: aCollectionOfCellsEffects
		  withLenght: anAmountOfParsecs
]

{ #category : #initialization }
Board class >> validateCanExistWith: cellsEffectsCollection [

	cellsEffectsCollection size > 1 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of cells' ]
]

{ #category : #'instance variables' }
Board >> anAmountOfCells [

	^ amountOfCells
]

{ #category : #'instance variables' }
Board >> cellsEffect [

	^ cellsEffects
]

{ #category : #'instance creation' }
Board >> initializeOf: aCollectionOfCellsEffects withLenght: anAmountOfParsecs [

	cellsEffects := aCollectionOfCellsEffects.
	parsecs := anAmountOfParsecs.
	amountOfCells := cellsEffects size
]

{ #category : #'instance variables' }
Board >> parsecs [

	^ parsecs
]
