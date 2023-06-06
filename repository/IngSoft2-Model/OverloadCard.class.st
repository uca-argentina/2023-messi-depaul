Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
OverloadCard >> byTurn [
	^true.
]

{ #category : #action }
OverloadCard >> implementOn: aBoardGame [

	^ -2
]

{ #category : #'instance variable' }
OverloadCard >> name [
	^'overload'
]

{ #category : #action }
OverloadCard >> playOn: aBoardGame to: aSpaceship [

	aBoardGame throwPermanentCardTo: aSpaceship
]
