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
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).
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
BoardGameTest >> test01WhenCreationOfBoardGameWithRepeatedSpaceshipsThenCannotCreate [
	|spaceships|
	spaceships := OrderedCollection with: 'Cami' with: 'Vicky' with: 'Cami'.	
	self
		should: [ 
			BoardGame
				playedBy: spaceships
				rolling: (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
				on: (Board of: cellEffects withLenght: 15)
				with: 2 ]
		raise: Error
		withMessage: 'Cannot create board with repeated spaceships'
]

{ #category : #tests }
BoardGameTest >> test02WhenALoadedDieIsThrownThenASpaceshipMovesForwardOnePosition [

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
	
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 2
]

{ #category : #tests }
BoardGameTest >> test03WhenASpaceshipWinsThenGameOver [

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

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.

	self
		should: [ aBoardGame playTurnFor: 'Cami' ]
		raise: Error
		withMessage: 'There is a winner, you cant keep moving forward'
]

{ #category : #tests }
BoardGameTest >> test04WhenTwoSpaceshipPlayThenSpaceship1Wins [

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

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	self assert: aBoardGame winner equals: 'Vicky'
]

{ #category : #tests }
BoardGameTest >> test05WhenAllSpaceshipsPositionsThenAnOrderedCollection [

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
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: aBoardGame positions
		equals: (OrderedCollection with: 5 with: 3)
]

{ #category : #tests }
BoardGameTest >> test06WhenTwoSpaceshipsPlaysThenSpaceshipPositions [

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
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 5.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 3
]

{ #category : #tests }
BoardGameTest >> test07WhenItsNotASpaceshipsTruenThenCannotPlay [

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
		should: [ aBoardGame playTurnFor: 'Cami' ]
		raise: Error
		withMessage: 'Its not your turn'
]

{ #category : #tests }
BoardGameTest >> test08WhenABoardGameWithNoSpaceshipsThenFailsCreation [

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
BoardGameTest >> test09WhenASpaceshipAdvanceTwoRoundsThenCurrentPositionAndRound [

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
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 5.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1
]

{ #category : #tests }
BoardGameTest >> test10WhenASpaceshipAdvanceTwoRoundsThenGameIsOver [

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
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	self
		should: [ aBoardGame playTurnFor: 'Cami' ]
		raise: Error
		withMessage: 'There is a winner, you cant keep moving forward'
]

{ #category : #tests }
BoardGameTest >> test11WhenABoardGameIsPlayedThenThereIsNotAWinner [

	| spaceships aBoard aBoardGame |
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: 15.
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 2 )))
		              on: aBoard
		              with: 3.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	self should: [ aBoardGame winner equals: 'Vicky' ]
		raise: Error
		withMessage: 'There is not a winner'
]
