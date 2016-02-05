#!/usr/bin/env bash

# ##################################################
# Library of functions to view demos of UI elements
#
# VERSION 1.0.0
#
# HISTORY:
#
# * November 22, 2015 - v1.0.0  - Library Created
#
# ##################################################

demo_echo_expansion() {
    case $1 in
        echo)
        	demo_graphic -cn --spaces=2 --header="Echo Expansion:" --title="echo"
			echo "\n\techo \"regular output\""
			echo -b "\techo -b \"bold output\""
			echo -u "\techo -u \"underlined output\""
			echo -l "\techo -l \"light regular output\""
			echo -lb "\techo -lb \"light bold output\""
			echo -lu "\techo -lu \"light underlined output\""
			echo -d "\techo -d \"dark regular output\""			
			echo -db "\techo -db \"dark bold output\""
			echo -du "\techo -du \"dark underline output\""
			echo -n "\techo -n \"use "
			echo -ubn "-"
			echo -ubn "n"
			echo " to skip the trailing newline\n\t  and piece formats together\""
			echo "\n"
            ;;
        einf) 
			demo_graphic -cn --spaces=2 --header="Echo Expansion:" --title="einf"
			einf "\n\teinf \"regular output\""
			einf -b "\teinf -b \"bold output\""
			einf -u "\teinf -u \"underlined output\""
			einf -l "\teinf -l \"light regular output\""
			einf -lb "\teinf -lb \"light bold output\""
			einf -lu "\teinf -lu \"light underlined output\""
			einf -d "\teinf -d \"dark regular output\""			
			einf -db "\teinf -db \"dark bold output\""
			einf -du "\teinf -du \"dark underline output\""
			einf -n "\teinf -n \"use "
			einf -ubn "-"
			einf -ubn "n"
			einf " to skip the trailing newline\n\t  and piece formats together\""
			einf "\n"
            ;;
        ente) 
			demo_graphic -cn --spaces=2 --header="Echo Expansion:" --title="ente"
			ente "\n\tente \"regular output\""
			ente -b "\tente -b \"bold output\""
			ente -u "\tente -u \"underlined output\""
			ente -l "\tente -l \"light regular output\""
			ente -lb "\tente -lb \"light bold output\""
			ente -lu "\tente -lu \"light underlined output\""
			ente -d "\tente -d \"dark regular output\""			
			ente -db "\tente -db \"dark bold output\""
			ente -du "\tente -du \"dark underline output\""
			ente -n "\tente -n \"use "
			ente -ubn "-"
			ente -ubn "n"
			ente " to skip the trailing newline\n\t  and piece formats together\""
			ente "\n"
            ;;
        ewar) 
        	demo_graphic -cn --spaces=2 --header="Echo Expansion:" --title="ewar"
			ewar "\n\tewar \"regular output\""
			ewar -b "\tewar -b \"bold output\""
			ewar -u "\tewar -u \"underlined output\""
			ewar -l "\tewar -l \"light regular output\""
			ewar -lb "\tewar -lb \"light bold output\""
			ewar -lu "\tewar -lu \"light underlined output\""
			ewar -d "\tewar -d \"dark regular output\""			
			ewar -db "\tewar -db \"dark bold output\""
			ewar -du "\tewar -du \"dark underline output\""
			ewar -n "\tewar -n \"use "
			ewar -ubn "-"
			ewar -ubn "n"
			ewar " to skip the trailing newline\n\t  and piece formats together\""
			ewar "\n"
            ;;
        esuc) 
        	demo_graphic -cn --spaces=2 --header="Echo Expansion:" --title="esuc"
			esuc "\n\tesuc \"regular output\""
			esuc -b "\tesuc -b \"bold output\""
			esuc -u "\tesuc -u \"underlined output\""
			esuc -l "\tesuc -l \"light regular output\""
			esuc -lb "\tesuc -lb \"light bold output\""
			esuc -lu "\tesuc -lu \"light underlined output\""
			esuc -d "\tesuc -d \"dark regular output\""			
			esuc -db "\tesuc -db \"dark bold output\""
			esuc -du "\tesuc -du \"dark underline output\""
			esuc -n "\tesuc -n \"use "
			esuc -ubn "-"
			esuc -ubn "n"
			esuc " to skip the trailing newline\n\t  and piece formats together\""
			esuc "\n"
            ;;
        eerr) 
        	demo_graphic -cn --spaces=2 --header="Echo Expansion:" --title="eerr"
			eerr "\n\teerr \"regular output\""
			eerr -b "\teerr -b \"bold output\""
			eerr -u "\teerr -u \"underlined output\""
			eerr -l "\teerr -l \"light regular output\""
			eerr -lb "\teerr -lb \"light bold output\""
			eerr -lu "\teerr -lu \"light underlined output\""
			eerr -d "\teerr -d \"dark regular output\""			
			eerr -db "\teerr -db \"dark bold output\""
			eerr -du "\teerr -du \"dark underline output\""
			eerr -n "\teerr -n \"use "
			eerr -ubn "-"
			eerr -ubn "n"
			eerr " to skip the trailing newline\n\t  and piece formats together\""
			eerr "\n"
            ;;
        emes) 
        	demo_graphic -cn --spaces=2 --header="Echo Expansion:" --title="emes"
			echo -un "\n\temes infpos \"Package Title\""
			echo ":"
			#echo -n "\t"
			emes infpos "Package Title"
			echo "\n"
            ;;
        evar)
			local example="hello world"

			demo_graphic -cn --spaces=2 --header="Echo Expansion:" --title="evar"

			echo -un "\n\tearr 'array'"
			echo ":"
			esuc -bu "\n\tVariables"
			evar --tabs=1 'example'
			echo "\n"
			;;
		earr)
			local desktop_browsers=("Chrome" "Firefox" "Safari" "Opera" "IE")
			local -A popular_on_mobile=([iPhone]="Safari" [Android]="Chrome" [Windows]="Internet Explorer")
			
			demo_graphic -cn --spaces=2 --header="Echo Expansion:" --title="earr"
			
			echo -un "\n\tearr 'array'"
			echo ":"
			einf -bu "\n\tSimple Array"
			earr --tabs=1 'desktop_browsers'
			einf -bu "\n\tAssociative Array"
			earr --tabs=1 'popular_on_mobile'
			echo "\n"
			;;
        * )
            demo_usage
            ;;
    esac
}

demo_color() {
	clear
	echo "($USER@$THIS_HOST) $TERM"
	eart -n --c=001 '001  '; eart -n --c=002 '002  '; eart -n --c=003 '003  '; eart -n --c=004 '004  '; eart -n --c=005 '005  '; eart -n --c=006 '006  '; eart -n --c=007 '007  '; eart -n --c=008 '008  '; eart -n --c=009 '009  '; eart -n --c=010 '010  '; eart -n --c=011 '011  '; eart -n --c=012 '012  '; eart -n --c=013 '013  '; eart -n --c=014 '014  '; eart --c=015 '015  '; eart -bn --c=001 '001  '; eart -bn --c=002 '002  '; eart -bn --c=003 '003  '; eart -bn --c=004 '004  '; eart -bn --c=005 '005  '; eart -bn --c=006 '006  '; eart -bn --c=007 '007  '; eart -bn --c=008 '008  '; eart -bn --c=009 '009  '; eart -bn --c=010 '010  '; eart -bn --c=011 '011  '; eart -bn --c=012 '012  '; eart -bn --c=013 '013  '; eart -bn --c=014 '014  '; eart -b --c=015 '015  '; eart -n --c=016 '016  '; eart -n --c=017 '017  '; eart -n --c=018 '018  '; eart -n --c=019 '019  '; eart -n --c=020 '010  '; eart -n --c=021 '021  '; eart -n --c=022 '022  '; eart -n --c=023 '023  '; eart -n --c=024 '024  '; eart -n --c=025 '025  '; eart -n --c=026 '026  '; eart -n --c=027 '027  '; eart -n --c=028 '028  '; eart -n --c=029 '029  '; eart --c=030 '030  '; eart -bn --c=016 '016  '; eart -bn --c=017 '017  '; eart -bn --c=018 '018  '; eart -bn --c=019 '019  '; eart -bn --c=020 '010  '; eart -bn --c=021 '021  '; eart -bn --c=022 '022  '; eart -bn --c=023 '023  '; eart -bn --c=024 '024  '; eart -bn --c=025 '025  '; eart -bn --c=026 '026  '; eart -bn --c=027 '027  '; eart -bn --c=028 '028  '; eart -bn --c=029 '029  '; eart -b --c=030 '030  '; eart -n --c=031 '031  '; eart -n --c=032 '032  '; eart -n --c=033 '033  '; eart -n --c=034 '034  '; eart -n --c=035 '035  '; eart -n --c=036 '036  '; eart -n --c=037 '037  '; eart -n --c=038 '038  '; eart -n --c=039 '039  '; eart -n --c=040 '040  '; eart -n --c=041 '041  '; eart -n --c=042 '042  '; eart -n --c=043 '043  '; eart -n --c=044 '044  '; eart --c=045 '045  '; eart -bn --c=031 '031  '; eart -bn --c=032 '032  '; eart -bn --c=033 '033  '; eart -bn --c=034 '034  '; eart -bn --c=035 '035  '; eart -bn --c=036 '036  '; eart -bn --c=037 '037  '; eart -bn --c=038 '038  '; eart -bn --c=039 '039  '; eart -bn --c=040 '040  '; eart -bn --c=041 '041  '; eart -bn --c=042 '042  '; eart -bn --c=043 '043  '; eart -bn --c=044 '044  '; eart -b --c=045 '045  '; eart -n --c=046 '046  '; eart -n --c=047 '047  '; eart -n --c=048 '048  '; eart -n --c=049 '049  '; eart -n --c=050 '050  '; eart -n --c=051 '051  '; eart -n --c=052 '052  '; eart -n --c=053 '053  '; eart -n --c=054 '054  '; eart -n --c=055 '055  '; eart -n --c=056 '056  '; eart -n --c=057 '057  '; eart -n --c=058 '058  '; eart -n --c=059 '059  '; eart --c=060 '060  '; eart -bn --c=046 '046  '; eart -bn --c=047 '047  '; eart -bn --c=048 '048  '; eart -bn --c=049 '049  '; eart -bn --c=050 '050  '; eart -bn --c=051 '051  '; eart -bn --c=052 '052  '; eart -bn --c=053 '053  '; eart -bn --c=054 '054  '; eart -bn --c=055 '055  '; eart -bn --c=056 '056  '; eart -bn --c=057 '057  '; eart -bn --c=058 '058  '; eart -bn --c=059 '059  '; eart -b --c=060 '060  '; eart -n --c=061 '061  '; eart -n --c=062 '062  '; eart -n --c=063 '063  '; eart -n --c=064 '064  '; eart -n --c=065 '065  '; eart -n --c=066 '066  '; eart -n --c=067 '067  '; eart -n --c=068 '068  '; eart -n --c=069 '069  '; eart -n --c=070 '070  '; eart -n --c=071 '071  '; eart -n --c=072 '072  '; eart -n --c=073 '073  '; eart -n --c=074 '074  '; eart --c=075 '075  '; eart -bn --c=061 '061  '; eart -bn --c=062 '062  '; eart -bn --c=063 '063  '; eart -bn --c=064 '064  '; eart -bn --c=065 '065  '; eart -bn --c=066 '066  '; eart -bn --c=067 '067  '; eart -bn --c=068 '068  '; eart -bn --c=069 '069  '; eart -bn --c=070 '070  '; eart -bn --c=071 '071  '; eart -bn --c=072 '072  '; eart -bn --c=073 '073  '; eart -bn --c=074 '074  '; eart -b --c=075 '075  '; eart -n --c=076 '076  '; eart -n --c=077 '077  '; eart -n --c=078 '078  '; eart -n --c=079 '079  '; eart -n --c=080 '070  '; eart -n --c=081 '081  '; eart -n --c=082 '082  '; eart -n --c=083 '083  '; eart -n --c=084 '084  '; eart -n --c=085 '085  '; eart -n --c=086 '086  '; eart -n --c=087 '087  '; eart -n --c=088 '088  '; eart -n --c=089 '089  '; eart --c=090 '090  '; eart -bn --c=076 '076  '; eart -bn --c=077 '077  '; eart -bn --c=078 '078  '; eart -bn --c=079 '079  '; eart -bn --c=080 '070  '; eart -bn --c=081 '081  '; eart -bn --c=082 '082  '; eart -bn --c=083 '083  '; eart -bn --c=084 '084  '; eart -bn --c=085 '085  '; eart -bn --c=086 '086  '; eart -bn --c=087 '087  '; eart -bn --c=088 '088  '; eart -bn --c=089 '089  '; eart -b --c=090 '090  '; eart -n --c=091 '091  '; eart -n --c=092 '092  '; eart -n --c=093 '093  '; eart -n --c=094 '094  '; eart -n --c=095 '095  '; eart -n --c=096 '096  '; eart -n --c=097 '097  '; eart -n --c=098 '098  '; eart -n --c=099 '099  '; eart -n --c=100 '100  '; eart -n --c=101 '101  '; eart -n --c=102 '102  '; eart -n --c=103 '103  '; eart -n --c=104 '104  '; eart --c=105 '105  '; eart -bn --c=091 '091  '; eart -bn --c=092 '092  '; eart -bn --c=093 '093  '; eart -bn --c=094 '094  '; eart -bn --c=095 '095  '; eart -bn --c=096 '096  '; eart -bn --c=097 '097  '; eart -bn --c=098 '098  '; eart -bn --c=099 '099  '; eart -bn --c=100 '100  '; eart -bn --c=101 '101  '; eart -bn --c=102 '102  '; eart -bn --c=103 '103  '; eart -bn --c=104 '104  '; eart -b --c=105 '105  '; eart -n --c=106 '106  '; eart -n --c=107 '107  '; eart -n --c=108 '108  '; eart -n --c=109 '109  '; eart -n --c=110 '110  '; eart -n --c=111 '111  '; eart -n --c=112 '112  '; eart -n --c=113 '113  '; eart -n --c=114 '114  '; eart -n --c=115 '115  '; eart -n --c=116 '116  '; eart -n --c=117 '117  '; eart -n --c=118 '118  '; eart -n --c=119 '119  '; eart --c=120 '120  '; eart -bn --c=106 '106  '; eart -bn --c=107 '107  '; eart -bn --c=108 '108  '; eart -bn --c=109 '109  '; eart -bn --c=110 '110  '; eart -bn --c=111 '111  '; eart -bn --c=112 '112  '; eart -bn --c=113 '113  '; eart -bn --c=114 '114  '; eart -bn --c=115 '115  '; eart -bn --c=116 '116  '; eart -bn --c=117 '117  '; eart -bn --c=118 '118  '; eart -bn --c=119 '119  '; eart -b --c=120 '120  '; eart -n --c=121 '121  '; eart -n --c=122 '122  '; eart -n --c=123 '123  '; eart -n --c=124 '124  '; eart -n --c=125 '125  '; eart -n --c=126 '126  '; eart -n --c=127 '127  '; eart -n --c=128 '128  '; eart -n --c=129 '129  '; eart -n --c=130 '130  '; eart -n --c=131 '131  '; eart -n --c=132 '132  '; eart -n --c=133 '133  '; eart -n --c=134 '134  '; eart --c=135 '135  '; eart -bn --c=121 '121  '; eart -bn --c=122 '122  '; eart -bn --c=123 '123  '; eart -bn --c=124 '124  '; eart -bn --c=125 '125  '; eart -bn --c=126 '126  '; eart -bn --c=127 '127  '; eart -bn --c=128 '128  '; eart -bn --c=129 '129  '; eart -bn --c=130 '130  '; eart -bn --c=131 '131  '; eart -bn --c=132 '132  '; eart -bn --c=133 '133  '; eart -bn --c=134 '134  '; eart -b --c=135 '135  '; eart -n --c=136 '136  '; eart -n --c=137 '137  '; eart -n --c=138 '138  '; eart -n --c=139 '139  '; eart -n --c=140 '140  '; eart -n --c=141 '141  '; eart -n --c=142 '142  '; eart -n --c=143 '143  '; eart -n --c=144 '144  '; eart -n --c=145 '145  '; eart -n --c=146 '146  '; eart -n --c=147 '147  '; eart -n --c=148 '148  '; eart -n --c=149 '149  '; eart --c=150 '150  '; eart -bn --c=136 '136  '; eart -bn --c=137 '137  '; eart -bn --c=138 '138  '; eart -bn --c=139 '139  '; eart -bn --c=140 '140  '; eart -bn --c=141 '141  '; eart -bn --c=142 '142  '; eart -bn --c=143 '143  '; eart -bn --c=144 '144  '; eart -bn --c=145 '145  '; eart -bn --c=146 '146  '; eart -bn --c=147 '147  '; eart -bn --c=148 '148  '; eart -bn --c=149 '149  '; eart -b --c=150 '150  '; eart -n --c=151 '151  '; eart -n --c=152 '152  '; eart -n --c=153 '153  '; eart -n --c=154 '154  '; eart -n --c=155 '155  '; eart -n --c=156 '156  '; eart -n --c=157 '157  '; eart -n --c=158 '158  '; eart -n --c=159 '159  '; eart -n --c=160 '160  '; eart -n --c=161 '161  '; eart -n --c=162 '162  '; eart -n --c=163 '163  '; eart -n --c=164 '164  '; eart --c=165 '165  '; eart -bn --c=151 '151  '; eart -bn --c=152 '152  '; eart -bn --c=153 '153  '; eart -bn --c=154 '154  '; eart -bn --c=155 '155  '; eart -bn --c=156 '156  '; eart -bn --c=157 '157  '; eart -bn --c=158 '158  '; eart -bn --c=159 '159  '; eart -bn --c=160 '160  '; eart -bn --c=161 '161  '; eart -bn --c=162 '162  '; eart -bn --c=163 '163  '; eart -bn --c=164 '164  '; eart -b --c=165 '165  '; eart -n --c=166 '166  '; eart -n --c=167 '167  '; eart -n --c=168 '168  '; eart -n --c=169 '169  '; eart -n --c=170 '170  '; eart -n --c=171 '171  '; eart -n --c=172 '172  '; eart -n --c=173 '173  '; eart -n --c=174 '174  '; eart -n --c=175 '175  '; eart -n --c=176 '176  '; eart -n --c=177 '177  '; eart -n --c=178 '178  '; eart -n --c=179 '179  '; eart --c=180 '180  '; eart -bn --c=166 '166  '; eart -bn --c=167 '167  '; eart -bn --c=168 '168  '; eart -bn --c=169 '169  '; eart -bn --c=170 '170  '; eart -bn --c=171 '171  '; eart -bn --c=172 '172  '; eart -bn --c=173 '173  '; eart -bn --c=174 '174  '; eart -bn --c=175 '175  '; eart -bn --c=176 '176  '; eart -bn --c=177 '177  '; eart -bn --c=178 '178  '; eart -bn --c=179 '179  '; eart -b --c=180 '180  '; eart -n --c=181 '181  '; eart -n --c=182 '182  '; eart -n --c=183 '183  '; eart -n --c=184 '184  '; eart -n --c=185 '185  '; eart -n --c=186 '186  '; eart -n --c=187 '187  '; eart -n --c=188 '188  '; eart -n --c=189 '189  '; eart -n --c=190 '190  '; eart -n --c=191 '191  '; eart -n --c=192 '192  '; eart -n --c=193 '193  '; eart -n --c=194 '194  '; eart --c=195 '195  '; eart -bn --c=181 '181  '; eart -bn --c=182 '182  '; eart -bn --c=183 '183  '; eart -bn --c=184 '184  '; eart -bn --c=185 '185  '; eart -bn --c=186 '186  '; eart -bn --c=187 '187  '; eart -bn --c=188 '188  '; eart -bn --c=189 '189  '; eart -bn --c=190 '190  '; eart -bn --c=191 '191  '; eart -bn --c=192 '192  '; eart -bn --c=193 '193  '; eart -bn --c=194 '194  '; eart -b --c=195 '195  '; eart -n --c=196 '196  '; eart -n --c=197 '197  '; eart -n --c=198 '198  '; eart -n --c=199 '199  '; eart -n --c=200 '200  '; eart -n --c=201 '201  '; eart -n --c=202 '202  '; eart -n --c=203 '203  '; eart -n --c=204 '204  '; eart -n --c=205 '205  '; eart -n --c=206 '206  '; eart -n --c=207 '207  '; eart -n --c=208 '208  '; eart -n --c=209 '209  '; eart --c=210 '210  '; eart -bn --c=196 '196  '; eart -bn --c=197 '197  '; eart -bn --c=198 '198  '; eart -bn --c=199 '199  '; eart -bn --c=200 '200  '; eart -bn --c=201 '201  '; eart -bn --c=202 '202  '; eart -bn --c=203 '203  '; eart -bn --c=204 '204  '; eart -bn --c=205 '205  '; eart -bn --c=206 '206  '; eart -bn --c=207 '207  '; eart -bn --c=208 '208  '; eart -bn --c=209 '209  '; eart -b --c=210 '210  '; eart -n --c=211 '211  '; eart -n --c=212 '212  '; eart -n --c=213 '213  '; eart -n --c=214 '214  '; eart -n --c=215 '215  '; eart -n --c=216 '216  '; eart -n --c=217 '217  '; eart -n --c=218 '218  '; eart -n --c=219 '219  '; eart -n --c=220 '220  '; eart -n --c=221 '221  '; eart -n --c=222 '222  '; eart -n --c=223 '223  '; eart -n --c=224 '224  '; eart --c=225 '225  '; eart -bn --c=211 '211  '; eart -bn --c=212 '212  '; eart -bn --c=213 '213  '; eart -bn --c=214 '214  '; eart -bn --c=215 '215  '; eart -bn --c=216 '216  '; eart -bn --c=217 '217  '; eart -bn --c=218 '218  '; eart -bn --c=219 '219  '; eart -bn --c=220 '220  '; eart -bn --c=221 '221  '; eart -bn --c=222 '222  '; eart -bn --c=223 '223  '; eart -bn --c=224 '224  '; eart -b --c=225 '225  '; eart -n --c=226 '226  '; eart -n --c=227 '227  '; eart -n --c=228 '228  '; eart -n --c=229 '229  '; eart -n --c=230 '230  '; eart -n --c=231 '231  '; eart -n --c=232 '232  '; eart -n --c=233 '233  '; eart -n --c=234 '234  '; eart -n --c=235 '235  '; eart -n --c=236 '236  '; eart -n --c=237 '237  '; eart -n --c=238 '238  '; eart -n --c=239 '239  '; eart --c=240 '240  '; eart -bn --c=226 '226  '; eart -bn --c=227 '227  '; eart -bn --c=228 '228  '; eart -bn --c=229 '229  '; eart -bn --c=230 '230  '; eart -bn --c=231 '231  '; eart -bn --c=232 '232  '; eart -bn --c=233 '233  '; eart -bn --c=234 '234  '; eart -bn --c=235 '235  '; eart -bn --c=236 '236  '; eart -bn --c=237 '237  '; eart -bn --c=238 '238  '; eart -bn --c=239 '239  '; eart -b --c=240 '240  '; eart -n --c=241 '241  '; eart -n --c=242 '242  '; eart -n --c=243 '243  '; eart -n --c=244 '244  '; eart -n --c=245 '245  '; eart -n --c=246 '246  '; eart -n --c=247 '247  '; eart -n --c=248 '248  '; eart -n --c=249 '249  '; eart -n --c=250 '250  '; eart -n --c=251 '251  '; eart -n --c=252 '252  '; eart -n --c=253 '253  '; eart -n --c=254 '254  '; eart --c=255 '255  '; eart -bn --c=241 '241  '; eart -bn --c=242 '242  '; eart -bn --c=243 '243  '; eart -bn --c=244 '244  '; eart -bn --c=245 '245  '; eart -bn --c=246 '246  '; eart -bn --c=247 '247  '; eart -bn --c=248 '248  '; eart -bn --c=249 '249  '; eart -bn --c=250 '250  '; eart -bn --c=251 '251  '; eart -bn --c=252 '252  '; eart -bn --c=253 '253  '; eart -bn --c=254 '254  '; eart -b --c=255 '255  '

}


