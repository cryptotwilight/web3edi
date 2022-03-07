const iABStudentAbi = [
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "_certId",
				"type": "uint256"
			}
		],
		"name": "addCertificate",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_added",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_course",
				"type": "address"
			}
		],
		"name": "addCourse",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_added",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_school",
				"type": "address"
			}
		],
		"name": "addSchool",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_added",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getCertificates",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "_nftCertId",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getCourses",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_courses",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getSchoolBadges",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "_schoolBadges",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getSchools",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "_schools",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "_course",
				"type": "address"
			}
		],
		"name": "removeCourse",
		"outputs": [
			{
				"internalType": "bool",
				"name": "_removed",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]