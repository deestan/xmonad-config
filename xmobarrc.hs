Config { font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
       , bgColor = "black"
       , fgColor = "grey"
       , position = TopW L 90
       , lowerOnStart = True
       , commands = [ Run Weather "EGPF"
                      [ "-t", "<tempC>°C <skyCondition>",
                        "-L", "64",
                        "-H", "77",
                        "--normal", "green",
                        "--high", "red",
                        "--low",
                        "lightblue"
                      ] 36000
                    , Run Wireless "wlan0"
                      [ "--template", "<essid> <quality>%"
                      ] 50
                    , Run Locks
                    , Run Com
                      "dc" ["-f", "/sys/devices/platform/acer-wmi/subsystem/devices/coretemp.0/hwmon/hwmon0/temp1_input", "-e", "1000 / p"] "temp" 100
                    , Run Cpu
                      [ "--template", "Strain: <total>%"
                      , "-L", "3"
                      , "-H", "50"
                      , "--normal", "green"
                      ,"--high"   , "red"
                      ] 10
                    -- , Run Memory ["-t","Mem: <usedratio>%"] 10
                    , Run Swap
                      [ "--template", "Clutter: <usedratio>%"
                      ] 10
                    , Run Date "%a <fc=#bbbbee>%F</fc> <fc=#ee9a00>%T</fc>" "date" 1
                    , Run StdinReader
                    , Run Battery        [ "--template" , "Food: <acstatus>"
                                         , "--Low"      , "10"        -- units: %
                                         , "--High"     , "80"        -- units: %
                                         , "--low"      , "red"
                                         , "--normal"   , "green"
                                         , "--high"     , "lightgreen"
                                                          
                                         , "--" -- battery specific options
                                           -- discharging status
                                         , "-o"	, "<left>% (<timeleft>)"
                                           -- AC "on" status
                                         , "-O"	, "<left>% <fc=#40ff40>^_^</fc>"
                                           -- charged status (currently not working)
                                         , "-i"	, "<left>% <fc=#40ff40>^_^</fc>"
                                         ] 10
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %cpu% %temp%°c | %swap% | %battery%  ^%wlan0wi%  %EGPF%  %date% %locks%"
       }
