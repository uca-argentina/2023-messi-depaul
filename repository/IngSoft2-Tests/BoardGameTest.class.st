Class {
	#name : #BoardGameTest,
	#superclass : #TestCase,
	#instVars : [
		'cellEffects'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardGameTest >> setUp [

	super setUp.
	cellEffects := OrderedCollection new.
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: NoEffect new).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	cellEffects add: (CellEfect on: 6 of: NoEffect new).
	cellEffects add: (CellEfect on: 7 of: NoEffect new).
	cellEffects add: (CellEfect on: 8 of: NoEffect new).
	cellEffects add: (CellEfect on: 9 of: NoEffect new).
	cellEffects add: (CellEfect on: 10 of: NoEffect new).
]

{ #category : #tests }
BoardGameTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
			self assert: error messageText equals: anErrorMessage ].
]

{ #category : #tests }
BoardGameTest >> test07WhenALoadedDieIsThrownThenASpaceshipMovesForwardOnePosition [

	| aBoardGame aBoard aLoadedDie spaceships |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.

	aBoard := Board of: cellEffects withLenght: 15.

	aLoadedDie := LoadedDie of: #( 1 2 3 ).

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: aLoadedDie)
		              on: aBoard
		              with: 2.
	
	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 2
	
	"PlayedBy: spaceshipsCollection rolling: dieCollection on: aBoard with: amountOfRounds"
]

{ #category : #tests }
BoardGameTest >> test08WhenASpaceshipWinsThenGameOver [

	| spaceships aBoard aBoardGame |
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	
	aBoard := Board of: cellEffects withLenght: 15.
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 3 )))
		              on: aBoard
		              with: 1.

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.

	self
		should: [ aBoardGame aSpaceshipPlays: 'Cami' ]
		raise: Error
		withMessage: 'There is a winner, you cant keep moving forward'
]

{ #category : #tests }
BoardGameTest >> test09WhenTwoSpaceshipPlayThenSpaceship1Wins [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: 15.
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 1.

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: aBoardGame winner equals: 'Vicky'
]

{ #category : #tests }
BoardGameTest >> test10WhenAllSpaceshipsPositionsThenAnOrderedCollection [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: 15.
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	self
		assert: aBoardGame positions
		equals: (OrderedCollection with: 5 with: 3)
]

{ #category : #tests }
BoardGameTest >> test11WhenTwoSpaceshipsPlaysThenSpaceshipPositions [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: 15.
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 5.
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 3
]

{ #category : #tests }
BoardGameTest >> test12WhenItsNotASpaceshipsTruenThenThrowsErrorMessage [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: 15.
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2.
	self
		should: [ aBoardGame aSpaceshipPlays: 'Cami' ]
		raise: Error
		withMessage: 'Its not your turn'
]

{ #category : #tests }
BoardGameTest >> test13WhenABoardGameWithNoSpaceshipsThenFailsCreation [

	self
		should: [ 
			BoardGame
				playedBy: OrderedCollection new
				rolling: (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
				on: (Board of: cellEffects withLenght: 15)
				with: 2 ]
		raise: Error
		withMessage: 'Cannot create board with no spaceships'
]

{ #category : #tests }
BoardGameTest >> test14WhenASpaceshipAdvanceTwoRoundsThenSpaceshipPositionsAndRounds [

	| spaceships aBoard aBoardGame |
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: 15.
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 3 4 20 )))
		              on: aBoard
		              with: 3.	
	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 4.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 5.
	self assert: (aBoardGame spaceshipRound: 'Cami') equals: 1
]

{ #category : #tests }
BoardGameTest >> test15WhenASpaceshipAdvanceTwoRoundsThenFails [

	| spaceships aBoard aBoardGame |
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: 15.
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 12 4 20 )))
		              on: aBoard
		              with: 3.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	self
		should: [ aBoardGame aSpaceshipPlays: 'Cami' ]
		raise: Error
		withMessage: 'There is a winner, you cant keep moving forward'
]
