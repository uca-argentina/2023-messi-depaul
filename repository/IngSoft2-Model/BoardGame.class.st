Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'amountOfCells',
		'turn',
		'aWinner',
		'dice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
BoardGame class >> of: anAmountOfCells with: spaceships andWith: dice [
	self validateCanExistWith: anAmountOfCells.
	^(self new) initializesOf: anAmountOfCells with: spaceships andWith: dice.
]

{ #category : #'instance creation' }
BoardGame class >> validateCanExistWith: anAmount [
	anAmount > 1 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of cells' ]
]

{ #category : #action }
BoardGame >> aSpaceshipTurn [

	| aSpaceship |
	aSpaceship := spaceships at: turn.
	turn := turn \\ spaceships size + 1.
	^ aSpaceship
]

{ #category : #'instance variables' }
BoardGame >> aWinner [
	^ aWinner
]

{ #category : #'instance variables' }
BoardGame >> dice [
	^ dice
]

{ #category : #initialization }
BoardGame >> initializesOf: anAmountOfCells with: spaceshipsCollection andWith: diceCollection [ 
	amountOfCells := anAmountOfCells .
	spaceships := spaceshipsCollection .
	dice := diceCollection .
	turn:= 1.
]

{ #category : #action }
BoardGame >> positions [

	^ spaceships collect: [ :spaceship | spaceship position ]
]

{ #category : #action }
BoardGame >> spaceshipPlays [
	| aSpaceship |
	aSpaceship := self aSpaceshipTurn.
	aSpaceship updatePosition: self throwDice .
	self winner == aSpaceship.
]

{ #category : #'instance variables' }
BoardGame >> spaceships [
	^ spaceships
]

{ #category : #action }
BoardGame >> throwDice [

	| result |
	result := 0.
	dice do: [ :each | result := result + each throw ].
	^ result
]

{ #category : #action }
BoardGame >> validateWinner [

	Error signal: 'There is a winner, you cant keep moving forward'
]

{ #category : #action }
BoardGame >> winner [

	aWinner isNil
		ifFalse: [ self validateWinner ]
		ifTrue: [ 
			aWinner := spaceships
				           detect: [ :spaceship | 
				           spaceship position >= amountOfCells ]
				           ifNone: [  ] ]
			
		"Encararlo por un true or false. Si aWinner es true, no se puede seguir jugando."
]
