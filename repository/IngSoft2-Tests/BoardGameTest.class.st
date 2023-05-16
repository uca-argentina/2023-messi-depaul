Class {
	#name : #BoardGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardGameTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
			self assert: error messageText equals: anErrorMessage ].
]

{ #category : #tests }
BoardGameTest >> test02WhenABoardWithNegativeAmountOfCellsThenFailsCreation [
| aCellEfect cellEffects |
aCellEfect := CellEfect on: 2 of: SpeedUpEffect.
cellEffects := OrderedCollection new. 
cellEffects add: aCellEfect.
self should: [ LoadedBoard of: -10 and: 2 with: cellEffects] raise: Error withMessage: 'Cannot create board with a negative amount of cells'.
]

{ #category : #tests }
BoardGameTest >> test03WhenAGameIsPlayedWithDifferentFacedDiceThenSpaceshipPositions [
|spaceships aBoard aBoardGame cellEffects |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	cellEffects := OrderedCollection new. 
	aBoard:= LoadedBoard of: 10 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )) with: (LoadedDie of: #( 4 5 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.

self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 3.
self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 8.
]

{ #category : #tests }
BoardGameTest >> test04WhenAThreeFacedDieCreationThenTrue [
| aDie |
aDie := Die of: 3.
self assert: aDie faces equals: 3.

]

{ #category : #tests }
BoardGameTest >> test05WhenADieIsCreatedWithNegativeFacesThenFailsCreation [
self should: [ Die of: 1 ] raise: Error withMessage: 'Cannot create die with 2 or less amount of faces'.


]

{ #category : #tests }
BoardGameTest >> test06WhenADieThrowsThenItIsARandomBetweenOneAndHisAmountOfFaces [
| aDie |
aDie := Die of: 10.
self assert: ((aDie throw) between: 1 and: (aDie faces)).

]

{ #category : #tests }
BoardGameTest >> test07WhenALoadedDieSequenceCreationThenSequenceIsValid [
|aLoadedDie|
aLoadedDie := LoadedDie of: #(1 2 3).
self assert: aLoadedDie sequence equals: #(1 2 3).

]

{ #category : #tests }
BoardGameTest >> test08WhenALoadedDieWithNegativeSequenceThenFailsCreation [
self should: [ LoadedDie of: #(-1)] raise: Error withMessage: 'Cannot create die with value less than 0'.
]

{ #category : #tests }
BoardGameTest >> test09WhenALoadedDieIsThrown4TimesWithSequenceValues1231ThenSequenceIsValid [
|aLoadedDie|
aLoadedDie := LoadedDie of: #(1 2 3) .
self assert: aLoadedDie throw equals: 1.
self assert: aLoadedDie throw equals: 2.
self assert: aLoadedDie throw equals: 3.
self assert: aLoadedDie throw equals: 1.

]

{ #category : #tests }
BoardGameTest >> test10WhenALoadedDieIsThrownThenASpaceshipMovesForwardOnePosition [
|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard:= LoadedBoard of: 3 and: 2 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).

aBoardGame aSpaceshipPlays: 'Vicky'.

self assert: ((aBoardGame spaceshipPosition: 'Vicky')) equals: 2.

]

{ #category : #tests }
BoardGameTest >> test11WhenALoadedDieIsThrownThenASpaceshipMovesForwardThreePosition [
|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard:= LoadedBoard of: 10 and: 2 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 2.

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 4.
]

{ #category : #tests }
BoardGameTest >> test12WhenASpaceshipWinsThenGameOver [
|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard:= LoadedBoard of: 10 and: 1 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).

aBoardGame aSpaceshipPlays: 'Vicky'.
aBoardGame aSpaceshipPlays: 'Cami'.
aBoardGame aSpaceshipPlays: 'Vicky'.
aBoardGame aSpaceshipPlays: 'Cami'.
aBoardGame aSpaceshipPlays: 'Vicky'.
aBoardGame aSpaceshipPlays: 'Cami'.
aBoardGame aSpaceshipPlays: 'Vicky'.
aBoardGame aSpaceshipPlays: 'Cami'.
aBoardGame aSpaceshipPlays: 'Vicky'.

self should: [ aBoardGame aSpaceshipPlays: 'Cami'. ] raise: Error withMessage: 'There is a winner, you cant keep moving forward'.



]

{ #category : #tests }
BoardGameTest >> test13WhenTwoSpaceshipPlayThenSpaceship1Wins [
|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard:= LoadedBoard of: 10 and: 1 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).

aBoardGame aSpaceshipPlays: 'Vicky'.
aBoardGame aSpaceshipPlays: 'Cami'.
aBoardGame aSpaceshipPlays: 'Vicky'.
aBoardGame aSpaceshipPlays: 'Cami'.
aBoardGame aSpaceshipPlays: 'Vicky'.
aBoardGame aSpaceshipPlays: 'Cami'.
aBoardGame aSpaceshipPlays: 'Vicky'.
aBoardGame aSpaceshipPlays: 'Cami'.
aBoardGame aSpaceshipPlays: 'Vicky'.

self assert: (aBoardGame winner) equals: 'Vicky'.
]

{ #category : #tests }
BoardGameTest >> test14WhenAllSpaceshipsPositionsThenAnOrderedCollection [

|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard:= LoadedBoard of: 10 and: 2 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).
		
	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.


	self
		assert: aBoardGame positions
		equals: (OrderedCollection with: 5 with: 3)
]

{ #category : #tests }
BoardGameTest >> test15WhenThereAreTwoDieOnTheGameThenSpaceshipsPositionsTrue [
|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard:= LoadedBoard of: 10 and: 2 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )) with: (LoadedDie of: #( 1 2 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.

self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 9.
self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 5.
]

{ #category : #tests }
BoardGameTest >> test17WhenBoardGameHasTwoDieThenCollectionOfDieCorrectSize [

	|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard:= LoadedBoard of: 10 and: 2 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection  with: (Die of: 3)
			               with: (Die of: 3)).

	self assert: aBoardGame dice size equals: 2
]

{ #category : #tests }
BoardGameTest >> test20When2RoundsArePlayedThenThreeSpaceshipsMovesForward [

	|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	aBoard:= LoadedBoard of: 10 and: 2 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 2.
	aBoardGame aSpaceshipPlays: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 3.
	aBoardGame aSpaceshipPlays: 'Delfi'.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') equals: 4.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 3.
	aBoardGame aSpaceshipPlays: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 5.
	aBoardGame aSpaceshipPlays: 'Delfi'.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') equals: 7.
]

{ #category : #tests }
BoardGameTest >> test25WhenTwoSpaceshipsPlaysThenSpaceshipPositions [
|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard:= LoadedBoard of: 10 and: 2 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 5.
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 3.




]

{ #category : #tests }
BoardGameTest >> test26WhenItsNotASpaceshipsTruenThenThrowsErrorMessage [
|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard:= LoadedBoard of: 10 and: 2 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).

self should: [aBoardGame aSpaceshipPlays: 'Cami'.] raise: Error withMessage: 'Its not your turn'.




]

{ #category : #tests }
BoardGameTest >> test27WhenABoardGameWithNoSpaceshipsThenFailsCreation [

	self
		should: [ 
			BoardGame
				of: (LoadedBoard of: 10 and: 2 with: OrderedCollection new)
				with: OrderedCollection new
				andWith: (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))) ]
		raise: Error
		withMessage: 'Cannot create board with no spaceships'
]

{ #category : #tests }
BoardGameTest >> test28WhenASpaceshipAdvanceToNextRoundThenSpaceshipRound [
|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard:= LoadedBoard of: 5 and: 2 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 3 4 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 2.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 5.
	self assert: (aBoardGame spaceshipRound: 'Cami') equals: 1.
	




]

{ #category : #tests }
BoardGameTest >> test29WhenASpaceshipAdvanceTwoRoundsThenSpaceshipPositionsAndRounds [
|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard:= LoadedBoard of: 5 and: 3 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 3 4 11 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 3.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 5.
	self assert: (aBoardGame spaceshipRound: 'Cami') equals: 1.
	




]

{ #category : #tests }
BoardGameTest >> test30WhenASpaceshipAdvanceTwoRoundsThenFails [
|spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard:= LoadedBoard of: 5 and: 2 with: OrderedCollection new.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 3 4 11 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.
	
self should: [aBoardGame aSpaceshipPlays: 'Cami'] raise: Error withMessage: 'There is a winner, you cant keep moving forward'




]

{ #category : #tests }
BoardGameTest >> test32WhenACellIsSpeedUpThenSpaceshipMovesFourPositions [

	| aCellEfect spaceships aBoard aBoardGame cellEffects |
	aCellEfect := CellEfect on: 2 of: SpeedUpEffect new.
	cellEffects := OrderedCollection new. 
	cellEffects add: aCellEfect.
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: 5 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 2.
]

{ #category : #tests }
BoardGameTest >> test33WhenACellSpeedUpThenSpaceshipMovesTwoRounds [

	| spaceships aBoard aBoardGame cellEffects |
	
	cellEffects := OrderedCollection new. 
	cellEffects add: (CellEfect on: 3 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: 3 and: 4 with: cellEffects.
	
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 2 2 1 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 3.

	

]

{ #category : #tests }
BoardGameTest >> test33WhenAllCellsAreSpeedUpThenEffectIsApplied [

	| spaceships aBoard aBoardGame cellEffects |
	
	cellEffects := OrderedCollection new. 
	cellEffects add: (CellEfect on: 2 of: SpeedUpEffect new).
	cellEffects add: (CellEfect on: 3 of: SpeedUpEffect new).
	cellEffects add: (CellEfect on: 7 of: SpeedUpEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: 10 and: 4 with: cellEffects.
	
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
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 2.
	

]

{ #category : #tests }
BoardGameTest >> test34WhenACellIsWormHoleThenSpaceshipMovesBackwardsFourPositions [

	| aCellEfect spaceships aBoard aBoardGame cellEffects |
	aCellEfect := CellEfect on: 6 of: WormHoleEffect new.
	cellEffects := OrderedCollection new. 
	cellEffects add: aCellEfect.
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: 10 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 2.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.
]

{ #category : #tests }
BoardGameTest >> test35WhenABoardOfTwoCellsAndASpaceshipLandsOnWormHoleThenGoesBackTwoRounds [

	| aCellEfect spaceships aBoard aBoardGame cellEffects |
	aCellEfect := CellEfect on: 1 of: WormHoleEffect new.
	cellEffects := OrderedCollection new.
	cellEffects add: aCellEfect.
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: 2 and: 4 with: cellEffects.
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
BoardGameTest >> test35WhenASpaceshipInRoundOneLandsOnWormHoleAndInPositionLessThanFourThenGoesToStart [

	| aCellEfect spaceships aBoard aBoardGame cellEffects |
	aCellEfect := CellEfect on: 3 of: WormHoleEffect new.
	cellEffects := OrderedCollection new. 
	cellEffects add: aCellEfect.
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: 10 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 2 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.
]

{ #category : #tests }
BoardGameTest >> test35WhenASpaceshipLandsOnWormHoleThenChangesRoundAndPosition [

	| aCellEfect spaceships aBoard aBoardGame cellEffects |
	aCellEfect := CellEfect on: 2 of: WormHoleEffect new.
	cellEffects := OrderedCollection new. 
	cellEffects add: aCellEfect.
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: 8 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 9 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 6.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.
]

{ #category : #tests }
BoardGameTest >> test36WhenACellIsAtomicBombThenSpaceshipsMovesBackwardsToStart [

	| aCellEfect spaceships aBoard aBoardGame cellEffects |
	aCellEfect := CellEfect on: 6 of: AtomicBombEffect new.
	cellEffects := OrderedCollection new. 
	cellEffects add: aCellEfect.
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: 10 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.
]

{ #category : #tests }
BoardGameTest >> test37WhenACellIsAtomicBombThenAllSpaceshipsMovesBackwardsToStart [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.
	cellEffects add: (CellEfect on: 6 of: AtomicBombEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: 10 and: 2 with: cellEffects.
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
BoardGameTest >> test38WhenASpacehipLandsOnMoonWalkThenSpaceshipPositionDoesNotChange [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect |
	cellEffects := OrderedCollection new.
	aMoonWalkEffect:= MoonWalkEffect with: 5.
	cellEffects add: (CellEfect on: 6 of: aMoonWalkEffect).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: 10 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 6.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.

]

{ #category : #tests }
BoardGameTest >> test39WhenASpaceshipLandsOnMoonWalkThenOtherSpaceshipsChangePositions [

	| spaceships aBoard aBoardGame cellEffects aMoonWalkEffect |
	cellEffects := OrderedCollection new.
	aMoonWalkEffect:= MoonWalkEffect with: 5.
	cellEffects add: (CellEfect on: 6 of: aMoonWalkEffect).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: 10 and: 2 with: cellEffects.
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
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.

]

{ #category : #tests }
BoardGameTest >> test40WhenASpaceshipsLandOnWormHoleEffectAndLandsOnCellWithEffectThenEffectNotApplied [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new. 
	cellEffects add: (CellEfect on: 6 of: WormHoleEffect new).
	cellEffects add: (CellEfect on: 2 of: SpeedUpEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: 10 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 2.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.
]

{ #category : #tests }
BoardGameTest >> test41WhenAGameIsPlayedWithCellsEffectThenSpaceshipsRanking [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new. 
	cellEffects add: (CellEfect on: 6 of: WormHoleEffect new).
	cellEffects add: (CellEfect on: 2 of: SpeedUpEffect new).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	aBoard := LoadedBoard of: 10 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 5 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Delfi'.

	self assert: (aBoardGame ranking) equals: (OrderedCollection with: 'Cami' with: 'Delfi' with: 'Vicky').
]

{ #category : #tests }
BoardGameTest >> test42WhenAGameIsPlayedThenSpaceshipsRanking [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	aBoard := LoadedBoard of: 10 and: 2 with: OrderedCollection new. 
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 15 18 9 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Delfi'.
	
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 6.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 2.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 9.
	self assert: (aBoardGame spaceshipRound: 'Cami') equals: 2.
	
	self assert: (aBoardGame spaceshipPosition: 'Delfi') equals: 10.
	self assert: (aBoardGame spaceshipRound: 'Delfi') equals: 1.

	self assert: (aBoardGame ranking) equals: (OrderedCollection with: 'Cami' with: 'Vicky' with: 'Delfi').
]

{ #category : #tests }
BoardGameTest >> test43WhenAGameIsPlayedWithTwoSpaceshipsThenRanking [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: 10 and: 2 with: OrderedCollection new. 
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 15 18 9 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 6.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 2.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 9.
	self assert: (aBoardGame spaceshipRound: 'Cami') equals: 2.

	self assert: (aBoardGame ranking) equals: (OrderedCollection with: 'Cami' with: 'Vicky').
]

{ #category : #tests }
BoardGameTest >> test45ASpaceshipLandsOnHyperJumpThenMovesOneCell [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect:= HyperJumpEffect with: (OrderedCollection with: 5).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: 5 with:15 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 5 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 3.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.


]

{ #category : #tests }
BoardGameTest >> test46ASpaceshipLandsOnHyperJumpThenMovesTwoRounds [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect:= HyperJumpEffect with: (OrderedCollection with: 5).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: 5 with:15 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 5 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 3.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.


]

{ #category : #tests }
BoardGameTest >> test47ASpaceshipLandsOnHyperJumpThenMovesTwoCells [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect:= HyperJumpEffect with: (OrderedCollection with: 6).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: 5 with:15 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 5 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 4.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.


]

{ #category : #tests }
BoardGameTest >> test48WhenTwoSpaceshipsLandsOnHyperJumpThenMovesToTheirNewPositions [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect:= HyperJumpEffect with: (OrderedCollection with: 6 with: 5).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: 5 with:15 and: 2 with: cellEffects.
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
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 2.

]

{ #category : #tests }
BoardGameTest >> test49WhenASpaceshipLandsInAHyperJumpWithNegativeValuesThenMovesBackwards [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect:= HyperJumpEffect with: (OrderedCollection with: -4).
	cellEffects add: (CellEfect on: 3 of: aHyperJumpEffect).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: 5 with:15 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 2 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.
	

]

{ #category : #tests }
BoardGameTest >> test50WhenASpaceshipLandsInHyperJumpInRoundOneThenMovesToInitialPosition [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect:= HyperJumpEffect with: (OrderedCollection with: -5).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := LoadedBoard of: 5 with:15 and: 2 with: cellEffects.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.
	

]

{ #category : #tests }
BoardGameTest >> test51WhenSpaceshipLandsInHyperJumpThenGoesBackTwoRounds [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	cellEffects := OrderedCollection new.
	aHyperJumpEffect:= HyperJumpEffect with: (OrderedCollection with: -30).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: 5 with:15 and: 4 with: cellEffects.
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
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 1.
	

]

{ #category : #tests }
BoardGameTest >> test52 [

	| spaceships aBoard aBoardGame cellEffects aHyperJumpEffect |
	
	cellEffects := OrderedCollection new.
	aHyperJumpEffect:= HyperJumpEffect with: (OrderedCollection with: -30).
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: aHyperJumpEffect).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	aBoard := LoadedBoard of: cellEffects with:15 and: 4.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 10 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 3.
	
	

]

{ #category : #tests }
BoardGameTest >> test52WhenCreationOfLoadedBoardThenValid [

	| spaceships aBoard aBoardGame cellEffects |
	cellEffects := OrderedCollection new.
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: SpeedUpEffect new).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	
	aBoard := LoadedBoard of: cellEffects with:15 and: 4.
	aBoardGame := BoardGame
		              of: aBoard
		              with: spaceships
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 1 3 ))).

	aBoardGame aSpaceshipPlays: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 1.
	self assert: (aBoardGame spaceshipRound: 'Vicky') equals: 2.
]
