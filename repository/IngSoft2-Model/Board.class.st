Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'amountOfCells',
		'cellsEffects',
		'parsecs',
		'parsecsPerCell'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> of: aCollectionOfCellsEffects withLenght: aMeasure [

	self validateCanExistWith: aCollectionOfCellsEffects.
	^ self new
		  initializeOf: aCollectionOfCellsEffects
		  withLenght: aMeasure.
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
Board >> initializeOf: aCollectionOfCellsEffects withLenght: aMeasure [

	cellsEffects := aCollectionOfCellsEffects.
	parsecs := aMeasure parsecs.
	amountOfCells := cellsEffects size.
	parsecsPerCell := parsecs quantity // amountOfCells.
]

{ #category : #'instance variables' }
Board >> parsecsPerCell [

	^ parsecsPerCell 
]
