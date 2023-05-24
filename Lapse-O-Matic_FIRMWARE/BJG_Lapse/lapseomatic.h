#pragma once

#include <FS.h>
#include <esp_camera.h>
#include "config.h"

// This holds the various subroutines for the wifie camera to use
// This makes main code easier to read.

void flash_on();
void flash_off();
void latch_flash();
void unlatch_flash();
void flash_error(int my_flash_number);
void print_wakeup_reason();

void readFile(fs::FS &fs, const char * path,settings &my_settings_config);
void readSettings(fs::FS &fs, const char * path, settings &my_settings_config);

void configure_camera(camera_config_t &my_config, settings &my_settings_config);
