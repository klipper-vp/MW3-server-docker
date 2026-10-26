Init()
{
    waittillframeend;
    thread ModuleSetup();
}

ModuleSetup()
{
    level waittill( level.notifyTypes.gameFunctionsInitialized );
    RegisterCustomCommands();
}

RegisterCustomCommands()
{
    // --- COMANDO 1: DISCORD (!dc) ---
    scripts\_integration_shared::RegisterScriptCommand( 
        "DiscordCommand", 
        "discord", 
        "dc", 
        "Mostra o link do Discord", 
        "User", 
        undefined, 
        false, 
        ::DiscordCommandCallback 
    );

    // --- COMANDO 2: STEAM (!stm) ---
    // Mudei para "stm" para não conflitar com nada
    scripts\_integration_shared::RegisterScriptCommand( 
        "SteamCommand",    
        "steam",           
        "stm",              
        "Mostra o perfil da Steam", 
        "User", 
        undefined, 
        false, 
        ::SteamCommandCallback 
    );
}

// ==========================================
// CALLBACKS
// ==========================================

DiscordCommandCallback( event, _ )
{
    if ( IsPlayer( self ) )
    {
        self thread ShowSocialMessage( "^1Acessem o Discord:", "^3discord.com/invite/gPtZq69XKS" );
    }
}

SteamCommandCallback( event, _ )
{
    if ( IsPlayer( self ) )
    {
        self thread ShowSocialMessage( "^5Adicione na Steam:", "^7s.team/p/dqn-jjbb/qdbvmjwr" );
    }
}

// ==========================================
// FUNÇÃO VISUAL
// ==========================================
ShowSocialMessage( titulo, link )
{
    self endon("disconnect");

    hud = NewClientHudElem( self );
    hud.alignX = "center";
    hud.alignY = "middle";
    hud.horzAlign = "center";
    hud.vertAlign = "middle";
    hud.y = -40; 
    hud.fontScale = 2;
    hud.font = "objective";
    hud.alpha = 0;
    hud.hidewheninmenu = true;
    hud.sort = 10;
    
    hud SetText( titulo + "\n" + link );

    hud FadeOverTime( 0.5 );
    hud.alpha = 1;

    wait( 5 ); 

    hud FadeOverTime( 1.0 );
    hud.alpha = 0;
    
    wait( 1.0 );
    if(IsDefined(hud))
    {
        hud Destroy();
    }
}