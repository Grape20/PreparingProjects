//Copyright (c) 2020 En Hu. All rights reserved.
#include "CNClass.h"

CNClass::CNClass(char* VerticesFilename, char* ArcsFilename)
{
	using namespace std;
	//load files
	fstream VexFile, ArcFile;
	cout << "I have loaded: " << endl;
	cout << VerticesFilename << ' ' << ArcsFilename << endl;
	VexFile.open(VerticesFilename);
	ArcFile.open(ArcsFilename);
	//get number of vertices and the sign of is-sorted-and-weighted
	int t1, t2;//temporary int-type data
	VexFile >> t1; ArcFile >> t2;
	if (t1 != t2)	throw("number of Vertices is not equal");
	else if (t1 < 0)	throw("number of Vertices cannot less than 0");
	else if (t1 > maxsize)	throw("overflow");
	else numVertices = t1;
	bool isSortedWeighted;
	ArcFile >> t1;
	switch (t1)
	{
	case 0:
		isSortedWeighted = false;
		break;
	case 1:
		isSortedWeighted = true;
		break;
	default:
		throw("error type of sign of is-triangular-matrix");
		break;
	}
	if (isSortedWeighted)//if the files has been sorted-and-weighted
	{
		//get data of paper, author, and weights
		string paper, author, finished; double weights;
		for (int i = 0; i < numVertices; i++)
		{
			VexFile >> paper;
			VexFile >> author;
			VexFile >> weights;
			Vertices[i].paper = paper;
			Vertices[i].author = author;
			Vertices[i].weight = weights;
			VexFile >> finished;
			if (finished == "#")	continue;
			else throw("error: the type of VexFile is wrong");
		}
		//get data of arcs
		for (int i = 0; i < (1 + numVertices) * numVertices / 2; i++)	ArcFile >> arcs[i];
		//initialize empty room
		for (int i = (1 + numVertices) * numVertices / 2; i < maxsize; i++)	arcs[i] = 0;
	}
	else//if not, then start from scratch
	{
		//initialize arcs matrix
		for (int i = 0; i < (1 + maxsize) / 2 * maxsize; i++)
			arcs[i] = 0;
		VertexNode* tempVex = new VertexNode[numVertices];//temporary vertexdata
		//temporaray arcdata
		bool** tempArcs = new bool* [numVertices];
		for (int i = 0; i < numVertices; i++)
			tempArcs[i] = new bool[numVertices];
		//get data of vertex
		string paper, author, finished; double weights;
		for (int i = 0; i < numVertices; i++)
		{
			VexFile >> paper;
			VexFile >> author;
			VexFile >> weights;
			tempVex[i].paper = paper;
			tempVex[i].author = author;
			tempVex[i].weight = 1;
			VexFile >> finished;
			if (finished == "#")	continue;
			else throw("error: the type of VexFile is wrong");
		}
		//get data of arcs
		for (int i = 0; i < numVertices; i++)
			for (int j = 0; j < numVertices; j++)
			{
				ArcFile >> t1;
				if (t1 > 0)
					tempArcs[i][j] = true;
				else tempArcs[i][j] = false;
			}
		//get indegree
		for (int j = 0; j < numVertices; j++)
		{
			int count = 0;
			for (int i = 0; i < numVertices; i++)
				if (tempArcs[i][j])	count++;
			tempVex[j].indegree = count;
		}
		//toposort
		int* s = new int[numVertices];//stack, which stores index of vertices
		int* toposeries = new int[numVertices];//stores toposeries
		int top = -1, count = 0;
		for (int i = 0; i < numVertices; i++)
			if (tempVex[i].indegree == 0)
				s[++top] = i;
		while (top != -1)
		{
			t1 = s[top--];

			//cout << tempVex[t1];
			toposeries[count++] = t1;

			for (int j = 0; j < numVertices; j++)
				if (tempArcs[t1][j])
				{
					tempVex[j].indegree--;
					if (tempVex[j].indegree == 0)
						s[++top] = j;
				}
		}
		if (count < numVertices)	throw("there is a ring");
		
		//int* inversetopo = new int[numVertices];//stores inverse of toposeries
		//for (int i = 0; i < numVertices; i++)
		//	inversetopo[toposeries[i]] = i;

		//input paper and author
		for (int i = 0; i < numVertices; i++)
		{
			Vertices[numVertices - 1 - i].paper = tempVex[toposeries[i]].paper;
			Vertices[numVertices - 1 - i].author = tempVex[toposeries[i]].author;
		}

		//weigh vertices and arcs
		for (int i = numVertices - 1; i >= 0; i--)
		{
			//sum of weights of inarcs
			double sum = 0;
			for (int j = i + 1; j < numVertices; j++)
				sum = sum + arcs[(1 + j) * j / 2 + i];
			//weigh vertex
			Vertices[i].weight = sum + 1;
			//calculate outdegree
			Vertices[i].outdegree = 0;
			for (int j = 0; j < numVertices; j++)
				if (tempArcs[toposeries[numVertices - i - 1]][j])
					Vertices[i].outdegree++;
			//set the weights of outarcs
			for (int j = 0; j < i; j++)
				if (tempArcs[toposeries[numVertices - i - 1]][toposeries[numVertices - j - 1]])
					arcs[(1 + i) * i / 2 + j] = Vertices[i].weight / Vertices[i].outdegree;
		}

		VexFile.close(); ArcFile.close();
		//delete[] inversetopo;
		delete[] toposeries;
		delete[] tempVex;
		for (int i = 0; i < numVertices; i++)
			delete[] tempArcs[i];
		delete[] tempArcs;
	}
}

CNClass::~CNClass()
{
	using namespace std;
	bool isdecided = false;
	while (!isdecided)
	{
		cout << "Do you want to save the data? Input 'y' if yes, 'n' if no. " << endl
			<< "your decision: ";
		char decision;
		cin >> decision;
		cout << endl;
		if (decision == 'y')
		{
			char VerticesFilename[50], ArcsFilename[50];
			char split[] = "===================================================";
			cout << split << endl << "I am ready to input data. " << endl;
			cout << "Please input the VerticesFilename(suggestion: VertexData2.txt)" << endl << "name: ";
			cin >> VerticesFilename; 
			cout << "Please input the ArcsFilename(suggestion: ArcData2.txt)" << endl << "name: ";
			cin >> ArcsFilename; 
			InputData(VerticesFilename, ArcsFilename);
			isdecided = true;
			cout << "This program is about to finish. Goodbye! " << endl;
		}
		else if (decision == 'n')
		{
			isdecided = true;
			cout << "This program is about to finish. Goodbye! " << endl;
		}
		else
			cout << "Error decision! Please decided again. " << endl;
	}
	system("pause");
}

void CNClass::NewPaper()
{
	using namespace std;
	if (numVertices == maxsize)
	{
		cout << "overflow";
		return;
	}
	//add vertex
	string papername, authorname;
	cout << "Please input the name of paper you want to add. " << endl
		<< "name: ";
	cin >> papername;
	cout << "Please input the name of author you want to add. " << endl
		<< "name: ";
	cin >> authorname;
	Vertices[numVertices].paper = papername;
	Vertices[numVertices].author = authorname;
	Vertices[numVertices].weight = 1;
	cout << "new paper's papername and authorname have been added! " << endl << endl;
	//add arcs
	int count = 0;
	int citedid[maxsize];
	for (int i = 0; i < maxsize; i++)	citedid[i] = -1;
	bool finishedsign = false;
	while (!finishedsign)
	{
		char finished;
		cout << "Have you input all papers have been cited? Input 'y' if yes, 'n' if no" << endl;
		cin >> finished;
		if (finished == 'y')	finishedsign = true;
		else if (finished == 'n')
		{
			cout << "Please input the name of " << (count + 1) << "th paper has been cited. " << endl
				<< "name: ";
			cin >> papername;
			cout << "Please input the name of " << (count + 1) << "th author has been cited. " << endl
				<< "name: ";
			cin >> authorname;
			int i = SearchPaperAuthor(papername, authorname, false);
			if (i >= 0 && i < maxsize)
				citedid[count++] = i;
			else if (i == -1)
				cout << "I cannot find the paper you have inputed. " << endl;
			else
				cout << "More than one paper. I have not solve this problem. " << endl;
		}
		else cout << "Error type! Please input again. " << endl;
	}
	Vertices[numVertices].outdegree = count;
	numVertices++;
	for (int i = 0; i < numVertices - 1 && citedid[i] != -1; i++)
		//arcs[numVertices - 1][citedid[i]] = 1 / count;
		arcs[numVertices * (numVertices - 1) / 2 + citedid[i]] = 1.0 / double(count);
	
	//update weights of vertices and arcs
	for (int i = numVertices - 2; i >= 0; i--)
	{
		//sum of weights of inarcs
		double sum = 0;
		for (int j = i + 1; j < numVertices; j++)
			sum = sum + arcs[(1 + j) * j / 2 + i];
		//weigh vertex
		Vertices[i].weight = sum + 1;
		//calculate outdegree
		Vertices[i].outdegree = 0;
		for (int j = 0; j < i; j++)
			if (arcs[(1 + i) * i / 2 + j] > 0)	Vertices[i].outdegree++;
		//set the weights of outarcs
		double outarcweight = Vertices[i].weight / Vertices[i].outdegree;
		for (int j = 0; j < i; j++)
			if (arcs[(1 + i) * i / 2 + j] > 0)	arcs[(1 + i) * i / 2 + j] = outarcweight;
	}
	cout << "New paper and all its citaion have been added! " << endl;
}

void CNClass::InputData(char* VerticesFilename, char* ArcsFilename)
{
	using namespace std;
	fstream Vexfile, Arcfile;
	char split[] = "===================================================";
	cout << split << endl;
	cout << "Begin inputing data! " << endl;
	Vexfile.open(VerticesFilename); Arcfile.open(ArcsFilename);
	//input arcs data
	Arcfile << numVertices << '\n';
	Arcfile << 1 << '\n';
	for (int i = 0; i < numVertices; i++)
	{
		for (int j = 0; j <= i; j++)
			Arcfile << arcs[(1 + i) * i / 2 + j] << ' ';
		Arcfile << '\n';
	}
		
	//input vex data
	Vexfile << numVertices << '\n';
	for (int i = 0; i < numVertices; i++)
	{
		Vexfile << Vertices[i].paper << '\n';
		Vexfile << Vertices[i].author << '\n';
		Vexfile << Vertices[i].weight << '\n';
		Vexfile << '#' << '\n';
	}
	cout << "Data has been input! " << endl;
	cout << split << endl;
}

void CNClass::Withdraw(int index)
{
	using namespace std;
	//start withdrawing
	cout << "Sorry! I have not design this algorithem. " << endl;
}

void CNClass::Modify(int index)
{
	using namespace std;
	cout << "Begin modifying! " << endl;
	string papername, authorname;
	cout << "Please input new paper name. " << endl
		<< "name: ";
	cin >> papername;
	cout << "Please input new author name. " << endl
		<< "name: ";
	cin >> authorname;
	Vertices[index].paper = papername;
	Vertices[index].author = authorname;
	cout << "Modify successfully! " << endl;
}

int CNClass::SearchPaper(std::string papersearch)
{
	using namespace std;
	int* id = new int[numVertices];
	for (int i = 0; i < numVertices; i++)	id[i] = -1;
	int count = 0;
	for (int i = 0; i < numVertices; i++)
		if (Vertices[i].paper == papersearch)
			id[count++] = i;
	cout << "There are " << count << " papers matched: " << endl;
	for (int i = 0, j = 0; i < numVertices && id[j] != -1; i++)
		if (i == id[j])
		{
			cout << "papername: " << Vertices[i].paper << '\n';
			cout << "author: " << Vertices[i].author << '\n';
			cout << "weight: " << Vertices[i].weight << '\n';
			cout << '#' << '\n';
			j++;
		}

	delete[] id;
	return count;
}

int CNClass::SearchAuthor(std::string authorsearch)
{
	using namespace std;
	int* id = new int[numVertices];
	for (int i = 0; i < numVertices; i++)	id[i] = -1;
	int count = 0;
	for (int i = 0; i < numVertices; i++)
		if (Vertices[i].author == authorsearch)
			id[count++] = i;
	cout << "There are " << count << " papers matched: " << endl;
	for (int i = 0, j = 0; i < numVertices && id[j] != -1; i++)
		if (i == id[j])
		{
			cout << "papername: " << Vertices[i].paper << '\n';
			cout << "author: " << Vertices[i].author << '\n';
			cout << "weight: " << Vertices[i].weight << '\n';
			cout << '#' << '\n';
			j++;
		}

	delete[] id;
	return count;

}

int CNClass::SearchPaperAuthor(std::string papersearch, std::string authorsearch, bool printcite)
{
	using namespace std;
	int* id = new int[numVertices];
	for (int i = 0; i < numVertices; i++)	id[i] = -1;
	int count = 0;
	for (int i = 0; i < numVertices; i++)
		if (Vertices[i].paper == papersearch && Vertices[i].author == authorsearch)
			id[count++] = i;
	cout << "There are " << count << " papers matched: " << endl;
	for (int i = 0, j = 0; i < numVertices && id[j] != -1; i++)
		if (i == id[j])
		{
			cout << "papername: " << Vertices[i].paper << '\n';
			cout << "author: " << Vertices[i].author << '\n';
			cout << "weight: " << Vertices[i].weight << '\n';
			cout << '#' << '\n';
			j++;
		}
	int result;
	if (count == 1)
	{
		result = id[count - 1];
		if (printcite)
		{
			cout << "this paper has cited: " << endl;
			for (int i = 0; i < numVertices; i++)	id[i] = -1;
			count = 0;
			for (int i = 0; i < result; i++)
				if (arcs[(1 + result) * result / 2 + i] > 0)
					id[count++] = i;
			for (int i = 0, j = 0; i < numVertices && id[j] != -1; i++)
				if (i == id[j])
				{
					cout << "papername: " << Vertices[i].paper << '\n';
					cout << "author: " << Vertices[i].author << '\n';
					cout << '#' << '\n';
					j++;
				}
			cout << endl;
			cout << "this paper has been cited by: " << endl;
			for (int i = 0; i < numVertices; i++)	id[i] = -1;
			count = 0;
			for (int i = result + 1; i < numVertices; i++)
				if (arcs[(1 + i) * i / 2 + result] > 0)
					id[count++] = i;
			for (int i = 0, j = 0; i < numVertices && id[j] != -1; i++)
				if (i == id[j])
				{
					cout << "papername: " << Vertices[i].paper << '\n';
					cout << "author: " << Vertices[i].author << '\n';
					cout << '#' << '\n';
					j++;
				}
			cout << endl;
		}
	}
	else if (count == 0) result = -1;
	else result = maxsize + count;

	delete[] id;
	return result;
}

void CNClass::DFS(int v)
{
	using namespace std;
	cout << "Print all papers contributed to the paper you have inputed: " << endl;
	bool visited[maxsize];
	for (int i = 0; i < maxsize; i++)
		visited[i] = false;
	int s[maxsize]; int top = -1;
	cout << "itself: " << endl;
	cout << "papername: " << Vertices[v].paper << '\n';
	cout << "author: " << Vertices[v].author << '\n';
	cout << '#' << '\n';
	cout << "others: " << endl;
	visited[v] = true; s[++top] = v;
	while (top != -1)
	{
		int j = 0;
		v = s[top];
		for (; j < v; j++)
			if (arcs[(1 + v) * v / 2 + j] > 0 && !visited[j])
			{
				cout << "papername: " << Vertices[j].paper << '\n';
				cout << "author: " << Vertices[j].author << '\n';
				cout << '#' << '\n';
				visited[j] = true;
				s[++top] = j;
				break;
			}
		if (j == v)
			top--;
	}
	cout << endl;
}

void CNClass::PrintAll()
{
	using namespace std;
	cout << "All informations about papers: " << endl;
	for (int i = 0; i < numVertices; i++)
	{
		cout << "papername: " << Vertices[i].paper << '\n';
		cout << "author: " << Vertices[i].author << '\n';
		cout << "weight: " << Vertices[i].weight << '\n';
	}
}
