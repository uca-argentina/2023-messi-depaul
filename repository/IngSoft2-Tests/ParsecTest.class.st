Class {
	#name : #ParsecTest,
	#superclass : #TestCase,
	#instVars : [
		'cellEffects',
		'aDeckOfCards',
		'aCroupier'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
ParsecTest >> setUp [
	super setUp.
	aDeckOfCards := DeckOfCards with: (OrderedCollection
			                 with: SpeedCard new
			                 with: OverloadCard new
			                 with: AccelerationCard new
			                 with: CancellationCard new).
	aCroupier := Croupier handling: aDeckOfCards
]

{ #category : #tests }
ParsecTest >> test01WhenASpaceshipLandsOnHyperJumpwWithParsecsAndLightYearsThenMovesForward [

	| spaceships aBoard aBoardGame |
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell
			 on: 2
			 of: (HyperJumpEffect with: (OrderedCollection with: (LightYear of: 18) with: (Parsec of: 5)))).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	
	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 2
]

{ #category : #tests }
ParsecTest >> test02WhenABoardInLightYearsAndSpaceshipLandsOnHyperJumpThenSpacechipMovesForward [

	| spaceships aBoard aBoardGame |
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell
			 on: 2
			 of: (HyperJumpEffect with: (OrderedCollection with: (LightYear of: 18) with: (Parsec of: 5)))).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	
	aBoard := Board of: cellEffects withLenght: (LightYear of: (15*3)).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 2
]

{ #category : #tests }
ParsecTest >> test03WhenABoardInNegativeLightYearsAndSpaceshipLandsOnHyperJumpThenSpacechipMoves [

	| spaceships aBoard aBoardGame |
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell
			 on: 2
			 of: (HyperJumpEffect with: (OrderedCollection with: (LightYear of: -18) with: (Parsec of: 5)))).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	
	aBoard := Board of: cellEffects withLenght: (LightYear of: (15*3)).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 1 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.
]
