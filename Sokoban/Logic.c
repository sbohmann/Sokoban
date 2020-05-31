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

void Logic_start(struct Logic *instance) {
    Game_display(instance->game);
}
