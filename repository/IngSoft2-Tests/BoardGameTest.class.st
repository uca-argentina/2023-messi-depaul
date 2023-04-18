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
BoardGameTest >> testWhenASpaceshipAdvanceOnePositionThenTrue [
|aSpaceship|
aSpaceship := Spaceship withPosition: 0.
aSpaceship advanceAnAmountOfCells: 1.

self assert: (aSpaceship whereIsMyPosition) equals: 1.
]

{ #category : #tests }
BoardGameTest >> testWhenASpaceshipCreationWithPositionCeroThenTrue [
|aSpaceship|
aSpaceship := Spaceship withPosition: 0.

self assert: (aSpaceship whereIsMyPosition) equals: 0.
]

{ #category : #tests }
BoardGameTest >> testWhenASpaceshipHasWonTheGameThenTrue [
| aBoard aBoardGame spaceships aSpaceship1 aSpaceship2 |
aBoard := Board withAnAmountOfCells: 10.
aSpaceship1 := Spaceship withPosition: 10.
aSpaceship2 := Spaceship withPosition: 0.
spaceships:= OrderedCollection with: aSpaceship1 with: aSpaceship2.
aBoardGame := BoardGame with: aBoard and: spaceships.

self assert: aBoardGame hasAnySpaceshipWon equals: aSpaceship1.
]

{ #category : #tests }
BoardGameTest >> testWhenSpaceshipCreationThenIsValid [

| aSpaceship |
aSpaceship:= Spaceship new.
self assert: aSpaceship isValid.
]
