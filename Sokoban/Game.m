
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <Sokoban-Swift.h>

#import <stdlib.h>
#import <string.h>

struct Game {
    GameView *view;
};

//static void list_selectors(struct Game *instance) {
//    unsigned int method_count = 0;
//    Method *method_list = class_copyMethodList(object_getClass(instance->view), &method_count);
//    NSLog(@"%d methods", method_count);
//    for (int index=0; index < method_count; index++) {
//        NSLog(@"Method no #%d: %s", index, sel_getName(method_getName(method_list[index])));
//    }
//}

struct Game * Game_create(id view) {
    struct Game *result = malloc(sizeof(struct Game));
    result->view = view;
    return result;
}

void Game_load_sprite(struct Game *self, size_t key, const char *name) {
    [self->view loadSpriteWithKey: key name:[NSString stringWithUTF8String:name]];
}

void Game_draw_sprite(struct Game *self, size_t key, struct Position position) {
    [self->view drawSpriteWithKey:key position:position];
}

void Game_redraw(struct Game *self) {
    [self->view redraw];
}
