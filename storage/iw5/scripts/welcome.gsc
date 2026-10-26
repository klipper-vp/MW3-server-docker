init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread showWelcomeFinalCenter();
    }
}

showWelcomeFinalCenter()
{
    self endon("disconnect");
    self waittill("spawned_player");

    wait 4; // Espera o jogador carregar

    if(isDefined(self.wlc)) self.wlc destroy();

    // Criando o elemento de HUD
    self.wlc = newClientHudElem(self);
    
    // Alinhamento Centralizado (320x180)
    self.wlc.horizAlign = "fullscreen";
    self.wlc.vertAlign = "fullscreen";
    self.wlc.alignX = "center";
    self.wlc.alignY = "middle";
    self.wlc.x = 320; 
    self.wlc.y = 180; 
    
    self.wlc.font = "objective";
    self.wlc.fontScale = 2.4;
    self.wlc.foreground = true;
    self.wlc.alpha = 0;
    self.wlc.glowAlpha = 1;
    self.wlc.glowColor = (0, 0, 0); 
    self.wlc.hideWhenInMenu = true;

    // --- ETAPA 1: BEM-VINDO ---
    self.wlc setText("^7BEM-VINDO AO\n^2KiLLeR ^3BRaSiL");
    self.wlc fadeOverTime(1.5);
    self.wlc.alpha = 1;
    wait 3;

    // --- ETAPA 2: BOM JOGO ---
    self.wlc fadeOverTime(1);
    self.wlc.alpha = 0;
    wait 1;
    
    self.wlc setText("^1BOM JOGO!"); 
    self.wlc fadeOverTime(1);
    self.wlc.alpha = 1;
    wait 2;

    // --- ETAPA 3: VOLTE SEMPRE ---
    self.wlc fadeOverTime(1);
    self.wlc.alpha = 0;
    wait 1;

    self.wlc setText("^3VOLTE ^5SEMPRE!"); // Amarelo e Branco
    self.wlc fadeOverTime(1);
    self.wlc.alpha = 1;
    wait 2;

    // Finaliza e destrói
    if(isDefined(self.wlc))
    {
        self.wlc fadeOverTime(2);
        self.wlc.alpha = 0;
        wait 2;
        self.wlc destroy();
    }
}