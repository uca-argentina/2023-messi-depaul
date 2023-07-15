Class {
	#name : #CellGeneratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
CellGeneratorTest >> test01WhenACellGeneratorGeneratesCellsThenABoardIsCreatedWithCells [

	| aCellGenerator aBoard |
	aCellGenerator := CellGenerator setWithCellEffects: 100.
	aBoard := Board
		          of: aCellGenerator cellsEffect
		          withLenght: (Parsec of: 15).
	self assert: aBoard anAmountOfCells equals: 100
]
