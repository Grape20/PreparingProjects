//Copyright (c) 2020 En Hu. All rights reserved.

#include <iostream>
#include"CNClass.h"

int main()
{
    using namespace std;
    cout << "Hello World!\n";
    cout << "This program analyze citation network.\n";
	char split[] = "===================================================";
	cout << split << endl;
	//char VerticesFilename[] = "VertexData1.txt", ArcsFilename[] = "ArcData1.txt";
	char VerticesFilename[50], ArcsFilename[50];
	cout << "Enter the VerticesFilename(suggestion: VertexData1.txt)" << endl << "name: ";
	cin >> VerticesFilename;
	cout << "Enter the ArcsFilename(suggestion: ArcData1.txt)" << endl << "name: ";
	cin >> ArcsFilename;
	CNClass CN1(VerticesFilename, ArcsFilename);
	cout << split << endl;
	bool finished = false;
	while (!finished)
	{
		int id_operation;
		cout << "What do you want to do? Enter the index of operation" << endl;
		cout << "1. Add new paper" << endl
			<< "2. Withdraw a paper" << endl
			<< "3. Modify a paper" << endl
			<< "4. Search a paper with author(detailed)" << endl
			<< "5. Search papers without author" << endl
			<< "6. Search author" << endl
			<< "7. DFS a paper with author(means find all papers contribute to it)" << endl
			<< "8. Print all information" << endl
			<< "9. Quit" << endl;
		cout << "your decision: ";
		cin >> id_operation;
		string papername, authorname; int index;
		switch (id_operation)
		{
		case 1:
			cout << split << endl;
			cout << "Begin adding new paper! " << endl;
			CN1.NewPaper();
			cout << split << endl;
			break;
		case 2:
			char decision;
			cout << "Do you really want to withdraw the paper? Input 'y' if yes, else if no." << endl;
			cin >> decision;
			if (decision != 'y')	break;
			else
			{
				cout << split << endl;
				cout << "Begin withdrawing! " << endl;
				cout << "Please input the name of paper you want to withdraw. " << endl
					<< "name: ";
				cin >> papername;
				cout << "Please input the name of author you want to withdraw. " << endl
					<< "name: ";
				cin >> authorname;
				index = CN1.SearchPaperAuthor(papername, authorname, false);
				if (index == -1)	cout << "I cannot find the paper. " << endl;
				else if (index > maxsize)	cout << "There is more than one paper. I have not solve this problem now. " << endl;
				else CN1.Withdraw(index);
				cout << split << endl;
				break;
			}
		case 3:
			cout << split << endl;
			cout << "Please input the name of paper you want to modify. " << endl
				<< "name: ";
			cin >> papername;
			cout << "Please input the name of author you want to modify. " << endl
				<< "name: ";
			cin >> authorname;
			index = CN1.SearchPaperAuthor(papername, authorname, false);
			if (index == -1)	cout << "I cannot find the paper. " << endl;
			else if (index > maxsize)	cout << "There is more than one paper. I have not solve this problem now. " << endl;
			else CN1.Modify(index);
			cout << split << endl;
			break;
		case 4:
			cout << split << endl;
			cout << "Start SearchPaperAuthor! " << endl;
			cout << "Please input the name of paper. " << endl
				<< "name: ";
			cin >> papername;
			cout << "Please input the name of author you want. " << endl
				<< "name: ";
			cin >> authorname;
			CN1.SearchPaperAuthor(papername, authorname, true);
			cout << split << endl;
			break;
		case 5:
			cout << split << endl;
			cout << "Start SearchPaper! " << endl;
			cout << "Please input the name of paper you want. " << endl
			<< "name: ";
			cin >> papername;
			CN1.SearchPaper(papername);
			cout << split << endl;
			break;
		case 6:
			cout << split << endl;
			cout << "Start SearchAuthor! " << endl;
			cout << "Please input the name of author you want. " << endl
				<< "name: ";
			cin >> authorname;
			CN1.SearchAuthor(authorname);
			cout << split << endl;
			break;
		case 7:
			cout << split << endl;
			cout << "Start DFS! " << endl;
			cout << "Please input the name of paper you want to DFS. " << endl
				<< "name: ";
			cin >> papername;
			cout << "Please input the name of author you want to DFS. " << endl
				<< "name: ";
			cin >> authorname;
			index = CN1.SearchPaperAuthor(papername, authorname, false);
			if (index == -1)	cout << "I cannot find the paper. " << endl;
			else if (index > maxsize)	cout << "There is more than one paper. I have not solve this problem now. " << endl;
			else CN1.DFS(index);
			cout << split << endl;
			break;
		case 8:
			cout << split << endl;
			cout << "Start PrintAll! " << endl;
			CN1.PrintAll();
			cout << split << endl;
			break;
		case 9:
			finished = true;
			break;
		default:
			cout << "Wrong index! Please enter again. " << endl;
			break;
		}
	}
}

// 运行程序: Ctrl + F5 或调试 >“开始执行(不调试)”菜单
// 调试程序: F5 或调试 >“开始调试”菜单