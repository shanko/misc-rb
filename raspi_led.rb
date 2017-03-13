def raspi_type
  hash = {
    "model name : " => :pi0,
    "model name : ARMv7 Processor rev 5 (v7l)" => :pi2,
    "model name	: ARMv7 Processor rev 4 (v7l)" => :pi3,
  }

  str = `grep model /proc/cpuinfo | uniq`.chomp

  return hash[str]
end

def green_led(status = :on)
  return if raspi_type != :pi3

  if status == :on
    system("echo 1 | sudo tee /sys/class/leds/led0/brightness")
  elsif status == :off
    system("echo 0 | sudo tee /sys/class/leds/led0/brightness")
  end
end

3.times do
 green_led(:on)
 sleep(0.5)

 green_led(:off)
 sleep(0.5)
end

