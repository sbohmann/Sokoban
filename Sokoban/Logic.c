#include "Game.h"

#include <stdlib.h>
#include <string.h>

#include <stdio.h>

struct Logic {
    struct Game *game;
    struct Position position;
};

struct Logic * Logic_create(struct Game *game) {
    struct Logic *result = malloc(sizeof(struct Logic));
    memset(result, 0, sizeof(struct Logic));
    result->game = game;
    result->position = (struct Position) { 0, 0 };
    return result;
}

void Logic_start(struct Logic *self) {
    Game_load_sprite(self->game, 1, "player");
}

void Logic_draw(struct Logic *self) {
    Game_draw_sprite(self->game, 1, self->position);
}

void Logic_handle_key(struct Logic *self, size_t key) {
    printf("Key: %zu\n", key);
    switch (key) {
        case 1:
            self->position.y -= 40;
            break;
        case 2:
            self->position.y += 40;
            break;
        case 3:
            self->position.x -= 40;
            break;
        case 4:
            self->position.x += 40;
    }
    Game_redraw(self->game);
}
