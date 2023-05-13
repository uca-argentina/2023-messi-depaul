Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'amountOfCells',
		'turn',
		'aWinner',
		'dice',
		'spaceshipPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
BoardGame class >> of: anAmountOfCells with: spaceships andWith: dice [
	self validateCanExistWith: anAmountOfCells and: spaceships.
	^(self new) initializesOf: anAmountOfCells with: spaceships andWith: dice.
]

{ #category : #'instance creation' }
BoardGame class >> validateCanExistWith: anAmount and: aSpaceshipCollection [
	anAmount > 1 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of cells' ].
	(aSpaceshipCollection isEmpty) ifTrue: [Error signal: 'Cannot create board with no spaceships'].
]

{ #category : #action }
BoardGame >> aSpaceshipKeepPlaying [

	aWinner := spaceshipPositions anySatisfy: [ :spaceship | 
		           spaceship position = amountOfCells ].
	^ aWinner.
]

{ #category : #action }
BoardGame >> aSpaceshipPlays: aName [

	| aSpaceshipPosition1 |
	self aSpaceshipKeepPlaying
		ifFalse: [ 
			self aSpaceshipTurn = aName
				ifTrue: [ 
					aSpaceshipPosition1 := spaceshipPositions detect: [ 
						                       :aSpaceshipPosition | 
						                       aSpaceshipPosition spaceship == aName ].
					aSpaceshipPosition1 change: self throwDice ]
				ifFalse: [ self validateTurn ] ]
		ifTrue: [ self validateWinner ]
]

{ #category : #action }
BoardGame >> aSpaceshipTurn [

	| aSpaceship |
	aSpaceship := spaceships at: turn.
	turn := turn \\ spaceships size + 1.
	^ aSpaceship
]

{ #category : #'instance variables' }
BoardGame >> dice [
	^ dice
]

{ #category : #action }
BoardGame >> gameWinner [

	^ (spaceshipPositions
		           detect: [ :spaceship | 
		           spaceship position = amountOfCells ]
		           ifNone: [  ]).
]

{ #category : #initialization }
BoardGame >> initializesOf: anAmountOfCells with: spaceshipsCollection andWith: diceCollection [ 
	amountOfCells := anAmountOfCells .
	spaceships := spaceshipsCollection .
	dice := diceCollection .
	turn:= 1.
	self spaceshipsInitialization.
	aWinner := false.
]

{ #category : #action }
BoardGame >> positions [

	^ spaceshipPositions collect: [ :spaceship | spaceship position ].
]

{ #category : #action }
BoardGame >> spaceshipPosition: aName [
	^ ((spaceshipPositions detect: [:spaceshipPosition | spaceshipPosition spaceship == aName ]) position).
]

{ #category : #action }
BoardGame >> spaceshipsInitialization [

	| size |
	size := 0.
	spaceshipPositions := OrderedCollection new.
	[ spaceships size > size ] whileTrue: [ 
		spaceshipPositions add:
			(SpaceshipPosition of: (spaceships at: size + 1) with: 0).
		size := size + 1 ]
]

{ #category : #action }
BoardGame >> throwDice [

	| result |
	result := 0.
	dice do: [ :each | result := result + each throw ].
	^ result
]

{ #category : #validation }
BoardGame >> validateTurn [
	Error signal: 'Its not your turn'.
]

{ #category : #action }
BoardGame >> validateWinner [

	Error signal: 'There is a winner, you cant keep moving forward'
]
