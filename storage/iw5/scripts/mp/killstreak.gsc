#include maps\mp\gametypes\_hud_util;

init() {
    level thread onPlayerConnect();
}

onPlayerConnect() {
    for (;;) {
        level waittill("connected", player);
        player thread killstreakPlayer();
    }
}

killstreakPlayer() {
    self endon("disconnect");
    level endon("game_ended");

    self.hudkillstreak = createFontString("Objective", 1);
    
    // Posição corrigida (0 no eixo X)
    self.hudkillstreak setPoint("CENTER", "TOP", 0, 10);
    
    // Voltando o texto para KILLSTREAK
    self.hudkillstreak.label = &"^2KILLSTREAK: ^1";

    while (true) {
        // Lendo a variável de sequência, que zera quando morre
        self.hudkillstreak setValue(self.pers["cur_kill_streak"]);
        wait 0.5;
    }
}