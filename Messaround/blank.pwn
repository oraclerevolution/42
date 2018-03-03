#include <a_samp>
#include <sscanf2>
#include <kcmd>
#include <lompi>
#include <getfilecontent>
#pragma tabsize 0
#define DSCM
#include <days>
#define cmd:%1(%2) \
			forward cmd_%1(%2); \
			public cmd_%1(%2)
#define MAX_TIMERS 10

#define INFINITY (Float:0x7F800000)
#define NaN (Float:0x7FFFFFFF)

#define ShowPlayerMarkerForPlayer(%0,%1) SetPlayerMarkerForPlayer(%0,%1,(GetPlayerColor(%1) | 0x000000FF) & 0xFFFFFF99)
#define HidePlayerMarkerForPlayer(%0,%1) SetPlayerMarkerForPlayer(%0,%1,GetPlayerColor(%1) & 0xFFFFFF00)

new MusicURLS[][]={
	"abcd efg",
	"abcdefg",
	"URLdsqdsqds3"
};

stock ShowPlayerMarkerForAll(playerid)
{
	new color = GetPlayerColor(playerid);
	for(new i = 0; i < MAX_PLAYERS; i++)
	    if(IsPlayerConnected(i))
	        SetPlayerMarkerForPlayer(i, playerid,(color | 0x000000FF) & 0xFFFFFF99);
	return;
}

stock HidePlayerMarkerForAll(playerid)
{
	new color = GetPlayerColor(playerid);
	for(new i = 0; i < MAX_PLAYERS; i++)
	    if(IsPlayerConnected(i))
	        SetPlayerMarkerForPlayer(i, playerid, color & 0xFFFFFF00);
	return;
}

forward at();
public at()
{
	print("TOP");
}

#pragma unused gStrings

new
    gStrings[3][4] =
    {
        {'H',  'e',  'l', 'l'},
        {'o',  'o', 'w', '\0'},
        {'\0', 'Y',  'o', '\0'}
    };

#define min _min
#define max _max

main()
{
	/*new var[3];
	var[0]=random(10);
	var[1]=random(10);
	var[2]=random(10);
 	printf("%d - %d - %d", var[0], var[0]+var[1], var[1]+var[2]);*/
    //Test_Icule("%d%d%f%f", 1, 2, 3.4, 5.6);
    new var[]="watashi ga motenai no wa dou kangaetemo omaera ga warui";
    printf("%d", sizeof(var));
}

stock rand(min, max)
	return random(max - min) + min;

stock _min({Float, _}:...)
{
	new args 	= numargs(),
		_minim 	= 999999999;

	for(new i = 0; i < args; i++)
	{
	    new arg = getarg(i);

		if(arg < _minim)
			_minim = arg;

	}
	
	return _minim;
}

stock _max({Float, _}:...)
{
	new args 	= numargs(),
		_maxim 	= -99999999;

	for(new i = 0; i < args; i++)
	{
	    new arg = getarg(i);
		if(arg > _maxim)
			_maxim = arg;

	}
	return _maxim;
}

stock cval(ch)
	return '0' <= ch <= '9' ? ch - 48 : 0;

stock IsRpName(name[])
{
    new maj         = 0,
        underscore  = 0;

    for(new i = 0, len = strlen(name); i < len && maj <= 2 && underscore <= 1; i++)
    {
        if('A' <= name[i] <= 'Z')
        {
            maj++;
            if(i != 0 && name[i - 1] != '_')
                return false;
        }
        if(name[i] == '_')
		{
        	if(i == 0 || i == len - 1)
            	return false;
            underscore++;
		}
    }
    if(maj != 2 || underscore != 1)
        return false;

    return true;
}

stock GetPlayerID(name[])
{
	//à tester
	new players[MAX_PLAYERS],
		mindiff = 999,
		index;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i))
			continue;
		new name2[MAX_PLAYER_NAME + 1];
		GetPlayerName(playerid, name2, MAX_PLAYER_NAME + 1);
		players[i] = strdiff(name, name2);
		if(mindiff > players[i])
		{
			mindiff = players[i];
			index = i;
		}
		if(players[i] ==0)
		    return i;
	}
	return mindiff;
}

stock strdiff(str1[], str2[], ignorecase = true)
{
	new len[2];
	len[0] = strlen(str1);
	len[1] = strlen(str2);
	new diff = (len[0] > len[1]) ? (len[0] - len[1]) : (len[1] - len[0]);
	for(new i = 0; i < len[0] && i < len[1]; i++)
	{
		if((ignorecase) ? (tolower(str1[i]) != tolower(str2[i])) : (str1[i] != str2[i]))
		    diff++;
	}
	return diff;
}

stock strdel2(string[], start, end, size)
{
	new len = strlen(string) -1;
	if( start < 0 || start > end)
	    return false;
	    
	if(size < len + 1)
	    size = len;
	    
	if(end >= len)
	    end = len;
	    
	new diff = end - start,
		i;
	for(i = end; end < len; end++)
	    string[i - diff]=string[i];
	    
	string[i + 1] = EOS;
	    
	return true;
}

stock strcat2(string[], const string2[], sz = -1)
{
	new len  = strlen(string ),
		len2 = strlen(string2);
	if(sz < 1)
		sz = len + len2;
		
	for(new i = len; i < len + len2 && i - len < sz; i++)
		string[i]=string2[i - len];

	if(i < sz) string[i + 1] = 0;
	else string[sz - 1] 0;

	return 1;
}

public OnPlayerRequestClass(playerid,classid)
{
	SendClientMessage(playerid, -1, "lol");
    return 1;
}

stock MyFunc(marray[][])
{
	printf("%f %d", marray[0][size], marray[0][bande]);

	return 1;
}


stock Test_Icule(a_szDescriptor[], {Float, _}:...)
{
	new l_iArgIndex;
	new l_iDescriptorLen;
	new l_iArgValue;
	
	l_iDescriptorLen = strlen(a_szDescriptor);

	for(l_iArgIndex = 0; l_iArgIndex < l_iDescriptorLen; l_iArgIndex++)
	{
	    l_iArgValue = getarg(l_iArgIndex + 1);

		switch(a_szDescriptor[l_iArgIndex] + 1)
  		{
   			case 'd', 'i':
	     		printf("%d", l_iArgValue);
			case 'f':
		 		printf("%f", l_iArgValue);
			default:
				print("Erreur ...");
		            //en gros
		}
	}
}

stock sformat(frmt[], {Float, _}:...)
{
	new string[256] = "",
		len			= strlen(frmt);
	
	for(new i = 0; i < len; i++)
	{
	    new arg = getarg(i + 1);

	    switch(frmt[i])
	    {
	        case 'd', 'i':
	        	format(string, sizeof(string), "%s%d", string, arg);
 	        case 'f':
	        	format(string, sizeof(string), "%s%f", string, arg);
   	        case 'c':
	        	format(string, sizeof(string), "%s%c", string, arg);
  	        case 's':
	        	format(string, sizeof(string), "%s%s", string, arg);
	    }

	}
	printf("'%s'", string);
	return;
}

/*

stock TestFuncTagof({Float,_}:...)
{
	for(new i=0; i < numargs(); i++)
	{
		if(tagof(getarg(i, 0)) == tagof(Float:))
			printf("Float: %f", arg);
			
        else if(tag == tagof(bool:))
			printf("Bool: %s", (arg) ? ("true") : ("false"));

		else
		    printf("Tag inconnu: argument %d, tag %x", i, tagof(arg));
	}
	return;
}*/

enum edhdjehdk
{
    aaa,
    bbb,
    ccc
}

stock MaFonctionA(lala)
{
    printf("%d %c", lala, lala);
    return 1;
}

stock MaFonctionB(lala[])
{
    print(lala);
    return 1;
}

stock TriArray(array[], arraysize)
{
	new ech=0;
	for(new x=0;x<arraysize && x!=arraysize-1;x++)
	{
	    if(array[x] < array[x+1]) {
	        new tmp=array[x];
	        array[x]=array[x+1];
	        array[x+1]=tmp;
	        x=-1;
	        ech++;
	    }
 	}
	return ech;
}

stock trierTableau(tableau[], tailleTableau)
{
        new bool:iteration = true,
                tmp = 0,
                index = 0,
                nmbEchanges = 0;

        while (iteration)
        {
                // On passe itération à false pour prévoir la sortie de boucle
                iteration = false;

                // On parcours le tableau
                for (index = 0; index < tailleTableau; index++)
                {
                        // Si l'ordre de deux cases est inversé
                        if (tableau[index] > tableau[index + 1])
                        {
                                // On inverse les deux valeurs
                                tmp = tableau[index];
                                tableau[index] = tableau[index + 1];
                                tableau[index + 1] = tmp;

                                // On passe le booléen itération à true pour indiquer qu'il y a eu un échange
                                iteration = true;

                                // On peut même compter le nombre d'échanges effectués
                                nmbEchanges++;
                        }
                }
        }

        // On retourne le nombre d'échanges effectués une fois le tri terminé
        return nmbEchanges;
}

stock S_HEX(color)
{
	new frmt[7];
	format(frmt, sizeof(frmt), "%x", color);
	return frmt;
}

public OnGameModeInit()
{
 

}

stock LoadFS(name[])
{
	new command[126];
	format(command, sizeof(command), "loadfs %s", name);
	SendRconCommand(command);
	return 1;
}

stock ShowPlayerDialogEx(playerid, dialogid, caption[], text[], button1[], button2[]="")
{
	SetPVarString(playerid, "SPD_caption", caption);
	SetPVarString(playerid, "SPD_text", text);
	SetPVarString(playerid, "SPD_button1", button1);
	SetPVarString(playerid, "SPD_button2", button2);
	return CallRemoteFunction("SPD_ShowPlayerDialogEx", "ii", playerid, dialogid);
}

/*  DEBUT DE CE QUE JE N'AI PAS CODE  */
stock strrest(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}
	new offset = index;
	new result[128];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock FormatMoney(Float:amount, delimiter[2]=",")
{
	#define MAX_MONEY_STRING 16
	new txt[MAX_MONEY_STRING];
	format(txt, MAX_MONEY_STRING, "$%d", floatround(amount));
	new l = strlen(txt);
	if (amount < 0) // -
	{
	    if (l > 5) strins(txt, delimiter, l-3);
		if (l > 8) strins(txt, delimiter, l-6);
		if (l > 11) strins(txt, delimiter, l-9);
	}
	else
	{
		if (l > 4) strins(txt, delimiter, l-3);
		if (l > 7) strins(txt, delimiter, l-6);
		if (l > 10) strins(txt, delimiter, l-9);
	}
	return txt;
}


/*  FIN  */

stock IsFolderExist(src[])
{
	new frmt[128];
	format(frmt, sizeof(frmt), "%s\\IsFolderExist.ini", src);
	new exist_before=fexist(frmt);
	new File:file = fopen(frmt, io_append);
	if(fexist(frmt)) {
		fclose(file);
		if(!exist_before) fremove(frmt);
		return true;
	}
	return false;
}

stock date(frmt[], bool:dont_touch_unknowned_chars=false)
{
	new string[500] = "",
	 	cdate[3],
 		time[3],
		len = strlen(frmt);
		 
	gettime(time[0], time[1], time[2]);
	getdate(cdate[0], cdate[1], cdate[2]);
	
	for(new i = 0; i < len; i++)
	{
	    switch(frmt[i])
	    {
	        case 'U':
	            format(string, sizeof(string), "%s%d", string, gettime());
			case 'A':
	        	format(string, sizeof(string), "%s%s", string, (time[0] < 12) ? ("AM") : ("PM"));
			case 'a':
	        	format(string, sizeof(string), "%s%s", string, (time[0] < 12) ? ("am") : ("pm"));
	        case 'G':
	        	format(string, sizeof(string), "%s%d", string, time[0]);
	        case 'g':
	        	format(string, sizeof(string), "%s%d", string, (time[0] > 12) ? (time[0]-12) : (time[0]));
			case 'H':
	        	format(string, sizeof(string), "%s%s%d", string, (time[0] > 10) ? ("") : ("0"), time[0]);
	        case 'h':
	        	format(string, sizeof(string), "%s%s%d", string, (((time[0] > 12) ? (time[0]-12) : (time[0]))>10) ? ("") : ("0"), (time[0]>12) ? (time[0]-12) : (time[0]));
	        case 'i':
	        	format(string, sizeof(string), "%s%s%d", string, (time[1]<10) ? ("0") : (""), time[1]);
	        case 's':
	        	format(string, sizeof(string), "%s%s%d", string, (time[2]<10) ? ("0") : (""), time[2]);
	        case 'd':
	        	format(string, sizeof(string), "%s%s%d", string, (cdate[2]<10) ? ("0") : (" "), cdate[2]);
	        case 'j':
	        	format(string, sizeof(string), "%s%d", string, cdate[2]);
	        case 'm':
	        	format(string, sizeof(string), "%s%s%d", string, (cdate[1]<10) ? ("0") : (" "), cdate[1]);
	        case 'M':
	        {
	            switch(cdate[1])
				{
					case 1:strcat(string, "Jan");
					case 2:strcat(string, "Feb");
					case 3:strcat(string, "Mar");
					case 4:strcat(string, "Apr");
					case 5:strcat(string, "May");
					case 6:strcat(string, "Jun");
					case 7:strcat(string, "Jul");
					case 8:strcat(string, "Aug");
					case 9:strcat(string, "Sep");
					case 10:strcat(string, "Oct");
					case 11:strcat(string, "Nov");
					case 12:strcat(string, "Dec");
				}
			}
	        case 'F':
	        {
	            switch(cdate[1])
				{
					case 1:strcat(string, "January");
					case 2:strcat(string, "February");
					case 3:strcat(string, "March");
					case 4:strcat(string, "April");
					case 5:strcat(string, "May");
					case 6:strcat(string, "June");
					case 7:strcat(string, "July");
					case 8:strcat(string, "August");
					case 9:strcat(string, "September");
					case 10:strcat(string, "October");
					case 11:strcat(string, "November");
					case 12:strcat(string, "Dececember");
				}
			}
	        case 'n':
	        	format(string, sizeof(string), "%s%d", string, cdate[1]);
	        case 'Y':
	        	format(string, sizeof(string), "%s%d", string, cdate[0]);
	        case 'y':{
	        	format(string, sizeof(string), "%s%d", string, cdate[0]);
				strdel(string, strlen(string)-4, strlen(string)-2);
			}

	        default:
	            if(!dont_touch_unknowned_chars) format(string, sizeof(string), "%s%c", string, frmt[i]);
	    }
	}
	return string;
}

stock ndate(formatt[], bool:block_unk = false)
{
    new string[128] = "",
		len			= strlen(formatt),
		cdate[3],
		ctime[3];

    gettime(ctime[0], ctime[1], ctime[2]);
    getdate(cdate[0], cdate[1], cdate[2]);
    
    for(new i = 0; i < len; i++)
    {

        switch(formatt[i])
        {
            /*************************
                    Day
            *************************/

            case 'd': format(string, sizeof(string), "%s%02d", string, cdate[2]);
            case 'D':
            {
                switch(nGetDate())
                {
                    case 0: strcat(string, "Sat");
                    case 1: strcat(string, "Sun");
                    case 2: strcat(string, "Mon");
                    case 3: strcat(string, "Tue");
                    case 4: strcat(string, "Wed");
                    case 5: strcat(string, "Thu");
                    case 6: strcat(string, "Fri");
                }
            }
            case 'j': format(string, sizeof(string), "%s%d", string, cdate[2]);
            case 'l':
            {
                switch(nGetDate())
                {
                    case 0: strcat(string, "Saturday");
                    case 1: strcat(string, "Sunday");
                    case 2: strcat(string, "Monday");
                    case 3: strcat(string, "Tuesday");
                    case 4: strcat(string, "Wednesday");
                    case 5: strcat(string, "Thursday");
                    case 6: strcat(string, "Friday");
                }
            }
            case 'N': format(string, sizeof(string), "%s%d", string, nGetDate());
            case 'S':
            {
                switch(cdate[2])
                {
                    case 1, 21, 31: strcat(string, "st");
                    case 2, 22: strcat(string, "nd");
                    case 3, 23: strcat(string, "rd");
                    default: strcat(string, "th");
                }
            }
            case 'w': format(string, sizeof(string), "%s%d", string, nGetDate(-1));
            case 'z': format(string, sizeof(string), "%s%d", string, getdate());

            /*******************************
                        Week
            *******************************/

            case 'W':
            {
                new nbw, obw;
                new weeksMonth[12] = {4, 4, 4, 4, 5, 4, 5, 5, 4, 4, 4, 5};
                for(new x = 0; x < sizeof(weeksMonth); x++)
                {
                    nbw += weeksMonth[x];
                    if(obw < getdate() / 7 < nbw) break;
                    else obw = nbw;
                }
                format(string, sizeof(string), "%s%d", string, nbw);
            }

            /**************************
                    Month
            **************************/

            case 'F':
            {
                switch(cdate[1])
                {
                    case 1: strcat(string, "January");
                    case 2: strcat(string, "February");
                    case 3: strcat(string, "March");
                    case 4: strcat(string, "April");
                    case 5: strcat(string, "May");
                    case 6: strcat(string, "June");
                    case 7: strcat(string, "July");
                    case 8: strcat(string, "August");
                    case 9: strcat(string, "September");
                    case 10: strcat(string, "October");
                    case 11: strcat(string, "November");
                    case 12: strcat(string, "December");
                }
            }
            case 'm': format(string, sizeof(string), "%s%02d", string, cdate[1]);
            case 'M':
            {
                switch(cdate[1])
                {
                    case 1: strcat(string, "Jan");
                    case 2: strcat(string, "Feb");
                    case 3: strcat(string, "Mar");
                    case 4: strcat(string, "Apr");
                    case 5: strcat(string, "May");
                    case 6: strcat(string, "Jun");
                    case 7: strcat(string, "Jul");
                    case 8: strcat(string, "Aug");
                    case 9: strcat(string, "Sep");
                    case 10: strcat(string, "Oct");
                    case 11: strcat(string, "Nov");
                    case 12: strcat(string, "Dec");
                }
            }
            case 'n': format(string, sizeof(string), "%s%d", string, cdate[1]);
            case 't':
            {
                new d;
                switch(cdate[1])
                {
                    case 1: d = 31;
                    case 2:
                    {
                        if(cdate[0] % 4 != 0) d = 28;
                        else d = 29;
                    }
                    case 3: d = 31;
                    case 4: d = 30;
                    case 5: d = 31;
                    case 6: d = 30;
                    case 7: d = 31;
                    case 8: d = 31;
                    case 9: d = 30;
                    case 10: d = 31;
                    case 11: d = 30;
                    case 12: d = 31;
                }
                format(string, sizeof(string), "%s%d", string, d);
            }

            /*************************************
                            Year
            *************************************/

            case 'L':
            {
                new b = false;
                if(cdate[0] % 4 == 0) b = true;
                format(string, sizeof(string), "%s%d", string, b);
            }
            case 'Y': format(string, sizeof(string), "%s%d", string, cdate[0]);
            case 'y':
            {
                new dat[5];
                valstr(dat, cdate[0]);
                format(string, sizeof(string), "%s%s", string, dat[2]);
            }

            // To do : case 'o', once I'll know how useful it could be

            /********************************
                        Hours
            ********************************/

            case 'a':
            {
                if(0 <= ctime[0] < 12) strcat(string, "am");
                else strcat(string, "pm");
            }
            case 'A':
            {
                if(0 <= ctime[0] < 12) strcat(string, "AM");
                else strcat(string, "PM");
            }
            case 'g': format(string, sizeof(string), "%s%d", string, (ctime[0] > 12 ? ctime[0]-12 : ctime[0]));
            case 'G': format(string, sizeof(string), "%s%d", string, ctime[0]);
            case 'h': format(string, sizeof(string), "%s%02d", string, (ctime[0] > 12 ? ctime[0]-12 : ctime[0]));
            case 'H': format(string, sizeof(string), "%s%02d", string, ctime[0]);
            case 'i': format(string, sizeof(string), "%s%02d", string, ctime[1]);
            case 's': format(string, sizeof(string), "%s%02d", string, ctime[2]);
            // faire case 'u' quand je saurais à quoi ça sert

            /****************************************
                    Complete date and hours
            ****************************************/

            case 'c': format(string, sizeof(string), "%s%d-%d-%dT%d:%d:%d", string, cdate[0], cdate[1], cdate[2], ctime[0], ctime[1], ctime[2]);
            case 'r':
            {
                switch(nGetDate())
                {
                    case 0: strcat(string, "Sat");
                    case 1: strcat(string, "Sun");
                    case 2: strcat(string, "Mon");
                    case 3: strcat(string, "Tue");
                    case 4: strcat(string, "Wed");
                    case 5: strcat(string, "Thu");
                    case 6: strcat(string, "Fri");
                }
                format(string, sizeof(string), "%s, %d ", string, cdate[2]);
                switch(cdate[1])
                {
                    case 1: strcat(string, "Jan");
                    case 2: strcat(string, "Feb");
                    case 3: strcat(string, "Mar");
                    case 4: strcat(string, "Apr");
                    case 5: strcat(string, "May");
                    case 6: strcat(string, "Jun");
                    case 7: strcat(string, "Jul");
                    case 8: strcat(string, "Aug");
                    case 9: strcat(string, "Sep");
                    case 10: strcat(string, "Oct");
                    case 11: strcat(string, "Nov");
                    case 12: strcat(string, "Dec");
                }
                format(string, sizeof(string), "%s %d %02d:%02d:%02d", string, cdate[0], ctime[0], ctime[1], ctime[2]);
            }
            case 'u': format(string, sizeof(string), "%s%d", string, gettime());

            default: if(!block_unk) format(string, sizeof(string), "%s%c", string, formatt[i]);
        }
    }
    return string;
}

stock nGetDate(addsth = 0, cdate[3] = {0, 0, 0})
{
    if(cdate[0] == 0) getdate(cdate[0], cdate[1], cdate[2]);
    new v1, v2;
    if (cdate[1] <= 2)
    {
        cdate[1] += 12;
        --cdate[0];
    }
    v1 = cdate[0] % 100;
    v2 = cdate[0] / 100;

    return (((cdate[2] + (cdate[1]+1)*26/10 + v1 + v1/4 + v2/4 - 2*v2) % 7) + addsth);
}

stock GenerateCode(length = 6)
{
	if(length > 10)
 		length = 10;
	 
	new str[11];
	for(new i = 0; i < length; i++){
	    new letter = random(10) + 48;
	    while(ccontain(str, letter, length))
			letter = random(10) + 48;
		str[i] = letter;
	}
	
	return str;
}

stock ccontain(const str[], ch1, end = -1)
{
	if(end <= -1 || end >= strlen(str))
		end = strlen(str);
		
	for(new i = 0;i < end; i++)
	    if(str[i] == ch1) return true;

	return false;
}

stock cfind(const str[], ch1, end = -1)
{
    if(!(-1 < end < strlen(str)))
        end = strlen(str) - 1;
        
	if(ch1 < 0)
	    return -1;

    for(new i = 0; i < end; i++)
        if(str[i] == ch1) return i;

    return -1;
}

stock cfindc(const str[], ch1, number, end = -1)
{
    if(!(-1 < end < strlen(str)))
        end = strlen(str) - 1;

	if(ch1 < 0)
	    return -1;

    for(new i = 0, c_count = 0; i < end; i++)
        if(str[i] == ch1)
        {
            c_count++;
            if(c_count == number)
                return i;
        }

    return -1;
}

stock ccount(const str[], ch1, pos=-1)
{
	new ch_count=0;
	if(pos<=-1) pos=strlen(str);
	for(new i=0;i<pos;i++){
		if(str[i]==ch1) ch_count++;
	}
	return ch_count;
}

stock creplace(string[], search, remplacement, bool:ignorecase=false)
{
	new count=0;
	for(new i=0;i<strlen(string);i++)
	{
	    if(ignorecase)
			if(string[i]==search) {string[i]=remplacement;
 			count++;}
		else
		    if(tolower(string[i])==tolower(search)) {string[i]=remplacement;
 			count++;}
	}
	return count;
}

stock ktolower(ch)
	return (64 < ch < 91) ? (ch + 32) : (ch);
	
stock strtolower(str[])
{
	new len = strlen(str);
	
	for(new i=0; i < len; i++)
 		str[i]=ktolower(str[i]);
 		
	return;
}

stock strp(string[], index, separator = ' ')
{
	new result[60]		=  "",
		i				=  index,
		space			=  0,
		string_len		= strlen(string);
		
	if(index < 0 || separator < 32)
		return result;
	
 	while(space != index)
 	{
	 	while(i < string_len && string[i] != separator)
			i++;

 		space++;
 	}
		 
  	if(i >= string_len)
  		return result;
  		
	format(result, sizeof(result), string[(index == 0) ? (i) : (i + 1)]);
	i=0;
	
	while(result[i] != separator) i++;
	strdel(result, i, strlen(result));
	
	return result;
}

stock strp2(const string[], &index, separator = ' ')
{
	//Ne marche pas sur la dernière chaine
	new result[60]		= "",
	    i               = index,
		string_len		= strlen(string);

	if(separator < 32)
		return result;

	while(index < string_len && string[index] != separator)
		index++;

  	if(index >= string_len)
  		return result;

	format(result, sizeof(result), string[i]);

strdel(result, index - i, string_len - i);

	index++;
	return result;
}

stock strpex(string[], &index)
{
	new str[60];
	str = strp(string, index);
	index++;
	
	return str;
}

stock getStringValue(string[])
{
	new result[128];
	for(new i=0;i<strlen(string);i++){
		new var[3];
		format(var, 3, "%d", string[i]);
		strcat(result, var);
	}
	return strval(result);
}

stock str_cmp(string[], string2[], bool:respectcase=false)
{
	if(strlen(string)!=strlen(string2)) return 0;
	for(new i=0;i<strlen(string);i++) {
		if(!respectcase)
			if(tolower(string[i])!=tolower(string2[i]))  return 0;
		else
			if(string[i]!=string2[i]) return 0;
	}
	return 1;
}

/*public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[128], tmp[128],idx;
	cmd=strtok(cmdtext, idx);
		tmp=strrest(cmdtext, idx);

	if(strcmp("/cmd", cmd, true)==0)
	{
	    print("Command güd");
		tmp=strrest(cmdtext, idx);
		print(tmp);
	          new length = strlen(cmdtext);
        while ((idx < length) && (cmdtext[idx] <= ' '))
        {
                idx++;
        }
        new offset = idx;
        new result[64];
        while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
        {
                result[idx - offset] = cmdtext[idx];
                idx++;
        }
        result[idx - offset] = EOS;
        print(result);
	    return 1;
	}


    new cmd[60], params[128], func[128]="cmd_", i=1;
    while(i<strlen(cmdtext) && i<sizeof(cmd) && cmdtext[i]>' ')
    {
        cmd[i-1]=tolower(cmdtext[i]);
        i++;
    }
    strmid(params, cmdtext, i+1, strlen(cmdtext));
    strcat(func, cmd);
    if(CallLocalFunction(func, "is", playerid, (!strlen(params)) ? (" ") : (params))==1) return 1;
    return 0;
}*/

cmd:run(playerid, params[])
{
    ApplyAnimation(playerid, "PED", "run_player", 6.1, 1, 1, 1, 0, 0, 1);
    return 1;
}

cmd:dialog(playerid, params[])
{
	ShowPlayerDialogEx(playerid, 0, "Test", "Pédé", "prout");
	return 1;
}

public OnRconCommand(cmd[])
{
	//printf("%c", params);
	new str[256]="";
	for(new i=0;i<strlen(cmd);i++)
	{
	    if(cmd[i]>=97) format(str, sizeof(str), "%s'%d' ", str, cmd[i]);
	    else format(str, sizeof(str), "%s'%i' ", str, cmd[i]);
	}
    printf("'%s': %s", cmd, str);
    return 1;
}
