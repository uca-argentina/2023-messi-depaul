Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'spaceships',
		'turn',
		'dice',
		'spaceshipPositions',
		'board',
		'winner',
		'rounds',
		'isOver',
		'deckOfCards',
		'spaceshipCards',
		'activeCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
BoardGame class >> playedBy: spaceships rolling: dice on: aBoard with: rounds [

	self validateCanExistWith: spaceships andWith: rounds.
	^ self new
		  initializePlayedBy: spaceships
		  rolling: dice
		  on: aBoard
		  with: rounds
]

{ #category : #initialize }
BoardGame class >> playedBy: spaceships rolling: dice on: aBoard with: rounds utilizing: aDeckOfCards [

	self validateCanExistWith: spaceships andWith: rounds.
	^ self new
		  initializePlayedBy: spaceships
		  rolling: dice
		  on: aBoard
		  with: rounds
		  utilizing: aDeckOfCards
]

{ #category : #'instance creation' }
BoardGame class >> validateCanExistWith: aSpaceshipCollection andWith: anAmountOfRounds [

	aSpaceshipCollection isEmpty ifTrue: [ 
		Error signal: 'Cannot create board with no spaceships' ].

	anAmountOfRounds > 0 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of rounds' ].


	aSpaceshipCollection asSet size < aSpaceshipCollection size ifTrue: [ 
		Error signal: 'Cannot create board with repeated spaceships' ]
]

{ #category : #effects }
BoardGame >> amountOfCellsOfNegativeParsecs: parsecs [

	| parsecsPerCell amountOfCells amountOfParsecs |
	parsecsPerCell := board parsecs // board anAmountOfCells.
	amountOfCells := 0.
	amountOfParsecs := parsecs.

	[ amountOfParsecs < 0 ] whileTrue: [ 
		amountOfCells := amountOfCells - 1.
		amountOfParsecs := amountOfParsecs + parsecsPerCell ].

	^ amountOfCells
]

{ #category : #effects }
BoardGame >> amountOfCellsOfPositiveParsecs: parsecs [

	| parsecsPerCell amountOfCells amountOfParsecs |
	parsecsPerCell := board parsecs // board anAmountOfCells.
	amountOfCells := 0.
	amountOfParsecs := parsecs.

	[ amountOfParsecs >= parsecsPerCell ] whileTrue: [ 
		amountOfCells := amountOfCells + 1.
		amountOfParsecs := amountOfParsecs - parsecsPerCell ].

	^ amountOfCells
]

{ #category : #effects }
BoardGame >> applyAtomicBombEffect [

	spaceshipPositions do: [ :spaceship | 
		self moves: spaceship to: (spaceship position cellNumber negated) + 1 ]
]

{ #category : #effects }
BoardGame >> applyEffect [

	| aCellEffect |
	aCellEffect := board cellsEffect detect: [ :cell | 
		               cell number = self playingSpaceshipPosition position cellNumber  ].

	aCellEffect effect implementOn: self
]

{ #category : #effects }
BoardGame >> applyHyperJumpEffect: parsecs [

	| amountOfCells |
	amountOfCells := parsecs > 0
		                 ifTrue: [ 
		                 self amountOfCellsOfPositiveParsecs: parsecs ]
		                 ifFalse: [ 
		                 self amountOfCellsOfNegativeParsecs: parsecs ].

	self moves: self playingSpaceshipPosition to: amountOfCells
]

{ #category : #effects }
BoardGame >> applyMoonWalkEffect: cellsBackward [

	spaceshipPositions do: [ :spaceshipPosition | 
		spaceshipPosition spaceship
		~= self playingSpaceshipPosition spaceship ifTrue: [ 
			self moves: spaceshipPosition to: cellsBackward negated ] ]
]

{ #category : #effects }
BoardGame >> applyMovingEffect: aNumber [ 
	self moves: self playingSpaceshipPosition to: aNumber.
]

{ #category : #initialization }
BoardGame >> dealCards [

	| size amountOfCards|
	size := 0.
	amountOfCards:= 0.
	spaceshipCards := OrderedCollection new.
	
	[ spaceships size > size ] whileTrue: [ 
		spaceshipCards add:
			(SpaceshipCard named: (spaceships at: size + 1) with: (deckOfCards at: 1 )).
		size := size + 1 ]
]

{ #category : #initialization }
BoardGame >> initializePlayedBy: spaceshipsCollection rolling: dieCollection on: aBoard with: amountOfRounds [

	board := aBoard.
	spaceships := spaceshipsCollection.
	dice := dieCollection.
	turn := 1.
	isOver := false.
	rounds := amountOfRounds.
	winner := ''.
	self spaceshipsInitialization
]

{ #category : #initialization }
BoardGame >> initializePlayedBy: spaceshipsCollection rolling: dieCollection on: aBoard with: amountOfRounds utilizing: aDeckOfCards [

	board := aBoard.
	spaceships := spaceshipsCollection.
	dice := dieCollection.
	turn := 1.
	isOver := false.
	rounds := amountOfRounds.
	winner := ''.
	deckOfCards:= aDeckOfCards .
	activeCards := OrderedCollection new.
	self spaceshipsInitialization.
	self dealCards.
]

{ #category : #action }
BoardGame >> moveBackwards: aSpaceshipPosition to: amountOfCellsToMove [

	| amountOfRounds moveAmount |
	moveAmount := amountOfCellsToMove.
	amountOfRounds := aSpaceshipPosition position round.

	[ moveAmount <= 0 ] whileTrue: [ 
		amountOfRounds = 1
			ifTrue: [ moveAmount := 1 ]
			ifFalse: [ 
				amountOfRounds := amountOfRounds - 1.
				moveAmount := moveAmount + board anAmountOfCells ] ].
	moveAmount = 0 ifTrue: [ moveAmount := 1 ].

	^ Position on: moveAmount at: amountOfRounds
]

{ #category : #action }
BoardGame >> moveForward: aSpaceshipPosition to: amountOfCellsToMove [

	| amountOfRounds moveAmount |
	moveAmount := amountOfCellsToMove.
	amountOfRounds := aSpaceshipPosition position round.

	[ moveAmount > board anAmountOfCells ] whileTrue: [ 
		amountOfRounds := amountOfRounds + 1.
		moveAmount := moveAmount - board anAmountOfCells ].
	moveAmount = 0 ifTrue: [ moveAmount := 1 ].

	^ Position
		  on: moveAmount
		  at: amountOfRounds
]

{ #category : #action }
BoardGame >> moves: aSpaceshipPosition to: amountOfCellsToMove [

	| moveAmount aSpaceshipPositionNew aPosition |
	moveAmount := aSpaceshipPosition position cellNumber
	              + amountOfCellsToMove.
	aPosition := Position
		             on: moveAmount
		             at: aSpaceshipPosition position round.

	moveAmount > board anAmountOfCells ifTrue: [ 
		aPosition := self moveForward: aSpaceshipPosition to: moveAmount ].

	moveAmount <= 0 ifTrue: [ 
		aPosition := self moveBackwards: aSpaceshipPosition to: moveAmount ].

	aSpaceshipPositionNew := SpaceshipPosition
		                         named: aSpaceshipPosition spaceship
		                         on: aPosition.

	spaceshipPositions
		at: (spaceshipPositions indexOf: aSpaceshipPosition)
		put: aSpaceshipPositionNew
]

{ #category : #cards }
BoardGame >> playActiveCardsFor: aSpaceship [

	| amount |
	amount := 0.

	activeCards do: [ :activeCard | 
		activeCard spaceship = aSpaceship ifTrue: [ 
			amount := amount + activeCard card affectTotalAmount ] ].

	^ amount
]

{ #category : #action }
BoardGame >> playTurnFor: aSpaceship [

	isOver
		ifFalse: [ 
			| anAmount |
			self validateSpaceshipTurnFor: aSpaceship.

			anAmount := (self playActiveCardsFor: aSpaceship) + (self throwDice) .
			
			self relocatesSpaceshipPositionTo: anAmount.

			self validateWinner: self playingSpaceshipPosition.

			turn := turn \\ spaceships size + 1 ]
		ifTrue: [ self validateKeepPlaying ]
]

{ #category : #action }
BoardGame >> playingSpaceshipPosition [

	| aSpaceshipPosition |
	aSpaceshipPosition := spaceshipPositions detect: [ :spaceshipPosition | 
		                      spaceshipPosition spaceship == (spaceships at: turn) ].
	^ aSpaceshipPosition
]

{ #category : #action }
BoardGame >> positions [

	^ spaceshipPositions collect: [ :spaceship | spaceship position cellNumber].
]

{ #category : #action }
BoardGame >> ranking [

	| namesRanking |
	namesRanking := spaceshipPositions sort: [ 
		                :spaceshipPosition1 
		                :spaceshipPosition2 | 
		                (spaceshipPosition2 position round) < (spaceshipPosition1 position round)
			                or:
			                (spaceshipPosition2 position cellNumber)
			                < (spaceshipPosition1 position cellNumber)].
	namesRanking size >= 3 ifTrue: [ 
		namesRanking := namesRanking first: 3 ].
	^ namesRanking collect: [ :spaceshipPosition | 
		  spaceshipPosition spaceship ]
]

{ #category : #action }
BoardGame >> relocatesSpaceshipPositionTo: aNumber [

	self moves: self playingSpaceshipPosition to: aNumber.

	self applyEffect
]

{ #category : #cards }
BoardGame >> spaceshipCardOf: aCard from: aSpaceship [

	| aSpaceshipCard |
	aSpaceshipCard := spaceshipCards detect: [ :spaceshipCard | 
		                  spaceshipCard spaceship = aSpaceship and:
			                  spaceshipCard card name = aCard ].
	^ aSpaceshipCard
]

{ #category : #action }
BoardGame >> spaceshipPosition: aName [

	^ (spaceshipPositions detect: [ :spaceshipPosition | 
		   spaceshipPosition spaceship == aName ]) position
]

{ #category : #initialization }
BoardGame >> spaceshipsInitialization [

	| size |
	size := 0.
	spaceshipPositions := OrderedCollection new.
	[ spaceships size > size ] whileTrue: [ 
		spaceshipPositions add:
			(SpaceshipPosition named: (spaceships at: size + 1) on: (Position on: 1 at: 1)).
		size := size + 1 ]
]

{ #category : #action }
BoardGame >> throwDice [

	| result |
	result := 0.
	dice do: [ :each | result := result + each throw ].
	^ result
]

{ #category : #cards }
BoardGame >> throwSpeedCardFrom: aSpaceship to: anotherSpaceship [

	| aSpaceshipCard |
	aSpaceshipCard := self spaceshipCardOf: 'speed' from: aSpaceship.

	activeCards add:
		(SpaceshipCard named: anotherSpaceship with: aSpaceshipCard card).

	spaceshipCards remove: aSpaceshipCard

]

{ #category : #validation }
BoardGame >> validateKeepPlaying [

	Error signal: 'There is a winner, you cant keep moving forward'
]

{ #category : #validation }
BoardGame >> validateSpaceshipTurnFor: aSpaceship [

	(spaceships at: turn) = aSpaceship
		ifFalse: [ Error signal: 'Its not your turn' ].
]

{ #category : #validation }
BoardGame >> validateWinner: aSpaceshipPosition [

	(aSpaceshipPosition position round) > rounds
		ifTrue: [ 
			isOver := true.
			winner := aSpaceshipPosition spaceship ]
		ifFalse: [  ]
]

{ #category : #'instance variable' }
BoardGame >> winner [

	winner
		ifEmpty: [ Error signal: 'There is not a winner' ]
		ifNotEmpty: [  ].
	^ winner
]
