#pragma once

#import <stddef.h>

struct Position {
    size_t x;
    size_t y;
};

struct Game;

void Game_load_sprite(struct Game *self, size_t key, const char *name);

void Game_draw_sprite(struct Game *self, size_t key, struct Position position);

struct Logic;

struct Logic * Logic_create(struct Game *game);

void Logic_start(struct Logic *self);

void Logic_draw(struct Logic *self);

void Logic_handle_key(struct Logic *self, size_t key);
