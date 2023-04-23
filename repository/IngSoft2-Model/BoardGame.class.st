Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'board',
		'spaceships',
		'amountofcells',
		'tableOfPositions',
		'shift'
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

{ #category : #'action handling' }
BoardGame >> aSpaceshipMovesForward: aValue [ 
	|aSpaceship|
	aSpaceship := spaceships at: shift.
	shift := (shift \\ spaceships size) + 1.
	aSpaceship advanceAnAmountOfCells: aValue.
]

{ #category : #adding }
BoardGame >> add: aCollectionOfspaceships [ 
	| tableOfPositions |
	tableOfPositions := OrderedCollection new.
	1 to: (aCollectionOfspaceships size) do: [tableOfPositions add: 0]. 
	^tableOfPositions
]

{ #category : #validations }
BoardGame >> hasAnySpaceshipWon [
	^ spaceships detect: [:spaceship | spaceship position == board howManyCellsDoIHave].
]

{ #category : #'instance creation' }
BoardGame >> initializeWith: anAmountOfCells [ 
	amountofcells := anAmountOfCells.
	shift := 1.
	spaceships := OrderedCollection new.
]

{ #category : #'adding item' }
BoardGame >> introduce: aSpaceship [
	spaceships add: aSpaceship.
]

{ #category : #validation }
BoardGame >> isValid [
	^true.
]

{ #category : #'as yet unclassified' }
BoardGame >> showTableOfPositions [
	^tableOfPositions .
]

{ #category : #'as yet unclassified' }
BoardGame >> winner [
	^((spaceships positions) detect: [:position | position == amountofcells])
	
]

{ #category : #'as yet unclassified' }
BoardGame >> winner: aSpaceshipsCollection [
	^(aSpaceshipsCollection detect: [ :spaceship | (spaceship position) == amountofcells ]).
]
