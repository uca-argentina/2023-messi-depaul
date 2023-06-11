Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#instVars : [
		'cellEffects',
		'anOverloadCard',
		'aSpeedCard',
		'anAccelerationCard',
		'aCancellationCard',
		'aRepeatCard',
		'aRedoCard',
		'aDeckOfCards'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
CardTest >> setUp [
	super setUp.
	cellEffects := OrderedCollection new.
	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: CardEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: AtomicBombEffect new).
	cellEffects add: (Cell on: 10 of: SpeedUpEffect new).
	
	aDeckOfCards := OrderedCollection new.
	
	anOverloadCard := OverloadCard new.
	aSpeedCard := SpeedCard new.
	anAccelerationCard := AccelerationCard new.
	aCancellationCard := CancellationCard new.
	aRepeatCard := RepeatCard new.
	aRedoCard := RedoCard new.
	
]

{ #category : #tests }
CardTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
			self assert: error messageText equals: anErrorMessage ].
			
			
		
]

{ #category : #tests }
CardTest >> test01WhenASpaceshipPlaysASpeedCardThenStaysOnTheGame [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).
	aDeckOfCards add: aSpeedCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.


	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.
	
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 6
]

{ #category : #tests }
CardTest >> test02WhenTwoSpeedCardsAffectASpaceshipThenSpaceshipMovesAffected [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: aSpeedCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 5.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 8
]

{ #category : #tests }
CardTest >> test03WhenSpaceshipTriesToThrowSpeedCardThenCannotThrowIt [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).
	
	aDeckOfCards add: aSpeedCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.

	self
		should: [ aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami' ]
		raise: Error
		withMessage: 'You do not have that card'
]

{ #category : #tests }
CardTest >> test04WhenASpaceshipPlaysOverloadCardThenAffectedSpaceshipIsMovesTwoLessThanTotalDiceThrown [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: anOverloadCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 5 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
		
	aBoardGame throw: anOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4
]

{ #category : #tests }
CardTest >> test05WhenSpaceshipPlaysAccelerationCardThenAllSpaceshipIncrementsOneMove [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: anAccelerationCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	aBoardGame throw: anAccelerationCard from: 'Vicky'.
	
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 3.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4
]

{ #category : #tests }
CardTest >> test06WhenSpaceshipTriesToPlayPermanentCardAndItsNotHisTurnThenCannotThrowIt [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: AccelerationCard new.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	self
		should: [ aBoardGame throw: aSpeedCard from: 'Cami' to: 'Cami'.]
		raise: Error
		withMessage: 'Its not your turn'
]

{ #category : #tests }
CardTest >> test07WhenSpaceshipPlaysDifferentPermanentCardsThenSpaceshipsMovesAreAffected [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: aSpeedCard.
	aDeckOfCards add: anOverloadCard .
	aDeckOfCards add: anAccelerationCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
	
	aBoardGame throw: anOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame throw: anAccelerationCard from: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 3.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 2.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 8
]

{ #category : #tests }
CardTest >> test08WhenSpaceshipTriesToPlayPermanentCardAndItsNotHisTurnThenCannotThrowIt [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: SpeedCard new.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	self
		should: [ 
			aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Delfina' ]
		raise: Error
		withMessage: 'That spaceship doesn´t exists'
]

{ #category : #tests }
CardTest >> test09WhenASpaceshipPlaysACancellationCardThenAffectedSpaceshipMovesWithoutCardEffect [

	| spaceships aBoard aBoardGame aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: aSpeedCard.
	aDeckOfCards add: anOverloadCard.
	aDeckOfCards add: anAccelerationCard.
	aDeckOfCards add: aCancellationCard.

	aSpaceshipCard := SpaceshipCard named: (OrderedCollection with: 'Vicky') with: aSpeedCard. 

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
		
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: anAccelerationCard  from: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.
	
	aBoardGame throw: aCancellationCard from: 'Cami' choosing: aSpaceshipCard. 
	
	aBoardGame playTurnFor: 'Vicky'.
	
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 7.

]

{ #category : #tests }
CardTest >> test10WhenASpaceshipCancelsAccelerationCardThenAllSpaceshipsAreAffected [

	| spaceships aBoard aBoardGame aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: aSpeedCard.
	aDeckOfCards add: anOverloadCard.
	aDeckOfCards add: anAccelerationCard.
	aDeckOfCards add: aCancellationCard.
	aDeckOfCards add: aCancellationCard.


	aSpaceshipCard := SpaceshipCard
		                  named: spaceships
		                  with: anAccelerationCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	aBoardGame throw: anOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.

	aBoardGame throw: anAccelerationCard from: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame
		throw: aCancellationCard
		from: 'Cami'
		choosing: aSpaceshipCard.
	aBoardGame playTurnFor: 'Vicky'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 7
]

{ #category : #tests }
CardTest >> test11WhenASpaceshipLandsOnACardEffectCellThenAnotherCardIsDealed [

	| spaceships aBoard aBoardGame aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: aSpeedCard.
	aDeckOfCards add: anOverloadCard.
	aDeckOfCards add: anAccelerationCard.
	aDeckOfCards add: aCancellationCard.
	aDeckOfCards add: anAccelerationCard.
	
	aSpaceshipCard := SpaceshipCard named: spaceships with: anAccelerationCard.
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 4 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
	
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	aBoardGame throw: anAccelerationCard from: 'Vicky'. 
	aBoardGame playTurnFor: 'Vicky'.
	
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
]

{ #category : #tests }
CardTest >> test12WhenASpaceshipPlaysACancellationCardButThereAreNotPermanentCardOnGameThenCannotPlayCard [

	| spaceships aBoard aBoardGame aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: aCancellationCard.
	aDeckOfCards add: aCancellationCard.
	aDeckOfCards add: aCancellationCard.
	aDeckOfCards add: aCancellationCard.
	aDeckOfCards add: aCancellationCard.

	aSpaceshipCard := SpaceshipCard
		                  named: (OrderedCollection with: 'Vicky')
		                  with: anOverloadCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.


	self
		should: [ aBoardGame throw: aCancellationCard from: 'Vicky' choosing: aSpaceshipCard.   ]
		raise: Error
		withMessage: 'That card does not exist'
]

{ #category : #tests }
CardTest >> test13WhenASpaceshipPlaysCancellationCardThenCardDoesNotExists [

	| spaceships aBoard aBoardGame aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: aSpeedCard.
	aDeckOfCards add: anOverloadCard.
	aDeckOfCards add: anAccelerationCard.
	aDeckOfCards add: aCancellationCard.

	aSpaceshipCard := SpaceshipCard
		                  named: (OrderedCollection with: 'Vicky')
		                  with: anOverloadCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
	
	aBoardGame throw: anOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame throw: anAccelerationCard from: 'Cami'. 	

	self
		should: [ aBoardGame throw: aCancellationCard from: 'Cami' choosing:aSpaceshipCard ]
		raise: Error
		withMessage: 'That card does not exist'
]

{ #category : #tests }
CardTest >> test14WhenASpaceshipsThrowsARedoAndLastCardASpeedThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: aSpeedCard.
	aDeckOfCards add: aRedoCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.


	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aRedoCard from: 'Vicky' to: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 3.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4
]

{ #category : #tests }
CardTest >> test15WhenASpaceshipsThrowsARedoAndLastCardAOverloadThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: anOverloadCard.
	aDeckOfCards add: aRedoCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 9 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.


	
	aBoardGame throw: anOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aRedoCard from: 'Vicky' to: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 8.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 1.
]

{ #category : #tests }
CardTest >> test16WhenASpaceshipsThrowsTwoRedoAndLastCardASpeedThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: RedoCard new.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.



	aBoardGame throw: SpeedCard new from: 'Vicky' to: 'Cami'.
	aBoardGame throw: RedoCard new from: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: RedoCard new from: 'Cami' to: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 3.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 5
]

{ #category : #tests }
CardTest >> test17WhenASpaceshipsThrowsARedoAndLastCardAAccelerationThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: anAccelerationCard.
	aDeckOfCards add: aRedoCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.



	aBoardGame throw: anAccelerationCard from: 'Vicky'.
	aBoardGame throw: aRedoCard from: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.

	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 5.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 4.
]

{ #category : #tests }
CardTest >> test18WhenASpaceshipsThrowsARedoAndLastCardACancellationThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame aSpaceshipCard aSpaceshipCard2|
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: aSpeedCard.
	aDeckOfCards add: aCancellationCard.
	aDeckOfCards add: aSpeedCard.
	aDeckOfCards add: aRedoCard.
	
	aSpaceshipCard := SpaceshipCard named: (OrderedCollection with: 'Vicky') with: aSpeedCard. 
	aSpaceshipCard2 := SpaceshipCard named: (OrderedCollection with: 'Vicky') with: aSpeedCard. 

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.


	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.			
	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: aSpeedCard from: 'Cami' to: 'Vicky'.	
	aBoardGame throw: aCancellationCard from: 'Vicky' choosing: aSpaceshipCard.
	
	aBoardGame throw: aRedoCard from: 'Cami' choosing: aSpaceshipCard2.

	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 3.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 3.
]

{ #category : #tests }
CardTest >> test19WhenASpaceshipThrowsRepeatCardAndLastCellEffectSpeedUpThenASpaceshipIsAffected [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: aRepeatCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 9 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 4.
	
	aBoardGame throw: aRepeatCard from: 'Delfi' to: 'Delfi'.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber equals: 5.
	


]

{ #category : #tests }
CardTest >> test20WhenAspaceshipThrowsRepeatCardAndLastCellEffectAtomicBombThenAllSpaceshipsReturnToInitialPosition [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: aRepeatCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 8 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	
	aBoardGame throw: aRepeatCard from: 'Delfi'.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber equals: 1.
	


]

{ #category : #tests }
CardTest >> test21WhenASpaceshipThrowsRepeatCardAndLastCellEffectMoonWalkThenSomeSpaceshipsGoBackwards [

| spaceships aBoard aBoardGame cellEffectsCollection aMoonWalkEffect |
	cellEffectsCollection := OrderedCollection new.
	aMoonWalkEffect := MoonWalkEffect with: 5.

	cellEffectsCollection add: (Cell on: 1 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 2 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 3 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 4 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 5 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 6 of: aMoonWalkEffect).
	cellEffectsCollection add: (Cell on: 7 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 8 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 9 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 10 of: NoEffect new).


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	
	aDeckOfCards add: aRepeatCard.
		
	aBoard := Board of: cellEffectsCollection withLenght: (Parsec withValue: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 7 5 3 )))
		              on: aBoard
		              with: 2 utilizing: aDeckOfCards.

	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 8.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.
	
	aBoardGame throw: aRepeatCard from: 'Delfi' to: 'Vicky'.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	
]

{ #category : #tests }
CardTest >> test22WhenASpaceshipThrowsAnAccelerationCardToAnotherSpaceshipThenCannotThrowCard [

	| spaceships aBoard aBoardGame |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards add: anAccelerationCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
	
	aBoardGame playTurnFor: 'Vicky'.
	
	self should: [aBoardGame throw: anAccelerationCard from: 'Cami'to:'Cami'. ]
		raise: Error
		withMessage: 'You cannot choose a player for acceleration card.'
]

{ #category : #tests }
CardTest >> test23WhenASpaceshipThrowsRepeatCardAndLastCellEffectWormHoleThenASpaceshipGoesBackwards [

| spaceships aBoard aBoardGame cellEffectsCollection |
	cellEffectsCollection := OrderedCollection new.
	
	cellEffectsCollection add: (Cell on: 1 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 2 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 3 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 4 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 5 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 6 of: WormHoleEffect new).
	cellEffectsCollection add: (Cell on: 7 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 8 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 9 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 10 of: NoEffect new).


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	
	aDeckOfCards add: aRepeatCard.
		
	aBoard := Board of: cellEffectsCollection withLenght: (Parsec withValue: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 9 5 3 )))
		              on: aBoard
		              with: 2 utilizing: aDeckOfCards.
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 10.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.
	
	aBoardGame throw: aRepeatCard from: 'Delfi' to: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.
	

	
]

{ #category : #tests }
CardTest >> test24WhenASpaceshipThrowsRepeatCardAndDiceWerentThrownThenNoEffect [

| spaceships aBoard aBoardGame cellEffectsCollection |
	cellEffectsCollection := OrderedCollection new.
	
	cellEffectsCollection add: (Cell on: 1 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 2 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 3 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 4 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 5 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 6 of: WormHoleEffect new).
	cellEffectsCollection add: (Cell on: 7 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 8 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 9 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 10 of: NoEffect new).


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	
	aDeckOfCards add: aRepeatCard.
		
	aBoard := Board of: cellEffectsCollection withLenght: (Parsec withValue: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 9 5 3 )))
		              on: aBoard
		              with: 2 utilizing: aDeckOfCards.
	aBoardGame throw: aRepeatCard from: 'Delfi' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 10.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.
	
	aBoardGame throw: aRepeatCard from: 'Delfi' to: 'Vicky'.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.
	

	
]

{ #category : #tests }
CardTest >> test25WhenASpaceshipThrowsARepeatCardNotIndicatingSpaceshipAndLastCellEffectAMoonWalkThenAppliesToSpaceshipPlaying [

| spaceships aBoard aBoardGame cellEffectsCollection aMoonWalkEffect |
	cellEffectsCollection := OrderedCollection new.
	aMoonWalkEffect := MoonWalkEffect with: 5.
	
	cellEffectsCollection add: (Cell on: 1 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 2 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 3 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 4 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 5 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 6 of: aMoonWalkEffect).
	cellEffectsCollection add: (Cell on: 7 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 8 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 9 of: NoEffect new).
	cellEffectsCollection add: (Cell on: 10 of: NoEffect new).


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	
	aDeckOfCards add: aRepeatCard.
		
	aBoard := Board of: cellEffectsCollection withLenght: (Parsec withValue: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 9 5 5 )))
		              on: aBoard
		              with: 2 utilizing: aDeckOfCards.
	aBoardGame playTurnFor: 'Vicky'.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 10.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.
	
	aBoardGame playTurnFor: 'Delfi'.
	
	aBoardGame throw: aRepeatCard from: 'Delfi'. 
	
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.
	
	self assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') round equals: 1.
	

	
]
