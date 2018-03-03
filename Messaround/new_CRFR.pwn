/*=======================================
  ########  ########  ########  ########
  ##        ##    ##  ##        ##    ##
  ##        ##   ##   ##        ##   ##
  ##        ######    ######    ######
  ##        ##   ##   ##        ##   ##
  ########  ##    ##  ##        ##    ##
              Par Kiloutre
========================================*/

#include <a_samp>
#undef MAX_PLAYERS
//On supprime MAX_PLAYERS
#define MAX_PLAYERS 21
//On défini MAX_PLAYERS à 21 car c'est le nombre de joueur maximum
#include <a_mysql>
#include <streamer>
#include <kcmd>
#include <progressbar>
#include <sscanf2>
#include <FCNPC>
#include <debug>

#pragma dynamic 10000

//Define pour la version affichée
#define SERVER_VERSION "Version: 1.0"
#define MAX_MESSAGE_SIZE 145
#define KickP(%1) SetTimerEx("KickPlayer", 700, false, "i", %1)
#define ShowPlayerMarkerForPlayer(%0,%1) SetPlayerMarkerForPlayer(%0,%1,(GetPlayerColor(%1) | 0x000000FF) & 0xFFFFFF99)
#define HidePlayerMarkerForPlayer(%0,%1) SetPlayerMarkerForPlayer(%0,%1,GetPlayerColor(%1) & 0xFFFFFF00)

//Defines checkpoints
#define INVALID_CHECKPOINT -1
#define CP_24/7 0
#define CP_BINCO_GANTON 1
#define CP_TATOO_GANTON 2
#define CP_COIFFEUR_GANTON 3
#define CP_ROBPIZZA_GANTON 4
#define CP_BOMBSHOP 5
#define CP_PRISON 6
#define CP_ALHAMBRA 7
#define CP_SUBURBAN 8
#define CP_ROBOIS 9
#define CP_CLUCKIN 10
#define CP_BURGERSHOT 11
#define CP_INSIDETRACK 12
#define CP_ZIP 13
#define CP_TEENGREEN 14
#define CP_AMMUNATION 15
#define CP_BANQUE 16
#define CP_BUYVEH 17
#define CP_HOPITAL 18
#define CP_VENDREV 19
#define CP_EXPLBANKGATE 20
#define CP_VOLERBANQUE 21
#define CP_WEAPONPICKB 22
#define CP_WEAPONPICKG 23

#define CP_ATM1 50
#define CP_ATM2 51
#define CP_ATM3 52
#define CP_ATM4 53
#define CP_ATM5 54

//Define couleurs
#define COLOR_WHITE -1
#define COLOR_RED 0xDF0000FF
#define COLOR_GREEN 0x29A613FF
#define COLOR_BLUE 0x0C80D6FF
#define COLOR_YELLOW 0xD0CB04FF
#define COLOR_GREY 0x696969FF
#define COLOR_ORANGE 0xE09405FF
#define COLOR_PINK 0xFF0080FF
//Autres couleurs
#define COLOR_ERROR 0xD2691EAA
#define COLOR_DARKORANGE 0xD75906FF
#define COLOR_DARKYELLOW 0xE9BA1BFF
#define COLOR_DARKGREY 0x7D7D7DFF
#define COLOR_ROYALBLUE 0x4169FFAA
#define COLOR_BLUECOPS 0x1585DFFF
#define COLOR_BAC 0x09E3BDFF
#define COLOR_SWAT 0x1560DBFF
#define COLOR_MILI 0x8000FFFF
#define COLOR_LIGHTGREY 0x9F9F9FFF
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIGHTGREYBLUE 0x4169FFAA
#define COLOR_SLIME 0x10F441AA

//Define métier
#define TEAM_VOLEUR 0
#define TEAM_KIDNAP 1
#define TEAM_TERRO 2
#define TEAM_VIOLEUR 3
#define TEAM_HITMAN 4
#define TEAM_HACKER 5

#define TEAM_COPS 30
#define TEAM_SWAT 31
#define TEAM_MILITARY 32
#define TEAM_BAC 33

#define EXTTEAM_LEADGROOVE 0
#define EXTTEAM_GROOVE 1
#define EXTTEAM_LEADBALLAS 2
#define EXTTEAM_BALLAS 3
#define EXTTEAM_LEADBAC 4
#define EXTTEAM_BAC 5

//Define dialogues
#define DIALOG_ALL 9999

#define DIALOG_CONNECT 0
#define DIALOG_METIER 1
#define DIALOG_24/7 2
#define DIALOG_BUY 3
#define DIALOG_SAC 4
#define DIALOG_PICKSAC 5
#define DIALOG_PUTSAC 6
#define DIALOG_ATM 7
#define DIALOG_BANQUE 8
#define DIALOG_PUTMONEY 9
#define DIALOG_GETMONEY 10
#define DIALOG_BUYVEH 11
#define DIALOG_CARJACK 12
#define DIALOG_BOMBSHOP 13
#define DIALOG_BUYBOMB 14
#define DIALOG_COMP 15
#define DIALOG_UPCOMP 16
#define DIALOG_COMPINFO 17
#define DIALOG_WEPD 18
#define DIALOG_BUYWEP 19
#define DIALOG_GPS 20
#define DIALOG_COFFREG 21
#define DIALOG_COFFREGPUT 22
#define DIALOG_COFFREGGET 23
#define DIALOG_COFFREB 24
#define DIALOG_COFFREBPUT 25
#define DIALOG_COFFREBGET 26
#define DIALOG_PICKWEP 27
#define DIALOG_ADCMDS 28

#define DIALOG_REGLESMENU 998
#define DIALOG_REGLESCLASSES 999

#define LOCAL

#if defined LOCAL
	#define mysql_host "localhost"
	#define mysql_user "root"
	#define mysql_password ""
	#define mysql_database "crfr"
#else
	#define mysql_host "publicsql-1.pulseheberg.net"
	#define mysql_user "service_19045"
	#define mysql_password "w88cIrDM3F"
	#define mysql_database "service_19045"
#endif

main()
{
	print("==========================================");
	print("  ########  ########  ########  ########  ");
  	print("  ##        ##    ##  ##        ##    ##  ");
  	print("  ##        ##   ##   ##        ##   ##   ");
  	print("  ##        ######    ######    ######    ");
  	print("  ##        ##   ##   ##        ##   ##   ");
 	print("  ########  ##    ##  ##        ##    ##  ");
	print("==           CRFR par KILOUTRE          ==");
	print("==========================================");
}

//Enum et variables

AntiDeAMX()
{
    new a[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}

stock log(name[], string[])
{
	new d[3], t[3];
	getdate(d[0], d[1], d[2]);
	gettime(t[0], t[1], t[2]);
	printf("[%d/%d %d:%d] (%s) %s", d[1], d[2], t[0], t[1], name, string);
	return 1;
}

enum PINFO
{
	bool:logged,
	UID,
	CLASS,
	TEAM,
	EXTTEAM,
	wanted,
	spawned,
	name[MAX_PLAYER_NAME+1],
	skin,
	Float:hp,
	admin,
	adminservice,
	adminmode,
	adskin,
	bool:cuffed,
	bool:kidnapped,
	bool:afk,
	mentime,
	kidnappedtime,
	lastvhack,
	lastrob,
	lastrobbed,
	lastkidnap,
	lastkidnapped,
	lastviol,
	lastvioled,
	lastlrob,
	lastrobatm,
	lastatmhack,
	hackatmid,
	robatm,
	lrob,
	lastcarjack,
	lastxpl,
    lastlxpl,
	lastexpl,
	jailtime,
	pvtime,
	lastsuspect,
	mutedtime,
	avert,
	last_vehicle,
	lastdamage,
	bool:MST,
	bool:furtiv,
	bool:hidden,
	Float:noiselvl,
	success[128],
	kills,
	deaths,
	kill,
	death,
	tkill,
	totaldetach,
	lasttrob,
	hit,
	hitamount,
	bool:VIP,
	bool:military,
	bool:ballas,
	bool:groove,
	bool:bac,
	bool:leadballas,
	bool:leadgroove,
	bool:leadbac,
	bool:seeid,
	expltimer,
	hackatmtimer,
	Float:hackatm,
	bool:hackvehp,
	bool:invisible,
	lastinvisible,
	invisibletimer,
	ctimer,
	lastpm,
	bool:lastpmtype,
	lastweaponpick,
	lastcassmen,
	roblvl,
	robprogress,
	terrolvl,
	terroprogress,
	policelvl,
	policeprogress,
	bool:freeze
}

enum PINV
{
	bool:scissors,
	bool:amplificator,
	saucisses,
	C4,
	ROPES,
	SAC_C4,
	SAC_ROPES,
	SAC_CASH,
	BANK_CASH
}

enum COMP
{
	comp_lvl,
	comp_points,
	competences[128],
	comp_nextlvl
}

enum SKILL
{
	skill_pistol,
	skill_silenced,
    skill_deagle,
    skill_shotgun,
    skill_sawnoff_shotgun,
    skill_spas12_shotgun,
    skill_micro_uzi,
    skill_mp5,
    skill_ak47,
    skill_m4,
    skill_sniper
}

enum PICK
{
	bool:spawned,
	Float:entx,
	Float:enty,
	Float:entz,
	Float:enta,
	Float:extx,
	Float:exty,
	Float:extz,
	Float:exta,
	extid,
	entid,
	interior
}

enum VINFO
{
	bool:spawned=false,
	UID,
	P_UID,
	TEAM,
	bool:destroyed,
	bool:assured,
	bool:gps,
	bool:gonnaexplode,
	vcode[7],
	bool:stolen,
	vtry,
	bool:hacked,
	hacktimer
}

enum EPICKUPS
{
	PICKUP_ASSUR,
	PICKUP_GROOVECOFFRE,
	PICKUP_BALLASCOFFRE,
	PICKUP_BUYWEP
}

enum GMTEAM
{
	GROOVE,
	BALLAS
}

enum TEAMINFO
{
	MONEY,
	SCORE
}

new Teams[GMTEAM][TEAMINFO];

new PlayerColors[200] = {
0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,
0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,
0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,
0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,0x3D0A4FFF,
0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,0x057F94FF,
0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,
0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,
0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,
0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,
0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,0xDCDE3DFF,
0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
0xD8C762FF,0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,
0xF4A460FF,0xEE82EEFF,0xFFD720FF,0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,
0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,
0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,0x275222FF,0xF09F5BFF,
0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,
0x18F71FFF,0x4B8987FF,0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,
0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,
0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,
0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,0x9F945CFF,
0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,
0xD8C762FF,0xD8C762FF
};

new DeathWeaponName[][32] = {
	{"de ses poings."}, // 0
	{"de Poings Américains"}, // 1
	{"d'un Club de Golf"}, // 2
	{"d'une Matraque"}, // 3
	{"d'un Couteau"}, // 4
	{"d'une Batte de Baseball"}, // 5
	{"d'une Pelle"}, // 6
	{"d'une Queue de Billard"}, // 7
	{"d'un Katana"}, // 8
	{"d'une Tronconneuse"}, // 9
	{"d'un Purple Dildo"}, // 10
	{"d'un Big White Vibrator"}, // 11
	{"d'un Medium White Vibrator"}, // 12
	{"d'un Small White Vibrator"}, // 13
	{"de Fleurs"}, // 14
	{"d'une Canne"}, // 15
	{"d'une Grenade"}, // 16
	{"d'un Fumigène"}, // 17
	{"d'un Cocktail Molotov"}, // 18
	{" "}, // 19
	{" "}, // 20
	{" "}, // 21
	{"d'un Colt 45"}, // 22
	{"d'un Colt 45 (Silencieux)"}, // 23
	{"d'un Desert Eagle"}, // 24
	{"d'un Fusil à pompe"}, // 25
	{"d'un Fusil à Canon Scié"}, // 26
	{"d'un Fusil de Combat"}, // 27
	{"d'un Micro Uzi (Mac 10)"}, // 28
	{"d'un MP5"}, // 29
	{"d'un AK47"}, // 30
	{"d'une M4"}, // 31
	{"d'un Tec9"}, // 32
	{"d'un Fusil de Campagne"}, // 33
	{"d'un Fusil de Sniper"}, // 34
	{"d'un Lance-Roquette"}, // 35
	{"d'un Lance-Roquette Téléguidé"}, // 36
	{"d'un Lance-Flammes"}, // 37
	{"d'un Minigun"}, // 38
	{"de Charges de C4"}, // 39
	{"d'un Détonateur"}, // 40
	{"d'une Bombe à tag"}, // 41
	{"d'un Extincteur"}, // 42
	{"d'un Appareil Photo"}, // 43
	{"de Lunettes à Vision Nocturne"}, // 44
	{"de Lunettes à Infrarouges"}, // 45
	{"d'un Parachute"}, // 46
	{"d'un Fake Pistol"}, // 47
	{"de quelque chose..."}, //48
	{"d'un Véhicule"}, //49
	{"de Rotors d'Hélicoptère"}, //50
	{"d'une Explosion"}, //51
	{"de quelque chose..."}, //52
	{"de de l'eau"}, //53
	{"de quelque chose..."} //54
};

new VehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
	"Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
	"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
	"Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
	"Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
	"Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
	"Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
	"Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
	"Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
	"Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
	"Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
	"Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
	"Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
	"Blista Compact", "Police Maverick", "Boxvillde", "Benson", "Mesa", "RC Goblin",
	"Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
	"Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
 	"Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
 	"FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
 	"Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
 	"Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
	"Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
	"Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
	"Elegy", "RainDance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
	"Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
	"News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
	"Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
 	"Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
 	"Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
 	"Tiller", "Utility Trailer"
};

new Float:BuyvehPos[][4]={
	{1085.8286,-1387.9545,13.5149,90.2192},
	{1112.8920,-1387.7129,13.3991,90.2865},
	{1124.7047,-1387.6483,13.4432,89.7235},
	{1136.5526,-1387.8007,13.5101,88.8637}
};
new Float:AssurSpawn[][4] =
{
    {1144.7574,-1431.2477,15.5014,43.6010},
    {1143.9266,-1441.4191,15.5011,36.1846},
    {1142.7957,-1451.4619,15.5013,30.5094},
    {1112.3353,-1433.0562,15.5014,326.2827},
    {1117.6694,-1439.6490,15.5010,322.4771},
    {1117.0844,-1452.2665,15.5014,325.9718},
    {1116.7295,-1463.4729,15.5008,327.0687}
};

new Float:SpawnCrimiPos[][4]={
	{1829.9740,-1847.3551,13.5781,90.1386},
	{1729.3337,-1264.8644,13.5420,123.5800},
	{2251.4055,-1665.2750,15.4690,349.4044},
	{1723.5964,-1632.5203,20.2152,1.7351},
	{1364.0884,-1289.3719,13.5469,89.1290},
	{1829.5685,-1673.5363,13.5469,92.5968},
	{1070.6268,-1349.2552,13.5547,89.4397},
	{1206.5416,-928.9442,42.9292,191.3833},
	{2013.2576,-1414.0879,16.9922,176.6268},
	{1751.2826,-1945.0453,13.5644,180.2733},
	{1327.6703,-1431.4869,14.9720,272.9643}
};

new Float:SpawnFlicPos[][4]={
	{1579.8502,-1636.5485,13.5589,92.0068},
 	{1579.0640,-1634.9065,13.5624,135.9992},
 	{1575.8673,-1634.2642,13.5559,83.0884}
};

new Float:SpawnGroovePos[][4]={
	{2498.6211,-1650.9926,13.5305,164.1333},
	{2512.4160,-1665.9907,13.5724,87.9862},
	{2500.2959,-1686.2477,13.4804,11.2959},
	{2478.8733,-1685.9274,13.5078,347.2879}
};

new Float:SpawnBallasPos[][4]={
	{2768.2271,-1610.7424,10.9219,272.6118},
	{2768.8442,-1608.3269,10.9219,259.7938},
	{2768.7307,-1617.3755,10.9219,269.6181},
	{2773.6831,-1622.6812,10.9219,355.7020},
	{2791.4109,-1598.2760,11.0938,242.8911}
};

new Float:SpawnBACPos[][4]={
	{1150.0,-1181.3373,32.0275,90.0},
	{1150.0,-1182.8932,32.0275,90.0},
	{1150.0,-1179.1531,32.0275,90.0}
};

new Float:JailPos[][4] = {
	{215.5644,110.7332,999.0156,1.2767},
	{219.4913,110.9124,999.0156,359.0834},
	{223.4386,111.0879,999.0156,0.9634},
	{227.4427,111.2414,999.0156,358.1433}
};

new mysql_connection;

new pInfo[MAX_PLAYERS][PINFO], pInv[MAX_PLAYERS][PINV], vInfo[MAX_VEHICLES+1][VINFO];
new pPick[MAX_PLAYERS], pPut[MAX_PLAYERS], pNextBuy[MAX_PLAYERS], pBombNextBuy[MAX_PLAYERS];
new pLastMessage[MAX_PLAYERS], pComp[MAX_PLAYERS][COMP], pNextDComp[MAX_PLAYERS];
new bool:pRegistered[MAX_PLAYERS], pLogChance[MAX_PLAYERS], bool:PlayerWeapons[MAX_PLAYERS][50];
new pSpawnVeh[MAX_PLAYERS], vSpawned[MAX_VEHICLES+1];
new PickupInfo[500][PICK], pSkill[MAX_PLAYERS][SKILL];
new bool:pAntiDM[MAX_PLAYERS][MAX_PLAYERS], bool:pReport[MAX_PLAYERS][MAX_PLAYERS];
new cLastRob[500], PlayerBar:FurtivBar[MAX_PLAYERS];

new Vlights[MAX_VEHICLES],Vdoors[MAX_VEHICLES],Vbonnet[MAX_VEHICLES],Vboot[MAX_VEHICLES],Vobjective[MAX_VEHICLES];
new npcs[MAX_PLAYERS];
new PlayerText:pMsg[MAX_PLAYERS];

new Pickup[EPICKUPS];

new PlayerWeapon[MAX_PLAYERS][13];
new PlayerAmmo[MAX_PLAYERS][13];

new bool:SomeoneHackATM[11];
new LastAtmHacked[10];
new PlayerBar:HackATMT[MAX_PLAYERS];
new PlayerText3D:vlabel[MAX_PLAYERS][MAX_VEHICLES];

new cName[][] =
{
	"au 24/7 de la gare !",
	"au Binco de ganton !",
	"au tatoo's !",
	"chez le coiffeur de ganton !",
	"à la Pizzeria de ganton !",
	"au BombShop !",
	"CP_PRISON",
	"à l'Alhambra !",
	"au SubUrban !",
	"au Roboi's Food Mart !",
	"au Cluckin' Bell !",
	"au Burger's Shot !",
	"a l'Inside Track !",
	"au Zip !",
	"au Teen Green !",
	"a l'ammunation !",
	"CP_BANQUE",
	"au concessionaire !",
	"CP_HOPITAL",
	"CP_VENDREV",
	"CP_EXPLBANKGATE",
	"dans la banque !",
	"CP_WEAPONPICKB",
	"CP_WEAPONPICKG"
};

new Successes[][][]=
{
	{"Vous avez dit Trévor ?!", "Vous avez comis votre premier meurtre !"},
	{"L'acrobate", "Votre tout premier vol à la tire !"},
	{"James Bond 24", "Vous avez tué 24 personnes sans mourir !"},
	{"Le club des 27", "Vous êtes mors à 27 tués !"},
	{"Princesse Zelda", "Vous avez délivré quelqu'un de kidnappé pour la première fois!"},
	{"Super Mario Bros", "Vous avez délivré un total de 20 personnes !"},
	{"Time Out", "Vous êtes à court de temps."}
};

new sCompetences[][][]=
{
	{"Furtivité", "Être invisible sur la carte en étant accroupi"},
	{"Chance", "Augmente les taux de réussite de vos actions"},
	{"Régénération", "Votre vie se régénère automatiquement"}
};

new compInfo[][]=
{
	"La compétence furtivité vous permet d'être invisible sur la carte si vous vous accroupissez.\nUne barre de progression vous indique si vous êtes invisible(barre totalement grise) ou pas (barre possèdant du blanc)\nSi vous tirez, la jauge d'invisibilitée se remplit partiellement de blanc (le pourcentage de remplissement dépend de l'arme utilisée) et vous devenez visible jusqu'à que la jauge soit entièrement grise.\n(Si vous utilisez un pistolet avec silencieux, la jauge ne se remplira pas)",
	"La compétence chance augmente les chances de réussite lors d'une action qui peut être échouée telle que le viol, vol, etc\nElle vous permet donc d'avoir 80 chances sur 100 de réussir à la place de 70 chances sur 100.\nCette compétence vous permet aussi d'augmenter les chances d'écouter le temps d'un vol de lieu et augmente aussi les chances de gagner plus d'argent lors de vols.",
	"La compétence Régénération vous permet de régénerer votre vie à chaque seconde qui passe, et ce jusqu'à que votre vie atteigne ses 70%.\nPlus le niveau de la compétence est élevé, plus votre vie se régénère vite.\nSi vous avez une MST, la compétence régénération se désactivera jusqu'à que vous ne l'ayez plus.\nSi vous êtes touché par une balle, vous ne vous régènerez plus pendant les 7 prochaines secondes."
};

new compMaxLvl[]=
{
	1,
	3,
	3
};

new PlayerText:wantedtd[MAX_PLAYERS],
	Text:CLASS_CRIMI[2],
	Text:CLASS_COPS[2],
	Text:CLASS_SPECIALFORCE,
	Text:CLASS_SWAT,
	Text:CLASS_MILITARY,
	Text:CLASS_BAC,
	Text:VersionTD;

new Text:CLASS_BALLAS, Text:CLASS_BALLASM, Text:CLASS_BALLASL,
	Text:CLASS_GROOVE, Text:CLASS_GROOVEM, Text:CLASS_GROOVEL;

new BallasZone;
new GrooveZone;

new ArmyGate[2], BankGate;
//new BankBoxO, BankBoxLastRob, BankBox;
new bool:ArmyGateO[2],bool:BankGateO;

//Fonctions additives & forward
forward OnPlayerEnterVehicleEx(playerid, vehicleid, seat);
forward KickPlayer(playerid);
forward OnSuccessWin(playerid, successid);
forward animtimer(playerid);
forward explveh(playerid, vehicleid);
forward hackveh(playerid, vehicleid);
forward hackvehcmd(playerid, vehicleid);
forward phackatmtimer(playerid);
forward MoveGate(who);
forward TwoTimer();
forward invtimer(playerid);
forward HideMsg(playerid);
forward gpscheckpointtimer(playerid);
forward bankgateexpl(playerid);
forward bankgateclose();
forward RegenerateTimer();
forward RebootTimer();
native IsValidVehicle(vehicleid);

public RebootTimer()
	SendRconCommand("gmx");


public bankgateexpl(playerid)
{
	CreateExplosion(2318.66553, -15.17134, 15.14398, 11, 8.5);
	MoveDynamicObject(BankGate, 2318.30737, -15.13340, 12.63830, 0.5, 0.00000, 0.00000, 90.00000);
	BankGateO=true;
	SetTimer("bankgateclose", 180000, false);
	AddWanted(playerid, 4);
	AddScore(playerid, 1);
	new msg[128];
	format(msg, sizeof(msg), "Le terroriste %s(%d) a explosé la porte du coffre de la banque, interpellez-le vite !", pInfo[playerid][name], playerid);
	SendClientMessageToAllCops(COLOR_BLUECOPS, msg);
	SendClientMessage(playerid, COLOR_RED, "Vous avez explosé la porte du coffre de la banque, la police a été prévenue !");
}

public bankgateclose()
{
	MoveDynamicObject(BankGate, 2318.66553, -15.17134, 15.14398, 0.5, 0.00000, 0.00000, 90.00000);
	BankGateO=false;
	SendClientMessageToAll(COLOR_LIGHTBLUE, "La porte de la banque a été réparée !");
}

public gpscheckpointtimer(playerid)
{
    DisablePlayerRaceCheckpoint(playerid);
    RemovePlayerMapIcon(playerid, 99);
    SendClientMessage(playerid, COLOR_GREEN, "Le checkpoint de localisation de véhicule a été supprimé !");
}


stock ShowMsg(playerid, text[])
{
	PlayerTextDrawSetString(playerid, pMsg[playerid], text);
	PlayerTextDrawShow(playerid, pMsg[playerid]);
	SetTimerEx("HideMsg", 5000, false, "i", playerid);
	return 1;
}

public HideMsg(playerid)
{
	PlayerTextDrawHide(playerid, pMsg[playerid]);
	return 1;
}

public invtimer(playerid)
{
	SendClientMessage(playerid, COLOR_GREEN, "Vous êtes maintenant de nouveau visible sur la map !");
	pInfo[playerid][lastinvisible]=gettime()+120;
	for(new i=0;i<MAX_PLAYERS;i++)
	    if(i!=playerid&&IsPlayerConnected(i)) ShowPlayerMarkerForPlayer(i, playerid);
	pInfo[playerid][invisible]=false;
}

public hackvehcmd(playerid, vehicleid)
{
	new engine,alarm;
	GetVehicleParamsEx(vehicleid,engine,Vlights[vehicleid],alarm,Vdoors[vehicleid],Vbonnet[vehicleid],Vboot[vehicleid],Vobjective[vehicleid]);
	SetVehicleParamsEx(vehicleid,0,0,1,0,0,0,0);
	AddScore(playerid, 1);
 	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
 	pInfo[playerid][hackvehp]=true;
 	for(new i=0;i<MAX_PLAYERS;i++)
		if(GetPlayerVehicleID(i)==vehicleid)
			SendClientMessage(i, COLOR_ERROR, "Un hacker vient d'immobiliser ce véhicule !");
	vInfo[vehicleid][hacktimer]=SetTimerEx("hackveh", 10000, false, "ii", playerid, vehicleid);
}

public TwoTimer()
{
	for(new playerid=0;playerid<MAX_PLAYERS;playerid++)
	{
		if(IsPlayerNPC(playerid)) continue;
	    if(!IsPlayerConnected(playerid)) continue;
		new Float:size=7;
		if(IsPlayerInAnyVehicle(playerid)) size=10;
		if(pInfo[playerid][TEAM]==TEAM_MILITARY) {
			if(PlayerToPoint(floatadd(size, 3.5), playerid, 2720.26807, -2504.21460, 12.50000)&&!ArmyGateO[0]) {
				MoveGate(0);
			    SetTimerEx("MoveGate", 4000, false, "i", 0);
			}
			else if(PlayerToPoint(floatadd(size, 3.5), playerid, 2720.26807, -2405.68530, 12.50000)&&!ArmyGateO[1]) {
			 	MoveGate(1);
			    SetTimerEx("MoveGate", 4000, false, "i", 1);
			}
		}
	}
}

public RegenerateTimer()
{
	for(new playerid=0;playerid<MAX_PLAYERS;playerid++)
	{
	    if(!IsPlayerConnected(playerid)) continue;
	    if(GetCompetence(playerid, 2)>0&&!pInfo[playerid][MST]&&pInfo[playerid][lastdamage]<gettime()&&pInfo[playerid][spawned]) {
            GetPlayerHealth(playerid, pInfo[playerid][hp]);
			if(pInfo[playerid][hp]<70) {switch(GetCompetence(playerid, 2))
	        {
	            case 1:SetPlayerHealth(playerid, floatadd(pInfo[playerid][hp], 1.9));
	            case 2:SetPlayerHealth(playerid, floatadd(pInfo[playerid][hp], 2.3));
	            case 3:SetPlayerHealth(playerid, floatadd(pInfo[playerid][hp], 2.7));
 			}}
	    }
	}
}

public MoveGate(who)
{
	switch(who)
	{
	    case 0: { //Armée
		    if(ArmyGateO[0]) {
				MoveDynamicObject(ArmyGate[0], 2720.26807, -2504.21460, 12.50000, 5, 0.00000, 0.00000, 90.00000);
		        ArmyGateO[0]=false;
		    }
		    else {
		        MoveDynamicObject(ArmyGate[0], 2720.26807, -2495.2212, 12.50000, 5, 0.00000, 0.00000, 90.00000);
		        ArmyGateO[0]=true;
		    }
		}

		case 1: { //Armée1
		    if(ArmyGateO[1]) {
				MoveDynamicObject(ArmyGate[1], 2720.26807, -2405.68530, 12.50000, 5, 0.00000, 0.00000, 90.00000);
		        ArmyGateO[1]=false;
		    }
		    else {
		        MoveDynamicObject(ArmyGate[1], 2720.26807, -2396.7468, 12.50000, 5, 0.00000, 0.00000, 90.00000);
		        ArmyGateO[1]=true;
		    }
		}
	}
}

stock LoadNPC()
{
	new playerid=-1;
	playerid=FCNPC_Create("Marchand_1");
	npcs[0]=playerid;
	pInfo[playerid][ISNPC]=true;
	FCNPC_Spawn(playerid, 17, -28.2928,-91.6726,1003.5469);
	FCNPC_SetPosition(playerid, -28.2928,-91.6726,1003.5469);
	FCNPC_SetAngle(playerid, 356.4029);
	FCNPC_SetInterior(playerid, 18);
	return 1;
}

stock LoadMapping()
{
	ArmyGate[0]=CreateDynamicObject(971, 2720.26807, -2504.21460, 12.50000,   0.00000, 0.00000, 90.00000);
	ArmyGate[1]=CreateDynamicObject(971, 2720.26807, -2405.68530, 12.50000,   0.00000, 0.00000, 90.00000);
	BankGate=CreateDynamicObject(19367, 2318.66553, -15.17134, 15.14398,   0.00000, 0.00000, 90.00000);

	//BankBox=CreateDynamicObject(1829, 2311.84253, -4.27641, 15.27000,   0.00000, 0.00000, 89.76000);
	//BankBoxO=CreateDynamicObject(2332, 2311.54443, -4.28300, 15.27700,   0.00000, 0.00000, 90.00000);
	//PoliceGate=CreateObject(971, 1588.96350, -1637.95325, 15.19757,   0.00000, 0.00000, 180.00000);
	ArmyGateO[0]=false;
	ArmyGateO[1]=false;
	BankGateO=false;
	return 1;
}

stock DeleteMapping(playerid)
{
	RemoveBuildingForPlayer(playerid, 17772, 2870.2422, -1589.3906, 16.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 17550, 2870.2422, -1589.3906, 16.5625, 0.25);
	RemoveBuildingForPlayer(playerid, 3710, 2788.1563, -2455.8828, 16.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2771.0703, -2372.4453, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2789.2109, -2377.6250, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3744, 2774.7969, -2386.8516, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3770, 2795.8281, -2394.2422, 14.1719, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2783.7813, -2463.8203, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3624, 2788.1563, -2455.8828, 16.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2783.7813, -2448.4766, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2774.7969, -2386.8516, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2771.0703, -2372.4453, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3574, 2789.2109, -2377.6250, 15.2188, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2791.9531, -2463.8203, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2797.5156, -2448.3438, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3761, 2791.9531, -2448.4766, 14.6328, 0.25);
	RemoveBuildingForPlayer(playerid, 3626, 2795.8281, -2394.2422, 14.1719, 0.25);
}

public phackatmtimer(playerid)
{
	if((!PlayerToPoint(10.0,playerid,1497.00430, -1669.27260, 14.04690) && // ATM 1
	!PlayerToPoint(10.0,playerid,1472.16138, -1310.49963, 13.25410) &&// ATM2
	!PlayerToPoint(10.0,playerid,1808.50134, -1396.98694, 13.01920) &&// ATM3
	!PlayerToPoint(10.0,playerid,2108.97729, -1790.71216, 13.19380) &&// ATM4
	!PlayerToPoint(10.0,playerid,1810.79199, -1876.69238, 13.22270))||
	pInfo[playerid][hackatmid]==-1){
		SendClientMessage(playerid, COLOR_ERROR, "Vous êtes sorti du champ de piratage ou vous êtes mort: hacking annulé !");
		KillTimer(pInfo[playerid][hackatmtimer]);
		pInfo[playerid][hackatmid]=-1;
		HidePlayerProgressBar(playerid, HackATMT[playerid]);
	}
	else
	{
		pInfo[playerid][hackatm]+=1.2;
		SetPlayerProgressBarValue(playerid, HackATMT[playerid], pInfo[playerid][hackatm]);
		UpdatePlayerProgressBar(playerid, HackATMT[playerid]);
		if(pInfo[playerid][hackatm]>=100)
		{
		    SomeoneHackATM[pInfo[playerid][hackatmid]]=false;
	 		AddWanted(playerid, 2);
	 		new crand=0;
	 		while(crand<4000) crand=random(27000);
	 		pInv[playerid][BANK_CASH]+=crand;
	 		AddScore(playerid, 1);
		    new msg[128];
		    format(msg, sizeof(msg), "%s(%d) vient de pirater un ATM: %s ont été ajoutés dans son compte en banque.", pInfo[playerid][name], playerid, FormatMoney(crand));
		    SendClientMessageToAll(COLOR_ROYALBLUE, msg);
		    SendClientMessage(playerid, COLOR_GREEN, "Vos gains ont automatiquement été transférés dans votre compte en banque.");
		    KillTimer(pInfo[playerid][hackatmtimer]);
		    pInfo[playerid][hackatmid]=0;
		    HidePlayerProgressBar(playerid, HackATMT[playerid]);
		 	format(msg,sizeof(msg),"[RADIO DE POLICE] Suspect %s(%d) a piraté un ATM ! Il a volé %s !",pInfo[playerid][name],playerid, FormatMoney(crand));
			SendClientMessageToAllCops(COLOR_BLUECOPS, msg);
		}
	}
}

public animtimer(playerid)
{
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
}

public explveh(playerid, vehicleid)
{
	if(IsValidVehicle(vehicleid)){
		new Float:x, Float:y, Float:z;
		GetVehiclePos(vehicleid, x, y, z);
		CreateExplosion(x, y, z, 1, 8.5);
		DestroyVehicle(vehicleid);
		OnVehicleDeath(vehicleid, playerid);
		AddWanted(playerid, 4);
		AddScore(playerid, 1);
		vInfo[vehicleid][gonnaexplode]=false;
	}
}

public hackveh(playerid, vehicleid)
{
	if(IsValidVehicle(vehicleid)){
		SetVehicleParamsEx(vehicleid,1,Vlights[vehicleid],0,Vdoors[vehicleid],Vbonnet[vehicleid],Vboot[vehicleid],Vobjective[vehicleid]);
		if(pInfo[playerid][hackvehp]) {
  			AddWanted(playerid, 2);
  			pInfo[playerid][hackvehp]=false;
		}
        vInfo[vehicleid][hacked]=false;
	}
}

public KickPlayer(playerid)
{
	new rnd =random(sizeof(JailPos));
 	SetPlayerInterior(playerid,10);
  	SetPlayerPos(playerid,JailPos[rnd][0],JailPos[rnd][1],JailPos[rnd][2]);
   	SetPlayerFacingAngle(playerid,JailPos[rnd][3]);
	Kick(playerid);
	return 1;
}

stock BanPlayer(playerid, reason[]="Aucune", time=-1)
{
    new query[200], IP[16];
    GetPlayerIp(playerid, IP, 16);
	format(query, sizeof(query), "INSERT INTO `bans` (`Player`,`Ip`,`Reason`,`Duration`) VALUES ('%s','%s','%s','%d')", pInfo[playerid][name], IP, reason, time);
	mysql_query(query);
	for(new c = 0; c<=100; c++) SendClientMessage(playerid,COLOR_WHITE,"");
	SendClientMessage(playerid,COLOR_WHITE,"----------------------------------------------------------------------------------------");
	SendClientMessage(playerid,COLOR_RED,"Vous avez été bannis du serveur définitivement.");
 	SendClientMessage(playerid,COLOR_RED,"Vous pouvez faire une demande de débannissement sur notre forum dans la section adéquate.");
	SendClientMessage(playerid,COLOR_RED,"Merci de prendre un screen de la fenêtre du bannissement (TOUCHE F8).");
	SendClientMessage(playerid,COLOR_RED,"Nous ne débannissons pas les CHEATERS/HACKERS !");
	SendClientMessage(playerid,COLOR_WHITE,"----------------------------------------------------------------------------------------");
    ShowBan(playerid);
	return 1;
}

stock Load3DID(playerid)
{
	new str[21];
	for(new i=1;i<=MAX_VEHICLES;i++){
	    if(IsValidVehicle(i)) {
			format(str, sizeof(str), "ID du Véhicule: %d", i);
			vlabel[playerid][i-1] = CreatePlayer3DTextLabel(playerid,str,0x008080FF, 0, 0, 0, (!pInv[playerid][amplificator]) ? (30.0) : (47.5), INVALID_PLAYER_ID, i, 1);
		}
    }
	return 1;
}

stock Unload3DID(playerid)
{
	for(new i=1;i<=MAX_VEHICLES;i++)
 		if(IsValidVehicle(i)) DeletePlayer3DTextLabel(playerid, vlabel[playerid][i-1]);
	return 1;
}

stock Delete3DID(vehicleid)
{
   	for(new i=0;i<MAX_PLAYERS;i++)
   		DeletePlayer3DTextLabel(i, vlabel[i][vehicleid-1]);
	return 1;
}

stock Create3DID(vehicleid)
{
	new str[21];
	format(str, sizeof(str), "ID du Véhicule: %d", vehicleid);
	for(new i=0;i<MAX_PLAYERS;i++)
		if(pInfo[i][seeid]) vlabel[i][vehicleid-1] = CreatePlayer3DTextLabel(i,str,0x008080FF, 0, 0, 0, (!pInv[i][amplificator]) ? (30.0) : (47.5), INVALID_PLAYER_ID, vehicleid, 1);
	return 1;
}

stock ShowBan(playerid)
{
    new query[300], ip[16], reason[128],
		time[25], duration[25], Float:Duration;
		
	GetPlayerIp(playerid, ip, 16);
    format(query, sizeof(query), "SELECT * FROM bans WHERE Player = '%s' OR Ip = '%s'", pInfo[playerid][name], ip);
    
    mysql_query(query);
    mysql_store_result();
    
    while(mysql_fetch_row_format(query,"|"))
    {
        mysql_fetch_field_row(ip, "Ip");
        mysql_fetch_field_row(reason, "Reason");
        mysql_fetch_field_row(time, "Time");
        mysql_fetch_field_row(duration, "Duration");
    }
    mysql_free_result();
    Duration=floatstr(duration);
    
	new CurTimestamp = gettime();
	
	if(Duration<=-1){
		new string[256];
		format(string, sizeof(string), "Vous êtes banni définitivement, vous ne pouvez pas vous connecter.\n{FFFFFF}Utilisateur banni : {FF0000}%s \r\n{FFFFFF}Raison du banissement : {FF0000}%s \r\n{FFFFFF}IP bannie : {FF0000}%s \r\n{FFFFFF}Date : {FF0000}%s", pInfo[playerid][name], reason, ip, time);
 		ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "{FF0000}Banissement définitif", string, "Fermer", "");
        KickP(playerid);
        return 1;
  	}
	else{
		new string[256];
		
		if(Duration-CurTimestamp>=1) {
			format(string, sizeof(string),
			"Vous êtes banni temporairement, vous ne pouvez pas vous connecter pour le moment.\n{FFFFFF}Utilisateur banni : {FF0000}%s \r\n{FFFFFF}Raison du banissement : {FF0000}%s \r\n{FFFFFF}IP bannie : {FF0000}%s \r\n{FFFFFF}Date : {FF0000}%s\r\n{FFFFFF}Temps restant: {FF0000}%f minutes {FFFFFF}ou {FF0000}%f heures {FFFFFF}ou ",
			pInfo[playerid][name], reason, ip, time, floatdiv((Duration-CurTimestamp),60), floatdiv(floatdiv((Duration-CurTimestamp),60), 60));
			format(string, sizeof(string), "%s{FF0000}%f jours", string, floatdiv(floatdiv(floatdiv((Duration-CurTimestamp),60), 60),24));
			ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "{FF0000}Banissement temporaire", string, "Fermer", "");
        	KickP(playerid);
        	return 1;
		}
		else{
	 		new qquery[MAX_PLAYER_NAME+51];
			format(qquery, sizeof(qquery), "DELETE FROM  `bans` WHERE  `Player` =  '%s'", pInfo[playerid][name]);
			mysql_query(qquery);
			return 0;
		}
	}
}

public OnSuccessWin(playerid, successid)
{
	new gtext[128];
	format(gtext, sizeof(gtext), "~n~~n~~w~%s~n~~y~%s", Successes[successid][0], Successes[successid][1]);
	fix_Caracter(gtext);
	GameTextForPlayer(playerid, gtext, 6000, 4);
	PlayerPlaySound(playerid, 17802,0.0,0.0,0.0);
	format(gtext, sizeof(gtext), "%s(%d) a gagné le succès \"%s\" !", pInfo[playerid][name], playerid, Successes[successid][0]);
	SendClientMessageToAll(COLOR_BLUE, gtext);
	return 1;
}

stock AddSkillLevel(playerid, weaponid=-1)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return -1;
	if(weaponid==-1)  weaponid=GetPlayerWeapon(playerid);
	switch(GetWeaponSlot(weaponid))
	{
		case 2:
		{
			pSkill[playerid][skill_pistol]+=2;
			pSkill[playerid][skill_silenced]+=2;
			pSkill[playerid][skill_deagle]+=2;
		    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, pSkill[playerid][skill_pistol]);
		    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, pSkill[playerid][skill_silenced]);
		    SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, pSkill[playerid][skill_deagle]);
			return 2;
		}
		case 3:
		{
			pSkill[playerid][skill_shotgun]+=2;
			pSkill[playerid][skill_sawnoff_shotgun]+=2;
			pSkill[playerid][skill_spas12_shotgun]+=2;
		    SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, pSkill[playerid][skill_shotgun]);
		    SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, pSkill[playerid][skill_sawnoff_shotgun]);
		    SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, pSkill[playerid][skill_spas12_shotgun]);
			return 3;
		}
		case 4:
		{
			pSkill[playerid][skill_micro_uzi]+=2;
			pSkill[playerid][skill_mp5]+=2;
		    SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, pSkill[playerid][skill_micro_uzi]);
		    SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, pSkill[playerid][skill_mp5]);
			return 4;
		}
		case 5:
		{
			pSkill[playerid][skill_ak47]+=2;
			pSkill[playerid][skill_m4]+=2;
		    SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, pSkill[playerid][skill_ak47]);
    		SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, pSkill[playerid][skill_m4]);
			return 5;
		}
		case 6:
		{
			pSkill[playerid][skill_sniper]+=2;
   			SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, pSkill[playerid][skill_sniper]);
			return 6;
		}
	}
	return -1;
}

stock GetWeaponSlot(weaponid, bool:boo=false)
{
	switch(weaponid)
	{
	    case 0,1: if(!boo) return 0;
	    case 2..9: if(!boo) return 1;
	    case 10..15: if(!boo) return 10;
	    case 16..18: if(!boo) return 8;
	    case 22..24: return 2;
	    case 25..27: return 3;
	    case 28,29,32: return 4;
	    case 30,31: return 5;
	    case 33,34: return 6;
		case 35..38: return 7;
		case 39: if(!boo) return 8;
		case 40: if(!boo) return 12;
		case 41, 42: if(!boo) return 9;
	}
	return -1;
}

stock GenerateVCode(const length=6)
{
	new str[7];
	for(new i=0;i<length;i++){
	    new letter=random(10);
	    while(ccontain(str, letter+48, length)) letter=random(10);
		str[i]=letter+48;
	}
	return str;
}

stock ccontain(const str[], ch1, pos=-1)
{
	if(pos<=-1) pos=strlen(str);
	for(new i=0;i<pos;i++){
	    if(str[i]==ch1) return true;
 	}
	return false;
}

stock cfind(const str[], ch1, pos=-1)
{
	if(pos<=-1) pos=strlen(str);
	for(new i=0;i<pos;i++){
	    if(str[i]==ch1) return i;
 	}
	return -1;
}

stock LoadVehiclesFile()
{
	new File:file = fopen("vehicles.ini", io_read);
	if(file){
		new string[128];

		for(new i=0; i<MAX_VEHICLES;i++){
		    new model, Float:pos[4], team=-1, color[2]={0, 0};
			if(fread(file, string, 256, false) == 0) break;
			if(sscanf(string, "i f f f f D(-1) D(-1) D(-1)", model, pos[0], pos[1], pos[2], pos[3], team, color[0], color[1])) continue;
			if(color[0]==-1) color[0]=random(200);
			if(color[1]==-1) color[1]=random(200);
			new vid=AddStaticVehicleEx(model, pos[0], pos[1], pos[2], pos[3], color[0], color[1], 60);
		 	vInfo[vid][UID]=-1;
	    	vInfo[vid][P_UID]=-1;
	    	vInfo[vid][TEAM]=team;
			vInfo[vid][destroyed]=false;
			vInfo[vid][assured]=false;
			vInfo[vid][gps]=false;
		}
		fclose(file);
	    print("Chargement des véhicules effectué !");
	    return true;
	}
	else print("Chargement des véhicules échoué");
	return false;
}

stock LoadMappingFile()
{
	new File:file = fopen("mapping.ini", io_read);
	if(file){
		new string[128];

		for(new i=0; i<1000;i++){
		    new model, Float:pos[6];
			if(fread(file, string, 256, false) == 0) break;
			if(sscanf(string, "i f f f f f f", model, pos[0], pos[1], pos[2], pos[3], pos[4], pos[5])) {
				printf("Load mapping error: line %d, model id %d", i, model);
				continue;
			}
			CreateDynamicObject(model,  pos[0], pos[1], pos[2], pos[3], pos[4], pos[5]);
		}
		fclose(file);
	    print("Chargement du mapping effectué !");
	    return true;
	}
	else print("Chargement du mapping échoué");
	return false;
}

stock PlayerToPoint(Float:radius, playerid, Float:X, Float:Y, Float:Z)
{
    new Float:temppos[3];
    if(!IsPlayerInAnyVehicle(playerid)) GetPlayerPos(playerid, temppos[0], temppos[1], temppos[2]);
    else GetVehiclePos(GetPlayerVehicleID(playerid), temppos[0], temppos[1], temppos[2]);
    temppos[0] -= X;
    temppos[1] -= Y;
    temppos[2] -= Z;
    if(((temppos[0] < radius) && (temppos[0] > -radius)) && ((temppos[1] < radius) && (temppos[1] > -radius)) && ((temppos[2] < radius) && (temppos[2] > -radius)))
    	return true;
    return false;
}

stock PlayerToPointEx(Float:radius, Float:px, Float:py, Float:pz, Float:X, Float:Y, Float:Z)
{
    px -= X;
    py -= Y;
    pz -= Z;
    if(((px < radius) && (px > -radius)) && ((py < radius) && (py > -radius)) && ((pz < radius) && (pz > -radius)))
    	return true;
    return false;
}

stock fix_Caracter(string[])
{
        new coriginal[22] = {192, 199, 200, 201, 202, 203, 207, 217, 219, 220, 224, 226, 231, 232, 233, 234, 235, 238, 239, 249, 251, 252};
        new cconvertis[22] = {128, 133, 134, 135, 136, 137, 141, 146, 148, 149, 151, 153, 156, 157, 158, 159, 160, 163, 164, 169, 171, 172};
        new len = strlen(string);
        for (new i; i < len; i++)
        {
                for(new j;j < 22;j++)
                {
                        if(string[i] == coriginal[j])
                        {
                                string[i] = cconvertis[j];
                                break;
                        }
                }
        }
}

stock CanBeRobbed(checkpointid)
{
	switch(checkpointid)
	{
	    case -1, CP_PRISON, CP_BANQUE, CP_HOPITAL, CP_ATM1,
			 CP_ATM2, CP_ATM3, CP_ATM4, CP_ATM5, CP_VENDREV, CP_EXPLBANKGATE, CP_WEAPONPICKB, CP_WEAPONPICKG: return false;
	}
	return true;
}

stock GetPlayerCheckpoint(playerid, Float:size=2.75)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(PlayerToPointEx(size, x, y, z, -27.8137,-89.9468,1003.5469)) return CP_24/7;
	if(PlayerToPointEx(size, x, y, z, 207.6025,-100.8718,1005.2578)) return CP_BINCO_GANTON;
	if(PlayerToPointEx(size, x, y, z, -201.9624,-25.3541,1002.2734)) return CP_TATOO_GANTON;
	if(PlayerToPointEx(size, x, y, z, 414.3945,-11.1661,1001.8120)) return CP_COIFFEUR_GANTON;
	if(PlayerToPointEx(size, x, y, z, 376.4706,-119.1580,1001.4995)) return CP_ROBPIZZA_GANTON;
	if(PlayerToPointEx(size, x, y, z, 1102.7158,-1067.9561,31.8899)) return CP_BOMBSHOP;
	if(PlayerToPointEx(size, x, y, z, 1528.3334,-1677.8242,5.8906)) return CP_PRISON;
	if(PlayerToPointEx(size, x, y, z, 502.1191,-17.4997,1000.6719)) return CP_ALHAMBRA;
	if(PlayerToPointEx(size, x, y, z, 203.7636,-43.3142,1001.8047)) return CP_SUBURBAN;
	if(PlayerToPointEx(size, x, y, z, -30.4141,-55.0585,1003.5469)) return CP_ROBOIS;
	if(PlayerToPointEx(size, x, y, z, 370.8033,-6.5518,1001.8589)) return CP_CLUCKIN;
	if(PlayerToPointEx(size, x, y, z, 418.5053,-75.5452,1001.8047)) return CP_BURGERSHOT;
	if(PlayerToPointEx(size, x, y, z, 822.6247,10.2105,1004.1933)) return CP_INSIDETRACK;
	if(PlayerToPointEx(size, x, y, z, 496.5966,-75.8746,998.7578)) return CP_TEENGREEN;
	if(PlayerToPointEx(size, x, y, z, 161.5579,-84.0103,1001.8047)) return CP_ZIP;
	if(PlayerToPointEx(size, x, y, z, 1497.00430, -1669.27260, 14.04690)) return CP_ATM1;
	if(PlayerToPointEx(size, x, y, z, 1472.16138, -1310.49963, 13.25410)) return CP_ATM2;
	if(PlayerToPointEx(size, x, y, z, 1808.50134, -1396.98694, 13.01920)) return CP_ATM3;
	if(PlayerToPointEx(size, x, y, z, 2108.97729, -1790.71216, 13.19380)) return CP_ATM4;
	if(PlayerToPointEx(size, x, y, z, 1810.79199, -1876.69238, 13.22270)) return CP_ATM5;
	if(PlayerToPointEx(size, x, y, z, 2316.6182,-7.2763,26.7422)) return CP_BANQUE;
	if(PlayerToPointEx(size, x, y, z, 1104.7067,-1370.3041,13.9844)) return CP_BUYVEH;
	if(PlayerToPointEx(size, x, y, z, 294.7384,-40.7118,1001.5156)) return CP_AMMUNATION;
	if(PlayerToPointEx(size, x, y, z, 1176.8757,-1338.9587,13.9564)) return CP_HOPITAL;
	if(PlayerToPointEx(size, x, y, z, 2078.7405,-2006.2996,13.1109)) return CP_VENDREV;
	if(PlayerToPointEx(size, x, y, z, 2318.2739,-16.0869,15.3815)) return CP_EXPLBANKGATE;
	if(PlayerToPointEx(size, x, y, z, 2312.9063,-4.2867,15.3815)) return CP_VOLERBANQUE;
	if(PlayerToPointEx(size, x, y, z, 2332.6033,-1143.7164,1054.3047)) return CP_WEAPONPICKB;
	if(PlayerToPointEx(size, x, y, z, 135.4387,1380.0114,1088.3672)) return CP_WEAPONPICKG;
	return INVALID_CHECKPOINT;
}

stock Chances(val=30, maxval=101)
{
	new crand=random(maxval);
	return crand>val;
}

stock pChances(playerid, val=30)
{
	if(!IsPlayerConnected(playerid)) return Chances(val);
	new a=GetCompetence(playerid, 1);
	return Chances(val-(a*2));
}

//Report
stock SetReport(playerid, who, bool:can=true)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return 0;
	pReport[playerid][who]=can;
	return 1;
}

stock CanReport(playerid, who)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return 0;
	if(!IsPlayerConnected(who)||who==INVALID_PLAYER_ID||who<0) return 0;
	return pReport[playerid][who];
}

stock ResetReport(playerid)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return 0;
    for(new i=0;i<MAX_PLAYERS;i++)
        pReport[playerid][i]=false;
	return 1;
}

//Anti-DM
stock SetDM(playerid, who, bool:can=true)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return 0;
	if(!IsPlayerConnected(who)||who==INVALID_PLAYER_ID||who<0) return 0;
	pAntiDM[playerid][who]=can;
	return 1;
}

stock CanDm(playerid, who)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return 0;
	if(!IsPlayerConnected(who)||who==INVALID_PLAYER_ID||who<0) return 0;
	return pAntiDM[playerid][who];
}

stock ResetDM(playerid)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return 0;
    for(new i=0;i<MAX_PLAYERS;i++) {
        pAntiDM[playerid][i]=false;
        pAntiDM[i][playerid]=false;
	}
	return 1;
}


stock LoadPickup()
{
	Pickup[PICKUP_ASSUR]=CreatePickup(1239, 1, 1085.8085,-1368.1053,13.7813, -1);
	Pickup[PICKUP_GROOVECOFFRE]=CreatePickup(1274, 1, 144.9846,1384.1897,1088.3672, -1);
	Pickup[PICKUP_BALLASCOFFRE]=CreatePickup(1274, 1, 2337.9810,-1141.6392,1054.3047, -1);
	Pickup[PICKUP_BUYWEP]=CreatePickup(355, 1,295.4040,-37.5995,1001.5156, -1);
	PickupInfo[Pickup[PICKUP_ASSUR]][spawned]=false;
	PickupInfo[Pickup[PICKUP_ASSUR]][extid]=-1;
	PickupInfo[Pickup[PICKUP_GROOVECOFFRE]][spawned]=false;
	PickupInfo[Pickup[PICKUP_GROOVECOFFRE]][extid]=-1;
	PickupInfo[Pickup[PICKUP_BALLASCOFFRE]][spawned]=false;
	PickupInfo[Pickup[PICKUP_BALLASCOFFRE]][extid]=-1;
	PickupInfo[Pickup[PICKUP_BUYWEP]][spawned]=false;
	PickupInfo[Pickup[PICKUP_BUYWEP]][extid]=-1;
	Create3DTextLabel("/assurance ET /achetergps", 0x008080FF, 1085.8085,-1368.1053,14.0, 30.0, 0, 1);
	Create3DTextLabel("Coffre de team", COLOR_RED, 144.9846, 1384.1897, 1088.6672, 30.0, 0, 1);
	Create3DTextLabel("Coffre de team", COLOR_RED, 2337.9810,-1141.6392,1054.6047, 30.0, 0, 1);
	Create3DTextLabel("/acheter", COLOR_RED, 144.9846, 1384.1897, 1088.9672, 30.0, 0, 1);
	return 1;
}

stock ChangeVersionColor()
{
	new color=random(65536);
	TextDrawColor(VersionTD, color-1);
	for(new playerid=0;playerid<MAX_PLAYERS;playerid++) if(IsPlayerConnected(playerid)){
	    TextDrawHideForPlayer(playerid, VersionTD);
	    TextDrawShowForPlayer(playerid, VersionTD);
	}
}

stock LoadServInfo()
{
	mysql_query("SELECT * FROM servinfo WHERE 1");
	mysql_store_result(mysql_connection);
	while (mysql_retrieve_row())
	{
		new tmp[128];
		mysql_fetch_field_row(tmp, "Name");
	    if(strcmp(tmp, "Ballas", true)==0)
	    {
			mysql_fetch_field_row(tmp, "Money");
			Teams[BALLAS][MONEY]=strval(tmp);
			mysql_fetch_field_row(tmp, "Score");
			Teams[BALLAS][SCORE]=strval(tmp);
			continue;
	    }
		if(strcmp(tmp, "Groove", true)==0)
		{
			mysql_fetch_field_row(tmp, "Money");
			Teams[GROOVE][MONEY]=strval(tmp);
			mysql_fetch_field_row(tmp, "Score");
			Teams[GROOVE][SCORE]=strval(tmp);
			continue;
		}
	}
}

stock LoadPickupsSQL()
{
	mysql_query("SELECT * FROM lieux WHERE 1");
	mysql_store_result(mysql_connection);
	while (mysql_retrieve_row())
	{
	    new id=1238, Float:PickupPos[6], tmp[128];
		mysql_fetch_field_row(tmp, "ID");
	    id=strval(tmp);

	    //Entrée
		mysql_fetch_field_row(tmp, "pickup_entx");
	    PickupPos[0]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "pickup_enty");
	    PickupPos[1]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "pickup_entz");
	    PickupPos[2]=floatstr(tmp);

	    //Sortie
		mysql_fetch_field_row(tmp, "pickup_extx");
	    PickupPos[3]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "pickup_exty");
	    PickupPos[4]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "pickup_extz");
	    PickupPos[5]=floatstr(tmp);

	    new pickup=CreatePickup(id, 1, PickupPos[0], PickupPos[1], PickupPos[2], -1);
	    new pickup2=CreatePickup(id, 1, PickupPos[3], PickupPos[4], PickupPos[5], -1);
	    PickupInfo[pickup][extid]=pickup2;

		mysql_fetch_field_row(tmp, "interior");
	    PickupInfo[pickup][interior]=strval(tmp);

	    //Spawnpos entrée
		mysql_fetch_field_row(tmp, "ent_x");
	    PickupInfo[pickup][entx]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "ent_y");
	    PickupInfo[pickup][enty]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "ent_z");
	    PickupInfo[pickup][entz]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "ent_a");
	    PickupInfo[pickup][enta]=floatstr(tmp);

	    //Spawnpos sortie
		mysql_fetch_field_row(tmp, "ext_x");
	    PickupInfo[pickup][extx]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "ext_y");
	    PickupInfo[pickup][exty]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "ext_z");
	    PickupInfo[pickup][extz]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "ext_a");
	    PickupInfo[pickup][exta]=floatstr(tmp);

		//Autre
	    PickupInfo[pickup][spawned]=true;
	    PickupInfo[pickup][extid]=pickup2;
	    PickupInfo[pickup2][entid]=pickup;
	    PickupInfo[pickup][entid]=-1;
	}
	mysql_free_result(mysql_connection);
	print("Pickup chargés!");
	return true;
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

stock StopLoopingAnim(playerid)
{
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
    return true;
}

stock Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if (!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

stock pavert(playerid, reason[])
{
	new string[256]="";
	if(pInfo[playerid][avert]>=0&&pInfo[playerid][avert]<2)
	{
		pInfo[playerid][avert] ++;
  		format(string,sizeof(string),"%s(%d) a reçu un avertissement [%d/3]. {FF0000}Raison: {FFFFFF}%s.",pInfo[playerid][name],playerid,pInfo[playerid][avert],reason);
		SendClientMessageToAll(COLOR_BLUE, string);
		new Global[1024];
		format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}Vous avez reçu {FF0000}AVERTISSEMENT{FFFFFF}");
		format (Global, sizeof Global, "%s\n%s", Global, "Le {FF4D00}DEATHMATCHING {FFFFFF}- {FF4D00}CARKILL {FFFFFF}- {FF4D00}DBF {FFFFFF}- {FF4D00}USEBUG {FFFFFF}sont interdits sur CRFR.");
		format (Global, sizeof Global, "%s\n%s", Global, "Merci d'utiliser {EBEB00}/regles {FFFFFF}et {EBEB00}/pc{FFFFFF}.\n");
		format (Global, sizeof Global, "%s\n%s%s", Global, "{FF0000}Raison de l'avertissement{FFFFFF}: ", reason);
		ShowPlayerDialog (playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "{FF0000}• • AVERTISSEMENT • •", Global, "Fermer", "");
		return 1;
	}
	if(pInfo[playerid][avert] == 2)
	{
		pInfo[playerid][avert]++;
  		format(string,sizeof(string),"%s(%d) a reçu un avertissement [3/3]. {FF0000}Raison: {FFFFFF}%s.",pInfo[playerid][name],playerid,reason);
		SendClientMessageToAll(COLOR_BLUE, string);
 		format(string,sizeof(string),"%s(%d) a été kick automatiquement a cause de ses avertissements.",pInfo[playerid][name],playerid);
		SendClientMessageToAll(COLOR_BLUE, string);
		new Global[1024];
		format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}Vous avez reçu trop d'{FF0000}AVERTISSEMENTS{FFFFFF}.");
		format (Global, sizeof Global, "%s\n%s", Global, "Le {FF4D00}DEATHMATCHING {FFFFFF}- {FF4D00}CARKILL {FFFFFF}- {FF4D00}DBF {FFFFFF}- {FF4D00}USEBUG {FFFFFF}sont interdits sur CRFR.");
		format (Global, sizeof Global, "%s\n%s", Global, "Merci d'utiliser {EBEB00}/regles {FFFFFF}et {EBEB00}/pc{FFFFFF}.\n");
		format (Global, sizeof Global, "%s\n%s%s", Global, "{FF0000}Raison de l'avertissement{FFFFFF}: ", reason);
		ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "{FF0000}• • AVERTISSEMENT • •", Global, "Fermer", "");
		KickP(playerid);
		return 1;
	}
	return true;
}

stock PlayerDeathVariables(playerid)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return 0;
	ResetWanted(playerid);
    pInfo[playerid][invisible]=false;
    pInfo[playerid][hackvehp]=false;
	pInfo[playerid][spawned]=false;
	pInfo[playerid][cuffed]=false;
	pInfo[playerid][kidnapped]=false;
	pInfo[playerid][afk]=false;
	pInfo[playerid][MST]=false;
	pInfo[playerid][freeze]=false;
	pInfo[playerid][hp]=0;
	pInfo[playerid][lastsuspect]=0;
	pInfo[playerid][lastcassmen]=0;
	pInfo[playerid][mentime]=0;
	pInfo[playerid][pvtime]=0;
	pInfo[playerid][kidnappedtime]=0;
	pInfo[playerid][lastweaponpick]=0;
	pInfo[playerid][lastrob]=0;
	pInfo[playerid][lastrobbed]=0;
	pInfo[playerid][lastkidnap]=0;
	pInfo[playerid][lastkidnapped]=0;
	pInfo[playerid][lastdamage]=0;
	pInfo[playerid][lastvhack]=0;
    pInfo[playerid][lastinvisible]=0;
	pInfo[playerid][lastviol]=0;
	pInfo[playerid][lastvioled]=0;
	pInfo[playerid][lastcarjack]=0;
	pInfo[playerid][lastlrob]=0;
	pInfo[playerid][lastrobatm]=0;
	pInfo[playerid][lastatmhack]=0;
	pInfo[playerid][hackatmid]=-1;
	pInfo[playerid][robatm]=0;
	pInfo[playerid][lastxpl]=0;
	pInfo[playerid][lastlxpl]=0;
	pInfo[playerid][lastexpl]=0;
	pInfo[playerid][lrob]=0;
	pInfo[playerid][avert]=0;
	pInfo[playerid][last_vehicle]=0;
	pInfo[playerid][lrob]=0;
	pInfo[playerid][tkill]=0;
	pInfo[playerid][lasttrob]=0;
	pInv[playerid][scissors]=false;
	pInv[playerid][amplificator]=false;
	pInv[playerid][C4]=0;
	pInv[playerid][ROPES]=0;
	pNextBuy[playerid]=-1;
	pBombNextBuy[playerid]=-1;
	pNextDComp[playerid]=-1;
	pPick[playerid]=-1;
	pInfo[playerid][jailtime]=0;
	pInfo[playerid][furtiv]=false;
	pInfo[playerid][hidden]=false;
	pInfo[playerid][noiselvl]=0;
	if(pInfo[playerid][hit]>0) {
	    new msg[128];
		format(msg, sizeof(msg), "%s(%d) est mort sans qu'un mercenaire puisse le tuer, il n'a plus de contrat sur la tête: vous ne pouvez plus le tuer !", pInfo[playerid][name], playerid);
	    for(new i=0;i<MAX_PLAYERS;i++) {
	        if(pInfo[playerid][TEAM]==TEAM_HITMAN) {
				SendClientMessage(playerid, COLOR_DARKGREY, msg);
	        }
	    }
	}
	pInfo[playerid][hit]=0;
	pInfo[playerid][hitamount]=0;
	SetPlayerAutoColor(playerid);
	for(new i=0;i<47;i++)
		PlayerWeapons[playerid][i]=false;
	HidePlayerProgressBar(playerid, FurtivBar[playerid]);
	ResetDM(playerid);
	return 1;
}

stock ResetPlayerVariables(playerid)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return 0;
    PlayerDeathVariables(playerid);
	pRegistered[playerid]=false;
	pInfo[playerid][logged]=false;
	pInfo[playerid][UID]=-1;
	pInfo[playerid][CLASS]=0;
	pInfo[playerid][roblvl]=0;
	pInfo[playerid][robprogress]=0;
	pInfo[playerid][terrolvl]=0;
	pInfo[playerid][terroprogress]=0;
	pInfo[playerid][lastpm]=-1;
	pInfo[playerid][lastpmtype]=false;
	pInfo[playerid][TEAM]=-1;
	pInfo[playerid][EXTTEAM]=-1;
	pInfo[playerid][avert]=0;
	pInfo[playerid][kills]=0;
	pInfo[playerid][deaths]=0;
	pInfo[playerid][mutedtime]=0;
	pInfo[playerid][kill]=0;
	pInfo[playerid][death]=0;
	pInfo[playerid][seeid]=false;
	format(pInfo[playerid][name], 0, "");
	format(pInfo[playerid][success], 0, "");
	format(pComp[playerid][competences], 0, "");
	pInfo[playerid][skin]=21;
	pInfo[playerid][admin]=0;
	pInfo[playerid][avert]=0;
	pInv[playerid][SAC_C4]=0;
	pInv[playerid][SAC_ROPES]=0;
	pInv[playerid][BANK_CASH]=0;
	pInv[playerid][SAC_CASH]=0;
	pLastMessage[playerid]=0;
	pLogChance[playerid]=0;
	pSpawnVeh[playerid]=0;
	pComp[playerid][comp_lvl]=0;
	pComp[playerid][comp_points]=0;
	pComp[playerid][comp_nextlvl]=30;
	pSkill[playerid][skill_pistol]=0;
	pSkill[playerid][skill_silenced]=0;
    pSkill[playerid][skill_deagle]=0;
    pSkill[playerid][skill_shotgun]=0;
    pSkill[playerid][skill_sawnoff_shotgun]=0;
    pSkill[playerid][skill_spas12_shotgun]=0;
    pSkill[playerid][skill_micro_uzi]=0;
    pSkill[playerid][skill_mp5]=0;
    pSkill[playerid][skill_ak47]=0;
    pSkill[playerid][skill_m4]=0;
    pSkill[playerid][skill_sniper]=0;
    KillTimer(pInfo[playerid][expltimer]);
    KillTimer(pInfo[playerid][hackatmtimer]);
    pInfo[playerid][expltimer]=-1;
	ResetReport(playerid);
	return 1;
}

stock SavePlayerStats(playerid)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return 0;
	if(IsPlayerConnected(playerid)&&pInfo[playerid][logged]){
  	new query[200];
  	format(query,sizeof(query),"UPDATE `comptes` SET `score` = '%d' WHERE `UID` = '%d' LIMIT 1",GetPlayerScore(playerid),pInfo[playerid][UID]); mysql_query(query);
  	format(query,sizeof(query),"UPDATE `comptes` SET `kills` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][kills],pInfo[playerid][UID]); mysql_query(query);
  	format(query,sizeof(query),"UPDATE `comptes` SET `deaths` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][deaths],pInfo[playerid][UID]); mysql_query(query);
  	format(query,sizeof(query),"UPDATE `comptes` SET `skin` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][skin], pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `argent` = '%d' WHERE `UID` = '%d' LIMIT 1",GetPlayerMoney(playerid), pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `bank_cash` = '%d' WHERE `UID` = '%d' LIMIT 1",pInv[playerid][BANK_CASH], pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `admin` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][admin],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `wanted-level` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][wanted],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `SAC_C4` = '%d' WHERE `UID` = '%d' LIMIT 1",pInv[playerid][SAC_C4],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `SAC_CORDES` = '%d' WHERE `UID` = '%d' LIMIT 1",pInv[playerid][SAC_ROPES],pInfo[playerid][UID]); mysql_query(query);
  	format(query,sizeof(query),"UPDATE `comptes` SET `SAC_CASH` = '%d' WHERE `UID` = '%d' LIMIT 1",pInv[playerid][SAC_CASH],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `VIP` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][VIP],pInfo[playerid][UID]); mysql_query(query);
  	format(query,sizeof(query),"UPDATE `comptes` SET `Army` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][military],pInfo[playerid][UID]); mysql_query(query);
  	format(query,sizeof(query),"UPDATE `comptes` SET `Groove` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][groove],pInfo[playerid][UID]); mysql_query(query);
  	format(query,sizeof(query),"UPDATE `comptes` SET `LeaderGroove` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][leadgroove],pInfo[playerid][UID]); mysql_query(query);
  	format(query,sizeof(query),"UPDATE `comptes` SET `Ballas` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][ballas],pInfo[playerid][UID]); mysql_query(query);
  	format(query,sizeof(query),"UPDATE `comptes` SET `LeaderBallas` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][leadballas],pInfo[playerid][UID]); mysql_query(query);
  	format(query,sizeof(query),"UPDATE `comptes` SET `BAC` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][bac],pInfo[playerid][UID]); mysql_query(query);
  	format(query,sizeof(query),"UPDATE `comptes` SET `LeaderBAC` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][leadbac],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `success` = '%s' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][success],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `competences` = '%s' WHERE `UID` = '%d' LIMIT 1",pComp[playerid][competences],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `jailtime` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][jailtime],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `roblvl` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][roblvl],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `robprogress` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][robprogress],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `terrolvl` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][terrolvl],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `terroprogress` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][terroprogress],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `policelvl` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][policelvl],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `policeprogress` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][policeprogress],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `level` = '%d' WHERE `UID` = '%d' LIMIT 1",pComp[playerid][comp_lvl],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `totaldetach` = '%d' WHERE `UID` = '%d' LIMIT 1",pInfo[playerid][totaldetach],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `comp_points` = '%d' WHERE `UID` = '%d' LIMIT 1",pComp[playerid][comp_points],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `comp_nextlvl` = '%d' WHERE `UID` = '%d' LIMIT 1",pComp[playerid][comp_nextlvl],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `skill-pistol` = '%d' WHERE `UID` = '%d' LIMIT 1",pSkill[playerid][skill_pistol],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `skill-silenced` = '%d' WHERE `UID` = '%d' LIMIT 1",pSkill[playerid][skill_silenced],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `skill-deagle` = '%d' WHERE `UID` = '%d' LIMIT 1",pSkill[playerid][skill_deagle],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `skill-shotgun` = '%d' WHERE `UID` = '%d' LIMIT 1",pSkill[playerid][skill_shotgun],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `skill-sawnoff-shotgun` = '%d' WHERE `UID` = '%d' LIMIT 1",pSkill[playerid][skill_sawnoff_shotgun],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `skill-spas12-shotgun` = '%d' WHERE `UID` = '%d' LIMIT 1",pSkill[playerid][skill_spas12_shotgun],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `skill-micro_uzi` = '%d' WHERE `UID` = '%d' LIMIT 1",pSkill[playerid][skill_micro_uzi],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `skill-mp5` = '%d' WHERE `UID` = '%d' LIMIT 1",pSkill[playerid][skill_mp5],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `skill-ak47` = '%d' WHERE `UID` = '%d' LIMIT 1",pSkill[playerid][skill_ak47],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `skill-m4` = '%d' WHERE `UID` = '%d' LIMIT 1",pSkill[playerid][skill_m4],pInfo[playerid][UID]); mysql_query(query);
   	format(query,sizeof(query),"UPDATE `comptes` SET `skill-sniper` = '%d' WHERE `UID` = '%d' LIMIT 1",pSkill[playerid][skill_sniper],pInfo[playerid][UID]); mysql_query(query);
   	return true;}
	return false;
}

stock SaveVehicleStats(vehicleid)
{
	if(vInfo[vehicleid][P_UID]!=-1){
		new Float:pos[4];
	    GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
	    GetVehicleZAngle(vehicleid, pos[3]);
	    new query[200];
	    format(query,sizeof(query),"UPDATE `vehicules` SET `owneruid` = %d WHERE `VID` = %d LIMIT 1",vInfo[vehicleid][P_UID],vInfo[vehicleid][UID]); mysql_query(query);
	    format(query,sizeof(query),"UPDATE `vehicules` SET `owner` = '%s' WHERE `VID` = %d LIMIT 1",GetPlayerNameWithUID(vInfo[vehicleid][P_UID]),vInfo[vehicleid][UID]); mysql_query(query);
	    format(query,sizeof(query),"UPDATE `vehicules` SET `x` = '%f' WHERE `VID` = %d LIMIT 1",pos[0],vInfo[vehicleid][UID]); mysql_query(query);
	    format(query,sizeof(query),"UPDATE `vehicules` SET `y` = '%f' WHERE `VID` = %d LIMIT 1",pos[1],vInfo[vehicleid][UID]); mysql_query(query);
	    format(query,sizeof(query),"UPDATE `vehicules` SET `z` = '%f' WHERE `VID` = %d LIMIT 1",pos[2],vInfo[vehicleid][UID]); mysql_query(query);
	    format(query,sizeof(query),"UPDATE `vehicules` SET `a` = '%f' WHERE `VID` = %d LIMIT 1",pos[3],vInfo[vehicleid][UID]); mysql_query(query);
	    format(query,sizeof(query),"UPDATE `vehicules` SET `id` = %d WHERE `VID` = %d LIMIT 1",GetVehicleModel(vehicleid),vInfo[vehicleid][UID]); mysql_query(query);
	    format(query,sizeof(query),"UPDATE `vehicules` SET `assured` = %d WHERE `VID` = %d LIMIT 1",vInfo[vehicleid][assured],vInfo[vehicleid][UID]); mysql_query(query);
	    format(query,sizeof(query),"UPDATE `vehicules` SET `destroyed` = %d WHERE `VID` = %d LIMIT 1",vInfo[vehicleid][destroyed],vInfo[vehicleid][UID]); mysql_query(query);
	    format(query,sizeof(query),"UPDATE `vehicules` SET `gps` = %d WHERE `VID` = %d LIMIT 1",vInfo[vehicleid][gps],vInfo[vehicleid][UID]); mysql_query(query);
		return true;
	}
	return false;
}

stock LoadVehicleSQL(vuid, Float:x=-1.1, Float:y=-1.1, Float:z=-1.1, Float:a=-1.1)
{
	if(vuid==-1) return INVALID_VEHICLE_ID;
	new query[200];
	format(query, sizeof(query), "SELECT * FROM vehicules WHERE `VID` = %d", vuid);
	mysql_query(query);
	mysql_store_result(mysql_connection);
	new bcar;
	while (mysql_retrieve_row())
	{
		new id, tmp[32];
		if(x==-1.1&&y==-1.1&&z==-1.1&&a==-1.1)
		{
			mysql_fetch_field_row(tmp, "x");
		    x=floatstr(tmp);
			mysql_fetch_field_row(tmp, "y");
		    y=floatstr(tmp);
			mysql_fetch_field_row(tmp, "z");
		    z=floatstr(tmp);
			mysql_fetch_field_row(tmp, "a");
		    a=floatstr(tmp);
		}
		mysql_fetch_field_row(tmp, "id");
		id=strval(tmp);
		bcar = CreateVehicle(id, x, y, z, a, 0, 0, -1);

		mysql_fetch_field_row(tmp, "VID");
	    vInfo[bcar][UID]=strval(tmp);
		mysql_fetch_field_row(tmp, "destroyed");
		vInfo[bcar][destroyed]=(strval(tmp)==1) ? (true) : (false);
		if(!vInfo[bcar][destroyed]) {
		mysql_fetch_field_row(tmp, "assured");
		vInfo[bcar][assured]=(strval(tmp)==1) ? (true) : (false);
		mysql_fetch_field_row(tmp, "gps");
		vInfo[bcar][gps]=(strval(tmp)==1) ? (true) : (false);
		mysql_fetch_field_row(tmp, "comp-spoiler");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-capot");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-nitro");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-toit");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-phares");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-jupes");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-exhaust");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-roues");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-stereo");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-hydraulique");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-parechocavant");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-parechocarriere");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-ventgauche");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		mysql_fetch_field_row(tmp, "comp-ventdroit");
		if(strval(tmp)!=-1) AddVehicleComponent(bcar, strval(tmp));
		vInfo[bcar][gps]=(strval(tmp)==1) ? (true) : (false);
		mysql_fetch_field_row(tmp, "owneruid");
		vInfo[bcar][P_UID]=strval(tmp);
		}
	}
	mysql_free_result(mysql_connection);
	return bcar;
}

stock LoadVehiclesSQL()
{
	mysql_query("SELECT * FROM vehicules WHERE 1");
	mysql_store_result(mysql_connection);
	new v=0;
	while (mysql_retrieve_row())
	{
	    v++;
	    new bcar, id, Float:pos[4], tmp[60];
		mysql_fetch_field_row(tmp, "id");
	    id=strval(tmp);
		mysql_fetch_field_row(tmp, "x");
	    pos[0]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "y");
	    pos[1]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "z");
	    pos[2]=floatstr(tmp);
		mysql_fetch_field_row(tmp, "a");
	    pos[3]=floatstr(tmp);
	    bcar = CreateVehicle(id, pos[0], pos[1], pos[2], pos[3], 0, 1, 0);
		mysql_fetch_field_row(tmp, "destroyed");
	    vInfo[bcar][destroyed]=(strval(tmp)==1) ? (true) : (false);
	    if(!vInfo[bcar][destroyed]) {
			mysql_fetch_field_row(tmp, "VID");
		    vInfo[bcar][UID]=strval(tmp);
			mysql_fetch_field_row(tmp, "owneruid");
		    vInfo[bcar][P_UID]=strval(tmp);
			mysql_fetch_field_row(tmp, "gps");
		    vInfo[bcar][gps]=(strval(tmp)==1) ? (true) : (false);
			mysql_fetch_field_row(tmp, "assured");
		    vInfo[bcar][assured]=(strval(tmp)==1) ? (true) : (false);
		    vInfo[bcar][spawned]=true;
			SetVehicleNumberPlate(bcar, GetPlayerNameWithUID(vInfo[bcar][P_UID]));
		}
	    else DestroyVehicle(bcar);
	}
	mysql_free_result(mysql_connection);
	printf("%d véhicule(s) chargé(s) via SQL !", v);
	return true;
}

stock DeleteVehicleStats(vehicleid)
{
	if(vInfo[vehicleid][UID]==-1) return 0;
	new query[256];
	format(query, sizeof(query), "DELETE FROM `%s`.`vehicules` WHERE `vehicules`.`VID` = %d", mysql_database, vInfo[vehicleid][UID]);
	mysql_query(query);
	return 1;
}

stock CreateVehicleStats(vehicleid)
{
	if(!IsValidVehicle(vehicleid)) return false;
	new Float:pos[4];
 	GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
  	GetVehicleZAngle(vehicleid, pos[3]);
 	new query[200];
	format(query, sizeof(query), "INSERT INTO `vehicules`(`owneruid`, `x`, `y`, `z`, `a`, `id`, `owner`) VALUES (%d, '%f', '%f', '%f', '%f', %d, '%s')",
	vInfo[vehicleid][P_UID], pos[0], pos[1], pos[2], pos[3], GetVehicleModel(vehicleid), GetPlayerNameWithUID(vInfo[vehicleid][P_UID]));
    mysql_query(query);
	format(query, sizeof(query), "SELECT * FROM `vehicules` WHERE `x`='%f', `y`='%f', `z`='%f', `a`='%f', `id`=%d",
	 pos[0], pos[1], pos[2], pos[3], GetVehicleModel(vehicleid));
	new savingstring[128];
	mysql_query(query);
	mysql_store_result();
	new uid=-1;
    while(mysql_fetch_row_format(query,"|"))
    {
        mysql_fetch_field_row(savingstring, "VID");
		uid=strval(savingstring);
    }
    vInfo[vehicleid][spawned]=true;
	return uid;
}

stock IsCanAction(playerid)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return -1;
	if(!pInfo[playerid][spawned]||pInfo[playerid][cuffed]||pInfo[playerid][kidnapped]||pInfo[playerid][jailtime]>0||!pInfo[playerid][logged])
		return false;
	return true;
}

stock ResetWanted(playerid)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return -1;
    pInfo[playerid][wanted]=0;
	PlayerTextDrawColor(playerid, wantedtd[playerid], 0xFFFFFFFF);
	PlayerTextDrawSetString(playerid, wantedtd[playerid], "~w~Niveau de recherche: 0");
	SetPlayerAutoColor(playerid);
	PlayerTextDrawHide(playerid, wantedtd[playerid]);
	PlayerTextDrawShow(playerid, wantedtd[playerid]);
	return 1;
}

stock AddWanted(playerid, value)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return -1;
	pInfo[playerid][wanted]+=value;
	SetPlayerAutoColor(playerid);
	new pcol =GetPlayerColor(playerid), string[128];
	format(string,sizeof(string),"|| Votre niveau de recherche est maintenant de %d étoiles ||",pInfo[playerid][wanted]);
	SendClientMessage(playerid,pcol,string);
	ActualiseWantedTD(playerid);
	return true;
}

stock ActualiseWantedTD(playerid)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return -1;
    SetPlayerAutoColor(playerid);
	new string[128];
	format(string, sizeof(string), "Niveau de recherche: %d", pInfo[playerid][wanted]);
	PlayerTextDrawColor(playerid, wantedtd[playerid], GetPlayerColor(playerid));
	PlayerTextDrawSetString(playerid, wantedtd[playerid], string);
	PlayerTextDrawHide(playerid, wantedtd[playerid]);
	PlayerTextDrawShow(playerid, wantedtd[playerid]);
	return true;
}

stock AddScore(playerid, value)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return -1;
	SetPlayerScore(playerid, GetPlayerScore(playerid)+value);
	if(pComp[playerid][comp_nextlvl]>0) pComp[playerid][comp_nextlvl]-=value;
	if(pComp[playerid][comp_nextlvl]>30) pComp[playerid][comp_nextlvl]=30;
	if(value>0&&pComp[playerid][comp_nextlvl]<=0)
	{
	    pComp[playerid][comp_lvl]++;
	    pComp[playerid][comp_points]++;
		pComp[playerid][comp_nextlvl]=30;
		new msg[128];
		format(msg, sizeof(msg), "Vous avez atteint le niveau %d, félicitations !", pComp[playerid][comp_lvl]);
		SendClientMessage(playerid, COLOR_GREEN, msg);
		SendClientMessage(playerid, COLOR_GREEN, "Vous venez de gagner 1 point de compétences, tapez /comp(etences) pour le dépenser.");
	}
	if(value<0&&pComp[playerid][comp_nextlvl]<=0) {
	    pComp[playerid][comp_lvl]--;
	    pComp[playerid][comp_points]--;
		pComp[playerid][comp_nextlvl]=30;
	}
	if(IsPlayerGroove(playerid)) {
		new rand=random(12000+(value*1795));
		Teams[GROOVE][SCORE]+=value;
		Teams[GROOVE][MONEY]+=rand;
	}
	if(IsPlayerBallas(playerid)) {
		new rand=random(12000+(value*1795));
		Teams[BALLAS][SCORE]+=value;
		Teams[BALLAS][MONEY]+=rand;
	}
	return true;
}

stock GivePlayerWeaponEx(playerid,weaponid,ammo)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return 0;
    PlayerWeapons[playerid][weaponid]=true;
    GivePlayerWeapon(playerid,weaponid,ammo);
    return true;
}

stock GetPlayerNameWithUID(uid)
{
    new query[400], pname[MAX_PLAYER_NAME+1]="Inconnu";
    if(uid<=-1) return pname;
    format(query, sizeof(query), "SELECT * FROM comptes WHERE `UID` = '%d'", uid);
    mysql_query(query);
    mysql_store_result();
    while(mysql_fetch_row_format(query,"|"))
    	mysql_fetch_field_row(pname, "pseudo");
    mysql_free_result();
    if(!strlen(pname)) pname="Inconnu";
	return pname;
}

stock GetPlayerIDWithUID(uid)
{
	for(new i=0;i<MAX_PLAYERS;i++)
	    if(pInfo[i][UID]==uid) {
	        return i;
		}
	return -1;
}

stock MySQL_Register(playerid, passwordstring[])
{
    new query[200],IP[16];
    GetPlayerIp(playerid, IP, 16);
    format(query, sizeof(query), "INSERT INTO comptes (pseudo, password, score, argent, IP) VALUES('%s', SHA1('%s'), 0, 0, '%s')", pInfo[playerid][name], passwordstring, IP);
    mysql_query(query);

    SendClientMessage(playerid,COLOR_LIGHTBLUE,"Vous vous êtes enregistré avec succès ! Votre compte a été créé.");
    return 1;
}

stock IsPlayerCrimi(playerid)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return 0;
	switch(pInfo[playerid][CLASS])
	{
	    case 0,1,9,10,11,12,13,14,15,16: return true;
	}
	return false;
}

stock IsPlayerCops(playerid)
{
	if(IsPlayerCrimi(playerid)) return false;
	switch(pInfo[playerid][CLASS])
	{
	    case 2,3,4,5,6,7,8: return true;
	}
	switch(pInfo[playerid][TEAM])
	{
	    case TEAM_COPS, TEAM_SWAT, TEAM_MILITARY, TEAM_BAC: return true;
	}
	return false;
}

stock IsPlayerGroove(playerid)
{
	if(!IsPlayerCrimi(playerid)) return false;
	switch(pInfo[playerid][EXTTEAM])
	{
	    case EXTTEAM_GROOVE, EXTTEAM_LEADGROOVE: return true;
	}

	switch(pInfo[playerid][CLASS])
	{
	    case 9,10,11,12: return true;
	}

	return false;
}

stock IsPlayerBallas(playerid)
{
	if(!IsPlayerCrimi(playerid)) return false;
	switch(pInfo[playerid][EXTTEAM])
	{
	    case EXTTEAM_BALLAS, EXTTEAM_LEADBALLAS: return true;
	}

	switch(pInfo[playerid][CLASS])
	{
	    case 13,14,15,16: return true;
	}
	return false;
}

stock IsPlayerBac(playerid)
{
	if(IsPlayerCrimi(playerid)) return false;
	switch(pInfo[playerid][EXTTEAM])
	{
	    case EXTTEAM_BAC, EXTTEAM_LEADBAC: return true;
	}

	switch(pInfo[playerid][CLASS])
	{
	    case 6,7,8: return true;
	}
	return false;
}

stock MySQL_Login(playerid)
{
    new query[400], savingstring[35];
    format(query, sizeof(query), "SELECT * FROM comptes WHERE pseudo = '%s'", pInfo[playerid][name]);
    mysql_query(query);
    mysql_store_result();
    //fait crash
    while(mysql_fetch_row_format(query,"|"))
    {
        mysql_fetch_field_row(savingstring, "UID"); pInfo[playerid][UID]=strval(savingstring);
       	mysql_fetch_field_row(savingstring, "score"); SetPlayerScore(playerid, strval(savingstring));
        mysql_fetch_field_row(savingstring, "admin"); pInfo[playerid][admin]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "skin"); pInfo[playerid][skin]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "kills"); pInfo[playerid][kills]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "deaths"); pInfo[playerid][deaths]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "wanted-level"); pInfo[playerid][wanted]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "argent"); GivePlayerMoney(playerid, strval(savingstring));
        mysql_fetch_field_row(savingstring, "bank_cash"); pInv[playerid][BANK_CASH]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "SAC_C4"); pInv[playerid][SAC_C4]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "SAC_CORDES"); pInv[playerid][SAC_ROPES]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "SAC_CASH"); pInv[playerid][SAC_CASH]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "jailtime"); pInfo[playerid][jailtime]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "roblvl"); pInfo[playerid][roblvl]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "robprogress"); pInfo[playerid][robprogress]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "terrolvl"); pInfo[playerid][terrolvl]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "terroprogress"); pInfo[playerid][terroprogress]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "policelvl"); pInfo[playerid][policelvl]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "policeprogress"); pInfo[playerid][policeprogress]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "totaldetach"); pInfo[playerid][totaldetach]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "VIP"); pInfo[playerid][VIP]=(strval(savingstring)!=0) ? (true) : (false);
        mysql_fetch_field_row(savingstring, "Army"); pInfo[playerid][military]=(strval(savingstring)!=0) ? (true) : (false);
        mysql_fetch_field_row(savingstring, "LeaderGroove"); pInfo[playerid][leadgroove]=(strval(savingstring)!=0) ? (true) : (false);
        mysql_fetch_field_row(savingstring, "Groove"); pInfo[playerid][groove]=(strval(savingstring)!=0) ? (true) : (false);
        mysql_fetch_field_row(savingstring, "LeaderBallas"); pInfo[playerid][leadballas]=(strval(savingstring)!=0) ? (true) : (false);
        mysql_fetch_field_row(savingstring, "Ballas"); pInfo[playerid][ballas]=(strval(savingstring)!=0) ? (true) : (false);
        mysql_fetch_field_row(savingstring, "LeaderBAC"); pInfo[playerid][leadbac]=(strval(savingstring)!=0) ? (true) : (false);
        mysql_fetch_field_row(savingstring, "BAC"); pInfo[playerid][bac]=(strval(savingstring)!=0) ? (true) : (false);
       	mysql_fetch_field_row(pInfo[playerid][success], "success");
        mysql_fetch_field_row(pComp[playerid][competences], "competences");
        mysql_fetch_field_row(savingstring, "level"); pComp[playerid][comp_lvl]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "comp_points"); pComp[playerid][comp_points]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "comp_nextlvl"); pComp[playerid][comp_nextlvl]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "skill-pistol"); pSkill[playerid][skill_pistol]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "skill-silenced"); pSkill[playerid][skill_silenced]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "skill-deagle"); pSkill[playerid][skill_deagle]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "skill-shotgun"); pSkill[playerid][skill_shotgun]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "skill-sawnoff-shotgun"); pSkill[playerid][skill_sawnoff_shotgun]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "skill-spas12-shotgun"); pSkill[playerid][skill_spas12_shotgun]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "skill-micro_uzi"); pSkill[playerid][skill_micro_uzi]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "skill-mp5"); pSkill[playerid][skill_mp5]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "skill-ak47"); pSkill[playerid][skill_ak47]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "skill-m4"); pSkill[playerid][skill_m4]=strval(savingstring);
        mysql_fetch_field_row(savingstring, "skill-sniper"); pSkill[playerid][skill_sniper]=strval(savingstring);
    }
   	format(query, sizeof(query), "UPDATE `comptes` SET `last_connection` = %d WHERE `UID`='%d'", gettime(), pInfo[playerid][UID]);
	mysql_query(query);
    mysql_free_result();
    pInfo[playerid][logged]=true;
    pInfo[playerid][adminservice]=3;
  	return 1;
}

stock SendClientMessageToAllCops(color, msg[])
{
	for(new i=0;i<MAX_PLAYERS;i++)
		if(IsPlayerCops(i)&&pInfo[i][spawned]) SendClientMessage(i, color, msg);

	return 1;
}

stock SendClientMessageToAllAdmins(color, msg[], reason=0)
{
	new count=0;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(pInfo[i][admin]>0&&pInfo[i][adminservice]!=0)
		{
		    if(reason==0||pInfo[i][adminservice]==3) {
				count++;
		        SendClientMessage(i, color, msg);
		        continue;
			}
			if(reason==1&&pInfo[i][adminservice]==1){
				count++;
			    SendClientMessage(i, color, msg);
		        continue;
			}
  			if(reason==2&&pInfo[i][adminservice]==2){
				count++;
			    SendClientMessage(i, color, msg);
		        continue;
			}
		}
	}
	return count;
}

stock SendAdminChat(playerid, text[])
{
	new count=0;
	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(pInfo[i][admin]>0&&pInfo[i][adminservice]!=0)
		{
		    new msg[144];
		    format(msg, sizeof(msg), "(ADCHAT) %s(%d): {FFFFFF}%s", pInfo[playerid][name], playerid, text);
			SendClientMessage(i, COLOR_BLUE, msg);
		}
	}
	return count;
}

stock SetPlayerAutoColor(playerid)
{
	if(!IsPlayerConnected(playerid)||playerid==INVALID_PLAYER_ID||playerid<0) return -1;
	if(!pInfo[playerid][spawned])
	    SetPlayerColor(playerid, COLOR_DARKGREY);

	switch(pInfo[playerid][CLASS])
	{
	    case 0,1,9,10,11,12,13,14,15,16:
		{
			if(pInfo[playerid][wanted]==0) SetPlayerColor(playerid, COLOR_WHITE);
			else if(pInfo[playerid][wanted]<4) SetPlayerColor(playerid, COLOR_YELLOW);
			else if(pInfo[playerid][wanted]<20) SetPlayerColor(playerid, COLOR_ORANGE);
			else if(pInfo[playerid][wanted]<100) SetPlayerColor(playerid, COLOR_DARKORANGE);
			else if(pInfo[playerid][wanted]>100) SetPlayerColor(playerid, COLOR_RED);
		}
		case 2,3:
			SetPlayerColor(playerid, COLOR_BLUECOPS);
		case 4:
			SetPlayerColor(playerid, COLOR_SWAT);
		case 5:
			SetPlayerColor(playerid, COLOR_MILI);
		case 6,7,8:
		    SetPlayerColor(playerid, COLOR_BAC);
	}
	if(pInfo[playerid][furtiv]) {
		for(new i=0;i<MAX_PLAYERS;i++)
			if(i!=playerid&&IsPlayerConnected(i)) ShowPlayerMarkerForPlayer(i, playerid);
		pInfo[playerid][furtiv]=false;
 		pInfo[playerid][hidden]=false;
 	    HidePlayerProgressBar(playerid, FurtivBar[playerid]);
	}
	return 1;
}

//Timer
forward explcaisset(playerid, vehicleid);
forward OneTimer();
forward SaveStatsTimer();

public SaveStatsTimer()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	    if(IsPlayerConnected(i)) SavePlayerStats(i);
 	for(new i=i;i<=MAX_VEHICLES;i++)
	    if(IsValidVehicle(i)&&vInfo[i][P_UID]!=-1) SaveVehicleStats(i);

	new query[128];
    format(query, sizeof(query), "UPDATE `servinfo` SET `Money`=%d,`Score`=%d WHERE `Name`='Ballas'",
	Teams[BALLAS][MONEY], Teams[BALLAS][SCORE]);
	mysql_query(query);
	format(query, sizeof(query), "UPDATE `servinfo` SET `Money`=%d,`Score`=%d WHERE `Name`='Groove'",
	Teams[GROOVE][MONEY], Teams[GROOVE][SCORE]);
	mysql_query(query);
	SendClientMessageToAll(COLOR_ROYALBLUE, "Vos statistiques ont été automatiquement sauvegardés !");
}

public explcaisset(playerid, vehicleid)
{
	if(IsValidVehicle(vehicleid))
	{
		SendClientMessage(playerid, COLOR_GREEN, "Le véhicule a explosé, vous gagnez un point de score !");
		if(vInfo[vehicleid][P_UID]!=-1&&pInfo[playerid][UID]!=vInfo[vehicleid][P_UID]) {
		    AddScore(playerid, -23);
		    SendClientMessage(playerid, COLOR_RED, "Vous avez explosé un véhicule personnel, vous venez de perdre deux points de score !");
		}
	    new Float:x, Float:y, Float:z;
	    GetVehiclePos(vehicleid, x, y, z);
	   	CreateExplosion(x, y, z, 6, 9.5);
		DestroyVehicle(vehicleid);
		OnVehicleDeath(vehicleid, playerid);
		CreateExplosion(x, y, z, 6, 8.0);
		AddScore(playerid, 1);
		AddWanted(playerid, 2);
	}
}

public OneTimer()
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
		if(!IsPlayerConnected(i)) continue;
		if(IsPlayerNPC(i)) continue;
	    if(pInfo[i][mutedtime]>0&&pInfo[i][mutedtime]==gettime()) {
	        pInfo[i][mutedtime]=0;
	        SendClientMessage(i, COLOR_GREEN, "Vous pouvez de nouveau parler !");
		}
		if(!pInfo[i][spawned]) continue;

	    if(pInfo[i][MST]) {
	        GetPlayerHealth(i, pInfo[i][hp]);
	        SetPlayerHealth(i, floatsub(pInfo[i][hp], 0.10));
		}

		if(pInfo[i][pvtime]>0) {
            pInfo[i][pvtime]--;
            if(pInfo[i][pvtime]<=0) {
				SendClientMessage(i, COLOR_YELLOW, "Vous n'avez pas payé votre PV, vous gagnez 3 étoiles de recherches, la police a été prévenue.");
				AddWanted(i, 4);
				new msg[144];
				format(msg, sizeof(msg), "Le suspect %s(%d) n'a pas payé son PV, il est maintenant recherché: pourchassez-le !", pInfo[i][name], i);
				SendClientMessageToAllCops(COLOR_BLUECOPS, msg);
				pInfo[i][pvtime]=0;
			}
		}

	    if(pInfo[i][hit]>1) pInfo[i][hit]--;
	    if(pInfo[i][hit]==1) {
	        new msg[144];
	        format(msg, sizeof(msg), "Le contrat sur la tête de %s(%d) a expiré, vous ne pouvez plus le tuer.", pInfo[i][name], i);
		    for(new a=0;a<MAX_PLAYERS;a++) {
		        if(pInfo[a][TEAM]==TEAM_HITMAN) {
					SendClientMessage(a, COLOR_DARKGREY, msg);
		        }
		    }
	        SendClientMessage(i, COLOR_GREEN, "Vous avez perdu votre contrat !");
	    }
 		if(pInfo[i][kidnappedtime]>1)
		{
			new string[125];
		    format(string,sizeof(string),"~h~~w~Vous êtes kidnappé~n~~h~~r~%d ~h~~y~secondes restantes", pInfo[i][kidnappedtime]);
	      	GameTextForPlayer(i, string, 3000, 3);
			pInfo[i][kidnappedtime]--;
		}
		if(pInfo[i][kidnappedtime]==1)
		{
	    	TogglePlayerControllable(i, 1);
			pInfo[i][kidnapped] =false;
			pInfo[i][kidnappedtime]=0;
			SendClientMessage(i, COLOR_GREEN, "Vos cordes se sont détachées, vous pouvez vous enfuir !");
	    }
	    if(pInfo[i][noiselvl]>0) pInfo[i][noiselvl]=floatsub(pInfo[i][noiselvl], 6.5);
	    if(pInfo[i][invisible]&&pInfo[i][furtiv]) pInfo[i][furtiv]=false;
		if(pInfo[i][furtiv])
		{

		    if(GetPlayerSpecialAction(i)==SPECIAL_ACTION_DUCK&&!IsPlayerInAnyVehicle(i)) {
			    new Float:x, Float:y, Float:z;
			    GetPlayerVelocity(i, x, y, z);
			    new Float:result=floatmul(floatadd(floatadd(x, y), z), 2);
			    pInfo[i][noiselvl]=floatadd(pInfo[i][noiselvl], result);
				if(pInfo[i][noiselvl]>0&&pInfo[i][hidden]) {
				    pInfo[i][hidden]=false;
		 			for(new a=0;a<MAX_PLAYERS;a++)
					    if(a!=i&&IsPlayerConnected(a)) ShowPlayerMarkerForPlayer(a, i);
				}
				if(pInfo[i][noiselvl]<=0&&!pInfo[i][hidden]) {
				    pInfo[i][hidden]=true;
		 			for(new a=0;a<MAX_PLAYERS;a++)
					    if(a!=i&&IsPlayerConnected(a)) HidePlayerMarkerForPlayer(a, i);
				}
	       		ShowPlayerProgressBar(i, FurtivBar[i]);
				SetPlayerProgressBarValue(i, FurtivBar[i], pInfo[i][noiselvl]);
				UpdatePlayerProgressBar(i, FurtivBar[i]);
				if(pInfo[i][noiselvl]<0) pInfo[i][noiselvl]=0;
				if(pInfo[i][noiselvl]>100) pInfo[i][noiselvl]=100;
			}
			else {
				for(new a=0;a<MAX_PLAYERS;a++)
			    	if(a!=i&&IsPlayerConnected(a)) ShowPlayerMarkerForPlayer(a, i);
				pInfo[i][furtiv]=false;
	 	    	pInfo[i][furtiv]=false;
	 	    	HidePlayerProgressBar(i, FurtivBar[i]);
	 	    	SetPlayerAutoColor(i);
			}
		}
	    switch(GetPlayerCheckpoint(i, 3.0))
	    {
	        case INVALID_CHECKPOINT: DisablePlayerCheckpoint(i);
	        case CP_24/7: SetPlayerCheckpoint(i, -27.8137,-89.9468,1003.5469, 2.0);
	        case CP_BINCO_GANTON: SetPlayerCheckpoint(i, 207.6025,-100.8718,1005.2578, 2.0);
	        case CP_TATOO_GANTON: SetPlayerCheckpoint(i, -201.9624,-25.3541,1002.2734, 2.0);
	        case CP_COIFFEUR_GANTON: SetPlayerCheckpoint(i, 414.3945,-11.1661,1001.8120, 2.0);
	        case CP_ROBPIZZA_GANTON: SetPlayerCheckpoint(i, 376.4706,-119.1580,1001.4995, 2.0);
	        case CP_ALHAMBRA: SetPlayerCheckpoint(i, 502.1191,-17.4997,1000.6719, 2.5);
	        case CP_SUBURBAN: SetPlayerCheckpoint(i, 203.7636,-43.3142,1001.8047, 2.5);
	        case CP_ROBOIS: SetPlayerCheckpoint(i, -30.4141,-55.0585,1003.5469, 2.5);
	        case CP_CLUCKIN: SetPlayerCheckpoint(i, 370.8033,-6.5518,1001.8589, 2.5);
	        case CP_BURGERSHOT: SetPlayerCheckpoint(i, 418.5053,-75.5452,1001.8047, 2.5);
	        case CP_INSIDETRACK: SetPlayerCheckpoint(i, 822.6247,10.2105,1004.1933, 2.5);
	        case CP_ZIP: SetPlayerCheckpoint(i, 161.5579,-84.0103,1001.8047, 2.5);
	        case CP_TEENGREEN: SetPlayerCheckpoint(i, 496.5966,-75.8746,998.7578, 2.5);
	        case CP_ATM1: SetPlayerCheckpoint(i, 1497.0043,-1669.2726,14.0469, 2.5);
	        case CP_BANQUE: SetPlayerCheckpoint(i, 2316.6182,-7.2763,26.7422, 2.5);
	        case CP_EXPLBANKGATE: SetPlayerCheckpoint(i, 2318.3262,-15.9289,14.3815, 2.0);
	        case CP_VOLERBANQUE: SetPlayerCheckpoint(i, 2312.9063,-4.2867,14.3815, 2.0);
	    }
   	    switch(GetPlayerCheckpoint(i, 2.25))
	    {
	        case CP_AMMUNATION: SetPlayerCheckpoint(i, 294.7384,-40.7118,1001.5156, 2.34);
	    }
  	    switch(GetPlayerCheckpoint(i, 10))
	    {
	        case CP_BOMBSHOP: SetPlayerCheckpoint(i, 1102.7158,-1067.9561,31.8899, 3.0);
	        case CP_PRISON: SetPlayerCheckpoint(i, 1528.3334,-1677.8242,5.8906, 4.5);
	        case CP_ATM1: SetPlayerCheckpoint(i, 1497.0043,-1669.2726,14.0469, 3);
	        case CP_ATM2: SetPlayerCheckpoint(i, 1472.16138, -1310.49963, 13.25410, 5);
	        case CP_ATM3: SetPlayerCheckpoint(i, 1808.50134, -1396.98694, 13.01920, 5);
	        case CP_ATM4: SetPlayerCheckpoint(i, 2108.97729, -1790.71216, 13.19380, 5);
	        case CP_ATM5: SetPlayerCheckpoint(i, 1810.79199, -1876.69238, 13.22270, 5);
	        case CP_BUYVEH: SetPlayerCheckpoint(i, 1104.7067,-1370.3041,13.9844, 4.7);
	        case CP_HOPITAL: SetPlayerCheckpoint(i, 1176.8757,-1338.9587,13.9564, 4.7);
	        case CP_WEAPONPICKB: SetPlayerCheckpoint(i, 2332.6033,-1143.7164,1054.3047, 2.5);
	        case CP_WEAPONPICKG: SetPlayerCheckpoint(i, 135.4387,1380.0114,1088.3672, 2.5);
	    }
	    switch(GetPlayerCheckpoint(i, 20))
	    {
	        case CP_VENDREV: SetPlayerCheckpoint(i, 2078.7405,-2006.2996,13.1109, 5.5);
	    }
 	    if(pInfo[i][robatm]==1)
	    {
			new str[128], rand=0, money=0;
			rand=random(8);
			switch(rand)
			{
			    case 0:money=random((GetCompetence(i, 1)==1) ? (9000) : (8000));
			    case 1:money=random((GetCompetence(i, 1)==1) ? (10000) : (9000));
			    case 2:money=random((GetCompetence(i, 1)==1) ? (10500) : (9500));
			    case 3:money=random((GetCompetence(i, 1)==1) ? (11500) : (10000));
			    case 4:money=random((GetCompetence(i, 1)==1) ? (12250) : (10250));
			    case 5:money=random((GetCompetence(i, 1)==1) ? (13750) : (10750));
			    case 6:money=random((GetCompetence(i, 1)==1) ? (14500) : (11500));
			    case 7:money=random((GetCompetence(i, 1)==1) ? (15000) : (11750));
			    case 8:money=random((GetCompetence(i, 1)==1) ? (16000) : (12500));
			}
			pInfo[i][robprogress]+=30;
			if(pInfo[i][robprogress]>=100) {
			    pInfo[i][roblvl]++;
			    pInfo[i][robprogress]=0;
			    format(str, sizeof(str), "Vous avez monté de niveau voleur ! Vous êtes maintenant au niveau %d !", pInfo[i][roblvl]);
			    SendClientMessage(i, COLOR_GREEN, str);
			}
			format(str, sizeof(str), "%s(%d) vient de voler %s dans un ATM !", pInfo[i][name], i, FormatMoney(money));
			SendClientMessageToAll(COLOR_BLUE, str);
		    format(str, sizeof(str), "[RADIO] Le suspect %s(%d) a volé %s dans un ATM, interpellez-le !", pInfo[i][name], i, FormatMoney(money));
		    SendClientMessageToAllCops(COLOR_BLUECOPS, str);
		    GivePlayerMoney(i, money);
	        pInfo[i][robatm]=0;
	    }
		if(pInfo[i][robatm]>1)
		{
		    switch(GetPlayerCheckpoint(i)) {
		        case CP_ATM1, CP_ATM2, CP_ATM3, CP_ATM4, CP_ATM5: {
					new string[125];
			        format(string,sizeof(string),"~h~~w~Vol d'ATM en cours~n~~h~~r~%d ~h~~y~secondes~n~~b~La police a žtž pržvenue..."
					, pInfo[i][robatm]);
		      		GameTextForPlayer(i, string, 2200, 3);
				    pInfo[i][robatm]--;
				}
				default: {
					pInfo[i][robatm]=0;
					SendClientMessage(i, COLOR_ERROR, "Vol échoué, vous êtes sorti du checkpoint avant la fin !");
				}
			}
		}
	    if(pInfo[i][lrob]==1)
	    {
			new str[128], rand=0, money=0, lvl=20;
			rand=random((GetCompetence(i, 1)!=1) ? (8) : (9));
            switch(GetPlayerCheckpoint(i))
			{
				case CP_BOMBSHOP, CP_AMMUNATION:
				{
					lvl+=15;
					switch(rand)
					{
					    case 0:money=random(9557);
					    case 1:money=random(9857);
					    case 2:money=random(13870);
					    case 3:money=random(15560);
					    case 4:money=random(18870);
					    case 5:money=random(20200);
					    case 6:money=random(21770);
					    case 7:money=random(22770);
					    case 8:money=random(24770);
					}
				}
				case CP_BUYVEH: switch(rand)
				{
				    case 0:money=random(9557);
				    case 1:money=random(9857);
				    case 2:money=random(10557);
				    case 3:money=random(10736);
				    case 4:money=random(11057);
				    case 5:money=random(11557);
				    case 6:money=random(15000);
				    case 7:money=random(17000);
				    case 8:money=random(19000);
				}
				case CP_VOLERBANQUE:
				{
				    lvl+=25;
					AddWanted(i, 4);
					AddScore(i, 1);
					new amount=0;
					for(new a=0;a<MAX_PLAYERS;a++) {
					    if(i!=a&&IsPlayerConnected(a)&&pInv[a][BANK_CASH]>17957)
					    {
	        				amount=random(pInv[a][BANK_CASH]/3);
					        GivePlayerMoney(a, -amount);
					        format(str, sizeof(str), "%s(%d) vient de vous voler %s sur votre compte en banque !", pInfo[i][name], i, FormatMoney(amount));
							SendClientMessage(a, COLOR_DARKGREY, "[ MESSAGE DE LA BANQUE ]");
					        SendClientMessage(a, COLOR_LIGHTBLUE, str);
					        pInv[a][BANK_CASH]-=amount;
					        money+=amount;
					    }
					}
					if(amount==0) money=random((GetCompetence(i, 1)!=1) ? (50000) : (60000));
				}
				default: switch(rand)
				{
				    case 0:money=random(6557);
				    case 1:money=random(6857);
				    case 2:money=random(7557);
				    case 3:money=random(7736);
				    case 4:money=random(8057);
				    case 5:money=random(8557);
				    case 6:money=random(12000);
				    case 7:money=random(14000);
				    case 8:money=random(16000);
				}
			}
			if(GetPlayerCheckpoint(i)==CP_24/7)
		        FCNPC_SetSpecialAction(GetPlayerTargetPlayer(i), SPECIAL_ACTION_NONE);
			pInfo[i][robprogress]+=lvl;
			if(pInfo[i][robprogress]>=100) {
			    pInfo[i][roblvl]++;
			    pInfo[i][robprogress]=0;
			    format(str, sizeof(str), "Vous avez monté de niveau voleur ! Vous êtes maintenant au niveau %d !", pInfo[i][roblvl]);
			    SendClientMessage(i, COLOR_GREEN, str);
			}
		    GivePlayerMoney(i, money);
			format(str, sizeof(str), "%s(%d) vient de voler %s %s", pInfo[i][name], i, FormatMoney(money), cName[GetPlayerCheckpoint(i)]);
			SendClientMessageToAll(COLOR_BLUE, str);
		    format(str, sizeof(str), "[RADIO] Le suspect %s(%d) a volé %s %s, interpellez-le !", pInfo[i][name], i, FormatMoney(money), cName[GetPlayerCheckpoint(i)]);
		    SendClientMessageToAllCops(COLOR_BLUECOPS, str);
	        pInfo[i][lrob]=0;

	    }
		if(pInfo[i][lrob]>1)
		{
		    if(GetPlayerCheckpoint(i)==-1) {
				pInfo[i][lrob]=0;
				SendClientMessage(i, COLOR_ERROR, "Vol échoué, vous êtes sorti du checkpoint avant la fin !");
			}
			else {
			    new string[125];
		        format(string,sizeof(string),"~h~~w~Vol en cours~n~~h~~r~%d ~h~~y~secondes~n~~b~L'alarme a žtž activže..."
				, pInfo[i][lrob]);
	      		GameTextForPlayer(i, string, 3000, 3);
			    pInfo[i][lrob]--;
		    }
		}
	    if(pInfo[i][mentime] > 1)
	    {
	        new string[128];
	    	format(string,sizeof(string),"~h~~w~Menottž~n~~h~~y~pendant ~h~~r~%d ~h~~y~secondes",pInfo[i][mentime]);
    		GameTextForPlayer(i, string, 3000, 3);

			pInfo[i][mentime] --;
		}
		if(pInfo[i][mentime] == 1)
		{
		 	pInfo[i][mentime]=0;
		    SendClientMessage(i, COLOR_GREEN, "Vous avez été dé-menotté par l'anti-abus !");
	    	TogglePlayerControllable(i, 1);
			pInfo[i][cuffed] =false;
		 	SetPlayerSpecialAction(i,SPECIAL_ACTION_NONE);
			RemovePlayerAttachedObject(i,0);
		 	StopLoopingAnim(i);
		}
	    if(pInfo[i][jailtime] > 1)
	    {
	        new string[128];
	    	format(string,sizeof(string),"~h~~w~Jail~n~~h~~y~pendant ~h~~r~%d ~h~~y~secondes",pInfo[i][jailtime]);
    		GameTextForPlayer(i, string, 1000, 3);

			pInfo[i][jailtime] --;
		}
		if(pInfo[i][jailtime] == 1)
		{
		    pInfo[i][jailtime]=0;
	        new string[128];
			format(string,sizeof(string),"%s(%d) a été libéré de prison.",pInfo[i][name],i);
			SendClientMessageToAll(COLOR_ORANGE,string);
			SetPlayerHealth(i,100);
			SetPlayerArmour(i,0);
			SetPlayerPos(i,225.8451,112.8976,1003.2188);
			SetPlayerFacingAngle(i,1.0816);
			SetPlayerInterior(i,10);
			SetCameraBehindPlayer(i);
		}
	}
}

//Commandes

cmd:adon(playerid, params[]) return cmd_admode(playerid, params);
cmd:adoff(playerid, params[]) return cmd_admode(playerid, params);
cmd:admode(playerid,params[])
{
	if(pInfo[playerid][admin] < 2) return 0;
	if(!IsCanAction(playerid))
		return SendClientMessage(playerid,COLOR_ERROR,"Vous ne pouvez pas utiliser cette commande maintenant !");

	if(!pInfo[playerid][adminmode]) {
		pInfo[playerid][adskin] = GetPlayerSkin(playerid);

		for(new w=0; w<13; w++)
			GetPlayerWeaponData(playerid,w,PlayerWeapon[playerid][w],PlayerAmmo[playerid][w]);

		if(pInfo[playerid][admin] == 3)
			SetPlayerSkin(playerid, 211);

		if(pInfo[playerid][admin] >= 4)
			SetPlayerSkin(playerid, 217);

		ResetPlayerWeapons(playerid);
		pInfo[playerid][adminmode]=true;
		GivePlayerWeaponEx(playerid,38,999999);
		SetPlayerHealth(playerid,9999999999);
		SetPlayerArmour(playerid,9999999999);

	    for(new i = 0; i < MAX_PLAYERS; i++)
			ShowPlayerNameTagForPlayer(i, playerid, false);
	}
	else {
		ResetPlayerWeapons(playerid);
		for(new w=0; w<13; w++)
			GivePlayerWeaponEx(playerid,PlayerWeapon[playerid][w],PlayerAmmo[playerid][w]);

		for(new i = 0; i < MAX_PLAYERS; i++)
			ShowPlayerNameTagForPlayer(i, playerid, true);

		SetPlayerHealth(playerid,100);
		pInfo[playerid][adminmode]=false;
		SetPlayerSkin(playerid,pInfo[playerid][adskin]);
		SetPlayerArmour(playerid,100);
	}
	return 1;
}

cmd:assurance(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans un véhicule pour faire ça !");

	if(vInfo[GetPlayerVehicleID(playerid)][P_UID]!=pInfo[playerid][UID])
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans un véhicule vous appartenant pour acheter une assurance !");

	if(pInv[playerid][BANK_CASH]<15000)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez avoir de quoi payer l'assurance ($15,000) sur votre compte bancaire !");

	new vehicleid=GetPlayerVehicleID(playerid);
	if(vInfo[vehicleid][assured])
	    return SendClientMessage(playerid, COLOR_ERROR, "Votre véhicule est déjà assuré !");

	if(!PlayerToPoint(10.0,playerid,1085.8085,-1368.1053,13.7813))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être sur le pickup d'achat d'assurance de l'Otto's Car pour assurer votre véhicule !");

	vInfo[vehicleid][assured]=true;
	pInv[playerid][BANK_CASH]-=15000;
	SendClientMessage(playerid, COLOR_GREEN, "Votre véhicule est maintenant assuré ! $15,000 ont été prélevés de votre compte bancaire.");
	SaveVehicleStats(vehicleid);
	//Yup
	return 1;
}

cmd:achetergps(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans un véhicule pour faire ça !");

	if(vInfo[GetPlayerVehicleID(playerid)][P_UID]!=pInfo[playerid][UID])
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans un véhicule vous appartenant pour acheter un GPS !");

	if(pInv[playerid][BANK_CASH]<15000)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez avoir de quoi payer le GPS ($5,000) sur votre compte bancaire !");
	new vehicleid=GetPlayerVehicleID(playerid);
	if(vInfo[vehicleid][gps])
	    return SendClientMessage(playerid, COLOR_ERROR, "Votre véhicule possède déjà un GPS !");

	if(!PlayerToPoint(10.0,playerid,1085.8085,-1368.1053,13.7813))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être sur le pickup d'achat de GPS de l'Otto's Car pour assurer votre véhicule !");

	SendClientMessage(playerid, COLOR_GREEN, "Votre véhicule possède maintenant un GPS ! $5,000 ont été prélevés de votre comtpe bancaire, tapez /gps pour localiser votre véhicule.");
	pInv[playerid][BANK_CASH]-=15000;
	vInfo[vehicleid][gps]=true;
	SaveVehicleStats(vehicleid);
	return 1;
}

cmd:gps(playerid, params[])
{
	new dialog[2048]="";
	for(new v=1;v<=MAX_VEHICLES;v++)
		if(IsValidVehicle(v)&&!vInfo[v][destroyed]&&vInfo[v][gps]&&vInfo[v][P_UID]==pInfo[playerid][UID])
			format(dialog, sizeof(dialog), "%s\n%s", dialog, VehicleNames[GetVehicleModel(v)-400]);

	if(strlen(dialog)==0) return SendClientMessage(playerid, COLOR_ERROR, "Aucun véhicule ne possèdant un GPS n'a pu être trouvé !");
 	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "Localisation de vos véhicules", dialog, "Localiser", "Quitter");
	return 1;
}

cmd:question(playerid, params[])
{
	new reason[144];
	if(sscanf(params, "s[144]", reason))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /question (Question)");

	new msg[MAX_MESSAGE_SIZE];
	format(msg, sizeof(msg), "Question de %s(%d): %s", pInfo[playerid][name], playerid, reason);
	if(SendClientMessageToAllAdmins(COLOR_LIGHTBLUE, msg, 1)!=0)
	    SendClientMessage(playerid, COLOR_GREEN, "Votre question a bien été envoyée a un des administrateurs en ligne.");
	else
	    SendClientMessage(playerid, COLOR_RED, "Aucun administrateur n'est en ligne, votre question n'a pas pu être envoyée !");
	return 1;
}

cmd:report(playerid, params[])
{
	new reason[144], ID;
	if(sscanf(params, "is[144]", ID, reason))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /report (Pseudo/ID) (Raison)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas connecté !");

	new msg[MAX_MESSAGE_SIZE];
	format(msg, sizeof(msg), "Report de %s(%d) pour %s(%d): %s", pInfo[playerid][name], playerid, pInfo[ID][name], ID, reason);
	if(SendClientMessageToAllAdmins(COLOR_LIGHTBLUE, msg, 2)!=0)
	    SendClientMessage(playerid, COLOR_GREEN, "Votre report a bien été envoyé a un des administrateurs en ligne.");
	else
	    SendClientMessage(playerid, COLOR_RED, "Aucun administrateur n'est en ligne, votre report n'a pas pu être envoyé ! Vous pouvez le poster sur le forum dans la section \"Report\".");

	if(CanReport(playerid, ID))
        SendClientMessageToAllAdmins(COLOR_LIGHTBLUE, "Le report est justifié, vous pouvez sanctionner.", 2);
	return 1;
}

cmd:admin(playerid,params[])
{
	SendClientMessage(playerid,COLOR_ERROR,"[ Membres de l'équipe CRFR en ligne ]");
	SendClientMessage(playerid,COLOR_WHITE,"-------------------------------------------------------------------");
	new bool:co=false;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(pInfo[i][admin] > 0 && pInfo[i][adminservice]!=0)
	    {
	        co=true;
			new str[23], string[144];
	        switch(pInfo[i][admin])
	        {
				case 1:str="Modérateur en test";
				case 2:str="Modérateur";
				case 3:str="Super-Modérateur";
				case 4:str="Administrateur";
				case 5:str="Administrateur Général";
				case 1337:str="Fondateur";
	        }
			format(string,sizeof(string),"%s : %s(%d)", str, pInfo[i][name],i);
	        switch(pInfo[i][adminservice])
	        {
	            case 1:strcat(string, " (prend les questions)");
	            case 2:strcat(string, " (prend les reports)");
	            case 3:strcat(string, " (prend les questions et les reports)");
	        }
		    SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
        }
    }
    if(!co) SendClientMessage(playerid, COLOR_LIGHTBLUE, "Aucun staff n'est en ligne !");
	SendClientMessage(playerid,COLOR_WHITE,"-------------------------------------------------------------------");
	return 1;
}

cmd:service(playerid, params[])
{
	if(pInfo[playerid][admin]<=0) return 0;
	new lvl;
	if(sscanf(params, "i", lvl))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /service (Numéro) = 0(désactivé) - 1(prend les questions) - 2(prend les reports) - 3(prend les questions et les reports)");
	if(lvl<0||lvl>3)
		return SendClientMessage(playerid, COLOR_ERROR, "Usage: /service (Numéro = 0(désactivé) - 1(prend les questions) - 2(prend les reports) - 3(prend les questions et les reports).)");

	switch(lvl)
	{
	    case 0: SendClientMessage(playerid, COLOR_GREEN, "Vous n'êtes plus en service !");
	    case 1: SendClientMessage(playerid, COLOR_GREEN, "Vous prenez maintenant les questions !");
	    case 2: SendClientMessage(playerid, COLOR_GREEN, "Vous prenez maintenant les reports !");
	    case 3: SendClientMessage(playerid, COLOR_GREEN, "Vous prenez maintenant les questions et les reports!");
	}

	pInfo[playerid][adminservice]=lvl;
	return 1;
}

cmd:compinfo(playerid, params[])
{
	new dialog[600];
	for(new i=0;i<sizeof(sCompetences);i++)
		 format(dialog, sizeof(dialog), "%s%s - %s\n", dialog, sCompetences[i][0], sCompetences[i][1]);
	ShowPlayerDialog(playerid, DIALOG_COMPINFO, DIALOG_STYLE_LIST, "Informations sur les Compétences", dialog, "Ok", "Annuler");
	return 1;
}

cmd:comp(playerid, params[]) return cmd_competences(playerid, params);
cmd:competences(playerid, params[])
{
	new dialog[600], title[50];
	for(new i=0;i<sizeof(sCompetences);i++)
		format(dialog, sizeof(dialog), "%s%s - %s: niveau %d\n", dialog, sCompetences[i][0], sCompetences[i][1], GetCompetence(playerid, i));

	format(title, sizeof(title), "Compétences - Niveau %d (%d points)", pComp[playerid][comp_lvl], pComp[playerid][comp_points]);
	ShowPlayerDialog(playerid, DIALOG_COMP, DIALOG_STYLE_LIST, title, dialog, "Ok", "Annuler");
	return 1;
}

cmd:succes(playerid, params[])
{
	new dialog[600];
	for(new i=0;i<sizeof(sCompetences);i++)
		if(strlen(Successes[i][0])!=0&&GetSuccess(playerid, i))
			format(dialog, sizeof(dialog), "{29A613}%s%s - %s\n", dialog, Successes[i][0], Successes[i][1]);
	if(!strlen(dialog)) dialog="Vous n'avez aucun succès !";
	ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Succès", dialog, "OK", "");
	return 1;
}

cmd:admsg(playerid, params[])
{
	if(pInfo[playerid][admin]<1) return 0;
	new text[111];
	if(sscanf(params, "s[111]", text))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /admsg (Message)");
 	new str[23], msg[144];
  	switch(pInfo[playerid][admin])
 	{
		case 1:str="Modérateur en test";
		case 2:str="Modérateur";
		case 3:str="Super-Modérateur";
		case 4:str="Administrateur";
		case 5:str="Administrateur Général";
		case 1337:str="Fondateur";
		default:str="Staff";
	}
	format(msg, sizeof(msg), "%s: {FFFFFF}%s", str, text);
	SendClientMessageToAll(COLOR_BLUE, msg);
	return 1;
}

cmd:adchat(playerid, params[])
{
	if(pInfo[playerid][admin]<1) return 0;
	new text[144];
	if(sscanf(params, "s[144]", text))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /adchat (Message)");
	SendAdminChat(playerid, text);
	return 1;
}

cmd:adpm(playerid, params[])
{
	if(pInfo[playerid][admin]<1) return 0;
	new ID, pmsg[144];
	if(sscanf(params, "us[144]", ID, pmsg))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /adpm (Pseudo/ID) (Message)");

	if(!IsPlayerConnected(ID)||!pInfo[ID][logged])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas connecté !");

	if(playerid==ID)
		return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas vous envoyer un message privé à vous-même !");

	new msg[128];
	format(msg, sizeof(msg), "PM STAFF: %s (Répondez en /question)", pmsg);
	SendClientMessage(ID, COLOR_DARKYELLOW, msg);
	format(msg, sizeof(msg), "PM STAFF à %s(%d): %s", pInfo[ID][name], ID, pmsg);
	SendClientMessage(playerid, COLOR_DARKYELLOW, msg);
	return 1;
}

cmd:pm(playerid, params[])
{
	new ID, pmsg[144];
	if(sscanf(params, "us[144]", ID, pmsg))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /pm (Pseudo/ID) (Message)");

	if(!IsPlayerConnected(ID)||!pInfo[ID][logged])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas connecté !");

	if(playerid==ID)
		return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas vous envoyer un message privé à vous-même !");

	if(pInfo[playerid][mutedtime]>gettime()) {
		new msg[128];
		format(msg, sizeof(msg), "Vous êtes muté pendant encore %d secondes, vous ne pouvez pas parler !", pInfo[playerid][mutedtime]-gettime());
	    return SendClientMessage(playerid, COLOR_ERROR, msg);
	}
	new msg[128];
	format(msg, sizeof(msg), "PM de %s(%d): %s", pInfo[playerid][name], playerid, pmsg);
	SendClientMessage(ID, COLOR_DARKYELLOW, msg);
	format(msg, sizeof(msg), "PM à %s(%d): %s", pInfo[ID][name], ID, pmsg);
	SendClientMessage(playerid, COLOR_DARKYELLOW, msg);
	pInfo[ID][lastpm]=playerid;
	pInfo[ID][lastpmtype]=false;
	new str[128];
	format(str, sizeof(str), "%s(%d) à %s(%d): %s", pInfo[playerid][name], playerid, pInfo[ID][name], ID, pmsg);
	log("PM", str);
	return 1;
}

cmd:rpm(playerid, params[])
{
	new msg[144];
	if(sscanf(params, "s[144]", msg))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /rpm (Message)");
	new pm[128];
	format(pm, sizeof(pm), "%d %s", pInfo[playerid][lastpm], msg);
	return cmd_pm(playerid, pm);
}

cmd:seeid(playerid, params[])
{
	if(pInfo[playerid][TEAM]!=TEAM_HACKER)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas hacker, vous ne pouvez pas faire ça !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");

	if(pInfo[playerid][seeid]) {
	    pInfo[playerid][seeid]=false;
		SendClientMessage(playerid, COLOR_GREEN, "Vous ne voyez maintenant plus les ID de véhicule !");
	    Unload3DID(playerid);
	}
	else {
	    pInfo[playerid][seeid]=true;
		SendClientMessage(playerid, COLOR_GREEN, "Vous voyez maintenant les ID de véhicule !");
	    Load3DID(playerid);
	}
	return 1;
}

cmd:hackveh(playerid, params[])
{
	if(pInfo[playerid][TEAM] != TEAM_HACKER)
 		return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être un hacker pour pirater des véhicules !");

    if(!IsCanAction(playerid))
		return SendClientMessage(playerid,COLOR_ERROR,"Vous ne pouvez pas utiliser cette commande maintenant.");

	new avid;
	if(sscanf(params, "i", avid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /hackveh (ID du Véhicule) (/seeid pour voir les ID de véhicules)");

	if(pInfo[playerid][lastvhack]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà piraté un véhicule récemment ! Veuillez attendre un peu !");

	if(!IsValidVehicle(avid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le véhicule n'existe pas, ré-essayez avec un autre !");

	if(vInfo[avid][hacked])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce véhicule est déjà immobilisé !");

	new Float:pos[3];
	GetVehiclePos(avid, pos[0], pos[1], pos[2]);
	if(!PlayerToPoint((!pInv[playerid][amplificator]) ? (30) : (45), playerid, pos[0], pos[1], pos[2]))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le véhicule est trop loin de vous!");

	pInfo[playerid][lastvhack]=gettime()+30;
	if(!Chances((GetCompetence(playerid, 1)==1) ? (20) : (30)))
	    return SendClientMessage(playerid, COLOR_ERROR, "Tentative de hacking de véhicule échouée!");
	pInfo[playerid][lastvhack]=gettime()+65;
	SendClientMessage(playerid, COLOR_YELLOW, "Vous venez de pirater un véhicule!");
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
    SetTimerEx("animtimer", 2000, false, "i", playerid);
    SetTimerEx("hackvehcmd", 2575, false, "ii", playerid, avid);

	vInfo[avid][hacked]=true;
	return 1;
}

cmd:invisible(playerid, params[])
{
	if(pInfo[playerid][TEAM] != TEAM_HACKER)
 		return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être un hacker pour vous rendre invisible !");

 	if(pInfo[playerid][lastinvisible]>gettime())
 	    return SendClientMessage(playerid, COLOR_ERROR, "Vous vous êtes déjà rendu invisible récemment, attendez un petit peu!");

	if(pInfo[playerid][invisible])
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous êtes déjà invisible !");

	for(new i=0;i<MAX_PLAYERS;i++)
	    if(i!=playerid&&IsPlayerConnected(i)) HidePlayerMarkerForPlayer(i, playerid);

    pInfo[playerid][invisible]=true;
	SendClientMessage(playerid, COLOR_GREEN, (!pInv[playerid][amplificator]) ? ("Vous êtes maintenant invisible pour une minute sur la map !") : ("Vous êtes maintenant invisible pour une minute et 30 secondes sur la map !"));
	pInfo[playerid][invisibletimer]=SetTimerEx("invtimer", (!pInv[playerid][amplificator]) ? (60000) : (90000), false, "i", playerid);
	return 1;
}

cmd:explveh(playerid, params[])
{
	if(pInfo[playerid][TEAM]!=TEAM_HACKER)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas hacker, vous ne pouvez pas faire ça !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");

	new vid;
	if(sscanf(params, "i", vid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /explveh (ID du Véhicule)");

	if(!IsValidVehicle(vid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce véhicule n'existe pas !");

	if(vInfo[vid][gonnaexplode])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce véhicule va déjà exploser !");

	new Float:pos[3];
	GetVehiclePos(vid, pos[0], pos[1], pos[2]);
	if(!PlayerToPoint((!pInv[playerid][amplificator]) ? (30) : (45), playerid, pos[0], pos[1], pos[2]))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le véhicule est trop loin de vous !");

	if(vInfo[vid][P_UID]!=-1)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce véhicule appartient à quelqu'un, vous ne pouvez pas faire ça !");

    for(new i; i < MAX_PLAYERS; i++)
		if(GetPlayerVehicleID(i) == vid) return SendClientMessage(playerid, COLOR_ERROR, "Ce véhicule est occupé, vous ne pouvez pas faire ça !");

	if(pInfo[playerid][lastexpl]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà explosé un véhicule récemment, vous ne pouvez pas en exploser un autre !");

    pInfo[playerid][lastexpl]=gettime()+30;

	if(!Chances((GetCompetence(playerid, 1)==1) ? (20) : (30)))
	    return SendClientMessage(playerid, COLOR_ERROR, "Tentative échouée, ré-essayez plus tard !");

    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
	SendClientMessage(playerid, COLOR_YELLOW, "Le véhicule ciblé va exploser, courrez!");
	PlayerPlaySound(playerid, 1057, 0, 0, 0);
	vInfo[vid][gonnaexplode]=true;
    pInfo[playerid][lastexpl]+=45;
    pInfo[playerid][expltimer]=SetTimerEx("explveh", 4500, false, "ii", playerid, vid);
    SetTimerEx("animtimer", 3000, false, "i", playerid);
	return 1;
}

cmd:hackatm(playerid, params[])
{
	if(pInfo[playerid][TEAM]!=TEAM_HACKER)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être hacker pour hacker un atm !");

    if(!IsCanAction(playerid))
		return SendClientMessage(playerid,COLOR_ERROR,"Vous ne pouvez pas utiliser cette commande maintenant.");

	if(!PlayerToPoint(10.0,playerid,1497.00430, -1669.27260, 14.04690) && // ATM 1
	!PlayerToPoint(10.0,playerid,1472.16138, -1310.49963, 13.25410) &&// ATM2
	!PlayerToPoint(10.0,playerid,1808.50134, -1396.98694, 13.01920) &&// ATM3
	!PlayerToPoint(10.0,playerid,2108.97729, -1790.71216, 13.19380) &&// ATM4
	!PlayerToPoint(10.0,playerid,1810.79199, -1876.69238, 13.22270))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas à proximité d'un ATM !");

	if(pInfo[playerid][lastatmhack]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez tenté de hacker/hacké un ATM récemment, vous devez patienter !");

    if(PlayerToPoint((!pInv[playerid][amplificator]) ? (10.0) : (20.0),playerid, 1497.00430, -1669.27260, 14.04690)){
        if(SomeoneHackATM[1])
            return SendClientMessage(playerid, COLOR_ERROR, "Quelqu'un pirate déjà cet ATM!");
        pInfo[playerid][hackatmid]=1;}

    if(PlayerToPoint((!pInv[playerid][amplificator]) ? (10.0) : (20.0),playerid, 1472.16138, -1310.49963, 13.25410)){
        if(SomeoneHackATM[2])
        	return SendClientMessage(playerid, COLOR_ERROR, "Quelqu'un pirate déjà cet ATM!");
        pInfo[playerid][hackatmid]=2;}

    if(PlayerToPoint((!pInv[playerid][amplificator]) ? (10.0) : (20.0),playerid, 1808.50134, -1396.98694, 13.01920)){
        if(SomeoneHackATM[3])
            return SendClientMessage(playerid, COLOR_ERROR, "Quelqu'un pirate déjà cet ATM!");
        pInfo[playerid][hackatmid]=3;}

    if(PlayerToPoint((!pInv[playerid][amplificator]) ? (10.0) : (20.0),playerid, 2108.97729, -1790.71216, 13.19380)){
        if(SomeoneHackATM[4])
            return SendClientMessage(playerid, COLOR_ERROR, "Quelqu'un pirate déjà cet ATM!");
        pInfo[playerid][hackatmid]=4;}

    if(PlayerToPoint((!pInv[playerid][amplificator]) ? (10.0) : (20.0),playerid, 1810.79199, -1876.69238, 13.22270)){
        if(SomeoneHackATM[5])
            return SendClientMessage(playerid, COLOR_ERROR, "Quelqu'un pirate déjà cet ATM!");
        pInfo[playerid][hackatmid]=5;}

	if(LastAtmHacked[pInfo[playerid][hackatmid]]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Cet ATM a déjà été piraté récemment!");

 	pInfo[playerid][lastatmhack]=gettime()+70;
	if(!Chances(43)){
	    pInfo[playerid][hackatmid]=-1;
	    return SendClientMessage(playerid, COLOR_ERROR, "Tentative de piratage échouée!");
 	}
 	pInfo[playerid][lastatmhack]+=100;
   	LastAtmHacked[pInfo[playerid][hackatmid]]=gettime()+220;
	SomeoneHackATM[pInfo[playerid][hackatmid]]=true;
	SendClientMessage(playerid, COLOR_GREEN, "Vous piratez un ATM, restez à proximité jusqu'à la fin du piratage.");
	pInfo[playerid][hackatm]=0.0;
	pInfo[playerid][hackatmtimer]=SetTimerEx("phackatmtimer", (!pInv[playerid][amplificator]) ? (187) : (162), true, "i", playerid);
	ShowPlayerProgressBar(playerid, HackATMT[playerid]);
	SetPlayerProgressBarValue(playerid, HackATMT[playerid], pInfo[playerid][hackatm]);
	AddWanted(playerid, 3);
	return 1;
}

cmd:exploser(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");

	if(pInfo[playerid][TEAM]!=TEAM_TERRO)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être terroriste pour exploser les lieux !");

	if(pInv[playerid][C4]<=0)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'avez pas de C4 sur vous !");

	if(pInfo[playerid][lastlxpl]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà explosé ou tenté d'exploser un lieu récemment, vous devez attendre !");

	pInfo[playerid][lastlxpl]=gettime()+35;

	if(!Chances((GetCompetence(playerid, 1)==1) ? (20) : (30))) {
	    AddWanted(playerid, 2);
	    return SendClientMessage(playerid, COLOR_ERROR, "Tentative d'amorcage échouée, la police a été prévenue !");
	}
	pInfo[playerid][lastlxpl]=gettime()+35;

	if(PlayerToPoint(3.0, playerid, 2318.2739,-16.0869,15.3815)) {
	    if(BankGateO) return SendClientMessage(playerid, COLOR_ERROR, "Ce lieu est déjà explosé, attendez qu'il soit réparé !");
		if(pInfo[playerid][terrolvl]<15)
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être terroriste de niveau 10 minimum pour exploser ce lieu !");
	    SendClientMessage(playerid, COLOR_RED, "Vous avez posé une bombe, elle explosera dans 5 secondes, éloignez vous !");
	    SetTimerEx("bankgateexpl", 5000, false, "i", playerid);
	    pInv[playerid][C4]--;
	 	pInfo[playerid][terroprogress]+=20;
		if(pInfo[playerid][terroprogress]>=100) {
		    new str[144];
			pInfo[playerid][terrolvl]++;
			pInfo[playerid][terroprogress]=0;
			format(str, sizeof(str), "Vous avez monté de niveau terroriste ! Vous êtes maintenant au niveau %d !", pInfo[playerid][terrolvl]);
			SendClientMessage(playerid, COLOR_GREEN, str);
		}
	    return 1;
	}

	SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans un checkpoint de lieu explosable !");
	return 1;
}

cmd:explcaisse(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");

	if(pInfo[playerid][TEAM]!=TEAM_TERRO)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être terroriste pour exploser les véhicules !");

	if(!IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans un véhicule !");

	if(pInfo[playerid][lastxpl]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà explosé ou tenté d'exploser un véhicule récemment, vous devez attendre un peu !");

	if(pInv[playerid][C4]<=0)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'avez pas assez de C4 sur vous !");

	pInfo[playerid][lastxpl]=gettime()+35;

 	if(!Chances((GetCompetence(playerid, 1)==1) ? (20) : (30)))
	    return SendClientMessage(playerid, COLOR_ERROR, "Tentative d'explosion de véhicule échouée!");

	SetTimerEx("explcaisset", 10000, false, "ii", playerid, GetPlayerVehicleID(playerid));
	pInv[playerid][C4]--;
	pInfo[playerid][lastxpl]=gettime()+65;
	SendClientMessage(playerid, COLOR_GREEN, "Vous avez posé une bombe dans ce véhicule, elle explosera dans 10 secondes !");
    AddWanted(playerid, 2);
 	pInfo[playerid][terroprogress]+=20;
	if(pInfo[playerid][terroprogress]>=100) {
		new str[144];
		pInfo[playerid][terrolvl]++;
		pInfo[playerid][terroprogress]=0;
		format(str, sizeof(str), "Vous avez monté de niveau terroriste ! Vous êtes maintenant au niveau %d !", pInfo[playerid][terrolvl]);
		SendClientMessage(playerid, COLOR_GREEN, str);
	}
	return 1;
}

cmd:arme(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	new cp=GetPlayerCheckpoint(playerid);
	if(cp==CP_WEAPONPICKG) {
	    if(!IsPlayerGroove(playerid)) return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas prendre d'arme ici si vous n'êtes pas Groove !");
		if(pInfo[playerid][lastweaponpick]>gettime())
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà pris une arme récemment, attendez un peu !");

		ShowPlayerDialog(playerid, DIALOG_PICKWEP, DIALOG_STYLE_LIST, "Armes", "9mm Silencieux\nFusil a Pompe\nMP5\nM4", "Prendre", "Quitter");
		return 1;
	}

	if(cp==CP_WEAPONPICKB) {
	    if(!IsPlayerBallas(playerid)) return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas prendre d'arme ici si vous n'êtes pas Ballas !");
		if(pInfo[playerid][lastweaponpick]>gettime())
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà pris une arme récemment, attendez un peu !");

		ShowPlayerDialog(playerid, DIALOG_PICKWEP, DIALOG_STYLE_LIST, "Armes", "9mm Silencieux\nFusil a Pompe\nMP5\nM4", "Prendre", "Quitter");
		return 1;
	}
	return 1;
}

cmd:coffre(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(PlayerToPoint(3, playerid, 144.9846, 1384.1897, 1088.6672)) {
		if(!IsPlayerGroove(playerid))
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça si vous n'êtes pas un Groove !");
		ShowPlayerDialog(playerid, DIALOG_COFFREG, DIALOG_STYLE_LIST, "Coffre Groove", "Ajouter de l'argent\nRetirer de l'argent\n{FF0000}Contenu du coffre", "OK", "Annuler");
		return 1;
	}

	if(PlayerToPoint(3, playerid, 2337.9810,-1141.6392,1054.3047)) {
		if(IsPlayerBallas(playerid))
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça si vous n'êtes pas un Ballas !");
		ShowPlayerDialog(playerid, DIALOG_COFFREB, DIALOG_STYLE_LIST, "Coffre Ballas", "Ajouter de l'argent\nRetirer de l'argent\n{FF0000}Contenu du coffre", "OK", "Annuler");
		return 1;
	}

	return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes a proximité d'aucun coffre de team !");
}

cmd:banque(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");

	if(GetPlayerCheckpoint(playerid)!=CP_BANQUE)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans le checkpoint de la banque !");

	ShowPlayerDialog(playerid, DIALOG_BANQUE, DIALOG_STYLE_LIST, "Gestion de votre Compte en Banque", "Déposer de l'argent\nRetirer de l'argent\n{FF0000}Informations du compte", "Choisir", "Annuler");
	return 1;
}

cmd:retrait(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");

	new cp=GetPlayerCheckpoint(playerid);
	if(cp!=CP_ATM1&&cp!=CP_ATM2&&cp!=CP_ATM3&&cp!=CP_ATM4&&cp!=CP_ATM5)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans un checkpoint d'ATM !");

	new dialog[256];
 	format(dialog, sizeof(dialog), "Entrez un la quantité d'argent à retirer\nVous avez {FF0000}%s{A9C4E4} en banque.", FormatMoney(pInv[playerid][BANK_CASH]));
	ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_INPUT, "Retirer de l'argent", dialog, "Retirer", "Annuler");
	return 1;
}

cmd:sac(playerid, params[]) return cmd_sacados(playerid, params);
cmd:sacados(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
	new dialog[600];
	format(dialog, sizeof(dialog),
 	"%sAjouter toute vos cordes\n%sAjouter tout votre C4\n%sPrendre des cordes\n%sPrendre du C4\nAjouter de l'argent\nPrendre de l'argent\n{FF0000}Contenu de l'inventaire",
 	(!IsPlayerCrimi(playerid)) ? ("{6C6C6C}") : (""), (!IsPlayerCrimi(playerid)) ? ("{6C6C6C}") : (""), (!IsPlayerCrimi(playerid)) ? ("{6C6C6C}") : (""), (!IsPlayerCrimi(playerid)) ? ("{6C6C6C}") : (""));
	ShowPlayerDialog(playerid, DIALOG_SAC, DIALOG_STYLE_LIST, "Sac à dos", dialog, "Ok", "Fermer");
	return 1;
}

cmd:inventaire(playerid, params[]) return cmd_inv(playerid, params);
cmd:inv(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");

	new dialog[2042]="Contenu de votre inventaire:";
	if(IsPlayerCrimi(playerid)) format(dialog, sizeof(dialog), "%s\nNombre de C4 (sur vous): {FF0000}%d{A9C4E4}. Dans votre sac: {FF0000}%d{A9C4E4}.", dialog, pInv[playerid][C4], pInv[playerid][SAC_C4]);
	if(IsPlayerCrimi(playerid)) format(dialog, sizeof(dialog), "%s\nNombre de cordes (sur vous): {FF0000}%d{A9C4E4}. Dans votre sac: {FF0000}%d{A9C4E4}.", dialog, pInv[playerid][ROPES], pInv[playerid][SAC_ROPES]);
	format(dialog, sizeof(dialog), "%s\nArgent (sur vous): {FF0000}%s{A9C4E4}. Dans votre sac: {FF0000}%s{A9C4E4}.", dialog, FormatMoney(GetPlayerMoney(playerid)), FormatMoney(pInv[playerid][SAC_CASH]));
	format(dialog, sizeof(dialog), "%s\n{FF0000}%d{A9C4E4} saucisses, {FF0000}%d{A9C4E4} paire de ciseaux, {FF0000}%d{A9C4E4} amplificateur", dialog, pInv[playerid][saucisses], pInv[playerid][scissors], pInv[playerid][amplificator]);
	ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Contenu de l'inventaire", dialog, "OK", "");
	return 1;
}

cmd:acheter(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");

	new cp=GetPlayerCheckpoint(playerid);

	switch(cp)
	{
		case CP_24/7, CP_ROBOIS:
			return ShowPlayerDialog(playerid, DIALOG_24/7, DIALOG_STYLE_LIST, "MAGASIN 24/7", "Cordes (1x = $750)\nCiseaux ($1,200)\nSaucisses (1x = $500)\nAmplificateur ($22,500)", "Acheter", "Quitter");
		case CP_BUYVEH:
		    return ShowPlayerDialog(playerid, DIALOG_BUYVEH, DIALOG_STYLE_LIST, "Acheter un véhicule",
			"Infernus ($250,000)\nTurismo ($225,000)\nSuper GT ($230,000)\nBullet (225,000)\nHotring Racer ($400,000)\nBuffalo ($200,000)\nStretch ($125,000)\nCheetah ($175,000)\nBanshee ($175,000)\nZR-350 ($175,000)\nComet ($150,000)"
			, "Acheter", "Annuler");
		case CP_HOPITAL: {
			if(GetPlayerMoney(playerid)<5000)
			    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'avez pas assez d'argent !");
			GetPlayerHealth(playerid, pInfo[playerid][hp]);
			if(pInfo[playerid][hp]>=100&&!pInfo[playerid][MST])
			    return SendClientMessage(playerid, COLOR_ERROR, "Vous êtes en parfaite santé, ne gâchez pas votre argent !");
			GivePlayerMoney(playerid, -5000);
			SetPlayerHealth(playerid, 100);
			pInfo[playerid][MST]=false;
			return SendClientMessage(playerid, COLOR_ERROR, "Vous avez été soigné de toute maladies et blessure au prix de $5,000 !");
		}
		case CP_BOMBSHOP:{
		    if(IsPlayerCrimi(playerid))
				return ShowPlayerDialog(playerid, DIALOG_BOMBSHOP, DIALOG_STYLE_LIST, "BombShop", "Sacoches de C4 (1x = $500)", "Acheter", "Annuler");
			else
			    return SendClientMessage(playerid, COLOR_ERROR, "Tu ne peux rien acheter au BombShop si tu n'es pas criminel !");
		}
	}
	if(PlayerToPoint(3, playerid, 295.4040,-37.5995,1001.5156))
		return ShowPlayerDialog(playerid, DIALOG_WEPD, DIALOG_STYLE_LIST, "Catégories", "Arme de Mélées\nPistolets\nMitraillettes\nFusils\nGilet pare-balle ($1,000)", "Continuer", "Annuler");

	return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans un checkpoint où vous pourriez acheter quelque chose !");
}

cmd:men(playerid, params[])
{
	if(!IsPlayerCops(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas menotter si vous n'êtes pas policier !");

	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /men (Pseudo/ID)");

	if(IsPlayerCops(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas menotter un policier !");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas connecté.");

	if(pInfo[ID][cuffed])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est déjà menotté, vous ne pouvez pas le menotter !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action dans un véhicule!");

	if(!IsCanAction(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action sur ce joueur maintenant !");

	if(IsPlayerInAnyVehicle(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action sur un joueur dans un véhicule!");

	if(!Chances()&&pInfo[ID][wanted]>=4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Tentative de menottage échoué!");
	if(GetDistanceBetweenPlayers(playerid, ID) > 4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est trop loin !");
	pInfo[ID][cuffed]=true;
	new msg[128];
	format(msg, sizeof(msg), "L'officier de police %s(%d) vient de vous menotter !", pInfo[playerid][name], playerid);
	SendClientMessage(ID, COLOR_LIGHTBLUE, msg);
	format(msg, sizeof(msg), "[ MENOTTAGE ]");
	SendClientMessage(playerid, COLOR_GREY, msg);
	if(pInfo[ID][wanted]==0)format(msg, sizeof(msg), "Vous venez de menotter %s(%d). Il est {FFFFFF}innocent{33CCFF}, vous pouvez le fouiller avec /fouiller !", pInfo[ID][name], ID);
	else if(pInfo[ID][wanted]<4) {
		format(msg, sizeof(msg), "Vous venez de menotter %s(%d). Il est {D0CB04}suspect{33CCFF}.", pInfo[ID][name], ID);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, msg);
		format(msg, sizeof(msg),  "Vous devez lui donner un pv avec /pv et vous pouvez le fouiller avec /fouiller!", pInfo[ID][name], ID);
	}
	else if(pInfo[ID][wanted]<20)
		format(msg, sizeof(msg),"Vous venez de menotter %s(%d). Il est {E09405}recherché{33CCFF}, vous devez l'arrêter avec /ar !", pInfo[ID][name], ID);

	else if(pInfo[ID][wanted]<100)
		format(msg, sizeof(msg),"Vous venez de menotter %s(%d). Il est {D75906}hautement recherché{33CCFF}, vous devez l'arrêter avec /ar !", pInfo[ID][name], ID);

	else if(pInfo[ID][wanted]>=100)
		format(msg, sizeof(msg),"Vous venez de menotter %s(%d). Il est {C60000}êxtremement recherché{33CCFF}, vous devez l'arrêter avec /ar !", pInfo[ID][name], ID);

	SendClientMessage(playerid, COLOR_LIGHTBLUE, msg);
	TogglePlayerControllable(ID,0);
	SetPlayerAttachedObject(ID, 0, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
  	SetPlayerSpecialAction(ID,SPECIAL_ACTION_CUFFED);
 	pInfo[ID][mentime]=30;
	return 1;
}

cmd:pv(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(!IsPlayerCops(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça si vous n'êtes pas policier !");

	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /pv (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas connecté !");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action depuis un véhicule!");

	if(IsPlayerInAnyVehicle(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action sur un joueur dans un véhicule!");

	if(pInfo[ID][wanted]==0||pInfo[ID][wanted]>=4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur doit être jaune (niveau de recherche 1~3) pour que vous puissiez lui donner un PV !");

	if(pInfo[ID][pvtime]>0)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur a déjà un PV !");

 	if(GetDistanceBetweenPlayers(playerid, ID) > 4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est trop loin !");

	new msg[144];
	format(msg, sizeof(msg), "Vous venez de donner un PV à %s(%d), il  a une minute pour le payer.", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, msg);
	format(msg, sizeof(msg), "Le policier %s(%d) vient de vous donner un PV, vous avez une minute pour le payer ou vous serez encore plus recherché ! ", pInfo[playerid][name], playerid);
	SendClientMessage(ID, COLOR_LIGHTBLUE, msg);
	SendClientMessage(ID, COLOR_LIGHTBLUE, "Tapez /paypv pour payer votre PV. Un PV coûte $1,000");
	pInfo[ID][pvtime]=60;
	return 1;
}

cmd:paypv(playerid, params[])
{
	if(pInfo[playerid][pvtime]<=0)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'avez aucun PV à payer !");

	if(GetPlayerMoney(playerid)<1000)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'avez pas assez d'argent ($1,000) pour payer le PV !");

	SendClientMessage(playerid, COLOR_GREEN, "Vous venez de payer $1,000, vous n'avez plus de PV.");
	pInfo[playerid][pvtime]=0;
	GivePlayerMoney(playerid, -1000);
	ResetWanted(playerid);
	return 1;
}

cmd:suspect(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(!IsPlayerCops(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça si vous n'êtes pas policier !");

	new ID, reason[128];
	if(sscanf(params, "us[128]", ID, reason))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /suspect (Pseudo/ID) (Raison)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas connecté !");

	if(!IsPlayerCrimi(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas suspecter un civil/policier !");

	if(!IsCanAction(ID)&&!pInfo[ID][cuffed])
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action sur ce joueur maintenant !");

	if(pInfo[ID][lastsuspect]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur a déjà été suspecté par quelqu'un récemment !");

	if(GetDistanceBetweenPlayers(playerid, ID) > 7)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est trop loin !");

	new msg[144];
	format(msg, sizeof(msg), "L'officier de police %s(%d) vient de suspecter %s(%d). Raison: %s", pInfo[playerid][name], playerid, pInfo[ID][name], ID, reason);
	SendClientMessageToAllCops(COLOR_BLUECOPS, msg);
	format(msg, sizeof(msg), "Le policier %s(%d) vient de vous suspecter, raison: %s", pInfo[playerid][name], playerid, reason);
	SendClientMessage(ID, COLOR_YELLOW, msg);
	pInfo[ID][lastsuspect]=gettime()+100;
	AddWanted(ID, 2);
	return 1;
}

cmd:cassmen(playerid, params[])
{
	if(pInfo[playerid][lastcassmen]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà tenté de casser vos menottez récemment, attendez un peu !");

	if(!pInfo[playerid][cuffed])
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas menotté, vous ne pouvez pas faire ça !");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous êtes détenu, vous ne pouvez pas faire ça !");

    pInfo[playerid][lastcassmen]=gettime()+30;
    new msg[144];
    if(!pChances(playerid, 27)) {
        AddWanted(playerid, 2);
        SendClientMessage(playerid, COLOR_ERROR, "Tentative de cassage de menotte échouée, vous gagnez deux étoiles de recherche !");
		format(msg, sizeof(msg), "Le suspect %s(%d) vient de tenter de casser ses menottes !", pInfo[playerid][name], playerid);
		SendClientMessageToAllCops(COLOR_BLUECOPS, msg);
	}

	pInfo[playerid][cuffed]=false;
	pInfo[playerid][mentime]=0;
 	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid,0);
 	StopLoopingAnim(playerid);
	AddWanted(playerid, 3);
	SendClientMessage(playerid, COLOR_GREEN, "Vous avez réussi a casser vos menottes, courrez !");
	format(msg, sizeof(msg), "Le suspect %s(%d) a réussi a casser ses menottes, arrêtez-le !");
	SendClientMessageToAllCops(COLOR_BLUECOPS, msg);
	return 1;
}

cmd:fouiller(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(!IsPlayerCops(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça si vous n'êtes pas policier !");

	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /fouiller (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas connecté !");

	if(!pInfo[ID][cuffed])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas menotté, vous ne pouvez pas lui donner de PV !");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action depuis un véhicule!");

	if(IsPlayerInAnyVehicle(ID))
		return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action sur un joueur dans un véhicule!");

	if(GetDistanceBetweenPlayers(playerid, ID) > 4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est trop loin !");

	new bool:a=false, msg[144];
	if(!pChances(ID, 20)) {
		a=true;
		AddWanted(ID, 3);
	}
	if(a) {
		format(msg, sizeof(msg), "Vous venez de trouver de l'héroïne et de la weed sur %s(%d), %s !", pInfo[ID][name], ID, (pInfo[ID][wanted]>=4) ? ("envoyez-le en prison !") : ("donnez lui un PV via /pv ."));
		SendClientMessage(playerid, COLOR_LIGHTBLUE, msg);
		format(msg, sizeof(msg), "Le policier %s(%d) vient de trouver des sachets d'héroïne et de la weed sur vous !", pInfo[playerid][name], playerid);
		SendClientMessage(ID, COLOR_LIGHTBLUE, msg);
	}
	else {
		format(msg, sizeof(msg), "Vous avez fouillé %s(%d) et vous n'avez rien trouvé sur lui.", pInfo[ID][name], ID, (pInfo[ID][wanted]>=4) ? ("envoyez-le en prison !") : ("donnez lui un PV via /pv ."));
		SendClientMessage(playerid, COLOR_LIGHTBLUE, msg);
		format(msg, sizeof(msg), "Le policier %s(%d) vient de vous fouiller et n'a rien trouvé sur vous.", pInfo[playerid][name], playerid);
		SendClientMessage(ID, COLOR_LIGHTBLUE, msg);
	}
	return 1;
}

cmd:eject(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer ça maintenant !");

	new vid=GetPlayerVehicleID(playerid);
	if(vid==INVALID_VEHICLE_ID)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas éjecter les joueurs si vous n'êtes pas dans un véhicule !");

	if(GetPlayerVehicleSeat(playerid)!=0)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas éjecter les joueurs si vous n'êtes pas conducteur !");

	for(new i=0;i<MAX_PLAYERS;i++)
	{
	    if(GetPlayerVehicleID(i)==vid&&i!=playerid) {
			RemovePlayerFromVehicle(i);
	      	GameTextForPlayer(i, "~b~Vous vous êtes fait žjectž !", 3000, 3);
	    }
	}
	return 1;
}

cmd:detenir(playerid, params[])
{
	if(!IsPlayerCops(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas arrêter un joueur si vous n'êtes pas policier !");

	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /detenir (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas connecté.");

	if(!pInfo[ID][cuffed])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas menotté, vous ne pouvez pas le détenir !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action depuis un véhicule !");

	if(IsPlayerInAnyVehicle(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action si le joueur est un véhicule ! /eject pour l'éjecter !");

	if(pInfo[ID][wanted]<4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas assez recherché pour que vous puissiez faire ça !");

	if(!IsValidVehicle(pInfo[ID][last_vehicle]))
		return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être entré dans un véhicule pour pouvoir détenir !");

	if(GetDistanceBetweenPlayers(playerid, ID) > 4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est trop loin !");

	new msg[128];
  	format(msg, sizeof(msg), "L'officier de police %s(%d) vient de vous détenir dans son véhicule !", pInfo[playerid][name], playerid);
	SendClientMessage(ID, COLOR_YELLOW, msg);
	pInfo[ID][mentime]=160;
	format(msg, sizeof(msg), "Vous avez mit le criminel %s(%d) dans votre véhicule, amenez le en prison !", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, msg);
	PutPlayerInVehicle(ID, pInfo[playerid][last_vehicle], 1);
	return 1;
}

cmd:livrer(playerid, params[])
{
	if(!IsPlayerCops(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas livrer un joueur si vous n'êtes pas policier !");

	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /livrer (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas connecté.");

	if(!pInfo[ID][cuffed])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas détenu, vous ne pouvez pas le livrer !");

	if(!IsPlayerInAnyVehicle(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas dans un véhicule, utilisez /ar pour l'arrêter !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(GetPlayerVehicleID(playerid)!=GetPlayerVehicleID(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans le même véhicule que le joueur !");

	if(pInfo[ID][wanted]<4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas assez recherché pour que vous puissiez faire ça !");

	if(GetPlayerCheckpoint(playerid, 3.5)!=CP_PRISON)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans le checkpoint de la prison pour faire ça !");

	new msg[128];
    pInfo[ID][cuffed]=false;
 	SetPlayerSpecialAction(ID,SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(ID,0);
 	StopLoopingAnim(ID);
    TogglePlayerControllable(ID, 1);
  	format(msg, sizeof(msg), "L'officier de police %s(%d) vient de vous livrer en prison ! Tous vos C4 et toute vos armes ont été confisquées !", pInfo[playerid][name], playerid);
	SendClientMessage(ID, COLOR_YELLOW, msg);
	new money=random(pInfo[ID][wanted]*375);
	format(msg, sizeof(msg), "Vous avez mit le criminel %s(%d) en prison, vous venez de gagner %s !", pInfo[ID][name], ID, FormatMoney(money));
	GivePlayerMoney(playerid, money);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, msg);
    pInv[ID][C4]=0;
    pInfo[ID][jailtime]=pInfo[ID][wanted]*6;
    ResetPlayerWeapons(ID);
    ResetWanted(ID);
 	for(new i=0;i<47;i++)
		PlayerWeapons[ID][i]=false;
	new rnd = random(sizeof(JailPos));
	SetPlayerInterior(ID,10);
	SetPlayerPos(ID,JailPos[rnd][0],JailPos[rnd][1],JailPos[rnd][2]);
	SetPlayerFacingAngle(ID,JailPos[rnd][3]);
	pInfo[playerid][policeprogress]+=15;
	if(pInfo[playerid][policeprogress]>=100) {
		new str[144];
		pInfo[playerid][policelvl]++;
		pInfo[playerid][policeprogress]=0;
		format(str, sizeof(str), "Vous avez monté de niveau policier ! Vous êtes maintenant au niveau %d !", pInfo[playerid][policelvl]);
		SendClientMessage(playerid, COLOR_GREEN, str);
	}
	return 1;
}

cmd:ar(playerid, params[])
{
	if(!IsPlayerCops(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas arrêter un joueur si vous n'êtes pas policier !");

	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /ar (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas connecté.");

	if(!pInfo[ID][cuffed])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas menotté, vous ne pouvez pas l'arrêter !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action depuis un véhicule !");

	if(IsPlayerInAnyVehicle(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action si le joueur est un véhicule ! /eject pour l'éjecter !");

	if(GetDistanceBetweenPlayers(playerid, ID) > 4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est trop loin !");

	if(pInfo[ID][wanted]<4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas assez recherché pour que vous puissiez faire ça !");

	new msg[128];
    pInfo[ID][cuffed]=false;
 	SetPlayerSpecialAction(ID,SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(ID,0);
 	StopLoopingAnim(ID);
    TogglePlayerControllable(ID, 1);
  	format(msg, sizeof(msg), "L'officier de police %s(%d) vient de vous mettre en prison ! Tous vos C4 et cordes ont été confisqués !", pInfo[playerid][name], playerid);
	SendClientMessage(ID, COLOR_YELLOW, msg);
	new money=random(pInfo[ID][wanted]*275);
	format(msg, sizeof(msg), "Vous avez mit le criminel %s(%d) en prison, vous venez de gagner %s !", pInfo[ID][name], ID, FormatMoney(money));
	GivePlayerMoney(playerid, money);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, msg);
    pInv[ID][C4]=0;
    pInv[ID][ROPES]=0;
    pInfo[ID][jailtime]=pInfo[ID][wanted]*6;
    pInfo[playerid][mentime]=0;
    ResetWanted(ID);
	new rnd = random(sizeof(JailPos));
	SetPlayerInterior(ID,10);
	SetPlayerPos(ID,JailPos[rnd][0],JailPos[rnd][1],JailPos[rnd][2]);
	SetPlayerFacingAngle(ID,JailPos[rnd][3]);
	pInfo[playerid][policeprogress]+=15;
	if(pInfo[playerid][policeprogress]>=100) {
		new str[144];
		pInfo[playerid][policelvl]++;
		pInfo[playerid][policeprogress]=0;
		format(str, sizeof(str), "Vous avez monté de niveau policier ! Vous êtes maintenant au niveau %d !", pInfo[playerid][policelvl]);
		SendClientMessage(playerid, COLOR_GREEN, str);
	}
	return 1;
}

cmd:demen(playerid, params[])
{
	if(!IsPlayerCops(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas dé-menotter si vous n'êtes pas policier !");

	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /men (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas connecté.");

	if(!pInfo[ID][cuffed])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas menotté !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action dans un véhicule!");

	if(IsPlayerInAnyVehicle(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action sur un joueur dans un véhicule!");


	if(GetDistanceBetweenPlayers(playerid, ID) > 4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est trop loin !");

	new msg[128];
	format(msg, sizeof(msg), "L'officier de police %s(%d) vient de vous dé-menotter, vous êtes libre !", pInfo[playerid][name], playerid);
	SendClientMessage(ID, COLOR_LIGHTBLUE, msg);
	format(msg, sizeof(msg), "Vous venez de dé-menotter %s(%d), il est maintenant libre!", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, msg);
	TogglePlayerControllable(ID, 1);
	pInfo[ID][cuffed] =false;
	pInfo[ID][mentime] =0;
 	SetPlayerSpecialAction(ID,SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(ID,0);
 	StopLoopingAnim(ID);
	return 1;
}

cmd:violer(playerid, params[])
{
	if(!IsPlayerCrimi(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça si vous n'êtes pas criminel !");
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /violer (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas connecté.");

	if(GetDistanceBetweenPlayers(playerid, ID) > 4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est trop loin !");

	if(playerid == ID)
		return SendClientMessage(playerid,COLOR_ERROR,"C'est idiot, vous ne pouvez pas vous violer vous-même !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action dans un véhicule!");

	if(!IsCanAction(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action sur ce joueur maintenant !");

	if(IsPlayerInAnyVehicle(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action sur un joueur dans un véhicule!");

	if(pInfo[playerid][lastviol]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà violé/tenté de violer quelqu'un récemment, attendez un peu!");

	if(pInfo[ID][lastvioled]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur a déjà été violé récemment, attendez un peu!");

    pInfo[playerid][lastviol]=gettime()+120;
 	if(!Chances((GetCompetence(playerid, 1)==1) ? (20) : (30))) {
	    AddWanted(playerid, 2);
	    return SendClientMessage(playerid, COLOR_ERROR, "Viol échoué !");
	}

	new string[128];
	format(string,sizeof(string),"Vous avez attrapé %s(%d) est vous l'avez violé!", pInfo[ID][name], ID);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	format(string,sizeof(string),"Vous avez été violé par %s(%d), vengez-vous et tuez-le !", pInfo[playerid][name], playerid);
	SendClientMessage(ID,COLOR_LIGHTBLUE,string);
	SetDM(ID, playerid, true);
	AddScore(playerid, 1);
	if(IsPlayerCops(ID)) {
		SendClientMessage(playerid, COLOR_YELLOW, "Vous avez violé un policier, vous venez de gagner deux étoiles de recherche de plus que la normale !");
		AddWanted(playerid, 6);
		AddScore(playerid, 1);
	}
	else AddWanted(playerid, 4);
	if(pInfo[playerid][MST]) {
		pInfo[ID][MST]=true;
		SendClientMessage(ID, COLOR_RED, "Vous avez attrapé une mst, allez vite vous soigner !");
		AddScore(playerid, 1);
	}
	else if(!pChances(ID, 30)) {
		pInfo[ID][MST]=true;
		SendClientMessage(ID, COLOR_RED, "Vous avez attrapé une mst, allez vite vous soigner !");
		AddScore(playerid, 1);
	}
 	format(string, sizeof(string), "~h~~g~Vous avez violž ~h~~y~%s ~n~~w~ ~h~~w~", pInfo[ID][name],ID);
	GameTextForPlayer(playerid, string, 3000, 3);
 	format(string,sizeof(string), "~h~~y~%s ~h~~w~vous a violž ~n~~h~~g~", pInfo[playerid][name]);
	GameTextForPlayer(ID, string, 3000, 3);
    format(string, sizeof(string), "[RADIO] Le suspect %s(%d) a violé %s(%d), interpellez-le !", pInfo[playerid][name], playerid, pInfo[ID][name], ID);
    SendClientMessageToAllCops(COLOR_BLUECOPS, string);
	return 1;
}

cmd:kidnap(playerid, params[])
{
	if(pInfo[playerid][TEAM]!=TEAM_KIDNAP)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être kidnappeur pour kidnapper les joueurs!");

	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /kidnap (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas connecté.");

	if(GetDistanceBetweenPlayers(playerid, ID) > 4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est trop loin !");

	if(pInfo[ID][kidnapped])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est déjà kidnappé!");

	if(pInfo[ID][cuffed])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est menotté, vous ne pouvez pas le kidnapper!");

	if(playerid == ID)
		return SendClientMessage(playerid,COLOR_ERROR,"C'est idiot, vous ne pouvez pas vous kidnapper vous-même !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action dans un véhicule!");

	if(!IsCanAction(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action sur ce joueur maintenant !");

	if(IsPlayerInAnyVehicle(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action sur un joueur dans un véhicule!");

	if(pInfo[playerid][lastkidnap]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà kidnappé/tenté de kidnapper quelqu'un récemment, attendez un peu!");

	if(pInfo[ID][lastkidnapped]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur a déjà été kidnappé récemment, attendez un peu!");

	if(!IsValidVehicle(pInfo[playerid][last_vehicle]))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être entré dans un véhicule avant de kidnapper quelqu'un!");

	if(pInv[playerid][ROPES]<=0)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'avez aucune cordes pour kidnapper sur vous !");

    pInfo[playerid][lastkidnap]=gettime()+120;
 	if(!pChances(playerid, 30)) {
	    AddWanted(playerid, 2);
	    return SendClientMessage(playerid, COLOR_ERROR, "Tentative de kidnapping échouée!");
	}

	SetPlayerInterior(ID, 0);
	PutPlayerInVehicle(ID, pInfo[playerid][last_vehicle], 1);
 	pInfo[ID][lastkidnapped]=gettime()+135;
 	pInfo[ID][kidnappedtime]=140;
 	pInfo[ID][kidnapped]=true;
    SetDM(ID, playerid, true);
    SetPlayerInterior(ID, 0);
	TogglePlayerControllable(ID, 0);

	new string[128];
 	format(string, sizeof(string), "~h~~g~Vous avez kidnappž ~h~~y~%s ~n~~w~ ~h~~w~", pInfo[ID][name],ID);
	GameTextForPlayer(playerid, string, 3000, 3);
 	format(string,sizeof(string), "~h~~y~%s ~h~~w~vous a kidnappž ~n~~h~~g~", pInfo[playerid][name]);
	GameTextForPlayer(ID, string, 3000, 3);
	format(string, sizeof(string), "%s(%d) vous a kidnappé ! Si vous avez une paire de ciseaux, faites /coupercorde !", pInfo[playerid][name], playerid);
	SendClientMessage(ID, COLOR_YELLOW, string);
	format(string, sizeof(string), "Vous avez kidnappé %s(%d)  !", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_YELLOW, string);
	if(IsPlayerCops(ID)) {
		SendClientMessage(playerid, COLOR_YELLOW, "Vous avez kidnappé un policier, vous venez de gagner deux étoiles de recherche de plus que la normale !");
		AddScore(playerid, 1);
		AddWanted(playerid, 6);
	}
	else AddWanted(playerid, 4);

	AddScore(playerid, 1);
	pInv[playerid][ROPES]--;
    format(string, sizeof(string), "[RADIO] Le suspect %s(%d) a kidnappé %s(%d), interpellez-le !", pInfo[playerid][name], playerid);
    SendClientMessageToAllCops(COLOR_BLUECOPS, string);
	return 1;
}

cmd:suicide(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas vous suicider maintenant !");

	if(pInfo[playerid][wanted]>=4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous êtes trop recherché pour faire ça !");

	if(pInfo[playerid][wanted]==0) {
	    AddScore(playerid, -1);
	    SetPlayerHealth(playerid, 0);
	}
	else if(pInfo[playerid][wanted]<4) {
	    AddScore(playerid, -pInfo[playerid][wanted]);
	    SetPlayerHealth(playerid, 0);
	    SendClientMessage(playerid, COLOR_PINK, "Vous avez perdu autant de score que d'étoiles de recherche que vous aviez !");
	}
	else SendClientMessage(playerid, COLOR_ERROR, "Vous êtes trop recherché pour faire ça !");
	return 1;
}

cmd:detach(playerid, params[])
{
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /detach (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas connecté.");

	if(GetDistanceBetweenPlayers(playerid, ID) > 4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est trop loin !");

	if(!pInfo[ID][kidnapped])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas kidnappé!");

	if(playerid == ID)
		return SendClientMessage(playerid,COLOR_ERROR,"C'est idiot, vous ne pouvez pas vous détacher vous-même !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	TogglePlayerControllable(ID, 1);
 	pInfo[ID][kidnappedtime]=0;
	new msg[128];
	format(msg, sizeof(msg), "Vous avez été détaché par %s(%d), fuyez !", pInfo[playerid][name], playerid);
	SendClientMessage(ID, COLOR_GREEN, msg);
	format(msg, sizeof(msg), "Vous avez détaché %s(%d), il est libre !", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	if(!GetSuccess(playerid, 4)) SetSuccess(playerid, 4, true);
	else pInfo[playerid][totaldetach]++;
	if(pInfo[playerid][totaldetach]>=20&&!GetSuccess(playerid, 5)) SetSuccess(playerid, 5, true);
	return 1;
}

cmd:saucisse(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(pInv[playerid][saucisses]<=0)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'avez pas de saucisses, vous pouvez en acheter au 24/7 !");

    GetPlayerHealth(playerid, pInfo[playerid][hp]);
	SetPlayerHealth(playerid, floatadd(pInfo[playerid][hp], 30.5));
    PlayerPlaySound(playerid, 17802,0.0,0.0,0.0);
    pInv[playerid][saucisses]--;
    ApplyAnimation(playerid,"FOOD","EAT_Burger",4.1,0,1,1,0,1000,1);
	return 1;
}

cmd:coupercorde(playerid, params[])
{
	if(!pInfo[playerid][spawned])
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(!pInv[playerid][scissors])
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'avez pas de ciseaux, vous pouvez en acheter au 24/7 !");

	if(!pInfo[playerid][kidnapped])
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas kidnappé!");

	TogglePlayerControllable(playerid, 1);
 	pInfo[playerid][kidnappedtime]=0;
 	pInv[playerid][scissors]=false;
	SendClientMessage(playerid, COLOR_GREEN, "Vous avez coupé votre corde, vous pouvez fuir !");
	return 1;
}

stock GetPriceWithModel(modelid)
{
	if(modelid==522) modelid-=100;
	if(modelid<460) modelid+=40;
	else modelid-=100;
	return modelid*modelid;
}

cmd:vendrev(playerid, params[])
{
	if(pInfo[playerid][TEAM]!=TEAM_VOLEUR)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça si vous n'êtes pas voleur !");

	if(GetPlayerCheckpoint(playerid, 5)!=CP_VENDREV)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça si vous n'êtes pas dans le checkpoint pour vendre un véhicule !");

	if(!IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans un véhicule !");

	if(!vInfo[GetPlayerVehicleID(playerid)][stolen])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce véhicule n'est pas volé, vous ne pouvez pas le vendre !");

	new vehicleid=GetPlayerVehicleID(playerid);
	new msg[128], model=GetVehicleModel(vehicleid);
	new amount=GetPriceWithModel(model)-50000;
	DestroyVehicle(vehicleid);
	DeleteVehicleStats(vehicleid);
	vInfo[vehicleid][UID]=-1;
	vInfo[vehicleid][P_UID]=-1;
	vInfo[vehicleid][assured]=false;
	vInfo[vehicleid][destroyed]=false;
	GivePlayerMoney(playerid, amount);
	format(msg, sizeof(msg), "Vous avez vendu un(e) %s pour le prix de %s !", VehicleNames[model-400], FormatMoney(amount));
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:voleratm(playerid, params[])
{
	if(pInfo[playerid][TEAM]!=TEAM_VOLEUR)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça si vous n'êtes pas voleur !");

	new cp=GetPlayerCheckpoint(playerid);
	if(cp!=CP_ATM1&&cp!=CP_ATM2&&cp!=CP_ATM3&&cp!=CP_ATM4&&cp!=CP_ATM5)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans un checkpoint d'ATM !");

	if(pInfo[playerid][lastrobatm]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà volé un ATM récemment, attendez un tout petit peu !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action dans un véhicule!");

	if(cLastRob[cp]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Cet ATM a déjà été volé récemment !");

    pInfo[playerid][lastrobatm]=gettime()+45;
	if(!pChances(30)) {
	    AddWanted(playerid, 2);
	    return SendClientMessage(playerid, COLOR_ERROR, "Tentative de vol échouée, la police a été prévenue !");
	}
    pInfo[playerid][lastrobatm]+=45;
    cLastRob[cp]=gettime()+160;
 	new rand=random(30);
	if(GetCompetence(playerid, 1)==0) while(rand < 29) rand=random(39);
	else while(rand < 25) rand=random(35);
	pInfo[playerid][robatm]=rand;
	new string[128];
    format(string, sizeof(string), "[RADIO] Le suspect %s(%d) a commencé un vol dans un ATM, interpellez-le !", pInfo[playerid][name], playerid);
    SendClientMessageToAllCops(COLOR_BLUECOPS, string);
	return 1;
}

cmd:volerlieu(playerid, params[])
{
	if(!IsPlayerCrimi(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça si vous n'êtes pas criminel !");

	new cp=GetPlayerCheckpoint(playerid);
	if(cp==-1)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans un checkpoint de lieu volable !");

	if(!CanBeRobbed(cp))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas voler cet endroit !");

	if(pInfo[playerid][lastlrob]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà volé un lieu récemment, attendez un tout petit peu !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action dans un véhicule!");

	if(cLastRob[cp]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce lieu a déjà été volé récemment !");

	switch(cp)
	{
	    case CP_BOMBSHOP, CP_AMMUNATION: if(pInfo[playerid][roblvl]<10)
	        return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être au minimum un voleur de niveau 10 pour pouvoir voler ce lieu !");
	    case CP_VOLERBANQUE: if(pInfo[playerid][roblvl]<20)
	        return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être au minimum un voleur de niveau 20 pour pouvoir voler ce lieu !");
		case CP_BUYVEH:if(pInfo[playerid][roblvl]<5)
	        return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être au minimum un voleur de niveau 5 pour pouvoir voler ce lieu !");
	}

	pInfo[playerid][lastlrob]=gettime()+35;

 	if(!pChances(30)) {
	    AddWanted(playerid, 2);
	    return SendClientMessage(playerid, COLOR_ERROR, "Tentative de vol échouée, la police a été prévenue !");
	}

	pInfo[playerid][lastlrob]+=55;
	new rand=random(30);
	if(GetCompetence(playerid, 1)==0) while(rand < 20) rand=random(30);
	else while(rand < 18) rand=random(28);
	if(cp!=CP_VOLERBANQUE)
		cLastRob[GetPlayerCheckpoint(playerid)]=gettime()+132;
	else cLastRob[cp]=gettime()+300;
    pInfo[playerid][lrob]=(cp!=CP_VOLERBANQUE) ? (rand) : (rand+15);
    SendClientMessage(playerid, COLOR_GREEN, "Vol commencé, la police a été prévenue!");
	AddScore(playerid, 1);
	AddWanted(playerid, 3);
	new string[128];
    format(string, sizeof(string), "[RADIO] Le suspect %s(%d) a commencé un vol %s, interpellez-le !", pInfo[playerid][name], playerid, cName[GetPlayerCheckpoint(playerid)]);
    SendClientMessageToAllCops(COLOR_BLUECOPS, string);
	return 1;
}

cmd:stats(playerid, params[])
{
	new dialog[1024], pid=playerid;
	if(sscanf(params, "u", pid)) pid=playerid;
	if(!IsPlayerConnected(pid))
		return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas connecté !");
	format(dialog, sizeof(dialog),
	"Niveau voleur: {FFFFFF}%d - {A9C4E4}Niveau terroriste: {FFFFFF}%d\nNiveau policier: {FFFFFF}%d\n{A9C4E4}Argent: {FFFFFF}%s{A9C4E4} - En banque:{FFFFFF} %s\n{A9C4E4}Total de kills: {FFFFFF}%d {A9C4E4}- Dans cette partie: {FFFFFF}%d\n{A9C4E4}Total de morts: {FFFFFF}%d {A9C4E4}- Dans cette partie: {FFFFFF}%d",
	pInfo[pid][roblvl], pInfo[pid][terrolvl], pInfo[pid][policelvl], FormatMoney(GetPlayerMoney(pid)), FormatMoney(pInv[pid][BANK_CASH]),
	pInfo[pid][kills], pInfo[pid][kill], pInfo[pid][deaths], pInfo[pid][death]);
	ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Statistiques", dialog, "OK", "");
	return 1;
}

cmd:voler(playerid, params[])
{
	if(pInfo[playerid][TEAM]!=TEAM_VOLEUR)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être voleur pour voler les joueurs!");

	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /voler (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Le joueur n'est pas connecté.");

	if(GetDistanceBetweenPlayers(playerid, ID) > 4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est trop loin !");

	if(GetPlayerMoney(ID)<=0)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'a pas d'argent sur lui!");

	if(playerid == ID)
		return SendClientMessage(playerid,COLOR_ERROR,"C'est idiot, vous ne pouvez pas vous voler vous-même, mais bien éssayé !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action maintenant !");

	if(IsPlayerInAnyVehicle(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action dans un véhicule!");

	if(!IsCanAction(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action sur ce joueur maintenant !");

	if(IsPlayerInAnyVehicle(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas effectuer cette action sur un joueur dans un véhicule!");

	if(pInfo[playerid][lastrob]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà volé/tenté de voler quelqu'un récemment, attendez un peu!");

	if(pInfo[ID][lastrobbed]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur a déjà été volé récemment, attendez un peu!");

 	pInfo[playerid][lastrob]=gettime()+120;
    AddWanted(playerid, 2);

 	if(!Chances(30)) {
	    AddWanted(playerid, 2);
	    return SendClientMessage(playerid, COLOR_ERROR, "Tentative de vol échouée!");
	}
	new rand=random(4), money=0;
	new Float:maxvalue=GetPlayerMoney(ID);
	if(maxvalue>5000000) maxvalue=floatdiv(maxvalue, 2.8);
	else if(maxvalue>1000000) maxvalue=floatdiv(maxvalue, 2.5);
	else if(maxvalue>700000) maxvalue=floatdiv(maxvalue, 2.2);
	else if(maxvalue>500000) maxvalue=floatdiv(maxvalue, 2);
	else if(maxvalue>300000) maxvalue=floatdiv(maxvalue, 1.7);
	else if(maxvalue>100000) maxvalue=floatdiv(maxvalue, 1.5);
	else if(maxvalue>70000) maxvalue=floatdiv(maxvalue, 1.3);
	else if(maxvalue>50000) maxvalue=floatdiv(maxvalue, 1.1);
	switch(rand)
	{
	    case 0:money=random(floatround(floatdiv(maxvalue, 3.0)));
	    case 1,2:money=random(floatround(floatdiv(maxvalue, 2.2)));
	    case 3:money=random(floatround(floatdiv(maxvalue, 1.2)));
	}
	GivePlayerMoney(ID, -money);
	GivePlayerMoney(playerid, money);
	new string[128];
 	format(string, sizeof(string), "~h~~g~Vous avez volž ~h~~y~%s ~n~~w~€ ~h~~w~%s", FormatMoney(money), pInfo[ID][name],ID);
	GameTextForPlayer(playerid, string, 3000, 3);
 	format(string,sizeof(string), "~h~~y~%s ~h~~w~vous a volž ~n~~h~~g~%s", pInfo[playerid][name], FormatMoney(money));
	GameTextForPlayer(ID, string, 3000, 3);
	format(string,sizeof(string),"Vous venez de voler %s à %s(%d). ", FormatMoney(money),pInfo[ID][name], ID);
 	SendClientMessage(playerid,COLOR_GREEN,string);
	format(string,sizeof(string),"Vous venez de vous faire voler %s par %s(%d). ", FormatMoney(money),pInfo[playerid][name],playerid);
 	SendClientMessage(ID,COLOR_RED,string);
  	pInfo[ID][lastrobbed]=gettime()+160;
    SetDM(ID, playerid, true);
	if(IsPlayerCops(ID)) {
		SendClientMessage(playerid, COLOR_YELLOW, "Vous avez volé un policier, vous venez de gagner deux étoiles de recherche de plus que la normale !");
		AddWanted(playerid, 6);
		AddScore(playerid, 1);
	}
	else AddWanted(playerid, 4);
    AddScore(playerid, 1);
    if(!GetSuccess(playerid, 1)) SetSuccess(playerid, 1, true);
    format(string, sizeof(string), "[RADIO] Le suspect %s(%d) a volé %s à %s(%d), interpellez-le !", pInfo[playerid][name], playerid, FormatMoney(money), pInfo[ID][name], ID);
    SendClientMessageToAllCops(COLOR_BLUECOPS, string);
 	pInfo[playerid][robprogress]+=15;
	if(pInfo[playerid][robprogress]>=100) {
		pInfo[playerid][roblvl]++;
		pInfo[playerid][robprogress]=0;
		format(string, sizeof(string), "Vous avez monté de niveau voleur ! Vous êtes maintenant au niveau %d !", pInfo[playerid][roblvl]);
		SendClientMessage(playerid, COLOR_GREEN, string);
	}
	return 1;
}

cmd:cmds(playerid,params[])
{
	if(!pInfo[playerid][spawned])
 		return SendClientMessage(playerid,COLOR_ERROR,"Vous devez être Spawn pour utiliser cette commande");

	new dialog[1024], title[120]="COMMANDES";
	switch(pInfo[playerid][TEAM])
	{
	    case TEAM_VOLEUR:
	    {
	        strcat(title, "- VOLEUR / CARJACKEUR");
	        format(dialog, sizeof(dialog), "{FF0000}/voler{A9C4E4} - Voler un joueur.\n{FF0000}/voleratm{A9C4E4} - Voler un ATM.\n{FF0000}/vendrev{A9C4E4} - Vendre un véhicule volé");
	    }
	    case TEAM_KIDNAP:
	    {
	        strcat(title, "- KIDNAPPEUR");
	        format(dialog, sizeof(dialog), "{FF0000}/kidnap{A9C4E4} - Kidnapper un joueur.");
	    }
	    case TEAM_TERRO:
	    {
	        strcat(title, "- TERRORISTE");
	        format(dialog, sizeof(dialog), "{FF0000}/explcaisse{A9C4E4} - Exploser un véhicule.\n{FF0000}/exploser{A9C4E4} - Exploser un lieu");
	    }
	    case TEAM_VIOLEUR:
	    {
	        strcat(title, "- VIOLEUR");
	        format(dialog, sizeof(dialog), "{FF0000}/violer{A9C4E4} - Violer un joueur.");
	    }
	    case TEAM_HITMAN:
	    {
	        strcat(title, "- MERCENAIRE");
	        format(dialog, sizeof(dialog), "{FF0000}/listhit{A9C4E4} OU {FF0000}/hitlist{A9C4E4} - Afficher la liste des contrats.");
	    }
	    case TEAM_HACKER:
		{
	        strcat(title, "- HACKER");
	        format(dialog, sizeof(dialog), "{FF0000}/seeid{A9C4E4} - Voir les ID de véhicules (activé par défaut)\n{FF0000}/explveh{A9C4E4} - Exploser un véhicule à distance\n{FF0000}/hackatm{A9C4E4} - Pirater un ATM\n{FF0000}/hackveh{A9C4E4} - Pirater (immobiliser) un véhicule");
	    }
	    case TEAM_COPS:
	    {
	        format(title, sizeof(title), "{1585DF}COMMANDES - POLICIER");
	    }
		case TEAM_SWAT:
		{
	        format(title, sizeof(title), "{1560DB}COMMANDES - S.W.A.T");
		}
		case TEAM_MILITARY:
		{
	        format(title, sizeof(title), "{8000FF}COMMANDES - MILITAIRE");
		}
	}
	if(IsPlayerCops(playerid)) {
		new color[]="{1585DF}";
		if(pInfo[playerid][TEAM]==TEAM_MILITARY) color="{8000FF}";
		if(pInfo[playerid][TEAM]==TEAM_SWAT) color="{1560DB}";
		if(IsPlayerBac(playerid)) color="{09E3BD}";
		format(dialog, sizeof(dialog),
		"%s/men{A9C4E4} - Menotter un joueur.\n%s/demen{A9C4E4} - Dé-menotter un joueur.\n%s/ar{A9C4E4} - Arrêter un joueur.\n%s/detenir{A9C4E4} - Détenir un joueur dans son véhicule.\n%s/livrer{A9C4E4} - Livrer un joueur détenu.\n%s/pv{A9C4E4} - Donner un PV a un joueur.\n%s/fouiller{A9C4E4} - Fouiller un joueur.",
		color, color, color, color, color, color, color);
	}
	if(IsPlayerBac(playerid)) {
		format(title, sizeof(title), "{09E3BD}COMMANDES - BAC");
	}
	format(dialog, sizeof(dialog), "%s\n\n{A9C4E4}Tapez {10F441}/gcmds{A9C4E4} pour voir toutes les commandes accessibles", dialog);
	ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, title, dialog, "OK", "");
	return 1;
}

cmd:gcmds(playerid, params[])
{
	new dialog[2042];
	format(dialog, sizeof(dialog), "{10F441}/cmds{A9C4E4} - Voir les commandes accessible pour votre métier.");
	format(dialog, sizeof(dialog), "%s\n{10F441}/regles{A9C4E4} - Voir les regles", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/pc{A9C4E4} - Voir les règles en ce qui concerne les Deathmatching", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/admin{A9C4E4} - Voir les administrateurs en service", dialog);
	if(IsPlayerCrimi(playerid)) format(dialog, sizeof(dialog), "%s\n{10F441}/violer{A9C4E4} - Violer un joueur", dialog);
	if(IsPlayerCrimi(playerid)) format(dialog, sizeof(dialog), "%s\n{10F441}/violerlieu{A9C4E4} - Voler un lieu", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/coupercorde{A9C4E4} - Couper une corde (lorsque vous êtes kidnappé et avez un ciseaux)", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/detach{A9C4E4} - Détacher un joueur kidnappé", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/acheter{A9C4E4} - Acheter quelque chose au 24/7", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/sac(ados){A9C4E4} - Accèder à votre sac à dos", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/inv(entaire){A9C4E4} - Accèder à votre inventaire", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/suicide{A9C4E4} - Permet de vous suicider", dialog);
	if(IsPlayerCrimi(playerid)) format(dialog, sizeof(dialog), "%s\n{10F441}/placehit{A9C4E4} - Poser un contrat sur la tête d'une personne", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/saucisse{A9C4E4} - Mange de saucisses (vous redonne de la vie)", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/comp(etence){A9C4E4} - Vous permet de gérer vos compétences", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/compinfo{A9C4E4} - Vous permet d'accèder aux informations quant aux compétences", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/succes{A9C4E4} - Affiche la liste des succès que vous avez gagné", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/pm{A9C4E4} - Envoie un PM (Private Message / Message privé) à un joueur", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/rpm{A9C4E4} - Répondre au dernier PM reçu (pas besoin de spécifier le Pseudo/l'ID du joueur)", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/gc{A9C4E4} - Donner de votre argent à un joueur", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/eject{A9C4E4} - Ejecter tous les joueurs (sauf vous) de votre véhicule.", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/gps{A9C4E4} - Localiser vos véhicules qui possèdent un GPS.", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/question{A9C4E4} - Poser une question aux administrateurs en ligne.", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/report{A9C4E4} - Reporter (dénoncer) un joueur pour une entorse aux règles.", dialog);
	if(pInfo[playerid][VIP]) format(dialog, sizeof(dialog), "%s\n{10F441}/afk{A9C4E4} - Entrer/Sortir du mode AFK.", dialog);
	if(IsPlayerCrimi(playerid)) format(dialog, sizeof(dialog), "%s\n{10F441}/paypv{A9C4E4} - Payer un PV.", dialog);
	if(IsPlayerCrimi(playerid)) format(dialog, sizeof(dialog), "%s\n{10F441}/cassmen{A9C4E4} - Tenter de casser vos menottes.", dialog);
	format(dialog, sizeof(dialog), "%s\n{10F441}/stats{A9C4E4} (Pseudo/ID = optionnel) - Voir vos stats/les statistiquess d'un joueur", dialog);

	ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "{10F441}COMMANDES GÉNÉRALES", dialog, "OK", "");
	return 1;
}

cmd:afk(playerid, params[])
{
	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");

	if(!pInfo[playerid][VIP])
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas VIP, vous ne pouvez pas vous mettre AFK !");

	if(pInfo[playerid][afk])
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous êtes maintenant AFK !");
        TogglePlayerControllable(playerid, 1);
	    pInfo[playerid][afk]=false;
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous n'êtes maintenant plus AFK !");
        TogglePlayerControllable(playerid, 0);
        pInfo[playerid][afk]=true;
	}
	return 1;
}

cmd:regles(playerid,params[])
{
 	ShowPlayerDialog(playerid, DIALOG_REGLESMENU, DIALOG_STYLE_LIST, "{FF0000}Règles de CRFR","Règles des classes\nRègles Forces de l'ordre\nRègles des Gangs\nInformations - Système de compétences","Choisir","Fermer");
	return 1;
}

cmd:pc(playerid,params[])
{
	ShowPlayerDialog(playerid,DIALOG_ALL,DIALOG_STYLE_MSGBOX,"{FF0000}Légende",
	"{1585DF}Cette couleur est pour la police\n{FFFFFF}Cette couleur est pour les innocents/civils\n{D0CB04}Cette couleur est pour les suspects\n{E09405}Cette couleur est pour les joueurs recherchés\n{D75906}Cette couleur est pour les joueurs très recherchés\n{C60000}Cette couleur est pour les joueurs extrêmement recherchés","Fermer","");
	return 1;
}

cmd:hitlist(playerid, params[]) return cmd_listhit(playerid, params);
cmd:listhit(playerid, params[])
{
	if(pInfo[playerid][TEAM]!=TEAM_HITMAN)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça si vous n'êtes pas mercenaire !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");

	new msg[128]="";
	SendClientMessage(playerid, COLOR_DARKGREY, "[ LISTE DE CONTRATS ]");
	for(new i=0;i<MAX_PLAYERS;i++) {
		if(pInfo[i][hit]>0) {
			format(msg, sizeof(msg), "%s(%d) - %s. Temps restant: %d secondes", pInfo[i][name], i, FormatMoney(pInfo[i][hitamount]), pInfo[i][hit]);
			SendClientMessage(playerid, COLOR_LIGHTGREY, msg);
		}
	}
	if(strlen(msg)==0) SendClientMessage(playerid, COLOR_LIGHTGREY, "Personne n'a de contrat sur sa tête !");
	return 1;
}

cmd:placehit(playerid, params[])
{
	if(IsPlayerCops(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas poser de contrat en étant policier !");

	if(pInfo[playerid][TEAM]==TEAM_HITMAN)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas poser de contrat en étant mercenaire !");

	if(!IsCanAction(playerid))
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");

	if(pInfo[playerid][hit]>0)
	    return SendClientMessage(playerid, COLOR_ERROR, "Cette personne a déjà un contrat sur la tête, vous ne pouvez pas lui en poser !");

	new amount=0, ID;
	if(sscanf(params, "ii", ID, amount))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /placehit (Pseudo/ID) (Montant)");

	if(!pInfo[ID][spawned])
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas poser de contrat sur une personne morte !");

	if(playerid==ID)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas poser de contrat sur vous-même !");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas connecté !");

	if(amount<1000)
	    return SendClientMessage(playerid, COLOR_ERROR, "Le montant doit être plus grand ou égal à 1000 !");

	pInfo[playerid][hit]=1200;
	pInfo[playerid][hitamount]=amount;
	new msg[128];
	format(msg, sizeof(msg), "%s(%d) a posé un contrat sur %s(%d) du montant de %s !", pInfo[playerid][name], playerid, pInfo[ID][name], ID, FormatMoney(amount));
	SendClientMessageToAll(COLOR_BLUE, msg);
	format(msg, sizeof(msg), "Vous avez posé un contrat de %s sur %s(%d)", FormatMoney(amount), pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:adcmds(playerid, paramas[])
{
	if(pInfo[playerid][admin]==0) return 0;
	new dialog[2064], title[128];
	format(title, sizeof(title), "Commandes Admin - Niveau {10F441}%d", pInfo[playerid][admin]);
	format(dialog, sizeof(dialog), "{10F441}/service{A9C4E4} - Se mettre en service");
	if(pInfo[playerid][admin]>=2) {
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adwanted{A9C4E4} - Modifie le niveau de recherche d'un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/(ad)goto{A9C4E4} - Se téléporte à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/(ad)bring{A9C4E4} - Téléporte un joueur à vous", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/admute{A9C4E4} - Fait taire un joueur pendant un certain temps", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/addemute{A9C4E4} - Ré-autorise un joueur a parler", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adfreeze{A9C4E4} - Freeze (immobilise) un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/addefreeze{A9C4E4} - Dé-freeze un joueur", dialog);
	}
	if(pInfo[playerid][admin]>=3) {
	    format(dialog, sizeof(dialog), "%s\n{10F441}/v{A9C4E4} - Faire apparaître un véhicule.", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/admode{A9C4E4} - Active/Désactive le mode admin", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/advie{A9C4E4} - Met la vie d'un joueur à un certain niveau", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adarmure{A9C4E4} - Met l'armure d'un joueur à un certain niveau", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adkick{A9C4E4} - Exclus un joueur du serveur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adgc{A9C4E4} - Donne de l'argent à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adscore{A9C4E4} - Donne des points de score à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adjail{A9C4E4} - Mettre quelqu'un en prison/Ajouter du temps de jail a un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/addejail{A9C4E4} - Sortir un joueur de prison", dialog);
	    format(dialog, sizeof(dialog), "%s\n\n{10F441}/advip{A9C4E4} - Donne le statut de VIP à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/addevip{A9C4E4} - Enlève le statut de VIP à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/admili{A9C4E4} - Donne le statut de militaire à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/addemili{A9C4E4} - Enlève le statut de militaire à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adgroove{A9C4E4} - Donne le statut de Groove à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/addegroove{A9C4E4} - Enlève le statut de Groove à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adlgroove{A9C4E4} - Donne le statut de Leader Groove à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/addelgroove{A9C4E4} - Enlève le statut de Leader Groove à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adballas{A9C4E4} - Donne le statut de Ballas à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/addeballas{A9C4E4} - Enlève le statut de Ballas à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adlballas{A9C4E4} - Donne le statut de Leader Ballas à un joueur", dialog);
	    format(dialog, sizeof(dialog), "%s\n{10F441}/addelballas{A9C4E4} - Enlève le statut de Leader Ballas à un joueur", dialog);
	}
	if(pInfo[playerid][admin]>=4) {
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adban{A9C4E4} - Banni un joueur définitivement", dialog);
	}
	if(pInfo[playerid][admin]==1337) {
	    format(dialog, sizeof(dialog), "%s\n{10F441}/adsetlevel{A9C4E4} - Modifier le niveau admin d'un joueur", dialog);
	}
	ShowPlayerDialog(playerid, DIALOG_ADCMDS, DIALOG_STYLE_MSGBOX, title, dialog, ">>", "Retour");
	return 1;
}

cmd:advie(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 2;
	new ID, amount;
	if(sscanf(params, "ui", ID, amount))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /advie (Pseudo/ID) (Vie)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(!pInfo[playerid][spawned])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas spawné, vous ne pouvez pas faire ça !");

	if(amount<0) amount=0;

	SetPlayerHealth(ID, amount);
	new msg[128];
	format(msg, sizeof(msg), "Un Administrateur a modifié votre vie, vous avez maintenant %d points de vie.", amount);
	SendClientMessage(ID, COLOR_GREEN, msg);
	format(msg, sizeof(msg), "Vous avez changé la vie de %s(%d), il a maintenant %d points de vie.", pInfo[ID][name], ID, amount);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:adarmure(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 2;
	new ID, amount;
	if(sscanf(params, "ui", ID, amount))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /adarmure (Pseudo/ID) (Vie)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(!pInfo[playerid][spawned])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas spawné, vous ne pouvez pas faire ça !");

	if(amount<0) amount=0;

	SetPlayerArmour(ID, amount);
	new msg[128];
	format(msg, sizeof(msg), "Un Administrateur a modifié votre armure, vous avez maintenant %d points d'armure.", amount);
	SendClientMessage(ID, COLOR_GREEN, msg);
	format(msg, sizeof(msg), "Vous avez changé l'armure de %s(%d), il a maintenant %d points d'armure.", pInfo[ID][name], ID, amount);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:advip(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /advip (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(pInfo[ID][VIP])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est déjà VIP !");

	new msg[128];
	pInfo[ID][VIP]=true;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a donné le statut de VIP !");
	format(msg, sizeof(msg), "Vous avez donné le statut de VIP à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:addevip(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /addevip (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(!pInfo[ID][VIP])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas VIP !");

	new msg[128];
	pInfo[ID][VIP]=false;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a retiré le statut de VIP !");
	format(msg, sizeof(msg), "Vous avez retiré le statut de VIP à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:admili(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /admili (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(pInfo[ID][military])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est déjà militaire !");

	new msg[128];
	pInfo[ID][military]=true;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a donné le statut de Militaire !");
	format(msg, sizeof(msg), "Vous avez donné le statut de Militaire à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:addemili(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /addemili (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(!pInfo[ID][military])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas militaire !");

	new msg[128];
	pInfo[ID][military]=false;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a retiré le statut Militaire !");
	format(msg, sizeof(msg), "Vous avez retiré le statut de Militaire à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:adgroove(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /adgroove (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(pInfo[ID][groove])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est déjà groove !");

	new msg[128];
	pInfo[ID][groove]=true;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a donné le statut de Groove !");
	format(msg, sizeof(msg), "Vous avez donné le statut de Groove à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:addegroove(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /addegroove (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(!pInfo[ID][groove])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas groove !");

	new msg[128];
	pInfo[ID][groove]=false;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a retiré le statut de Groove !");
	format(msg, sizeof(msg), "Vous avez retiré le statut de Groove à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:adlgroove(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /adlgroove (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(pInfo[ID][leadgroove])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est déjà Leader Groove !");

	new msg[128];
	pInfo[ID][leadgroove]=true;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a donné le statut de Leader Groove !");
	format(msg, sizeof(msg), "Vous avez donné le statut de Leader Groove à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:addelgroove(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /addelgroove (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(!pInfo[ID][leadgroove])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas Leader Groove !");

	new msg[128];
	pInfo[ID][leadgroove]=false;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a retiré le statut de Leader Groove !");
	format(msg, sizeof(msg), "Vous avez retiré le statut de Leader Groove à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}
cmd:adballas(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /adballas (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(pInfo[ID][ballas])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est déjà Ballas !");

	new msg[128];
	pInfo[ID][ballas]=true;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a donné le statut de Ballas !");
	format(msg, sizeof(msg), "Vous avez donné le statut de Ballas à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:addeballas(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /addeballas (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(!pInfo[ID][ballas])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas ballas !");

	new msg[128];
	pInfo[ID][ballas]=false;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a retiré le statut de Ballas !");
	format(msg, sizeof(msg), "Vous avez retiré le statut de Ballas à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:adlballas(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /adlballas (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(pInfo[ID][leadballas])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est déjà Leader Ballas !");

	new msg[128];
	pInfo[ID][leadballas]=true;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a donné le statut de Leader Ballas !");
	format(msg, sizeof(msg), "Vous avez donné le statut de Leader Ballas à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:addelballas(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /addelballas (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(!pInfo[ID][leadballas])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas Leader Ballas !");

	new msg[128];
	pInfo[ID][leadballas]=false;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a retiré le statut de Leader Ballas !");
	format(msg, sizeof(msg), "Vous avez retiré le statut de Leader Ballas à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:adbac(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /adbac (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(pInfo[ID][bac])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est déjà groove !");

	new msg[128];
	pInfo[ID][bac]=true;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a donné le statut de membre de la BAC !");
	format(msg, sizeof(msg), "Vous avez donné le statut de membre de la BAC à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:addebac(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /addebac (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(!pInfo[ID][bac])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas groove !");

	new msg[128];
	pInfo[ID][bac]=false;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a retiré le statut de membre de la BAC !");
	format(msg, sizeof(msg), "Vous avez retiré le statut de membre de la BAC à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:adlbac(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /adlbac (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(pInfo[ID][leadbac])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est déjà Leader de la BAC !");

	new msg[128];
	pInfo[ID][leadbac]=true;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a donné le statut de Leader de la BAC !");
	format(msg, sizeof(msg), "Vous avez donné le statut de Leader de la BAC à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:addelbac(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /addelbac (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(!pInfo[ID][leadbac])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas Leader de la BAC !");

	new msg[128];
	pInfo[ID][leadbac]=false;
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a retiré le statut de Leader de la BAC !");
	format(msg, sizeof(msg), "Vous avez retiré le statut de Leader de la BAC à %s(%d)", pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	return 1;
}

cmd:adjail(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID, time;
	if(sscanf(params, "ui", ID, time))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /adjail (Pseudo/ID) (Temps en secondes)");

	if(time<5||time>60*15)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire taire un joueur plus de 15 minutes ou moins de 5 secondes !");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(!pInfo[ID][spawned])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'a pas encore spawné, vous ne pouvez pas faire ça !");

	new msg[128];
	if(pInfo[ID][jailtime]==0) format(msg, sizeof(msg), "Un Administrateur a mit %s(%d) en jail pour %d secondes.", pInfo[ID][name], ID, time);
	else format(msg, sizeof(msg), "Un Administrateur a prolongé le temps de jail de %s(%d) de %d secondes.", pInfo[ID][name], ID, time);
	SendClientMessageToAll(COLOR_BLUE, msg);
	pInfo[ID][jailtime]+=time;
    ResetPlayerWeapons(ID);
    ResetWanted(ID);
 	for(new i=0;i<47;i++)
		PlayerWeapons[ID][i]=false;
	new rnd = random(sizeof(JailPos));
	SetPlayerInterior(ID,10);
	SetPlayerPos(ID,JailPos[rnd][0],JailPos[rnd][1],JailPos[rnd][2]);
	SetPlayerFacingAngle(ID,JailPos[rnd][3]);

	return 1;
}

cmd:addejail(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /addejail (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(pInfo[ID][jailtime]==0)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas en prison  !");

	new msg[128];
	format(msg, sizeof(msg), "Vous avez sorti %s(%d) de prison !", pInfo[ID][name], ID);
	SendClientMessage(ID, COLOR_GREEN, "Un Administrateur vous a sorti de prison !");
	SendClientMessage(playerid, COLOR_GREEN, msg);
 	pInfo[ID][jailtime]=0;
	SetPlayerHealth(ID,100);
	SetPlayerArmour(ID,0);
	SetPlayerPos(ID,225.8451,112.8976,1003.2188);
	SetPlayerFacingAngle(ID,1.0816);
	SetPlayerInterior(ID,10);
	SetCameraBehindPlayer(ID);
	return 1;
}

cmd:admute(playerid, params[])
{
	if(pInfo[playerid][admin] < 2) return 0;
	new ID, time, reason[128];
	if(sscanf(params, "uiS()[128]", ID, time, reason))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /admute (Pseudo/ID) (Temps en secondes) (Raison = optionnel)");

	if(time<=0||time>=108000)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire taire un joueur plus de 30 minutes !");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(pInfo[ID][mutedtime]>gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est déjà muté !");

	new msg[128];
	format(msg, sizeof(msg), "Un Administrateur a muté %s(%d) pour %d secondes. %s %s", pInfo[ID][name], ID, time, (strlen(reason)!=0) ? ("Raison:") : (""), reason);
	SendClientMessageToAll(COLOR_BLUE, msg);
	pInfo[ID][mutedtime]=gettime()+time;
	return 1;
}

cmd:addemute(playerid, params[])
{
	if(pInfo[playerid][admin] < 2) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /addemute (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(pInfo[ID][mutedtime]<gettime())
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas muté !");

	new msg[128];
	format(msg, sizeof(msg), "Un Administrateur a dé-muté %s(%d), il peut de nouveau parler !", pInfo[ID][name], ID);
	SendClientMessageToAll(COLOR_BLUE, msg);
	pInfo[ID][mutedtime]=0;
	return 1;
}

cmd:adfreeze(playerid, params[])
{
	if(pInfo[playerid][admin] < 2) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /adfreeze (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(pInfo[ID][freeze])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est déjà freeze !");

	new msg[128];
	format(msg, sizeof(msg), "Vous avez freeze %s(%d) !", pInfo[ID][name], ID);
	SendClientMessage(ID, COLOR_YELLOW, "Un Administrateur vous a freeze (immobilisé) !");
	SendClientMessage(playerid, COLOR_GREEN, msg);
	pInfo[ID][freeze]=true;
	TogglePlayerControllable(ID, 0);
	return 1;
}

cmd:addefreeze(playerid, params[])
{
	if(pInfo[playerid][admin] < 2) return 0;
	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /addefreeze (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(!pInfo[ID][freeze])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas freeze !");

	new msg[128];
	format(msg, sizeof(msg), "Vous avez dé-freeze %s(%d) !", pInfo[ID][name], ID);
	SendClientMessage(ID, COLOR_YELLOW, "Un Administrateur vous a dé-freeze !");
	SendClientMessage(playerid, COLOR_GREEN, msg);
	pInfo[ID][freeze]=false;
	TogglePlayerControllable(ID, 1);
	return 1;
}

cmd:adavert(playerid, params[])
{
	if(pInfo[playerid][admin] < 2) return 0;
	new ID, reason[144];
	if(sscanf(params, "uS()[144]", ID, reason))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /adavert (Pseudo/ID) (Raison)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

    pavert(ID, reason);
	return 1;
}

cmd:adkick(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID, reason[144];
	if(sscanf(params, "uS()[144]", ID, reason))
	    return SendClientMessage(playerid, COLOR_ERROR, "Utilisation: /adkick (Pseudo/ID) (Raison = optionnel)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	new msg[128];
	format(msg, sizeof(msg), "Un Administrateur a kické %s(%d) du serveur. %s %s", (strlen(reason)!=0) ? ("Raison:") : (""), pInfo[ID][name], ID, reason);
	SendClientMessageToAll(COLOR_GREEN, msg);
	KickP(ID);
	return 1;
}

cmd:adgmx(playerid, params[])
{
	if(pInfo[playerid][admin] < 5) return 0;
	new duration=5, msg[144];
	if(sscanf(params, "i", duration)) duration=5;
	if(duration<5) return SendClientMessage(playerid, COLOR_ERROR, "Il faut avoir un temps de minimum 5 secondes !");
    SaveStatsTimer();
	SetTimer("RebootTimer", duration*1000, false);
	format(msg, sizeof(msg), "Le serveur va redémarrer dans %d secondes, ne vous déconnectez pas !", duration);
	SendClientMessageToAll(COLOR_YELLOW, msg);
	return 1;
}

cmd:adban(playerid,params[])
{
	if(pInfo[playerid][admin] < 4) return 0;
	new string[144], ID, reason[144];
	if(sscanf(params,"uS()[144]", ID, reason))
		return SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adban (Pseudo/ID) (Raison = optionnel)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté sur le serveur.");

	format(string,sizeof(string),"Un Administrateur a banni %s(%d) du serveur. %s {FF0000}%s.",pInfo[ID],ID,(strlen(reason)!=0) ? ("Raison:") : (""), reason);
	SendClientMessageToAll(COLOR_BLUE, string);
	BanPlayer(ID, reason);
	return 1;
}

cmd:adtempban(playerid,params[])
{
	if(playerid!=-1)//if(pInfo[playerid][admin] < 4)
 		return 0;
	new string[144], ID, time, reason[144];
	if(sscanf(params,"uiS()[144]", ID, time, reason))
		return SendClientMessage(playerid,COLOR_ERROR,"USAGE: /adban (Pseudo/ID) (Temps en minutes) (Raison = optionnel)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté sur le serveur.");

	if(time<=0||time>=36000)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez bannir un joueur que dans un temps situé entre 1 minutes et 10h !");

	format(string,sizeof(string),"Un Administrateur a banni %s(%d) du serveur pendant %d minutes. %s {FF0000}%s.",pInfo[ID],ID, time,(strlen(reason)!=0) ? ("Raison:") : (""), reason);
	SendClientMessageToAll(COLOR_BLUE, string);
	BanPlayer(ID, reason, (gettime()+(time*60)));
	return 1;
}


cmd:adwanted(playerid,params[])
{
	if(pInfo[playerid][admin] < 2) return 0;
	new ID, lvl;
    if(sscanf(params,"ui",ID,lvl))
		return SendClientMessage(playerid,COLOR_ERROR,"Utilisation: /adwanted (Pseudo/ID) (nombre d'étoile(s))");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	AddWanted(ID, lvl);
	new msg[128];
	format(msg, sizeof(msg), "Vous avez ajouté %d étoiles au niveau de recherche de %s(%d). Nouveau niveau de recherche: %d", lvl, pInfo[ID][name], ID, pInfo[ID][wanted]);
	SendClientMessage(playerid, COLOR_GREEN, msg);
	format(msg, sizeof(msg), "Un Administrateur vous a ajouté %d étoiles à votre niveau de recherche. Nouveau niveau de recherche: %d", lvl, pInfo[ID][wanted]);
    SendClientMessage(ID, COLOR_GREEN, msg);
	return 1;
}

cmd:adscore(playerid,params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID, lvl;
    if(sscanf(params,"ui",ID,lvl))
		return SendClientMessage(playerid,COLOR_ERROR,"Utilisation: /adscore (Pseudo/ID) (Score)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	new msg[128];
	AddScore(ID, lvl);
	format(msg, sizeof(msg), "Vous avez ajouté %d au score de %s(%d). Nouveau score: %d", lvl, pInfo[ID][name], ID, GetPlayerScore(ID));
	SendClientMessage(playerid, COLOR_GREEN, msg);
	format(msg, sizeof(msg), "Un Administrateur a ajouté %d à votre score. Votre nouveau score: %d", lvl, GetPlayerScore(ID));
    SendClientMessage(ID, COLOR_GREEN, msg);
	return 1;
}

cmd:givecash(playerid, params[]) return cmd_gc(playerid, params);
cmd:gc(playerid,params[])
{
	new ID, amount;
    if(sscanf(params,"ui",ID,amount))
		return SendClientMessage(playerid,COLOR_ERROR,"Utilisation: /g(ive)c(ash) (Pseudo/ID) (Argent)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	if(GetPlayerMoney(playerid)<amount)
	    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'avez pas autant d'argent à donner !");

	if(playerid==ID)
		return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas vous envoyer un message privé à vous-même !");

	if(amount<=0)
	    return SendClientMessage(playerid, COLOR_ERROR, "Le montant d'argent doit être plus grand que 0 !");

	if(GetDistanceBetweenPlayers(playerid, ID) > 4)
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur est trop loin !");

	GivePlayerMoney(ID, amount);
	GivePlayerMoney(playerid, -amount);
	new msg[128];
	format(msg, sizeof(msg), "Vous avez donné %s à %s(%d). ", FormatMoney(amount), pInfo[ID][name], ID);
	SendClientMessage(playerid, COLOR_DARKYELLOW, msg);
	format(msg, sizeof(msg), "%s(%d) vous a donné %s.", pInfo[playerid][name], ID, FormatMoney(amount));
    SendClientMessage(ID, COLOR_DARKYELLOW, msg);
	return 1;
}

cmd:adgivecash(playerid, params[]) return cmd_adgc(playerid, params);
cmd:adgc(playerid,params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new ID, amount;
    if(sscanf(params,"ui",ID,amount))
		return SendClientMessage(playerid,COLOR_ERROR,"Utilisation: /adgc (Pseudo/ID) (Argent)");

	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	GivePlayerMoney(ID, amount);
	new msg[128];
	format(msg, sizeof(msg), "Vous avez donné %s à %s(%d). Son argent total: %s", FormatMoney(amount), pInfo[ID][name], ID, FormatMoney(GetPlayerMoney(ID)));
	SendClientMessage(playerid, COLOR_GREEN, msg);
	format(msg, sizeof(msg), "Un Administrateur vous a donné %s. Total d'argent: %s", FormatMoney(amount), FormatMoney(GetPlayerMoney(ID)));
    SendClientMessage(ID, COLOR_GREEN, msg);
	return 1;
}

cmd:adgoto(playerid, params[]) return cmd_goto(playerid, params);
cmd:goto(playerid, params[])
{
	if(pInfo[playerid][admin] < 2) return 0;

	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /(ad)goto (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas connecté !");

	if(!pInfo[ID][spawned])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas spawné !");

	new Float:pos[4];
	if(!IsPlayerInAnyVehicle(ID)) {
		GetPlayerPos(ID, pos[0], pos[1], pos[2]);
		GetPlayerFacingAngle(ID, pos[3]);
	}
	else {
		GetVehiclePos(GetPlayerVehicleID(ID), pos[0], pos[1], pos[2]);
		GetVehicleZAngle(ID, pos[3]);
	}
	if(!IsPlayerInAnyVehicle(playerid)) {
		SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		SetPlayerFacingAngle(playerid, pos[3]);
	}
	else {
		SetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), pos[3]);
	}
	SendClientMessage(playerid, COLOR_GREEN, "Vous vous êtes téléporté à un joueur !");
	return 1;
}

cmd:adbring(playerid, params[]) return cmd_bring(playerid, params);
cmd:bring(playerid, params[])
{
	if(pInfo[playerid][admin] < 2) return 0;

	new ID;
	if(sscanf(params, "u", ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /(ad)bring (Pseudo/ID)");

	if(!IsPlayerConnected(ID))
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas connecté !");

	if(!pInfo[ID][spawned])
	    return SendClientMessage(playerid, COLOR_ERROR, "Ce joueur n'est pas spawné !");

	new Float:pos[4];
	if(!IsPlayerInAnyVehicle(playerid)) {
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		GetPlayerFacingAngle(playerid, pos[3]);
	}
	else {
		GetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);
		GetVehicleZAngle(playerid, pos[3]);
	}
	if(!IsPlayerInAnyVehicle(ID)) {
		SetPlayerPos(ID, pos[0], pos[1], pos[2]);
		SetPlayerFacingAngle(ID, pos[3]);
	}
	else {
		SetVehiclePos(GetPlayerVehicleID(ID), pos[0], pos[1], pos[2]);
		SetVehicleZAngle(GetPlayerVehicleID(ID), pos[3]);
	}
	SendClientMessage(playerid, COLOR_GREEN, "Vous avez téléporté un joueur à vous !");
	SendClientMessage(ID, COLOR_GREEN, "Un Admin vous a téléporté à lui !");
	return 1;
}

cmd:adsetlevel(playerid, params[])
{
	if(pInfo[playerid][admin] < 1337) return 0;
	new lvl=0, ID;
	if(sscanf(params, "ui", ID, lvl))
	    return SendClientMessage(playerid, COLOR_ERROR, "Usage: /adsetlevel (Pseudo/ID) (Level admin)");

	if(lvl<0||lvl>1337)
	    return SendClientMessage(playerid, COLOR_ERROR, "Le niveau d'admin doit être entre 0 et 1337!");

 	if(!IsPlayerConnected(ID))
		return SendClientMessage(playerid,COLOR_ERROR,"Ce joueur n'est pas connecté au serveur.");

	new msg[128];
	format(msg, sizeof(msg), "%s(%d) a changé le niveau admin de %s(%d) en %d!", pInfo[playerid][name], playerid, pInfo[ID][name], ID, lvl);
	SendClientMessageToAllAdmins(COLOR_GREEN, msg);
	format(msg, sizeof(msg), "Un Administrateur a changé votre niveau admin! Nouveau niveau admin: %d", lvl);
	SendClientMessage(ID, COLOR_GREEN, msg);
	pInfo[ID][admin]=lvl;
	return 1;
}

cmd:v(playerid, params[])
{
	if(pInfo[playerid][admin] < 3) return 0;
	new model, vehame[128];
    if(sscanf(params, "i", model))
        if(!sscanf(params, "s[50]", vehame))
            model = GetVehicleModelByName(vehame);

    if(!(model >= 400 && model <= 611))
    	return SendClientMessage(playerid, COLOR_ERROR, "/v (Nom/ID du véhicule)");

	new Float:X, Float:Y, Float:Z, Float:angle;
    GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, angle);
	DestroyVehicle(pSpawnVeh[playerid]);
    pSpawnVeh[playerid] = CreateVehicle(model, X, Y+2, Z+1, angle, -1, -1, 900);
    vSpawned[pSpawnVeh[playerid]]=playerid;
   	SetVehicleVirtualWorld(pSpawnVeh[playerid], GetPlayerVirtualWorld(playerid));
    LinkVehicleToInterior(pSpawnVeh[playerid], GetPlayerInterior(playerid));
    PutPlayerInVehicle(playerid,pSpawnVeh[playerid],0);
 	vInfo[pSpawnVeh[playerid]][UID] =-1;
 	vInfo[pSpawnVeh[playerid]][P_UID] =-1;
	return 1;
}

cmd:vsave(playerid, params[])
{
    if(pInfo[playerid][admin] < 5) return 0;
    if(!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans un véhicule pour pouvoir faire cela !");

	new File:file=fopen("vehicles.ini", io_append), Float:pos[4], str[128];
	if(file){
		GetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);
		GetVehicleZAngle(GetPlayerVehicleID(playerid), pos[3]);
		format(str, sizeof(str), "%d %f %f %f %f %d\r\n", GetVehicleModel(GetPlayerVehicleID(playerid)), pos[0], pos[1], pos[2], pos[3], -1);
		fwrite(file, str);
		fclose(file);
        CreateVehicle(GetVehicleModel(GetPlayerVehicleID(playerid)), pos[0], pos[1], pos[2], pos[3], 0, 1, -1);
		SendClientMessage(playerid, COLOR_GREEN, "Véhicule sauvegardé !");
	}
	else SendClientMessage(playerid, COLOR_ERROR, "Erreur dans l'ouverture du fichier: véhicule non sauvegardé !");
	return 1;
}

new Float:Ppos[8], Float:Pppos[6], Pinterior;
cmd:psave(playerid, params[])
{
    if(pInfo[playerid][admin] < 5) return 0;

	switch(strval(params))
	{
		case 0:
		{
			GetPlayerPos(playerid, Ppos[0], Ppos[1], Ppos[2]);
			GetPlayerFacingAngle(playerid, Ppos[3]);
		}
		case 1:
		{
			GetPlayerPos(playerid, Ppos[4], Ppos[5], Ppos[6]);
			GetPlayerFacingAngle(playerid, Ppos[7]);
			Pinterior=GetPlayerInterior(playerid);
		}
		case 2:GetPlayerPos(playerid, Pppos[0], Pppos[1], Pppos[2]);
		case 3:GetPlayerPos(playerid, Pppos[3], Pppos[4], Pppos[5]);
		case 4:
		{
			SendClientMessage(playerid, COLOR_GREEN, "Lieu sauvegardé !");
   			new query[1024];
		    format(query, sizeof(query),
			"INSERT INTO lieux (pickup_entx, pickup_enty, pickup_entz, pickup_extx, pickup_exty, pickup_extz, ent_x, ent_y, ent_z, ent_a, ext_x, ext_y, ext_z, ext_a, interior) VALUES(%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %d)",
			Pppos[0], Pppos[1], Pppos[2], Pppos[3], Pppos[4], Pppos[5], Ppos[0], Ppos[1], Ppos[2], Ppos[3], Ppos[4], Ppos[5], Ppos[6],Ppos[7], Pinterior);
   		 	mysql_query(query);
		}
	}
	return 1;
}

cmd:pload(playerid, params[])
{
    if(pInfo[playerid][admin] < 5) return 0;

    LoadPickupsSQL();
	SendClientMessage(playerid, COLOR_GREEN, "Pickups chargés!");
	return 1;
}

//Callback

public OnGameModeInit()
{
	LoadMapping();

	//CreateVehicle(578,1084.50000000,-1195.69995117,18.79999924,180.00000000,1,0,900); //DFT-30

	SetGameModeText("CRFR - Version beta");
    EnableVehicleFriendlyFire();
    ShowNameTags(1);

	CLASS_CRIMI[0]=TextDrawCreate(74.000000, 212.000000, "JOB AU CHOIX");
	TextDrawBackgroundColor(CLASS_CRIMI[0], 255);
	TextDrawFont(CLASS_CRIMI[0], 3);
	TextDrawLetterSize(CLASS_CRIMI[0], 0.589999, 2.000000);
	TextDrawColor(CLASS_CRIMI[0], 0xffffff99);
	TextDrawSetOutline(CLASS_CRIMI[0], 1);
	TextDrawSetProportional(CLASS_CRIMI[0], 1);

	CLASS_CRIMI[1]=TextDrawCreate(74.000000, 230.000000, "CRIMINEL");
	TextDrawBackgroundColor(CLASS_CRIMI[1], 255);
	TextDrawFont(CLASS_CRIMI[1], 3);
	TextDrawLetterSize(CLASS_CRIMI[1], 0.589999, 2.000000);
	TextDrawColor(CLASS_CRIMI[1], -1);
	TextDrawSetOutline(CLASS_CRIMI[1], 1);
	TextDrawSetProportional(CLASS_CRIMI[1], 1);

	CLASS_COPS[0]=TextDrawCreate(74.000000, 212.000000, "FORCES DE L'ORDRE");
	TextDrawBackgroundColor(CLASS_COPS[0], 255);
	TextDrawFont(CLASS_COPS[0], 3);
	TextDrawLetterSize(CLASS_COPS[0], 0.589999, 2.000000);
	TextDrawColor(CLASS_COPS[0], 0x0080FFFF);
	TextDrawSetOutline(CLASS_COPS[0], 1);
	TextDrawSetProportional(CLASS_COPS[0], 1);

	CLASS_COPS[1]=TextDrawCreate(74.000000, 230.000000, "OFFICIER DE LA POLICE");
	TextDrawBackgroundColor(CLASS_COPS[1], 255);
	TextDrawFont(CLASS_COPS[1], 3);
	TextDrawLetterSize(CLASS_COPS[1], 0.589999, 2.000000);
	TextDrawColor(CLASS_COPS[1], -1);
	TextDrawSetOutline(CLASS_COPS[1], 1);
	TextDrawSetProportional(CLASS_COPS[1], 1);

	CLASS_SPECIALFORCE = TextDrawCreate(74.000000, 212.000000, "FORCES SPECIALES");
	TextDrawBackgroundColor(CLASS_SPECIALFORCE, 255);
	TextDrawFont(CLASS_SPECIALFORCE, 3);
	TextDrawLetterSize(CLASS_SPECIALFORCE, 0.589999, 2.000000);
	TextDrawColor(CLASS_SPECIALFORCE, 0x8000FFFF);
	TextDrawSetOutline(CLASS_SPECIALFORCE, 1);
	TextDrawSetProportional(CLASS_SPECIALFORCE, 1);

	CLASS_SWAT=TextDrawCreate(74.000000, 230.000000, "S.W.A.T");
	TextDrawBackgroundColor(CLASS_SWAT, 255);
	TextDrawFont(CLASS_SWAT, 3);
	TextDrawLetterSize(CLASS_SWAT, 0.589999, 2.000000);
	TextDrawColor(CLASS_SWAT, -1);
	TextDrawSetOutline(CLASS_SWAT, 1);
	TextDrawSetProportional(CLASS_SWAT, 1);

	CLASS_MILITARY=TextDrawCreate(74.000000, 230.000000, "Militaire");
	TextDrawBackgroundColor(CLASS_MILITARY, 255);
	TextDrawFont(CLASS_MILITARY, 3);
	TextDrawLetterSize(CLASS_MILITARY, 0.589999, 2.000000);
	TextDrawColor(CLASS_MILITARY, -1);
	TextDrawSetOutline(CLASS_MILITARY, 1);
	TextDrawSetProportional(CLASS_MILITARY, 1);

	new str[]="Brigade Anti-Criminalité";
	fix_Caracter(str);
	CLASS_BAC=TextDrawCreate(74.000000, 230.000000, str);
	TextDrawBackgroundColor(CLASS_BAC, 255);
	TextDrawFont(CLASS_BAC, 3);
	TextDrawLetterSize(CLASS_BAC, 0.589999, 2.000000);
	TextDrawColor(CLASS_BAC, -1);
	TextDrawSetOutline(CLASS_BAC, 1);
	TextDrawSetProportional(CLASS_BAC, 1);

	CLASS_BALLAS = TextDrawCreate(74.000000, 212.000000, "BALLAS FAMILY");
	TextDrawBackgroundColor(CLASS_BALLAS, 255);
	TextDrawFont(CLASS_BALLAS, 3);
	TextDrawLetterSize(CLASS_BALLAS, 0.589999, 2.000000);
	TextDrawColor(CLASS_BALLAS, 0xff00ff33);
	TextDrawSetOutline(CLASS_BALLAS, 1);
	TextDrawSetProportional(CLASS_BALLAS, 1);

	CLASS_BALLASM = TextDrawCreate(74.000000, 230.000000, "MEMBRE BALLAS");
	TextDrawBackgroundColor(CLASS_BALLASM, 255);
	TextDrawFont(CLASS_BALLASM, 3);
	TextDrawLetterSize(CLASS_BALLASM, 0.589999, 2.000000);
	TextDrawColor(CLASS_BALLASM, 0xffffffff);
	TextDrawSetOutline(CLASS_BALLASM, 1);
	TextDrawSetProportional(CLASS_BALLASM, 1);

	CLASS_BALLASL = TextDrawCreate(74.000000, 230.000000, "LEADER BALLAS");
	TextDrawBackgroundColor(CLASS_BALLASL, 255);
	TextDrawFont(CLASS_BALLASL, 3);
	TextDrawLetterSize(CLASS_BALLASL, 0.589999, 2.000000);
	TextDrawColor(CLASS_BALLASL, 0xffffffff);
	TextDrawSetOutline(CLASS_BALLASL, 1);
	TextDrawSetProportional(CLASS_BALLASL, 1);

	CLASS_GROOVE = TextDrawCreate(74.000000, 212.000000, "GROOVE STREET");
	TextDrawBackgroundColor(CLASS_GROOVE, 255);
	TextDrawFont(CLASS_GROOVE, 3);
	TextDrawLetterSize(CLASS_GROOVE, 0.589999, 2.000000);
	TextDrawColor(CLASS_GROOVE, 0x00ff0033);
	TextDrawSetOutline(CLASS_GROOVE, 1);
	TextDrawSetProportional(CLASS_GROOVE, 1);

	CLASS_GROOVEM = TextDrawCreate(74.000000, 230.000000, "MEMBRE GROOVE");
	TextDrawBackgroundColor(CLASS_GROOVEM, 255);
	TextDrawFont(CLASS_GROOVEM, 3);
	TextDrawLetterSize(CLASS_GROOVEM, 0.589999, 2.000000);
	TextDrawColor(CLASS_GROOVEM, 0xffffffff);
	TextDrawSetOutline(CLASS_GROOVEM, 1);
	TextDrawSetProportional(CLASS_GROOVEM, 1);

	CLASS_GROOVEL = TextDrawCreate(74.000000, 230.000000, "LEADER GROOVE");
	TextDrawBackgroundColor(CLASS_GROOVEL, 255);
	TextDrawFont(CLASS_GROOVEL, 3);
	TextDrawLetterSize(CLASS_GROOVEL, 0.589999, 2.000000);
	TextDrawColor(CLASS_GROOVEL, 0xffffffff);
	TextDrawSetOutline(CLASS_GROOVEL, 1);
	TextDrawSetProportional(CLASS_GROOVEL, 1);

	new color=random(65536);
	VersionTD = TextDrawCreate(3.000000, 436.000000, SERVER_VERSION);
	TextDrawBackgroundColor(VersionTD, -1);
	TextDrawFont(VersionTD, 3);
	TextDrawLetterSize(VersionTD, 0.329998, 1.100000);
	TextDrawColor(VersionTD, color-1);
 	TextDrawSetOutline(VersionTD, 1);
	TextDrawSetProportional(VersionTD, 1);
	TextDrawTextSize(VersionTD, 639.000000, 0.000000);

    mysql_debug(0);
	mysql_connection = mysql_connect(mysql_host, mysql_user, mysql_database, mysql_password);

	//Classes
	AddPlayerClass(21, 725.2963,-1665.0764,10.6862,178.9547, 0, 0, 0, 0, 0, 0); //Criminel skin 1
	AddPlayerClass(23, 725.2963,-1665.0764,10.6862,178.9547, 0, 0, 0, 0, 0, 0); //Criminel skin 1
	AddPlayerClass(280, 725.3023,-1664.7418,10.6862,178.9547, 0, 0, 0, 0, 0, 0); //Policier skin 1
	AddPlayerClass(284, 725.3023,-1664.7418,10.6862,178.9547, 0, 0, 0, 0, 0, 0); //Policier skin 2
	AddPlayerClass(285, 1568.7595,-1695.8564,5.8906,357.0104, 0, 0, 0, 0, 0, 0); //Swat
	AddPlayerClass(287, 1568.7595,-1695.8564,5.8906,357.0104, 0, 0, 0, 0, 0, 0); //Militaire
	AddPlayerClass(98,1154.5231,-1766.4125,16.5938,359.6039,0,0,0,0,0,0); // BAC
	AddPlayerClass(188,1154.5231,-1766.4125,16.5938,359.6039,0,0,0,0,0,0); // BAC
	AddPlayerClass(170,1154.5231,-1766.4125,16.5938,359.6039,0,0,0,0,0,0); // BAC
	AddPlayerClass(293, 2529.7959,-1667.4255,15.1687,89.3802, 0, 0, 0, 0, 0, 0); //Groove leader
	AddPlayerClass(105, 2529.7959,-1667.4255,15.1687,89.3802, 0, 0, 0, 0, 0, 0); //Groove1
	AddPlayerClass(106, 2529.7959,-1667.4255,15.1687,89.3802, 0, 0, 0, 0, 0, 0); //Groove2
	AddPlayerClass(107, 2529.7959,-1667.4255,15.1687,89.3802, 0, 0, 0, 0, 0, 0); //Groove3
	AddPlayerClass(296, 2768.2271,-1610.7424,10.9219,272.6118,0, 0, 0, 0, 0, 0); //Leader Ballas
	AddPlayerClass(104, 2768.2271,-1610.7424,10.9219,272.6118,0, 0, 0, 0, 0, 0); //Ballas1
	AddPlayerClass(103, 2768.2271,-1610.7424,10.9219,272.6118,0, 0, 0, 0, 0, 0); //Ballas2
	AddPlayerClass(102, 2768.2271,-1610.7424,10.9219,272.6118,0, 0, 0, 0, 0, 0); //Ballas3

	BallasZone = GangZoneCreate(2748.1677,-1647.4272,2858.8225,-1501.8668);
	GrooveZone = GangZoneCreate(2477.7009,-1722.1967,2541.9399,-1627.4650);

	new query[128];
	format(query, sizeof(query), "DELETE from `vehicules` WHERE `destroyed`=1");
	mysql_query(query);

    //LoadNPC();

    LoadPickup();
    LoadVehiclesFile();
    LoadVehiclesSQL();
    LoadPickupsSQL();
    LoadMappingFile();
	SetTimer("OneTimer", 1010, true);
	SetTimer("TwoTimer", 2010, true);
	SetTimer("SaveStatsTimer", 900*1000, true);
	SetTimer("RegenerateTimer", 3000, true);
	DisableInteriorEnterExits();

	for(new i=1;i<=MAX_VEHICLES;i++)
	{
	    if(!vInfo[i][spawned]) {
		    vInfo[i][UID]=-1;
		    vInfo[i][P_UID]=-1;
	 		vInfo[i][destroyed]=false;
			vInfo[i][assured]=false;
			vInfo[i][gps]=false;
		}
	}
	return 1;
}

public OnGameModeExit()
{
	for(new i=0;i<1000;i++)
	    KillTimer(i);
 	for(new i=0;i<MAX_PLAYERS;i++)
	    if(IsPlayerConnected(i)) SavePlayerStats(i);
	for(new i=1;i<=MAX_VEHICLES;i++)
		if(IsValidVehicle(i)&&vInfo[i][P_UID]!=-1) SaveVehicleStats(i);
 	new query[128];
	format(query, sizeof(query), "DELETE from `vehicules` WHERE `destroyed`=1");
	mysql_query(query);
	format(query, sizeof(query), "UPDATE `servinfo` SET `Money`=%d,`Score`=%d WHERE `Name`='Ballas'",
	Teams[BALLAS][MONEY], Teams[BALLAS][SCORE]);
	mysql_query(query);
	format(query, sizeof(query), "UPDATE `servinfo` SET `Money`=%d,`Score`=%d WHERE `Name`='Groove'",
	Teams[GROOVE][MONEY], Teams[GROOVE][SCORE]);
	mysql_query(query);
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(pInfo[playerid][furtiv]&&weaponid!=23)
		pInfo[playerid][noiselvl]=floatmul(floatadd(pInfo[playerid][noiselvl], float(weaponid)), (weaponid!=34) ? (1.5) : (100.0));

    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
    pInfo[playerid][lastdamage]=gettime()+7;
    GetPlayerHealth(playerid, pInfo[playerid][hp]);
    GetPlayerHealth(issuerid, pInfo[issuerid][hp]);
	if(IsPlayerCops(issuerid)&&IsPlayerCrimi(playerid)&&pInfo[playerid][wanted]<4&&!pInfo[issuerid][adminmode])
	{
	    SetReport(playerid, issuerid, true);
	    GameTextForPlayer(issuerid, "~w~ANTI-DM ! NE TIREZ PAS SUR LES CIVILS !~n~/pc ", 3000, 3);

		SetPlayerHealth(issuerid, floatsub(pInfo[issuerid][hp], floatdiv(amount, 2.35)));
		if(pInfo[playerid][spawned])
			SetPlayerHealth(playerid, floatadd(pInfo[playerid][hp], amount));

		else {
			SetPlayerHealth(issuerid, 0);
			AddScore(playerid, -1);
		}
	    return 1;
	}
	if(IsPlayerCrimi(issuerid)&&IsPlayerCops(playerid)&&pInfo[issuerid][wanted]<4&&!pInfo[issuerid][adminmode])
	{
	    SetReport(playerid, issuerid, true);
	    GameTextForPlayer(issuerid, "~w~ANTI-DM ! NE TIREZ PAS SUR LES POLICIERS~n~EN ETANT INNOCENT !~n~ /pc", 3000, 3);

		SetPlayerHealth(issuerid, floatsub(pInfo[issuerid][hp], floatdiv(amount, 2.35)));
		if(pInfo[playerid][spawned])
			SetPlayerHealth(playerid, floatadd(pInfo[playerid][hp], amount));

		else {
			SetPlayerHealth(issuerid, 0);
			AddScore(playerid, -1);
		}
	    return 1;
	}
	if(IsPlayerCrimi(issuerid)&&IsPlayerCrimi(playerid))
	{
		new candm;
		candm=CanDm(issuerid, playerid);
		if(candm&&!CanDm(playerid, issuerid)) SetDM(playerid, issuerid);
		if(pInfo[issuerid][TEAM]==TEAM_HITMAN&&pInfo[playerid][hit]>0) candm=true;
		if(!candm&&!pInfo[issuerid][adminmode])
		{
		    SetReport(playerid, issuerid, true);
		    GameTextForPlayer(issuerid, "ANTI-DM ! VOUS NE POUVEZ PAS ! ", 3000, 3);

			SetPlayerHealth(issuerid, floatsub(pInfo[issuerid][hp], floatdiv(amount, 2.35)));
			if(pInfo[playerid][spawned])
				SetPlayerHealth(playerid, floatadd(pInfo[playerid][hp], amount));

			else {
				SetPlayerHealth(issuerid, 0);
				AddScore(playerid, -1);
			}
		}
	}
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    pInfo[playerid][CLASS]=classid;
	switch(classid)
	{
		case 0,1:{
		    SetPlayerPos(playerid, 725.6484,-1665.5813,10.6856);
		    SetPlayerFacingAngle(playerid, 180.0803);
			SetPlayerCameraPos(playerid, 725.6198,-1668.4537,10.6856);
			SetPlayerCameraLookAt(playerid,725.6484,-1665.5813,10.6856);
            TextDrawShowForPlayer(playerid, CLASS_CRIMI[0]);
            TextDrawShowForPlayer(playerid, CLASS_CRIMI[1]);
            TextDrawHideForPlayer(playerid, CLASS_COPS[0]);
            TextDrawHideForPlayer(playerid, CLASS_COPS[1]);
			TextDrawHideForPlayer(playerid, CLASS_BALLAS);
			TextDrawHideForPlayer(playerid, CLASS_BALLASM);
		}
		case 2,3:{
		    SetPlayerPos(playerid, 1552.8380,-1675.3727,16.1953);
		    SetPlayerFacingAngle(playerid, 88.6945);
			SetPlayerCameraPos(playerid, 1549.5504,-1675.3445,16.9153);
		    SetPlayerCameraLookAt(playerid, 1552.8380,-1675.3727,16.1953);
            TextDrawHideForPlayer(playerid, CLASS_CRIMI[0]);
            TextDrawHideForPlayer(playerid, CLASS_CRIMI[1]);
            TextDrawShowForPlayer(playerid, CLASS_COPS[0]);
            TextDrawShowForPlayer(playerid, CLASS_COPS[1]);
            TextDrawHideForPlayer(playerid, CLASS_SPECIALFORCE);
            TextDrawHideForPlayer(playerid, CLASS_SWAT);
		}
		case 4: {
		    SetPlayerPos(playerid, 1568.7319,-1692.0,5.8906);
		    SetPlayerFacingAngle(playerid, 180.0);
			SetPlayerCameraPos(playerid, 1568.7319,-1696.0,5.8906);
		    SetPlayerCameraLookAt(playerid, 1568.7319,-1692.0,5.8906);
  			TextDrawColor(CLASS_SPECIALFORCE, 0x1560DBFF);
            TextDrawHideForPlayer(playerid, CLASS_SPECIALFORCE);
            TextDrawShowForPlayer(playerid, CLASS_SPECIALFORCE);
            TextDrawHideForPlayer(playerid, CLASS_COPS[0]);
            TextDrawHideForPlayer(playerid, CLASS_COPS[1]);
            TextDrawHideForPlayer(playerid, CLASS_MILITARY);
            TextDrawShowForPlayer(playerid, CLASS_SWAT);
		}
		case 5: {
		    SetPlayerPos(playerid, 1568.7319,-1692.0,5.8906);
		    SetPlayerFacingAngle(playerid, 180.0);
			SetPlayerCameraPos(playerid, 1568.7319,-1696.0,5.8906);
		    SetPlayerCameraLookAt(playerid, 1568.7319,-1692.0,5.8906);
			TextDrawColor(CLASS_SPECIALFORCE, 0x8000FFFF);
            TextDrawHideForPlayer(playerid, CLASS_SPECIALFORCE);
            TextDrawHideForPlayer(playerid, CLASS_SWAT);
			TextDrawHideForPlayer(playerid, CLASS_BAC);
            TextDrawShowForPlayer(playerid, CLASS_SPECIALFORCE);
            TextDrawShowForPlayer(playerid, CLASS_MILITARY);
		}
		case 6: {
			SetPlayerPos(playerid, 1151.8749,-1180.9440,32.0647);
			SetPlayerFacingAngle(playerid,89);
			SetPlayerCameraPos(playerid, 1148.8749,-1180.9440,32.0275);
			SetPlayerCameraLookAt(playerid, 1151.8749,-1180.9440,32.0647);
  			TextDrawColor(CLASS_SPECIALFORCE, COLOR_BAC);
            TextDrawHideForPlayer(playerid, CLASS_MILITARY);
            TextDrawHideForPlayer(playerid, CLASS_SPECIALFORCE);
            TextDrawShowForPlayer(playerid, CLASS_SPECIALFORCE);
            TextDrawShowForPlayer(playerid, CLASS_BAC);
		}
		case 7,8: {
			SetPlayerPos(playerid, 1151.8749,-1180.9440,32.0647);
			SetPlayerFacingAngle(playerid,89);
			SetPlayerCameraPos(playerid, 1148.8749,-1180.9440,32.0275);
			SetPlayerCameraLookAt(playerid, 1151.8749,-1180.9440,32.0647);
  			TextDrawColor(CLASS_SPECIALFORCE, COLOR_BAC);
            TextDrawHideForPlayer(playerid, CLASS_GROOVE);
            TextDrawHideForPlayer(playerid, CLASS_GROOVEL);
            TextDrawHideForPlayer(playerid, CLASS_SPECIALFORCE);
            TextDrawShowForPlayer(playerid, CLASS_SPECIALFORCE);
            TextDrawShowForPlayer(playerid, CLASS_BAC);
		}
		case 9: {
 			TextDrawShowForPlayer(playerid, CLASS_GROOVE);
			TextDrawShowForPlayer(playerid, CLASS_GROOVEL);
			TextDrawHideForPlayer(playerid, CLASS_BAC);
			TextDrawHideForPlayer(playerid, CLASS_GROOVEM);
            TextDrawHideForPlayer(playerid, CLASS_SPECIALFORCE);
			SetPlayerPos(playerid, 2497.1470,-1668.0388,13.3438);
			SetPlayerFacingAngle(playerid,95.12);
			SetPlayerCameraPos(playerid, 2494.1407,-1668.0388,13.3438);
			SetPlayerCameraLookAt(playerid, 2497.1470,-1668.0388,13.3438);
		}
		case 10,11,12: {
		    TextDrawHideForPlayer(playerid, CLASS_GROOVEL);
			TextDrawShowForPlayer(playerid, CLASS_GROOVEM);
   			TextDrawShowForPlayer(playerid, CLASS_GROOVE);
			TextDrawHideForPlayer(playerid, CLASS_BALLAS);
			TextDrawHideForPlayer(playerid, CLASS_BALLASL);
			SetPlayerPos(playerid, 2497.1470,-1668.0388,13.3438);
			SetPlayerFacingAngle(playerid,95.12);
			SetPlayerCameraPos(playerid, 2494.1407,-1668.0388,13.3438);
			SetPlayerCameraLookAt(playerid, 2497.1470,-1668.0388,13.3438);
		}
		case 13: {
			TextDrawHideForPlayer(playerid, CLASS_GROOVE);
   			TextDrawHideForPlayer(playerid, CLASS_GROOVEM);
			TextDrawHideForPlayer(playerid, CLASS_BALLASM);
			TextDrawShowForPlayer(playerid, CLASS_BALLAS);
			TextDrawShowForPlayer(playerid, CLASS_BALLASL);
			SetPlayerPos(playerid, 2808.9089,-1572.9385,10.9267);
			SetPlayerFacingAngle(playerid,178);
			SetPlayerCameraPos(playerid, 2808.9089,-1575.9385,10.9267);
			SetPlayerCameraLookAt(playerid, 2808.9089,-1572.9385,10.9267);
		}
		case 14,15,16: {
            TextDrawHideForPlayer(playerid, CLASS_CRIMI[0]);
            TextDrawHideForPlayer(playerid, CLASS_CRIMI[1]);
  		    TextDrawHideForPlayer(playerid, CLASS_BALLASL);
			TextDrawShowForPlayer(playerid, CLASS_BALLAS);
			TextDrawShowForPlayer(playerid, CLASS_BALLASM);
			SetPlayerPos(playerid, 2808.9089,-1572.9385,10.9267);
			SetPlayerFacingAngle(playerid,178);
			SetPlayerCameraPos(playerid, 2808.9089,-1575.9385,10.9267);
			SetPlayerCameraLookAt(playerid, 2808.9089,-1572.9385,10.9267);
		}
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(!pInfo[playerid][logged]) {
	    SendClientMessage(playerid, COLOR_ERROR, "Connectez-vous avant de faire ça !");
		return 0;
	}
	switch(pInfo[playerid][CLASS])
	{
	    case 2, 3, 4:{
			if(pInfo[playerid][wanted]>0){
	     		SendClientMessage(playerid, COLOR_ERROR, "Vous étiez recherché à votre dernière déconnexion du serveur, vous ne pouvez pas devenir policier !");
			    return 0;
	    	}
			if(GetPlayerScore(playerid)<50) {
	     		SendClientMessage(playerid, COLOR_ERROR, "Vous devez avoir 50 de score au minimum pour être policier !");
			    return 0;
			}
			if(pInfo[playerid][CLASS]==4&&pInfo[playerid][policelvl]<20) {
	     		SendClientMessage(playerid, COLOR_ERROR, "Vous devez être policier de niveau 20 minmum pour choisir cette classe !");
			    return 0;
			}
			if(pInfo[playerid][CLASS]==5&&!pInfo[playerid][military]) {
	     		SendClientMessage(playerid, COLOR_ERROR, "Vous devez être militaire pour choisir cette classe !");
			    return 0;
			}
			pInfo[playerid][TEAM]=TEAM_COPS;
		}
		case 6: if(!pInfo[playerid][leadbac]) {
	     	SendClientMessage(playerid, COLOR_ERROR, "Vous devez être le Leader de la BAC pour choisir cette classe !");
			return 0;
		}
		case 7, 8: if(!pInfo[playerid][bac]) {
	     	SendClientMessage(playerid, COLOR_ERROR, "Vous devez être de la BAC pour choisir cette classe !");
			return 0;
		}
		case 9: if(!pInfo[playerid][leadgroove]) {
	     	SendClientMessage(playerid, COLOR_ERROR, "Vous devez être Leader des Grooves pour choisir cette classe !");
			return 0;
		}
		case 10,11,12: if(!pInfo[playerid][groove]) {
	     	SendClientMessage(playerid, COLOR_ERROR, "Vous devez être un Groove pour choisir cette classe !");
			return 0;
		}
		case 13: if(!pInfo[playerid][leadballas]) {
	     	SendClientMessage(playerid, COLOR_ERROR, "Vous devez être Leader des Ballas pour choisir cette classe !");
			return 0;
		}
		case 14,15,16: if(!pInfo[playerid][ballas]) {
	     	SendClientMessage(playerid, COLOR_ERROR, "Vous devez être un Ballas pour choisir cette classe !");
			return 0;
		}
	}

    TextDrawHideForPlayer(playerid, CLASS_CRIMI[0]);
    TextDrawHideForPlayer(playerid, CLASS_CRIMI[1]);
   	TextDrawHideForPlayer(playerid, CLASS_COPS[0]);
    TextDrawHideForPlayer(playerid, CLASS_COPS[1]);
    TextDrawHideForPlayer(playerid, CLASS_SPECIALFORCE);
    TextDrawHideForPlayer(playerid, CLASS_MILITARY);
    TextDrawHideForPlayer(playerid, CLASS_SWAT);
    TextDrawHideForPlayer(playerid, CLASS_BAC);
    TextDrawHideForPlayer(playerid, CLASS_BALLAS);
	TextDrawHideForPlayer(playerid, CLASS_BALLASL);
	TextDrawHideForPlayer(playerid, CLASS_BALLASM);
    TextDrawHideForPlayer(playerid, CLASS_GROOVE);
	TextDrawHideForPlayer(playerid, CLASS_GROOVEL);
	TextDrawHideForPlayer(playerid, CLASS_GROOVEM);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid==DIALOG_ADCMDS)
	{
	    if(!response) return 1;
	    new dialog[1024], title[128];
		format(title, sizeof(title), "Commandes Admin - Niveau {10F441}%d", pInfo[playerid][admin]);
		if(pInfo[playerid][admin]>=1)
		{
		    format(dialog, sizeof(dialog), "{10F441}/adpm{A9C4E4} - Envoye un PM en tant que staff anonyme a un joueur");
		    format(dialog, sizeof(dialog), "{10F441}/admsg{A9C4E4} - Envoye un message en tant que staff anonyme a tous les joueurs");
		    format(dialog, sizeof(dialog), "{10F441}/adchat{A9C4E4} - Parle dans le tchat admin");
		}
		if(pInfo[playerid][admin]>=3)
		{
	 	    format(dialog, sizeof(dialog), "%s\n{10F441}/adballas{A9C4E4} - Donne le statut de Ballas à un joueur", dialog);
		    format(dialog, sizeof(dialog), "%s\n{10F441}/addeballas{A9C4E4} - Enlève le statut de Ballas à un joueur", dialog);
		    format(dialog, sizeof(dialog), "%s\n{10F441}/adlballas{A9C4E4} - Donne le statut de Leader Ballas à un joueur", dialog);
		    format(dialog, sizeof(dialog), "%s\n{10F441}/addelballas{A9C4E4} - Enlève le statut de Leader Ballas à un joueur", dialog);
	 	    format(dialog, sizeof(dialog), "%s\n{10F441}/adbac{A9C4E4} - Donne le statut de membre de la BAC à un joueur", dialog);
		    format(dialog, sizeof(dialog), "%s\n{10F441}/addebac{A9C4E4} - Enlève le statut de membre de la BAC à un joueur", dialog);
		    format(dialog, sizeof(dialog), "%s\n{10F441}/adlbac{A9C4E4} - Donne le statut de Leader de la BAC à un joueur", dialog);
		    format(dialog, sizeof(dialog), "%s\n{10F441}/addelbac{A9C4E4} - Enlève le statut de Leader de la BAC à un joueur", dialog);
		}
 		if(pInfo[playerid][admin]>=5)
		{
	 	    format(dialog, sizeof(dialog), "%s\n{10F441}/adgmx{A9C4E4} (Temps en secondes = optionnel) - Redémarrer le serveur", dialog);
		}
		if(strlen(dialog)!=0) ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, title, dialog, "OK", "");
	    return 1;
	}
	if(dialogid==DIALOG_PICKWEP)
	{
	    if(!response) return 1;
	    if(!IsCanAction(playerid))
	        return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");

		switch(listitem)
		{
		    case 0:
			{
			    GivePlayerWeaponEx(playerid, 23, 500);
			    pInfo[playerid][lastweaponpick]=gettime()+22*7;
			}
 		    case 1:
			{
			    GivePlayerWeaponEx(playerid, 25, 500);
			    pInfo[playerid][lastweaponpick]=gettime()+225*7;
			}
  		    case 2:
			{
			    GivePlayerWeaponEx(playerid, 29, 500);
			    pInfo[playerid][lastweaponpick]=gettime()+229*7;
			}
   		    case 3:
			{
			    GivePlayerWeaponEx(playerid, 31, 500);
			    pInfo[playerid][lastweaponpick]=gettime()+231*7;
			}
		}
		return 1;
	}
	if(dialogid==DIALOG_COFFREBGET)
	{
	    if(!response)
			ShowPlayerDialog(playerid, DIALOG_COFFREB, DIALOG_STYLE_LIST, "Coffre Ballas", "Ajouter de l'argent\nRetirer de l'argent\n{FF0000}Contenu du coffre", "OK", "Annuler");

	    if(!IsCanAction(playerid))
	        return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");
		new amount=0;
		if(sscanf(inputtext, "i", amount))
		{
			ShowPlayerDialog(playerid, DIALOG_COFFREBGET, DIALOG_STYLE_INPUT, "Retirer de l'argent", "Entrez un montant d'argent à déposer dans le coffre\n{FF0000}Vous devez entrer un montant à déposer !", "Déposer", "Annuler");
		    return 1;
		}
		if(amount<=0)
		{
			ShowPlayerDialog(playerid, DIALOG_COFFREBGET, DIALOG_STYLE_INPUT, "Retirer de l'argent", "Entrez un montant d'argent à déposer dans le coffre\n{FF0000}Vous devez entrer un montant plus grand que zéro !", "Déposer", "Annuler");
		    return 1;
		}
		if(amount>Teams[BALLAS][MONEY])
		{
			ShowPlayerDialog(playerid, DIALOG_COFFREBGET, DIALOG_STYLE_INPUT, "Retirer de l'argent", "Entrez un montant d'argent à déposer dans le coffre\n{FF0000}Le coffre ne contient pas autant d'argent !", "Déposer", "Annuler");
		    return 1;
  		}
		new msg[144];
		Teams[BALLAS][MONEY]-=amount;
		GivePlayerMoney(playerid, amount);
		format(msg, sizeof(msg), "Vous avez retiré %s dans le coffre de la team ballas. Le coffre contient maintenant %s !", FormatMoney(amount), FormatMoney(Teams[BALLAS][MONEY]));
		SendClientMessage(playerid, COLOR_GREEN, msg);
		return 1;
	}
	if(dialogid==DIALOG_COFFREGGET)
	{
	    if(!response)
			ShowPlayerDialog(playerid, DIALOG_COFFREG, DIALOG_STYLE_LIST, "Coffre Groove", "Ajouter de l'argent\nRetirer de l'argent\n{FF0000}Contenu du coffre", "OK", "Annuler");
	    if(!IsCanAction(playerid))
	        return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");
		new amount=0;
		if(sscanf(inputtext, "i", amount))
		{
			ShowPlayerDialog(playerid, DIALOG_COFFREGGET, DIALOG_STYLE_INPUT, "Retirer de l'argent", "Entrez un montant d'argent à déposer dans le coffre\n{FF0000}Vous devez entrer un montant à déposer !", "Déposer", "Annuler");
		    return 1;
		}
		if(amount<=0)
		{
			ShowPlayerDialog(playerid, DIALOG_COFFREGGET, DIALOG_STYLE_INPUT, "Retirer de l'argent", "Entrez un montant d'argent à déposer dans le coffre\n{FF0000}Vous devez entrer un montant plus grand que zéro !", "Déposer", "Annuler");
		    return 1;
		}
		if(amount>Teams[GROOVE][MONEY])
		{
			ShowPlayerDialog(playerid, DIALOG_COFFREGGET, DIALOG_STYLE_INPUT, "Retirer de l'argent", "Entrez un montant d'argent à déposer dans le coffre\n{FF0000}Le coffre ne contient pas autant d'argent !", "Déposer", "Annuler");
		    return 1;
  		}
		new msg[144];
		Teams[GROOVE][MONEY]-=amount;
		GivePlayerMoney(playerid, amount);
		format(msg, sizeof(msg), "Vous avez retiré %s dans le coffre de la team groove. Le coffre contient maintenant %s !", FormatMoney(amount), FormatMoney(Teams[GROOVE][MONEY]));
		SendClientMessage(playerid, COLOR_GREEN, msg);
		return 1;
	}
	if(dialogid==DIALOG_COFFREBPUT)
	{
	    if(!response)
			ShowPlayerDialog(playerid, DIALOG_COFFREB, DIALOG_STYLE_LIST, "Coffre Ballas", "Ajouter de l'argent\nRetirer de l'argent\n{FF0000}Contenu du coffre", "OK", "Annuler");
	    if(!IsCanAction(playerid))
	        return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");
		new amount=0;
		if(sscanf(inputtext, "i", amount))
		{
			ShowPlayerDialog(playerid, DIALOG_COFFREBPUT, DIALOG_STYLE_INPUT, "Déposer de l'argent", "Entrez un montant d'argent à déposer dans le coffre\n{FF0000}Vous devez entrer un montant à déposer !", "Déposer", "Annuler");
		    return 1;
		}
		if(amount<=0)
		{
			ShowPlayerDialog(playerid, DIALOG_COFFREBPUT, DIALOG_STYLE_INPUT, "Déposer de l'argent", "Entrez un montant d'argent à déposer dans le coffre\n{FF0000}Vous devez entrer un montant plus grand que zéro !", "Déposer", "Annuler");
		    return 1;
		}
		if(amount>GetPlayerMoney(playerid))
		{
			ShowPlayerDialog(playerid, DIALOG_COFFREBPUT, DIALOG_STYLE_INPUT, "Déposer de l'argent", "Entrez un montant d'argent à déposer dans le coffre\n{FF0000}Vous n'avez pas assez d'argent sur vous !", "Déposer", "Annuler");
		    return 1;
		}

		new msg[144];
		Teams[BALLAS][MONEY]+=amount;
		GivePlayerMoney(playerid, -amount);
		format(msg, sizeof(msg), "Vous avez déposé %s dans le coffre de la team ballas. Le coffre contient maintenant %s !", FormatMoney(amount), FormatMoney(Teams[BALLAS][MONEY]));
		SendClientMessage(playerid, COLOR_GREEN, msg);
		return 1;
	}
	if(dialogid==DIALOG_COFFREGPUT)
	{
	    if(!response)
			ShowPlayerDialog(playerid, DIALOG_COFFREG, DIALOG_STYLE_LIST, "Coffre Groove", "Ajouter de l'argent\nRetirer de l'argent\n{FF0000}Contenu du coffre", "OK", "Annuler");
	    if(!IsCanAction(playerid))
	        return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");
		new amount=0;
		if(sscanf(inputtext, "i", amount))
		{
			ShowPlayerDialog(playerid, DIALOG_COFFREGPUT, DIALOG_STYLE_INPUT, "Déposer de l'argent", "Entrez un montant d'argent à déposer dans le coffre\n{FF0000}Vous devez entrer un montant à déposer !", "Déposer", "Annuler");
		    return 1;
		}
		if(amount<=0)
		{
			ShowPlayerDialog(playerid, DIALOG_COFFREGPUT, DIALOG_STYLE_INPUT, "Déposer de l'argent", "Entrez un montant d'argent à déposer dans le coffre\n{FF0000}Vous devez entrer un montant plus grand que zéro !", "Déposer", "Annuler");
		    return 1;
		}
		if(amount>GetPlayerMoney(playerid))
		{
			ShowPlayerDialog(playerid, DIALOG_COFFREGPUT, DIALOG_STYLE_INPUT, "Déposer de l'argent", "Entrez un montant d'argent à déposer dans le coffre\n{FF0000}Vous n'avez pas assez d'argent sur vous !", "Déposer", "Annuler");
		    return 1;
		}

		new msg[144];
		Teams[GROOVE][MONEY]+=amount;
		GivePlayerMoney(playerid, -amount);
		format(msg, sizeof(msg), "Vous avez déposé %s dans le coffre de la team groove. Le coffre contient maintenant %s !", FormatMoney(amount), FormatMoney(Teams[GROOVE][MONEY]));
		SendClientMessage(playerid, COLOR_GREEN, msg);
		return 1;
	}
	if(dialogid==DIALOG_COFFREG)
	{
	    if(!response) return 1;
	    if(!IsCanAction(playerid))
	        return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");
		switch(listitem)
		{
		    case 0:
			    ShowPlayerDialog(playerid, DIALOG_COFFREGPUT, DIALOG_STYLE_INPUT, "Déposer de l'argent", "Entrez un montant d'argent à déposer dans le coffre", "Déposer", "Annuler");
		    case 1:
			    ShowPlayerDialog(playerid, DIALOG_COFFREGGET, DIALOG_STYLE_INPUT, "Retirer de l'argent", "Entrez un montant d'argent à retirer du coffre", "Déposer", "Annuler");
		    case 2:
			{
				new dialog[1024];
				format(dialog, sizeof(dialog), "Contenu du coffre\nArgent: %s", FormatMoney(Teams[GROOVE][MONEY]));
				ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Coffre Groove Street", dialog, "OK", "");
			}

		}
	    return 1;
	}
	if(dialogid==DIALOG_COFFREB)
	{
	    if(!response) return 1;
	    if(!IsCanAction(playerid))
	        return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");
		switch(listitem)
		{
		    case 0:
			    ShowPlayerDialog(playerid, DIALOG_COFFREBPUT, DIALOG_STYLE_INPUT, "Déposer de l'argent", "Entrez un montant d'argent à déposer dans le coffre", "Déposer", "Annuler");
		    case 1:
			    ShowPlayerDialog(playerid, DIALOG_COFFREBGET, DIALOG_STYLE_INPUT, "Retirer de l'argent", "Entrez un montant d'argent à retirer du coffre", "Déposer", "Annuler");
		    case 2:
			{
				new dialog[1024];
				format(dialog, sizeof(dialog), "Contenu du coffre\nArgent: %s", FormatMoney(Teams[BALLAS][MONEY]));
				ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Coffre Ballas", dialog, "OK", "");
			}

		}
	    return 1;
	}
	if(dialogid==DIALOG_GPS)
	{
	    new Veh[MAX_VEHICLES], cveh=0;
		for(new v=1;v<=MAX_VEHICLES;v++)
		    if(IsValidVehicle(v)&&!vInfo[v][destroyed]&&vInfo[v][gps]&&vInfo[v][P_UID]==pInfo[playerid][UID]) {
				Veh[cveh]=v;
			    cveh++;
			}
		for(new i=0;i<cveh;i++)
		{
		    if(listitem==i)
		    {
		        if(vInfo[Veh[i]][gps])
				{
			        new Float:x, Float:y, Float:z;
			        GetVehiclePos(Veh[i], x, y, z);
			        SetPlayerRaceCheckpoint(playerid, 2, x, y, z, 0.0,0.0,0.0, 12.5);
			        pInfo[playerid][ctimer]=SetTimerEx("gpscheckpointtimer", 60000, false, "i", playerid);
			        SendClientMessage(playerid, COLOR_GREEN, "Un checkpoint rouge est apparu la où est votre véhicule ! Regardez votre mini-carte, il disparaîtra dans une minute.");
	                SetPlayerMapIcon(playerid, 99,  x, y, z, 0, 0xFF0000FF, MAPICON_GLOBAL);
				}
                else SendClientMessage(playerid, COLOR_ERROR, "Ce véhicule ne possède pas de GPS!");
		    }
		}
	}
	if(dialogid==DIALOG_BUYWEP)
	{
	    if(!response) return cmd_acheter(playerid, "");
		if(!IsCanAction(playerid)) return 1;
	    if(PlayerToPoint(3, playerid, 295.4040,-37.5995,1001.5156)) return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans le checkpoint de l'Ammunation !");
	    if(pNextBuy[playerid]==0) {
		switch(listitem)
		{
			case 0: {
				if(GetPlayerMoney(playerid)<400) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -400);
				GivePlayerWeapon(playerid, 8, 1);
			}
			case 1: {
 				if(GetPlayerMoney(playerid)<250) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -250);
				GivePlayerWeapon(playerid, 8, 5);
			}
			case 2: {
 				if(GetPlayerMoney(playerid)<375) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -375);
				GivePlayerWeapon(playerid, 8, 1);
			}
		}
	    }
	    if(pNextBuy[playerid]==1) {
		switch(listitem)
		{
			case 0: {
				if(GetPlayerMoney(playerid)<950) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -950);
				GivePlayerWeapon(playerid, 22, 275);
			}
			case 1: {
 				if(GetPlayerMoney(playerid)<1275) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -1275);
				GivePlayerWeapon(playerid, 23, 275);
			}
			case 2: {
 				if(GetPlayerMoney(playerid)<2245) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -2245);
				GivePlayerWeapon(playerid, 24, 275);
			}
		}
	    }
	    if(pNextBuy[playerid]==2) {
		switch(listitem)
		{
			case 0: {
				if(GetPlayerMoney(playerid)<2500) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -2500);
				GivePlayerWeapon(playerid, 28, 500);
			}
 			case 1: {
 				if(GetPlayerMoney(playerid)<2500) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -2500);
				GivePlayerWeapon(playerid, 22, 500);
			}
			case 2: {
 				if(GetPlayerMoney(playerid)<2500) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -2500);
				GivePlayerWeapon(playerid, 29, 500);
			}
			case 3: {
 				if(GetPlayerMoney(playerid)<2500) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -2500);
				GivePlayerWeapon(playerid, 31, 750);
			}
			case 4: {
 				if(GetPlayerMoney(playerid)<2500) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -2500);
				GivePlayerWeapon(playerid, 30, 750);
			}
		}
	    }
	    if(pNextBuy[playerid]==3) {
		switch(listitem)
		{
			case 0: {
				if(GetPlayerMoney(playerid)<2750) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -2750);
				GivePlayerWeapon(playerid, 25, 450);
			}
			case 1: {
 				if(GetPlayerMoney(playerid)<3250) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -3250);
				GivePlayerWeapon(playerid, 27, 500);
			}
			case 2: {
 				if(GetPlayerMoney(playerid)<2750) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -2750);
				GivePlayerWeapon(playerid, 26, 450);
			}
			case 3: {
 				if(GetPlayerMoney(playerid)<2500) {
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez pas assez d'argent pour acheter ça !", "OK", "");
				    return 1;
				}
				GivePlayerMoney(playerid, -2500);
				GivePlayerWeapon(playerid, 33, 650);
			}
		}
	    }
	}
	if(dialogid==DIALOG_WEPD)
	{
	    if(!response||!IsCanAction(playerid)) return 1;
	    if(PlayerToPoint(3, playerid, 295.4040,-37.5995,1001.5156)) return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans le checkpoint de l'Ammunation !");
	    pNextBuy[playerid]=listitem;
	    switch(listitem)
	    {
	        case 0: {
	            ShowPlayerDialog(playerid, DIALOG_BUYWEP, DIALOG_STYLE_LIST, "Armes de Mélées", "Katana ($400)\nBatte de Baseball ($250)\nPoing Américain ($375)", "Acheter", "Annuler");
	        }
 	        case 1: {
	            ShowPlayerDialog(playerid, DIALOG_BUYWEP, DIALOG_STYLE_LIST, "Pistolets", "9mm ($950) (275 balles)\n9mm Silencieux ($1275) (275 balles)\nDesert Eagle ($2245) (275 balles)", "Acheter", "Annuler");
	        }
 	        case 2: {
	            ShowPlayerDialog(playerid, DIALOG_BUYWEP, DIALOG_STYLE_LIST, "Mitraillettes", "Uzi ($2500) (500 balles)\nTec9 ($2500) (500 balles)\nMP5 ($2500) (500 balles)\nM4 ($3000) (750 balles)\nAK47 ($3000) (750 balles)", "Acheter", "Annuler");
	        }
 	        case 3: {
	            ShowPlayerDialog(playerid, DIALOG_BUYWEP, DIALOG_STYLE_LIST, "Fusils", "Fusil a Pompe ($2750) (450 balles)\nFusil de Combat ($3250) (500 balles)\nFusil a Canon Scié ($2750) (450 balles)\nFusil de Campagne ($2500) (650 balles)", "Acheter", "Annuler");
	        }
	        case 4: {
	            if(GetPlayerMoney(playerid)<1000)
	                return SendClientMessage(playerid, COLOR_ERROR, "Vous n'avez pas assez d'argent ($1,000) pour acheter un Gilet pare-balle !");
				new Float:armour;
				GetPlayerArmour(playerid, armour);
				if(armour>=100)
				    return SendClientMessage(playerid, COLOR_ERROR, "Votre armure est déjà au maximum !");
	            GivePlayerMoney(playerid, -1000);
	            SetPlayerArmour(playerid, 100);
	        }
	    }
	    return 1;
	}
	if(dialogid==DIALOG_COMPINFO)
	{
	    if(!response) return 1;
	    new dialog[600], title[50];
	    format(dialog, sizeof(dialog), "Informations sur la compétence %s (%s):\n%s", sCompetences[listitem][0], sCompetences[listitem][1], compInfo[listitem]);
	    format(title, sizeof(title), "Informations - %s", sCompetences[listitem][0]);
	    ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, title, dialog, "Ok", "");
	    return 1;
	}
	if(dialogid==DIALOG_UPCOMP)
	{
	    if(!response) return 1;
	    if(listitem==1) {
		    new dialog[600], title[50];
		    format(dialog, sizeof(dialog), "Informations sur la compétence %s (%s):\n%s", sCompetences[pNextDComp[playerid]][0], sCompetences[pNextDComp[playerid]][1], compInfo[pNextDComp[playerid]]);
		    format(title, sizeof(title), "Compétence %s", sCompetences[pNextDComp[playerid]][0]);
		    ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, title, dialog, "Ok", "");
	        return 1;
	    }
	    if(pComp[playerid][comp_points]<=0)
     	{
			ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Vous n'avez aucun points, vous ne pouvez pas augmenter de compétences.", "OK", "");
			return 1;
	    }
	    if(GetCompetence(playerid, pNextDComp[playerid])>=compMaxLvl[pNextDComp[playerid]])
     	{
			ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Cette compétence est à son niveau maximal !", "OK", "");
			return 1;
	    }
	    switch(pNextDComp[playerid])
	    {
	        case 0:if(pComp[playerid][comp_lvl]<3) {
				ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Cette compétence nécessite d'être au niveau 3 minimum !", "OK", "");
				return 1;
	        }
    	    case 2:if(pComp[playerid][comp_lvl]<4) {
				ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Erreur", "{FF0000}Cette compétence nécessite d'être au niveau 4 minimum !", "OK", "");
				return 1;
	        }
	    }
     	SetCompetence(playerid, pNextDComp[playerid], GetCompetence(playerid, pNextDComp[playerid])+1);
     	pComp[playerid][comp_points]--;
		new msg[128];
		format(msg, sizeof(msg), "Vous avez augmenté la compétence %s au niveau %d !", sCompetences[pNextDComp[playerid]][0], GetCompetence(playerid, pNextDComp[playerid]));
		ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Compétence", msg, "Ok", "Annuler");
		return 1;
	}
	if(dialogid==DIALOG_COMP)
	{
	    if(!response) return 1;
		pNextDComp[playerid]=listitem;
		new dialog[400], title[100];
		format(dialog, sizeof(dialog), "Augmenter la compétence (Vous avez {FF0000}%d{A9C4E4} points)\nInformations sur la compétence", pComp[playerid][comp_points]);
		format(title, sizeof(title), "%s - Niveau %d", sCompetences[listitem][0], GetCompetence(playerid, listitem));
		ShowPlayerDialog(playerid, DIALOG_UPCOMP, DIALOG_STYLE_LIST, title, dialog, "OK", "Annuler");
		return 1;
	}

	if(dialogid==DIALOG_BUYBOMB)
	{
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");
		if(GetPlayerCheckpoint(playerid)!=CP_BOMBSHOP)
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans le checkpoint du BombShop !");
	    switch(pBombNextBuy[playerid])
	    {
	        case 0:
	        {
			    new amount=0;
		   		if(sscanf(inputtext, "i", amount))
				{
					ShowPlayerDialog(playerid, DIALOG_BUYBOMB, DIALOG_STYLE_INPUT, "Acheter du C4", "Entrez un nombre de C4 à acheter\n{FF0000}Vous devez entrer un nombre de C4 à acheter !", "Quitter", "Annuler");
					return 1;
				}
				if(amount<=0)
				{
					ShowPlayerDialog(playerid, DIALOG_BUYBOMB, DIALOG_STYLE_INPUT, "Acheter du C4", "Entrez un nombre de C4 à acheter\n{FF0000}Vous devez entrer un nombre plus grand que 0 !", "Quitter", "Annuler");
					return 1;
				}
				if((amount*500)>GetPlayerMoney(playerid))
				{
					ShowPlayerDialog(playerid, DIALOG_BUYBOMB, DIALOG_STYLE_INPUT, "Acheter du C4", "Entrez un nombre de C4 à acheter\n{FF0000}Vous n'avez pas assez d'argent pour acheter autant de C4 !", "Quitter", "Annuler");
					return 1;
				}
				GivePlayerMoney(playerid, -(amount*500));
				pInv[playerid][C4]+=amount;
				new msg[128];
				format(msg, sizeof(msg), "Vous avez acheté %d C4 au prix de %s !", amount, FormatMoney(amount*500));
				return SendClientMessage(playerid, COLOR_GREEN, msg);
	        }
	    }
	}

	if(dialogid==DIALOG_BOMBSHOP)
	{
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas faire ça maintenant !");
		if(GetPlayerCheckpoint(playerid)!=CP_BOMBSHOP)
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans le checkpoint du BombShop !");
		switch(listitem)
		{
		    case 0: {
				ShowPlayerDialog(playerid, DIALOG_BUYBOMB, DIALOG_STYLE_INPUT, "Acheter du C4", "Entrez un nombre de C4 à acheter", "Quitter", "Annuler");
				pBombNextBuy[playerid]=0;
			}
		}
	}

	if(dialogid==DIALOG_CARJACK)
	{
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
		new vehicleid=GetPlayerVehicleID(playerid);
	    if(!response||vehicleid==INVALID_VEHICLE_ID) {
			RemovePlayerFromVehicle(playerid);
			return 1;
		}
		if(GetPlayerVehicleSeat(playerid)!=0)
			return SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas voler de véhicule en étant en passager.");
		if(pInfo[playerid][lastcarjack]>gettime())
		    return SendClientMessage(playerid, COLOR_ERROR, "Tu ne peux plus voler de véhicules pour le moment!");

		if(strcmp(inputtext, vInfo[vehicleid][vcode], false, strlen(vInfo[vehicleid][vcode]))==0&&strlen(inputtext)>0)
		{
		    new string[128];
			SendClientMessage(playerid,COLOR_DARKGREY,"[ Véhicule Volé ]");
			format(string,sizeof(string),"Vous avez volé le véhicule de %s(%d) ",GetPlayerNameWithUID(vInfo[vehicleid][P_UID]),GetPlayerIDWithUID(vInfo[vehicleid][P_UID]));
			SendClientMessage(playerid,COLOR_ERROR,string);
			AddWanted(playerid,4);
			AddScore(playerid,2);

			format(string,sizeof(string),"Le Carjacker %s(%d) a volé votre véhicule!",pInfo[playerid][name],playerid);
			if(IsPlayerConnected(GetPlayerIDWithUID(vInfo[vehicleid][P_UID]))) SendClientMessage(GetPlayerIDWithUID(vInfo[vehicleid][P_UID]),COLOR_RED,string);

			format(string,sizeof(string),"Le Carjacker %s(%d) a volé le véhicule de %s(%d) !",pInfo[playerid][name],playerid, GetPlayerNameWithUID(vInfo[vehicleid][P_UID]),GetPlayerIDWithUID(vInfo[vehicleid][P_UID]));
			SendClientMessageToAll(COLOR_RED,string);

			vInfo[vehicleid][P_UID] = pInfo[playerid][UID];
			vInfo[vehicleid][stolen]=true;
			SaveVehicleStats(vehicleid);
			pInfo[playerid][lastcarjack]=gettime()+140;
			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective);
			pInfo[playerid][lasttrob]=0;
		    return 1;
		}
		if(vInfo[vehicleid][vtry]<=0){
			RemovePlayerFromVehicle(playerid);
			pInfo[playerid][lastcarjack]=gettime()+140;
			pInfo[playerid][lasttrob]=0;
			return SendClientMessage(playerid, COLOR_LIGHTBLUE, "Vous avez échoué toute vos tentatives! Vous pourrez ré-essayer dans deux minutes et 40 secondes!");
		}

		new dialog[500], title[97], ins[80];
		new ch[7];
		format(dialog, sizeof(dialog), "Vous êtes en train de voler un véhicule!\nVous devez trouver le code à %d chiffre qui dévérouillera le véhicule.", strlen(vInfo[vehicleid][vcode]));
		if(strlen(inputtext)==strlen(vInfo[vehicleid][vcode])) {
			for(new i=0;i<strlen(inputtext)&&i<strlen(vInfo[vehicleid][vcode]);i++)
			{
			    if(inputtext[i]==vInfo[vehicleid][vcode][i])
				{
					ch[i]=1;
			        format(ins, sizeof(ins), "%s{4FDB37}%c", ins, inputtext[i]);
				}
				if(ch[i] != 1 && cfind(vInfo[vehicleid][vcode], inputtext[i]) != i &&
				   cfind(vInfo[vehicleid][vcode], inputtext[i]) != -1)
	   			{
					ch[i]=1;
				    format(ins, sizeof(ins), "%s{DBB818}%c", ins, inputtext[i]);
				}
			 	else if(ch[i]!=1)
			 	{
			 		ch[i]=1;
				 	format(ins, sizeof(ins), "%s{E03434}%c", ins, inputtext[i]);
			 	}
			}
			format(dialog, sizeof(dialog), "%s\n{A9C4E4}Code tapé: %s{A9C4E4}. {%s}%d {A9C4E4}essais restants.\n{4FDB37}Vert{A9C4E4} = Chiffre présent et bien placé.\n{DBB818}Jaune{A9C4E4} = Chiffre présent mais mal placé.", dialog, ins, (vInfo[vehicleid][vtry]>3) ? ("4FDB37") : ("E03434"), vInfo[vehicleid][vtry]);
			format(dialog, sizeof(dialog), "%s\n{E03434}Rouge{A9C4E4} = Chiffre non présent.\n{E03434}", dialog);
			format(dialog, sizeof(dialog), "%s/!\\ Un code ne contient jamais deux fois le même chiffre ! /!\\ \n /!\\ Un chiffre apparaîtra en jaune si il n'est présent qu'une fois mais que vous l'écrivez deux fois ! /!\\", dialog);
			format(title, sizeof(title), "Vol de véhicule - %s", ins);
			vInfo[vehicleid][vtry]--;
		}
		else {
			format(dialog, sizeof(dialog), "%s\n{A9C4E4}Code tapé: {FF0000}ERREUR{A9C4E4}. {%s}%d {A9C4E4}essais restants.\n{4FDB37}Vert{A9C4E4} = Chiffre présent et bien placé.\n{DBB818}Jaune{A9C4E4} = Chiffre présent mais mal placé.", dialog, (vInfo[vehicleid][vtry]>3) ? ("4FDB37") : ("E03434"), vInfo[vehicleid][vtry]);
			format(dialog, sizeof(dialog), "%s\n{E03434}Rouge{A9C4E4} = Chiffre non présent.\n{E03434}", dialog);
			format(dialog, sizeof(dialog), "%s/!\\ Un code ne contient jamais deux fois le même chiffre ! /!\\\n/!\\La longueur de ce que vous avez entré n'est pas celle du code ! /!\\", dialog);
			format(title, sizeof(title), "Vol de véhicule - %s", ins);
		}
		ShowPlayerDialog(playerid, DIALOG_CARJACK, DIALOG_STYLE_INPUT, "Vol de véhicule", dialog, "Essayer", "Quitter");
		return 1;
	}


	if(dialogid==DIALOG_BUYVEH)
	{
	    if(!response) return 1;
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
		if(GetPlayerCheckpoint(playerid)!=CP_BUYVEH)
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans un checkpoint d'achat de véhicule !");
        new price=-1, model=-1, vname[40]="Véhicule";
		switch(listitem)
		{
			case 0:
			{
			    vname="Infernus";
			    model=411;
			    price=250000;
			}
 			case 1:
			{
			    vname="Turismo";
			    model=451;
			    price=225000;
			}
 			case 2:
			{
			    vname="Super GT";
			    model=506;
			    price=230000;
			}
  			case 3:
			{
			    vname="Bullet";
			    model=541;
			    price=225000;
			}
 			case 4:
			{
			    vname="Hotring Racer";
			    model=494;
			    price=400000;
			}
			case 5:
			{
			    vname="Buffalo";
			    model=402;
			    price=200000;
			}
			case 6:
			{
			    vname="Stretch";
			    model=409;
			    price=125000;
			}
			case 7:
			{
			    vname="Cheetah";
			    model=415;
			    price=175000;
			}
			case 8:
			{
			    vname="Banshee";
			    model=429;
			    price=175000;
			}
			case 9:
			{
			    vname="ZR-350";
			    model=477;
			    price=175000;
			}
			case 10:
			{
			    vname="Comet";
			    model=480;
			    price=150000;
			}
		}
		if(GetPlayerMoney(playerid)<price)
			return SendClientMessage(playerid, COLOR_ERROR, "Vous n'avez pas assez d'argent sur vous !");
		if(!(model >= 400 && model <= 611))
		    return SendClientMessage(playerid, COLOR_ERROR, "Le véhicule est invalide !");
		GivePlayerMoney(playerid, -price);
		new rand=random(sizeof(BuyvehPos));
		new vid = CreateVehicle(model, BuyvehPos[rand][0], BuyvehPos[rand][1], BuyvehPos[rand][2], BuyvehPos[rand][3], 0, 1, -1);
		vInfo[vid][P_UID]=pInfo[playerid][UID];
		vInfo[vid][UID]=CreateVehicleStats(vid);
		vInfo[vid][TEAM]=-1;
		vInfo[vid][destroyed]=false;
		vInfo[vid][assured]=false;
		vInfo[vid][gps]=false;
		PutPlayerInVehicle(playerid, vid, 0);
		SaveVehicleStats(vid);
		new msg[128];
		format(msg, sizeof(msg), "Vous avez bien acheté un(e) %s au prix de %s !", vname, FormatMoney(price));
		return SendClientMessage(playerid, COLOR_GREEN, msg);
	}

	if(dialogid==DIALOG_PUTMONEY)
	{
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
	    if(!response) return 1;
		if(GetPlayerCheckpoint(playerid)!=CP_BANQUE)
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans un checkpoint de banque !");
	    new amount=0;
   		if(sscanf(inputtext, "i", amount))
		{
		 	ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_INPUT, "Déposer de l'argent", "Entrez la quantité d'argent à retirer.\n{FF0000}Vous devez entrer un nombre !", "Retirer", "Annuler");
			return 1;
		}
		if(amount<=0)
		{
		 	ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_INPUT, "Déposer de l'argent", "Entrez la quantité d'argent à retirer.\n{FF0000}Vous devez entrer un nombre plus grand que 0 !", "Retirer", "Annuler");
			return 1;
		}
		if(amount>GetPlayerMoney(playerid))
		{
		 	ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_INPUT, "Déposer de l'argent", "Entrez la quantité d'argent à retirer.\n{FF0000}Vous n'avez pas autant d'argent à déposer !", "Retirer", "Annuler");
			return 1;
		}
		pInv[playerid][BANK_CASH]+=amount;
		GivePlayerMoney(playerid, -amount);
		new msg[128];
		format(msg, sizeof(msg), "Vous avez correctement déposé {FF0000}%s{A9C4E4} à la banque", FormatMoney(amount));
		ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_MSGBOX, "Informations", msg, "Retirer", "Annuler");
	}

	if(dialogid==DIALOG_GETMONEY)
	{
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
	    if(!response) return 1;
		if(GetPlayerCheckpoint(playerid)!=CP_BANQUE)
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans un checkpoint de banque !");
	    new amount=0;
   		if(sscanf(inputtext, "i", amount))
		{
		 	ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_INPUT, "Retirer de l'argent", "Entrez la quantité d'argent à retirer.\n{FF0000}Vous devez entrer un nombre !", "Retirer", "Annuler");
			return 1;
		}
		if(amount<=0)
		{
		 	ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_INPUT, "Retirer de l'argent", "Entrez la quantité d'argent à retirer.\n{FF0000}Vous devez entrer un nombre plus grand que 0 !", "Retirer", "Annuler");
			return 1;
		}
		if(amount>pInv[playerid][BANK_CASH])
		{
		 	ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_INPUT, "Retirer de l'argent", "Entrez la quantité d'argent à retirer.\n{FF0000}Vous n'avez pas autant d'argent à retirer !", "Retirer", "Annuler");
			return 1;
		}
		pInv[playerid][BANK_CASH]-=amount;
		GivePlayerMoney(playerid, amount);
		new msg[128];
		format(msg, sizeof(msg), "Vous avez correctement retiré {FF0000}%s{A9C4E4} à la banque", FormatMoney(amount));
		ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_MSGBOX, "Informations", msg, "Retirer", "Annuler");
	}

	if(dialogid==DIALOG_BANQUE)
	{
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
	    if(!response) return 1;
		if(GetPlayerCheckpoint(playerid)!=CP_BANQUE)
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans le checkpoint de la banque !");
		switch(listitem)
		{
		    case 0:
		    	ShowPlayerDialog(playerid, DIALOG_PUTMONEY, DIALOG_STYLE_INPUT, "Déposer de l'argent", "Entrez la quantité d'argent à déposer.", "Déposer", "Annuler");
			case 1:
		    	ShowPlayerDialog(playerid, DIALOG_GETMONEY, DIALOG_STYLE_INPUT, "Retirer de l'argent", "Entrez la quantité d'argent à retirer.", "Retirer", "Annuler");
			case 2:
			{
			    new dialog[600];
			    format(dialog, sizeof(dialog), "Titulaire du compte: {FF0000}%s{A9C4E4}\nArgent sur le compte en banque: {FF0000}%s", pInfo[playerid][name], FormatMoney(pInv[playerid][BANK_CASH]));
			    ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Informations du Compte en banque", dialog, "OK", "");
			}
		}
	    return 1;
	}

	if(dialogid==DIALOG_ATM)
	{
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
	    if(!response) return 1;
		new cp=GetPlayerCheckpoint(playerid);
		if(cp!=CP_ATM1&&cp!=CP_ATM2&&cp!=CP_ATM3&&cp!=CP_ATM4&&cp!=CP_ATM5)
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous devez être dans un checkpoint d'ATM !");

	    new amount=0, dialog[256];
   		if(sscanf(inputtext, "i", amount))
		{
		    format(dialog, sizeof(dialog), "Entrez la quantité d'argent à retirer\nVous avez {FF0000}%s{A9C4E4} en banque.\n{FF0000}Vous devez entrer un nombre !", FormatMoney(pInv[playerid][BANK_CASH]));
		 	ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_INPUT, "Retirer de l'argent", dialog, "Retirer", "Annuler");
			return 1;
		}
		if(amount<=0)
		{
		    format(dialog, sizeof(dialog), "Entrez la quantité d'argent à retirer\nVous avez {FF0000}%s{A9C4E4} en banque.\n{FF0000}Vous devez entrer un nombre plus grand que 0 !", FormatMoney(pInv[playerid][BANK_CASH]));
		 	ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_INPUT, "Retirer de l'argent", dialog, "Retirer", "Annuler");
			return 1;
		}
		if(amount>pInv[playerid][BANK_CASH])
		{
		    format(dialog, sizeof(dialog), "Entrez la quantité d'argent à retirer\nVous avez {FF0000}%s{A9C4E4} en banque.\n{FF0000}Vous n'avez pas autant d'argent en banque !", FormatMoney(pInv[playerid][BANK_CASH]));
		 	ShowPlayerDialog(playerid, DIALOG_ATM, DIALOG_STYLE_INPUT, "Retirer de l'argent", dialog, "Retirer", "Annuler");
			return 1;
		}
		pInv[playerid][BANK_CASH]-=amount;
		GivePlayerMoney(playerid, amount);
		new msg[128];
		format(msg, sizeof(msg), "Vous avez retiré %s dans un ATM.", FormatMoney(amount));
		SendClientMessage(playerid, COLOR_GREEN, msg);
		return 1;
	}

	if(dialogid==DIALOG_PUTSAC)
	{
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
	    if(!response) return 1;
	    new amount=0;
	    if(pPut[playerid]==0)
	    {
	        if(sscanf(inputtext, "i", amount))
	        {
		     	ShowPlayerDialog(playerid, DIALOG_PUTSAC, DIALOG_STYLE_INPUT, "Ajouter de l'argent", "Entrez la quantité d'argent à ajouter.\n{FF0000}Vous devez entrer un nombre !", "OK", "Annuler");
				return 1;
			}
			if(amount<=0)
			{
		     	ShowPlayerDialog(playerid, DIALOG_PUTSAC, DIALOG_STYLE_INPUT, "Ajouter de l'argent", "Entrez la quantité d'argent à ajouter.\n{FF0000}Vous devez entrer un nombre plus grand que 0 !", "OK", "Annuler");
				return 1;
			}
			if(amount>GetPlayerMoney(playerid))
			{
		     	ShowPlayerDialog(playerid, DIALOG_PUTSAC, DIALOG_STYLE_INPUT, "Ajouter de l'argent", "Entrez la quantité d'argent à ajouter.\n{FF0000}Vous n'avez pas assez d'argent à ajouter !", "OK", "Annuler");
   			 	return 1;
			}
			if(amount+pInv[playerid][SAC_CASH]>3000000)
			{
		     	ShowPlayerDialog(playerid, DIALOG_PUTSAC, DIALOG_STYLE_INPUT, "Ajouter de l'argent", "Entrez la quantité d'argent à ajouter.\n{FF0000}Votre sac ne peut contenir que $3,000,000 maximum !", "OK", "Annuler");
   			 	return 1;
			}
			pInv[playerid][SAC_CASH]+=amount;
			GivePlayerMoney(playerid, -amount);
			new msg[128];
			format(msg, sizeof(msg), "Vous avez mit %s dans votre sac !", FormatMoney(amount));
			SendClientMessage(playerid, COLOR_GREEN, msg);
		}
	    if(pPut[playerid]==1)
	    {
	        if(sscanf(inputtext, "i", amount))
	        {
		     	ShowPlayerDialog(playerid, DIALOG_PUTSAC, DIALOG_STYLE_INPUT, "Prendre de l'argent", "Entrez la quantité d'argent à prendre.\n{FF0000}Vous devez entrer un nombre !", "OK", "Annuler");
				return 1;
			}
			if(amount<=0)
			{
		     	ShowPlayerDialog(playerid, DIALOG_PUTSAC, DIALOG_STYLE_INPUT, "Prendre de l'argent", "Entrez la quantité d'argent à prendre.\n{FF0000}Vous devez entrer un nombre plus grand que 0 !", "OK", "Annuler");
				return 1;
			}
			if(amount>pInv[playerid][SAC_CASH])
			{
		     	ShowPlayerDialog(playerid, DIALOG_PUTSAC, DIALOG_STYLE_INPUT, "Prendre de l'argent", "Entrez la quantité d'argent à prendre.\n{FF0000}Vous n'avez pas assez d'argent à prendre !", "OK", "Annuler");
   			 	return 1;
			}
			pInv[playerid][SAC_CASH]-=amount;
			GivePlayerMoney(playerid, amount);
			new msg[128];
			format(msg, sizeof(msg), "Vous avez pris %s de votre sac !", FormatMoney(amount));
			SendClientMessage(playerid, COLOR_GREEN, msg);
		}
	}
	if(dialogid==DIALOG_PICKSAC)
	{
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
	    if(!response) return 1;
	    new amount=0;
		if(pPick[playerid]==1)
		{
			if(!IsPlayerCrimi(playerid))
			{
				ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Action impossible", "{FF0000}Vous ne pouvez pas faire ça si vous n'êtes pas criminel !", "OK", "");
				return 1;
			}
	        if(sscanf(inputtext, "i", amount))
	        {
		     	ShowPlayerDialog(playerid, DIALOG_PICKSAC, DIALOG_STYLE_INPUT, "Prendre des C4", "Entrez un nombre de C4 à prendre.\nVous devez entrer un nombre !", "OK", "Annuler");
				return 1;
			}
			if(amount<=0)
			{
		     	ShowPlayerDialog(playerid, DIALOG_PICKSAC, DIALOG_STYLE_INPUT, "Prendre des C4", "Entrez un nombre de C4 à prendre.\nVous devez entrer un nombre plus grand que 0 !", "OK", "Annuler");
				return 1;
			}
			if(amount>pInv[playerid][SAC_C4])
			{
		     	ShowPlayerDialog(playerid, DIALOG_PICKSAC, DIALOG_STYLE_INPUT, "Prendre des C4", "Entrez un nombre de C4 à prendre.\nVous n'avez pas assez de C4 !", "OK", "Annuler");
   			 	return 1;
			}
			pInv[playerid][SAC_C4]-=amount;
   			pInv[playerid][C4]+=amount;
			new msg[128];
			format(msg, sizeof(msg), "Vous avez pris %d C4 de votre sac !", amount);
			SendClientMessage(playerid, COLOR_GREEN, msg);
		}
		else
		{
			if(!IsPlayerCrimi(playerid))
			{
				ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Action impossible", "{FF0000}Vous ne pouvez pas faire ça si vous n'êtes pas criminel !", "OK", "");
				return 1;
			}
	        if(sscanf(inputtext, "i", amount))
	        {
		     	ShowPlayerDialog(playerid, DIALOG_PICKSAC, DIALOG_STYLE_INPUT, "Prendre des cordes", "Entrez un nombre de cordes à prendre.\nVous devez entrer un nombre !", "OK", "Annuler");
				return 1;
			}
			if(amount<=0)
			{
		     	ShowPlayerDialog(playerid, DIALOG_PICKSAC, DIALOG_STYLE_INPUT, "Prendre des cordes", "Entrez un nombre de cordes à prendre.\nVous devez entrer un nombre plus grand que 0 !", "OK", "Annuler");
				return 1;
			}
			if(amount>pInv[playerid][SAC_ROPES])
			{
		     	ShowPlayerDialog(playerid, DIALOG_PICKSAC, DIALOG_STYLE_INPUT, "Prendre des C4", "Entrez un nombre de C4 à prendre.\nVous n'avez pas assez de C4 !", "OK", "Annuler");
				return 1;
			}
			pInv[playerid][SAC_ROPES]-=amount;
			pInv[playerid][ROPES]+=amount;
			new msg[128];
			format(msg, sizeof(msg), "Vous avez pris %d cordes de votre sac !", amount);
			SendClientMessage(playerid, COLOR_GREEN, msg);
		}
	    return 1;
	}

	if(dialogid==DIALOG_SAC)
	{
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
	    if(!response) return 1;
	    switch(listitem)
	    {
			case 0:
			{
				if(!IsPlayerCrimi(playerid))
				{
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Action impossible", "{FF0000}Vous ne pouvez pas faire ça si vous n'êtes pas criminel !", "OK", "");
					return 1;
				}
			    if(pInv[playerid][ROPES]<=0)
			    {
			        ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Action impossible", "{FF0000}Vous n'avez aucune cordes sur vous à ajouter !", "OK", "");
			        return 1;
			    }
			    pInv[playerid][SAC_ROPES]+=pInv[playerid][ROPES];
			    pInv[playerid][ROPES]=0;
				SendClientMessage(playerid, COLOR_GREEN, "Vous avez ajouté toutes vos cordes dans votre sac !");
			}
			case 1:
			{
				if(!IsPlayerCrimi(playerid))
				{
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Action impossible", "{FF0000}Vous ne pouvez pas faire ça si vous n'êtes pas criminel !", "OK", "");
					return 1;
				}
			    if(pInv[playerid][C4]<=0)
			    {
			        ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Action impossible", "{FF0000}Vous n'avez aucun C4 sur vous à ajouter !", "OK", "");
			        return 1;
			    }
			    pInv[playerid][SAC_C4]+=pInv[playerid][C4];
			    pInv[playerid][C4]=0;
				SendClientMessage(playerid, COLOR_GREEN, "Vous avez ajouté tout votre C4 dans votre sac !");
			}
			case 2:
			{
				if(!IsPlayerCrimi(playerid))
				{
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Action impossible", "{FF0000}Vous ne pouvez pas faire ça si vous n'êtes pas criminel !", "OK", "");
					return 1;
				}
			    if(pInv[playerid][SAC_ROPES]<=0)
			    {
			        ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Action impossible", "{FF0000}Vous n'avez aucune cordes dans votre sac à prendre !", "OK", "Annuler");
			        return 1;
			    }
			    pPick[playerid]=0;
		     	ShowPlayerDialog(playerid, DIALOG_PICKSAC, DIALOG_STYLE_INPUT, "Prendre des cordes", "Entrez un nombre de cordes à prendre.", "OK", "Annuler");
			}
			case 3:
			{
				if(!IsPlayerCrimi(playerid))
				{
					ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Action impossible", "{FF0000}Vous ne pouvez pas faire ça si vous n'êtes pas criminel !", "OK", "");
					return 1;
				}
			    if(pInv[playerid][SAC_C4]<=0)
			    {
			        ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Action impossible", "{FF0000}Vous n'avez aucun C4 dans votre sac à prendre !", "OK", "Annuler");
			        return 1;
			    }
			    pPick[playerid]=1;
		     	ShowPlayerDialog(playerid, DIALOG_PICKSAC, DIALOG_STYLE_INPUT, "Prendre des C4", "Entrez un nombre de C4 à prendre.", "OK", "Annuler");
			}
			case 4:
			{
				if(GetPlayerMoney(playerid)<=0)
				{
			        ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Action impossible", "{FF0000}Vous n'avez pas d'argent à ajouter !", "OK", "Annuler");
			        return 1;
				}
				pPut[playerid]=0;
		     	ShowPlayerDialog(playerid, DIALOG_PUTSAC, DIALOG_STYLE_INPUT, "Ajouter de l'argent", "Entrez la quantité d'argent à ajouter.", "OK", "Annuler");
			}
			case 5:
			{
				if(pInv[playerid][SAC_CASH]<=0)
				{
			        ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Action impossible", "{FF0000}Vous n'avez pas d'argent dans le sac à prendre !", "OK", "Annuler");
			        return 1;
				}
				pPut[playerid]=1;
		     	ShowPlayerDialog(playerid, DIALOG_PUTSAC, DIALOG_STYLE_INPUT, "Prendre de l'argent", "Entrez la quantité d'argent à prendre.", "OK", "Annuler");

			}
			case 6:
			{
			    cmd_inv(playerid, " ");
			    return 1;
			}
	    }

	    return 1;
	}
	if(dialogid==DIALOG_BUY)
	{
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
		if(!response) return 1;
		if(GetPlayerCheckpoint(playerid)!=CP_24/7&&GetPlayerCheckpoint(playerid)!=CP_ROBOIS)
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans un checkpoint de 24/7 !");
	    new amount=0, dialog[380];
	    switch(pNextBuy[playerid])
	    {
	        case -1:return 1;
	        case 0:
	        {
	            if(sscanf(inputtext, "i", amount))
	            {
					ShowPlayerDialog(playerid, DIALOG_BUY, DIALOG_STYLE_INPUT, "Passage à la caisse", "{A9C4E4}Achat de: {FF0000}Cordes{A9C4E4}\nPrix à l'unité: {FF0000}$750\nVous devez entrer un chiffre !", "Acheter", "Annuler");
					return 1;
				}
				if(amount<=0)
	            {
					ShowPlayerDialog(playerid, DIALOG_BUY, DIALOG_STYLE_INPUT, "Passage à la caisse", "{A9C4E4}Achat de: {FF0000}Cordes{A9C4E4}\nPrix à l'unité: {FF0000}$750\nVous devez entrer un chiffre plus grand que zéro !", "Acheter", "Annuler");
					return 1;
				}
				if(GetPlayerMoney(playerid)<(750*amount))
	            {
					ShowPlayerDialog(playerid, DIALOG_BUY, DIALOG_STYLE_INPUT, "Passage à la caisse", "{A9C4E4}Achat de: {FF0000}Cordes{FFFFFF}\nPrix à l'unité: {FF0000}$750\nVous n'avez pas assez d'argent !", "Acheter", "Annuler");
					return 1;
				}
				pInv[playerid][ROPES]+=amount;
				GivePlayerMoney(playerid, -(750*amount));
				format(dialog, sizeof(dialog), "{A9C4E4}Articles achetés: {FF0000}Cordes (%dx)\n{A9C4E4}Coût total: {FF0000}%s", amount, FormatMoney(amount*750));
				ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Ticket de caisse", dialog, "Continuer", "");
	        }
	        case 1:
	        {
				if(GetPlayerMoney(playerid)<1200)
	            {
					ShowPlayerDialog(playerid, DIALOG_BUY, DIALOG_STYLE_INPUT, "Passage à la caisse", "{A9C4E4}Achat de: {FF0000}paire de Ciseaux{A9C4E4}\nPrix à l'unité: {FF0000}$1,200\nVous n'avez pas assez d'argent !", "Acheter", "Annuler");
					return 1;
				}
				if(pInv[playerid][scissors])
				    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà une paire de ciseaux sur vous!");
                pInv[playerid][scissors]=true;
				GivePlayerMoney(playerid, -1200);
				format(dialog, sizeof(dialog), "{A9C4E4}Articles acheté: {FF0000}Paire de ciseaux (1x)\n{A9C4E4}Coût total: {FF0000}1200$");
				ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Ticket de caisse", dialog, "Continuer", "");

	        }
 	        case 2:
	        {
	            if(sscanf(inputtext, "i", amount))
	            {
					ShowPlayerDialog(playerid, DIALOG_BUY, DIALOG_STYLE_INPUT, "Passage à la caisse", "{A9C4E4}Achat de: {FF0000}Saucisses{A9C4E4}\nPrix à l'unité: {FF0000}$500\nVous devez entrer un chiffre !", "Acheter", "Annuler");
					return 1;
				}
				if(amount<=0)
	            {
					ShowPlayerDialog(playerid, DIALOG_BUY, DIALOG_STYLE_INPUT, "Passage à la caisse", "{A9C4E4}Achat de: {FF0000}Saucisses{A9C4E4}\nPrix à l'unité: {FF0000}$500\nVous devez entrer un chiffre plus grand que zéro !", "Acheter", "Annuler");
					return 1;
				}
				if(GetPlayerMoney(playerid)<(500*amount))
	            {
					ShowPlayerDialog(playerid, DIALOG_BUY, DIALOG_STYLE_INPUT, "Passage à la caisse", "{A9C4E4}Achat de: {FF0000}Saucisses{A9C4E4}\nPrix à l'unité: {FF0000}$500\nVous n'avez pas assez d'argent !", "Acheter", "Annuler");
					return 1;
				}
				GivePlayerMoney(playerid, -(500*amount));
				pInv[playerid][saucisses]+=amount;
				format(dialog, sizeof(dialog), "{A9C4E4}Articles achetés: {FF0000}Saucisses (%dx)\n{A9C4E4}Coût total: {FF0000}%s", amount, FormatMoney(amount*500));
				ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Ticket de caisse", dialog, "Continuer", "");
	        }
	        case 3:
	        {
				if(GetPlayerMoney(playerid)<22500)
	            {
					ShowPlayerDialog(playerid, DIALOG_BUY, DIALOG_STYLE_INPUT, "Passage à la caisse", "{A9C4E4}Achat de: {FF0000}Amplificateur{A9C4E4}\nPrix à l'unité: {FF0000}$22,500\nVous n'avez pas assez d'argent !", "Acheter", "Annuler");
					return 1;
				}
				if(pInv[playerid][amplificator])
				    return SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà une paire de ciseaux sur vous!");
                pInv[playerid][amplificator]=true;
                if(pInfo[playerid][seeid]) {
                    Unload3DID(playerid);
					Load3DID(playerid);
				}
				GivePlayerMoney(playerid, -22500);
				format(dialog, sizeof(dialog), "{A9C4E4}Articles acheté: {FF0000}Amplificateur (1x)\n{A9C4E4}Coût total: {FF0000}22500$");
				ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Ticket de caisse", dialog, "Continuer", "");
	        }
	    }
	}
    new string[1024];
    if(dialogid==DIALOG_24/7)
    {
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
		if(GetPlayerCheckpoint(playerid)!=CP_24/7&&GetPlayerCheckpoint(playerid)!=CP_ROBOIS)
		    return SendClientMessage(playerid, COLOR_ERROR, "Vous n'êtes pas dans un checkpoint de 24/7 !");
        pNextBuy[playerid]=listitem;
        switch(listitem)
        {
            case 0:ShowPlayerDialog(playerid, DIALOG_BUY, DIALOG_STYLE_INPUT, "Passage à la caisse", "{A9C4E4}Achat de: {FF0000}Cordes{A9C4E4}\nPrix à l'unité: {FF0000}$750", "Acheter", "Annuler");
            case 1:ShowPlayerDialog(playerid, DIALOG_BUY, DIALOG_STYLE_MSGBOX, "Passage à la caisse", "{A9C4E4}Achat de: {FF0000}paire de Ciseaux{A9C4E4}\nPrix à l'unité: {FF0000}$1,200", "Acheter", "Annuler");
            case 2:ShowPlayerDialog(playerid, DIALOG_BUY, DIALOG_STYLE_INPUT, "Passage à la caisse", "{A9C4E4}Achat de: {FF0000}Saucisses{A9C4E4}\nPrix à l'unité: {FF0000}$500", "Acheter", "Annuler");
       		case 3:ShowPlayerDialog(playerid, DIALOG_BUY, DIALOG_STYLE_MSGBOX, "Passage à la caisse", "{A9C4E4}Achat de: {FF0000}Amplificateur{A9C4E4}\nPrix à l'unité: {FF0000}$22,500", "Acheter", "Annuler");
        }
        return 1;
    }
	if(dialogid==DIALOG_CONNECT)
	{
		if(!response) {
			Kick(playerid);
   		}
		if(!strlen(inputtext)){
			if(!pRegistered[playerid])
			ShowPlayerDialog(playerid, DIALOG_CONNECT, DIALOG_STYLE_PASSWORD, "Inscription", "{A9C4E4}Ce compte {FF0000}n'existe pas.\n{A9C4E4}Merci d'entrer votre mot de passe pour vos futures connexion.\n{FF0000}Veuillez entrer un mot de passe !", "Inscription", "Quitter");

		 	else{
			    format(string, sizeof(string), "{A9C4E4}Bonjour %s. Votre compte est {FF0000}enregistré.\n{A9C4E4}Veuillez entrer votre mot de passe ci-dessous pour vous connecter.\n{FF0000}Veuillez entrer un mot de passe !",pInfo[playerid][name]);
				ShowPlayerDialog(playerid,15500,DIALOG_STYLE_PASSWORD,"Connexion",string,"Valider","Quitter");
			}
			return 1;
		}

		if(pRegistered[playerid])
		{
	        new escapepass[100]; //
	        mysql_real_escape_string(inputtext, escapepass); //We escape the inputtext to avoid SQL injections.
	        format(string, sizeof(string), "SELECT `pseudo` FROM comptes WHERE pseudo = '%s' AND password = SHA1('%s')", pInfo[playerid][name], escapepass);
	        mysql_query(string);
	        mysql_store_result();
	        new numrows = mysql_num_rows();
	        if(numrows == 1) {
				MySQL_Login(playerid);
				SendClientMessage(playerid,COLOR_LIGHTBLUE,"Vous vous êtes bien connecté sur CRFR, vos statistiques ont été actualisés");
			    ActualiseWantedTD(playerid);
			    if(pInfo[playerid][wanted]>0) SendClientMessage(playerid, GetPlayerColor(playerid), "Vous étiez recherché à votre dernière connexion, vous conservez votre niveau de recherche !");
			}
			mysql_free_result();

   			if(!numrows){
      			if(pLogChance[playerid]<=0) {
					SendClientMessage(playerid, COLOR_ERROR, "Tentatives de connexion échouées!");
					KickP(playerid);
		            return 1;
				}

	            format(string, sizeof(string), "{A9C4E4}Bonjour %s. Votre compte est {FF0000}enregistré.\n{A9C4E4}Veuillez entrer votre mot de passe ci-dessous pour vous connecter.\n{FF0000}Mot de passe incorrect. Essais restants: {FFFFFF}%d",pInfo[playerid][name], pLogChance[playerid]);
				ShowPlayerDialog(playerid,DIALOG_CONNECT,DIALOG_STYLE_PASSWORD,"Connexion",string,"Valider","Quitter");
    			pLogChance[playerid]--;
				return 1;
			}
			return 1;
		}
		else
		{
	        if(strlen(inputtext)==0 || strlen(inputtext) > 100) {
				format(string, sizeof(string),
				"{A9C4E4}Inscription à Cops And Robbers France %s\nVeuillez entrer votre mot de passe ci-dessous pour vous {FF0000}enregistrer.\n{FF0000}Votre mot de passe ne doit pas être trop long ou vide!",pInfo[playerid][name]);
				ShowPlayerDialog(playerid,15000,DIALOG_STYLE_PASSWORD,"Inscription",string,"Valider","Quitter");
			}

	        else if(strlen(inputtext) > 0 && strlen(inputtext) < 100) {
	            new escpass[100];
	            mysql_real_escape_string(inputtext, escpass);
	            MySQL_Register(playerid, escpass);
	            MySQL_Login(playerid);
			    ActualiseWantedTD(playerid);
			    if(pInfo[playerid][wanted]>0) SendClientMessage(playerid, GetPlayerColor(playerid), "Vous étiez recherché à votre dernière connexion, vous conservez votre niveau de recherche !");
			}
    		return 1;
		}
	}
	if(dialogid==DIALOG_METIER)
	{
		if(!IsCanAction(playerid))
	    	return SendClientMessage(playerid, COLOR_ERROR,"Vous ne pouvez pas faire ça maintenant !");
	 	if(!response){
	        ShowPlayerDialog(playerid, DIALOG_METIER, DIALOG_STYLE_LIST, "Sélection de métier", "Voleur - Carjacker\nKidnappeur\nTerroriste\nVioleur\nMercenaire\nHacker", "Choisir", "");
	       	return 1;
		}
		new dialog[1024];
		if(listitem==0)
	 	{
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Job:{FFFFFF}\nVous êtes un Voleur/CarJacker et devez donc voler les véhicules achetés par les autres joueurs.\nCe Job peut être très rentable lors des Tunning ou courses de Drivers.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "Vous pouvez aussi voler les joueurs avec la commande /voler !");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Commandes:{FFFFFF}Faites /cmds pour connaître la liste de vos commandes.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Règles:{FFFFFF}\nVous suivez les mêmes règles que les autres criminels:\n -Deathmatch, carkill, hélikill sont strictement interdit.\n{FF0000}*{FFFFFF} Toute infraction à ces règles entraînera une sanction d' 1 avertissement, ainsi que de 200sec de Jail par DM.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "Plus d'information dans les /regles et /pc du serveur.");
			pInfo[playerid][TEAM]=TEAM_VOLEUR;
		 	ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "INFORMATIONS - VOLEUR/CARJACKER", dialog, "OK", "");
		   	GivePlayerWeapon(playerid,27,250);
			GivePlayerWeapon(playerid,23,100);
			GivePlayerWeapon(playerid,30,500);
		}
		else if(listitem==1)
	 	{
	        format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Job:{FFFFFF}\nVous êtes chargé de kidnapper et d'enlever un maximum de joueurs possibles. \nVous pourrez les transporter dans votre voitures et les lâcher où vous voulez dans la nature.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Commandes:{FFFFFF}Faites /cmds pour connaître la liste de vos commandes.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Règles:{FFFFFF}\nVous suivez les mêmes règles que les autres criminels:\n -Deathmatch, carkill, hélikill sont strictement interdit.\n{FF0000}*{FFFFFF} Toute infraction à ces règles entraînera une sanction d' 1 avertissement, ainsi que de 200sec de Jail par DM.\n{FF0000}ATTENTION !Si vous kidnappé quelqu'un, il a le droit de risposter ! Mais vous n'avez en aucun cas le droit de vous défendre, fuyez !\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Plus d'information dans les /regles et /pc du serveur.");
		 	pInfo[playerid][TEAM]=TEAM_KIDNAP;
        	ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "INFORMATIONS - KIDNAPPEUR", dialog, "OK", "");
   			GivePlayerWeaponEx(playerid,27,250);
			GivePlayerWeaponEx(playerid,23,100);
			GivePlayerWeaponEx(playerid,30,500);
		}
		else if(listitem==2)
		{
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Job:{FFFFFF}\nVous devez exploser les voitures et bâtiment. N'hésitez pas à jouer le kamikaze en piégant des voitures ou explosant des bâtiments entourés de joueurs !\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Commandes:{FFFFFF}Faites /cmds pour connaître la liste de vos commandes.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Règles:{FFFFFF}\nVous suivez les mêmes règles que les autres criminels:\n -Deathmatch, carkill, hélikill sont strictement interdit.\n{FF0000}*{FFFFFF} Toute infraction à ces règles entraînera une sanction d' 1 avertissement, ainsi que de 200sec de Jail par DM.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "Plus d'information dans les /regles et /pc du serveur.");
			pInfo[playerid][TEAM]=TEAM_TERRO;
    		ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "INFORMATIONS - TERRORISTE", dialog, "OK", "");
			GivePlayerWeaponEx(playerid,30,500);
			GivePlayerWeaponEx(playerid,34,60);
		   	GivePlayerWeaponEx(playerid,23,150);
		 	GivePlayerWeaponEx(playerid,5,1);
		}
		else if(listitem==3)
		{
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Job:{FFFFFF}\nVous êtes un délinquant sexuel qui saute sur tout ce qui bouge ! Votre rôle est donc de violer un maximum de personne possible.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Commandes:{FFFFFF}Faites /cmds pour connaître la liste de vos commandes.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Règles:{FFFFFF}\nVous suivez les mêmes règles que les autres criminels:\n -Deathmatch, carkill, hélikill sont strictement interdit.\n{FF0000}*{FFFFFF} Toute infraction à ces règles entraînera une sanction d' 1 avertissement, ainsi que de 200sec de Jail par DM.\n{FF0000}ATTENTION !\nSi vous violez quelqu'un, il a le droit de risposter ! Mais vous n'avez en aucun cas le droit de vous défendre, fuyez !\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Plus d'information dans les /regles et /pc du serveur.");
			pInfo[playerid][TEAM]=TEAM_VIOLEUR;
    		ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "INFORMATIONS - VIOLEUR", dialog, "OK", "");
       		GivePlayerWeaponEx(playerid,22,100);
		    GivePlayerWeaponEx(playerid,4,1);
		}
		else if(listitem==4)
		{
       		format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Job:{FFFFFF}\nLes mercenaires sont très utiles dans les règlements de comptes. Vous êtes chargé de tuer toute personne dont la tête est mise à prix !\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Commandes:{FFFFFF}Faites /cmds pour connaître la liste de vos commandes.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Règles:{FFFFFF}\nVous suivez les mêmes règles que les autres criminels:\n -Deathmatch, carkill, hélikill sont strictement interdit.\n{FF0000}*{FFFFFF} Toute infraction à ces règles entraînera une sanction d' 1 avertissement, ainsi que de 200sec de Jail par DM.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "Plus d'information dans les /regles et /pc du serveur.");
			pInfo[playerid][TEAM]=TEAM_HITMAN;
    		ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "INFORMATIONS - MERCENAIRE", dialog, "OK", "");
			GivePlayerWeaponEx(playerid,27,250);
		    GivePlayerWeaponEx(playerid,23,100);
		    GivePlayerWeaponEx(playerid,31,500);
		    GivePlayerWeaponEx(playerid,5,1);
		}
 		else if(listitem==5)
		{
		    if(GetPlayerScore(playerid) < 50) {
	        	ShowPlayerDialog(playerid, DIALOG_METIER, DIALOG_STYLE_LIST, "Sélection de métier", "Voleur - Carjacker\nKidnappeur\nTerroriste\nVioleur\nMercenaire\nHacker", "Choisir", "");
				SendClientMessage(playerid, COLOR_ERROR, "Vous devez avoir au minimum 50 points de score pour être Hacker !");
		        return 1;
		    }
 			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Job:{FFFFFF}\nVotre but est de voler les ATM et d'exploser les véhicules. Vous pouvez effectuer tout cela a distance.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "et vous pourrez agrémenter votre fuite d'un joli piratage de véhicule, l'immobilisant pendant 10 secondes\nle rendant donc inapte à se lancer dans votre poursuite.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Commandes:{FFFFFF}Faites /cmds pour connaître la liste de vos commandes.\n");
            format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Astuce:{FFFFFF}Vous pouvez acheter un amplificateur au 24/7, qui rendra vos vols plus rapide et augmentera la portée maximale pour effectuer vos actions.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "{4169FF}Règles:{FFFFFF}\nVous suivez les mêmes règles que les autres criminels:\n -Deathmatch, carkill, hélikill sont strictement interdit.\n{FF0000}*{FFFFFF} Toute infraction à ces règles entraînera une sanction d' 1 avertissement, ainsi que de 200sec de Jail par DM.\n");
			format (dialog, sizeof dialog, "%s\n%s", dialog, "Plus d'information dans les /regles et /pc du serveur.");
			pInfo[playerid][TEAM]=TEAM_HACKER;
    		ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "INFORMATIONS - HACKER", dialog, "OK", "");
            GivePlayerWeaponEx(playerid,25,500);
            GivePlayerWeaponEx(playerid,23,250);
	        GivePlayerWeaponEx(playerid,4,1);
			Load3DID(playerid);
			pInfo[playerid][seeid]=true;
		}
		else ShowPlayerDialog(playerid, DIALOG_METIER, DIALOG_STYLE_LIST, "Sélection de métier", "Voleur - Carjacker\nKidnappeur\nTerroriste\nVioleur\nMercenaire\nHacker", "Choisir", "");
		return 1;
	}

	if(dialogid == DIALOG_REGLESMENU && response)
	{
		new Global[2064];
		switch(listitem)
		{
	    	case 0:
	    	{
		    	format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}Le Deathmatching :\n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Le deathMatching souvent appelé DM consiste à tirer sur une personne ou son véhicule sans aucune raison valable.");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Le DM est strictement interdit, quand vous vous faites DM ne criez pas au DM sur le tchat,");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}faites /report [id] (raison) plus d'infos sur /aide.\n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Vous avez le droit de tirer sur une personne et sur son véhicule UNIQUEMENT s'il vous a :");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}Kidnappé - Volé - Violé OU lorsqu'il vous a tiré dessus après que vous l'ayez: Kidnappé - Volé - Violé \n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Si la personne est morte ou que vous êtes mort entre temps, vous n'avez pas le droit de la tuer car");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}ceci est considéré comme un Revenge Kill.\n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}Le Kidnapping : \n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Vous n'avez pas le droit de vous déconnecter en étant kidnappé, que ce soit pour n'importe quelle");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}raison ! Vous avez 2 minutes et 15 secondes à attendre ou alors vous pouvez couper vos cordes si vous avez des ciseaux !\n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Sachez que toute personne se faisant crash volontairement quand elle est");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}kidnappée se fera sanctionner si c'est trop répétitif ! Nous sommes au courant que c'est énervant");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}d'être kidnappé, mais ce n'est pas une raison pour vous déconnecter en kidnapping !\n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}Les Arrestations : \n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Il est strictement interdit de se déconnecter en étant menotté ou détenu par un ou plusieurs policiers.");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Les policiers qui menottent des criminels blancs ou jaunes peuvent les fouiller, mais ils n'ont pas le\n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}droit de les menotter en boucle, ceci s'appel « l'abus de /men » et il est sanctionnable ! ");
				format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}Les insultes : \n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Toutes insulte proférée est interdite, que ce soit une insulte visant un joueur ou un administrateur!");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Nous sommes sur un jeu pour s'amuser et non pour se faire insulter ! ");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Toutes moquerie envers un joueur, une connaissance d'un joueur ou n'importe qui qui peut énerver un joueur est interdites !");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Toutes provocation envers un administrateur ou un joueur est interdite ! ");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Tout caractères homophobes, xénophobes ou racistes ainsi que tout autre commentaire déplacé sont prohibés !");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Il est interdit de manquer de respect aux autres joueurs et aux administrateurs.");
				format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}La Pub : \n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Toutes personnes étant en train de faire de la pub pour n'importe quel autre serveur se verront");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}sanctionner d'un bannissement temporaire d'une durée d'un mois minimum, pouvant aller jusqu'à un bannissement définitif.");

				ShowPlayerDialog(playerid,DIALOG_REGLESCLASSES,DIALOG_STYLE_MSGBOX,"{FF0000}REGLES CLASSES",Global,">>","");
	    	}
	    	case 1:
	    	{
				format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}Les forces de l'ordre :\n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}En tant que policier, vous n'avez pas le droit de tirer sur les civils en blanc et/ou en jaune.");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Vous pouvez les menotter pour les fouiller mais vous avez l'OBLIGATION de les démenotter après la fouille.");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Vous pouvez tuer et/ou arrêter les criminels recherchés étant de couleur orange ou rouge.\n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Vous n'avez pas le droit de suspecter des civils pour des raisons futiles.");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Tout abus concernant le /suspect sera sévèrement sanctionné!\n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}Les barrages & herses : \n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Toutes herses et/ou barrages doivent être surveillés par la ou les personne(s) qui les ont posé ! ");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Si un barrage et/ou une herse n'est pas surveillé, un Administrateur peut les enlever");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}à tout moment et celui qui les a posé s'expose à des sanctions !");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Aucun barrage et/ou herse ne doit bloquer complètement un chemin !");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Vous devez laisser un accès au minimum !\n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}Les militaires : \n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Les militaires peuvent tuer les criminels rouges et oranges quand ils le veulent.");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Vous devez informer les autres joueurs que vous allez tirer si vous voyez un rouge avec la phrase suivante :");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}« Écartez-vous des rouges ou vous serrez tués avec eux. » Attention ce n'est pas une");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}raison pour tuer les joueurs de couleur blancs, jaunes ou oranges. Vous n'avez pas le droit de bombarder un QG.\n");
				ShowPlayerDialog(playerid,DIALOG_ALL,DIALOG_STYLE_MSGBOX,"{FF0000}REGLES FORCES DE L'ORDRE",Global,"Fermer","");
			}
	        case 2:
	        {
	            format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}Vous ne devez pas :\n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• DM (Deathmatch) sans raison : Tuer, voler, violer, kidnapper un de vos coéquipier s'il n'est pas d'accord ou si le serveur ne vous le permet pas.");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Rentrer dans le QG de votre team sans porter le skin du Gang.");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Bloquer l'entrée d'un QG.");
				format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}Vous devez : \n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Faire sortir les civils de votre QG, vous devez leur laisser 1 minute avant de pouvoir les tuer. ");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Écouter vos supérieurs, ne pas désobéir aux ordres.\n");
				format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Quand vous êtes Flic, vous jouez votre rôle de flic ! Aucune alliance n'est autorisée.");
				ShowPlayerDialog(playerid,DIALOG_ALL,DIALOG_STYLE_MSGBOX,"{FF0000}REGLES GANGS",Global,"Fermer","");
	        }
	        case 3:
	        {
	            format(Global, sizeof Global, "Le système de compétences permet d'avoir des avantages");
	            format(Global, sizeof Global, "%s\nTous les 30 points que vous gagnez, vous gagnez un niveau et un point de compétence", Global);
	            format(Global, sizeof Global, "%s\nVous pourrez dépenser ces points de dans des compétences, chaque compétence coûte un point.", Global);
	            format(Global, sizeof Global, "%s\nNéanmoins, certaines compétences ont plusieurs niveaux, chaque niveau coûte un point, tâchez donc de bien répartir vos points.", Global);
				ShowPlayerDialog(playerid, DIALOG_ALL, DIALOG_STYLE_MSGBOX, "Informations Compétences", Global, "OK", "");
	        }
		}
	}

	if(dialogid == DIALOG_REGLESCLASSES)
    {
        new Global[1024];

        if(!response)return 1;
	  	format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}La commande AFK : \n");
		format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Toutes personnes qui utilisent le /afk pour se protéger d'une chute, d'un policier qui veut l'arrêter ou");
		format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}autres se verront retirer leur statut V.I.P comme précisé sur le forum dans la partie adéquate.\n");
		format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}Les cheats & mods : \n");
		format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Il est interdit de se connecter sur le serveur avec un logiciel qui vous donne un avantage sur les");
		format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}autres joueurs (Cheats, binds, mods...).\n");
		format (Global, sizeof Global, "%s\n%s", Global, "{FF0000}Alliance Flics & Criminels : \n");
		format (Global, sizeof Global, "%s\n%s", Global, "{FFFFFF}• Aucune alliance entre un Flic et un Criminel de couleur orange ou rouge n'est autorisée.\n");
		ShowPlayerDialog(playerid,DIALOG_ALL,DIALOG_STYLE_MSGBOX,"{FF0000}REGLES CLASSES", Global, "Fermer", "");
  		return 1;
	 }
	return 0;
}

stock GetVehicleModelByName(vname[]) {
for( new i = 0; i < 212; i++) {
if(strfind(VehicleNames[i], vname, true) != -1) {
return i+400;
}
}
return 0;
}

stock SetSuccess(playerid, id, bool:value=true)
{
	if(playerid==INVALID_PLAYER_ID) return -1;
	if(id>strlen(pInfo[playerid][success])) return false;
	pInfo[playerid][success][id]=(value) ? ('1') : ('0');
	OnSuccessWin(playerid, id);
	return 1;
}

stock GetSuccess(playerid, id)
{
	if(playerid==INVALID_PLAYER_ID) return -1;
	if(id>strlen(pInfo[playerid][success])) return -1;
	return (pInfo[playerid][success][id]=='0') ? (false) : (true);
}

stock SetCompetence(playerid, id, value=1)
{
	if(playerid==INVALID_PLAYER_ID) return -1;
	if(id>strlen(pComp[playerid][competences])) return false;
	switch(value)
	{
	    case 0:pComp[playerid][competences][id]='0';
	    case 1:pComp[playerid][competences][id]='1';
	    case 2:pComp[playerid][competences][id]='2';
	    case 3:pComp[playerid][competences][id]='3';
	    case 4:pComp[playerid][competences][id]='4';
	    case 5:pComp[playerid][competences][id]='5';
	    case 6:pComp[playerid][competences][id]='6';
	    case 7:pComp[playerid][competences][id]='7';
	    case 8:pComp[playerid][competences][id]='8';
	    case 9:pComp[playerid][competences][id]='9';
	}
	return 1;
}

stock GetCompetence(playerid, id)
{
	if(playerid==INVALID_PLAYER_ID) return -1;
	if(id>strlen(pComp[playerid][competences])) return -1;
	switch(pComp[playerid][competences][id])
	{
	    case '0': return 0;
	    case '1': return 1;
	    case '2': return 2;
	    case '3': return 3;
	    case '4': return 4;
	    case '5': return 5;
	    case '6': return 6;
	    case '7': return 7;
	    case '8': return 8;
	    case '9': return 9;
	}
	return (pComp[playerid][competences][id]=='0') ? (false) : (true);
}

public OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid)) return 1;
	if(ShowBan(playerid)) return 1;
	DeleteMapping(playerid);
	ChangeVersionColor();
	pMsg[playerid] = CreatePlayerTextDraw(playerid, 22.000000, 114.000000, "Message");
	PlayerTextDrawBackgroundColor(playerid, pMsg[playerid], 1313755423);
	PlayerTextDrawFont(playerid, pMsg[playerid], 1);
	PlayerTextDrawLetterSize(playerid, pMsg[playerid], 0.250000, 1.000000);
	PlayerTextDrawColor(playerid, pMsg[playerid], -1);
	PlayerTextDrawSetOutline(playerid, pMsg[playerid], 0);
	PlayerTextDrawSetProportional(playerid, pMsg[playerid], 1);
	PlayerTextDrawUseBox(playerid, pMsg[playerid], 1);
	PlayerTextDrawBoxColor(playerid, pMsg[playerid], 255);
	PlayerTextDrawTextSize(playerid, pMsg[playerid], 138.000000, 4.000000);

	TextDrawShowForPlayer(playerid, VersionTD);
	//TogglePlayerClock(playerid,1);

	FurtivBar[playerid] = CreatePlayerProgressBar(playerid, 502.000000, 120.000000, 103, 8, 0xFFFFFFFF, 100.0);
	HackATMT[playerid] = CreatePlayerProgressBar(playerid, 271.0, 410.000000, 110, 8, 0xDFB302FF, 100.0);

	SetPlayerColor(playerid, PlayerColors[playerid]);
    wantedtd[playerid] = CreatePlayerTextDraw(playerid, 502.000000, 105.000000, "Niveau de recherche: 0");
    PlayerTextDrawFont(playerid, wantedtd[playerid], 1);
    PlayerTextDrawLetterSize(playerid, wantedtd[playerid], 0.260000, 1.100000);
    PlayerTextDrawSetOutline(playerid, wantedtd[playerid], 1);
    PlayerTextDrawSetShadow(playerid, wantedtd[playerid], 5);

    ResetPlayerVariables(playerid);
	GetPlayerName(playerid, pInfo[playerid][name], MAX_PLAYER_NAME+1);
	pLogChance[playerid]=3;
	new string[256];
	format(string,sizeof(string),"Bienvenue sur CRFR - Flics et Criminels %s !", SERVER_VERSION);
	SendClientMessage(playerid,COLOR_LIGHTBLUE,string);
	SendClientMessage(playerid,COLOR_WHITE,"- - - - -");
	SendClientMessage(playerid,COLOR_LIGHTGREYBLUE,"Vous êtes sur un serveur Flics et Criminels, merci de respecter les régles de ce mode de jeu");
	SendClientMessage(playerid,COLOR_SLIME,"Pour consulter le règlement faites /regles à tout moment.");
	SendClientMessage(playerid,COLOR_SLIME,"Pour connaître les commandes du serveur nous t'invitons à taper /gcmds");
	SendClientMessage(playerid,COLOR_GREEN,"{FFFFFF}Amusez vous bien sur CRFR {1585DF}Flics {FFFFFF}et {FF0000}Criminels.");
	SendClientMessage(playerid,COLOR_GREEN,"Version bêta, si vous voyez un bug merci de le signaler sur le forum ou a un Administrateur");
	SendClientMessage(playerid,COLOR_WHITE,"- - - - -");

	format(string, sizeof(string), "%s(%d) vient de se connecter sur CRFR - Flics et Criminels !", pInfo[playerid][name], playerid);
	SendClientMessageToAll(COLOR_DARKGREY, string);

	new query[200];
 	format(query, sizeof(query), "SELECT IP FROM `comptes` WHERE pseudo = '%s' LIMIT 1", pInfo[playerid][name]);
	mysql_query(query);
 	mysql_store_result();
	new rows = mysql_num_rows();
	if(rows==0){
  		SendClientMessage(playerid, COLOR_ERROR,"Ce nom de joueur n'est pas enregistré. Merci d'entrer votre mot de passe pour vous enregistrer.");
		pRegistered[playerid]=false;
		new dialog[256];
		format(dialog, sizeof(dialog), "{FFFFFF}Inscription à Cops And Robbers France %s\nVeuillez entrer votre mot de passe ci-dessous pour vous {FF0000}enregistrer.", pInfo[playerid][name]);
		ShowPlayerDialog(playerid, DIALOG_CONNECT, DIALOG_STYLE_PASSWORD, "Inscription", dialog, "Inscription", "Quitter");
	}
 	else{
		SendClientMessage(playerid, COLOR_ERROR,"Ce nom de joueur est déjà enregistré. Merci d'entrer votre mot de passe pour vous connecter");
        pRegistered[playerid]=true;
        format(string, sizeof(string), "{FFFFFF}Bonjour %s. Votre compte est {FF0000}enregistré.\n{FFFFFF}Veuillez entrer votre mot de passe ci-dessous pour vous connecter.",pInfo[playerid][name]);
		ShowPlayerDialog(playerid,15500,DIALOG_STYLE_PASSWORD,"Connexion:",string,"Valider","Quitter");
        ShowPlayerDialog(playerid, DIALOG_CONNECT, DIALOG_STYLE_PASSWORD, "Connexion", string, "Connexion", "Quitter");
	}
	mysql_free_result();

	SetPlayerMapIcon(playerid, 0, 1102.7158, -1067.9561, 31.8899, 8, 0, MAPICON_GLOBAL); //Icône bompshop
	SetPlayerMapIcon(playerid, 1, 1208.8140, -915.0212, 56.1324, 10, 0, MAPICON_GLOBAL); //Icône burgershot
	SetPlayerMapIcon(playerid, 2, 1104.7067,-1370.3041,13.9844, 55, 0, MAPICON_GLOBAL); //Icône concessionnaire
	SetPlayerMapIcon(playerid, 3, 2072.4685,-1793.7029,13.5469, 7, 0, MAPICON_GLOBAL); //Icône coiffeur
	SetPlayerMapIcon(playerid, 4, 2103.6072,-1806.3965,13.5547, 29, 0, MAPICON_GLOBAL); //Icône well stacked pizza
	SetPlayerMapIcon(playerid, 5, 925.4721,-1352.7209,13.3766, 14, 0, MAPICON_GLOBAL); //Icône cluckin ball
	SetPlayerMapIcon(playerid, 6, 1552.6508,-1675.5138,16.1953, 30, 0, MAPICON_GLOBAL); //Icône police
	SetPlayerMapIcon(playerid, 7, 2070.4128,-1779.8164,13.5587, 39, 0, MAPICON_GLOBAL); //Icône tatoo
	SetPlayerMapIcon(playerid, 8, 2244.7527,-1663.9713,15.4766, 45, 0, MAPICON_GLOBAL); //Icône binco
	SetPlayerMapIcon(playerid, 9, 1364.6790,-1279.1178,13.5469, 6, 0, MAPICON_GLOBAL); //Icône ammunation
	SetPlayerMapIcon(playerid, 10, 1465.0000,-1012.6400,26.8438, 52, 0, MAPICON_GLOBAL); //Icône banque
	SetPlayerMapIcon(playerid, 11, 1497.00430, -1669.27260, 14.04690, 36, 0, MAPICON_LOCAL); //Icône ATM1
	SetPlayerMapIcon(playerid, 12, 1472.16138, -1310.49963, 13.25410, 36, 0, MAPICON_LOCAL); //Icône ATM2
	SetPlayerMapIcon(playerid, 13, 1808.50134, -1396.98694, 13.01920, 36, 0, MAPICON_LOCAL); //Icône ATM3
	SetPlayerMapIcon(playerid, 14, 2108.97729, -1790.71216, 13.19380, 36, 0, MAPICON_LOCAL); //Icône ATM4
	SetPlayerMapIcon(playerid, 15, 810.791990, -1876.69238, 13.22270, 36, 0, MAPICON_LOCAL); //Icône ATM5
	SetPlayerMapIcon(playerid, 16, 2078.7405,-2006.2996,13.1109, 51, 0, MAPICON_GLOBAL); //Icône /vendrev
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerNPC(playerid)) return 1;
	if(reason==0&&!GetSuccess(playerid, 6)) SetSuccess(playerid, 6, true);
	SavePlayerStats(playerid);
	ChangeVersionColor();
	new msg[128];
	new sreason[][]={
	    "(Timeout/Crash)",
	    "(Déconnexion)",
	    "(Kické)"
	};
	format(msg, sizeof(msg), "%s(%d) s'est déconnecté du serveur. %s", pInfo[playerid][name], playerid, sreason[reason]);
	SendClientMessageToAll(COLOR_LIGHTGREY, msg);
    ResetPlayerVariables(playerid);
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(PickupInfo[pickupid][spawned])
	{
	    SetPlayerPos(playerid, PickupInfo[pickupid][extx], PickupInfo[pickupid][exty], PickupInfo[pickupid][extz]);
		SetPlayerFacingAngle(playerid, PickupInfo[pickupid][exta]);
		SetPlayerInterior(playerid, PickupInfo[pickupid][interior]);
	}
	else if(PickupInfo[PickupInfo[pickupid][entid]][extid]==pickupid)
	{
	    SetPlayerPos(playerid, PickupInfo[PickupInfo[pickupid][entid]][entx], PickupInfo[PickupInfo[pickupid][entid]][enty], PickupInfo[PickupInfo[pickupid][entid]][entz]);
		SetPlayerFacingAngle(playerid, PickupInfo[PickupInfo[pickupid][entid]][enta]);
		SetPlayerInterior(playerid, 0);
	}
	if(pickupid==Pickup[PICKUP_ASSUR])
		SendClientMessage(playerid, COLOR_YELLOW, "Tapez /assurance pour obtenir une assurance pour votre véhicule!");
	if(pickupid==Pickup[PICKUP_BUYWEP])
		SendClientMessage(playerid, COLOR_BLUE, "Utilisez la commande /acheter pour pouvoir acheter une arme !");
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    if(pLastMessage[playerid]>gettime()||pInfo[playerid][lrob]>0) return 1;
	switch(GetPlayerCheckpoint(playerid))
	{
	    case CP_24/7: {
		    SendClientMessage(playerid, COLOR_BLUE, "Utilisez la commande /acheter pour acheter des articles ou /volerlieu pour voler le 24/7.");
	 		pLastMessage[playerid]=gettime()+20;
	 		return 1;
 		}
	    case CP_BOMBSHOP: {
		    if(IsPlayerCrimi(playerid)) SendClientMessage(playerid, COLOR_BLUE, "Utilisez la commande /acheter pour acheter des trucs ou /volerlieu pour voler le BombShop.");
		    else SendClientMessage(playerid, COLOR_ERROR, "Il n'y a rien pour toi ici, dégage.");
	 		pLastMessage[playerid]=gettime()+20;
	 		return 1;
 		}
		case CP_PRISON: if(IsPlayerCops(playerid)) {
		    SendClientMessage(playerid, COLOR_BLUECOPS, "C'est ici que vous livrez les criminel détenus dans votre véhicule !");
	 		pLastMessage[playerid]=gettime()+20;
	 		return 1;
		}
		case CP_ATM1, CP_ATM2, CP_ATM3, CP_ATM4, CP_ATM5: {
		    SendClientMessage(playerid, COLOR_BLUE, (pInfo[playerid][TEAM]==TEAM_VOLEUR) ? ("Utilisez la commande /retrait pour retirer de l'argent ou la commande /voleratm pour le voler !") : ("Utilisez la commande /retrait pour retirer de l'argent !"));
	 		pLastMessage[playerid]=gettime()+20;
	 		return 1;
		}
		case CP_BANQUE: {
		    SendClientMessage(playerid, COLOR_BLUE, "Utilisez la commande /banque pour pouvoir gérer votre compte en banque.");
	 		pLastMessage[playerid]=gettime()+20;
	 		return 1;
		}
		case CP_BUYVEH:{
		    SendClientMessage(playerid, COLOR_BLUE, "Utilisez la commande /acheter pour pouvoir acheter un véhicule !");
	 		pLastMessage[playerid]=gettime()+20;
	 		return 1;
		}
		case CP_HOPITAL: {
		    SendClientMessage(playerid, COLOR_BLUE, "Utilisez la commande /acheter pour pouvoir vous soigner totalement ! (Coûte $5,000 !)");
	 		pLastMessage[playerid]=gettime()+20;
	 		return 1;
		}
		case CP_EXPLBANKGATE: {
		    SendClientMessage(playerid, COLOR_BLUE, "Faites /exploser pour exploser cette porte !");
    		pLastMessage[playerid]=gettime()+20;
	 		return 1;
		}
		case CP_WEAPONPICKG, CP_WEAPONPICKB: {
		    SendClientMessage(playerid, COLOR_BLUE, "Tapez /arme pour prendre une arme !");
	 		pLastMessage[playerid]=gettime()+20;
	 		return 1;
		}
	}
	if(CanBeRobbed(GetPlayerCheckpoint(playerid))&&GetPlayerCheckpoint(playerid)!=CP_VENDREV) {
		SendClientMessage(playerid, COLOR_BLUE, "Faites /volerlieu pour voler ce lieu !");
		pLastMessage[playerid]=gettime()+20;
	}
 	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
    DisablePlayerRaceCheckpoint(playerid);
    KillTimer(pInfo[playerid][ctimer]);
 	return 1;
}

public OnPlayerSpawn(playerid)
{
    AntiDeAMX();
	pInfo[playerid][spawned]=true;
 	pInfo[playerid][hp]=100.0;
	if(IsPlayerCrimi(playerid)&&pInfo[playerid][skin]==21)
	{
	    if(pInfo[playerid][CLASS]==0) SetPlayerSkin(playerid, 21);
	    if(pInfo[playerid][CLASS]==1) SetPlayerSkin(playerid, 23);
	}
	new rand=0, Float:pos[4];
	switch(pInfo[playerid][CLASS])
	{

		case 0,1,9,10,11,12,13,14,15,16:{
			ShowPlayerDialog(playerid, DIALOG_METIER, DIALOG_STYLE_LIST, "Sélection de métier", "Voleur - Carjacker\nKidnappeur\nTerroriste\nVioleur\nMercenaire\nHacker", "Choisir", "");
			rand=random(sizeof(SpawnCrimiPos));
			pos[0]=SpawnCrimiPos[rand][0];
			pos[1]=SpawnCrimiPos[rand][1];
			pos[2]=SpawnCrimiPos[rand][2];
			pos[3]=SpawnCrimiPos[rand][3];

			if(pInfo[playerid][CLASS]==9)
			{
				pInfo[playerid][EXTTEAM]=EXTTEAM_LEADGROOVE;
				pos[0]=2529.7959;
				pos[1]=-1667.4255;
				pos[2]=15.1687;
				pos[3]=89.3802;
			}
			if(pInfo[playerid][CLASS]>9&&pInfo[playerid][CLASS]<13)
			{
				pInfo[playerid][EXTTEAM]=EXTTEAM_GROOVE;
				rand=random(sizeof(SpawnGroovePos));
				pos[0]=SpawnGroovePos[rand][0];
				pos[1]=SpawnGroovePos[rand][1];
				pos[2]=SpawnGroovePos[rand][2];
				pos[3]=SpawnGroovePos[rand][3];
			}
			if(pInfo[playerid][CLASS]==13)
			{
				pInfo[playerid][EXTTEAM]=EXTTEAM_LEADBALLAS;
				rand=random(sizeof(SpawnBallasPos));
				pos[0]=SpawnBallasPos[rand][0];
				pos[1]=SpawnBallasPos[rand][1];
				pos[2]=SpawnBallasPos[rand][2];
				pos[3]=SpawnBallasPos[rand][3];
			}
			if(pInfo[playerid][CLASS]>13&&pInfo[playerid][CLASS]<17)
			{
				pInfo[playerid][EXTTEAM]=EXTTEAM_BALLAS;
				rand=random(sizeof(SpawnBallasPos));
				pos[0]=SpawnBallasPos[rand][0];
				pos[1]=SpawnBallasPos[rand][1];
				pos[2]=SpawnBallasPos[rand][2];
				pos[3]=SpawnBallasPos[rand][3];
			}
		}
		case 2,3,4,5,6,7,8:{
	        new Global[1024];
			format (Global, sizeof Global, "%s\n%s", Global, "{4169FF}Job:{FFFFFF}\nVotre travail consiste à neutraliser les criminels mettant le chaos sur Los Santos. Vous disposez pour cela de nombreux véhicules et armes.\nVous travaillez en coopération avec le Swat, le Fbi, la Cia, la Bac & l'Armée.\n");
			format (Global, sizeof Global, "%s\n%s", Global, "{4169FF}Commandes:{FFFFFF}\nFaites /cmds pour connaître la liste de vos commandes.\n");
			format (Global, sizeof Global, "%s\n%s", Global, "{4169FF}Règles:{FFFFFF}\nEn tant que Flic, vous devez montrer l'exemple et respecter des consignes spécifiques:\n -Vous pouvez seulement contrôler les joueurs blanc. Il est strictement interdit de tirer (même 1 seule balle).");
			format (Global, sizeof Global, "%s\n%s", Global, " -Mettre des PV aux {FFFF00}joueurs jaunes{FFFFFF}. Il est également strictement interdit de tirer (même 1 seule balle).\n -Arrêter ou tuer les {FFA500}joueurs oranges{FFFFFF} ou {FF0000}joueurs rouges{FFFFFF}.\n -Le TeamKill est strictement interdit!\n{FF0000}*{FFFFFF} Toute infraction à ces règles entraînera une sanction d' 1 avertissement, ainsi que de 200sec de Jail par DM.");
			format (Global, sizeof Global, "%s\n%s", Global, "Plus d'information dans les /regles et /pc du serveur.");
			ShowPlayerDialog(playerid,DIALOG_ALL,DIALOG_STYLE_MSGBOX,"{4169FF}INFORMATION - POLICE", Global,"Ok","");
			if(pInfo[playerid][CLASS]<4) {
				pInfo[playerid][TEAM]=TEAM_COPS;
				rand=random(sizeof(SpawnFlicPos));
				pos[0]=SpawnFlicPos[rand][0];
				pos[1]=SpawnFlicPos[rand][1];
				pos[2]=SpawnFlicPos[rand][2];
				pos[3]=SpawnFlicPos[rand][3];
				GivePlayerWeaponEx(playerid,31,500);
				GivePlayerWeaponEx(playerid,29,300);
				GivePlayerWeaponEx(playerid,22,300);
				GivePlayerWeaponEx(playerid,3,1);
			}
			else if(pInfo[playerid][CLASS]==4) {
				GivePlayerWeaponEx(playerid,31,500);
				GivePlayerWeaponEx(playerid,29,300);
				GivePlayerWeaponEx(playerid,25,30);
				GivePlayerWeaponEx(playerid,24,500);
				GivePlayerWeaponEx(playerid,3,1);
				SetPlayerArmour(playerid, 100);
				pInfo[playerid][TEAM]=TEAM_SWAT;
				rand=random(sizeof(SpawnFlicPos));
				pos[0]=SpawnFlicPos[rand][0];
				pos[1]=SpawnFlicPos[rand][1];
				pos[2]=SpawnFlicPos[rand][2];
				pos[3]=SpawnFlicPos[rand][3];
			}
			if(pInfo[playerid][CLASS]==5) {
				pos[0]=2731.6116;
				pos[1]=-2489.4612;
				pos[2]=13.6533;
				pos[3]=180.4118;
				pInfo[playerid][TEAM]=TEAM_MILITARY;
				GivePlayerWeaponEx(playerid,31,500);
				GivePlayerWeaponEx(playerid,34,60);
				GivePlayerWeaponEx(playerid,24,80);
			}
			if(pInfo[playerid][CLASS]==6) {
				pInfo[playerid][TEAM]=TEAM_BAC;
				pInfo[playerid][EXTTEAM]=EXTTEAM_LEADBAC;
				rand=random(sizeof(SpawnBACPos));
				pos[0]=SpawnBACPos[rand][0];
				pos[1]=SpawnBACPos[rand][1];
				pos[2]=SpawnBACPos[rand][2];
				pos[3]=SpawnBACPos[rand][3];
				SetPlayerAttachedObject(playerid, 5, 19142, 1, 0.1, 0.039999, 0.000000, 2.459999, 0.0, -3.100000, 1, 1, 1); // On lui mes l'objet désiré (Gilet)
				GivePlayerWeaponEx(playerid,31,500);
				GivePlayerWeaponEx(playerid,29,300);
				GivePlayerWeaponEx(playerid,41,800);
				GivePlayerWeaponEx(playerid,3,1);
				GivePlayerWeaponEx(playerid,24,200);
				SetPlayerArmour(playerid, 100);
			}
			if(pInfo[playerid][CLASS]==6||pInfo[playerid][CLASS]==7||pInfo[playerid][CLASS]==8) {
				pInfo[playerid][TEAM]=TEAM_BAC;
				pInfo[playerid][EXTTEAM]=EXTTEAM_BAC;
				rand=random(sizeof(SpawnBACPos));
				pos[0]=SpawnBACPos[rand][0];
				pos[1]=SpawnBACPos[rand][1];
				pos[2]=SpawnBACPos[rand][2];
				pos[3]=SpawnBACPos[rand][3];
				SetPlayerAttachedObject(playerid, 5, 19142, 1, 0.1, 0.039999, 0.000000, 2.459999, 0.0, -3.100000, 1, 1, 1); // On lui mes l'objet désiré (Gilet)
				GivePlayerWeaponEx(playerid,31,500);
				GivePlayerWeaponEx(playerid,29,300);
				GivePlayerWeaponEx(playerid,41,800);
				GivePlayerWeaponEx(playerid,3,1);
				GivePlayerWeaponEx(playerid,24,200);
				SetPlayerArmour(playerid, 100);
			}
		}
	}
	SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SetPlayerFacingAngle(playerid, pos[3]);
	SetCameraBehindPlayer(playerid);
    ActualiseWantedTD(playerid);
  	for(new i=0;i<MAX_PLAYERS;i++)
		if(i!=playerid&&IsPlayerConnected(i)) ShowPlayerMarkerForPlayer(i, playerid);

    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, pSkill[playerid][skill_pistol]);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, pSkill[playerid][skill_silenced]);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, pSkill[playerid][skill_deagle]);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, pSkill[playerid][skill_shotgun]);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, pSkill[playerid][skill_sawnoff_shotgun]);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SPAS12_SHOTGUN, pSkill[playerid][skill_spas12_shotgun]);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, pSkill[playerid][skill_micro_uzi]);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, pSkill[playerid][skill_mp5]);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, pSkill[playerid][skill_ak47]);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_M4, pSkill[playerid][skill_m4]);
    SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, pSkill[playerid][skill_sniper]);
    if(IsPlayerCrimi(playerid)) ActualiseWantedTD(playerid);
    else PlayerTextDrawHide(playerid, wantedtd[playerid]);

	GangZoneShowForPlayer(playerid, BallasZone, 0x93113596);
	GangZoneShowForPlayer(playerid, GrooveZone, 0x25A42296);
	if(pInfo[playerid][TEAM]==TEAM_HACKER) {
    	Load3DID(playerid);
		pInfo[playerid][seeid]=true;
	}

	if(pInfo[playerid][jailtime]>0) {
	    ResetPlayerWeapons(playerid);
	    ResetWanted(playerid);
	 	for(new i=0;i<47;i++)
			PlayerWeapons[playerid][i]=false;
		ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, "", "", "", "");
		new rnd = random(sizeof(JailPos));
		SetPlayerInterior(playerid,10);
		SetPlayerPos(playerid,JailPos[rnd][0],JailPos[rnd][1],JailPos[rnd][2]);
		SetPlayerFacingAngle(playerid,JailPos[rnd][3]);
		SendClientMessage(playerid, COLOR_ERROR, "Vous etiez en prison a votre connexion, vous avez été remis en prison !");
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    PlayerTextDrawHide(playerid, wantedtd[playerid]);
    KillTimer(pInfo[playerid][invisibletimer]);
    Unload3DID(playerid);
	pInfo[playerid][seeid]=false;
	SendDeathMessage(killerid, playerid, reason);
	new bool:candm=(CanDm(killerid, playerid)!=0) ? (true) : (false);
	if(!IsPlayerConnected(killerid)||pInfo[killerid][adminmode]) candm=true;
	if(pInfo[playerid][hit]>0&&pInfo[killerid][TEAM]==TEAM_HITMAN) {
		GivePlayerMoney(killerid, pInfo[playerid][hitamount]);
		AddScore(killerid, 1);
		new msg[128];
		format(msg, sizeof(msg), "Vous avez tué %s(%d), il avait un contrat sur la tête ! Vous venez de gagner le montant de %s et un point de score !", pInfo[playerid][name], playerid, FormatMoney(pInfo[playerid][hitamount]));
		SendClientMessage(killerid, COLOR_GREEN, msg);
		format(msg, sizeof(msg), "Le mercenaire %s(%d) a tué %s(%d) qui avait un contrat sur la tête, il vient de gagner la somme de %s", pInfo[killerid][name], killerid, pInfo[playerid][name], playerid, FormatMoney(pInfo[playerid][hitamount]));
		SendClientMessageToAll(COLOR_BLUE, msg);
	    candm=true;
	    format(msg, sizeof(msg), "[RADIO] Le criminel %s(%d) a tué %s(%d), interpellez-le !", pInfo[killerid][name], killerid, pInfo[playerid][name], playerid);
	    SendClientMessageToAllCops(COLOR_BLUECOPS, msg);
	    candm=true;
	}
	else if(!candm) {
		if(IsPlayerCops(killerid)&&pInfo[playerid][wanted]<4) {
			pavert(killerid, "Deathmatching");
			SetReport(playerid, killerid, true);
		}
		else if(IsPlayerCops(playerid)&&pInfo[killerid][wanted]<4) {
			pavert(killerid, "Deathmatching");
			SetReport(playerid, killerid, true);
		}
		else if(!IsPlayerCops(killerid)&&!IsPlayerCops(killerid)) {
			pavert(killerid, "Deathmatching");
			SetReport(playerid, killerid, true);
		}
	}
	else if(killerid!=INVALID_PLAYER_ID){
		AddScore(killerid, 1);
		if(!IsPlayerCops(killerid)) AddWanted(killerid, 4);
		candm=true;
	}
	GivePlayerMoney(playerid, -2000);
	SendClientMessage(playerid, COLOR_PINK, "Vous êtes mort, l'hopital vous a coûté $2,000 !");

    new msg[128];
    if(IsPlayerConnected(killerid)){
    if(!IsPlayerCops(killerid)) {
		format(msg, sizeof(msg), "%s(%d) a été tué par %s(%d) à l'aide %s", pInfo[playerid][name], playerid, pInfo[killerid][name], killerid, DeathWeaponName[reason]);
		new string[128];
	    format(string, sizeof(string), "[RADIO] Le suspect %s(%d) a tué %s(%d) à l'aide %s, interpellez-le !", pInfo[killerid][name], killerid, pInfo[playerid][name], playerid, DeathWeaponName[reason]);
	    SendClientMessageToAllCops(COLOR_BLUECOPS, string);
	}
	else if(IsPlayerConnected(killerid)&&!IsPlayerCops(playerid))
	{
	    new rand=random(5), score=0, money=0;
	    switch(pInfo[playerid][wanted])
	    {
			case 4..19:
			{
			    switch(rand)
			    {
			        case 0:money=random(7500);
			        case 1:money=random(8700);
			        case 2:money=random(9600);
			        case 3:money=random(11000);
			        case 4:money=random(14500);
				}
			    format(msg, sizeof(msg), "L'officier de police %s(%d) a tué le criminel recherché %s(%d) et a gagné %s !", pInfo[killerid][name], killerid, pInfo[playerid][name], playerid, FormatMoney(money));
				score=1;
			}
			case 20..99:
			{
			    switch(rand)
			    {
			        case 0:money=random(12500);
			        case 1:money=random(14500);
			        case 2:money=random(15500);
			        case 3:money=random(19000);
			        case 4:money=random(22300);
				}
			    format(msg, sizeof(msg), "L'officier de police %s(%d) a tué le criminel très recherché %s(%d) et a gagné %s !", pInfo[killerid][name], killerid, pInfo[playerid][name], playerid, FormatMoney(money));
				score=2;
			}
	    }
	    if(pInfo[playerid][wanted]>=100)
	    {
		 	switch(rand)
			{
			 	case 0:money=random(23700);
			    case 1:money=random(26650);
			    case 2:money=random(29840);
			    case 3:money=random(32137);
			    case 4:money=random(38372);
			}
	    	format(msg, sizeof(msg), "L'officier de police %s(%d) a tué le criminel extrêmement recherché %s(%d) et a gagné %s !", pInfo[killerid][name], killerid, pInfo[playerid][name], playerid, FormatMoney(money));
			score=3;
	    }
	    GivePlayerMoney(killerid, money);
	    AddScore(killerid, score);
	    candm=true;
 	 	pInfo[killerid][policeprogress]+=20;
		if(pInfo[killerid][policeprogress]>=100) {
			new str[144];
			pInfo[killerid][policelvl]++;
			pInfo[killerid][policeprogress]=0;
			format(str, sizeof(str), "Vous avez monté de niveau policier ! Vous êtes maintenant au niveau %d !", pInfo[killerid][policelvl]);
			SendClientMessage(killerid, COLOR_GREEN, str);
		}
	}}
    if(killerid==INVALID_PLAYER_ID) format(msg,sizeof(msg),"%s(%d) s'est tué pour une raison inconnue...",pInfo[playerid][name],playerid);

    SendClientMessageToAll((IsPlayerCops(killerid)) ? (COLOR_BLUECOPS) : (COLOR_PINK), msg);
    if(killerid>=0&&IsPlayerConnected(killerid)&&killerid!=INVALID_PLAYER_ID)
	{
	    if(IsPlayerCops(playerid))
		{
			AddWanted(killerid, 5);
	    	SetPlayerAutoColor(killerid);
	    	candm=true;

	    }
	    else if(!IsPlayerCops(killerid)) {
			AddWanted(killerid, 4);
	    	SetPlayerAutoColor(killerid);
	    	candm=true;
	    }
		pInfo[killerid][kill]++;
	 	pInfo[killerid][kills]++;
		pInfo[killerid][tkill]++;
		pInfo[playerid][death]++;
		pInfo[playerid][deaths]++;
		if(pInfo[killerid][tkill]==24&&!GetSuccess(killerid, 2)) SetSuccess(killerid, 2, true);
		if(!GetSuccess(killerid, 0)) SetSuccess(killerid, 0, true);
	    if(candm) AddSkillLevel(killerid, reason);
    }
	if(pInfo[playerid][tkill]==27&&!GetSuccess(playerid, 3)) SetSuccess(playerid, 3, true);
    PlayerDeathVariables(playerid);
   	if(pInfo[playerid][adminmode]) {
		for(new i = 0; i < MAX_PLAYERS; i++)
			ShowPlayerNameTagForPlayer(i, playerid, true);
		pInfo[playerid][adminmode]=false;
	}
	new str[128];
	format(str, sizeof(str), "%s(%d) a tué %s(%d) a l'aide %s", pInfo[killerid][name], killerid, pInfo[playerid][name], playerid, DeathWeaponName[reason]);
	log("KILL", str);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	if(vInfo[vehicleid][destroyed]) {
		if(!vInfo[vehicleid][assured])
			DestroyVehicle(vehicleid);
		else {
		    new rand=random(sizeof(AssurSpawn));
		    SetVehiclePos(vehicleid, AssurSpawn[rand][0], AssurSpawn[rand][1], AssurSpawn[rand][2]);
		    SetVehicleZAngle(vehicleid, AssurSpawn[rand][3]);
		    new playerid=GetPlayerIDWithUID(vInfo[vehicleid][P_UID]);
		    SendClientMessage(playerid, COLOR_GREEN, "Un de vos véhicules personnels vient d'être livré dans le centre commercial en face du comissariat !");
			if(pInv[playerid][BANK_CASH]<7500) {
				SendClientMessage(playerid, COLOR_YELLOW, "Vous n'aviez pas assez d'argent en banque pour payer votre mutuelle, elle vient de vous être retirée !");
			    vInfo[vehicleid][assured]=false;
			}
			else {
			    SendClientMessage(playerid, COLOR_GREEN, "Votre mutuelle vous a coûté $7,500 (en banque) pour votre véhicule !");
				pInv[playerid][BANK_CASH]-=7500;
			    vInfo[vehicleid][assured]=true;
			}
		    return 1;
		}
	}
    new model=GetVehicleModel(vehicleid);
	if(model==523||model==596||model==599&&vInfo[vehicleid][P_UID]!=-1)
		SetVehicleNumberPlate(vehicleid, "LSPD");
	else if(vInfo[vehicleid][P_UID]!=-1) SetVehicleNumberPlate(vehicleid, "CRFR");
	Delete3DID(vehicleid);
	Create3DID(vehicleid);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    vInfo[vehicleid][gonnaexplode]=false;
    vInfo[vehicleid][destroyed]=true;
    Delete3DID(vehicleid);
	if(vSpawned[vehicleid]!=-1) pSpawnVeh[vSpawned[vehicleid]]=0;
	for(new i=0;i<MAX_PLAYERS;i++)
	    if(pInfo[i][last_vehicle]==vehicleid) pInfo[i][last_vehicle]=-1;

	if(vInfo[vehicleid][P_UID]!=-1) {
		new playerid=GetPlayerIDWithUID(vInfo[vehicleid][P_UID]);
		if(!vInfo[vehicleid][assured]) {
			SendClientMessage(playerid, COLOR_RED, "Un de vos véhicules personnels a été détruit !");
  			vInfo[vehicleid][destroyed]=true;
			SaveVehicleStats(vehicleid);
			vInfo[vehicleid][P_UID]=-1;
		}
		else
			SendClientMessage(playerid, COLOR_GREEN, "Un de vos véhicules personnels a été détruit mais vous aviez une mutuelle, il va bientôt être livré pas loin du concessionaire !");
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(pInfo[playerid][mutedtime]>gettime()) {
		new msg[128];
		format(msg, sizeof(msg), "Vous êtes muté pendant encore %d secondes, vous ne pouvez pas parler !", pInfo[playerid][mutedtime]-gettime());
	    SendClientMessage(playerid, COLOR_ERROR, msg);
	    return 0;
	}
	new str[128];
	format(str, sizeof(str), "%s(%d): %s", pInfo[playerid][name], playerid, text);
	log("TEXT", str);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	SendClientMessage(playerid, COLOR_ERROR, "Cette commande n'existe pas ! Consultez /cmds ou /gcmds pour consulter la liste de commandes.");
	return 1;
}

public OnPlayerEnterVehicleEx(playerid, vehicleid, seat)
{
	new model=GetVehicleModel(vehicleid);
	pInfo[playerid][last_vehicle]=vehicleid;
	if(vInfo[vehicleid][P_UID]==pInfo[playerid][UID]&&vInfo[vehicleid][P_UID]!=-1&&seat==0) {
		new engine, lights, alarm, doors, bonnet, boot, objective;
		GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(vehicleid, 1, lights, alarm, doors, bonnet, boot, objective);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Bienvenue dans votre véhicule personnel acheté chez Otto's Car !");
	}
	else if(vInfo[vehicleid][P_UID]!=-1&&pInfo[playerid][TEAM]!=TEAM_VOLEUR&&seat==0) {
		RemovePlayerFromVehicle(playerid);
		new msg[128];
		format(msg, sizeof(msg), "Ce véhicule appartient à %s(%d), vous ne pouvez pas le prendre !", GetPlayerNameWithUID(vInfo[vehicleid][P_UID]), GetPlayerIDWithUID(vInfo[vehicleid][P_UID]));
		SendClientMessage(playerid, COLOR_ERROR, msg);
	}
	if(pInfo[playerid][TEAM]==TEAM_VOLEUR&&vInfo[vehicleid][P_UID]!=-1&&vInfo[vehicleid][P_UID]!=pInfo[playerid][UID]&&seat==0)
	{
	    if(pInfo[playerid][lastcarjack]<gettime())
	    {
	 		new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(vehicleid, 0, lights, alarm, doors, bonnet, boot, objective);
			format(vInfo[vehicleid][vcode], 7, "%s", GenerateVCode());
			vInfo[vehicleid][vtry]=7;
			new dialog[400];
			format(dialog, sizeof(dialog), "Vous êtes en train de voler un véhicule !\nVous devez trouver le code à %d chiffres qui dévérouillera le véhicule. Vous avez %d chances !", strlen(vInfo[vehicleid][vcode]), vInfo[vehicleid][vtry]);
			ShowPlayerDialog(playerid, DIALOG_CARJACK, DIALOG_STYLE_INPUT, "Vol de véhicule", dialog, "Essayer", "Quitter");
			if(pInfo[playerid][lasttrob]>gettime()) AddWanted(playerid, 2);
			else pInfo[playerid][lasttrob]=gettime()+60;
	    }
	    else {
	        RemovePlayerFromVehicle(playerid);
	        SendClientMessage(playerid, COLOR_ERROR, "Vous avez déjà volé un véhicule récemment, attendez un peu !");
	    }
	}
 	if((model==523||model==596||model==599)&&!IsPlayerCops(playerid)&&seat==0) {
 	    if(!IsPlayerCrimi(playerid)) {
		 	RemovePlayerFromVehicle(playerid);
		 	SendClientMessage(playerid, COLOR_ERROR, "Vous ne pouvez pas entrer dans un véhicule de police en étant civil !");
		}
 	    else if(pInfo[playerid][wanted]<4) {
			AddWanted(playerid, 4);
		 	SendClientMessage(playerid, COLOR_ERROR, "Vous êtes entré dans un véhicule de police en étant innocent, vous gagnez 4 étoiles de recherche !");
			new msg[128];
			format(msg, sizeof(msg), "Le suspect %s(%d) vient de voler un véhicule de police, interpellez-le vite !", pInfo[playerid][name], playerid);
			SendClientMessageToAllCops(COLOR_BLUECOPS, msg);
     	}
 	}
  	if(vInfo[vehicleid][TEAM]==4&&pInfo[playerid][TEAM]!=TEAM_MILITARY&&seat==0)
	{
		RemovePlayerFromVehicle(playerid);
	 	SendClientMessage(playerid, COLOR_ERROR, "Ce véhicule est réservé aux Militaires !");
 	}
 	if(vInfo[vehicleid][TEAM]==1&&!IsPlayerGroove(playerid)&&seat==0)
	{
		RemovePlayerFromVehicle(playerid);
	 	SendClientMessage(playerid, COLOR_ERROR, "Ce véhicule est réservé aux membres de la team Groove !");
 	}
  	if(vInfo[vehicleid][TEAM]==2&&!IsPlayerBallas(playerid)&&seat==0)
	{
		RemovePlayerFromVehicle(playerid);
	 	SendClientMessage(playerid, COLOR_ERROR, "Ce véhicule est réservé aux membres de la team Ballas !");
 	}
   	if(vInfo[vehicleid][TEAM]==3&&!IsPlayerBac(playerid)&&seat==0)
	{
		RemovePlayerFromVehicle(playerid);
	 	SendClientMessage(playerid, COLOR_ERROR, "Ce véhicule est réservé aux membres de la team BAC !");
 	}
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	SetCameraBehindPlayer(playerid);
    return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if((newstate==PLAYER_STATE_DRIVER||newstate==PLAYER_STATE_PASSENGER)
		&&oldstate==PLAYER_STATE_ONFOOT)
		OnPlayerEnterVehicleEx(playerid, GetPlayerVehicleID(playerid), GetPlayerVehicleSeat(playerid));
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
 	if (GetCompetence(playerid, 0)==1&&(newkeys & KEY_CROUCH) && !(oldkeys & KEY_CROUCH)&&
	 	!IsPlayerInAnyVehicle(playerid)&&IsCanAction(playerid)&&IsPlayerCrimi(playerid)&&!pInfo[playerid][invisible])
 	{
 	    if(!pInfo[playerid][furtiv]) {
 	        if(GetPlayerSpecialAction(playerid)==SPECIAL_ACTION_DUCK) {
			for(new i=0;i<MAX_PLAYERS;i++)
			    if(i!=playerid&&IsPlayerConnected(i)) HidePlayerMarkerForPlayer(i, playerid);
 	    	pInfo[playerid][furtiv]=true;
 	    	pInfo[playerid][hidden]=true;
			SetPlayerProgressBarValue(playerid, FurtivBar[playerid], 0);
       		ShowPlayerProgressBar(playerid, FurtivBar[playerid]);}
 	    }
 	    else {
 	        for(new i=0;i<MAX_PLAYERS;i++)
				if(i!=playerid&&IsPlayerConnected(i)) ShowPlayerMarkerForPlayer(i, playerid);
 	    	pInfo[playerid][furtiv]=false;
 	    	pInfo[playerid][hidden]=false;
 	    	HidePlayerProgressBar(playerid, FurtivBar[playerid]);
 	    	SetPlayerAutoColor(playerid);
 	    }
 	}
	return 1;
}

