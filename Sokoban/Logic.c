#include "Game.h"

#include <stdlib.h>
#include <string.h>

struct Logic {
    struct Game *game;
};

struct Logic * Logic_create(struct Game *game) {
    struct Logic *result = malloc(sizeof(struct Logic));
    memset(result, 0, sizeof(struct Logic));
    result->game = game;
    return result;
}

void Logic_start(struct Logic *self) {
    Game_load_sprite(self->game, 1, "player");
}

void Logic_draw(struct Logic *self) {
    Game_draw_sprite(self->game, 1, (struct Position) {30, 100});
}
