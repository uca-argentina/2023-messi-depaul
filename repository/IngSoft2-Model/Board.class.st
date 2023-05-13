Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'amountOfCells',
		'rounds'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> of: anAmountOfCells and: anAmountOfRounds [ 
	self validateCanExistWith: anAmountOfCells and: anAmountOfRounds.
	^(self new) initializeOf: anAmountOfCells and: anAmountOfRounds.
]

{ #category : #initialize }
Board class >> validateCanExistWith: anAmountOfCells and: anAmountOfRounds [ 
	anAmountOfCells > 1 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of cells' ].
	anAmountOfRounds  > 0 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of rounds' ].
]

{ #category : #'instance creation' }
Board >> anAmountOfCells [

	^ amountOfCells
]

{ #category : #'instance creation' }
Board >> initializeOf: anAmountOfCells and: anAmountOfRounds [ 
	amountOfCells:= anAmountOfCells .
	rounds:= anAmountOfRounds .
]
