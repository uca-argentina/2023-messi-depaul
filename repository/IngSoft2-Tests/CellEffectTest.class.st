Class {
	#name : #CellEffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CellEffectTest >> test16WhenACellIsSpeedUpThenSpaceshipMovesFourPositions [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: SpeedUpEffect new).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 3.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 2
]

{ #category : #tests }
CellEffectTest >> test17WhenACellSpeedUpThenSpaceshipMovesTwoRounds [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: NoEffect new).
	cellEffects add: (CellEfect on: 3 of: SpeedUpEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: cellEffects with: 4 and: 15.

	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 2 2 1 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 3
]

{ #category : #tests }
CellEffectTest >> test18WhenAllSpaceshipsLandOnSpeedUpCellsThenEffectIsApplied [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: SpeedUpEffect new).
	cellEffects add: (CellEfect on: 3 of: SpeedUpEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	cellEffects add: (CellEfect on: 6 of: NoEffect new).
	cellEffects add: (CellEfect on: 7 of: SpeedUpEffect new).
	cellEffects add: (CellEfect on: 8 of: NoEffect new).
	cellEffects add: (CellEfect on: 9 of: NoEffect new).
	cellEffects add: (CellEfect on: 10 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: cellEffects with: 4 and: 15.

	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 1 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 6.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.

	aBoardGame aSpaceshipPlays: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 7.
	self assert: (aBoardGame spaceshipRound: 'Cami') equals: 1.

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 2
]

{ #category : #tests }
CellEffectTest >> test19WhenACellIsWormHoleThenSpaceshipMovesBackwardsFourPositions [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: NoEffect new).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	cellEffects add: (CellEfect on: 6 of: WormHoleEffect new).
	cellEffects add: (CellEfect on: 7 of: NoEffect new).
	cellEffects add: (CellEfect on: 8 of: NoEffect new).
	cellEffects add: (CellEfect on: 9 of: NoEffect new).
	cellEffects add: (CellEfect on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 2.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]

{ #category : #tests }
CellEffectTest >> test20WhenABoardOfTwoCellsAndASpaceshipLandsOnWormHoleThenGoesBackTwoRounds [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (CellEfect on: 1 of: WormHoleEffect new).
	cellEffects add: (CellEfect on: 2 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: cellEffects with: 4 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 4 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]

{ #category : #tests }
CellEffectTest >> test21WhenASpaceshipInRoundOneLandsOnWormHoleAndInPositionLessThanFourThenGoesToStart [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: NoEffect new).
	cellEffects add: (CellEfect on: 3 of: WormHoleEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	cellEffects add: (CellEfect on: 6 of: NoEffect new).
	cellEffects add: (CellEfect on: 7 of: NoEffect new).
	cellEffects add: (CellEfect on: 8 of: NoEffect new).
	cellEffects add: (CellEfect on: 9 of: NoEffect new).
	cellEffects add: (CellEfect on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 2 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]

{ #category : #tests }
CellEffectTest >> test22WhenACellIsAtomicBombThenSpaceshipsMovesBackwardsToStart [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: NoEffect new).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	cellEffects add: (CellEfect on: 6 of: AtomicBombEffect new).
	cellEffects add: (CellEfect on: 7 of: NoEffect new).
	cellEffects add: (CellEfect on: 8 of: NoEffect new).
	cellEffects add: (CellEfect on: 9 of: NoEffect new).
	cellEffects add: (CellEfect on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]

{ #category : #tests }
CellEffectTest >> test23WhenACellIsAtomicBombThenAllSpaceshipsMovesBackwardsToStart [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: NoEffect new).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	cellEffects add: (CellEfect on: 6 of: AtomicBombEffect new).
	cellEffects add: (CellEfect on: 7 of: NoEffect new).
	cellEffects add: (CellEfect on: 8 of: NoEffect new).
	cellEffects add: (CellEfect on: 9 of: NoEffect new).
	cellEffects add: (CellEfect on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 2 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 3.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.

	aBoardGame aSpaceshipPlays: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 2.
	self assert: (aBoardGame spaceshipRound: 'Cami') equals: 1.

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.

	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Cami') equals: 1
]

{ #category : #tests }
CellEffectTest >> test24WhenACellIsAtomicBombThenSpaceshipsMovesBackwardsAndRoundDoesNotChange [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: NoEffect new).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: AtomicBombEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: cellEffects with: 4 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 11 2 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 2.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 3.
	
	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 3.
]

{ #category : #tests }
CellEffectTest >> test25WhenASpaceshipLandsOnMoonWalkThenOtherSpaceshipsChangePositions [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect |
	cellEffects := OrderedCollection new.
	aMoonWalkEffect := MoonWalkEffect with: 5.

	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: NoEffect new).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	cellEffects add: (CellEfect on: 6 of: aMoonWalkEffect).
	cellEffects add: (CellEfect on: 7 of: NoEffect new).
	cellEffects add: (CellEfect on: 8 of: NoEffect new).
	cellEffects add: (CellEfect on: 9 of: NoEffect new).
	cellEffects add: (CellEfect on: 10 of: NoEffect new).


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 7 5 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 8.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.

	aBoardGame aSpaceshipPlays: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 6.
	self assert: (aBoardGame spaceshipRound: 'Cami') equals: 1.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 3.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]

{ #category : #tests }
CellEffectTest >> test26WhenASpaceshipsLandOnWormHoleEffectAndLandsOnCellWithEffectThenEffectNotApplied [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: SpeedUpEffect new).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	cellEffects add: (CellEfect on: 6 of: WormHoleEffect new).
	cellEffects add: (CellEfect on: 7 of: NoEffect new).
	cellEffects add: (CellEfect on: 8 of: NoEffect new).
	cellEffects add: (CellEfect on: 9 of: NoEffect new).
	cellEffects add: (CellEfect on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 2.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]

{ #category : #tests }
CellEffectTest >> test27WhenAGameIsPlayedWithCellsEffectThenSpaceshipsRanking [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.

	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: SpeedUpEffect new).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	cellEffects add: (CellEfect on: 6 of: WormHoleEffect new).
	cellEffects add: (CellEfect on: 7 of: NoEffect new).
	cellEffects add: (CellEfect on: 8 of: NoEffect new).
	cellEffects add: (CellEfect on: 9 of: NoEffect new).
	cellEffects add: (CellEfect on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Delfi'.

	self
		assert: aBoardGame ranking
		equals: (OrderedCollection with: 'Cami' with: 'Delfi' with: 'Vicky')
]

{ #category : #tests }
CellEffectTest >> test28ASpaceshipLandsOnHyperJumpThenMovesOneCell [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with: (OrderedCollection with: 5).
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 5 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 3.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]

{ #category : #tests }
CellEffectTest >> test29ASpaceshipLandsOnHyperJumpThenMovesTwoRounds [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with: (OrderedCollection with: 5).
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 5 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 3.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]

{ #category : #tests }
CellEffectTest >> test30ASpaceshipLandsOnHyperJumpThenMovesTwoCells [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with: (OrderedCollection with: 6).
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 5 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 4.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]

{ #category : #tests }
CellEffectTest >> test31WhenTwoSpaceshipsLandsOnHyperJumpThenMovesToTheirNewPositions [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect
			 on: 2
			 of: (HyperJumpEffect with: (OrderedCollection with: 6 with: 5))).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 4.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.

	aBoardGame aSpaceshipPlays: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 3.
	self assert: (aBoardGame spaceshipRound: 'Cami') equals: 1.

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 4.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 2
]

{ #category : #tests }
CellEffectTest >> test32WhenASpaceshipLandsInAHyperJumpWithNegativeValuesThenMovesBackwards [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with:
		                    (OrderedCollection with: -4).
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: NoEffect new).
	cellEffects add: (CellEfect on: 3 of: aHyperJumpEffect).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 2 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]

{ #category : #tests }
CellEffectTest >> test33WhenASpaceshipLandsInHyperJumpInRoundOneThenMovesToInitialPosition [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with:
		                    (OrderedCollection with: -5).
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: cellEffects with: 2 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]

{ #category : #tests }
CellEffectTest >> test34WhenSpaceshipLandsInHyperJumpThenGoesBackTwoRounds [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with:
		                    (OrderedCollection with: -30).
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: cellEffects with: 4 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 10 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 3.

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 2.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]

{ #category : #tests }
CellEffectTest >> test35WhenASpaceshipPlaysAnHyperJumpWithNegativeParsecValueThenGoesBack2Rounds [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect := HyperJumpEffect with:
		                    (OrderedCollection with: -30).
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: cellEffects with: 4 and: 15.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 10 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 3.

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 2.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1
]
