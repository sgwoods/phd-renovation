graph: {
	hidden: 2 
	node: { title: "nil"
		label: "invisible node"
		level: 0
		info1: "guarantees graph has one node and edge"
		info2: "so that xvcg does not core dump"
		info3: "since edge is hidden there is no effect"
	}
	edge: {sourcename: "nil" targetname: "nil"  class: 2 }
	textmode  : center
	node: { title: "0"
		label:"main:i
equiv: 0"
		level: 1
		borderwidth: 3
		info1:"0"
		info2:"15"
		info3:"test.c"
	}
	node: { title: "1"
		label:"main:j
equiv: 0"
		level: 0
		borderwidth: 3
shape: ellipse
		info1:"1"
		info2:"15"
		info3:"test.c"
	}
	node: { title: "2"
		label:"main:k
equiv: 0"
		level: 0
		borderwidth: 3
shape: ellipse
		info1:"2"
		info2:"15"
		info3:"test.c"
	}
	node: { title: "3"
		label:"main:A
equiv: 0"
		level: 0
		borderwidth: 3
shape: ellipse
		info1:"3"
		info2:"15"
		info3:"test.c"
	}
	edge: {sourcename: "3" targetname: "0"}
}
