Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'amountofcells',
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

{ #category : #action }
BoardGame >> aSpaceshipMovesForward: aValue [ 
	|aSpaceship|
	aSpaceship := spaceships at: shift.
	shift := (shift \\ spaceships size) + 1.
	aSpaceship updatePosition: aValue + (aSpaceship position).
	
	(self winner == aSpaceship)
	ifTrue: [^aSpaceship].
]

{ #category : #action }
BoardGame >> allSpaceshipPositions [
	^ spaceships collect: [:spaceship | spaceship position].
]

{ #category : #'instance creation' }
BoardGame >> initializeWith: anAmountOfCells [ 
	amountofcells := anAmountOfCells.
	shift := 1.
	spaceships := OrderedCollection new.
]

{ #category : #action }
BoardGame >> insert: aSpaceship [
	spaceships add: aSpaceship.
]

{ #category : #validation }
BoardGame >> isValid [
	^true.
]

{ #category : #action }
BoardGame >> winner [
	| result |
	result := spaceships detect: [:spaceship | spaceship position >= amountofcells] ifNone: [nil].
	^ result

	
	
]
