#pragma once

struct Game;

void Game_display(struct Game *instance);

struct Logic;

struct Logic * Logic_create(struct Game *game);

void Logic_start(struct Logic *instance);

void Logic_handle_timer(struct Logic *instance);
