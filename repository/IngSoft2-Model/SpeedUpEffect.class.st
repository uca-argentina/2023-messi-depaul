Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedUpEffect >> implementOn: aBoardGame [

	aBoardGame applyMovingEffect: 4.
]

{ #category : #accessing }
SpeedUpEffect >> number [
	^4.
]
