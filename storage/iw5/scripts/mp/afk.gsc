init() {
    level thread onPlayerConnect();
}

onPlayerConnect() {
    for (;;) {
        level waittill("connected", player);
        player thread afkMonitor();
    }
}

afkMonitor() {
    self endon("disconnect");
    level endon("game_ended");

    // ==========================================================
    // CONFIGURAÇÃO DE IMUNIDADE DO DONO
    // ==========================================================
    // Opção 1: Cole sua GUID dentro das aspas (Recomendado)
    donoGUID = "01000000005e57e5"; 
    
    // Opção 2: Coloque seu Nick exato do jogo dentro das aspas
    donoNick = "killer_vp"; 
    
    // Se for você, o script para o monitoramento na hora e te deixa imune
    if (self.guid == donoGUID || self.name == donoNick) {
        return; 
    }
    // ==========================================================

    afkTime = 0;
    maxAfkTime = 60; // Tempo máximo inativo em SEGUNDOS (120 = 2 min)

    wait 15; 

    while (true) {
        wait 1.0; 

        // Checa se o cara está no "limbo" (espectador ou tela de time)
        if (!isDefined(self.origin) || !isDefined(self.angles)) {
            afkTime++; // Conta o tempo mesmo sem ele ter nascido
        } else {
            // Se ele já nasceu, grava a posição para comparar
            if (!isDefined(self.lastOrigin)) {
                self.lastOrigin = self.origin;
                self.lastAngles = self.angles;
            }

            // Compara a posição atual com a última gravada
            if (self.origin == self.lastOrigin && self.angles == self.lastAngles) {
                afkTime++;
            } else {
                afkTime = 0; // Mexeu, zera a contagem
                self.lastOrigin = self.origin;
                self.lastAngles = self.angles;
            }
        }

        if (afkTime == maxAfkTime - 15) {
            self iPrintLnBold("^1AVISO: ^3Entre no jogo senao sera kikado por ^2inatividade!");
        }

        if (afkTime >= maxAfkTime) {
            // O comando de kick raiz do motor do jogo
            kick(self getEntityNumber()); 
            break;
        }
    }
}