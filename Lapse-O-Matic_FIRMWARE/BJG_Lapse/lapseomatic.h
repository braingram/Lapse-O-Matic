#pragma once

#include <FS.h>
#include <esp_camera.h>
#include "config.h"

// This holds the various subroutines for the wifie camera to use
// This makes main code easier to read.

void set_led(int led, int state);
void flash_error(int my_flash_number);
void print_wakeup_reason();

void readFile(fs::FS &fs, const char * path,settings &my_settings_config);
void readSettings(fs::FS &fs, const char * path, settings &my_settings_config);

void configure_camera(camera_config_t &my_config, settings &my_settings_config);
