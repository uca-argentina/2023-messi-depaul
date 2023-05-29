Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
DieTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
			self assert: error messageText equals: anErrorMessage ].
]

{ #category : #tests }
DieTest >> test02WhenAGameIsPlayedWithDifferentFacedDiceThenSpaceshipPositions [
|spaceships aBoard aBoardGame cellEffects |
	
	cellEffects := OrderedCollection new. 
	cellEffects add: (CellEfect on: 1 of: NoEffect new).
	cellEffects add: (CellEfect on: 2 of: NoEffect new).
	cellEffects add: (CellEfect on: 3 of: NoEffect new).
	cellEffects add: (CellEfect on: 4 of: NoEffect new).
	cellEffects add: (CellEfect on: 5 of: NoEffect new).
	cellEffects add: (CellEfect on: 6 of: NoEffect new).
	cellEffects add: (CellEfect on: 7 of: NoEffect new).
	cellEffects add: (CellEfect on: 8 of: NoEffect new).
	cellEffects add: (CellEfect on: 9 of: NoEffect new).
	cellEffects add: (CellEfect on: 10 of: NoEffect new).
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	
	aBoard := Board of: cellEffects withLenght: 15.
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )) with: (LoadedDie of: #( 4 5 )))
		              on: aBoard
		              with: 2.		

	aBoardGame aSpaceshipPlays: 'Vicky'.
	aBoardGame aSpaceshipPlays: 'Cami'.
	aBoardGame aSpaceshipPlays: 'Vicky'.

self assert: (aBoardGame spaceshipPosition: 'Vicky') equals: 3.
self assert: (aBoardGame spaceshipPosition: 'Cami') equals: 8.
]

{ #category : #tests }
DieTest >> test03WhenADieIsCreatedWithNegativeFacesThenFailsCreation [
self should: [ Die of: 1 ] raise: Error withMessage: 'Cannot create die with 2 or less amount of faces'.


]

{ #category : #tests }
DieTest >> test04WhenADieThrowsThenItIsARandomBetweenOneAndHisAmountOfFaces [
| aDie |
aDie := Die of: 10.
self assert: ((aDie throw) between: 1 and: (aDie faces)).

]

{ #category : #tests }
DieTest >> test05WhenALoadedDieIsThrown4TimesWithSequenceValues1231ThenSequenceIsValid [
|aLoadedDie|
aLoadedDie := LoadedDie of: #(1 2 3) .
self assert: aLoadedDie throw equals: 1.
self assert: aLoadedDie throw equals: 2.
self assert: aLoadedDie throw equals: 3.
self assert: aLoadedDie throw equals: 1.

]

{ #category : #tests }
DieTest >> test06WhenALoadedDieWithNegativeSequenceThenFailsCreation [
self should: [ LoadedDie of: #(-1)] raise: Error withMessage: 'Cannot create die with value less than 0'.
]