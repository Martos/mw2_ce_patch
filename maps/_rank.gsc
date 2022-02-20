#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;

/* -=-=-=-=-=-=-=-=-=-=

SP & CO-OP XP/Rank system

-=-=-=-=-=-=-=-=-=-=-=- */

init()
{
	maps\_hud::init();

	// &&1 was promoted to &&2 &&3!
	precacheString( &"RANK_PLAYER_WAS_PROMOTED_N" );
	// &&1 was promoted to &&2!
	precacheString( &"RANK_PLAYER_WAS_PROMOTED" );
	// You've been promoted!
	precacheString( &"RANK_PROMOTED" );
	// I
	precacheString( &"RANK_ROMANI" );
	// II
	precacheString( &"RANK_ROMANII" );
	// +
	precachestring( &"SCRIPT_PLUS" );
	precacheshader( "line_horizontal" );
	precacheshader( "line_vertical" );
	precacheshader( "gradient_fadein" );
	precacheShader( "difficulty_star" );
	precachemenu( "coop_eog_summary" );
	precachemenu( "coop_eog_summary2" );
	precachemenu( "sp_eog_summary" );

	level.maxRank = int( tableLookup( "sp/ranktable.csv", 0, "maxrank", 1 ) );

/*	for ( rId = 0; rId <= level.maxRank; rId++ )
		precacheShader( tableLookup( "sp/rankIconTable.csv", 0, rId, 1 ) );*/

	rankId = 0;
	rankName = tableLookup( "sp/ranktable.csv", 0, rankId, 1 );
	assert( isDefined( rankName ) && rankName != "" );

	while ( isDefined( rankName ) && rankName != "" )
	{
		level.rankTable[ rankId ][ 1 ] = tableLookup( "sp/ranktable.csv", 0, rankId, 1 );
		level.rankTable[ rankId ][ 2 ] = tableLookup( "sp/ranktable.csv", 0, rankId, 2 );
		level.rankTable[ rankId ][ 3 ] = tableLookup( "sp/ranktable.csv", 0, rankId, 3 );
		level.rankTable[ rankId ][ 7 ] = tableLookup( "sp/ranktable.csv", 0, rankId, 7 );

		precacheString( tableLookupIString( "sp/ranktable.csv", 0, rankId, 10 ) );

		rankId++ ;
		rankName = tableLookup( "sp/ranktable.csv", 0, rankId, 1 );
	}

	//hud_score = get_hud_score();
	
	setXpRanks();

	thread xp_setup();
	foreach ( player in level.players )
		player thread xp_player_init();
}

setXpRanks()
{
	SetDvar("ce_def_min_rank_1", "0");
	SetDvar("ce_def_max_rank_1", "1000");
	SetDvar("ce_def_rank_1", "1000");
	SetDvar("ce_def_min_rank_2", "1000");
	SetDvar("ce_def_max_rank_2", "3400");
	SetDvar("ce_def_rank_2", "2400");
	SetDvar("ce_def_min_rank_3", "3400");
	SetDvar("ce_def_max_rank_3", "9800");
	SetDvar("ce_def_rank_3", "6400");
	SetDvar("ce_def_min_rank_4", "9800");
	SetDvar("ce_def_max_rank_4", "20200");
	SetDvar("ce_def_rank_4", "10400");
	SetDvar("ce_def_min_rank_5", "20200");
	SetDvar("ce_def_max_rank_5", "34600");
	SetDvar("ce_def_rank_5", "14400");
	SetDvar("ce_def_min_rank_6", "34600");
	SetDvar("ce_def_max_rank_6", "53000");
	SetDvar("ce_def_rank_6", "18400");
	SetDvar("ce_def_min_rank_7", "53000");
	SetDvar("ce_def_max_rank_7", "75400");
	SetDvar("ce_def_rank_7", "22400");
	SetDvar("ce_def_min_rank_8", "75400");
	SetDvar("ce_def_max_rank_8", "101800");
	SetDvar("ce_def_rank_8", "26400");
	SetDvar("ce_def_min_rank_9", "101800");
	SetDvar("ce_def_max_rank_9", "132200");
	SetDvar("ce_def_rank_9", "30400");
	SetDvar("ce_def_min_rank_10", "132200");
	SetDvar("ce_def_max_rank_10", "166600");
	SetDvar("ce_def_rank_10", "34400");
	SetDvar("ce_def_min_rank_11", "166600");
	SetDvar("ce_def_max_rank_11", "205000");
	SetDvar("ce_def_rank_11", "38400");
	SetDvar("ce_def_min_rank_12", "205000");
	SetDvar("ce_def_max_rank_12", "247400");
	SetDvar("ce_def_rank_12", "42400");
	SetDvar("ce_def_min_rank_13", "247400");
	SetDvar("ce_def_max_rank_13", "293800");
	SetDvar("ce_def_rank_13", "46400");
	SetDvar("ce_def_min_rank_14", "293800");
	SetDvar("ce_def_max_rank_14", "344200");
	SetDvar("ce_def_rank_14", "50400");
	SetDvar("ce_def_min_rank_15", "344200");
	SetDvar("ce_def_max_rank_15", "398600");
	SetDvar("ce_def_rank_15", "54400");
	SetDvar("ce_def_min_rank_16", "398600");
	SetDvar("ce_def_max_rank_16", "457000");
	SetDvar("ce_def_rank_16", "58400");
	SetDvar("ce_def_min_rank_17", "457000");
	SetDvar("ce_def_max_rank_17", "519400");
	SetDvar("ce_def_rank_17", "62400");
	SetDvar("ce_def_min_rank_18", "519400");
	SetDvar("ce_def_max_rank_18", "585800");
	SetDvar("ce_def_rank_18", "66400");
	SetDvar("ce_def_min_rank_19", "585800");
	SetDvar("ce_def_max_rank_19", "656200");
	SetDvar("ce_def_rank_19", "70400");
	SetDvar("ce_def_min_rank_20", "656200");
	SetDvar("ce_def_max_rank_20", "730600");
	SetDvar("ce_def_rank_20", "74400");
	SetDvar("ce_def_min_rank_21", "730600");
	SetDvar("ce_def_max_rank_21", "809000");
	SetDvar("ce_def_rank_21", "78400");
	SetDvar("ce_def_min_rank_22", "809000");
	SetDvar("ce_def_max_rank_22", "891400");
	SetDvar("ce_def_rank_22", "82400");
	SetDvar("ce_def_min_rank_23", "891400");
	SetDvar("ce_def_max_rank_23", "977800");
	SetDvar("ce_def_rank_23", "86400");
	SetDvar("ce_def_min_rank_24", "977800");
	SetDvar("ce_def_max_rank_24", "1068200");
	SetDvar("ce_def_rank_24", "90400");
	SetDvar("ce_def_min_rank_25", "1068200");
	SetDvar("ce_def_max_rank_25", "1162600");
	SetDvar("ce_def_rank_25", "94400");
	SetDvar("ce_def_min_rank_26", "1162600");
	SetDvar("ce_def_max_rank_26", "1261000");
	SetDvar("ce_def_rank_26", "98400");
	SetDvar("ce_def_min_rank_27", "1261000");
	SetDvar("ce_def_max_rank_27", "1363400");
	SetDvar("ce_def_rank_27", "102400");
	SetDvar("ce_def_min_rank_28", "1363400");
	SetDvar("ce_def_max_rank_28", "1469800");
	SetDvar("ce_def_rank_28", "106400");
	SetDvar("ce_def_min_rank_29", "1469800");
	SetDvar("ce_def_max_rank_29", "1580200");
	SetDvar("ce_def_rank_29", "110400");
	SetDvar("ce_def_min_rank_30", "1580200");
	SetDvar("ce_def_max_rank_30", "1694600");
	SetDvar("ce_def_rank_30", "114400");
	SetDvar("ce_def_min_rank_31", "1694600");
	SetDvar("ce_def_max_rank_31", "1813000");
	SetDvar("ce_def_rank_31", "118400");
	SetDvar("ce_def_min_rank_32", "1813000");
	SetDvar("ce_def_max_rank_32", "1935400");
	SetDvar("ce_def_rank_32", "122400");
	SetDvar("ce_def_min_rank_33", "1935400");
	SetDvar("ce_def_max_rank_33", "2061800");
	SetDvar("ce_def_rank_33", "126400");
	SetDvar("ce_def_min_rank_34", "2061800");
	SetDvar("ce_def_max_rank_34", "2192200");
	SetDvar("ce_def_rank_34", "130400");
	SetDvar("ce_def_min_rank_35", "2192200");
	SetDvar("ce_def_max_rank_35", "2326600");
	SetDvar("ce_def_rank_35", "134400");
	SetDvar("ce_def_min_rank_36", "2326600");
	SetDvar("ce_def_max_rank_36", "2465000");
	SetDvar("ce_def_rank_36", "138400");
	SetDvar("ce_def_min_rank_37", "2465000");
	SetDvar("ce_def_max_rank_37", "2607400");
	SetDvar("ce_def_rank_37", "142400");
	SetDvar("ce_def_min_rank_38", "2607400");
	SetDvar("ce_def_max_rank_38", "2753800");
	SetDvar("ce_def_rank_38", "146400");
	SetDvar("ce_def_min_rank_39", "2753800");
	SetDvar("ce_def_max_rank_39", "2904200");
	SetDvar("ce_def_rank_39", "150400");
	SetDvar("ce_def_min_rank_40", "2904200");
	SetDvar("ce_def_max_rank_40", "3058600");
	SetDvar("ce_def_rank_40", "154400");
	SetDvar("ce_def_min_rank_41", "3058600");
	SetDvar("ce_def_max_rank_41", "3217000");
	SetDvar("ce_def_rank_41", "158400");
	SetDvar("ce_def_min_rank_42", "3217000");
	SetDvar("ce_def_max_rank_42", "3379400");
	SetDvar("ce_def_rank_42", "162400");
	SetDvar("ce_def_min_rank_43", "3379400");
	SetDvar("ce_def_max_rank_43", "3545800");
	SetDvar("ce_def_rank_43", "166400");
	SetDvar("ce_def_min_rank_44", "3545800");
	SetDvar("ce_def_max_rank_44", "3716200");
	SetDvar("ce_def_rank_44", "170400");
	SetDvar("ce_def_min_rank_45", "3716200");
	SetDvar("ce_def_max_rank_45", "3890600");
	SetDvar("ce_def_rank_45", "174400");
	SetDvar("ce_def_min_rank_46", "3890600");
	SetDvar("ce_def_max_rank_46", "4069000");
	SetDvar("ce_def_rank_46", "178400");
	SetDvar("ce_def_min_rank_47", "4069000");
	SetDvar("ce_def_max_rank_47", "4251400");
	SetDvar("ce_def_rank_47", "182400");
	SetDvar("ce_def_min_rank_48", "4251400");
	SetDvar("ce_def_max_rank_48", "4437800");
	SetDvar("ce_def_rank_48", "186400");
	SetDvar("ce_def_min_rank_49", "4437800");
	SetDvar("ce_def_max_rank_49", "4628200");
	SetDvar("ce_def_rank_49", "190400");
	SetDvar("ce_def_min_rank_50", "4628200");
	SetDvar("ce_def_max_rank_50", "4822600");
	SetDvar("ce_def_rank_50", "194400");
	SetDvar("ce_def_min_rank_51", "4822600");
	SetDvar("ce_def_max_rank_51", "5021000");
	SetDvar("ce_def_rank_51", "198400");
	SetDvar("ce_def_min_rank_52", "5021000");
	SetDvar("ce_def_max_rank_52", "5223400");
	SetDvar("ce_def_rank_52", "202400");
	SetDvar("ce_def_min_rank_53", "5223400");
	SetDvar("ce_def_max_rank_53", "5429800");
	SetDvar("ce_def_rank_53", "206400");
	SetDvar("ce_def_min_rank_54", "5429800");
	SetDvar("ce_def_max_rank_54", "5640200");
	SetDvar("ce_def_rank_54", "210400");
	SetDvar("ce_def_min_rank_55", "5640200");
	SetDvar("ce_def_max_rank_55", "5854600");
	SetDvar("ce_def_rank_55", "214400");
	SetDvar("ce_def_min_rank_56", "00");
	SetDvar("ce_def_max_rank_56", "00");
	SetDvar("ce_def_rank_56", "00");
}

xp_player_init()
{
	if ( !isDefined( self.summary ) )
	{
		self.summary[ "summary" ] = [];
		xp = 0;
		rank = 0;

		if(getDvar("player_1_xp") == "") {
			setdvar( "player_1_xp", "0" );
			self.summary[ "summary" ][ "xp" ] = 0;
		} else {
			xp = GetDvarInt("player_1_xp");
			self.summary[ "summary" ][ "xp" ] = xp;
		}
		
		setdvar( "player_2_xp", "0" );

		if(getDvar("player_1_rank") == "") {
			setdvar( "player_1_rank", "0" );
			self.summary[ "rank" ] = 0;
		} else {
			rank = GetDvarInt("player_1_rank");
			self.summary[ "rank" ] = rank;
		}

		setdvar( "player_2_rank", "0" );

		//self.summary[ "summary" ][ "xp" ] = 0;
		self.summary[ "summary" ][ "score" ] = 0;

		self.summary[ "rankxp" ] = 0;
		//self.summary[ "rank" ] = 0;
	}

	self.rankUpdateTotal = 0;
	self.hud_rankscroreupdate = newclientHudElem( self );
	self.hud_rankscroreupdate.horzAlign = "center";
	self.hud_rankscroreupdate.vertAlign = "middle";
	self.hud_rankscroreupdate.alignX = "center";
	self.hud_rankscroreupdate.alignY = "middle";
	self.hud_rankscroreupdate.x = 0;
	self.hud_rankscroreupdate.y = -60;
	self.hud_rankscroreupdate.font = "hudbig";
	self.hud_rankscroreupdate.fontscale = 0.75;
	self.hud_rankscroreupdate.archived = false;
	self.hud_rankscroreupdate.color = ( 1, 1, 0.65 );
	self.hud_rankscroreupdate fontPulseInit(3.0);

	self.hud_score = newclientHudElem( self );
    self.hud_score.foreground = true;
	self.hud_score.x = 30;
	self.hud_score.y = -60;
	self.hud_score.alignX = "right";
	self.hud_score.alignY = "bottom";
	self.hud_score.horzAlign = "right";
	self.hud_score.vertAlign = "bottom";
	self.hud_score.score = 0;
	self.hud_score.color = (1, 1, 0.65);
	self.hud_score setText( "$ " + GetDvarInt("player_1_xp"));

	self.hud_score.font = "hudbig";
	self.hud_score.fontScale = 0.75;
	self.hud_score.sort = 1;
	self.hud_score.glowColor = ( 0, 0, 0 );
	self.hud_score.glowAlpha = 0;
	self.hud_score.alpha = 1;
 	self.hud_score.hidewheninmenu = true;

	//self.hud_score setValue(1000);
	self.hud_score SetPulseFX( 40, 2000, 600 );

	// XP BAR
	//self.hud_xpbar = xp_bar_client_elem( self );
	//self xpbar_update();
	if(getDvar("xpbar_enable") == "1") {
		self.xpbar = createXPBar(self, 224);
		self.xpbar.bar.color = (1,1,0.5);
		self.xpbar.bar.alpha = 0.75;
		self.xpbar updateBar(0);
	}

	self.hud_xp_warn = newclientHudElem( self );
	self.hud_xp_warn.foreground = true;
	self.hud_xp_warn.x = 20;
	self.hud_xp_warn.y = 0;
	self.hud_xp_warn.alignX = "right";
	self.hud_xp_warn.alignY = "top";
	self.hud_xp_warn.horzAlign = "right";
	self.hud_xp_warn.vertAlign = "top";
	self.hud_xp_warn.score = 0;
	self.hud_xp_warn.color = (1, 1, 0.65);
	self.hud_xp_warn setText( "XP ENABLED !");

	self.hud_xp_warn.font = "hudbig";
	self.hud_xp_warn.fontScale = 0.75;
	self.hud_xp_warn.sort = 1;
	self.hud_xp_warn.glowColor = ( 0, 1, 0 );
	self.hud_xp_warn.glowAlpha = 0;
	self.hud_xp_warn.alpha = 1;
	self.hud_xp_warn.hidewheninmenu = true;

	self.hud_xp_warn SetPulseFX( 40, 2000, 600 );
}

xp_bar_client_elem( client )
{
	hudelem = newClientHudElem( client );
	hudelem.x = ( hud_width_format() / 2 ) * ( -1 );
	hudelem.y = 0;
	hudelem.sort = 5;
	hudelem.horzAlign = "center_adjustable";
	hudelem.vertAlign = "bottom_adjustable";
	hudelem.alignX = "left";
	hudelem.alignY = "bottom";
	hudelem setshader( "gradient_fadein", get_xpbarwidth(), 4 );// gradient_fadein
	hudelem.color = ( 1, 0.8, 0.4 );
	hudelem.alpha = 0.65;
	hudelem.foreground = true;
	return hudelem;
}

hud_width_format()
{
	// screen formatting
	if ( getDvar( "hiDef" ) == "1" || getDvar( "wideScreen" ) == "1" )
	{
		if ( isSplitscreen() )
			return 966;// customized to match hud's xpbar background
		else
			return 720;
	}
	else
	{
		if ( isSplitscreen() )
			return 726;// customized to match hud's xpbar background
		else
			return 540;
	}
}

xpbar_update()
{
	if ( !get_xpbarwidth() )
		self.hud_xpbar.alpha = 0;
	else
		self.hud_xpbar.alpha = 0.65;

	self.hud_xpbar setshader( "gradient_fadein", get_xpbarwidth(), 4 );
}

get_xpbarwidth()
{
	player_num = "1";

	if ( self == level.player )
		player_num = "1";

	rank_range = int( tableLookup( "sp/ranktable.csv", 0, getdvar( "player_" + player_num + "_rank" ), 3 ) );
	rank_xp = int( getdvar( "player_" + player_num + "_xp" ) ) - int( tableLookup( "sp/ranktable.csv", 0, getdvar( "player_" + player_num + "_rank" ), 2 ) );

	//iPrintLn(rank_range);
	//iPrintLn(rank_xp);
	iPrintLn(level.player GetLocalPlayerProfileData("rankxp"));

	fullwidth = hud_width_format();
	newwidth = int( fullwidth * ( rank_xp / rank_range ) );

	iPrintLn(newwidth);

	return newwidth;
}

xp_setup()
{
	level.xpScale = 10 * GetDvarInt("g_gameskill");

	if ( level.console )
	{
		level.xpScale = 10 * GetDvarInt("g_gameskill");// getDvarInt( "scr_xpscale" );
	}

	registerScoreInfo( "kill", 10 );
	registerScoreInfo( "headshot", 10 );
	registerScoreInfo( "assist", 2 );
	registerScoreInfo( "suicide", 0 );
	registerScoreInfo( "teamkill", 0 );
}

giveXP_think()
{
	self waittill( "death", attacker, type, weapon );
	// split for recursive call
	self giveXP_helper( attacker );
}

giveXP_helper( attacker )
{
	// if AI removed by script/game, no xp to player
	if ( !isdefined( attacker ) )
		return;

	// if player is last to kill, give player kill points	
	if ( isPlayer( attacker ) )
	{
		attacker thread giveXp( "kill" );
		return;
	}

	// no xp if enemy was finished off by other enemies
	if ( isAI( attacker ) && attacker isBadGuy() )
		return;

	// if enemy shot by player was killed by destructibles
	if ( is_special_targetname_attacker( attacker ) )
	{
		if ( isdefined( attacker.attacker ) )
			self thread giveXP_helper( attacker.attacker );
		return;
	}

	// if enemy shot by player was killed by natural causes, no xp
	if ( !isPlayer( attacker ) && !isAI( attacker ) )
		return;

	// if enemy shot by player was killed by friendly, give assist
	if ( isdefined( self.attacker_list ) && self.attacker_list.size > 0 )
	{
		for ( i = 0; i < self.attacker_list.size; i++ )
		{
			// if attacker is player and not the last to kill, give player assist points
			if ( isPlayer( self.attacker_list[ i ] ) && self.attacker_list[ i ] != attacker )
				self.attacker_list[ i ] thread giveXp( "assist" );
		}
	}
}

is_special_targetname_attacker( attacker )
{
	assert( isdefined( attacker ) );

	if ( !isdefined( attacker.targetname ) )
		return false;

	 if ( attacker.targetname == "destructible" )
	 	return true;

	  if ( string_starts_with( attacker.targetname, "sentry_" ) )
	  	return true;

	  return false;
}

AI_xp_init()
{
	self thread giveXP_think();
	self.attacker_list = [];
	self.last_attacked = 0;
	self add_damage_function( ::xp_took_damage );
}

xp_took_damage( damage, attacker, direction_vec, point, type, modelName, tagName )
{
	if ( !isdefined( attacker ) )
		return;

	currentTime = gettime();
	timeElapsed = currentTime - self.last_attacked;
	if ( timeElapsed <= 10 * 1000 )
	{
		self.attacker_list[ self.attacker_list.size ] = attacker;
		self.last_attacked = gettime();
		return;
	}

	self.attacker_list = [];
	self.attacker_list[ 0 ] = attacker;
	self.last_attacked = gettime();
}

// used by _utility.gsc, edit with cre
updatePlayerScore( type, value )
{
	self notify( "update_xp" );
	self endon( "update_xp" );

	if ( getdvar( "xp_enable", "0" ) != "1" )
		return;

	//assertex ( isDefined( level.scoreInfo ), "Trying to give player XP when XP feature is not enabled, set dvar xp_enable to 1." );
	//assertex ( isDefined( type ), "First string parameter <type> is undefined or missing, you must label this XP reward." );

	if ( !isDefined( value ) )
	{
		if ( isDefined( level.scoreInfo[ type ] ) )
			value = getScoreInfoValue( type );
		else
			value = getScoreInfoValue( "kill" );
	}

	value = int( value * level.xpScale );

	if ( type == "kill" )
		self.hud_rankscroreupdate.color = ( 1, 1, 0.5 );

	if ( type == "assist" )
	{
		// assist points can never add up over kill points
		if ( value > getScoreInfoValue( "kill" ) )
			value = getScoreInfoValue( "kill" );

		self.hud_rankscroreupdate.color = ( 1, 1, 0.5 );
	}

	self.rankUpdateTotal += value;

	// +
	self.hud_rankscroreupdate.label = &"SCRIPT_PLUS";

	self.hud_rankscroreupdate setValue( self.rankUpdateTotal );
	self.hud_rankscroreupdate.alpha = 1;
	self.hud_rankscroreupdate thread fontPulse( self );

	wait 1;
	self.hud_rankscroreupdate fadeOverTime( 0.75 );
	self.hud_rankscroreupdate.alpha = 0;

	// set xp dvar for hud menu to print
	self.summary[ "summary" ][ "score" ] += self.rankUpdateTotal;
	self.summary[ "summary" ][ "xp" ] += self.rankUpdateTotal;
	self.summary[ "rankxp" ] += self.rankUpdateTotal;

	if ( self == level.player )
	{
		setdvar( "player_1_xp", self.summary[ "summary" ][ "xp" ] );
		setdvar( "player_1_rank", self.summary[ "rank" ] );
		self.hud_score setText( "$ " + getDvarInt("player_1_xp") );
		self.hud_score SetPulseFX( 40, 2000, 600 );
		
		//player.xpBarWidth = ( ( ( player.rankXp - player.minXp ) / player.maxXp ) * 200  );
		self.rankXp = getdvarint("player_1_xp");
		self.rankLevel = getdvarint("ce_rank");
		self.minXp = getdvarint("ce_def_min_rank_" + self.rankLevel);
		self.maxXp = getdvarint("ce_def_rank_" + (self.rankLevel));
		
		/*
		iPrintLn("xp: " + self.rankXp);
		iPrintLn("rank: " + self.rankLevel);
		iPrintLn("minxp: " + self.minXp);
		iPrintLn("maxxp: " + self.maxXp);
		*/
		
		self.xpBarWidth = ( ( ( self.rankXp - self.minXp ) / self.maxXp ) * 1  );
		
		if((GetDvarInt("ce_def_min_rank_"+(self.rankLevel+1)) - GetDvarInt("player_1_xp")) <= 0) {
			self.rankLevel++;
	
			SetDvar("ce_rank", self.rankLevel);
			SetDvar("ce_next_rank", self.rankLevel+1);
			
			if(self.xpBarWidth >= 1) {
				self.xpBarWidth = self.xpBarWidth - 1;
			}
	
			self thread updateRankAnnounceHUD();
		}
		
		self.centerXpBar updateBar(self.xpBarWidth);
		
		level.player SetLocalPlayerProfileData("rankxp", self.summary[ "summary" ][ "xp" ]);
	}
	else
	{
		setdvar( "player_2_xp", self.summary[ "summary" ][ "xp" ] );
		setdvar( "player_2_rank", self.summary[ "rank" ] );
	}

	//self xpbar_update();

	self.rankUpdateTotal = 0;

	/*
	if ( self updateRank() )
		self thread updateRankAnnounceHUD();
	*/
}

fontPulseInit(maxFontScale)
{
/*
	self.baseFontScale = self.fontScale;
	self.maxFontScale = self.fontScale * 2;
	//self.moveUpSpeed = 1.25;
	self.inFrames = 3;
	self.outFrames = 5;
*/
	self.baseFontScale = self.fontScale;
	if ( isDefined( maxFontScale ) )
		self.maxFontScale = min( maxFontScale, 6.3 );
	else
		self.maxFontScale = min( self.fontScale * 2, 6.3 );
	self.inFrames = 2;
	self.outFrames = 4;
}


fontPulse( player )
{
/*
	self notify( "fontPulse" );
	self endon( "fontPulse" );

	scaleRange = self.maxFontScale - self.baseFontScale;
	//self thread fontMoveup( -60 );

	while ( self.fontScale < self.maxFontScale )
	{
		self.fontScale = min( self.maxFontScale, self.fontScale + ( scaleRange / self.inFrames ) );
		wait 0.05;
	}

	while ( self.fontScale > self.baseFontScale )
	{
		self.fontScale = max( self.baseFontScale, self.fontScale - ( scaleRange / self.outFrames ) );
		wait 0.05;
	}
*/
	self notify ( "fontPulse" );
	self endon ( "fontPulse" );
	self endon( "death" );
	
	player endon("disconnect");
	
	self ChangeFontScaleOverTime( self.inFrames * 0.05 );
	self.fontScale = self.maxFontScale;	
	wait self.inFrames * 0.05;
	
	self ChangeFontScaleOverTime( self.outFrames * 0.05 );
	self.fontScale = self.baseFontScale;
}

/*
fontMoveup( start )
{
	self endon( "fontPulse" );
	self.y = start;

	while ( abs( start ) - abs( self.y ) < 60 )
	{
		self.y = self.y - self.moveUpSpeed;
		wait 0.05;
	}
}*/

updateRank()
{
	newRankId = self getRank();
	if ( newRankId == self.summary[ "rank" ] )
		return false;

	oldRank = self.summary[ "rank" ];
	rankId = self.summary[ "rank" ];

	self.summary[ "rank" ] = newRankId;

	if ( self == level.player )
		setdvar( "player_1_rank", self.summary[ "rank" ] );
	else
		setdvar( "player_2_rank", self.summary[ "rank" ] );

	self xpbar_update();

	while ( rankId <= newRankId )
	{
		self.setPromotion = true;
		rankId++ ;
	}
	return true;
}

updateRankAnnounceHUD()
{
	self endon( "disconnect" );

	self notify( "update_rank" );
	self endon( "update_rank" );

	self notify( "reset_outcome" );
	newRankName = self getRankInfoFull( self.summary[ "rank" ] );
	//iPrintLn(newRankName); WORKED
	notifyData = spawnStruct();

	// You've been promoted!
	notifyData.titleText = &"RANK_PROMOTED";
	notifyData.titleLabel = &"RANK_PROMOTED";
	notifyData.iconName = self getRankInfoIcon( self.summary[ "rank" ] );
	notifyData.sound = "sp_level_up";
	notifyData.duration = 4.0;

	rank_char = level.rankTable[ self.summary[ "rank" ] ][ 1 ];
	subRank = int( rank_char[ rank_char.size - 1 ] );

	if ( subRank == 2 )
	{
		notifyData.textLabel = newRankName;
		// I
		notifyData.notifyText = &"RANK_ROMANI";
		notifyData.textIsString = true;
	}
	else if ( subRank == 3 )
	{
		notifyData.textLabel = newRankName;
		// II
		notifyData.notifyText = &"RANK_ROMANII";
		notifyData.textIsString = true;
	}
	else
	{
		notifyData.notifyText = newRankName;
	}

	self thread notifyMessage( notifyData );

	//thread promotionSplashNotify();

	if ( subRank > 1 )
		return;

}

notifyMessage( notifyData )
{
	self endon( "death" );
	self endon( "disconnect" );

	if ( !self.doingNotify )
	{
		self thread showNotifyMessage( notifyData );
		return;
	}

	self.notifyQueue[ self.notifyQueue.size ] = notifyData;
}


showNotifyMessage( notifyData )
{
	self endon( "disconnect" );

	self.doingNotify = true;

	waitRequireVisibility( 0 );

	if ( isDefined( notifyData.duration ) )
		duration = notifyData.duration;
	else
		duration = 4.0;

	self thread resetOnCancel();

	if ( isDefined( notifyData.sound ) )
		self playLocalSound( notifyData.sound );

	if ( isDefined( notifyData.glowColor ) )
		glowColor = notifyData.glowColor;
	else
		glowColor = ( 0.3, 0.6, 0.3 );

	self.notifyTitle = createClientFontString( "objective", 2.5 );
	self.notifyTitle setPoint( "TOP", undefined, 30, 0 );
	self.notifyTitle.glowColor = ( 0.2, 0.3, 0.7 );
	self.notifyTitle.glowAlpha = 1;
	self.notifyTitle.hideWhenInMenu = true;
	self.notifyTitle.archived = false;
	self.notifyTitle.alpha = 1;

	anchorElem = self.notifyTitle;

	//iPrintLn(notifyData.titleText); WORKED

	if ( isDefined( notifyData.titleText ) )
	{

			if ( isDefined( notifyData.titleLabel ) )
				self.notifyTitle.label = notifyData.titleLabel;
			else
				// string not found for 
				self.notifyTitle.label = &"";

			if ( isDefined( notifyData.titleLabel ) && !isDefined( notifyData.titleIsString ) ) {
				self.notifyTitle setValue( notifyData.titleText );
				iPrintLn(self.notifyTitle);
			}
			else {
				self.notifyTitle setText( notifyData.titleText );
				iPrintLn(self.notifyTitle);
			}
			self.notifyTitle setPulseFX( 100, int( duration * 1000 ), 1000 );
			self.notifyTitle.glowColor = glowColor;
			self.notifyTitle.alpha = 1;
	}

	if ( isDefined( notifyData.notifyText ) )
	{
			if ( isDefined( notifyData.textLabel ) )
				self.notifyText.label = notifyData.textLabel;
			else
				// string not found for 
				self.notifyText.label = &"";

			if ( isDefined( notifyData.textLabel ) && !isDefined( notifyData.textIsString ) )
				self.notifyText setValue( notifyData.notifyText );
			else
				self.notifyText setText( notifyData.notifyText );
			self.notifyText setPulseFX( 100, int( duration * 1000 ), 1000 );
			self.notifyText.glowColor = glowColor;
			self.notifyText.alpha = 1;
			anchorElem = self.notifyText;
	}

	if ( isDefined( notifyData.notifyText2 ) )
	{
		if ( isSplitscreen() )
			textSize = 0.667;
		else
			textSize = 1.0;

		self.notifyText2 = createFontString( "hudbig", textSize );
		self.notifyText2 setParent( self.notifyTitle );
		self.notifyText2 setPoint( "TOP", "TOP", 0, 0 );
		self.notifyText2.glowColor = (0.2, 0.3, 0.7);
		self.notifyText2.glowAlpha = 1;
		self.notifyText2.hideWhenInMenu = true;
		self.notifyText2.archived = false;
		self.notifyText2.alpha = 0;
		self.notifyText2 setParent( anchorElem );

		if ( isDefined( notifyData.text2Label ) )
			self.notifyText2.label = notifyData.text2Label;
		else
			// string not found for 
			self.notifyText2.label = &"";

		self.notifyText2 setText( notifyData.notifyText2 );
		self.notifyText2 setPulseFX( 100, int( duration * 1000 ), 1000 );
		self.notifyText2.glowColor = glowColor;
		self.notifyText2.alpha = 1;
		anchorElem = self.notifyText2;
	}

	if ( isDefined( notifyData.iconName ) )
	{
		if ( isSplitscreen() )
			iconSize = 46;
		else
			iconSize = 70;
		iPrintLn(notifyData.iconName);
		self.notifyIcon = createIcon( "black", iconSize, iconSize );
		self.notifyIcon setParent( self.notifyText2 );
		self.notifyIcon setPoint( "TOP", "TOP", 0, 30 );
		self.notifyIcon.hideWhenInMenu = true;
		self.notifyIcon.archived = false;
		self.notifyIcon.alpha = 0;
		self.notifyIcon setParent( anchorElem );
		self.notifyIcon setShader( "difficulty_star", 60, 60 );
		self.notifyIcon.alpha = 0;
		self.notifyIcon fadeOverTime( 1.0 );
		self.notifyIcon.alpha = 1;

		waitRequireVisibility( duration );

		self.notifyIcon fadeOverTime( 0.75 );
		self.notifyIcon.alpha = 0;
	}
	else
	{
		waitRequireVisibility( duration );
	}

	self notify( "notifyMessageDone" );
	self.doingNotify = false;

	if ( self.notifyQueue.size > 0 )
	{
		nextNotifyData = self.notifyQueue[ 0 ];

		newQueue = [];
		for ( i = 1; i < self.notifyQueue.size; i++ )
			self.notifyQueue[ i - 1 ] = self.notifyQueue[ i ];
		self.notifyQueue[ i - 1 ] = undefined;

		self thread showNotifyMessage( nextNotifyData );
	}
}

resetOnCancel()
{
	self notify( "resetOnCancel" );
	self endon( "resetOnCancel" );
	self endon( "notifyMessageDone" );
	self endon( "disconnect" );

	level waittill( "cancel_notify" );

	self.notifyTitle.alpha = 0;
	self.notifyText.alpha = 0;
	self.notifyIcon.alpha = 0;
	self.doingNotify = false;
}

// waits for waitTime, plus any time required to let flashbangs go away.
waitRequireVisibility( waitTime )
{
	interval = .05;

	while ( !self canReadText() )
		wait interval;

	while ( waitTime > 0 )
	{
		wait interval;
		if ( self canReadText() )
			waitTime -= interval;
	}
}

canReadText()
{
	if ( self isFlashbanged() )
		return false;
	return true;
}

isFlashbanged()
{
	return isDefined( self.flashEndTime ) && gettime() < self.flashEndTime;
}

// ============== helpers ===============

registerScoreInfo( type, value )
{
	level.scoreInfo[ type ][ "value" ] = value;
}

getScoreInfoValue( type )
{
	return( level.scoreInfo[ type ][ "value" ] );
}

getRankInfoMinXP( rankId )
{
	return int( level.rankTable[ rankId ][ 2 ] );
}

getRankInfoXPAmt( rankId )
{
	return int( level.rankTable[ rankId ][ 3 ] );
}

getRankInfoMaxXp( rankId )
{
	return int( level.rankTable[ rankId ][ 7 ] );
}

getRankInfoFull( rankId )
{
	return tableLookupIString( "sp/ranktable.csv", 0, rankId, 10 );
}

getRankInfoIcon( rankId )
{
	return tableLookup( "sp/rankicontable.csv", 0, rankId, 1 );
}

getRank()
{
	rankXp = self.summary[ "rankxp" ];
	rankId = self.summary[ "rank" ];

	if ( rankXp < ( getRankInfoMinXP( rankId ) + getRankInfoXPAmt( rankId ) ) )
		return rankId;
	else
		return self getRankForXp( rankXp );
}

getRankForXp( xpVal )
{
	rankId = 0;
	rankName = level.rankTable[ rankId ][ 1 ];
	assert( isDefined( rankName ) );

	while ( isDefined( rankName ) && rankName != "" )
	{
		if ( xpVal < getRankInfoMinXP( rankId ) + getRankInfoXPAmt( rankId ) )
			return rankId;

		rankId++ ;
		if ( isDefined( level.rankTable[ rankId ] ) )
			rankName = level.rankTable[ rankId ][ 1 ];
		else
			rankName = undefined;
	}

	rankId -- ;
	return rankId;
}

getRankXP()
{
	return self.summary[ "rankxp" ];
}