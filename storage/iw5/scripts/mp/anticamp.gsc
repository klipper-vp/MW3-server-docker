#include maps\mp\gametypes\_hud_util;

init() {
    level thread onPlayerConnect();
}

onPlayerConnect() {
    for (;;) {
        level waittill("connected", player);
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned() {
    self endon("disconnect");
    for (;;) {
        self waittill("spawned_player");
        self thread antiCampMonitor();
    }
}

antiCampMonitor() {
    self endon("disconnect");
    self endon("death");
    level endon("game_ended");

    // ==========================================================
    // CONFIGURAÇÃO DE IMUNIDADE DO DONO
    // ==========================================================
    donoGUID = "01000000005e57e5"; // Cole sua GUID se preferir usar esse método
    donoNick = "killer_vp";     // Seu nick exato no jogo
    
    // Se for você, o script encerra o monitoramento de camping na hora
    if (self.guid == donoGUID || self.name == donoNick) {
        return; 
    }
    // ==========================================================

    // === CONFIGURAÇÕES DO ANTI-CAMP ===
    campTime = 0;
    maxCampTime = 20; // Segundos que o jogador pode ficar parado antes de morrer
    minDistance = 40; // Distância mínima que ele precisa se mover para não ser considerado camper

    while (true) {
        oldPosition = self.origin;
        wait 1.0; // Checa a posição a cada 1 segundo
        newPosition = self.origin;

        // Calcula se o jogador andou o suficiente
        if (Distance(oldPosition, newPosition) < minDistance) {
            campTime++;
        } else {
            campTime = 0; // O jogador se moveu, zera a contagem
        }

        // Aviso na tela faltando 10 segundos para a punição
        if (campTime == maxCampTime - 10) {
            self iPrintLnBold("^1AVISO: ^7Mova-se ou morrera por camperar!");
        }

        // Punição final
        if (campTime >= maxCampTime) {
            self iPrintLnBold("^1PUNIDO POR CAMPERAR!");
            self suicide(); // Mata o jogador
            campTime = 0;
        }
    }
}