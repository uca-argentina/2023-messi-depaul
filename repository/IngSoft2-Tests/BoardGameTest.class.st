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
BoardGameTest >> test03WhenASpaceshipCreationInitializeWithPositionCeroThenTrue [
|aSpaceship|
aSpaceship := Spaceship startsInPositionZero.
self assert: (aSpaceship position) equals: 0.
]

{ #category : #tests }
BoardGameTest >> test04WhenIsASpaceshipIsAddedToBoardgame [

| aBoardGame aSpaceship |
aBoardGame := BoardGame withAnAmountOfCells: 20.
aSpaceship := Spaceship startsInPositionZero.
self assert: (aBoardGame add: aSpaceship)
]

{ #category : #tests }
BoardGameTest >> test05whenASpaceshipMovesForward5PositionsThenTrue [

| aSpaceship |
aSpaceship := Spaceship startsInPositionZero.
aSpaceship movesForward: 5.
self assert: aSpaceship position equals: 5.
]

{ #category : #tests }
BoardGameTest >> test06WhenSpaceship1Wins [
| aBoardGame aSpaceship2 aSpaceship1 spaceships |
aBoardGame := BoardGame withAnAmountOfCells: 20.
aSpaceship1 := Spaceship startsInPositionZero.
aSpaceship2 := Spaceship startsInPositionZero.
aSpaceship1 movesForward: 5.
aSpaceship1 movesForward: 15.
spaceships := OrderedCollection new.
spaceships add: aSpaceship1.
spaceships add: aSpaceship2.

self assert: (aBoardGame winner: spaceships) equals: aSpaceship1.
]

{ #category : #tests }
BoardGameTest >> test07WhenAThreeFacedDiceCreationThenTrue [
| aDice |
aDice := Dice with: 3.
self assert: aDice faces equals: 3.

]

{ #category : #tests }
BoardGameTest >> test08WhenADiceThrowsThenItIsARandomBetweenOneAndHisAmountOfFaces [
| aDice |
aDice := Dice with: 10.
self assert: ((aDice throw) between: 1 and: (aDice faces)).

]

{ #category : #tests }
BoardGameTest >> test09WhenAThreeFacedLoadedDiceWithASequenceCreationThenTrue [
|aLoadedDice|
aLoadedDice := LoadedDice with: 3 andWith: #(1 2 3).
self assert: aLoadedDice faces equals: 3.

]

{ #category : #tests }
BoardGameTest >> test10 [
|aLoadedDice|
aLoadedDice := LoadedDice with: 3 andWith: #(1 2 3).
self assert: aLoadedDice throw equals: 1.
self assert: aLoadedDice throw equals: 2.
self assert: aLoadedDice throw equals: 3.
self assert: aLoadedDice throw equals: 1.

]
