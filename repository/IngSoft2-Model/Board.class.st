Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'amountOfCells'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Board class >> validateAnAmountOfCells: anAmount [
	anAmount > 1 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of cells' ]
]

{ #category : #'instance creation' }
Board class >> withAnAmountOfCells: anAmount [
	self validateAnAmountOfCells: anAmount.
	^(self new) initializeWithAnAmountOfCells: anAmount.
]

{ #category : #initialization }
Board >> initializeWithAnAmountOfCells: anAmount [ 
	amountOfCells:= anAmount.
]

{ #category : #validation }
Board >> isValid [
	^true
]
