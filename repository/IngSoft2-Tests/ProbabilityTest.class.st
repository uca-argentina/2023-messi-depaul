Class {
	#name : #ProbabilityTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
ProbabilityTest >> test01When1000BoardsAreCreatedThenProbabilityOfAtomicBombBetween1And3 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(ProbabilityCellEffect setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) atomicBombs ].
	self assert: (sum // 1000 between: 1 and: 3)
]

{ #category : #tests }
ProbabilityTest >> test02When1000BoardsAreCreatedThenProbabilityOfHyperJumpBetween7And9 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(ProbabilityCellEffect setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) hyperJumps ].
	
	
	self assert: ((sum // 1000) between: 7 and: 9)
]

{ #category : #tests }
ProbabilityTest >> test03When1000BoardsAreCreatedThenProbabilityOfMoonWalkBetween9And11 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(ProbabilityCellEffect setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) moonWalks ].
	self assert: ((sum // 1000) between: 9 and: 11)
]

{ #category : #tests }
ProbabilityTest >> test04When1000BoardsAreCreatedThenProbabilityOfNoEffectBetween39And41 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(ProbabilityCellEffect setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) noEffects ].	
	self assert: ((sum // 1000) between: 39 and: 41)
]

{ #category : #tests }
ProbabilityTest >> test05When1000BoardsAreCreatedThenProbabilityOfSpeedUpBetween19And21 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(ProbabilityCellEffect setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) speedUps ].	
	self assert: ((sum // 1000) between: 19 and: 21)
]

{ #category : #tests }
ProbabilityTest >> test06When1000BoardsAreCreatedThenProbabilityOfWormHoleBetween19And21 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(ProbabilityCellEffect setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) wormHoles ].	
	
	self assert: ((sum // 1000) between: 19 and: 21)
]
