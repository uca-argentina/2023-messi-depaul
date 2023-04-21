Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'spaceships',
		'amountofcells'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardGame class >> validateAnAmountOfCells: anAmount [
	anAmount > 1 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of cells' ]
]

{ #category : #initialization }
BoardGame class >> withAnAmountOfCells: anAmountOfCells [
	self validateAnAmountOfCells: anAmountOfCells.
	^(self new) initializeWith: anAmountOfCells.
]

{ #category : #adding }
BoardGame >> add: aSpaceship [ 
	^true.
]

{ #category : #validations }
BoardGame >> hasAnySpaceshipWon [
	^ spaceships detect: [:spaceship | spaceship position == board howManyCellsDoIHave].
]

{ #category : #'instance creation' }
BoardGame >> initializeWith: anAmountOfCells [ 
	amountofcells := anAmountOfCells.
]

{ #category : #validation }
BoardGame >> isValid [
	^true.
]

{ #category : #'as yet unclassified' }
BoardGame >> winner: aSpaceshipsCollection [
	^(aSpaceshipsCollection detect: [ :spaceship | (spaceship position) == amountofcells ]).
]
