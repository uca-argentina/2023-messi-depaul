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
BoardGameTest >> test01ABoardGameCreationIsValid [
| aBoardGame |
aBoardGame := BoardGame withAnAmountOfCells: 20.
self assert: aBoardGame isValid.
]

{ #category : #tests }
BoardGameTest >> test02WhenABoardWithNegativeAmountOfCellsThenFailsCreation [
self should: [ BoardGame withAnAmountOfCells: -10 ] raise: Error withMessage: 'Cannot create board with a negative amount of cells'.
]

{ #category : #tests }
BoardGameTest >> test03WhenASpaceshipCreationInitializeWithPositionZeroThenPositionZero [
|aSpaceship|
aSpaceship := Spaceship startsInPositionZero.
self assert: (aSpaceship position) equals: 0.
]

{ #category : #tests }
BoardGameTest >> test04WhenAThreeFacedDiceCreationThenTrue [
| aDice |
aDice := Dice with: 3.
self assert: aDice faces equals: 3.

]

{ #category : #tests }
BoardGameTest >> test05WhenADiceIsCreatedWithNegativeFacesThenFailsCreation [
self should: [ Dice with: 1 ] raise: Error withMessage: 'Cannot create dice with 2 or less amount of faces'.


]

{ #category : #tests }
BoardGameTest >> test06WhenADiceThrowsThenItIsARandomBetweenOneAndHisAmountOfFaces [
| aDice |
aDice := Dice with: 10.
self assert: ((aDice throw) between: 1 and: (aDice faces)).

]

{ #category : #tests }
BoardGameTest >> test07WhenALoadedDiceSequenceCreationThenTrue [
|aLoadedDice|
aLoadedDice := LoadedDice with: #(1 2 3).
self assert: aLoadedDice sequence equals: #(1 2 3).

]

{ #category : #tests }
BoardGameTest >> test08WhenALoadedDiceWithNegativeSequenceThenFailsCreation [
self should: [ LoadedDice with: #(-1)] raise: Error withMessage: 'Cannot create dice with value less than 0'.
]

{ #category : #tests }
BoardGameTest >> test09WhenALoadedDiceIsThrown4TimesWithSequenceValues1231ThenTrue [
|aLoadedDice|
aLoadedDice := LoadedDice with: #(1 2 3) .
self assert: aLoadedDice throw equals: 1.
self assert: aLoadedDice throw equals: 2.
self assert: aLoadedDice throw equals: 3.
self assert: aLoadedDice throw equals: 1.

]

{ #category : #tests }
BoardGameTest >> test10WhenALoadedDiceIsThrownThenASpaceshipMovesForwardOnePosition [
|aLoadedDice aSpaceship aBoardGame|
aSpaceship := Spaceship startsInPositionZero.
aLoadedDice := LoadedDice with: #(1 2 3).
aBoardGame := BoardGame withAnAmountOfCells: 10.

aBoardGame insert: aSpaceship .
aBoardGame insertDices: aLoadedDice.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.

self assert: aSpaceship position equals: 1.


]

{ #category : #tests }
BoardGameTest >> test11When2RoundsArePlayedThenSpaceshipsMovesForwardAmountOfCells [
| aBoardGame aSpaceship1 aSpaceship2 aSpaceship3 aLoadedDice|
aLoadedDice := LoadedDice with: #(1 2 3).

aBoardGame := BoardGame withAnAmountOfCells: 20.

aSpaceship1 := Spaceship startsInPositionZero.
aSpaceship2 := Spaceship startsInPositionZero.
aSpaceship3 := Spaceship startsInPositionZero.

aBoardGame insert: aSpaceship1.
aBoardGame insert: aSpaceship2.
aBoardGame insert: aSpaceship3.

aBoardGame aSpaceshipMovesForward: aLoadedDice throw.
self assert: (aSpaceship1 position) equals: 1.
aBoardGame aSpaceshipMovesForward: aLoadedDice throw.
self assert: (aSpaceship2 position) equals: 2.
aBoardGame aSpaceshipMovesForward: aLoadedDice throw.
self assert: (aSpaceship3 position) equals: 3.
aBoardGame aSpaceshipMovesForward: aLoadedDice throw.
self assert: (aSpaceship1 position) equals: 2.
aBoardGame aSpaceshipMovesForward: aLoadedDice throw.
self assert: (aSpaceship2 position) equals: 4.
aBoardGame aSpaceshipMovesForward: aLoadedDice throw.
self assert: (aSpaceship3 position) equals: 6.





]

{ #category : #tests }
BoardGameTest >> test12WhenASpaceshipWinsThenGameOver [
| aBoardGame aSpaceship1 aSpaceship2 aLoadedDice|
aLoadedDice := LoadedDice with: #(1 2 3).

aBoardGame := BoardGame withAnAmountOfCells: 3.

aSpaceship1 := Spaceship startsInPositionZero.
aSpaceship2 := Spaceship startsInPositionZero.

aBoardGame insert: aSpaceship1.
aBoardGame insert: aSpaceship2.

aBoardGame insertDices: aLoadedDice.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.

self should: [ aBoardGame aSpaceshipMovesForward: aLoadedDice throw ] raise: Error withMessage: 'There is a winner, stop playing'.



]

{ #category : #tests }
BoardGameTest >> test13WhenTwoSpaceshipPlayThenSpaceship1Wins [
| aBoardGame aSpaceship1 aSpaceship2 aLoadedDice|
aLoadedDice := LoadedDice with: #(1 2 3).

aBoardGame := BoardGame withAnAmountOfCells: 3.

aSpaceship1 := Spaceship startsInPositionZero.
aSpaceship2 := Spaceship startsInPositionZero.

aBoardGame insert: aSpaceship1.
aBoardGame insert: aSpaceship2.

aBoardGame insertDices: aLoadedDice.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.

self assert: (aBoardGame aWinner) equals: aSpaceship1.
]

{ #category : #tests }
BoardGameTest >> test14WhenAllSpaceshipsPositionsThenAnOrderedCollection [
| aBoardGame aSpaceship1 aSpaceship2 aLoadedDice|
aLoadedDice := LoadedDice with: #(1 2 3).

aBoardGame := BoardGame withAnAmountOfCells: 10.

aSpaceship1 := Spaceship startsInPositionZero.
aSpaceship2 := Spaceship startsInPositionZero.

aBoardGame insert: aSpaceship1.
aBoardGame insert: aSpaceship2.

aBoardGame insertDices: aLoadedDice.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.


self assert: (aBoardGame allSpaceshipPositions) equals: (OrderedCollection with: 4 with: 2) .
]

{ #category : #tests }
BoardGameTest >> test15WhenThereAreTwoDicesOnTheGameThenSpaceshipsPositionsTrue [
| aBoardGame aSpaceship1 aSpaceship2 aLoadedDice1 aLoadedDice2|
aLoadedDice1 := LoadedDice with: #(1 2 3).
aLoadedDice2 := LoadedDice with: #(1 2 3).

aBoardGame := BoardGame withAnAmountOfCells: 10.

aSpaceship1 := Spaceship startsInPositionZero.
aSpaceship2 := Spaceship startsInPositionZero.

aBoardGame insert: aSpaceship1.
aBoardGame insert: aSpaceship2.

aBoardGame insertDices: aLoadedDice1.
aBoardGame insertDices: aLoadedDice2.

aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.

self assert: (aSpaceship1 position) equals: 8.
self assert: (aSpaceship2 position) equals: 4.
]

{ #category : #tests }
BoardGameTest >> test16WhenThreeSpaceshipsThrowThreeDicesThenCorrectPositions [
| aBoardGame aSpaceship1 aSpaceship2 aLoadedDice1 aLoadedDice2 aLoadedDice3 aSpaceship3 |
aLoadedDice1 := LoadedDice with: #(1 2 3).
aLoadedDice2 := LoadedDice with: #(4 5).
aLoadedDice3 := LoadedDice with: #(6).

aBoardGame := BoardGame withAnAmountOfCells: 30.

aSpaceship1 := Spaceship startsInPositionZero.
aSpaceship2 := Spaceship startsInPositionZero.
aSpaceship3 := Spaceship startsInPositionZero.

aBoardGame insert: aSpaceship1.
aBoardGame insert: aSpaceship2.
aBoardGame insert: aSpaceship3.

aBoardGame insertDices: aLoadedDice1 .
aBoardGame insertDices: aLoadedDice2 .
aBoardGame insertDices: aLoadedDice3 .

aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.

self assert: (aSpaceship1 position) equals: 23.
self assert: (aSpaceship2 position) equals: 13.
self assert: (aSpaceship3 position) equals: 13.
]

{ #category : #tests }
BoardGameTest >> test17WhenBoardGameHasTwoDicesThenCollectionOfDicesCorrectSize [
| aBoardGame aSpaceship1 aSpaceship2 aDice1 aDice2 |
aDice1 := Dice with: 3.
aDice2 := Dice with: 3.

aBoardGame := BoardGame withAnAmountOfCells: 10.

aSpaceship1 := Spaceship startsInPositionZero.
aSpaceship2 := Spaceship startsInPositionZero.

aBoardGame insert: aSpaceship1.
aBoardGame insert: aSpaceship2.

aBoardGame insertDices: aDice1.
aBoardGame insertDices: aDice2.

aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.
aBoardGame aSpaceshipMovesForward: aBoardGame throwDices.

]
