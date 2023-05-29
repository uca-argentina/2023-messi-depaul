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
		'isOver'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
BoardGame class >> playedBy: spaceships rolling: dice on: aBoard with:rounds [
	self validateCanExistWith: spaceships andWith: rounds.
	^(self new) initializePlayedBy: spaceships rolling: dice on: aBoard with:rounds.
]

{ #category : #'instance creation' }
BoardGame class >> validateCanExistWith: aSpaceshipCollection andWith: anAmountOfRounds [

	aSpaceshipCollection isEmpty ifTrue: [ 
		Error signal: 'Cannot create board with no spaceships' ].

	anAmountOfRounds > 0 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of rounds' ]
]

{ #category : #effects }
BoardGame >> amountOfCellsOfNegativeParsecs: parsecs [

	| parsecsPerCell amountOfCells amountOfParsecs |
	parsecsPerCell := (board parsecs) // board anAmountOfCells.
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
	parsecsPerCell := (board parsecs) // (board anAmountOfCells).
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
		self moves: spaceship  to: ((spaceship position) negated) + 1].
]

{ #category : #effects }
BoardGame >> applyEffect [

	| aCellEffect |
	aCellEffect := board cellsEffect detect: [ :cell | 
		               cell number = self playingSpaceshipPosition position ].

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
BoardGame >> applySpeedUpEffect [

	self moves: self playingSpaceshipPosition to: 4.
]

{ #category : #effects }
BoardGame >> applyWormHoleEffect [

	self moves: self playingSpaceshipPosition to: -4
]

{ #category : #initialization }
BoardGame >> initializePlayedBy: spaceshipsCollection rolling: dieCollection on: aBoard with: amountOfRounds [
	board := aBoard  .
	spaceships := spaceshipsCollection .
	dice := dieCollection .
	turn:= 1.
	isOver := false.
	rounds:= amountOfRounds.
	winner := ''.
	self spaceshipsInitialization.
	
]

{ #category : #action }
BoardGame >> moves: aSpaceshipPosition to: amountOfCellsToMove [

	| moveAmount amountOfRounds aSpaceshipPositionNew posicion |

	moveAmount := aSpaceshipPosition position + amountOfCellsToMove.
	amountOfRounds := aSpaceshipPosition round.

	[ moveAmount > board anAmountOfCells ] whileTrue: [ 
		amountOfRounds := amountOfRounds + 1.
		moveAmount := moveAmount - board anAmountOfCells ].


	[ moveAmount <= 0 ] whileTrue: [ 
		amountOfRounds = 1
			ifTrue: [ moveAmount := 1 ]
			ifFalse: [ 
				amountOfRounds := amountOfRounds - 1.
				moveAmount := moveAmount + board anAmountOfCells ] ].

	moveAmount = 0 ifTrue: [ moveAmount := 1 ].

	aSpaceshipPositionNew := SpaceshipPosition
		                         named: aSpaceshipPosition spaceship
		                         on: moveAmount
		                         at: amountOfRounds.
		
	posicion:= spaceshipPositions indexOf: aSpaceshipPosition.
	spaceshipPositions at: posicion put: aSpaceshipPositionNew.

]

{ #category : #action }
BoardGame >> playTurnFor: aSpaceship [

	isOver
		ifFalse: [ 
			self validateSpaceshipTurnFor: aSpaceship.

			self relocatesSpaceshipPositionTo: self throwDice.

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

	^ spaceshipPositions collect: [ :spaceship | spaceship position ].
]

{ #category : #action }
BoardGame >> ranking [

	| namesRanking |
	namesRanking := spaceshipPositions sort: [ 
		                :spaceshipPosition1 
		                :spaceshipPosition2 | 
		                spaceshipPosition2 round < spaceshipPosition1 round 
			                or:
			                spaceshipPosition2 position
			                < spaceshipPosition1 position ].
	namesRanking size >= 3 ifTrue: [ 
		namesRanking := namesRanking first: 3 ].
	^ namesRanking collect: [ :spaceshipPosition | 
		  spaceshipPosition spaceship ]
]

{ #category : #action }
BoardGame >> relocatesSpaceshipPositionTo: aNumber [

	
	
	self moves: self playingSpaceshipPosition to: aNumber.
	
	self applyEffect.
	
]

{ #category : #action }
BoardGame >> spaceshipPosition: aName [
	^ ((spaceshipPositions detect: [:spaceshipPosition | spaceshipPosition spaceship == aName ]) position).
]

{ #category : #action }
BoardGame >> spaceshipRound: aName [ 
	^ ((spaceshipPositions detect: [:spaceshipPosition | spaceshipPosition spaceship == aName ]) round).
]

{ #category : #initialization }
BoardGame >> spaceshipsInitialization [

	| size |
	size := 0.
	spaceshipPositions := OrderedCollection new.
	[ spaceships size > size ] whileTrue: [ 
		spaceshipPositions add:
			(SpaceshipPosition named: (spaceships at: size + 1) on: 1 at: 1).
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
BoardGame >> validateKeepPlaying [

	Error signal: 'There is a winner, you cant keep moving forward'
]

{ #category : #validation }
BoardGame >> validateSpaceshipTurnFor: aSpaceship [

	(spaceships at: turn) = aSpaceship
		ifFalse: [ Error signal: 'Its not your turn' ].
]

{ #category : #validation }
BoardGame >> validateTurn [
	Error signal: 'Its not your turn'.
]

{ #category : #validation }
BoardGame >> validateWinner: aSpaceshipPosition [

	aSpaceshipPosition round > rounds ifTrue: [ 
		isOver := true.
		"aSpaceshipPosition winner: rounds."
		winner:= aSpaceshipPosition spaceship.
		]
	ifFalse:[].
]

{ #category : #'instance variable' }
BoardGame >> winner [
	(winner)ifEmpty: [ Error signal: 'There is not a winner'. ] ifNotEmpty: [  ].
		^ winner
]
