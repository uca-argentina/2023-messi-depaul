Class {
	#name : #ParsecTest,
	#superclass : #TestCase,
	#instVars : [
		'cellEffects',
		'aDeckOfCards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
ParsecTest >> setUp [
	super setUp.
	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: AccelerationCard new.
	aDeckOfCards add: CancellationCard new.
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
		              with: 2 utilizing: aDeckOfCards.

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
		              with: 2 utilizing: aDeckOfCards.

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
