#!/usr/bin/env ruby

# http://www.raspberrypi-spy.co.uk/2012/09/checking-your-raspberry-pi-board-version/
# Model and PCB Revision,  RAM,  Hardware Revision Code from /proc/cpuinfo

module RaspiVersion
  
  RPI_CPU = [
    { :model => 'Model B Rev 1',     :ram => '256MB',  :revision_code => ['0002']},
    { :model => 'Model B Rev 2',     :ram => '256MB',  :revision_code => ['0004', '0005', '0006']},
    { :model => 'Model A',           :ram => '256MB',  :revision_code => ['0007', '0008', '0009']},
    { :model => 'Model B Rev 2',     :ram => '512MB',  :revision_code => ['000d', '000e', '000f']},
    { :model => 'Model B+',          :ram => '512MB',  :revision_code => ['0010', '0013', '900032']},
    { :model => 'Compute Module  ',  :ram => '512MB',  :revision_code => ['0011']},
    { :model => 'Compute Module',    :ram => '512MB',  :revision_code => ['0014', '(Embest, China)']},
    { :model => 'Model A+',          :ram => '256MB',  :revision_code => ['0012']},
    { :model => 'Model A+',          :ram => '256MB',  :revision_code => ['0015', '(Embest, China)']},
    { :model => 'Model A+',          :ram => '512MB',  :revision_code => ['0015', '(Embest, China)']},
    { :model => 'Pi 2 Model B v1.1', :ram => '1GB',    :revision_code => ['a01041', '(Sony, UK)']},
    { :model => 'Pi 2 Model B v1.1', :ram => '1GB',    :revision_code => ['a21041', '(Embest, China)']},
    { :model => 'Pi 2 Model B v1.2', :ram => '1GB',    :revision_code => ['a22042']},
    { :model => 'Pi Zero v1.2',      :ram => '512MB',  :revision_code => ['900092']},
    { :model => 'Pi Zero v1.3',      :ram => '512MB',  :revision_code => ['900093']},
    { :model => 'Pi Zero W',         :ram => '512MB',  :revision_code => ['9000c1']},
    { :model => 'Pi 3 Model B',      :ram => '1GB',    :revision_code => ['a02082', '(Sony, UK)']},
    { :model => 'Pi 3 Model B',      :ram => '1GB',    :revision_code => ['a22082', '(Embest, China)']},
    { :model => 'Model B Rev 1 ECN0001 (no fuses, D14 removed)',  :ram => '256MB',  :revision_code => ['0003']},
  ]
  
  #p RPI_CPU
  
  def get_revision(code=nil)
    
    if code.nil?
      rev  = `grep Revision /proc/cpuinfo`
      code = (rev.split(':')[1]).strip
    end
  
    ## TODO: Handle revision code = '0015' properly for different RAM sizes
  
    RPI_CPU.each do |hash|
      return hash if (hash[:revision_code].include?(code))
    end

    return {code => "Unknown Version"}
  end

end

if __FILE__ == $0
require 'pp'
  include RaspiVersion
  pp RaspiVersion.get_revision
end


