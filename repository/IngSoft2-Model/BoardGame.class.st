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
		'permanentCards',
		'indexCards',
		'lastCardPlayed',
		'playingCard',
		'lastCellEffect',
		'playingSpaceshipPosition',
		'croupier'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
BoardGame class >> playedBy: spaceships rolling: dice on: aBoard with: rounds managedBy: aCroupier [ 

	self validateCanExistWith: spaceships andWith: rounds.
	^ self new
		  initializePlayedBy: spaceships
		  rolling: dice
		  on: aBoard
		  winningAfter: rounds
		  managedBy: aCroupier.
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
BoardGame >> applyAtomicBombEffect [

	spaceshipPositions do: [ :spaceship | 
		self moves: spaceship to: (spaceship position cellNumber negated) + 1 ]
]

{ #category : #effects }
BoardGame >> applyEffect [

	| aCellEffect |
	aCellEffect := board cellsEffect detect: [ :cell | 
		               cell quantity = playingSpaceshipPosition  position cellNumber  ].
	
	"croupier lastCellEffect: aCellEffect effect."
	lastCellEffect := aCellEffect effect.
	aCellEffect effect implementOn: self
]

{ #category : #effects }
BoardGame >> applyHyperJumpEffect: parsecs [

	self
		moves: playingSpaceshipPosition
		to: parsecs // board parsecsPerCell
]

{ #category : #effects }
BoardGame >> applyMoonWalkEffect: cellsBackward [

	"spaceshipPositions do: [ : spaceshipPosition | 
		((playingSpaceshipPosition spaceship) ~= (spaceshipPosition spaceship)) ifTrue: [ 
			self moves: spaceshipPosition to: cellsBackward negated ]]."

	(spaceshipPositions select: [ :spaceshipPosition | 
			playingSpaceshipPosition spaceships ~= spaceshipPosition spaceships ])
		do: [ :spaceshipPosition | 
			self moves: spaceshipPosition to: cellsBackward negated ].

]

{ #category : #effects }
BoardGame >> applyMovingEffect: aNumber [ 
	self moves: playingSpaceshipPosition to: aNumber.
]

{ #category : #effects }
BoardGame >> dealACardEffect [
	croupier dealACardTo: playingSpaceshipPosition spaceships.
]

{ #category : #initialization }
BoardGame >> dealCards [

	| size amountOfCards |
	size := 0.
	amountOfCards := 0.
	spaceshipCards := OrderedCollection new.

	[ spaceships size > size ] whileTrue: [ 
		spaceshipCards add: (SpaceshipCard
				 named: (OrderedCollection with: (spaceships at: size + 1))
				 with: (deckOfCards at: indexCards)).
		indexCards := indexCards \\ deckOfCards size + 1.
		spaceshipCards add: (SpaceshipCard
				 named:  (OrderedCollection with: (spaceships at: size + 1))
				 with: (deckOfCards at: indexCards)).
		indexCards := indexCards \\ deckOfCards size + 1.
		size := size + 1 ]
]

{ #category : #'instance creation' }
BoardGame >> initializePlayedBy: manySpaceships rolling: manyDice on: aBoard winningAfter: anAmountOfRounds managedBy: aCroupier [ 

	board := aBoard.
	spaceships := manySpaceships.
	dice := manyDice.
	turn := 1.
	isOver := false.
	rounds := anAmountOfRounds.
	winner := ''.
	lastCellEffect := NoEffect new.
	croupier := aCroupier.
	croupier dealCardsWhenGameIsStartedTo: spaceships.
	self spaceshipsInitialization.
]

{ #category : #action }
BoardGame >> moves: aSpaceshipPosition to: amountOfCellsToMove [

	| moveAmount aSpaceshipPositionNew cellNumberNew roundNew |
	moveAmount := aSpaceshipPosition position cellNumber
	              + amountOfCellsToMove.

	cellNumberNew := self
		                 newCellNumberPositionWith: moveAmount
		                 on: aSpaceshipPosition position round.
	roundNew := self
		            newRoundPositionWhen: aSpaceshipPosition position round
		            with: moveAmount.


	aSpaceshipPositionNew := SpaceshipPosition
		                         named: aSpaceshipPosition spaceships
		                         on:
		                         (Position on: cellNumberNew at: roundNew).
	playingSpaceshipPosition := aSpaceshipPositionNew.

	spaceshipPositions
		at: (spaceshipPositions indexOf: aSpaceshipPosition)
		put: aSpaceshipPositionNew
]

{ #category : #action }
BoardGame >> newCellNumberPositionWith: moveAmount on: aRound [

	| cellNumber amountOfRounds |
	cellNumber := moveAmount.
	amountOfRounds := aRound.

	[ cellNumber > board anAmountOfCells ] whileTrue: [ 
		cellNumber := cellNumber - board anAmountOfCells ].

	[ cellNumber <= 0 ] whileTrue: [ 
		amountOfRounds = 1
			ifTrue: [ cellNumber := 1 ]
			ifFalse: [ 
				amountOfRounds := amountOfRounds - 1.
				cellNumber := cellNumber + board anAmountOfCells ] ].

	cellNumber = 0 ifTrue: [ cellNumber := 1 ].

	^ cellNumber
]

{ #category : #action }
BoardGame >> newRoundPositionWhen: originalRound with: moveAmount [

	| cellNumber round |
	cellNumber := moveAmount.
	round := originalRound.

	[ cellNumber > board anAmountOfCells ] whileTrue: [ 
		cellNumber := cellNumber - board anAmountOfCells.
		round := round + 1 ].

	[ cellNumber < 0 ] whileTrue: [ 
		cellNumber := cellNumber + board anAmountOfCells.
		round := round - 1 ].

	round <= 0 ifTrue: [ round := 1 ].


	^ round
]

{ #category : #action }
BoardGame >> playTurnFor: aSpaceship [

	isOver
		ifFalse: [ 
			self validatePlayingSpaceshipPosition.
			self validateSpaceshipTurnFor: aSpaceship.
			self relocatesSpaceshipPositionTo: self totalAmount.
			self validateWinner: playingSpaceshipPosition.

			turn := turn \\ spaceships size + 1 ]
		ifTrue: [ self validateKeepPlaying ]
]

{ #category : #action }
BoardGame >> positions [

	^ spaceshipPositions collect: [ :spaceship | 
		  spaceship position cellNumber ]
]

{ #category : #action }
BoardGame >> ranking [

	| namesRanking |
	namesRanking := spaceshipPositions sort: [ 
		                :spaceshipPosition1
		                :spaceshipPosition2 | (spaceshipPosition1 >= spaceshipPosition2) ].
	namesRanking size >= 3 ifTrue: [ 
		namesRanking := namesRanking first: 3 ].
	^ namesRanking collect: [ :spaceshipPosition | 
		  spaceshipPosition spaceships ]
]

{ #category : #action }
BoardGame >> relocatesSpaceshipPositionTo: aNumber [

	self moves: playingSpaceshipPosition to: aNumber.

	self applyEffect
]

{ #category : #cards }
BoardGame >> repeatCard [

	lastCellEffect implementOn: self
]

{ #category : #cards }
BoardGame >> repeatCardTo: aSpaceship [

	playingSpaceshipPosition := spaceshipPositions detect: [ 
		                            :spaceshipPosition | 
		                            spaceshipPosition spaceships
		                            == aSpaceship ].

	lastCellEffect implementOn: self
]

{ #category : #action }
BoardGame >> spaceshipPosition: aName [

	^ (spaceshipPositions detect: [ :spaceshipPosition | 
		   spaceshipPosition spaceships == aName ]) position
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

{ #category : #cards }
BoardGame >> throw: aCard from: aSpaceship [

	| aCardPlayers |
	croupier take: aCard from: aSpaceship on: self.
	aCardPlayers := CardPlayers of: aCard with: spaceships.
	"(aCard name = 'repeat')ifTrue:[ 
		aCardPlayers := CardPlayers of: aCard with: (OrderedCollection with: aSpaceship). ]."
	croupier play: aCardPlayers.
]

{ #category : #cards }
BoardGame >> throw: aCard from: aSpaceship affecting: anotherSpaceship [ 
	| aCardPlayers |
	self validateSpaceshipExists: anotherSpaceship.
	croupier take: aCard from: aSpaceship on: self.
	aCardPlayers := CardPlayers
		                of: aCard
		                with: (OrderedCollection with: anotherSpaceship).
	croupier play: aCardPlayers on: self.
]

{ #category : #cards }
BoardGame >> throw: aCard from: aSpaceship choosing: anotherCard [
	
	croupier take: aCard from: aSpaceship on: self.
	croupier play: aCard forSelected: anotherCard

]

{ #category : #cards }
BoardGame >> throw: aCard from: aSpaceship to: anotherSpaceship [

	| aCardPlayers |
	self validateSpaceshipExists: anotherSpaceship.
	croupier take: aCard from: aSpaceship on: self.
	aCardPlayers := CardPlayers
		                of: aCard
		                with: (OrderedCollection with: anotherSpaceship).
	croupier play: aCardPlayers.
]

{ #category : #action }
BoardGame >> throwDice [

	| result |
	result := 0.
	dice do: [ :each | result := result + each throw ].
	^ result
]

{ #category : #cards }
BoardGame >> totalAmount [

	^ self throwDice + (croupier permanentCardsOf: playingSpaceshipPosition spaceships).
]

{ #category : #validation }
BoardGame >> validateKeepPlaying [

	Error signal: 'There is a winner, you cant keep moving forward'
]

{ #category : #validation }
BoardGame >> validatePermanentPlayFor: aSpaceship [

	(spaceships at: turn) = aSpaceship ifFalse: [ 
		Error signal: 'Its not your turn' ]
]

{ #category : #action }
BoardGame >> validatePlayingSpaceshipPosition [

	playingSpaceshipPosition := spaceshipPositions detect: [ 
		                            :spaceshipPosition | 
		                            spaceshipPosition spaceships
		                            == (spaceships at: turn) ]
]

{ #category : #validation }
BoardGame >> validateRedoCard [

	(lastCardPlayed = '')ifTrue: [ 
		Error signal: 'A card hasn´t been played yet' ].
	playingCard := lastCardPlayed
]

{ #category : #validation }
BoardGame >> validateSpaceshipExists: aSpaceship [

	(spaceships includes: aSpaceship)
		ifFalse: [ Error signal: 'That spaceship doesn´t exists' ].
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
			winner := aSpaceshipPosition spaceships ]
		ifFalse: [  ]
]

{ #category : #'instance variable' }
BoardGame >> winner [

	winner
		ifEmpty: [ Error signal: 'There is not a winner' ]
		ifNotEmpty: [  ].
	^ winner
]
