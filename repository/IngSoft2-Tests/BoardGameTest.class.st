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
BoardGameTest >> testWhenABoardWithNegativeAmountOfCellsThenFailsCreation [
self should: [ Board withAnAmountOfCells: -10 ] raise: Error withMessage: 'Cannot create board with a negative amount of cells'.
]

{ #category : #tests }
BoardGameTest >> testWhenSpaceshipCreationThenIsValid [

| aSpaceship |
aSpaceship:= Spaceship new.
self assert: aSpaceship isValid.
]
