
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <Sokoban-Swift.h>

#import <stdlib.h>
#import <string.h>

struct Game {
    GameView *view;
};

struct Game * Game_create(id view) {
    struct Game *result = malloc(sizeof(struct Game));
    *result = (struct Game) { view };
    return result;
}

//static void list_selectors(struct Game *instance) {
//    unsigned int method_count = 0;
//    Method * mlist = class_copyMethodList(object_getClass(instance->view), &method_count);
//    NSLog(@"%d methods", method_count);
//    for (int index=0; index < method_count; index++) {
//        NSLog(@"Method no #%d: %s", index, sel_getName(method_getName(mlist[index])));
//    }
//}

void Game_display(struct Game *instance) {
//    list_selectors(instance);

    [instance->view display];
}
