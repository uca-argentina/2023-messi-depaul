Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#instVars : [
		'cellEffects'
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

	| spaceships aBoard aBoardGame aSpeedCard aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).
	aSpeedCard := SpeedCard new.
	aDeckOfCards := OrderedCollection new.
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

	| spaceships aBoard aBoardGame aSpeedCard aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aSpeedCard := SpeedCard new.
	aDeckOfCards := OrderedCollection new.
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

	| spaceships aBoard aBoardGame aSpeedCard aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aSpeedCard := SpeedCard new.
	aDeckOfCards := OrderedCollection new.
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

	| spaceships aBoard aBoardGame aOverloadCard aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aOverloadCard := OverloadCard new.
	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: aOverloadCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 5 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
		
	aBoardGame throw: aOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4
]

{ #category : #tests }
CardTest >> test05WhenSpaceshipPlaysAccelerationCardThenAllSpaceshipIncrementsOneMove [

	| spaceships aBoard aBoardGame aAcelerationCard aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aAcelerationCard := AccelerationCard new.
	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: aAcelerationCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	aBoardGame throw: aAcelerationCard from: 'Vicky'.
	
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

	| spaceships aBoard aBoardGame aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
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
		should: [ aBoardGame throw: SpeedCard new from: 'Cami' to: 'Cami'.]
		raise: Error
		withMessage: 'Its not your turn'
]

{ #category : #tests }
CardTest >> test07WhenSpaceshipPlaysDifferentPermanentCardsThenSpaceshipsMovesAreAffected [

	| spaceships aBoard aBoardGame aDeckOfCards aOverloadCard aSpeedCard aAccelerationCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).
	aOverloadCard := OverloadCard new.
	aSpeedCard := SpeedCard new.
	aAccelerationCard := AccelerationCard new.

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: aSpeedCard.
	aDeckOfCards add: aOverloadCard.
	aDeckOfCards add: aAccelerationCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
	
	aBoardGame throw: aOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame throw: aAccelerationCard from: 'Cami'.
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

	| spaceships aBoard aBoardGame aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
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
			aBoardGame throw: SpeedCard new from: 'Vicky' to: 'Delfina' ]
		raise: Error
		withMessage: 'That spaceship doesn´t exists'
]

{ #category : #tests }
CardTest >> test09WhenASpaceshipPlaysACancellationCardThenAffectedSpaceshipMovesWithoutCardEffect [

	| spaceships aBoard aBoardGame aDeckOfCards aSpaceshipCard aOverloadCard aSpeedCard aAccelerationCard aCancellationCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).
	aOverloadCard := OverloadCard new.
	aSpeedCard := SpeedCard new.
	aAccelerationCard := AccelerationCard new.
	aCancellationCard := CancellationCard new.

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: aSpeedCard.
	aDeckOfCards add: aOverloadCard.
	aDeckOfCards add: aAccelerationCard.
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
	
	aBoardGame throw: aAccelerationCard  from: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.
	
	aBoardGame throw: aCancellationCard  from: 'Cami' choosing: aSpaceshipCard. 
	
	aBoardGame playTurnFor: 'Vicky'.
	
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 7.

]

{ #category : #tests }
CardTest >> test10WhenASpaceshipCancelsAccelerationCardThenAllSpaceshipsAreAffected [

	| spaceships aBoard aBoardGame aDeckOfCards aSpaceshipCard aOverloadCard aSpeedCard aAccelerationCard aCancellationCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aOverloadCard := OverloadCard new.
	aSpeedCard := SpeedCard new.
	aAccelerationCard := AccelerationCard new.
	aCancellationCard := CancellationCard new.

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: aSpeedCard.
	aDeckOfCards add: aOverloadCard.
	aDeckOfCards add: aAccelerationCard.
	aDeckOfCards add: aCancellationCard.
	aDeckOfCards add: aCancellationCard.


	aSpaceshipCard := SpaceshipCard
		                  named: spaceships
		                  with: aAccelerationCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.

	aBoardGame throw: aOverloadCard from: 'Vicky' to: 'Cami'.
	aBoardGame throw: aSpeedCard from: 'Vicky' to: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.

	aBoardGame throw: aAccelerationCard from: 'Cami'.
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

	| spaceships aBoard aBoardGame aDeckOfCards aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: AccelerationCard new.
	aDeckOfCards add: CancellationCard new.
	aDeckOfCards add: AccelerationCard new.
	
	aSpaceshipCard := SpaceshipCard named: spaceships with: AccelerationCard new.
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 4 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
	
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	aBoardGame throw: AccelerationCard new from: 'Vicky'. 
	aBoardGame playTurnFor: 'Vicky'.
	
	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 1.
]

{ #category : #tests }
CardTest >> test12WhenASpaceshipPlaysACancellationCardButThereAreNotPermanentCardOnGameThenCannotPlayCard [

	| spaceships aBoard aBoardGame aDeckOfCards aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.

	aDeckOfCards add: CancellationCard new.
	aDeckOfCards add: CancellationCard new.
	aDeckOfCards add: CancellationCard new.
	aDeckOfCards add: CancellationCard new.
	aDeckOfCards add: CancellationCard new.

	aSpaceshipCard := SpaceshipCard
		                  named: (OrderedCollection with: 'Vicky')
		                  with: OverloadCard new.

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
		should: [ aBoardGame throw: CancellationCard new from: 'Vicky' choosing: aSpaceshipCard.   ]
		raise: Error
		withMessage: 'That card does not exist'
]

{ #category : #tests }
CardTest >> test13WhenASpaceshipPlaysCancellationCardThenCardDoesNotExists [

	| spaceships aBoard aBoardGame aDeckOfCards aSpaceshipCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: AccelerationCard new.
	aDeckOfCards add: CancellationCard new.

	aSpaceshipCard := SpaceshipCard
		                  named: (OrderedCollection with: 'Vicky')
		                  with: OverloadCard new.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
	
	aBoardGame throw: OverloadCard  new from: 'Vicky' to: 'Cami'.
	aBoardGame throw: SpeedCard new from: 'Vicky' to: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame throw: AccelerationCard new from: 'Cami'. 	

	self
		should: [ aBoardGame throw: CancellationCard new from: 'Cami' choosing:aSpaceshipCard ]
		raise: Error
		withMessage: 'That card does not exist'
]

{ #category : #tests }
CardTest >> test14WhenASpaceshipsThrowsARedoAndLastCardASpeedThenSpaceshipsAffected [

	| spaceships aBoard aBoardGame aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
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

	| spaceships aBoard aBoardGame aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: OverloadCard new.
	aDeckOfCards add: RedoCard new.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 9 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.


	
	aBoardGame throw: OverloadCard new from: 'Vicky' to: 'Cami'.
	aBoardGame throw: RedoCard new from: 'Vicky' to: 'Vicky'.

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

	| spaceships aBoard aBoardGame aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
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

	| spaceships aBoard aBoardGame aDeckOfCards |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: AccelerationCard new.
	aDeckOfCards add: RedoCard new.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.



	aBoardGame throw: AccelerationCard new from: 'Vicky'.
	aBoardGame throw: RedoCard new from: 'Vicky'.

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

	| spaceships aBoard aBoardGame aDeckOfCards aSpaceshipCard aSpaceshipCard2|
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: CancellationCard new.
	aDeckOfCards add: SpeedCard new.
	aDeckOfCards add: RedoCard new.
	
	aSpaceshipCard := SpaceshipCard named: (OrderedCollection with: 'Vicky') with: SpeedCard new. 
	aSpaceshipCard2 := SpaceshipCard named: (OrderedCollection with: 'Vicky') with: SpeedCard new. 

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.


	aBoardGame throw: SpeedCard new from: 'Vicky' to: 'Vicky'.			
	aBoardGame playTurnFor: 'Vicky'.
	
	aBoardGame throw: SpeedCard new from: 'Cami' to: 'Vicky'.	
	aBoardGame throw: CancellationCard new from: 'Vicky' choosing: aSpaceshipCard.
	
	aBoardGame throw: RedoCard new from: 'Cami' choosing: aSpaceshipCard2.

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

	| spaceships aBoard aBoardGame aDeckOfCards aRepeatCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aRepeatCard := RepeatCard new.
	aDeckOfCards := OrderedCollection new.
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
	
	aBoardGame throw: RepeatCard new from: 'Delfi' to: 'Delfi'.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber equals: 5.
	


]

{ #category : #tests }
CardTest >> test20WhenAspaceshipThrowsRepeatCardAndLastCellEffectAtomicBombThenAllSpaceshipsReturnToInitialPosition [

	| spaceships aBoard aBoardGame aDeckOfCards aRepeatCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).

	aRepeatCard := RepeatCard new.
	aDeckOfCards := OrderedCollection new.
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
	
	aBoardGame throw: RepeatCard new from: 'Delfi'.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber equals: 1.
	


]

{ #category : #tests }
CardTest >> test21 [

| spaceships aBoard aBoardGame cellEffectsCollection aMoonWalkEffect aDeckOfCards aRepeatCard |
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
	
	aRepeatCard := RepeatCard new.
	aDeckOfCards := OrderedCollection new.
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
	
	aBoardGame throw: RepeatCard new from: 'Delfi' to: 'Vicky'.
	
	self assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	self assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	
]

{ #category : #tests }
CardTest >> test22 [

	| spaceships aBoard aBoardGame aDeckOfCards aAccelerationCard |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffects withLenght: (Parsec withValue: 15).
	aAccelerationCard := AccelerationCard new.

	aDeckOfCards := OrderedCollection new.
	aDeckOfCards add: aAccelerationCard.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              utilizing: aDeckOfCards.
	
	aBoardGame playTurnFor: 'Vicky'.
	
	self should: [aBoardGame throw: aAccelerationCard from: 'Cami'to:'Cami'. ]
		raise: Error
		withMessage: 'You cannot choose a player for acceleration card.'
]
