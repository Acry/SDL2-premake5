#ifndef _HELPER_H_
#define _HELPER_H_

#ifdef _WIN32
#include <SDL.h>
#include <SDL_image.h>
#else
#include <stdlib.h>
#include <SDL2/SDL.h>
#include <SDL2/SDL_image.h>
#endif

SDL_Window   *Window;
SDL_Renderer *Renderer;

void init (void);
void exit_(void);

#endif