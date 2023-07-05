Class {
	#name : #DrawCardEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
DrawCardEffect >> implementOn: aBoardGame [ 
	aBoardGame dealACard.
]
