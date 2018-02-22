#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <fstream>
#include <windows.h>
#include <winable.h>
#include <ctime>
#include <stdarg.h>

using namespace std;
 
 unsigned int _strlen(const char str[])
 {
	int i = 0;
	while(str[i] != 0)
		i++;
	
	return i;
 }
 
  unsigned int _strlen(const string str)
 {
	int i = 0;
	while(str[i] != 0)
		i++;
	
	return i;
 }
 
 int _rest(const int n1)
 {
	 return n1 - ((n1 / 2)) * 2;
 }
 
 int _strcut(char *str, unsigned int strlen, unsigned int start, unsigned int end)
 {
	if(start > strlen || end > strlen || start >= end || end == 0)
		return 0;
	
	for(int i = start; i < end; i++)
		str[i - start] = str[i];
			
	str[end - start] = 0;

	return 1;
 }

 int _chfind(const char str[], unsigned int strlen, char ch)
 {
	 for(int i = 0; i < strlen; i++)
		 if(str[i] == ch)
			 return i;
	 return -1;
 }
 
 bool _isCaps(char ch)
 {
	 return ch >= 65 && ch <=90;
 }
 
 bool _isNum(char ch)
 {
	 return ch >= 48 && ch <= 57;
 }
 
 char _toCaps(char ch)
 {
	return _isCaps(ch) ? ch : ch - 32;
 }
 
 char _toMin(char ch)
 {
	 return !_isCaps(ch) ? ch : ch + 32;
 }
 
 bool _strcmp(const char* str, const char tofind[], bool ignorecase = false, unsigned int start = 0, unsigned int length = 0)
 {	 
	 if(length == 0)
		 length = _strlen(str) > _strlen(tofind) ? _strlen(str) : _strlen(tofind);
	 if(start >= length)
		 return false;
	 
	 for(unsigned int i = start; i < length; i++) {
		if(ignorecase) { if(_toMin(str[i]) != _toMin(tofind[i])) return false; }
		else if(str[i] != tofind[i]) return false;
	 }
	 return true;
 }
 
 int _strfind(const char* str, const char tofind[], bool ignorecase = false, unsigned int start = 0)
 {	 
	unsigned int length = _strlen(str), length2 = _strlen(tofind);
	
	for(unsigned int i = 0; i < length; i++)
	{
		if(ignorecase) {
			if(_toMin(str[i]) == _toMin(tofind[0]))
			{
				for(unsigned int i2 = 0; i2 <= i + length2; i2++)
				{
					if(i2 == length2)
						return i;
					if(_toMin(str[i2 + i]) != _toMin(tofind[i2]))
						break;
				}
			}
		}
		else if(str[i] == tofind[0]) {
				for(unsigned int i2 = 0; i2 <= i + length2; i2++) {
					if(i2 == length2)
						return i;
					if(str[i2 + i] != tofind[i2])
						break;
				}	
			}
	}
	 return -1;
 }
 
 int _strval(const char str[], unsigned int start = 0)
 {
	 int length = _strlen(str), number = 0;
	 bool gotnum = false;
	 for(unsigned int i = start; i < length; i++)
	 {
		 if(_isNum(str[i])) { gotnum = true;
			int tempnumber = int(str[i] - 48);

			for(unsigned int i2 = i + 1; i2 < length && _isNum(str[i2]); i2++) 
					tempnumber *= 10;
			
			number+=tempnumber;
			
		 }
		 else if(gotnum) break;
	 }
	 return number;
 }
 
 void _strcpy(char *str, const char src[], unsigned int maxlength = 0)
 {
	 if(maxlength == 0)
		maxlength = _strlen(src);
	
	for(unsigned int i = 0; i < maxlength; i++)
		str[i] = src[i];
	
	return;
 }
 
  void _strcpy(char *str, const string src, unsigned int maxlength = 0)
 {
	 if(maxlength == 0)
		maxlength = _strlen(src);
	
	for(unsigned int i = 0; i < maxlength; i++)
		str[i] = src[i];
	
	return;
 }
 
 void _strtocpy(char *str, string src, unsigned int maxlength = 0)
 {
	 if(maxlength == 0)
		maxlength = _strlen(src);
	
	for(unsigned int i = 0; i < maxlength; i++)
		str[i] = src[i];
	
	return;
 }
 
 void _strins(char *str, const char toIns[], unsigned int pos = 0, int maxlength = -1)
 {
	 int length = _strlen(toIns);
	 if(maxlength <= -1)
		 maxlength = length + _strlen(str);
	 
	 char newstr[128];
	 
	 if(pos != 0) {
		 for(unsigned int i = 0; i < maxlength; i++)
		{
			if(i < pos) newstr[i] = str[i];
			else if(i < pos + length) newstr[i] = toIns[i - pos];
			else newstr[i] = str[i - pos - 2];
		}
	 }
	 
	newstr[maxlength] = 0;
	_strcpy(str, newstr);

	 return;
 }
 
 void _strdel(char *str, unsigned int start, unsigned int end)
 {
	if(end == 0 || start >= end)
		return;
	
	unsigned int length = _strlen(str) + 1, length2 = start - end;
	
	for(unsigned int i = start; i < length - length2; i++)
		str[i] = str[i - length2];
	
	return;
 }
 
 void _strcat(char* str, const char source[], unsigned int maxlength = 0)
 {
	 int length = _strlen(source), length2 = _strlen(str);
	 if(maxlength == 0)
		 maxlength = _strlen(str) + length;
	 
	 for(unsigned int i = _strlen(str); i < length2 + length2 && i < maxlength; i++)
		 str[i] = source[i - length2];
	
	 return;
 }
 
/*int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow)  
{
	HWND hWnd = CreateWindowEx(WS_EX_OVERLAPPEDWINDOW, "1", "tEST", WS_OVERLAPPEDWINDOW, 200, 300, 700, 500, NULL, NULL, hInstance, NULL);
    
    ShowWindow (hWnd, SW_SHOWNORMAL);
}*/
 
int main()
{
	//char str[] = "test de chaine ", str2[] = "chai", str3[128] = "test de chaine";
	//_strins(str3, str, 5, sizeof(str3));
	//_strcat(str3, "lel", sizeof(str3));
	//_strcat(str3, str2);
	//printf("%s\n", str3);
	//_strcut(str, sizeof(str), 8, 12);
	//_strins(str3, "Estael ", 5);
	//printf("%s %d\n", str, _chfind(str, _strlen(str), 'a'));
	//printf("%c %c\n", _toMin('A'), _toMin('a'));
	//printf("%d\n", _strcmp("test", "tesT5", true, 4));
	//printf("%d\n", _strcmp("tesT de chaine", "test de chaine", true, 0, 5));
	//printf("%s\n", str3);
	//printf("%d\n", _strfind("Es uno testo", "tesTo", true));dd
	
	bool exit = false;
	string mystr = "";
	char id[30] = "";
	if(!exit) printf("... Tapez une commande. Tapez 'help' pour la liste des commandes. ...\n");
	while(exit == false) {
		char line[256] = "";
		
		getline(cin, mystr);
		_strcpy(line, mystr);
		
		exit = _strcmp(line, "exit", true);
		if(_strcmp(line, "write ", true, 0, 6))
		{
			_strdel(line, 0, 6);
			ofstream file("\\\\KIKI\\ecriture\\texte.txt", ios::app);
			if(file.is_open())
			{
				std::time_t t = std::time(0);
				TCHAR  infoBuf[50];
				DWORD  bufCharCount = 50;
				if(GetComputerName(infoBuf, &bufCharCount)) {
					if(id[0] == 0) file << infoBuf << ": " << line << endl;
					else file << id << ": " << line << endl;
					printf("Ecriture effectuee avec succes.\n... Tapez une commande ...\n");
				}
				else printf("Impossible de recuperer le nom de PC. Votre message ne sera pas envoye.");
				
				file.close();
			}
			else printf("Erreur dans l'ouverture du fichier.\n");
		}
		else if(_strcmp(line, "read", true, 0, 4))
		{
			system("cls");
			ifstream file("\\\\KIKI\\ecriture\\texte.txt");
			if(file.is_open())
			{
				string newline;
				while (getline(file, newline))
					cout << newline << '\n';
				
				file.close();
				printf("\n... Tapez une commande ...\n");
			}
			else printf("Erreur dans l'ouverture du fichier.\n");
		}
		else if(_strcmp(line, "cls", true, 0, 3)) {
			system("cls");
			printf("... Tapez une commande. Tapez 'help' pour la liste des commandes. ...\n");
		}
		else if(_strcmp(line, "del", true, 0, 2)) {
			TCHAR  infoBuf[50];
			DWORD  bufCharCount = 50;
			if(GetComputerName(infoBuf, &bufCharCount)) {
				ofstream file("\\\\KIKI\\ecriture\\texte.txt");
				if(id[0] == 0) file << infoBuf << " a supprime tout les messages." << endl;
				else file << id << " a supprime tout les messages." << endl;
				file.close();
			}
			else printf("Impossible de recuperer le nom de PC. Votre commande ne sera pas effectuee.");
			system("cls");
			printf("... Tapez une commande. Tapez 'help' pour la liste des commandes. ...\n");
		}
		else if(_strcmp(line, "help", true, 0, 4)) {
			printf("\n --- Liste des commandes: ---\nwrite [message] (Ecris dans le fichier)\nread (Lis tout le fichier)\ncls (nettoie la console)\n");
			printf("\n... Tapez une commande ...\n");
		}
		else if(_strcmp(line, "id", true, 0, 2)) {
			_strdel(line, 0, 3);
			_strcpy(id, line);
			printf("Votre ID est maintenant: %s\n... Tapez une commande ...\n", id);
		} else printf("... Cette commande n'existe pas. ...\n");
	}
	system("pause");
    return 0;
 }