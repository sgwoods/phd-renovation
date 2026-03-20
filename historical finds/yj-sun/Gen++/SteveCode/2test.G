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
	textmode : center
	node: { title: "14"
		label:"main:i
size: 10"
		level: 1
		info1:"14"
		info2:"20"
		info3:"2test.c"
	}
	node: { title: "15"
		label:"main:j
size: 4"
		level: 0
shape: ellipse
		info1:"15"
		info2:"20"
		info3:"2test.c"
	}
	node: { title: "16"
		label:"main:k
size: 4"
		level: 3
		info1:"16"
		info2:"20"
		info3:"2test.c"
	}
	node: { title: "17"
		label:"main:A
size: 11"
		level: 0
shape: ellipse
		info1:"17"
		info2:"20"
		info3:"2test.c"
	}
	edge: {sourcename: "17" targetname: "14"}
	edge: {sourcename: "18" targetname: "16"}
}
