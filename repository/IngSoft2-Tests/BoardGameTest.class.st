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
BoardGameTest >> testABoardGameCreationIsValid [
| aBoard aBoardGame |
aBoard := Board withAnAmountOfCells: 10.
aBoardGame := BoardGame with: aBoard and: Spaceship new.
self assert: aBoardGame isValid.
]

{ #category : #tests }
BoardGameTest >> testBanana [
| aSpaceship aPosition |
aSpaceship := Spaceship new.
aPosition := Position new.

self assert: (aPosition whereItIs: aSpaceship ).
]

{ #category : #tests }
BoardGameTest >> testSpaceshipInitializeInZeroviCKylisto [
| aSpaceship aPosition aPositionSpaceship |
aSpaceship := Spaceship new.
aPosition:= Position new.
aPositionSpaceship := SpaceshipPosition withPosition: 0.

self assert: (aPosition isValid: aPositionSpaceship).
]

{ #category : #tests }
BoardGameTest >> testWhenABoardCreationThenIsValid [
| aBoard |
aBoard := Board new.
self assert: aBoard isValid.
]

{ #category : #tests }
BoardGameTest >> testWhenABoardCreationWith10CellsThenIsValid [
| aBoard |
aBoard := Board withAnAmountOfCells: 10.
self assert: aBoard isValid.
]

{ #category : #tests }
BoardGameTest >> testWhenABoardGameCreationWith2SpaceshipsThenValid [
| aBoard aBoardGame spaceships |
aBoard := Board withAnAmountOfCells: 10.
spaceships:= OrderedCollection with: Spaceship new with: Spaceship new.
aBoardGame := BoardGame with: aBoard and: spaceships.
self assert: aBoardGame isValid.
]

{ #category : #tests }
BoardGameTest >> testWhenABoardWithNegativeAmountOfCellsThenFailsCreation [
self should: [ Board withAnAmountOfCells: -10 ] raise: Error withMessage: 'Cannot create board with a negative amount of cells'.
]

{ #category : #tests }
BoardGameTest >> testWhenSpaceshipCreationThenIsValid [

| aSpaceship |
aSpaceship:= Spaceship new.
self assert: aSpaceship isValid.
]
