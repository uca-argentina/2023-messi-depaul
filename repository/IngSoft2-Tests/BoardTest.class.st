Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
BoardTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
			self assert: error messageText equals: anErrorMessage ].
]

{ #category : #tests }
BoardTest >> test01WhenABoardWithNegativeAmountOfCellsThenFailsCreation [
self should: [ Board of: OrderedCollection new withLenght: 15] raise: Error withMessage: 'Cannot create board with a negative amount of cells'.

]
