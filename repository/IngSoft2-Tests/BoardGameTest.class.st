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
|aLoadedDie aSpaceship|
aSpaceship := Spaceship startsInPositionZero.
aLoadedDie := LoadedDie of: #(4 3).
self should: [ BoardGame of: -10 with: aSpaceship andWith: aLoadedDie] raise: Error withMessage: 'Cannot create board with a negative amount of cells'.
]

{ #category : #tests }
BoardGameTest >> test03WhenASpaceshipCreationInitializeWithPositionZeroThenPositionZero [
|aSpaceship|
aSpaceship := Spaceship startsInPositionZero.
self assert: (aSpaceship position) equals: 0.
]

{ #category : #tests }
BoardGameTest >> test04WhenAThreeFacedDieCreationThenTrue [
| aDie |
aDie := Die of: 3.
self assert: aDie faces equals: 3.

]

{ #category : #tests }
BoardGameTest >> test05WhenADieIsCreatedWithNegativeFacesThenFailsCreation [
self should: [ Die of: 1 ] raise: Error withMessage: 'Cannot create dice with 2 or less amount of faces'.


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
self should: [ LoadedDie of: #(-1)] raise: Error withMessage: 'Cannot create dice with value less than 0'.
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

	| aBoardGame |
	aBoardGame := BoardGame
		              of: 10
		              with:
		              (OrderedCollection with:
			               Spaceship startsInPositionZero)
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).

	aBoardGame spaceshipPlays.
	self assert: (aBoardGame spaceships at: 1) position equals: 1.

	aBoardGame spaceshipPlays.
	self assert: (aBoardGame spaceships at: 1) position equals: 3.
]

{ #category : #tests }
BoardGameTest >> test11WhenALoadedDieIsThrownThenASpaceshipMovesForwardThreePosition [

	| aBoardGame |
	aBoardGame := BoardGame
		              of: 10
		              with:
		              (OrderedCollection with:
			               Spaceship startsInPositionZero)
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).

	aBoardGame spaceshipPlays.
	self assert: (aBoardGame spaceships at: 1) position equals: 1.

	aBoardGame spaceshipPlays.
	self assert: (aBoardGame spaceships at: 1) position equals: 3.
]

{ #category : #tests }
BoardGameTest >> test12WhenASpaceshipWinsThenGameOver [
| aBoardGame |
	aBoardGame := BoardGame
		              of: 3
		              with: (OrderedCollection
				               with: Spaceship startsInPositionZero
				               with: Spaceship startsInPositionZero)
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).

aBoardGame spaceshipPlays.
aBoardGame spaceshipPlays.
aBoardGame spaceshipPlays.

self should: [ aBoardGame spaceshipPlays ] raise: Error withMessage: 'There is a winner, you cant keep moving forward'.



]

{ #category : #tests }
BoardGameTest >> test13WhenTwoSpaceshipPlayThenSpaceship1Wins [

	| aBoardGame |
	aBoardGame := BoardGame
		              of: 3
		              with: (OrderedCollection
				               with: Spaceship startsInPositionZero
				               with: Spaceship startsInPositionZero)
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).

	aBoardGame spaceshipPlays.
	aBoardGame spaceshipPlays.
	aBoardGame spaceshipPlays.

	self assert: aBoardGame aWinner equals: (aBoardGame spaceships at: 1)
]

{ #category : #tests }
BoardGameTest >> test14WhenAllSpaceshipsPositionsThenAnOrderedCollection [

	| aBoardGame |
	aBoardGame := BoardGame
		              of: 10
		              with: (OrderedCollection
				               with: Spaceship startsInPositionZero
				               with: Spaceship startsInPositionZero)
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).
		
	aBoardGame spaceshipPlays.
	aBoardGame spaceshipPlays.
	aBoardGame spaceshipPlays.


	self
		assert: aBoardGame positions
		equals: (OrderedCollection with: 4 with: 2)
]

{ #category : #tests }
BoardGameTest >> test15WhenThereAreTwoDieOnTheGameThenSpaceshipsPositionsTrue [
| aBoardGame |
	aBoardGame := BoardGame
		              of: 10
		              with: (OrderedCollection
				               with: Spaceship startsInPositionZero
				               with: Spaceship startsInPositionZero)
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )) with: (LoadedDie of: #( 1 2 3 ))).

aBoardGame spaceshipPlays.
aBoardGame spaceshipPlays.
aBoardGame spaceshipPlays.

self assert: ((aBoardGame spaceships at: 1) position) equals: 8.
self assert: ((aBoardGame spaceships at: 2) position) equals: 4.
]

{ #category : #tests }
BoardGameTest >> test16WhenThreeSpaceshipsThrowThreeDieThenCorrectPositions [

	| aBoardGame |
	aBoardGame := BoardGame
		              of: 30
		              with: (OrderedCollection
				               with: Spaceship startsInPositionZero
				               with: Spaceship startsInPositionZero
				               with: Spaceship startsInPositionZero)
		              andWith: (OrderedCollection
				               with: (LoadedDie of: #( 1 2 3 ))
				               with: (LoadedDie of: #( 4 5 ))
				               with: (LoadedDie of: #( 6 ))).


	aBoardGame spaceshipPlays.
	aBoardGame spaceshipPlays.
	aBoardGame spaceshipPlays.
	aBoardGame spaceshipPlays.

	self assert: (aBoardGame spaceships at: 1) position equals: 23.
	self assert: (aBoardGame spaceships at: 2) position equals: 13.
	self assert: (aBoardGame spaceships at: 3) position equals: 13
]

{ #category : #tests }
BoardGameTest >> test17WhenBoardGameHasTwoDieThenCollectionOfDieCorrectSize [

	| aBoardGame |
	aBoardGame := BoardGame
		              of: 10
		              with: (OrderedCollection
				               with: Spaceship startsInPositionZero
				               with: Spaceship startsInPositionZero)
		              andWith:
		              (OrderedCollection
			               with: (Die of: 3)
			               with: (Die of: 3)).

	aBoardGame spaceshipPlays.
	aBoardGame spaceshipPlays.
	aBoardGame spaceshipPlays.

	self assert: aBoardGame dice size equals: 2
]

{ #category : #tests }
BoardGameTest >> test20When2RoundsArePlayedThenSpaceshipsMovesForwardAmountOfCells [

	| aBoardGame |
	aBoardGame := BoardGame
		              of: 20
		              with: (OrderedCollection
				               with: Spaceship startsInPositionZero
				               with: Spaceship startsInPositionZero
				               with: Spaceship startsInPositionZero)
		              andWith:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 ))).

	aBoardGame spaceshipPlays.
	self assert: (aBoardGame spaceships at: 1) position equals: 1.
	aBoardGame spaceshipPlays.
	self assert: (aBoardGame spaceships at: 2) position equals: 2.
	aBoardGame spaceshipPlays.
	self assert: (aBoardGame spaceships at: 3) position equals: 3.
	aBoardGame spaceshipPlays.
	self assert: (aBoardGame spaceships at: 1) position equals: 2.
	aBoardGame spaceshipPlays.
	self assert: (aBoardGame spaceships at: 2) position equals: 4.
	aBoardGame spaceshipPlays.
	self assert: (aBoardGame spaceships at: 3) position equals: 6
]
