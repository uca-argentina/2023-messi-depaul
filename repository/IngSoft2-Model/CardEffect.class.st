Class {
	#name : #CardEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CardEffect >> implementOn: aBoardGame [ 
	aBoardGame dealACard.
]
