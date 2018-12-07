# Copyright (c) 2017, Matheus Gibiluka, and Matheus Trevisan Moreira
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
    # * Redistributions of source code must retain the above copyright
      # notice, this list of conditions and the following disclaimer.
    # * Redistributions in binary form must reproduce the above copyright
      # notice, this list of conditions and the following disclaimer in the
      # documentation and/or other materials provided with the distribution.
    # * Neither the name of the Pontifical Catholic University of Rio Grande do Sul nor the
      # names of its contributors may be used to endorse or promote products
      # derived from this software without specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL Matheus Gibiluka, and Matheus Trevisan Moreira BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#compile_clock_tree -high_fanout_net edge_clk_s
#compile_clock_tree -high_fanout_net edge_clk_m

#set_clock_tree_references -references $buffer_cell
clock_opt -inter_clock_balance  -concurrent_clock_and_data
set M3Width [expr 2 *[get_attribute  [get_layers M3] defaultWidth]]
set M4Width [expr 2 *[get_attribute  [get_layers M4] defaultWidth]]
set pitch [get_attribute  [get_layers M4] pitch]
define_routing_rule M3_M4NDR -widths "M4 $M3Width  M5 $M4Width" -spacings  " M4 $pitch M5 $pitch"

set_clock_tree_references -references $ctree  
set_clock_tree_options -max_fanout 25 -max_transition [expr 0.1 * $CLK_PERIOD] -ocv_clustering true -target_skew 0.1 -routing_rule M3_M4NDR -target_early_delay [expr 0.35 * $CLK_PERIOD] -routing_rule M3_M4NDR 

compile_clock_tree -high_fanout_net [get_net {edge*/edge_clk_m edge*/edge_clk_s clk_put clk_net}]

#compile_clock_tree -high_fanout_net "edge_clk_m edge_clk_s"
