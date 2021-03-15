//Copyright (c) 2020 En Hu. All rights reserved.

#pragma once
#include<iostream>
#include<string>
#include<fstream>

#ifndef MAXSIZE
#define MAXSIZE
const int maxsize = 20;
#endif // !MAXSIZE

struct VertexNode
{
	std::string paper;
	std::string author;
	double weight;
	int indegree, outdegree;
};

class CNClass
{
public:
	CNClass(char* VerticesFilename, char* ArcsFilename);
	~CNClass();
	void NewPaper();
	void Withdraw(int index);
	void Modify(int index);
	int SearchPaper(std::string papersearch);
	int SearchAuthor(std::string authorsearch);
	int SearchPaperAuthor(std::string papersearch, std::string authorsearch, bool printcite);
	void DFS(int index);
	void PrintAll();
private:
	void InputData(char* VerticesFilename, char* ArcsFilename);
	int numVertices;
	double arcs[(1 + maxsize) / 2 * maxsize];//compressed type
	VertexNode Vertices[maxsize];
};

