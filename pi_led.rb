#!/usr/bin/env ruby 

require './pi_version'
include RaspiVersion

# Source: https://www.jeffgeerling.com/blogs/jeff-geerling/controlling-pwr-act-leds-raspberry-pi

rev = RaspiVersion.get_revision 
puts rev

commands = []
case rev[:model]

  when 'Model B Rev 1', 'Model B Rev 2', 'Model A', 'Model B Rev 2'

    puts "Not yet Implemented for #{rev[:model]}"

  # Raspberry Pi model 2 B, B+ and A+ 
  when 'Model A+', 'Model B+', 'Pi 2 Model B v1.1', 'Pi 2 Model B v1.2'

    # Set the PWR LED to GPIO mode (set 'off' by default).
    pwr_led_gpio = "echo gpio | sudo tee /sys/class/leds/led1/trigger"

    # Turn ON (1) or OFF (0) the PWR LED.
    pwr_led_on  = "echo 1 | sudo tee /sys/class/leds/led1/brightness"
    pwr_led_off = "echo 0 | sudo tee /sys/class/leds/led1/brightness"

    # Revert the PWR LED back to 'under-voltage detect' mode.
    pwr_led_under_voltage_detect = "echo input | sudo tee /sys/class/leds/led1/trigger"

    # Set the ACT LED to trigger on cpu0 instead of mmc0 (SD card access).
    act_led_sd_card_access = "echo cpu0 | sudo tee /sys/class/leds/led0/trigger"

    commands << pwr_led_gpio
    commands << pwr_led_on
    commands << pwr_led_off
    commands << pwr_led_under_voltage_detect
    commands << act_led_sd_card_access

  # Raspi-Zero
  when 'Pi Zero v1.2', 'Pi Zero v1.3', 'Pi Zero W'
    # Set the Pi Zero ACT LED trigger to 'none'.
    act_led = "echo none | sudo tee /sys/class/leds/led0/trigger"
    commands << act_led

    # Turn ON  or OFF the Pi Zero ACT LED.
    act_led_on  = "echo 1 | sudo tee /sys/class/leds/led0/brightness"
    act_led_off = "echo 0 | sudo tee /sys/class/leds/led0/brightness"
    commands << act_led_on
    commands << act_led_off

  # Raspi-model 3
  when 'Pi 3 Model B'
    puts "Not yet implemented for #{rev[:model]}"

  else
    puts "Not yet implemented for #{rev}"
end

commands.each do |cmd|
  puts "> " + cmd
  system(cmd)
  sleep(2)
end

puts "\ndone"

