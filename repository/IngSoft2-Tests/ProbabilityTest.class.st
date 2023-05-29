Class {
	#name : #ProbabilityTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ProbabilityTest >> test37When1000BoardsAreCreatedThenProbabilityOfAtomicBombBetween1And3 [

	| randomBoards sum |
	randomBoards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		| aBoard |
		aBoard := Board of: 100 with: 100 atRandom and: 100 atRandom.
		randomBoards add: aBoard ].

	1 to: randomBoards size do: [ :index | 
		sum := sum
		       + ((randomBoards at: index) amountOfCellsEffect at: 6) amount ].
	
	
	self assert: ((sum // 1000) between: 1 and: 3)
]

{ #category : #tests }
ProbabilityTest >> test38When1000BoardsAreCreatedThenProbabilityOfHyperJumpBetween7And9 [

	| randomBoards sum |
	randomBoards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		| aBoard |
		aBoard := Board of: 100 with: 100 atRandom and: 100 atRandom.
		randomBoards add: aBoard ].

	1 to: randomBoards size do: [ :index | 
		sum := sum
		       + ((randomBoards at: index) amountOfCellsEffect at: 5) amount ].
	
	
	self assert: ((sum // 1000) between: 7 and: 9)
]

{ #category : #tests }
ProbabilityTest >> test39When1000BoardsAreCreatedThenProbabilityOfMoonWalkBetween9And11 [

	| randomBoards sum |
	randomBoards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		| aBoard |
		aBoard := Board of: 100 with: 100 atRandom and: 100 atRandom.
		randomBoards add: aBoard ].

	1 to: randomBoards size do: [ :index | 
		sum := sum
		       + ((randomBoards at: index) amountOfCellsEffect at: 4) amount ].
	
	
	self assert: ((sum // 1000) between: 9 and: 11)
]

{ #category : #tests }
ProbabilityTest >> test40When1000BoardsAreCreatedThenProbabilityOfNoEffectBetween39And41 [

	| randomBoards sum |
	randomBoards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		| aBoard |
		aBoard := Board of: 100 with: 100 atRandom and: 100 atRandom.
		randomBoards add: aBoard ].

	1 to: randomBoards size do: [ :index | 
		sum := sum
		       + ((randomBoards at: index) amountOfCellsEffect at: 1) amount ].
	
	
	self assert: ((sum // 1000) between: 39 and: 41)
]

{ #category : #tests }
ProbabilityTest >> test41When1000BoardsAreCreatedThenProbabilityOfSpeedUpBetween19And21 [

	| randomBoards sum |
	randomBoards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		| aBoard |
		aBoard := Board of: 100 with: 100 atRandom and: 100 atRandom.
		randomBoards add: aBoard ].

	1 to: randomBoards size do: [ :index | 
		sum := sum
		       + ((randomBoards at: index) amountOfCellsEffect at: 3) amount ].
	
	
	self assert: ((sum // 1000) between: 19 and: 21)
]

{ #category : #tests }
ProbabilityTest >> test42When1000BoardsAreCreatedThenProbabilityOfWormHoleBetween19And21 [

	| randomBoards sum |
	randomBoards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		| aBoard |
		aBoard := Board of: 100 with: 100 atRandom and: 100 atRandom.
		randomBoards add: aBoard ].

	1 to: randomBoards size do: [ :index | 
		sum := sum
		       + ((randomBoards at: index) amountOfCellsEffect at: 2) amount ].
	
	
	self assert: ((sum // 1000) between: 19 and: 21)
]
