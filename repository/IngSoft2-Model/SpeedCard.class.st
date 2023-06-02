Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> implementOn: aBoardGame [

	^ 1
]

{ #category : #'instance variable' }
SpeedCard >> name [
	^'speed'.
]
