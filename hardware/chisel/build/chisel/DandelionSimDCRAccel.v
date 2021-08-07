module VTASim(
  input   clock,
  input   reset,
  output  sim_wait
);
  wire  sim_clock; // @[SimShell.scala 55:19]
  wire  sim_reset; // @[SimShell.scala 55:19]
  wire  sim_dpi_wait; // @[SimShell.scala 55:19]
  VTASimDPI sim ( // @[SimShell.scala 55:19]
    .clock(sim_clock),
    .reset(sim_reset),
    .dpi_wait(sim_dpi_wait)
  );
  assign sim_wait = sim_dpi_wait; // @[SimShell.scala 58:12]
  assign sim_clock = clock; // @[SimShell.scala 57:16]
  assign sim_reset = reset; // @[SimShell.scala 56:16]
endmodule
module VTAHostDPIToAXI(
  input         clock,
  input         reset,
  input         io_dpi_req_valid,
  input         io_dpi_req_opcode,
  input  [31:0] io_dpi_req_addr,
  input  [31:0] io_dpi_req_value,
  output        io_dpi_req_deq,
  output        io_dpi_resp_valid,
  output [31:0] io_dpi_resp_bits,
  input         io_axi_aw_ready,
  output        io_axi_aw_valid,
  output [31:0] io_axi_aw_bits_addr,
  input         io_axi_w_ready,
  output        io_axi_w_valid,
  output [63:0] io_axi_w_bits_data,
  output        io_axi_b_ready,
  input         io_axi_b_valid,
  input         io_axi_ar_ready,
  output        io_axi_ar_valid,
  output [31:0] io_axi_ar_bits_addr,
  output        io_axi_r_ready,
  input         io_axi_r_valid,
  input  [63:0] io_axi_r_bits_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] addr; // @[VTAHostDPI.scala 69:21]
  reg [31:0] data; // @[VTAHostDPI.scala 70:21]
  reg [2:0] state; // @[VTAHostDPI.scala 73:22]
  wire  _T_2 = 3'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_3 = 3'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_4 = 3'h2 == state; // @[Conditional.scala 37:30]
  wire  _T_5 = 3'h3 == state; // @[Conditional.scala 37:30]
  wire  _T_6 = 3'h4 == state; // @[Conditional.scala 37:30]
  wire  _T_7 = 3'h5 == state; // @[Conditional.scala 37:30]
  wire  _T_8 = state == 3'h0; // @[VTAHostDPI.scala 112:14]
  wire  _T_9 = _T_8 & io_dpi_req_valid; // @[VTAHostDPI.scala 112:24]
  wire  _T_10 = state == 3'h3; // @[VTAHostDPI.scala 117:28]
  wire  _T_13 = state == 3'h1; // @[VTAHostDPI.scala 124:28]
  wire  _T_16 = _T_13 & io_axi_ar_ready; // @[VTAHostDPI.scala 128:45]
  wire  _T_18 = _T_10 & io_axi_aw_ready; // @[VTAHostDPI.scala 128:91]
  assign io_dpi_req_deq = _T_16 | _T_18; // @[VTAHostDPI.scala 128:18]
  assign io_dpi_resp_valid = io_axi_r_valid; // @[VTAHostDPI.scala 129:21]
  assign io_dpi_resp_bits = io_axi_r_bits_data[31:0]; // @[VTAHostDPI.scala 130:20]
  assign io_axi_aw_valid = state == 3'h3; // @[VTAHostDPI.scala 117:19]
  assign io_axi_aw_bits_addr = addr; // @[VTAHostDPI.scala 118:23]
  assign io_axi_w_valid = state == 3'h4; // @[VTAHostDPI.scala 119:18]
  assign io_axi_w_bits_data = {{32'd0}, data}; // @[VTAHostDPI.scala 120:22]
  assign io_axi_b_ready = state == 3'h5; // @[VTAHostDPI.scala 122:18]
  assign io_axi_ar_valid = state == 3'h1; // @[VTAHostDPI.scala 124:19]
  assign io_axi_ar_bits_addr = addr; // @[VTAHostDPI.scala 125:23]
  assign io_axi_r_ready = state == 3'h2; // @[VTAHostDPI.scala 126:18]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  addr = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  data = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  state = _RAND_2[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      addr <= 32'h0;
    end else if (_T_9) begin
      addr <= io_dpi_req_addr;
    end
    if (reset) begin
      data <= 32'h0;
    end else if (_T_9) begin
      data <= io_dpi_req_value;
    end
    if (reset) begin
      state <= 3'h0;
    end else if (_T_2) begin
      if (io_dpi_req_valid) begin
        if (io_dpi_req_opcode) begin
          state <= 3'h3;
        end else begin
          state <= 3'h1;
        end
      end
    end else if (_T_3) begin
      if (io_axi_ar_ready) begin
        state <= 3'h2;
      end
    end else if (_T_4) begin
      if (io_axi_r_valid) begin
        state <= 3'h0;
      end
    end else if (_T_5) begin
      if (io_axi_aw_ready) begin
        state <= 3'h4;
      end
    end else if (_T_6) begin
      if (io_axi_w_ready) begin
        state <= 3'h5;
      end
    end else if (_T_7) begin
      if (io_axi_b_valid) begin
        state <= 3'h0;
      end
    end
  end
endmodule
module VTAHost(
  input         clock,
  input         reset,
  input         io_axi_aw_ready,
  output        io_axi_aw_valid,
  output [31:0] io_axi_aw_bits_addr,
  input         io_axi_w_ready,
  output        io_axi_w_valid,
  output [63:0] io_axi_w_bits_data,
  output        io_axi_b_ready,
  input         io_axi_b_valid,
  input         io_axi_ar_ready,
  output        io_axi_ar_valid,
  output [31:0] io_axi_ar_bits_addr,
  output        io_axi_r_ready,
  input         io_axi_r_valid,
  input  [63:0] io_axi_r_bits_data
);
  wire  host_dpi_clock; // @[SimShell.scala 20:24]
  wire  host_dpi_reset; // @[SimShell.scala 20:24]
  wire  host_dpi_dpi_req_valid; // @[SimShell.scala 20:24]
  wire  host_dpi_dpi_req_opcode; // @[SimShell.scala 20:24]
  wire [31:0] host_dpi_dpi_req_addr; // @[SimShell.scala 20:24]
  wire [31:0] host_dpi_dpi_req_value; // @[SimShell.scala 20:24]
  wire  host_dpi_dpi_req_deq; // @[SimShell.scala 20:24]
  wire  host_dpi_dpi_resp_valid; // @[SimShell.scala 20:24]
  wire [31:0] host_dpi_dpi_resp_bits; // @[SimShell.scala 20:24]
  wire  host_axi_clock; // @[SimShell.scala 21:24]
  wire  host_axi_reset; // @[SimShell.scala 21:24]
  wire  host_axi_io_dpi_req_valid; // @[SimShell.scala 21:24]
  wire  host_axi_io_dpi_req_opcode; // @[SimShell.scala 21:24]
  wire [31:0] host_axi_io_dpi_req_addr; // @[SimShell.scala 21:24]
  wire [31:0] host_axi_io_dpi_req_value; // @[SimShell.scala 21:24]
  wire  host_axi_io_dpi_req_deq; // @[SimShell.scala 21:24]
  wire  host_axi_io_dpi_resp_valid; // @[SimShell.scala 21:24]
  wire [31:0] host_axi_io_dpi_resp_bits; // @[SimShell.scala 21:24]
  wire  host_axi_io_axi_aw_ready; // @[SimShell.scala 21:24]
  wire  host_axi_io_axi_aw_valid; // @[SimShell.scala 21:24]
  wire [31:0] host_axi_io_axi_aw_bits_addr; // @[SimShell.scala 21:24]
  wire  host_axi_io_axi_w_ready; // @[SimShell.scala 21:24]
  wire  host_axi_io_axi_w_valid; // @[SimShell.scala 21:24]
  wire [63:0] host_axi_io_axi_w_bits_data; // @[SimShell.scala 21:24]
  wire  host_axi_io_axi_b_ready; // @[SimShell.scala 21:24]
  wire  host_axi_io_axi_b_valid; // @[SimShell.scala 21:24]
  wire  host_axi_io_axi_ar_ready; // @[SimShell.scala 21:24]
  wire  host_axi_io_axi_ar_valid; // @[SimShell.scala 21:24]
  wire [31:0] host_axi_io_axi_ar_bits_addr; // @[SimShell.scala 21:24]
  wire  host_axi_io_axi_r_ready; // @[SimShell.scala 21:24]
  wire  host_axi_io_axi_r_valid; // @[SimShell.scala 21:24]
  wire [63:0] host_axi_io_axi_r_bits_data; // @[SimShell.scala 21:24]
  VTAHostDPI host_dpi ( // @[SimShell.scala 20:24]
    .clock(host_dpi_clock),
    .reset(host_dpi_reset),
    .dpi_req_valid(host_dpi_dpi_req_valid),
    .dpi_req_opcode(host_dpi_dpi_req_opcode),
    .dpi_req_addr(host_dpi_dpi_req_addr),
    .dpi_req_value(host_dpi_dpi_req_value),
    .dpi_req_deq(host_dpi_dpi_req_deq),
    .dpi_resp_valid(host_dpi_dpi_resp_valid),
    .dpi_resp_bits(host_dpi_dpi_resp_bits)
  );
  VTAHostDPIToAXI host_axi ( // @[SimShell.scala 21:24]
    .clock(host_axi_clock),
    .reset(host_axi_reset),
    .io_dpi_req_valid(host_axi_io_dpi_req_valid),
    .io_dpi_req_opcode(host_axi_io_dpi_req_opcode),
    .io_dpi_req_addr(host_axi_io_dpi_req_addr),
    .io_dpi_req_value(host_axi_io_dpi_req_value),
    .io_dpi_req_deq(host_axi_io_dpi_req_deq),
    .io_dpi_resp_valid(host_axi_io_dpi_resp_valid),
    .io_dpi_resp_bits(host_axi_io_dpi_resp_bits),
    .io_axi_aw_ready(host_axi_io_axi_aw_ready),
    .io_axi_aw_valid(host_axi_io_axi_aw_valid),
    .io_axi_aw_bits_addr(host_axi_io_axi_aw_bits_addr),
    .io_axi_w_ready(host_axi_io_axi_w_ready),
    .io_axi_w_valid(host_axi_io_axi_w_valid),
    .io_axi_w_bits_data(host_axi_io_axi_w_bits_data),
    .io_axi_b_ready(host_axi_io_axi_b_ready),
    .io_axi_b_valid(host_axi_io_axi_b_valid),
    .io_axi_ar_ready(host_axi_io_axi_ar_ready),
    .io_axi_ar_valid(host_axi_io_axi_ar_valid),
    .io_axi_ar_bits_addr(host_axi_io_axi_ar_bits_addr),
    .io_axi_r_ready(host_axi_io_axi_r_ready),
    .io_axi_r_valid(host_axi_io_axi_r_valid),
    .io_axi_r_bits_data(host_axi_io_axi_r_bits_data)
  );
  assign io_axi_aw_valid = host_axi_io_axi_aw_valid; // @[SimShell.scala 25:10]
  assign io_axi_aw_bits_addr = host_axi_io_axi_aw_bits_addr; // @[SimShell.scala 25:10]
  assign io_axi_w_valid = host_axi_io_axi_w_valid; // @[SimShell.scala 25:10]
  assign io_axi_w_bits_data = host_axi_io_axi_w_bits_data; // @[SimShell.scala 25:10]
  assign io_axi_b_ready = host_axi_io_axi_b_ready; // @[SimShell.scala 25:10]
  assign io_axi_ar_valid = host_axi_io_axi_ar_valid; // @[SimShell.scala 25:10]
  assign io_axi_ar_bits_addr = host_axi_io_axi_ar_bits_addr; // @[SimShell.scala 25:10]
  assign io_axi_r_ready = host_axi_io_axi_r_ready; // @[SimShell.scala 25:10]
  assign host_dpi_clock = clock; // @[SimShell.scala 23:21]
  assign host_dpi_reset = reset; // @[SimShell.scala 22:21]
  assign host_dpi_dpi_req_deq = host_axi_io_dpi_req_deq; // @[SimShell.scala 24:19]
  assign host_dpi_dpi_resp_valid = host_axi_io_dpi_resp_valid; // @[SimShell.scala 24:19]
  assign host_dpi_dpi_resp_bits = host_axi_io_dpi_resp_bits; // @[SimShell.scala 24:19]
  assign host_axi_clock = clock;
  assign host_axi_reset = reset;
  assign host_axi_io_dpi_req_valid = host_dpi_dpi_req_valid; // @[SimShell.scala 24:19]
  assign host_axi_io_dpi_req_opcode = host_dpi_dpi_req_opcode; // @[SimShell.scala 24:19]
  assign host_axi_io_dpi_req_addr = host_dpi_dpi_req_addr; // @[SimShell.scala 24:19]
  assign host_axi_io_dpi_req_value = host_dpi_dpi_req_value; // @[SimShell.scala 24:19]
  assign host_axi_io_axi_aw_ready = io_axi_aw_ready; // @[SimShell.scala 25:10]
  assign host_axi_io_axi_w_ready = io_axi_w_ready; // @[SimShell.scala 25:10]
  assign host_axi_io_axi_b_valid = io_axi_b_valid; // @[SimShell.scala 25:10]
  assign host_axi_io_axi_ar_ready = io_axi_ar_ready; // @[SimShell.scala 25:10]
  assign host_axi_io_axi_r_valid = io_axi_r_valid; // @[SimShell.scala 25:10]
  assign host_axi_io_axi_r_bits_data = io_axi_r_bits_data; // @[SimShell.scala 25:10]
endmodule
module VTAMemDPIToAXI(
  input         clock,
  input         reset,
  output        io_dpi_req_valid,
  output        io_dpi_req_opcode,
  output [31:0] io_dpi_req_len,
  output [63:0] io_dpi_req_addr,
  output        io_dpi_wr_valid,
  output [63:0] io_dpi_wr_bits,
  output        io_dpi_rd_ready,
  input         io_dpi_rd_valid,
  input  [63:0] io_dpi_rd_bits,
  output        io_axi_aw_ready,
  input         io_axi_aw_valid,
  input  [31:0] io_axi_aw_bits_addr,
  input  [31:0] io_axi_aw_bits_len,
  output        io_axi_w_ready,
  input         io_axi_w_valid,
  input  [63:0] io_axi_w_bits_data,
  input         io_axi_w_bits_last,
  input         io_axi_b_ready,
  output        io_axi_b_valid,
  output        io_axi_ar_ready,
  input         io_axi_ar_valid,
  input  [31:0] io_axi_ar_bits_addr,
  input  [31:0] io_axi_ar_bits_len,
  input         io_axi_r_ready,
  output        io_axi_r_valid,
  output [63:0] io_axi_r_bits_data,
  output        io_axi_r_bits_last
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  opcode; // @[VTAMemDPI.scala 85:23]
  reg [31:0] len; // @[VTAMemDPI.scala 86:20]
  reg [63:0] addr; // @[VTAMemDPI.scala 87:21]
  reg [2:0] state; // @[VTAMemDPI.scala 90:22]
  wire  _T_2 = 3'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_3 = 3'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_4 = 3'h2 == state; // @[Conditional.scala 37:30]
  wire  _T_5 = io_axi_r_ready & io_dpi_rd_valid; // @[VTAMemDPI.scala 106:27]
  wire  _T_6 = len == 32'h0; // @[VTAMemDPI.scala 106:53]
  wire  _T_7 = _T_5 & _T_6; // @[VTAMemDPI.scala 106:46]
  wire  _T_8 = 3'h3 == state; // @[Conditional.scala 37:30]
  wire  _T_9 = 3'h4 == state; // @[Conditional.scala 37:30]
  wire  _T_10 = io_axi_w_valid & io_axi_w_bits_last; // @[VTAMemDPI.scala 116:27]
  wire  _T_11 = 3'h5 == state; // @[Conditional.scala 37:30]
  wire  _T_12 = state == 3'h0; // @[VTAMemDPI.scala 127:14]
  wire  _GEN_13 = io_axi_aw_valid | opcode; // @[VTAMemDPI.scala 132:33]
  wire  _T_13 = state == 3'h2; // @[VTAMemDPI.scala 138:20]
  wire  _T_15 = len != 32'h0; // @[VTAMemDPI.scala 139:51]
  wire  _T_16 = _T_5 & _T_15; // @[VTAMemDPI.scala 139:44]
  wire [31:0] _T_18 = len - 32'h1; // @[VTAMemDPI.scala 140:18]
  wire  _T_19 = state == 3'h1; // @[VTAMemDPI.scala 144:30]
  wire  _T_20 = _T_19 & io_axi_ar_valid; // @[VTAMemDPI.scala 144:47]
  wire  _T_21 = state == 3'h3; // @[VTAMemDPI.scala 144:75]
  wire  _T_22 = _T_21 & io_axi_aw_valid; // @[VTAMemDPI.scala 144:93]
  wire  _T_31 = state == 3'h4; // @[VTAMemDPI.scala 160:28]
  assign io_dpi_req_valid = _T_20 | _T_22; // @[VTAMemDPI.scala 144:20]
  assign io_dpi_req_opcode = opcode; // @[VTAMemDPI.scala 145:21]
  assign io_dpi_req_len = len; // @[VTAMemDPI.scala 146:18]
  assign io_dpi_req_addr = addr; // @[VTAMemDPI.scala 147:19]
  assign io_dpi_wr_valid = _T_31 & io_axi_w_valid; // @[VTAMemDPI.scala 160:19]
  assign io_dpi_wr_bits = io_axi_w_bits_data; // @[VTAMemDPI.scala 161:18]
  assign io_dpi_rd_ready = _T_13 & io_axi_r_ready; // @[VTAMemDPI.scala 158:19]
  assign io_axi_aw_ready = state == 3'h3; // @[VTAMemDPI.scala 150:19]
  assign io_axi_w_ready = state == 3'h4; // @[VTAMemDPI.scala 162:18]
  assign io_axi_b_valid = state == 3'h5; // @[VTAMemDPI.scala 164:18]
  assign io_axi_ar_ready = state == 3'h1; // @[VTAMemDPI.scala 149:19]
  assign io_axi_r_valid = _T_13 & io_dpi_rd_valid; // @[VTAMemDPI.scala 152:18]
  assign io_axi_r_bits_data = io_dpi_rd_bits; // @[VTAMemDPI.scala 153:22]
  assign io_axi_r_bits_last = len == 32'h0; // @[VTAMemDPI.scala 154:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  opcode = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  len = _RAND_1[31:0];
  _RAND_2 = {2{`RANDOM}};
  addr = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  state = _RAND_3[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      opcode <= 1'h0;
    end else if (_T_12) begin
      if (io_axi_ar_valid) begin
        opcode <= 1'h0;
      end else begin
        opcode <= _GEN_13;
      end
    end
    if (reset) begin
      len <= 32'h0;
    end else if (_T_12) begin
      if (io_axi_ar_valid) begin
        len <= io_axi_ar_bits_len;
      end else if (io_axi_aw_valid) begin
        len <= io_axi_aw_bits_len;
      end
    end else if (_T_13) begin
      if (_T_16) begin
        len <= _T_18;
      end
    end
    if (reset) begin
      addr <= 64'h0;
    end else if (_T_12) begin
      if (io_axi_ar_valid) begin
        addr <= {{32'd0}, io_axi_ar_bits_addr};
      end else if (io_axi_aw_valid) begin
        addr <= {{32'd0}, io_axi_aw_bits_addr};
      end
    end
    if (reset) begin
      state <= 3'h0;
    end else if (_T_2) begin
      if (io_axi_ar_valid) begin
        state <= 3'h1;
      end else if (io_axi_aw_valid) begin
        state <= 3'h3;
      end
    end else if (_T_3) begin
      if (io_axi_ar_valid) begin
        state <= 3'h2;
      end
    end else if (_T_4) begin
      if (_T_7) begin
        state <= 3'h0;
      end
    end else if (_T_8) begin
      if (io_axi_aw_valid) begin
        state <= 3'h4;
      end
    end else if (_T_9) begin
      if (_T_10) begin
        state <= 3'h5;
      end
    end else if (_T_11) begin
      if (io_axi_b_ready) begin
        state <= 3'h0;
      end
    end
  end
endmodule
module VTAMem(
  input         clock,
  input         reset,
  output        io_axi_aw_ready,
  input         io_axi_aw_valid,
  input  [31:0] io_axi_aw_bits_addr,
  input  [31:0] io_axi_aw_bits_len,
  output        io_axi_w_ready,
  input         io_axi_w_valid,
  input  [63:0] io_axi_w_bits_data,
  input         io_axi_w_bits_last,
  input         io_axi_b_ready,
  output        io_axi_b_valid,
  output        io_axi_ar_ready,
  input         io_axi_ar_valid,
  input  [31:0] io_axi_ar_bits_addr,
  input  [31:0] io_axi_ar_bits_len,
  input         io_axi_r_ready,
  output        io_axi_r_valid,
  output [63:0] io_axi_r_bits_data,
  output        io_axi_r_bits_last
);
  wire  mem_dpi_clock; // @[SimShell.scala 38:23]
  wire  mem_dpi_reset; // @[SimShell.scala 38:23]
  wire  mem_dpi_dpi_req_valid; // @[SimShell.scala 38:23]
  wire  mem_dpi_dpi_req_opcode; // @[SimShell.scala 38:23]
  wire [31:0] mem_dpi_dpi_req_len; // @[SimShell.scala 38:23]
  wire [63:0] mem_dpi_dpi_req_addr; // @[SimShell.scala 38:23]
  wire  mem_dpi_dpi_wr_valid; // @[SimShell.scala 38:23]
  wire [63:0] mem_dpi_dpi_wr_bits; // @[SimShell.scala 38:23]
  wire  mem_dpi_dpi_rd_ready; // @[SimShell.scala 38:23]
  wire  mem_dpi_dpi_rd_valid; // @[SimShell.scala 38:23]
  wire [63:0] mem_dpi_dpi_rd_bits; // @[SimShell.scala 38:23]
  wire  mem_axi_clock; // @[SimShell.scala 39:23]
  wire  mem_axi_reset; // @[SimShell.scala 39:23]
  wire  mem_axi_io_dpi_req_valid; // @[SimShell.scala 39:23]
  wire  mem_axi_io_dpi_req_opcode; // @[SimShell.scala 39:23]
  wire [31:0] mem_axi_io_dpi_req_len; // @[SimShell.scala 39:23]
  wire [63:0] mem_axi_io_dpi_req_addr; // @[SimShell.scala 39:23]
  wire  mem_axi_io_dpi_wr_valid; // @[SimShell.scala 39:23]
  wire [63:0] mem_axi_io_dpi_wr_bits; // @[SimShell.scala 39:23]
  wire  mem_axi_io_dpi_rd_ready; // @[SimShell.scala 39:23]
  wire  mem_axi_io_dpi_rd_valid; // @[SimShell.scala 39:23]
  wire [63:0] mem_axi_io_dpi_rd_bits; // @[SimShell.scala 39:23]
  wire  mem_axi_io_axi_aw_ready; // @[SimShell.scala 39:23]
  wire  mem_axi_io_axi_aw_valid; // @[SimShell.scala 39:23]
  wire [31:0] mem_axi_io_axi_aw_bits_addr; // @[SimShell.scala 39:23]
  wire [31:0] mem_axi_io_axi_aw_bits_len; // @[SimShell.scala 39:23]
  wire  mem_axi_io_axi_w_ready; // @[SimShell.scala 39:23]
  wire  mem_axi_io_axi_w_valid; // @[SimShell.scala 39:23]
  wire [63:0] mem_axi_io_axi_w_bits_data; // @[SimShell.scala 39:23]
  wire  mem_axi_io_axi_w_bits_last; // @[SimShell.scala 39:23]
  wire  mem_axi_io_axi_b_ready; // @[SimShell.scala 39:23]
  wire  mem_axi_io_axi_b_valid; // @[SimShell.scala 39:23]
  wire  mem_axi_io_axi_ar_ready; // @[SimShell.scala 39:23]
  wire  mem_axi_io_axi_ar_valid; // @[SimShell.scala 39:23]
  wire [31:0] mem_axi_io_axi_ar_bits_addr; // @[SimShell.scala 39:23]
  wire [31:0] mem_axi_io_axi_ar_bits_len; // @[SimShell.scala 39:23]
  wire  mem_axi_io_axi_r_ready; // @[SimShell.scala 39:23]
  wire  mem_axi_io_axi_r_valid; // @[SimShell.scala 39:23]
  wire [63:0] mem_axi_io_axi_r_bits_data; // @[SimShell.scala 39:23]
  wire  mem_axi_io_axi_r_bits_last; // @[SimShell.scala 39:23]
  VTAMemDPI mem_dpi ( // @[SimShell.scala 38:23]
    .clock(mem_dpi_clock),
    .reset(mem_dpi_reset),
    .dpi_req_valid(mem_dpi_dpi_req_valid),
    .dpi_req_opcode(mem_dpi_dpi_req_opcode),
    .dpi_req_len(mem_dpi_dpi_req_len),
    .dpi_req_addr(mem_dpi_dpi_req_addr),
    .dpi_wr_valid(mem_dpi_dpi_wr_valid),
    .dpi_wr_bits(mem_dpi_dpi_wr_bits),
    .dpi_rd_ready(mem_dpi_dpi_rd_ready),
    .dpi_rd_valid(mem_dpi_dpi_rd_valid),
    .dpi_rd_bits(mem_dpi_dpi_rd_bits)
  );
  VTAMemDPIToAXI mem_axi ( // @[SimShell.scala 39:23]
    .clock(mem_axi_clock),
    .reset(mem_axi_reset),
    .io_dpi_req_valid(mem_axi_io_dpi_req_valid),
    .io_dpi_req_opcode(mem_axi_io_dpi_req_opcode),
    .io_dpi_req_len(mem_axi_io_dpi_req_len),
    .io_dpi_req_addr(mem_axi_io_dpi_req_addr),
    .io_dpi_wr_valid(mem_axi_io_dpi_wr_valid),
    .io_dpi_wr_bits(mem_axi_io_dpi_wr_bits),
    .io_dpi_rd_ready(mem_axi_io_dpi_rd_ready),
    .io_dpi_rd_valid(mem_axi_io_dpi_rd_valid),
    .io_dpi_rd_bits(mem_axi_io_dpi_rd_bits),
    .io_axi_aw_ready(mem_axi_io_axi_aw_ready),
    .io_axi_aw_valid(mem_axi_io_axi_aw_valid),
    .io_axi_aw_bits_addr(mem_axi_io_axi_aw_bits_addr),
    .io_axi_aw_bits_len(mem_axi_io_axi_aw_bits_len),
    .io_axi_w_ready(mem_axi_io_axi_w_ready),
    .io_axi_w_valid(mem_axi_io_axi_w_valid),
    .io_axi_w_bits_data(mem_axi_io_axi_w_bits_data),
    .io_axi_w_bits_last(mem_axi_io_axi_w_bits_last),
    .io_axi_b_ready(mem_axi_io_axi_b_ready),
    .io_axi_b_valid(mem_axi_io_axi_b_valid),
    .io_axi_ar_ready(mem_axi_io_axi_ar_ready),
    .io_axi_ar_valid(mem_axi_io_axi_ar_valid),
    .io_axi_ar_bits_addr(mem_axi_io_axi_ar_bits_addr),
    .io_axi_ar_bits_len(mem_axi_io_axi_ar_bits_len),
    .io_axi_r_ready(mem_axi_io_axi_r_ready),
    .io_axi_r_valid(mem_axi_io_axi_r_valid),
    .io_axi_r_bits_data(mem_axi_io_axi_r_bits_data),
    .io_axi_r_bits_last(mem_axi_io_axi_r_bits_last)
  );
  assign io_axi_aw_ready = mem_axi_io_axi_aw_ready; // @[SimShell.scala 43:10]
  assign io_axi_w_ready = mem_axi_io_axi_w_ready; // @[SimShell.scala 43:10]
  assign io_axi_b_valid = mem_axi_io_axi_b_valid; // @[SimShell.scala 43:10]
  assign io_axi_ar_ready = mem_axi_io_axi_ar_ready; // @[SimShell.scala 43:10]
  assign io_axi_r_valid = mem_axi_io_axi_r_valid; // @[SimShell.scala 43:10]
  assign io_axi_r_bits_data = mem_axi_io_axi_r_bits_data; // @[SimShell.scala 43:10]
  assign io_axi_r_bits_last = mem_axi_io_axi_r_bits_last; // @[SimShell.scala 43:10]
  assign mem_dpi_clock = clock; // @[SimShell.scala 41:20]
  assign mem_dpi_reset = reset; // @[SimShell.scala 40:20]
  assign mem_dpi_dpi_req_valid = mem_axi_io_dpi_req_valid; // @[SimShell.scala 42:18]
  assign mem_dpi_dpi_req_opcode = mem_axi_io_dpi_req_opcode; // @[SimShell.scala 42:18]
  assign mem_dpi_dpi_req_len = mem_axi_io_dpi_req_len; // @[SimShell.scala 42:18]
  assign mem_dpi_dpi_req_addr = mem_axi_io_dpi_req_addr; // @[SimShell.scala 42:18]
  assign mem_dpi_dpi_wr_valid = mem_axi_io_dpi_wr_valid; // @[SimShell.scala 42:18]
  assign mem_dpi_dpi_wr_bits = mem_axi_io_dpi_wr_bits; // @[SimShell.scala 42:18]
  assign mem_dpi_dpi_rd_ready = mem_axi_io_dpi_rd_ready; // @[SimShell.scala 42:18]
  assign mem_axi_clock = clock;
  assign mem_axi_reset = reset;
  assign mem_axi_io_dpi_rd_valid = mem_dpi_dpi_rd_valid; // @[SimShell.scala 42:18]
  assign mem_axi_io_dpi_rd_bits = mem_dpi_dpi_rd_bits; // @[SimShell.scala 42:18]
  assign mem_axi_io_axi_aw_valid = io_axi_aw_valid; // @[SimShell.scala 43:10]
  assign mem_axi_io_axi_aw_bits_addr = io_axi_aw_bits_addr; // @[SimShell.scala 43:10]
  assign mem_axi_io_axi_aw_bits_len = io_axi_aw_bits_len; // @[SimShell.scala 43:10]
  assign mem_axi_io_axi_w_valid = io_axi_w_valid; // @[SimShell.scala 43:10]
  assign mem_axi_io_axi_w_bits_data = io_axi_w_bits_data; // @[SimShell.scala 43:10]
  assign mem_axi_io_axi_w_bits_last = io_axi_w_bits_last; // @[SimShell.scala 43:10]
  assign mem_axi_io_axi_b_ready = io_axi_b_ready; // @[SimShell.scala 43:10]
  assign mem_axi_io_axi_ar_valid = io_axi_ar_valid; // @[SimShell.scala 43:10]
  assign mem_axi_io_axi_ar_bits_addr = io_axi_ar_bits_addr; // @[SimShell.scala 43:10]
  assign mem_axi_io_axi_ar_bits_len = io_axi_ar_bits_len; // @[SimShell.scala 43:10]
  assign mem_axi_io_axi_r_ready = io_axi_r_ready; // @[SimShell.scala 43:10]
endmodule
module AXISimShell(
  input         clock,
  input         reset,
  output        mem_aw_ready,
  input         mem_aw_valid,
  input  [31:0] mem_aw_bits_addr,
  input  [31:0] mem_aw_bits_len,
  output        mem_w_ready,
  input         mem_w_valid,
  input  [63:0] mem_w_bits_data,
  input         mem_w_bits_last,
  input         mem_b_ready,
  output        mem_b_valid,
  output        mem_ar_ready,
  input         mem_ar_valid,
  input  [31:0] mem_ar_bits_addr,
  input  [31:0] mem_ar_bits_len,
  input         mem_r_ready,
  output        mem_r_valid,
  output [63:0] mem_r_bits_data,
  output        mem_r_bits_last,
  input         host_aw_ready,
  output        host_aw_valid,
  output [31:0] host_aw_bits_addr,
  input         host_w_ready,
  output        host_w_valid,
  output [63:0] host_w_bits_data,
  output        host_b_ready,
  input         host_b_valid,
  input         host_ar_ready,
  output        host_ar_valid,
  output [31:0] host_ar_bits_addr,
  output        host_r_ready,
  input         host_r_valid,
  input  [63:0] host_r_bits_data,
  input         sim_clock,
  output        sim_wait
);
  wire  mod_sim_clock; // @[SimShell.scala 93:23]
  wire  mod_sim_reset; // @[SimShell.scala 93:23]
  wire  mod_sim_sim_wait; // @[SimShell.scala 93:23]
  wire  mod_host_clock; // @[SimShell.scala 94:24]
  wire  mod_host_reset; // @[SimShell.scala 94:24]
  wire  mod_host_io_axi_aw_ready; // @[SimShell.scala 94:24]
  wire  mod_host_io_axi_aw_valid; // @[SimShell.scala 94:24]
  wire [31:0] mod_host_io_axi_aw_bits_addr; // @[SimShell.scala 94:24]
  wire  mod_host_io_axi_w_ready; // @[SimShell.scala 94:24]
  wire  mod_host_io_axi_w_valid; // @[SimShell.scala 94:24]
  wire [63:0] mod_host_io_axi_w_bits_data; // @[SimShell.scala 94:24]
  wire  mod_host_io_axi_b_ready; // @[SimShell.scala 94:24]
  wire  mod_host_io_axi_b_valid; // @[SimShell.scala 94:24]
  wire  mod_host_io_axi_ar_ready; // @[SimShell.scala 94:24]
  wire  mod_host_io_axi_ar_valid; // @[SimShell.scala 94:24]
  wire [31:0] mod_host_io_axi_ar_bits_addr; // @[SimShell.scala 94:24]
  wire  mod_host_io_axi_r_ready; // @[SimShell.scala 94:24]
  wire  mod_host_io_axi_r_valid; // @[SimShell.scala 94:24]
  wire [63:0] mod_host_io_axi_r_bits_data; // @[SimShell.scala 94:24]
  wire  mod_mem_clock; // @[SimShell.scala 95:23]
  wire  mod_mem_reset; // @[SimShell.scala 95:23]
  wire  mod_mem_io_axi_aw_ready; // @[SimShell.scala 95:23]
  wire  mod_mem_io_axi_aw_valid; // @[SimShell.scala 95:23]
  wire [31:0] mod_mem_io_axi_aw_bits_addr; // @[SimShell.scala 95:23]
  wire [31:0] mod_mem_io_axi_aw_bits_len; // @[SimShell.scala 95:23]
  wire  mod_mem_io_axi_w_ready; // @[SimShell.scala 95:23]
  wire  mod_mem_io_axi_w_valid; // @[SimShell.scala 95:23]
  wire [63:0] mod_mem_io_axi_w_bits_data; // @[SimShell.scala 95:23]
  wire  mod_mem_io_axi_w_bits_last; // @[SimShell.scala 95:23]
  wire  mod_mem_io_axi_b_ready; // @[SimShell.scala 95:23]
  wire  mod_mem_io_axi_b_valid; // @[SimShell.scala 95:23]
  wire  mod_mem_io_axi_ar_ready; // @[SimShell.scala 95:23]
  wire  mod_mem_io_axi_ar_valid; // @[SimShell.scala 95:23]
  wire [31:0] mod_mem_io_axi_ar_bits_addr; // @[SimShell.scala 95:23]
  wire [31:0] mod_mem_io_axi_ar_bits_len; // @[SimShell.scala 95:23]
  wire  mod_mem_io_axi_r_ready; // @[SimShell.scala 95:23]
  wire  mod_mem_io_axi_r_valid; // @[SimShell.scala 95:23]
  wire [63:0] mod_mem_io_axi_r_bits_data; // @[SimShell.scala 95:23]
  wire  mod_mem_io_axi_r_bits_last; // @[SimShell.scala 95:23]
  VTASim mod_sim ( // @[SimShell.scala 93:23]
    .clock(mod_sim_clock),
    .reset(mod_sim_reset),
    .sim_wait(mod_sim_sim_wait)
  );
  VTAHost mod_host ( // @[SimShell.scala 94:24]
    .clock(mod_host_clock),
    .reset(mod_host_reset),
    .io_axi_aw_ready(mod_host_io_axi_aw_ready),
    .io_axi_aw_valid(mod_host_io_axi_aw_valid),
    .io_axi_aw_bits_addr(mod_host_io_axi_aw_bits_addr),
    .io_axi_w_ready(mod_host_io_axi_w_ready),
    .io_axi_w_valid(mod_host_io_axi_w_valid),
    .io_axi_w_bits_data(mod_host_io_axi_w_bits_data),
    .io_axi_b_ready(mod_host_io_axi_b_ready),
    .io_axi_b_valid(mod_host_io_axi_b_valid),
    .io_axi_ar_ready(mod_host_io_axi_ar_ready),
    .io_axi_ar_valid(mod_host_io_axi_ar_valid),
    .io_axi_ar_bits_addr(mod_host_io_axi_ar_bits_addr),
    .io_axi_r_ready(mod_host_io_axi_r_ready),
    .io_axi_r_valid(mod_host_io_axi_r_valid),
    .io_axi_r_bits_data(mod_host_io_axi_r_bits_data)
  );
  VTAMem mod_mem ( // @[SimShell.scala 95:23]
    .clock(mod_mem_clock),
    .reset(mod_mem_reset),
    .io_axi_aw_ready(mod_mem_io_axi_aw_ready),
    .io_axi_aw_valid(mod_mem_io_axi_aw_valid),
    .io_axi_aw_bits_addr(mod_mem_io_axi_aw_bits_addr),
    .io_axi_aw_bits_len(mod_mem_io_axi_aw_bits_len),
    .io_axi_w_ready(mod_mem_io_axi_w_ready),
    .io_axi_w_valid(mod_mem_io_axi_w_valid),
    .io_axi_w_bits_data(mod_mem_io_axi_w_bits_data),
    .io_axi_w_bits_last(mod_mem_io_axi_w_bits_last),
    .io_axi_b_ready(mod_mem_io_axi_b_ready),
    .io_axi_b_valid(mod_mem_io_axi_b_valid),
    .io_axi_ar_ready(mod_mem_io_axi_ar_ready),
    .io_axi_ar_valid(mod_mem_io_axi_ar_valid),
    .io_axi_ar_bits_addr(mod_mem_io_axi_ar_bits_addr),
    .io_axi_ar_bits_len(mod_mem_io_axi_ar_bits_len),
    .io_axi_r_ready(mod_mem_io_axi_r_ready),
    .io_axi_r_valid(mod_mem_io_axi_r_valid),
    .io_axi_r_bits_data(mod_mem_io_axi_r_bits_data),
    .io_axi_r_bits_last(mod_mem_io_axi_r_bits_last)
  );
  assign mem_aw_ready = mod_mem_io_axi_aw_ready; // @[SimShell.scala 96:7]
  assign mem_w_ready = mod_mem_io_axi_w_ready; // @[SimShell.scala 96:7]
  assign mem_b_valid = mod_mem_io_axi_b_valid; // @[SimShell.scala 96:7]
  assign mem_ar_ready = mod_mem_io_axi_ar_ready; // @[SimShell.scala 96:7]
  assign mem_r_valid = mod_mem_io_axi_r_valid; // @[SimShell.scala 96:7]
  assign mem_r_bits_data = mod_mem_io_axi_r_bits_data; // @[SimShell.scala 96:7]
  assign mem_r_bits_last = mod_mem_io_axi_r_bits_last; // @[SimShell.scala 96:7]
  assign host_aw_valid = mod_host_io_axi_aw_valid; // @[SimShell.scala 97:8]
  assign host_aw_bits_addr = mod_host_io_axi_aw_bits_addr; // @[SimShell.scala 97:8]
  assign host_w_valid = mod_host_io_axi_w_valid; // @[SimShell.scala 97:8]
  assign host_w_bits_data = mod_host_io_axi_w_bits_data; // @[SimShell.scala 97:8]
  assign host_b_ready = mod_host_io_axi_b_ready; // @[SimShell.scala 97:8]
  assign host_ar_valid = mod_host_io_axi_ar_valid; // @[SimShell.scala 97:8]
  assign host_ar_bits_addr = mod_host_io_axi_ar_bits_addr; // @[SimShell.scala 97:8]
  assign host_r_ready = mod_host_io_axi_r_ready; // @[SimShell.scala 97:8]
  assign sim_wait = mod_sim_sim_wait; // @[SimShell.scala 100:12]
  assign mod_sim_clock = sim_clock; // @[SimShell.scala 99:17]
  assign mod_sim_reset = reset; // @[SimShell.scala 98:17]
  assign mod_host_clock = clock;
  assign mod_host_reset = reset;
  assign mod_host_io_axi_aw_ready = host_aw_ready; // @[SimShell.scala 97:8]
  assign mod_host_io_axi_w_ready = host_w_ready; // @[SimShell.scala 97:8]
  assign mod_host_io_axi_b_valid = host_b_valid; // @[SimShell.scala 97:8]
  assign mod_host_io_axi_ar_ready = host_ar_ready; // @[SimShell.scala 97:8]
  assign mod_host_io_axi_r_valid = host_r_valid; // @[SimShell.scala 97:8]
  assign mod_host_io_axi_r_bits_data = host_r_bits_data; // @[SimShell.scala 97:8]
  assign mod_mem_clock = clock;
  assign mod_mem_reset = reset;
  assign mod_mem_io_axi_aw_valid = mem_aw_valid; // @[SimShell.scala 96:7]
  assign mod_mem_io_axi_aw_bits_addr = mem_aw_bits_addr; // @[SimShell.scala 96:7]
  assign mod_mem_io_axi_aw_bits_len = mem_aw_bits_len; // @[SimShell.scala 96:7]
  assign mod_mem_io_axi_w_valid = mem_w_valid; // @[SimShell.scala 96:7]
  assign mod_mem_io_axi_w_bits_data = mem_w_bits_data; // @[SimShell.scala 96:7]
  assign mod_mem_io_axi_w_bits_last = mem_w_bits_last; // @[SimShell.scala 96:7]
  assign mod_mem_io_axi_b_ready = mem_b_ready; // @[SimShell.scala 96:7]
  assign mod_mem_io_axi_ar_valid = mem_ar_valid; // @[SimShell.scala 96:7]
  assign mod_mem_io_axi_ar_bits_addr = mem_ar_bits_addr; // @[SimShell.scala 96:7]
  assign mod_mem_io_axi_ar_bits_len = mem_ar_bits_len; // @[SimShell.scala 96:7]
  assign mod_mem_io_axi_r_ready = mem_r_ready; // @[SimShell.scala 96:7]
endmodule
module DCR(
  input         clock,
  input         reset,
  output        io_host_aw_ready,
  input         io_host_aw_valid,
  input  [31:0] io_host_aw_bits_addr,
  output        io_host_w_ready,
  input         io_host_w_valid,
  input  [63:0] io_host_w_bits_data,
  input         io_host_b_ready,
  output        io_host_b_valid,
  output        io_host_ar_ready,
  input         io_host_ar_valid,
  input  [31:0] io_host_ar_bits_addr,
  input         io_host_r_ready,
  output        io_host_r_valid,
  output [63:0] io_host_r_bits_data,
  output        io_dcr_launch,
  input         io_dcr_finish,
  input         io_dcr_ecnt_0_valid,
  input  [31:0] io_dcr_ecnt_0_bits,
  input  [31:0] io_dcr_ecnt_1_bits,
  input  [31:0] io_dcr_ecnt_2_bits,
  input  [31:0] io_dcr_ecnt_3_bits,
  input  [31:0] io_dcr_ecnt_4_bits,
  input  [31:0] io_dcr_ecnt_5_bits,
  input  [31:0] io_dcr_ecnt_6_bits,
  output [31:0] io_dcr_vals_0,
  output [31:0] io_dcr_ptrs_0,
  output [31:0] io_dcr_ptrs_1,
  output [31:0] io_dcr_ptrs_2,
  output [31:0] io_dcr_ptrs_3
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] waddr; // @[DCR.scala 88:22]
  reg [1:0] wstate; // @[DCR.scala 91:23]
  reg  rstate; // @[DCR.scala 95:23]
  reg [31:0] rdata; // @[DCR.scala 96:22]
  reg [31:0] reg_0; // @[DCR.scala 102:37]
  reg [31:0] reg_1; // @[DCR.scala 102:37]
  reg [31:0] reg_2; // @[DCR.scala 102:37]
  reg [31:0] reg_3; // @[DCR.scala 102:37]
  reg [31:0] reg_4; // @[DCR.scala 102:37]
  reg [31:0] reg_5; // @[DCR.scala 102:37]
  reg [31:0] reg_6; // @[DCR.scala 102:37]
  reg [31:0] reg_7; // @[DCR.scala 102:37]
  reg [31:0] reg_18; // @[DCR.scala 102:37]
  reg [31:0] reg_19; // @[DCR.scala 102:37]
  reg [31:0] reg_20; // @[DCR.scala 102:37]
  reg [31:0] reg_21; // @[DCR.scala 102:37]
  reg [31:0] reg_22; // @[DCR.scala 102:37]
  wire  _T = 2'h0 == wstate; // @[Conditional.scala 37:30]
  wire  _T_1 = 2'h1 == wstate; // @[Conditional.scala 37:30]
  wire  _T_2 = 2'h2 == wstate; // @[Conditional.scala 37:30]
  wire  _T_3 = io_host_aw_ready & io_host_aw_valid; // @[Decoupled.scala 40:37]
  wire  _T_7 = ~rstate; // @[Conditional.scala 37:30]
  wire  _GEN_7 = io_host_ar_valid | rstate; // @[DCR.scala 138:30]
  wire  _T_11 = io_host_w_ready & io_host_w_valid; // @[Decoupled.scala 40:37]
  wire  _T_12 = 32'h0 == waddr; // @[DCR.scala 156:44]
  wire  _T_13 = _T_11 & _T_12; // @[DCR.scala 156:31]
  wire [63:0] _GEN_11 = _T_13 ? io_host_w_bits_data : {{32'd0}, reg_0}; // @[DCR.scala 156:55]
  wire [63:0] _GEN_12 = io_dcr_finish ? 64'h2 : _GEN_11; // @[DCR.scala 154:23]
  wire  _T_15 = 32'h4 == waddr; // @[DCR.scala 163:51]
  wire  _T_16 = _T_11 & _T_15; // @[DCR.scala 163:33]
  wire [63:0] _GEN_13 = _T_16 ? io_host_w_bits_data : {{32'd0}, reg_1}; // @[DCR.scala 163:62]
  wire [63:0] _GEN_14 = io_dcr_ecnt_0_valid ? {{32'd0}, io_dcr_ecnt_0_bits} : _GEN_13; // @[DCR.scala 161:32]
  wire [63:0] _GEN_16 = {{32'd0}, io_dcr_ecnt_1_bits}; // @[DCR.scala 161:32]
  wire [63:0] _GEN_18 = {{32'd0}, io_dcr_ecnt_2_bits}; // @[DCR.scala 161:32]
  wire [63:0] _GEN_20 = {{32'd0}, io_dcr_ecnt_3_bits}; // @[DCR.scala 161:32]
  wire [63:0] _GEN_22 = {{32'd0}, io_dcr_ecnt_4_bits}; // @[DCR.scala 161:32]
  wire [63:0] _GEN_24 = {{32'd0}, io_dcr_ecnt_5_bits}; // @[DCR.scala 161:32]
  wire [63:0] _GEN_26 = {{32'd0}, io_dcr_ecnt_6_bits}; // @[DCR.scala 161:32]
  wire  _T_66 = 32'h48 == waddr; // @[DCR.scala 169:45]
  wire  _T_67 = _T_11 & _T_66; // @[DCR.scala 169:27]
  wire [63:0] _GEN_47 = _T_67 ? io_host_w_bits_data : {{32'd0}, reg_18}; // @[DCR.scala 169:56]
  wire  _T_69 = 32'h4c == waddr; // @[DCR.scala 169:45]
  wire  _T_70 = _T_11 & _T_69; // @[DCR.scala 169:27]
  wire [63:0] _GEN_48 = _T_70 ? io_host_w_bits_data : {{32'd0}, reg_19}; // @[DCR.scala 169:56]
  wire  _T_72 = 32'h50 == waddr; // @[DCR.scala 169:45]
  wire  _T_73 = _T_11 & _T_72; // @[DCR.scala 169:27]
  wire [63:0] _GEN_49 = _T_73 ? io_host_w_bits_data : {{32'd0}, reg_20}; // @[DCR.scala 169:56]
  wire  _T_75 = 32'h54 == waddr; // @[DCR.scala 169:45]
  wire  _T_76 = _T_11 & _T_75; // @[DCR.scala 169:27]
  wire [63:0] _GEN_50 = _T_76 ? io_host_w_bits_data : {{32'd0}, reg_21}; // @[DCR.scala 169:56]
  wire  _T_78 = 32'h58 == waddr; // @[DCR.scala 169:45]
  wire  _T_79 = _T_11 & _T_78; // @[DCR.scala 169:27]
  wire [63:0] _GEN_51 = _T_79 ? io_host_w_bits_data : {{32'd0}, reg_22}; // @[DCR.scala 169:56]
  wire  _T_80 = io_host_ar_ready & io_host_ar_valid; // @[Decoupled.scala 40:37]
  wire  _T_81 = 32'h0 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_83 = 32'h4 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_85 = 32'h8 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_87 = 32'hc == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_89 = 32'h10 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_91 = 32'h14 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_93 = 32'h18 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_95 = 32'h1c == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_97 = 32'h20 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_99 = 32'h24 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_101 = 32'h28 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_103 = 32'h2c == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_105 = 32'h30 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_107 = 32'h34 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_109 = 32'h38 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_111 = 32'h3c == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_113 = 32'h40 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_115 = 32'h44 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_117 = 32'h48 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_119 = 32'h4c == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_121 = 32'h50 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_123 = 32'h54 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  wire  _T_125 = 32'h58 == io_host_ar_bits_addr; // @[Mux.scala 80:60]
  assign io_host_aw_ready = wstate == 2'h0; // @[DCR.scala 131:20]
  assign io_host_w_ready = wstate == 2'h1; // @[DCR.scala 132:19]
  assign io_host_b_valid = wstate == 2'h2; // @[DCR.scala 133:19]
  assign io_host_ar_ready = ~rstate; // @[DCR.scala 149:20]
  assign io_host_r_valid = rstate; // @[DCR.scala 150:19]
  assign io_host_r_bits_data = {{32'd0}, rdata}; // @[DCR.scala 151:23]
  assign io_dcr_launch = reg_0[0]; // @[DCR.scala 178:17]
  assign io_dcr_vals_0 = reg_18; // @[DCR.scala 181:20]
  assign io_dcr_ptrs_0 = reg_19; // @[DCR.scala 186:22]
  assign io_dcr_ptrs_1 = reg_20; // @[DCR.scala 186:22]
  assign io_dcr_ptrs_2 = reg_21; // @[DCR.scala 186:22]
  assign io_dcr_ptrs_3 = reg_22; // @[DCR.scala 186:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  waddr = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  wstate = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  rstate = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  rdata = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  reg_0 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  reg_1 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  reg_2 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  reg_3 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  reg_4 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  reg_5 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  reg_6 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  reg_7 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  reg_18 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  reg_19 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  reg_20 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  reg_21 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  reg_22 = _RAND_16[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      waddr <= 32'hffff;
    end else if (_T_3) begin
      waddr <= io_host_aw_bits_addr;
    end
    if (reset) begin
      wstate <= 2'h0;
    end else if (_T) begin
      if (io_host_aw_valid) begin
        wstate <= 2'h1;
      end
    end else if (_T_1) begin
      if (io_host_w_valid) begin
        wstate <= 2'h2;
      end
    end else if (_T_2) begin
      if (io_host_b_ready) begin
        wstate <= 2'h0;
      end
    end
    if (reset) begin
      rstate <= 1'h0;
    end else if (_T_7) begin
      rstate <= _GEN_7;
    end else if (rstate) begin
      if (io_host_r_ready) begin
        rstate <= 1'h0;
      end
    end
    if (reset) begin
      rdata <= 32'h0;
    end else if (_T_80) begin
      if (_T_125) begin
        rdata <= reg_22;
      end else if (_T_123) begin
        rdata <= reg_21;
      end else if (_T_121) begin
        rdata <= reg_20;
      end else if (_T_119) begin
        rdata <= reg_19;
      end else if (_T_117) begin
        rdata <= reg_18;
      end else if (_T_115) begin
        rdata <= 32'h0;
      end else if (_T_113) begin
        rdata <= 32'h0;
      end else if (_T_111) begin
        rdata <= 32'h0;
      end else if (_T_109) begin
        rdata <= 32'h0;
      end else if (_T_107) begin
        rdata <= 32'h0;
      end else if (_T_105) begin
        rdata <= 32'h0;
      end else if (_T_103) begin
        rdata <= 32'h0;
      end else if (_T_101) begin
        rdata <= 32'h0;
      end else if (_T_99) begin
        rdata <= 32'h0;
      end else if (_T_97) begin
        rdata <= 32'h0;
      end else if (_T_95) begin
        rdata <= reg_7;
      end else if (_T_93) begin
        rdata <= reg_6;
      end else if (_T_91) begin
        rdata <= reg_5;
      end else if (_T_89) begin
        rdata <= reg_4;
      end else if (_T_87) begin
        rdata <= reg_3;
      end else if (_T_85) begin
        rdata <= reg_2;
      end else if (_T_83) begin
        rdata <= reg_1;
      end else if (_T_81) begin
        rdata <= reg_0;
      end else begin
        rdata <= 32'h0;
      end
    end
    if (reset) begin
      reg_0 <= 32'h0;
    end else begin
      reg_0 <= _GEN_12[31:0];
    end
    if (reset) begin
      reg_1 <= 32'h0;
    end else begin
      reg_1 <= _GEN_14[31:0];
    end
    if (reset) begin
      reg_2 <= 32'h0;
    end else begin
      reg_2 <= _GEN_16[31:0];
    end
    if (reset) begin
      reg_3 <= 32'h0;
    end else begin
      reg_3 <= _GEN_18[31:0];
    end
    if (reset) begin
      reg_4 <= 32'h0;
    end else begin
      reg_4 <= _GEN_20[31:0];
    end
    if (reset) begin
      reg_5 <= 32'h0;
    end else begin
      reg_5 <= _GEN_22[31:0];
    end
    if (reset) begin
      reg_6 <= 32'h0;
    end else begin
      reg_6 <= _GEN_24[31:0];
    end
    if (reset) begin
      reg_7 <= 32'h0;
    end else begin
      reg_7 <= _GEN_26[31:0];
    end
    if (reset) begin
      reg_18 <= 32'h0;
    end else begin
      reg_18 <= _GEN_47[31:0];
    end
    if (reset) begin
      reg_19 <= 32'h0;
    end else begin
      reg_19 <= _GEN_48[31:0];
    end
    if (reset) begin
      reg_20 <= 32'h0;
    end else begin
      reg_20 <= _GEN_49[31:0];
    end
    if (reset) begin
      reg_21 <= 32'h0;
    end else begin
      reg_21 <= _GEN_50[31:0];
    end
    if (reset) begin
      reg_22 <= 32'h0;
    end else begin
      reg_22 <= _GEN_51[31:0];
    end
  end
endmodule
module Arbiter(
  input         io_in_0_valid,
  input  [31:0] io_in_0_bits_addr,
  input         io_in_1_valid,
  input  [31:0] io_in_1_bits_addr,
  input         io_in_2_valid,
  input  [31:0] io_in_2_bits_addr,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits_addr,
  output [1:0]  io_chosen
);
  wire [1:0] _GEN_0 = io_in_1_valid ? 2'h1 : 2'h2; // @[Arbiter.scala 126:27]
  wire [31:0] _GEN_2 = io_in_1_valid ? io_in_1_bits_addr : io_in_2_bits_addr; // @[Arbiter.scala 126:27]
  wire  _T = io_in_0_valid | io_in_1_valid; // @[Arbiter.scala 31:68]
  wire  grant_2 = ~_T; // @[Arbiter.scala 31:78]
  wire  _T_4 = ~grant_2; // @[Arbiter.scala 135:19]
  assign io_out_valid = _T_4 | io_in_2_valid; // @[Arbiter.scala 135:16]
  assign io_out_bits_addr = io_in_0_valid ? io_in_0_bits_addr : _GEN_2; // @[Arbiter.scala 124:15 Arbiter.scala 128:19 Arbiter.scala 128:19]
  assign io_chosen = io_in_0_valid ? 2'h0 : _GEN_0; // @[Arbiter.scala 123:13 Arbiter.scala 127:17 Arbiter.scala 127:17]
endmodule
module DME(
  input         clock,
  input         reset,
  input         io_mem_aw_ready,
  output        io_mem_aw_valid,
  input         io_mem_w_ready,
  output        io_mem_w_valid,
  output        io_mem_w_bits_last,
  output        io_mem_b_ready,
  input         io_mem_b_valid,
  input         io_mem_ar_ready,
  output        io_mem_ar_valid,
  output [31:0] io_mem_ar_bits_addr,
  output        io_mem_r_ready,
  input         io_mem_r_valid,
  input  [63:0] io_mem_r_bits_data,
  input         io_mem_r_bits_last,
  input         io_dme_rd_0_cmd_valid,
  input  [31:0] io_dme_rd_0_cmd_bits_addr,
  input         io_dme_rd_0_data_ready,
  output        io_dme_rd_0_data_valid,
  output [63:0] io_dme_rd_0_data_bits,
  input         io_dme_rd_1_cmd_valid,
  input  [31:0] io_dme_rd_1_cmd_bits_addr,
  input         io_dme_rd_1_data_ready,
  output        io_dme_rd_1_data_valid,
  output [63:0] io_dme_rd_1_data_bits,
  input         io_dme_rd_2_cmd_valid,
  input  [31:0] io_dme_rd_2_cmd_bits_addr,
  input         io_dme_rd_2_data_ready,
  output        io_dme_rd_2_data_valid,
  output [63:0] io_dme_rd_2_data_bits
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  wire  rd_arb_io_in_0_valid; // @[DME.scala 130:22]
  wire [31:0] rd_arb_io_in_0_bits_addr; // @[DME.scala 130:22]
  wire  rd_arb_io_in_1_valid; // @[DME.scala 130:22]
  wire [31:0] rd_arb_io_in_1_bits_addr; // @[DME.scala 130:22]
  wire  rd_arb_io_in_2_valid; // @[DME.scala 130:22]
  wire [31:0] rd_arb_io_in_2_bits_addr; // @[DME.scala 130:22]
  wire  rd_arb_io_out_ready; // @[DME.scala 130:22]
  wire  rd_arb_io_out_valid; // @[DME.scala 130:22]
  wire [31:0] rd_arb_io_out_bits_addr; // @[DME.scala 130:22]
  wire [1:0] rd_arb_io_chosen; // @[DME.scala 130:22]
  wire  _T = rd_arb_io_out_ready & rd_arb_io_out_valid; // @[Decoupled.scala 40:37]
  reg [1:0] rd_arb_chosen; // @[Reg.scala 15:16]
  reg [1:0] rstate; // @[DME.scala 138:23]
  wire  _T_1 = 2'h0 == rstate; // @[Conditional.scala 37:30]
  wire  _T_2 = 2'h1 == rstate; // @[Conditional.scala 37:30]
  wire  _T_3 = 2'h2 == rstate; // @[Conditional.scala 37:30]
  wire  _T_4 = io_mem_r_ready & io_mem_r_valid; // @[Decoupled.scala 40:37]
  wire  _T_5 = _T_4 & io_mem_r_bits_last; // @[DME.scala 152:28]
  reg [1:0] wstate; // @[DME.scala 168:23]
  reg [31:0] wr_cnt; // @[DME.scala 171:23]
  wire  _T_7 = wstate == 2'h0; // @[DME.scala 174:15]
  wire  _T_8 = io_mem_w_ready & io_mem_w_valid; // @[Decoupled.scala 40:37]
  wire [31:0] _T_10 = wr_cnt + 32'h1; // @[DME.scala 177:22]
  wire  _T_11 = 2'h0 == wstate; // @[Conditional.scala 37:30]
  wire  _T_12 = 2'h1 == wstate; // @[Conditional.scala 37:30]
  wire  _T_13 = 2'h2 == wstate; // @[Conditional.scala 37:30]
  wire  _T_17 = 2'h3 == wstate; // @[Conditional.scala 37:30]
  reg [31:0] rd_addr; // @[Reg.scala 27:20]
  wire  _T_24 = rd_arb_chosen == 2'h0; // @[DME.scala 215:46]
  wire  _T_26 = rd_arb_chosen == 2'h1; // @[DME.scala 215:46]
  wire  _T_28 = rd_arb_chosen == 2'h2; // @[DME.scala 215:46]
  wire  _T_43 = rstate == 2'h2; // @[DME.scala 240:28]
  wire  _GEN_33 = 2'h1 == rd_arb_chosen ? io_dme_rd_1_data_ready : io_dme_rd_0_data_ready; // @[DME.scala 240:42]
  wire  _GEN_40 = 2'h2 == rd_arb_chosen ? io_dme_rd_2_data_ready : _GEN_33; // @[DME.scala 240:42]
  Arbiter rd_arb ( // @[DME.scala 130:22]
    .io_in_0_valid(rd_arb_io_in_0_valid),
    .io_in_0_bits_addr(rd_arb_io_in_0_bits_addr),
    .io_in_1_valid(rd_arb_io_in_1_valid),
    .io_in_1_bits_addr(rd_arb_io_in_1_bits_addr),
    .io_in_2_valid(rd_arb_io_in_2_valid),
    .io_in_2_bits_addr(rd_arb_io_in_2_bits_addr),
    .io_out_ready(rd_arb_io_out_ready),
    .io_out_valid(rd_arb_io_out_valid),
    .io_out_bits_addr(rd_arb_io_out_bits_addr),
    .io_chosen(rd_arb_io_chosen)
  );
  assign io_mem_aw_valid = wstate == 2'h1; // @[DME.scala 226:19]
  assign io_mem_w_valid = 1'h0; // @[DME.scala 230:18]
  assign io_mem_w_bits_last = wr_cnt == 32'h0; // @[DME.scala 232:22]
  assign io_mem_b_ready = wstate == 2'h3; // @[DME.scala 234:18]
  assign io_mem_ar_valid = rstate == 2'h1; // @[DME.scala 236:19]
  assign io_mem_ar_bits_addr = rd_addr; // @[DME.scala 237:23]
  assign io_mem_r_ready = _T_43 & _GEN_40; // @[DME.scala 240:18]
  assign io_dme_rd_0_data_valid = _T_24 & io_mem_r_valid; // @[DME.scala 215:29]
  assign io_dme_rd_0_data_bits = io_mem_r_bits_data; // @[DME.scala 216:28]
  assign io_dme_rd_1_data_valid = _T_26 & io_mem_r_valid; // @[DME.scala 215:29]
  assign io_dme_rd_1_data_bits = io_mem_r_bits_data; // @[DME.scala 216:28]
  assign io_dme_rd_2_data_valid = _T_28 & io_mem_r_valid; // @[DME.scala 215:29]
  assign io_dme_rd_2_data_bits = io_mem_r_bits_data; // @[DME.scala 216:28]
  assign rd_arb_io_in_0_valid = io_dme_rd_0_cmd_valid; // @[DME.scala 134:21]
  assign rd_arb_io_in_0_bits_addr = io_dme_rd_0_cmd_bits_addr; // @[DME.scala 134:21]
  assign rd_arb_io_in_1_valid = io_dme_rd_1_cmd_valid; // @[DME.scala 134:21]
  assign rd_arb_io_in_1_bits_addr = io_dme_rd_1_cmd_bits_addr; // @[DME.scala 134:21]
  assign rd_arb_io_in_2_valid = io_dme_rd_2_cmd_valid; // @[DME.scala 134:21]
  assign rd_arb_io_in_2_bits_addr = io_dme_rd_2_cmd_bits_addr; // @[DME.scala 134:21]
  assign rd_arb_io_out_ready = rstate == 2'h0; // @[DME.scala 210:23]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  rd_arb_chosen = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  rstate = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  wstate = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  wr_cnt = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  rd_addr = _RAND_4[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (_T) begin
      rd_arb_chosen <= rd_arb_io_chosen;
    end
    if (reset) begin
      rstate <= 2'h0;
    end else if (_T_1) begin
      if (rd_arb_io_out_valid) begin
        rstate <= 2'h1;
      end
    end else if (_T_2) begin
      if (io_mem_ar_ready) begin
        rstate <= 2'h2;
      end
    end else if (_T_3) begin
      if (_T_5) begin
        rstate <= 2'h0;
      end
    end
    if (reset) begin
      wstate <= 2'h0;
    end else if (!(_T_11)) begin
      if (_T_12) begin
        if (io_mem_aw_ready) begin
          wstate <= 2'h2;
        end
      end else if (!(_T_13)) begin
        if (_T_17) begin
          if (io_mem_b_valid) begin
            wstate <= 2'h0;
          end
        end
      end
    end
    if (reset) begin
      wr_cnt <= 32'h0;
    end else if (_T_7) begin
      wr_cnt <= 32'h0;
    end else if (_T_8) begin
      wr_cnt <= _T_10;
    end
    if (reset) begin
      rd_addr <= 32'h0;
    end else if (_T) begin
      rd_addr <= rd_arb_io_out_bits_addr;
    end
  end
endmodule
module memoryWrapper(
  input         clock,
  input         reset,
  output        io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_bits_addr,
  input  [7:0]  io_in_bits_inst,
  input  [63:0] io_in_bits_data,
  input  [2:0]  io_in_bits_src,
  input         io_mem_aw_ready,
  output        io_mem_aw_valid,
  output [31:0] io_mem_aw_bits_addr,
  input         io_mem_w_ready,
  output        io_mem_w_valid,
  output [63:0] io_mem_w_bits_data,
  output        io_mem_b_ready,
  input         io_mem_ar_ready,
  output        io_mem_ar_valid,
  output [31:0] io_mem_ar_bits_addr,
  output [15:0] io_mem_ar_bits_len,
  output        io_mem_r_ready,
  input         io_mem_r_valid,
  input  [63:0] io_mem_r_bits_data,
  input         io_mem_r_bits_last,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits_addr,
  output [63:0] io_out_bits_data,
  output [2:0]  io_out_bits_dst
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [63:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [63:0] _RAND_9;
  reg [63:0] _RAND_10;
  reg [63:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] addrReg; // @[mainMemWrapper.scala 36:26]
  reg [2:0] numberOfLines; // @[mainMemWrapper.scala 37:32]
  reg [2:0] srcReg; // @[mainMemWrapper.scala 38:25]
  reg [31:0] returnAddr; // @[mainMemWrapper.scala 39:29]
  reg [63:0] dataRegRead_0; // @[mainMemWrapper.scala 40:30]
  reg [63:0] dataRegRead_1; // @[mainMemWrapper.scala 40:30]
  reg [63:0] dataRegRead_2; // @[mainMemWrapper.scala 40:30]
  reg [63:0] dataRegRead_3; // @[mainMemWrapper.scala 40:30]
  reg [63:0] dataRegRead_4; // @[mainMemWrapper.scala 40:30]
  reg [63:0] dataRegRead_5; // @[mainMemWrapper.scala 40:30]
  reg [63:0] dataRegRead_6; // @[mainMemWrapper.scala 40:30]
  reg [63:0] dataRegWrite_0; // @[mainMemWrapper.scala 41:31]
  reg [2:0] stReg; // @[mainMemWrapper.scala 44:24]
  wire  _T_2 = io_in_ready & io_in_valid; // @[Decoupled.scala 40:37]
  wire  _T_3 = stReg == 3'h0; // @[mainMemWrapper.scala 47:35]
  wire  _T_4 = _T_2 & _T_3; // @[mainMemWrapper.scala 47:27]
  wire  _T_6 = io_in_bits_data[31:0] != 32'h0; // @[mainMemWrapper.scala 47:80]
  wire  start = _T_4 & _T_6; // @[mainMemWrapper.scala 47:46]
  wire [31:0] _T_9 = {io_in_bits_data[31:3], 3'h0}; // @[mainMemWrapper.scala 50:58]
  wire  _T_11 = io_in_bits_data[2:0] == 3'h0; // @[mainMemWrapper.scala 51:51]
  wire  _T_15 = io_in_bits_inst == 8'h1; // @[mainMemWrapper.scala 58:54]
  wire  writeInst = start & _T_15; // @[mainMemWrapper.scala 58:36]
  wire  _T_17 = io_mem_r_ready & io_mem_r_valid; // @[Decoupled.scala 40:37]
  reg [2:0] readCount; // @[Counter.scala 29:33]
  wire  _T_18 = readCount == 3'h6; // @[Counter.scala 38:24]
  wire [2:0] _T_20 = readCount + 3'h1; // @[Counter.scala 39:22]
  wire  writeWrapped = io_mem_w_ready & io_mem_w_valid; // @[Decoupled.scala 40:37]
  wire  _T_22 = stReg == 3'h5; // @[mainMemWrapper.scala 65:55]
  reg [19:0] dramLatencyCnt; // @[Counter.scala 29:33]
  wire  _T_24 = dramLatencyCnt == 20'hf423f; // @[Counter.scala 38:24]
  wire [19:0] _T_26 = dramLatencyCnt + 20'h1; // @[Counter.scala 39:22]
  wire  _T_27 = io_out_ready & io_out_valid; // @[Decoupled.scala 40:37]
  reg [19:0] nextPacket; // @[Counter.scala 29:33]
  wire  _T_29 = nextPacket == 20'hf423f; // @[Counter.scala 38:24]
  wire [19:0] _T_31 = nextPacket + 20'h1; // @[Counter.scala 39:22]
  wire [2:0] _T_33 = numberOfLines - 3'h1; // @[mainMemWrapper.scala 67:62]
  wire [19:0] _GEN_75 = {{17'd0}, _T_33}; // @[mainMemWrapper.scala 67:44]
  wire  packetsDone = nextPacket == _GEN_75; // @[mainMemWrapper.scala 67:44]
  wire [31:0] _T_38 = returnAddr + 32'h8; // @[mainMemWrapper.scala 70:34]
  wire  _T_43 = stReg == 3'h1; // @[mainMemWrapper.scala 82:38]
  wire  _T_45 = stReg == 3'h2; // @[mainMemWrapper.scala 85:37]
  wire [3:0] _T_47 = 3'h1 * numberOfLines; // @[mainMemWrapper.scala 89:35]
  wire [3:0] _T_49 = _T_47 - 4'h1; // @[mainMemWrapper.scala 89:51]
  wire [20:0] _T_51 = nextPacket * 20'h1; // @[mainMemWrapper.scala 101:78]
  wire [21:0] _T_52 = {{1'd0}, _T_51}; // @[mainMemWrapper.scala 101:88]
  wire [63:0] _GEN_34 = 3'h1 == _T_52[2:0] ? dataRegRead_1 : dataRegRead_0; // @[mainMemWrapper.scala 101:22]
  wire [63:0] _GEN_35 = 3'h2 == _T_52[2:0] ? dataRegRead_2 : _GEN_34; // @[mainMemWrapper.scala 101:22]
  wire [63:0] _GEN_36 = 3'h3 == _T_52[2:0] ? dataRegRead_3 : _GEN_35; // @[mainMemWrapper.scala 101:22]
  wire [63:0] _GEN_37 = 3'h4 == _T_52[2:0] ? dataRegRead_4 : _GEN_36; // @[mainMemWrapper.scala 101:22]
  wire [63:0] _GEN_38 = 3'h5 == _T_52[2:0] ? dataRegRead_5 : _GEN_37; // @[mainMemWrapper.scala 101:22]
  wire  _T_55 = 3'h0 == stReg; // @[Conditional.scala 37:30]
  wire  _T_56 = 3'h3 == stReg; // @[Conditional.scala 37:30]
  wire  _T_57 = io_mem_ar_ready & io_mem_ar_valid; // @[Decoupled.scala 40:37]
  wire  _T_58 = 3'h4 == stReg; // @[Conditional.scala 37:30]
  wire  _T_60 = _T_17 & io_mem_r_bits_last; // @[mainMemWrapper.scala 129:34]
  wire  _T_61 = 3'h1 == stReg; // @[Conditional.scala 37:30]
  wire  _T_62 = io_mem_aw_ready & io_mem_aw_valid; // @[Decoupled.scala 40:37]
  wire  _T_63 = 3'h2 == stReg; // @[Conditional.scala 37:30]
  wire  _T_64 = 3'h5 == stReg; // @[Conditional.scala 37:30]
  wire  _T_65 = dramLatencyCnt > 20'hc8; // @[mainMemWrapper.scala 146:34]
  wire  _T_67 = packetsDone & _T_27; // @[mainMemWrapper.scala 148:34]
  wire  _GEN_49 = _T_64 & _T_65; // @[Conditional.scala 39:67]
  wire  _GEN_53 = _T_63 ? 1'h0 : _GEN_49; // @[Conditional.scala 39:67]
  wire  _GEN_56 = _T_61 ? 1'h0 : _T_63; // @[Conditional.scala 39:67]
  wire  _GEN_57 = _T_61 ? 1'h0 : _GEN_53; // @[Conditional.scala 39:67]
  wire  _GEN_60 = _T_58 ? 1'h0 : _T_61; // @[Conditional.scala 39:67]
  wire  _GEN_61 = _T_58 ? 1'h0 : _GEN_56; // @[Conditional.scala 39:67]
  wire  _GEN_62 = _T_58 ? 1'h0 : _GEN_57; // @[Conditional.scala 39:67]
  wire  _GEN_65 = _T_56 ? 1'h0 : _T_58; // @[Conditional.scala 39:67]
  wire  _GEN_66 = _T_56 ? 1'h0 : _GEN_60; // @[Conditional.scala 39:67]
  wire  _GEN_67 = _T_56 ? 1'h0 : _GEN_61; // @[Conditional.scala 39:67]
  wire  _GEN_68 = _T_56 ? 1'h0 : _GEN_62; // @[Conditional.scala 39:67]
  assign io_in_ready = stReg == 3'h0; // @[mainMemWrapper.scala 56:17]
  assign io_mem_aw_valid = _T_55 ? 1'h0 : _GEN_66; // @[mainMemWrapper.scala 93:21 mainMemWrapper.scala 134:29]
  assign io_mem_aw_bits_addr = _T_43 ? addrReg : 32'h0; // @[mainMemWrapper.scala 82:25]
  assign io_mem_w_valid = _T_55 ? 1'h0 : _GEN_67; // @[mainMemWrapper.scala 95:20 mainMemWrapper.scala 140:28]
  assign io_mem_w_bits_data = _T_45 ? dataRegWrite_0 : 64'h0; // @[mainMemWrapper.scala 85:24]
  assign io_mem_b_ready = stReg == 3'h2; // @[mainMemWrapper.scala 90:20]
  assign io_mem_ar_valid = _T_55 ? 1'h0 : _T_56; // @[mainMemWrapper.scala 92:21 mainMemWrapper.scala 122:29]
  assign io_mem_ar_bits_addr = addrReg; // @[mainMemWrapper.scala 88:25]
  assign io_mem_ar_bits_len = {{12'd0}, _T_49}; // @[mainMemWrapper.scala 89:24]
  assign io_mem_r_ready = _T_55 ? 1'h0 : _GEN_65; // @[mainMemWrapper.scala 94:20 mainMemWrapper.scala 128:28]
  assign io_out_valid = _T_55 ? 1'h0 : _GEN_68; // @[mainMemWrapper.scala 109:18 mainMemWrapper.scala 147:30]
  assign io_out_bits_addr = returnAddr; // @[mainMemWrapper.scala 102:22]
  assign io_out_bits_data = 3'h6 == _T_52[2:0] ? dataRegRead_6 : _GEN_38; // @[mainMemWrapper.scala 101:22]
  assign io_out_bits_dst = srcReg; // @[mainMemWrapper.scala 105:21]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  addrReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  numberOfLines = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  srcReg = _RAND_2[2:0];
  _RAND_3 = {1{`RANDOM}};
  returnAddr = _RAND_3[31:0];
  _RAND_4 = {2{`RANDOM}};
  dataRegRead_0 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  dataRegRead_1 = _RAND_5[63:0];
  _RAND_6 = {2{`RANDOM}};
  dataRegRead_2 = _RAND_6[63:0];
  _RAND_7 = {2{`RANDOM}};
  dataRegRead_3 = _RAND_7[63:0];
  _RAND_8 = {2{`RANDOM}};
  dataRegRead_4 = _RAND_8[63:0];
  _RAND_9 = {2{`RANDOM}};
  dataRegRead_5 = _RAND_9[63:0];
  _RAND_10 = {2{`RANDOM}};
  dataRegRead_6 = _RAND_10[63:0];
  _RAND_11 = {2{`RANDOM}};
  dataRegWrite_0 = _RAND_11[63:0];
  _RAND_12 = {1{`RANDOM}};
  stReg = _RAND_12[2:0];
  _RAND_13 = {1{`RANDOM}};
  readCount = _RAND_13[2:0];
  _RAND_14 = {1{`RANDOM}};
  dramLatencyCnt = _RAND_14[19:0];
  _RAND_15 = {1{`RANDOM}};
  nextPacket = _RAND_15[19:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      addrReg <= 32'h0;
    end else if (start) begin
      addrReg <= _T_9;
    end
    if (reset) begin
      numberOfLines <= 3'h0;
    end else if (start) begin
      if (_T_11) begin
        numberOfLines <= 3'h1;
      end else begin
        numberOfLines <= io_in_bits_data[2:0];
      end
    end
    if (reset) begin
      srcReg <= 3'h0;
    end else if (start) begin
      srcReg <= io_in_bits_src;
    end
    if (reset) begin
      returnAddr <= 32'h0;
    end else if (_T_27) begin
      returnAddr <= _T_38;
    end else if (start) begin
      returnAddr <= io_in_bits_addr;
    end
    if (reset) begin
      dataRegRead_0 <= 64'h0;
    end else if (_T_17) begin
      if (3'h0 == readCount) begin
        dataRegRead_0 <= io_mem_r_bits_data;
      end
    end
    if (reset) begin
      dataRegRead_1 <= 64'h0;
    end else if (_T_17) begin
      if (3'h1 == readCount) begin
        dataRegRead_1 <= io_mem_r_bits_data;
      end
    end
    if (reset) begin
      dataRegRead_2 <= 64'h0;
    end else if (_T_17) begin
      if (3'h2 == readCount) begin
        dataRegRead_2 <= io_mem_r_bits_data;
      end
    end
    if (reset) begin
      dataRegRead_3 <= 64'h0;
    end else if (_T_17) begin
      if (3'h3 == readCount) begin
        dataRegRead_3 <= io_mem_r_bits_data;
      end
    end
    if (reset) begin
      dataRegRead_4 <= 64'h0;
    end else if (_T_17) begin
      if (3'h4 == readCount) begin
        dataRegRead_4 <= io_mem_r_bits_data;
      end
    end
    if (reset) begin
      dataRegRead_5 <= 64'h0;
    end else if (_T_17) begin
      if (3'h5 == readCount) begin
        dataRegRead_5 <= io_mem_r_bits_data;
      end
    end
    if (reset) begin
      dataRegRead_6 <= 64'h0;
    end else if (_T_17) begin
      if (3'h6 == readCount) begin
        dataRegRead_6 <= io_mem_r_bits_data;
      end
    end
    if (reset) begin
      dataRegWrite_0 <= 64'h0;
    end else if (writeInst) begin
      dataRegWrite_0 <= io_in_bits_data;
    end
    if (reset) begin
      stReg <= 3'h0;
    end else if (_T_55) begin
      if (start) begin
        if (writeInst) begin
          stReg <= 3'h1;
        end else begin
          stReg <= 3'h3;
        end
      end
    end else if (_T_56) begin
      if (_T_57) begin
        stReg <= 3'h4;
      end
    end else if (_T_58) begin
      if (_T_60) begin
        stReg <= 3'h5;
      end
    end else if (_T_61) begin
      if (_T_62) begin
        stReg <= 3'h2;
      end
    end else if (_T_63) begin
      if (writeWrapped) begin
        stReg <= 3'h0;
      end
    end else if (_T_64) begin
      if (_T_65) begin
        if (_T_67) begin
          stReg <= 3'h0;
        end
      end
    end
    if (reset) begin
      readCount <= 3'h0;
    end else if (start) begin
      readCount <= 3'h0;
    end else if (_T_17) begin
      if (_T_18) begin
        readCount <= 3'h0;
      end else begin
        readCount <= _T_20;
      end
    end
    if (reset) begin
      dramLatencyCnt <= 20'h0;
    end else if (start) begin
      dramLatencyCnt <= 20'h0;
    end else if (_T_22) begin
      if (_T_24) begin
        dramLatencyCnt <= 20'h0;
      end else begin
        dramLatencyCnt <= _T_26;
      end
    end
    if (reset) begin
      nextPacket <= 20'h0;
    end else if (start) begin
      nextPacket <= 20'h0;
    end else if (_T_27) begin
      if (_T_29) begin
        nextPacket <= 20'h0;
      end else begin
        nextPacket <= _T_31;
      end
    end
  end
endmodule
module Queue(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits_addr,
  input  [7:0]  io_enq_bits_inst,
  input  [63:0] io_enq_bits_data,
  input  [2:0]  io_enq_bits_src,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits_addr,
  output [7:0]  io_deq_bits_inst,
  output [63:0] io_deq_bits_data,
  output [2:0]  io_deq_bits_src
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram_addr [0:31]; // @[Decoupled.scala 209:16]
  wire [31:0] ram_addr__T_11_data; // @[Decoupled.scala 209:16]
  wire [4:0] ram_addr__T_11_addr; // @[Decoupled.scala 209:16]
  wire [31:0] ram_addr__T_3_data; // @[Decoupled.scala 209:16]
  wire [4:0] ram_addr__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_en; // @[Decoupled.scala 209:16]
  reg [7:0] ram_inst [0:31]; // @[Decoupled.scala 209:16]
  wire [7:0] ram_inst__T_11_data; // @[Decoupled.scala 209:16]
  wire [4:0] ram_inst__T_11_addr; // @[Decoupled.scala 209:16]
  wire [7:0] ram_inst__T_3_data; // @[Decoupled.scala 209:16]
  wire [4:0] ram_inst__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_3_en; // @[Decoupled.scala 209:16]
  reg [63:0] ram_data [0:31]; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_11_data; // @[Decoupled.scala 209:16]
  wire [4:0] ram_data__T_11_addr; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_3_data; // @[Decoupled.scala 209:16]
  wire [4:0] ram_data__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_en; // @[Decoupled.scala 209:16]
  reg [2:0] ram_src [0:31]; // @[Decoupled.scala 209:16]
  wire [2:0] ram_src__T_11_data; // @[Decoupled.scala 209:16]
  wire [4:0] ram_src__T_11_addr; // @[Decoupled.scala 209:16]
  wire [2:0] ram_src__T_3_data; // @[Decoupled.scala 209:16]
  wire [4:0] ram_src__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_src__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_src__T_3_en; // @[Decoupled.scala 209:16]
  reg [4:0] enq_ptr_value; // @[Counter.scala 29:33]
  reg [4:0] deq_ptr_value; // @[Counter.scala 29:33]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 214:33]
  wire  _T = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  empty = ptr_match & _T; // @[Decoupled.scala 215:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 216:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire [4:0] _T_5 = enq_ptr_value + 5'h1; // @[Counter.scala 39:22]
  wire [4:0] _T_7 = deq_ptr_value + 5'h1; // @[Counter.scala 39:22]
  wire  _T_8 = do_enq != do_deq; // @[Decoupled.scala 227:16]
  assign ram_addr__T_11_addr = deq_ptr_value;
  assign ram_addr__T_11_data = ram_addr[ram_addr__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_addr__T_3_data = io_enq_bits_addr;
  assign ram_addr__T_3_addr = enq_ptr_value;
  assign ram_addr__T_3_mask = 1'h1;
  assign ram_addr__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_inst__T_11_addr = deq_ptr_value;
  assign ram_inst__T_11_data = ram_inst[ram_inst__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_inst__T_3_data = io_enq_bits_inst;
  assign ram_inst__T_3_addr = enq_ptr_value;
  assign ram_inst__T_3_mask = 1'h1;
  assign ram_inst__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_data__T_11_addr = deq_ptr_value;
  assign ram_data__T_11_data = ram_data[ram_data__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_data__T_3_data = io_enq_bits_data;
  assign ram_data__T_3_addr = enq_ptr_value;
  assign ram_data__T_3_mask = 1'h1;
  assign ram_data__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_src__T_11_addr = deq_ptr_value;
  assign ram_src__T_11_data = ram_src[ram_src__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_src__T_3_data = io_enq_bits_src;
  assign ram_src__T_3_addr = enq_ptr_value;
  assign ram_src__T_3_mask = 1'h1;
  assign ram_src__T_3_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 232:16]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 231:16]
  assign io_deq_bits_addr = ram_addr__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_inst = ram_inst__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_data = ram_data__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_src = ram_src__T_11_data; // @[Decoupled.scala 233:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    ram_addr[initvar] = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    ram_inst[initvar] = _RAND_1[7:0];
  _RAND_2 = {2{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    ram_data[initvar] = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 32; initvar = initvar+1)
    ram_src[initvar] = _RAND_3[2:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  enq_ptr_value = _RAND_4[4:0];
  _RAND_5 = {1{`RANDOM}};
  deq_ptr_value = _RAND_5[4:0];
  _RAND_6 = {1{`RANDOM}};
  maybe_full = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram_addr__T_3_en & ram_addr__T_3_mask) begin
      ram_addr[ram_addr__T_3_addr] <= ram_addr__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_inst__T_3_en & ram_inst__T_3_mask) begin
      ram_inst[ram_inst__T_3_addr] <= ram_inst__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_data__T_3_en & ram_data__T_3_mask) begin
      ram_data[ram_data__T_3_addr] <= ram_data__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_src__T_3_en & ram_src__T_3_mask) begin
      ram_src[ram_src__T_3_addr] <= ram_src__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      enq_ptr_value <= 5'h0;
    end else if (do_enq) begin
      enq_ptr_value <= _T_5;
    end
    if (reset) begin
      deq_ptr_value <= 5'h0;
    end else if (do_deq) begin
      deq_ptr_value <= _T_7;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_8) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module Queue_1(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits_addr,
  input  [7:0]  io_enq_bits_inst,
  input  [63:0] io_enq_bits_data,
  input  [2:0]  io_enq_bits_src,
  input  [2:0]  io_enq_bits_dst,
  input  [1:0]  io_enq_bits_msgType,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits_addr,
  output [7:0]  io_deq_bits_inst,
  output [63:0] io_deq_bits_data,
  output [2:0]  io_deq_bits_src,
  output [2:0]  io_deq_bits_dst,
  output [1:0]  io_deq_bits_msgType
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram_addr [0:1]; // @[Decoupled.scala 209:16]
  wire [31:0] ram_addr__T_11_data; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_11_addr; // @[Decoupled.scala 209:16]
  wire [31:0] ram_addr__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_en; // @[Decoupled.scala 209:16]
  reg [7:0] ram_inst [0:1]; // @[Decoupled.scala 209:16]
  wire [7:0] ram_inst__T_11_data; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_11_addr; // @[Decoupled.scala 209:16]
  wire [7:0] ram_inst__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_3_en; // @[Decoupled.scala 209:16]
  reg [63:0] ram_data [0:1]; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_11_data; // @[Decoupled.scala 209:16]
  wire  ram_data__T_11_addr; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_en; // @[Decoupled.scala 209:16]
  reg [2:0] ram_src [0:1]; // @[Decoupled.scala 209:16]
  wire [2:0] ram_src__T_11_data; // @[Decoupled.scala 209:16]
  wire  ram_src__T_11_addr; // @[Decoupled.scala 209:16]
  wire [2:0] ram_src__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_src__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_src__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_src__T_3_en; // @[Decoupled.scala 209:16]
  reg [2:0] ram_dst [0:1]; // @[Decoupled.scala 209:16]
  wire [2:0] ram_dst__T_11_data; // @[Decoupled.scala 209:16]
  wire  ram_dst__T_11_addr; // @[Decoupled.scala 209:16]
  wire [2:0] ram_dst__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_dst__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_dst__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_dst__T_3_en; // @[Decoupled.scala 209:16]
  reg [1:0] ram_msgType [0:1]; // @[Decoupled.scala 209:16]
  wire [1:0] ram_msgType__T_11_data; // @[Decoupled.scala 209:16]
  wire  ram_msgType__T_11_addr; // @[Decoupled.scala 209:16]
  wire [1:0] ram_msgType__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_msgType__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_msgType__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_msgType__T_3_en; // @[Decoupled.scala 209:16]
  reg  enq_ptr_value; // @[Counter.scala 29:33]
  reg  deq_ptr_value; // @[Counter.scala 29:33]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 214:33]
  wire  _T = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  empty = ptr_match & _T; // @[Decoupled.scala 215:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 216:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire  _T_5 = enq_ptr_value + 1'h1; // @[Counter.scala 39:22]
  wire  _T_7 = deq_ptr_value + 1'h1; // @[Counter.scala 39:22]
  wire  _T_8 = do_enq != do_deq; // @[Decoupled.scala 227:16]
  wire  _T_10 = ~full; // @[Decoupled.scala 232:19]
  assign ram_addr__T_11_addr = deq_ptr_value;
  assign ram_addr__T_11_data = ram_addr[ram_addr__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_addr__T_3_data = io_enq_bits_addr;
  assign ram_addr__T_3_addr = enq_ptr_value;
  assign ram_addr__T_3_mask = 1'h1;
  assign ram_addr__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_inst__T_11_addr = deq_ptr_value;
  assign ram_inst__T_11_data = ram_inst[ram_inst__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_inst__T_3_data = io_enq_bits_inst;
  assign ram_inst__T_3_addr = enq_ptr_value;
  assign ram_inst__T_3_mask = 1'h1;
  assign ram_inst__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_data__T_11_addr = deq_ptr_value;
  assign ram_data__T_11_data = ram_data[ram_data__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_data__T_3_data = io_enq_bits_data;
  assign ram_data__T_3_addr = enq_ptr_value;
  assign ram_data__T_3_mask = 1'h1;
  assign ram_data__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_src__T_11_addr = deq_ptr_value;
  assign ram_src__T_11_data = ram_src[ram_src__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_src__T_3_data = io_enq_bits_src;
  assign ram_src__T_3_addr = enq_ptr_value;
  assign ram_src__T_3_mask = 1'h1;
  assign ram_src__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_dst__T_11_addr = deq_ptr_value;
  assign ram_dst__T_11_data = ram_dst[ram_dst__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_dst__T_3_data = io_enq_bits_dst;
  assign ram_dst__T_3_addr = enq_ptr_value;
  assign ram_dst__T_3_mask = 1'h1;
  assign ram_dst__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_msgType__T_11_addr = deq_ptr_value;
  assign ram_msgType__T_11_data = ram_msgType[ram_msgType__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_msgType__T_3_data = io_enq_bits_msgType;
  assign ram_msgType__T_3_addr = enq_ptr_value;
  assign ram_msgType__T_3_mask = 1'h1;
  assign ram_msgType__T_3_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = io_deq_ready | _T_10; // @[Decoupled.scala 232:16 Decoupled.scala 245:40]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 231:16]
  assign io_deq_bits_addr = ram_addr__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_inst = ram_inst__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_data = ram_data__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_src = ram_src__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_dst = ram_dst__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_msgType = ram_msgType__T_11_data; // @[Decoupled.scala 233:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_addr[initvar] = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_inst[initvar] = _RAND_1[7:0];
  _RAND_2 = {2{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_data[initvar] = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_src[initvar] = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_dst[initvar] = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_msgType[initvar] = _RAND_5[1:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  enq_ptr_value = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  deq_ptr_value = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  maybe_full = _RAND_8[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram_addr__T_3_en & ram_addr__T_3_mask) begin
      ram_addr[ram_addr__T_3_addr] <= ram_addr__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_inst__T_3_en & ram_inst__T_3_mask) begin
      ram_inst[ram_inst__T_3_addr] <= ram_inst__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_data__T_3_en & ram_data__T_3_mask) begin
      ram_data[ram_data__T_3_addr] <= ram_data__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_src__T_3_en & ram_src__T_3_mask) begin
      ram_src[ram_src__T_3_addr] <= ram_src__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_dst__T_3_en & ram_dst__T_3_mask) begin
      ram_dst[ram_dst__T_3_addr] <= ram_dst__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_msgType__T_3_en & ram_msgType__T_3_mask) begin
      ram_msgType[ram_msgType__T_3_addr] <= ram_msgType__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      enq_ptr_value <= 1'h0;
    end else if (do_enq) begin
      enq_ptr_value <= _T_5;
    end
    if (reset) begin
      deq_ptr_value <= 1'h0;
    end else if (do_deq) begin
      deq_ptr_value <= _T_7;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_8) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module Queue_3(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits_addr,
  input  [7:0]  io_enq_bits_inst,
  input  [63:0] io_enq_bits_data,
  input  [2:0]  io_enq_bits_src,
  input  [2:0]  io_enq_bits_dst,
  input  [1:0]  io_enq_bits_msgType,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits_addr,
  output [7:0]  io_deq_bits_inst,
  output [63:0] io_deq_bits_data,
  output [2:0]  io_deq_bits_src,
  output [2:0]  io_deq_bits_dst,
  output [1:0]  io_deq_bits_msgType
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram_addr [0:1]; // @[Decoupled.scala 209:16]
  wire [31:0] ram_addr__T_11_data; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_11_addr; // @[Decoupled.scala 209:16]
  wire [31:0] ram_addr__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_en; // @[Decoupled.scala 209:16]
  reg [7:0] ram_inst [0:1]; // @[Decoupled.scala 209:16]
  wire [7:0] ram_inst__T_11_data; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_11_addr; // @[Decoupled.scala 209:16]
  wire [7:0] ram_inst__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_3_en; // @[Decoupled.scala 209:16]
  reg [63:0] ram_data [0:1]; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_11_data; // @[Decoupled.scala 209:16]
  wire  ram_data__T_11_addr; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_en; // @[Decoupled.scala 209:16]
  reg [2:0] ram_src [0:1]; // @[Decoupled.scala 209:16]
  wire [2:0] ram_src__T_11_data; // @[Decoupled.scala 209:16]
  wire  ram_src__T_11_addr; // @[Decoupled.scala 209:16]
  wire [2:0] ram_src__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_src__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_src__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_src__T_3_en; // @[Decoupled.scala 209:16]
  reg [2:0] ram_dst [0:1]; // @[Decoupled.scala 209:16]
  wire [2:0] ram_dst__T_11_data; // @[Decoupled.scala 209:16]
  wire  ram_dst__T_11_addr; // @[Decoupled.scala 209:16]
  wire [2:0] ram_dst__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_dst__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_dst__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_dst__T_3_en; // @[Decoupled.scala 209:16]
  reg [1:0] ram_msgType [0:1]; // @[Decoupled.scala 209:16]
  wire [1:0] ram_msgType__T_11_data; // @[Decoupled.scala 209:16]
  wire  ram_msgType__T_11_addr; // @[Decoupled.scala 209:16]
  wire [1:0] ram_msgType__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_msgType__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_msgType__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_msgType__T_3_en; // @[Decoupled.scala 209:16]
  reg  enq_ptr_value; // @[Counter.scala 29:33]
  reg  deq_ptr_value; // @[Counter.scala 29:33]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 214:33]
  wire  _T = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  empty = ptr_match & _T; // @[Decoupled.scala 215:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 216:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire  _T_5 = enq_ptr_value + 1'h1; // @[Counter.scala 39:22]
  wire  _T_7 = deq_ptr_value + 1'h1; // @[Counter.scala 39:22]
  wire  _T_8 = do_enq != do_deq; // @[Decoupled.scala 227:16]
  assign ram_addr__T_11_addr = deq_ptr_value;
  assign ram_addr__T_11_data = ram_addr[ram_addr__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_addr__T_3_data = io_enq_bits_addr;
  assign ram_addr__T_3_addr = enq_ptr_value;
  assign ram_addr__T_3_mask = 1'h1;
  assign ram_addr__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_inst__T_11_addr = deq_ptr_value;
  assign ram_inst__T_11_data = ram_inst[ram_inst__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_inst__T_3_data = io_enq_bits_inst;
  assign ram_inst__T_3_addr = enq_ptr_value;
  assign ram_inst__T_3_mask = 1'h1;
  assign ram_inst__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_data__T_11_addr = deq_ptr_value;
  assign ram_data__T_11_data = ram_data[ram_data__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_data__T_3_data = io_enq_bits_data;
  assign ram_data__T_3_addr = enq_ptr_value;
  assign ram_data__T_3_mask = 1'h1;
  assign ram_data__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_src__T_11_addr = deq_ptr_value;
  assign ram_src__T_11_data = ram_src[ram_src__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_src__T_3_data = io_enq_bits_src;
  assign ram_src__T_3_addr = enq_ptr_value;
  assign ram_src__T_3_mask = 1'h1;
  assign ram_src__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_dst__T_11_addr = deq_ptr_value;
  assign ram_dst__T_11_data = ram_dst[ram_dst__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_dst__T_3_data = io_enq_bits_dst;
  assign ram_dst__T_3_addr = enq_ptr_value;
  assign ram_dst__T_3_mask = 1'h1;
  assign ram_dst__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_msgType__T_11_addr = deq_ptr_value;
  assign ram_msgType__T_11_data = ram_msgType[ram_msgType__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_msgType__T_3_data = io_enq_bits_msgType;
  assign ram_msgType__T_3_addr = enq_ptr_value;
  assign ram_msgType__T_3_mask = 1'h1;
  assign ram_msgType__T_3_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 232:16]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 231:16]
  assign io_deq_bits_addr = ram_addr__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_inst = ram_inst__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_data = ram_data__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_src = ram_src__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_dst = ram_dst__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_msgType = ram_msgType__T_11_data; // @[Decoupled.scala 233:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_addr[initvar] = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_inst[initvar] = _RAND_1[7:0];
  _RAND_2 = {2{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_data[initvar] = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_src[initvar] = _RAND_3[2:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_dst[initvar] = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    ram_msgType[initvar] = _RAND_5[1:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  enq_ptr_value = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  deq_ptr_value = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  maybe_full = _RAND_8[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram_addr__T_3_en & ram_addr__T_3_mask) begin
      ram_addr[ram_addr__T_3_addr] <= ram_addr__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_inst__T_3_en & ram_inst__T_3_mask) begin
      ram_inst[ram_inst__T_3_addr] <= ram_inst__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_data__T_3_en & ram_data__T_3_mask) begin
      ram_data[ram_data__T_3_addr] <= ram_data__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_src__T_3_en & ram_src__T_3_mask) begin
      ram_src[ram_src__T_3_addr] <= ram_src__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_dst__T_3_en & ram_dst__T_3_mask) begin
      ram_dst[ram_dst__T_3_addr] <= ram_dst__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_msgType__T_3_en & ram_msgType__T_3_mask) begin
      ram_msgType[ram_msgType__T_3_addr] <= ram_msgType__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      enq_ptr_value <= 1'h0;
    end else if (do_enq) begin
      enq_ptr_value <= _T_5;
    end
    if (reset) begin
      deq_ptr_value <= 1'h0;
    end else if (do_deq) begin
      deq_ptr_value <= _T_7;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_8) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module RRArbiter(
  input         clock,
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [31:0] io_in_0_bits_addr,
  input  [7:0]  io_in_0_bits_inst,
  input  [63:0] io_in_0_bits_data,
  input  [2:0]  io_in_0_bits_src,
  input  [2:0]  io_in_0_bits_dst,
  input  [1:0]  io_in_0_bits_msgType,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [31:0] io_in_1_bits_addr,
  input  [7:0]  io_in_1_bits_inst,
  input  [63:0] io_in_1_bits_data,
  input  [2:0]  io_in_1_bits_src,
  input  [2:0]  io_in_1_bits_dst,
  input  [1:0]  io_in_1_bits_msgType,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits_addr,
  output [7:0]  io_out_bits_inst,
  output [63:0] io_out_bits_data,
  output [2:0]  io_out_bits_src,
  output [2:0]  io_out_bits_dst,
  output [1:0]  io_out_bits_msgType,
  output        io_chosen
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  _T = io_out_ready & io_out_valid; // @[Decoupled.scala 40:37]
  reg  lastGrant; // @[Reg.scala 15:16]
  wire  grantMask_1 = 1'h1 > lastGrant; // @[Arbiter.scala 67:49]
  wire  validMask_1 = io_in_1_valid & grantMask_1; // @[Arbiter.scala 68:75]
  wire  _T_2 = validMask_1 | io_in_0_valid; // @[Arbiter.scala 31:68]
  wire  _T_4 = ~validMask_1; // @[Arbiter.scala 31:78]
  wire  _T_5 = ~_T_2; // @[Arbiter.scala 31:78]
  wire  _T_9 = grantMask_1 | _T_5; // @[Arbiter.scala 72:50]
  wire  _GEN_17 = io_in_0_valid ? 1'h0 : 1'h1; // @[Arbiter.scala 77:27]
  assign io_in_0_ready = _T_4 & io_out_ready; // @[Arbiter.scala 60:16]
  assign io_in_1_ready = _T_9 & io_out_ready; // @[Arbiter.scala 60:16]
  assign io_out_valid = io_chosen ? io_in_1_valid : io_in_0_valid; // @[Arbiter.scala 41:16]
  assign io_out_bits_addr = io_chosen ? io_in_1_bits_addr : io_in_0_bits_addr; // @[Arbiter.scala 42:15]
  assign io_out_bits_inst = io_chosen ? io_in_1_bits_inst : io_in_0_bits_inst; // @[Arbiter.scala 42:15]
  assign io_out_bits_data = io_chosen ? io_in_1_bits_data : io_in_0_bits_data; // @[Arbiter.scala 42:15]
  assign io_out_bits_src = io_chosen ? io_in_1_bits_src : io_in_0_bits_src; // @[Arbiter.scala 42:15]
  assign io_out_bits_dst = io_chosen ? io_in_1_bits_dst : io_in_0_bits_dst; // @[Arbiter.scala 42:15]
  assign io_out_bits_msgType = io_chosen ? io_in_1_bits_msgType : io_in_0_bits_msgType; // @[Arbiter.scala 42:15]
  assign io_chosen = validMask_1 | _GEN_17; // @[Arbiter.scala 40:13]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  lastGrant = _RAND_0[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (_T) begin
      lastGrant <= io_chosen;
    end
  end
endmodule
module Router(
  input         clock,
  input         reset,
  input         io_cacheIn_valid,
  input  [31:0] io_cacheIn_bits_addr,
  input  [63:0] io_cacheIn_bits_data,
  input         io_cacheOut_ready,
  output        io_cacheOut_valid,
  output [31:0] io_cacheOut_bits_addr,
  output [7:0]  io_cacheOut_bits_inst,
  output [63:0] io_cacheOut_bits_data,
  output [1:0]  io_cacheOut_bits_msgType,
  output        io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_bits_addr,
  input  [7:0]  io_in_bits_inst,
  input  [63:0] io_in_bits_data,
  input  [2:0]  io_in_bits_src,
  input  [2:0]  io_in_bits_dst,
  input  [1:0]  io_in_bits_msgType,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits_addr,
  output [7:0]  io_out_bits_inst,
  output [63:0] io_out_bits_data,
  output [2:0]  io_out_bits_src,
  output [2:0]  io_out_bits_dst,
  output [1:0]  io_out_bits_msgType
);
  wire  cache_in_Q_clock; // @[Router.scala 19:26]
  wire  cache_in_Q_reset; // @[Router.scala 19:26]
  wire  cache_in_Q_io_enq_ready; // @[Router.scala 19:26]
  wire  cache_in_Q_io_enq_valid; // @[Router.scala 19:26]
  wire [31:0] cache_in_Q_io_enq_bits_addr; // @[Router.scala 19:26]
  wire [7:0] cache_in_Q_io_enq_bits_inst; // @[Router.scala 19:26]
  wire [63:0] cache_in_Q_io_enq_bits_data; // @[Router.scala 19:26]
  wire [2:0] cache_in_Q_io_enq_bits_src; // @[Router.scala 19:26]
  wire [2:0] cache_in_Q_io_enq_bits_dst; // @[Router.scala 19:26]
  wire [1:0] cache_in_Q_io_enq_bits_msgType; // @[Router.scala 19:26]
  wire  cache_in_Q_io_deq_ready; // @[Router.scala 19:26]
  wire  cache_in_Q_io_deq_valid; // @[Router.scala 19:26]
  wire [31:0] cache_in_Q_io_deq_bits_addr; // @[Router.scala 19:26]
  wire [7:0] cache_in_Q_io_deq_bits_inst; // @[Router.scala 19:26]
  wire [63:0] cache_in_Q_io_deq_bits_data; // @[Router.scala 19:26]
  wire [2:0] cache_in_Q_io_deq_bits_src; // @[Router.scala 19:26]
  wire [2:0] cache_in_Q_io_deq_bits_dst; // @[Router.scala 19:26]
  wire [1:0] cache_in_Q_io_deq_bits_msgType; // @[Router.scala 19:26]
  wire  cache_out_Q_clock; // @[Router.scala 20:27]
  wire  cache_out_Q_reset; // @[Router.scala 20:27]
  wire  cache_out_Q_io_enq_ready; // @[Router.scala 20:27]
  wire  cache_out_Q_io_enq_valid; // @[Router.scala 20:27]
  wire [31:0] cache_out_Q_io_enq_bits_addr; // @[Router.scala 20:27]
  wire [7:0] cache_out_Q_io_enq_bits_inst; // @[Router.scala 20:27]
  wire [63:0] cache_out_Q_io_enq_bits_data; // @[Router.scala 20:27]
  wire [2:0] cache_out_Q_io_enq_bits_src; // @[Router.scala 20:27]
  wire [2:0] cache_out_Q_io_enq_bits_dst; // @[Router.scala 20:27]
  wire [1:0] cache_out_Q_io_enq_bits_msgType; // @[Router.scala 20:27]
  wire  cache_out_Q_io_deq_ready; // @[Router.scala 20:27]
  wire  cache_out_Q_io_deq_valid; // @[Router.scala 20:27]
  wire [31:0] cache_out_Q_io_deq_bits_addr; // @[Router.scala 20:27]
  wire [7:0] cache_out_Q_io_deq_bits_inst; // @[Router.scala 20:27]
  wire [63:0] cache_out_Q_io_deq_bits_data; // @[Router.scala 20:27]
  wire [2:0] cache_out_Q_io_deq_bits_src; // @[Router.scala 20:27]
  wire [2:0] cache_out_Q_io_deq_bits_dst; // @[Router.scala 20:27]
  wire [1:0] cache_out_Q_io_deq_bits_msgType; // @[Router.scala 20:27]
  wire  in_Q_clock; // @[Router.scala 21:20]
  wire  in_Q_reset; // @[Router.scala 21:20]
  wire  in_Q_io_enq_ready; // @[Router.scala 21:20]
  wire  in_Q_io_enq_valid; // @[Router.scala 21:20]
  wire [31:0] in_Q_io_enq_bits_addr; // @[Router.scala 21:20]
  wire [7:0] in_Q_io_enq_bits_inst; // @[Router.scala 21:20]
  wire [63:0] in_Q_io_enq_bits_data; // @[Router.scala 21:20]
  wire [2:0] in_Q_io_enq_bits_src; // @[Router.scala 21:20]
  wire [2:0] in_Q_io_enq_bits_dst; // @[Router.scala 21:20]
  wire [1:0] in_Q_io_enq_bits_msgType; // @[Router.scala 21:20]
  wire  in_Q_io_deq_ready; // @[Router.scala 21:20]
  wire  in_Q_io_deq_valid; // @[Router.scala 21:20]
  wire [31:0] in_Q_io_deq_bits_addr; // @[Router.scala 21:20]
  wire [7:0] in_Q_io_deq_bits_inst; // @[Router.scala 21:20]
  wire [63:0] in_Q_io_deq_bits_data; // @[Router.scala 21:20]
  wire [2:0] in_Q_io_deq_bits_src; // @[Router.scala 21:20]
  wire [2:0] in_Q_io_deq_bits_dst; // @[Router.scala 21:20]
  wire [1:0] in_Q_io_deq_bits_msgType; // @[Router.scala 21:20]
  wire  arbiter_clock; // @[Router.scala 23:23]
  wire  arbiter_io_in_0_ready; // @[Router.scala 23:23]
  wire  arbiter_io_in_0_valid; // @[Router.scala 23:23]
  wire [31:0] arbiter_io_in_0_bits_addr; // @[Router.scala 23:23]
  wire [7:0] arbiter_io_in_0_bits_inst; // @[Router.scala 23:23]
  wire [63:0] arbiter_io_in_0_bits_data; // @[Router.scala 23:23]
  wire [2:0] arbiter_io_in_0_bits_src; // @[Router.scala 23:23]
  wire [2:0] arbiter_io_in_0_bits_dst; // @[Router.scala 23:23]
  wire [1:0] arbiter_io_in_0_bits_msgType; // @[Router.scala 23:23]
  wire  arbiter_io_in_1_ready; // @[Router.scala 23:23]
  wire  arbiter_io_in_1_valid; // @[Router.scala 23:23]
  wire [31:0] arbiter_io_in_1_bits_addr; // @[Router.scala 23:23]
  wire [7:0] arbiter_io_in_1_bits_inst; // @[Router.scala 23:23]
  wire [63:0] arbiter_io_in_1_bits_data; // @[Router.scala 23:23]
  wire [2:0] arbiter_io_in_1_bits_src; // @[Router.scala 23:23]
  wire [2:0] arbiter_io_in_1_bits_dst; // @[Router.scala 23:23]
  wire [1:0] arbiter_io_in_1_bits_msgType; // @[Router.scala 23:23]
  wire  arbiter_io_out_ready; // @[Router.scala 23:23]
  wire  arbiter_io_out_valid; // @[Router.scala 23:23]
  wire [31:0] arbiter_io_out_bits_addr; // @[Router.scala 23:23]
  wire [7:0] arbiter_io_out_bits_inst; // @[Router.scala 23:23]
  wire [63:0] arbiter_io_out_bits_data; // @[Router.scala 23:23]
  wire [2:0] arbiter_io_out_bits_src; // @[Router.scala 23:23]
  wire [2:0] arbiter_io_out_bits_dst; // @[Router.scala 23:23]
  wire [1:0] arbiter_io_out_bits_msgType; // @[Router.scala 23:23]
  wire  arbiter_io_chosen; // @[Router.scala 23:23]
  wire  _T = in_Q_io_deq_bits_dst == 3'h0; // @[Router.scala 34:74]
  wire  _T_2 = in_Q_io_deq_bits_dst != 3'h0; // @[Router.scala 37:72]
  wire  _T_5 = arbiter_io_in_1_ready & _T_2; // @[Router.scala 38:48]
  wire  _T_7 = cache_out_Q_io_enq_ready & _T; // @[Router.scala 38:113]
  Queue_1 cache_in_Q ( // @[Router.scala 19:26]
    .clock(cache_in_Q_clock),
    .reset(cache_in_Q_reset),
    .io_enq_ready(cache_in_Q_io_enq_ready),
    .io_enq_valid(cache_in_Q_io_enq_valid),
    .io_enq_bits_addr(cache_in_Q_io_enq_bits_addr),
    .io_enq_bits_inst(cache_in_Q_io_enq_bits_inst),
    .io_enq_bits_data(cache_in_Q_io_enq_bits_data),
    .io_enq_bits_src(cache_in_Q_io_enq_bits_src),
    .io_enq_bits_dst(cache_in_Q_io_enq_bits_dst),
    .io_enq_bits_msgType(cache_in_Q_io_enq_bits_msgType),
    .io_deq_ready(cache_in_Q_io_deq_ready),
    .io_deq_valid(cache_in_Q_io_deq_valid),
    .io_deq_bits_addr(cache_in_Q_io_deq_bits_addr),
    .io_deq_bits_inst(cache_in_Q_io_deq_bits_inst),
    .io_deq_bits_data(cache_in_Q_io_deq_bits_data),
    .io_deq_bits_src(cache_in_Q_io_deq_bits_src),
    .io_deq_bits_dst(cache_in_Q_io_deq_bits_dst),
    .io_deq_bits_msgType(cache_in_Q_io_deq_bits_msgType)
  );
  Queue_1 cache_out_Q ( // @[Router.scala 20:27]
    .clock(cache_out_Q_clock),
    .reset(cache_out_Q_reset),
    .io_enq_ready(cache_out_Q_io_enq_ready),
    .io_enq_valid(cache_out_Q_io_enq_valid),
    .io_enq_bits_addr(cache_out_Q_io_enq_bits_addr),
    .io_enq_bits_inst(cache_out_Q_io_enq_bits_inst),
    .io_enq_bits_data(cache_out_Q_io_enq_bits_data),
    .io_enq_bits_src(cache_out_Q_io_enq_bits_src),
    .io_enq_bits_dst(cache_out_Q_io_enq_bits_dst),
    .io_enq_bits_msgType(cache_out_Q_io_enq_bits_msgType),
    .io_deq_ready(cache_out_Q_io_deq_ready),
    .io_deq_valid(cache_out_Q_io_deq_valid),
    .io_deq_bits_addr(cache_out_Q_io_deq_bits_addr),
    .io_deq_bits_inst(cache_out_Q_io_deq_bits_inst),
    .io_deq_bits_data(cache_out_Q_io_deq_bits_data),
    .io_deq_bits_src(cache_out_Q_io_deq_bits_src),
    .io_deq_bits_dst(cache_out_Q_io_deq_bits_dst),
    .io_deq_bits_msgType(cache_out_Q_io_deq_bits_msgType)
  );
  Queue_3 in_Q ( // @[Router.scala 21:20]
    .clock(in_Q_clock),
    .reset(in_Q_reset),
    .io_enq_ready(in_Q_io_enq_ready),
    .io_enq_valid(in_Q_io_enq_valid),
    .io_enq_bits_addr(in_Q_io_enq_bits_addr),
    .io_enq_bits_inst(in_Q_io_enq_bits_inst),
    .io_enq_bits_data(in_Q_io_enq_bits_data),
    .io_enq_bits_src(in_Q_io_enq_bits_src),
    .io_enq_bits_dst(in_Q_io_enq_bits_dst),
    .io_enq_bits_msgType(in_Q_io_enq_bits_msgType),
    .io_deq_ready(in_Q_io_deq_ready),
    .io_deq_valid(in_Q_io_deq_valid),
    .io_deq_bits_addr(in_Q_io_deq_bits_addr),
    .io_deq_bits_inst(in_Q_io_deq_bits_inst),
    .io_deq_bits_data(in_Q_io_deq_bits_data),
    .io_deq_bits_src(in_Q_io_deq_bits_src),
    .io_deq_bits_dst(in_Q_io_deq_bits_dst),
    .io_deq_bits_msgType(in_Q_io_deq_bits_msgType)
  );
  RRArbiter arbiter ( // @[Router.scala 23:23]
    .clock(arbiter_clock),
    .io_in_0_ready(arbiter_io_in_0_ready),
    .io_in_0_valid(arbiter_io_in_0_valid),
    .io_in_0_bits_addr(arbiter_io_in_0_bits_addr),
    .io_in_0_bits_inst(arbiter_io_in_0_bits_inst),
    .io_in_0_bits_data(arbiter_io_in_0_bits_data),
    .io_in_0_bits_src(arbiter_io_in_0_bits_src),
    .io_in_0_bits_dst(arbiter_io_in_0_bits_dst),
    .io_in_0_bits_msgType(arbiter_io_in_0_bits_msgType),
    .io_in_1_ready(arbiter_io_in_1_ready),
    .io_in_1_valid(arbiter_io_in_1_valid),
    .io_in_1_bits_addr(arbiter_io_in_1_bits_addr),
    .io_in_1_bits_inst(arbiter_io_in_1_bits_inst),
    .io_in_1_bits_data(arbiter_io_in_1_bits_data),
    .io_in_1_bits_src(arbiter_io_in_1_bits_src),
    .io_in_1_bits_dst(arbiter_io_in_1_bits_dst),
    .io_in_1_bits_msgType(arbiter_io_in_1_bits_msgType),
    .io_out_ready(arbiter_io_out_ready),
    .io_out_valid(arbiter_io_out_valid),
    .io_out_bits_addr(arbiter_io_out_bits_addr),
    .io_out_bits_inst(arbiter_io_out_bits_inst),
    .io_out_bits_data(arbiter_io_out_bits_data),
    .io_out_bits_src(arbiter_io_out_bits_src),
    .io_out_bits_dst(arbiter_io_out_bits_dst),
    .io_out_bits_msgType(arbiter_io_out_bits_msgType),
    .io_chosen(arbiter_io_chosen)
  );
  assign io_cacheOut_valid = cache_out_Q_io_deq_valid; // @[Router.scala 26:15]
  assign io_cacheOut_bits_addr = cache_out_Q_io_deq_bits_addr; // @[Router.scala 26:15]
  assign io_cacheOut_bits_inst = cache_out_Q_io_deq_bits_inst; // @[Router.scala 26:15]
  assign io_cacheOut_bits_data = cache_out_Q_io_deq_bits_data; // @[Router.scala 26:15]
  assign io_cacheOut_bits_msgType = cache_out_Q_io_deq_bits_msgType; // @[Router.scala 26:15]
  assign io_in_ready = in_Q_io_enq_ready; // @[Router.scala 27:15]
  assign io_out_valid = arbiter_io_out_valid; // @[Router.scala 29:10]
  assign io_out_bits_addr = arbiter_io_out_bits_addr; // @[Router.scala 29:10]
  assign io_out_bits_inst = arbiter_io_out_bits_inst; // @[Router.scala 29:10]
  assign io_out_bits_data = arbiter_io_out_bits_data; // @[Router.scala 29:10]
  assign io_out_bits_src = arbiter_io_out_bits_src; // @[Router.scala 29:10]
  assign io_out_bits_dst = arbiter_io_out_bits_dst; // @[Router.scala 29:10]
  assign io_out_bits_msgType = arbiter_io_out_bits_msgType; // @[Router.scala 29:10]
  assign cache_in_Q_clock = clock;
  assign cache_in_Q_reset = reset;
  assign cache_in_Q_io_enq_valid = io_cacheIn_valid; // @[Router.scala 25:21]
  assign cache_in_Q_io_enq_bits_addr = io_cacheIn_bits_addr; // @[Router.scala 25:21]
  assign cache_in_Q_io_enq_bits_inst = 8'h0; // @[Router.scala 25:21]
  assign cache_in_Q_io_enq_bits_data = io_cacheIn_bits_data; // @[Router.scala 25:21]
  assign cache_in_Q_io_enq_bits_src = 3'h0; // @[Router.scala 25:21]
  assign cache_in_Q_io_enq_bits_dst = 3'h1; // @[Router.scala 25:21]
  assign cache_in_Q_io_enq_bits_msgType = 2'h0; // @[Router.scala 25:21]
  assign cache_in_Q_io_deq_ready = arbiter_io_in_0_ready; // @[Router.scala 31:20]
  assign cache_out_Q_clock = clock;
  assign cache_out_Q_reset = reset;
  assign cache_out_Q_io_enq_valid = in_Q_io_deq_valid & _T; // @[Router.scala 34:28]
  assign cache_out_Q_io_enq_bits_addr = in_Q_io_deq_bits_addr; // @[Router.scala 33:27]
  assign cache_out_Q_io_enq_bits_inst = in_Q_io_deq_bits_inst; // @[Router.scala 33:27]
  assign cache_out_Q_io_enq_bits_data = in_Q_io_deq_bits_data; // @[Router.scala 33:27]
  assign cache_out_Q_io_enq_bits_src = in_Q_io_deq_bits_src; // @[Router.scala 33:27]
  assign cache_out_Q_io_enq_bits_dst = in_Q_io_deq_bits_dst; // @[Router.scala 33:27]
  assign cache_out_Q_io_enq_bits_msgType = in_Q_io_deq_bits_msgType; // @[Router.scala 33:27]
  assign cache_out_Q_io_deq_ready = io_cacheOut_ready; // @[Router.scala 26:15]
  assign in_Q_clock = clock;
  assign in_Q_reset = reset;
  assign in_Q_io_enq_valid = io_in_valid; // @[Router.scala 27:15]
  assign in_Q_io_enq_bits_addr = io_in_bits_addr; // @[Router.scala 27:15]
  assign in_Q_io_enq_bits_inst = io_in_bits_inst; // @[Router.scala 27:15]
  assign in_Q_io_enq_bits_data = io_in_bits_data; // @[Router.scala 27:15]
  assign in_Q_io_enq_bits_src = io_in_bits_src; // @[Router.scala 27:15]
  assign in_Q_io_enq_bits_dst = io_in_bits_dst; // @[Router.scala 27:15]
  assign in_Q_io_enq_bits_msgType = io_in_bits_msgType; // @[Router.scala 27:15]
  assign in_Q_io_deq_ready = _T_5 | _T_7; // @[Router.scala 38:21]
  assign arbiter_clock = clock;
  assign arbiter_io_in_0_valid = cache_in_Q_io_deq_valid; // @[Router.scala 31:20]
  assign arbiter_io_in_0_bits_addr = cache_in_Q_io_deq_bits_addr; // @[Router.scala 31:20]
  assign arbiter_io_in_0_bits_inst = cache_in_Q_io_deq_bits_inst; // @[Router.scala 31:20]
  assign arbiter_io_in_0_bits_data = cache_in_Q_io_deq_bits_data; // @[Router.scala 31:20]
  assign arbiter_io_in_0_bits_src = cache_in_Q_io_deq_bits_src; // @[Router.scala 31:20]
  assign arbiter_io_in_0_bits_dst = cache_in_Q_io_deq_bits_dst; // @[Router.scala 31:20]
  assign arbiter_io_in_0_bits_msgType = cache_in_Q_io_deq_bits_msgType; // @[Router.scala 31:20]
  assign arbiter_io_in_1_valid = in_Q_io_deq_valid & _T_2; // @[Router.scala 37:26]
  assign arbiter_io_in_1_bits_addr = in_Q_io_deq_bits_addr; // @[Router.scala 36:25]
  assign arbiter_io_in_1_bits_inst = in_Q_io_deq_bits_inst; // @[Router.scala 36:25]
  assign arbiter_io_in_1_bits_data = in_Q_io_deq_bits_data; // @[Router.scala 36:25]
  assign arbiter_io_in_1_bits_src = in_Q_io_deq_bits_src; // @[Router.scala 36:25]
  assign arbiter_io_in_1_bits_dst = in_Q_io_deq_bits_dst; // @[Router.scala 36:25]
  assign arbiter_io_in_1_bits_msgType = in_Q_io_deq_bits_msgType; // @[Router.scala 36:25]
  assign arbiter_io_out_ready = io_out_ready; // @[Router.scala 29:10]
endmodule
module Router_1(
  input         clock,
  input         reset,
  output        io_cacheIn_ready,
  input         io_cacheIn_valid,
  input  [31:0] io_cacheIn_bits_addr,
  input  [63:0] io_cacheIn_bits_data,
  input  [2:0]  io_cacheIn_bits_dst,
  input         io_cacheOut_ready,
  output        io_cacheOut_valid,
  output [31:0] io_cacheOut_bits_addr,
  output [7:0]  io_cacheOut_bits_inst,
  output [63:0] io_cacheOut_bits_data,
  output [2:0]  io_cacheOut_bits_src,
  output        io_in_ready,
  input         io_in_valid,
  input  [31:0] io_in_bits_addr,
  input  [7:0]  io_in_bits_inst,
  input  [63:0] io_in_bits_data,
  input  [2:0]  io_in_bits_src,
  input  [2:0]  io_in_bits_dst,
  input  [1:0]  io_in_bits_msgType,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits_addr,
  output [7:0]  io_out_bits_inst,
  output [63:0] io_out_bits_data,
  output [2:0]  io_out_bits_src,
  output [2:0]  io_out_bits_dst,
  output [1:0]  io_out_bits_msgType
);
  wire  cache_in_Q_clock; // @[Router.scala 19:26]
  wire  cache_in_Q_reset; // @[Router.scala 19:26]
  wire  cache_in_Q_io_enq_ready; // @[Router.scala 19:26]
  wire  cache_in_Q_io_enq_valid; // @[Router.scala 19:26]
  wire [31:0] cache_in_Q_io_enq_bits_addr; // @[Router.scala 19:26]
  wire [7:0] cache_in_Q_io_enq_bits_inst; // @[Router.scala 19:26]
  wire [63:0] cache_in_Q_io_enq_bits_data; // @[Router.scala 19:26]
  wire [2:0] cache_in_Q_io_enq_bits_src; // @[Router.scala 19:26]
  wire [2:0] cache_in_Q_io_enq_bits_dst; // @[Router.scala 19:26]
  wire [1:0] cache_in_Q_io_enq_bits_msgType; // @[Router.scala 19:26]
  wire  cache_in_Q_io_deq_ready; // @[Router.scala 19:26]
  wire  cache_in_Q_io_deq_valid; // @[Router.scala 19:26]
  wire [31:0] cache_in_Q_io_deq_bits_addr; // @[Router.scala 19:26]
  wire [7:0] cache_in_Q_io_deq_bits_inst; // @[Router.scala 19:26]
  wire [63:0] cache_in_Q_io_deq_bits_data; // @[Router.scala 19:26]
  wire [2:0] cache_in_Q_io_deq_bits_src; // @[Router.scala 19:26]
  wire [2:0] cache_in_Q_io_deq_bits_dst; // @[Router.scala 19:26]
  wire [1:0] cache_in_Q_io_deq_bits_msgType; // @[Router.scala 19:26]
  wire  cache_out_Q_clock; // @[Router.scala 20:27]
  wire  cache_out_Q_reset; // @[Router.scala 20:27]
  wire  cache_out_Q_io_enq_ready; // @[Router.scala 20:27]
  wire  cache_out_Q_io_enq_valid; // @[Router.scala 20:27]
  wire [31:0] cache_out_Q_io_enq_bits_addr; // @[Router.scala 20:27]
  wire [7:0] cache_out_Q_io_enq_bits_inst; // @[Router.scala 20:27]
  wire [63:0] cache_out_Q_io_enq_bits_data; // @[Router.scala 20:27]
  wire [2:0] cache_out_Q_io_enq_bits_src; // @[Router.scala 20:27]
  wire [2:0] cache_out_Q_io_enq_bits_dst; // @[Router.scala 20:27]
  wire [1:0] cache_out_Q_io_enq_bits_msgType; // @[Router.scala 20:27]
  wire  cache_out_Q_io_deq_ready; // @[Router.scala 20:27]
  wire  cache_out_Q_io_deq_valid; // @[Router.scala 20:27]
  wire [31:0] cache_out_Q_io_deq_bits_addr; // @[Router.scala 20:27]
  wire [7:0] cache_out_Q_io_deq_bits_inst; // @[Router.scala 20:27]
  wire [63:0] cache_out_Q_io_deq_bits_data; // @[Router.scala 20:27]
  wire [2:0] cache_out_Q_io_deq_bits_src; // @[Router.scala 20:27]
  wire [2:0] cache_out_Q_io_deq_bits_dst; // @[Router.scala 20:27]
  wire [1:0] cache_out_Q_io_deq_bits_msgType; // @[Router.scala 20:27]
  wire  in_Q_clock; // @[Router.scala 21:20]
  wire  in_Q_reset; // @[Router.scala 21:20]
  wire  in_Q_io_enq_ready; // @[Router.scala 21:20]
  wire  in_Q_io_enq_valid; // @[Router.scala 21:20]
  wire [31:0] in_Q_io_enq_bits_addr; // @[Router.scala 21:20]
  wire [7:0] in_Q_io_enq_bits_inst; // @[Router.scala 21:20]
  wire [63:0] in_Q_io_enq_bits_data; // @[Router.scala 21:20]
  wire [2:0] in_Q_io_enq_bits_src; // @[Router.scala 21:20]
  wire [2:0] in_Q_io_enq_bits_dst; // @[Router.scala 21:20]
  wire [1:0] in_Q_io_enq_bits_msgType; // @[Router.scala 21:20]
  wire  in_Q_io_deq_ready; // @[Router.scala 21:20]
  wire  in_Q_io_deq_valid; // @[Router.scala 21:20]
  wire [31:0] in_Q_io_deq_bits_addr; // @[Router.scala 21:20]
  wire [7:0] in_Q_io_deq_bits_inst; // @[Router.scala 21:20]
  wire [63:0] in_Q_io_deq_bits_data; // @[Router.scala 21:20]
  wire [2:0] in_Q_io_deq_bits_src; // @[Router.scala 21:20]
  wire [2:0] in_Q_io_deq_bits_dst; // @[Router.scala 21:20]
  wire [1:0] in_Q_io_deq_bits_msgType; // @[Router.scala 21:20]
  wire  arbiter_clock; // @[Router.scala 23:23]
  wire  arbiter_io_in_0_ready; // @[Router.scala 23:23]
  wire  arbiter_io_in_0_valid; // @[Router.scala 23:23]
  wire [31:0] arbiter_io_in_0_bits_addr; // @[Router.scala 23:23]
  wire [7:0] arbiter_io_in_0_bits_inst; // @[Router.scala 23:23]
  wire [63:0] arbiter_io_in_0_bits_data; // @[Router.scala 23:23]
  wire [2:0] arbiter_io_in_0_bits_src; // @[Router.scala 23:23]
  wire [2:0] arbiter_io_in_0_bits_dst; // @[Router.scala 23:23]
  wire [1:0] arbiter_io_in_0_bits_msgType; // @[Router.scala 23:23]
  wire  arbiter_io_in_1_ready; // @[Router.scala 23:23]
  wire  arbiter_io_in_1_valid; // @[Router.scala 23:23]
  wire [31:0] arbiter_io_in_1_bits_addr; // @[Router.scala 23:23]
  wire [7:0] arbiter_io_in_1_bits_inst; // @[Router.scala 23:23]
  wire [63:0] arbiter_io_in_1_bits_data; // @[Router.scala 23:23]
  wire [2:0] arbiter_io_in_1_bits_src; // @[Router.scala 23:23]
  wire [2:0] arbiter_io_in_1_bits_dst; // @[Router.scala 23:23]
  wire [1:0] arbiter_io_in_1_bits_msgType; // @[Router.scala 23:23]
  wire  arbiter_io_out_ready; // @[Router.scala 23:23]
  wire  arbiter_io_out_valid; // @[Router.scala 23:23]
  wire [31:0] arbiter_io_out_bits_addr; // @[Router.scala 23:23]
  wire [7:0] arbiter_io_out_bits_inst; // @[Router.scala 23:23]
  wire [63:0] arbiter_io_out_bits_data; // @[Router.scala 23:23]
  wire [2:0] arbiter_io_out_bits_src; // @[Router.scala 23:23]
  wire [2:0] arbiter_io_out_bits_dst; // @[Router.scala 23:23]
  wire [1:0] arbiter_io_out_bits_msgType; // @[Router.scala 23:23]
  wire  arbiter_io_chosen; // @[Router.scala 23:23]
  wire  _T = in_Q_io_deq_bits_dst == 3'h1; // @[Router.scala 34:74]
  wire  _T_2 = in_Q_io_deq_bits_dst != 3'h1; // @[Router.scala 37:72]
  wire  _T_5 = arbiter_io_in_1_ready & _T_2; // @[Router.scala 38:48]
  wire  _T_7 = cache_out_Q_io_enq_ready & _T; // @[Router.scala 38:113]
  Queue_1 cache_in_Q ( // @[Router.scala 19:26]
    .clock(cache_in_Q_clock),
    .reset(cache_in_Q_reset),
    .io_enq_ready(cache_in_Q_io_enq_ready),
    .io_enq_valid(cache_in_Q_io_enq_valid),
    .io_enq_bits_addr(cache_in_Q_io_enq_bits_addr),
    .io_enq_bits_inst(cache_in_Q_io_enq_bits_inst),
    .io_enq_bits_data(cache_in_Q_io_enq_bits_data),
    .io_enq_bits_src(cache_in_Q_io_enq_bits_src),
    .io_enq_bits_dst(cache_in_Q_io_enq_bits_dst),
    .io_enq_bits_msgType(cache_in_Q_io_enq_bits_msgType),
    .io_deq_ready(cache_in_Q_io_deq_ready),
    .io_deq_valid(cache_in_Q_io_deq_valid),
    .io_deq_bits_addr(cache_in_Q_io_deq_bits_addr),
    .io_deq_bits_inst(cache_in_Q_io_deq_bits_inst),
    .io_deq_bits_data(cache_in_Q_io_deq_bits_data),
    .io_deq_bits_src(cache_in_Q_io_deq_bits_src),
    .io_deq_bits_dst(cache_in_Q_io_deq_bits_dst),
    .io_deq_bits_msgType(cache_in_Q_io_deq_bits_msgType)
  );
  Queue_1 cache_out_Q ( // @[Router.scala 20:27]
    .clock(cache_out_Q_clock),
    .reset(cache_out_Q_reset),
    .io_enq_ready(cache_out_Q_io_enq_ready),
    .io_enq_valid(cache_out_Q_io_enq_valid),
    .io_enq_bits_addr(cache_out_Q_io_enq_bits_addr),
    .io_enq_bits_inst(cache_out_Q_io_enq_bits_inst),
    .io_enq_bits_data(cache_out_Q_io_enq_bits_data),
    .io_enq_bits_src(cache_out_Q_io_enq_bits_src),
    .io_enq_bits_dst(cache_out_Q_io_enq_bits_dst),
    .io_enq_bits_msgType(cache_out_Q_io_enq_bits_msgType),
    .io_deq_ready(cache_out_Q_io_deq_ready),
    .io_deq_valid(cache_out_Q_io_deq_valid),
    .io_deq_bits_addr(cache_out_Q_io_deq_bits_addr),
    .io_deq_bits_inst(cache_out_Q_io_deq_bits_inst),
    .io_deq_bits_data(cache_out_Q_io_deq_bits_data),
    .io_deq_bits_src(cache_out_Q_io_deq_bits_src),
    .io_deq_bits_dst(cache_out_Q_io_deq_bits_dst),
    .io_deq_bits_msgType(cache_out_Q_io_deq_bits_msgType)
  );
  Queue_3 in_Q ( // @[Router.scala 21:20]
    .clock(in_Q_clock),
    .reset(in_Q_reset),
    .io_enq_ready(in_Q_io_enq_ready),
    .io_enq_valid(in_Q_io_enq_valid),
    .io_enq_bits_addr(in_Q_io_enq_bits_addr),
    .io_enq_bits_inst(in_Q_io_enq_bits_inst),
    .io_enq_bits_data(in_Q_io_enq_bits_data),
    .io_enq_bits_src(in_Q_io_enq_bits_src),
    .io_enq_bits_dst(in_Q_io_enq_bits_dst),
    .io_enq_bits_msgType(in_Q_io_enq_bits_msgType),
    .io_deq_ready(in_Q_io_deq_ready),
    .io_deq_valid(in_Q_io_deq_valid),
    .io_deq_bits_addr(in_Q_io_deq_bits_addr),
    .io_deq_bits_inst(in_Q_io_deq_bits_inst),
    .io_deq_bits_data(in_Q_io_deq_bits_data),
    .io_deq_bits_src(in_Q_io_deq_bits_src),
    .io_deq_bits_dst(in_Q_io_deq_bits_dst),
    .io_deq_bits_msgType(in_Q_io_deq_bits_msgType)
  );
  RRArbiter arbiter ( // @[Router.scala 23:23]
    .clock(arbiter_clock),
    .io_in_0_ready(arbiter_io_in_0_ready),
    .io_in_0_valid(arbiter_io_in_0_valid),
    .io_in_0_bits_addr(arbiter_io_in_0_bits_addr),
    .io_in_0_bits_inst(arbiter_io_in_0_bits_inst),
    .io_in_0_bits_data(arbiter_io_in_0_bits_data),
    .io_in_0_bits_src(arbiter_io_in_0_bits_src),
    .io_in_0_bits_dst(arbiter_io_in_0_bits_dst),
    .io_in_0_bits_msgType(arbiter_io_in_0_bits_msgType),
    .io_in_1_ready(arbiter_io_in_1_ready),
    .io_in_1_valid(arbiter_io_in_1_valid),
    .io_in_1_bits_addr(arbiter_io_in_1_bits_addr),
    .io_in_1_bits_inst(arbiter_io_in_1_bits_inst),
    .io_in_1_bits_data(arbiter_io_in_1_bits_data),
    .io_in_1_bits_src(arbiter_io_in_1_bits_src),
    .io_in_1_bits_dst(arbiter_io_in_1_bits_dst),
    .io_in_1_bits_msgType(arbiter_io_in_1_bits_msgType),
    .io_out_ready(arbiter_io_out_ready),
    .io_out_valid(arbiter_io_out_valid),
    .io_out_bits_addr(arbiter_io_out_bits_addr),
    .io_out_bits_inst(arbiter_io_out_bits_inst),
    .io_out_bits_data(arbiter_io_out_bits_data),
    .io_out_bits_src(arbiter_io_out_bits_src),
    .io_out_bits_dst(arbiter_io_out_bits_dst),
    .io_out_bits_msgType(arbiter_io_out_bits_msgType),
    .io_chosen(arbiter_io_chosen)
  );
  assign io_cacheIn_ready = cache_in_Q_io_enq_ready; // @[Router.scala 25:21]
  assign io_cacheOut_valid = cache_out_Q_io_deq_valid; // @[Router.scala 26:15]
  assign io_cacheOut_bits_addr = cache_out_Q_io_deq_bits_addr; // @[Router.scala 26:15]
  assign io_cacheOut_bits_inst = cache_out_Q_io_deq_bits_inst; // @[Router.scala 26:15]
  assign io_cacheOut_bits_data = cache_out_Q_io_deq_bits_data; // @[Router.scala 26:15]
  assign io_cacheOut_bits_src = cache_out_Q_io_deq_bits_src; // @[Router.scala 26:15]
  assign io_in_ready = in_Q_io_enq_ready; // @[Router.scala 27:15]
  assign io_out_valid = arbiter_io_out_valid; // @[Router.scala 29:10]
  assign io_out_bits_addr = arbiter_io_out_bits_addr; // @[Router.scala 29:10]
  assign io_out_bits_inst = arbiter_io_out_bits_inst; // @[Router.scala 29:10]
  assign io_out_bits_data = arbiter_io_out_bits_data; // @[Router.scala 29:10]
  assign io_out_bits_src = arbiter_io_out_bits_src; // @[Router.scala 29:10]
  assign io_out_bits_dst = arbiter_io_out_bits_dst; // @[Router.scala 29:10]
  assign io_out_bits_msgType = arbiter_io_out_bits_msgType; // @[Router.scala 29:10]
  assign cache_in_Q_clock = clock;
  assign cache_in_Q_reset = reset;
  assign cache_in_Q_io_enq_valid = io_cacheIn_valid; // @[Router.scala 25:21]
  assign cache_in_Q_io_enq_bits_addr = io_cacheIn_bits_addr; // @[Router.scala 25:21]
  assign cache_in_Q_io_enq_bits_inst = 8'h2; // @[Router.scala 25:21]
  assign cache_in_Q_io_enq_bits_data = io_cacheIn_bits_data; // @[Router.scala 25:21]
  assign cache_in_Q_io_enq_bits_src = 3'h1; // @[Router.scala 25:21]
  assign cache_in_Q_io_enq_bits_dst = io_cacheIn_bits_dst; // @[Router.scala 25:21]
  assign cache_in_Q_io_enq_bits_msgType = 2'h0; // @[Router.scala 25:21]
  assign cache_in_Q_io_deq_ready = arbiter_io_in_0_ready; // @[Router.scala 31:20]
  assign cache_out_Q_clock = clock;
  assign cache_out_Q_reset = reset;
  assign cache_out_Q_io_enq_valid = in_Q_io_deq_valid & _T; // @[Router.scala 34:28]
  assign cache_out_Q_io_enq_bits_addr = in_Q_io_deq_bits_addr; // @[Router.scala 33:27]
  assign cache_out_Q_io_enq_bits_inst = in_Q_io_deq_bits_inst; // @[Router.scala 33:27]
  assign cache_out_Q_io_enq_bits_data = in_Q_io_deq_bits_data; // @[Router.scala 33:27]
  assign cache_out_Q_io_enq_bits_src = in_Q_io_deq_bits_src; // @[Router.scala 33:27]
  assign cache_out_Q_io_enq_bits_dst = in_Q_io_deq_bits_dst; // @[Router.scala 33:27]
  assign cache_out_Q_io_enq_bits_msgType = in_Q_io_deq_bits_msgType; // @[Router.scala 33:27]
  assign cache_out_Q_io_deq_ready = io_cacheOut_ready; // @[Router.scala 26:15]
  assign in_Q_clock = clock;
  assign in_Q_reset = reset;
  assign in_Q_io_enq_valid = io_in_valid; // @[Router.scala 27:15]
  assign in_Q_io_enq_bits_addr = io_in_bits_addr; // @[Router.scala 27:15]
  assign in_Q_io_enq_bits_inst = io_in_bits_inst; // @[Router.scala 27:15]
  assign in_Q_io_enq_bits_data = io_in_bits_data; // @[Router.scala 27:15]
  assign in_Q_io_enq_bits_src = io_in_bits_src; // @[Router.scala 27:15]
  assign in_Q_io_enq_bits_dst = io_in_bits_dst; // @[Router.scala 27:15]
  assign in_Q_io_enq_bits_msgType = io_in_bits_msgType; // @[Router.scala 27:15]
  assign in_Q_io_deq_ready = _T_5 | _T_7; // @[Router.scala 38:21]
  assign arbiter_clock = clock;
  assign arbiter_io_in_0_valid = cache_in_Q_io_deq_valid; // @[Router.scala 31:20]
  assign arbiter_io_in_0_bits_addr = cache_in_Q_io_deq_bits_addr; // @[Router.scala 31:20]
  assign arbiter_io_in_0_bits_inst = cache_in_Q_io_deq_bits_inst; // @[Router.scala 31:20]
  assign arbiter_io_in_0_bits_data = cache_in_Q_io_deq_bits_data; // @[Router.scala 31:20]
  assign arbiter_io_in_0_bits_src = cache_in_Q_io_deq_bits_src; // @[Router.scala 31:20]
  assign arbiter_io_in_0_bits_dst = cache_in_Q_io_deq_bits_dst; // @[Router.scala 31:20]
  assign arbiter_io_in_0_bits_msgType = cache_in_Q_io_deq_bits_msgType; // @[Router.scala 31:20]
  assign arbiter_io_in_1_valid = in_Q_io_deq_valid & _T_2; // @[Router.scala 37:26]
  assign arbiter_io_in_1_bits_addr = in_Q_io_deq_bits_addr; // @[Router.scala 36:25]
  assign arbiter_io_in_1_bits_inst = in_Q_io_deq_bits_inst; // @[Router.scala 36:25]
  assign arbiter_io_in_1_bits_data = in_Q_io_deq_bits_data; // @[Router.scala 36:25]
  assign arbiter_io_in_1_bits_src = in_Q_io_deq_bits_src; // @[Router.scala 36:25]
  assign arbiter_io_in_1_bits_dst = in_Q_io_deq_bits_dst; // @[Router.scala 36:25]
  assign arbiter_io_in_1_bits_msgType = in_Q_io_deq_bits_msgType; // @[Router.scala 36:25]
  assign arbiter_io_out_ready = io_out_ready; // @[Router.scala 29:10]
endmodule
module bipassLD(
  input         clock,
  input         reset,
  input         io_in_valid,
  input  [31:0] io_in_bits_addr,
  input  [2:0]  io_in_bits_way,
  output        io_dataMem_in_valid,
  output [31:0] io_dataMem_in_bits_address,
  input  [63:0] io_dataMem_outputValue_0,
  output        io_out_valid,
  output [63:0] io_out_bits_data
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [5:0] set = io_in_bits_addr[5:0]; // @[Gem5CacheLogic.scala 85:19]
  reg [63:0] dataRead_0; // @[elements.scala 323:27]
  wire [7:0] _T_1 = set * 6'h2; // @[elements.scala 327:39]
  wire [7:0] _GEN_0 = {{5'd0}, io_in_bits_way}; // @[elements.scala 327:49]
  wire [7:0] _T_3 = _T_1 + _GEN_0; // @[elements.scala 327:49]
  reg  _T_4; // @[elements.scala 331:28]
  assign io_dataMem_in_valid = io_in_valid; // @[elements.scala 325:25]
  assign io_dataMem_in_bits_address = {{24'd0}, _T_3}; // @[elements.scala 327:32]
  assign io_out_valid = _T_4; // @[elements.scala 331:18]
  assign io_out_bits_data = dataRead_0; // @[elements.scala 332:23]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  dataRead_0 = _RAND_0[63:0];
  _RAND_1 = {1{`RANDOM}};
  _T_4 = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      dataRead_0 <= 64'h0;
    end else begin
      dataRead_0 <= io_dataMem_outputValue_0;
    end
    _T_4 <= io_in_valid;
  end
endmodule
module MemBank(
  input         clock,
  input         io_read_in_valid,
  input  [31:0] io_read_in_bits_address,
  output [63:0] io_read_outputValue_0,
  input         io_write_valid,
  input  [31:0] io_write_bits_address,
  input  [63:0] io_write_bits_inputValue_0
);
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [63:0] mems_0 [0:127]; // @[BankedMemory.scala 40:8]
  wire [63:0] mems_0__T_1_data; // @[BankedMemory.scala 40:8]
  wire [6:0] mems_0__T_1_addr; // @[BankedMemory.scala 40:8]
  wire [63:0] mems_0__T_5_data; // @[BankedMemory.scala 40:8]
  wire [6:0] mems_0__T_5_addr; // @[BankedMemory.scala 40:8]
  wire  mems_0__T_5_mask; // @[BankedMemory.scala 40:8]
  wire  mems_0__T_5_en; // @[BankedMemory.scala 40:8]
  assign mems_0__T_1_addr = io_read_in_bits_address[6:0];
  assign mems_0__T_1_data = mems_0[mems_0__T_1_addr]; // @[BankedMemory.scala 40:8]
  assign mems_0__T_5_data = io_write_bits_inputValue_0;
  assign mems_0__T_5_addr = io_write_bits_address[6:0];
  assign mems_0__T_5_mask = 1'h1;
  assign mems_0__T_5_en = io_write_valid;
  assign io_read_outputValue_0 = mems_0__T_1_data; // @[BankedMemory.scala 46:42]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    mems_0[initvar] = _RAND_0[63:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(mems_0__T_5_en & mems_0__T_5_mask) begin
      mems_0[mems_0__T_5_addr] <= mems_0__T_5_data; // @[BankedMemory.scala 40:8]
    end
  end
endmodule
module MemBank_1(
  input         clock,
  input         io_read_in_valid,
  input  [5:0]  io_read_in_bits_address,
  output [25:0] io_read_outputValue_0_tag,
  output [25:0] io_read_outputValue_1_tag,
  input         io_write_valid,
  input  [1:0]  io_write_bits_bank,
  input  [5:0]  io_write_bits_address,
  input  [25:0] io_write_bits_inputValue_0_tag,
  input  [25:0] io_write_bits_inputValue_1_tag
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_MEM_INIT
  reg [25:0] mems_0_tag [0:63]; // @[BankedMemory.scala 40:8]
  wire [25:0] mems_0_tag__T_data; // @[BankedMemory.scala 40:8]
  wire [5:0] mems_0_tag__T_addr; // @[BankedMemory.scala 40:8]
  wire [25:0] mems_0_tag__T_5_data; // @[BankedMemory.scala 40:8]
  wire [5:0] mems_0_tag__T_5_addr; // @[BankedMemory.scala 40:8]
  wire  mems_0_tag__T_5_mask; // @[BankedMemory.scala 40:8]
  wire  mems_0_tag__T_5_en; // @[BankedMemory.scala 40:8]
  reg [25:0] mems_1_tag [0:63]; // @[BankedMemory.scala 40:8]
  wire [25:0] mems_1_tag__T_1_data; // @[BankedMemory.scala 40:8]
  wire [5:0] mems_1_tag__T_1_addr; // @[BankedMemory.scala 40:8]
  wire [25:0] mems_1_tag__T_9_data; // @[BankedMemory.scala 40:8]
  wire [5:0] mems_1_tag__T_9_addr; // @[BankedMemory.scala 40:8]
  wire  mems_1_tag__T_9_mask; // @[BankedMemory.scala 40:8]
  wire  mems_1_tag__T_9_en; // @[BankedMemory.scala 40:8]
  wire  _GEN_17 = io_write_bits_bank[0] ? 1'h0 : io_write_bits_bank[1]; // @[BankedMemory.scala 57:82]
  assign mems_0_tag__T_addr = io_read_in_bits_address;
  assign mems_0_tag__T_data = mems_0_tag[mems_0_tag__T_addr]; // @[BankedMemory.scala 40:8]
  assign mems_0_tag__T_5_data = io_write_bits_inputValue_0_tag;
  assign mems_0_tag__T_5_addr = io_write_bits_address;
  assign mems_0_tag__T_5_mask = 1'h1;
  assign mems_0_tag__T_5_en = io_write_valid & io_write_bits_bank[0];
  assign mems_1_tag__T_1_addr = io_read_in_bits_address;
  assign mems_1_tag__T_1_data = mems_1_tag[mems_1_tag__T_1_addr]; // @[BankedMemory.scala 40:8]
  assign mems_1_tag__T_9_data = io_write_bits_inputValue_1_tag;
  assign mems_1_tag__T_9_addr = io_write_bits_address;
  assign mems_1_tag__T_9_mask = 1'h1;
  assign mems_1_tag__T_9_en = io_write_valid & _GEN_17;
  assign io_read_outputValue_0_tag = mems_0_tag__T_data; // @[BankedMemory.scala 46:42]
  assign io_read_outputValue_1_tag = mems_1_tag__T_1_data; // @[BankedMemory.scala 46:42]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 64; initvar = initvar+1)
    mems_0_tag[initvar] = _RAND_0[25:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 64; initvar = initvar+1)
    mems_1_tag[initvar] = _RAND_1[25:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(mems_0_tag__T_5_en & mems_0_tag__T_5_mask) begin
      mems_0_tag[mems_0_tag__T_5_addr] <= mems_0_tag__T_5_data; // @[BankedMemory.scala 40:8]
    end
    if(mems_1_tag__T_9_en & mems_1_tag__T_9_mask) begin
      mems_1_tag[mems_1_tag__T_9_addr] <= mems_1_tag__T_9_data; // @[BankedMemory.scala 40:8]
    end
  end
endmodule
module Decoder(
  input  [27:0] io_inAction,
  output        io_outSignals_0,
  output        io_outSignals_1,
  output        io_outSignals_2,
  output        io_outSignals_3,
  output        io_outSignals_4,
  output        io_outSignals_5,
  output        io_outSignals_6,
  output        io_outSignals_7,
  output        io_outSignals_8
);
  assign io_outSignals_0 = io_inAction[0]; // @[elements.scala 21:19]
  assign io_outSignals_1 = io_inAction[1]; // @[elements.scala 21:19]
  assign io_outSignals_2 = io_inAction[2]; // @[elements.scala 21:19]
  assign io_outSignals_3 = io_inAction[3]; // @[elements.scala 21:19]
  assign io_outSignals_4 = io_inAction[4]; // @[elements.scala 21:19]
  assign io_outSignals_5 = io_inAction[5]; // @[elements.scala 21:19]
  assign io_outSignals_6 = io_inAction[6]; // @[elements.scala 21:19]
  assign io_outSignals_7 = io_inAction[7]; // @[elements.scala 21:19]
  assign io_outSignals_8 = io_inAction[8]; // @[elements.scala 21:19]
endmodule
module FindEmptyLine(
  input   io_data_0,
  input   io_data_1,
  output  io_value_valid
);
  wire  _T = ~io_data_0; // @[elements.scala 74:53]
  wire  _T_1 = ~io_data_1; // @[elements.scala 74:53]
  assign io_value_valid = _T | _T_1; // @[elements.scala 68:20 elements.scala 76:32 elements.scala 76:32]
endmodule
module Find(
  input  [25:0] io_key_tag,
  input  [25:0] io_data_0_tag,
  input  [25:0] io_data_1_tag,
  input         io_valid_0,
  input         io_valid_1,
  output        io_value_valid,
  output [31:0] io_value_bits
);
  wire  _T = io_data_0_tag == io_key_tag; // @[elements.scala 35:54]
  wire  _T_1 = io_data_1_tag == io_key_tag; // @[elements.scala 35:54]
  wire [1:0] bitmap = {_T_1,_T}; // @[Cat.scala 29:58]
  wire [1:0] _T_3 = {io_valid_1,io_valid_0}; // @[elements.scala 36:46]
  wire [1:0] _T_4 = bitmap & _T_3; // @[elements.scala 36:29]
  assign io_value_valid = _T_4 != 2'h0; // @[elements.scala 39:20]
  assign io_value_bits = {{31'd0}, _T_4[1]}; // @[elements.scala 38:19]
endmodule
module Gem5CacheLogic(
  input         clock,
  input         reset,
  output        io_cpu_req_ready,
  input         io_cpu_req_valid,
  input  [31:0] io_cpu_req_bits_addr,
  input  [63:0] io_cpu_req_bits_data,
  input  [27:0] io_cpu_req_bits_command,
  input  [1:0]  io_cpu_req_bits_way,
  input  [1:0]  io_cpu_req_bits_replaceWay,
  output        io_cpu_resp_valid,
  output        io_cpu_resp_bits_iswrite,
  output [1:0]  io_cpu_resp_bits_way,
  output        io_metaMem_write_valid,
  output [1:0]  io_metaMem_write_bits_bank,
  output [5:0]  io_metaMem_write_bits_address,
  output [25:0] io_metaMem_write_bits_inputValue_0_tag,
  output [25:0] io_metaMem_write_bits_inputValue_1_tag,
  output        io_dataMem_write_valid,
  output [31:0] io_dataMem_write_bits_address,
  output [63:0] io_dataMem_write_bits_inputValue_0,
  output        io_validTagBits_write_valid,
  output [63:0] io_validTagBits_write_bits_addr,
  output        io_validTagBits_write_bits_value,
  output        io_validTagBits_read_in_valid,
  output [63:0] io_validTagBits_read_in_bits_addr,
  input         io_validTagBits_read_out_0,
  input         io_validTagBits_read_out_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
`endif // RANDOMIZE_REG_INIT
  wire [27:0] decoder_io_inAction; // @[Gem5CacheLogic.scala 176:23]
  wire  decoder_io_outSignals_0; // @[Gem5CacheLogic.scala 176:23]
  wire  decoder_io_outSignals_1; // @[Gem5CacheLogic.scala 176:23]
  wire  decoder_io_outSignals_2; // @[Gem5CacheLogic.scala 176:23]
  wire  decoder_io_outSignals_3; // @[Gem5CacheLogic.scala 176:23]
  wire  decoder_io_outSignals_4; // @[Gem5CacheLogic.scala 176:23]
  wire  decoder_io_outSignals_5; // @[Gem5CacheLogic.scala 176:23]
  wire  decoder_io_outSignals_6; // @[Gem5CacheLogic.scala 176:23]
  wire  decoder_io_outSignals_7; // @[Gem5CacheLogic.scala 176:23]
  wire  decoder_io_outSignals_8; // @[Gem5CacheLogic.scala 176:23]
  wire  emptyLine_io_data_0; // @[Gem5CacheLogic.scala 347:25]
  wire  emptyLine_io_data_1; // @[Gem5CacheLogic.scala 347:25]
  wire  emptyLine_io_value_valid; // @[Gem5CacheLogic.scala 347:25]
  wire [25:0] tagFinder_io_key_tag; // @[Gem5CacheLogic.scala 350:25]
  wire [25:0] tagFinder_io_data_0_tag; // @[Gem5CacheLogic.scala 350:25]
  wire [25:0] tagFinder_io_data_1_tag; // @[Gem5CacheLogic.scala 350:25]
  wire  tagFinder_io_valid_0; // @[Gem5CacheLogic.scala 350:25]
  wire  tagFinder_io_valid_1; // @[Gem5CacheLogic.scala 350:25]
  wire  tagFinder_io_value_valid; // @[Gem5CacheLogic.scala 350:25]
  wire [31:0] tagFinder_io_value_bits; // @[Gem5CacheLogic.scala 350:25]
  reg [31:0] addr_reg; // @[Gem5CacheLogic.scala 190:25]
  reg [63:0] cpu_data; // @[Gem5CacheLogic.scala 191:25]
  reg [27:0] cpu_command; // @[Gem5CacheLogic.scala 193:28]
  reg [25:0] tag; // @[Gem5CacheLogic.scala 195:20]
  reg [5:0] set; // @[Gem5CacheLogic.scala 196:20]
  reg [2:0] wayInput; // @[Gem5CacheLogic.scala 197:25]
  reg [2:0] replaceWayInput; // @[Gem5CacheLogic.scala 198:32]
  wire  _T_3 = io_cpu_req_ready & io_cpu_req_valid; // @[Decoupled.scala 40:37]
  wire [6:0] _GEN_47 = {{1'd0}, set}; // @[Gem5CacheLogic.scala 277:41]
  wire [12:0] _T_6 = _GEN_47 * 7'h40; // @[Gem5CacheLogic.scala 277:41]
  wire  signals_2 = decoder_io_outSignals_2; // @[Gem5CacheLogic.scala 216:21 Gem5CacheLogic.scala 287:11]
  wire  wayInvalid = wayInput == 3'h2; // @[Gem5CacheLogic.scala 339:27]
  wire  _T_28 = ~wayInvalid; // @[Gem5CacheLogic.scala 366:14]
  wire [2:0] _GEN_15 = _T_28 ? wayInput : 3'h2; // @[Gem5CacheLogic.scala 366:26]
  wire [2:0] way = signals_2 ? replaceWayInput : _GEN_15; // @[Gem5CacheLogic.scala 364:23]
  wire [12:0] _GEN_48 = {{10'd0}, way}; // @[Gem5CacheLogic.scala 277:51]
  wire [12:0] _T_8 = _T_6 + _GEN_48; // @[Gem5CacheLogic.scala 277:51]
  wire  signals_1 = decoder_io_outSignals_1; // @[Gem5CacheLogic.scala 216:21 Gem5CacheLogic.scala 287:11]
  wire  signals_0 = decoder_io_outSignals_0; // @[Gem5CacheLogic.scala 216:21 Gem5CacheLogic.scala 287:11]
  wire  _T_23 = signals_1 & signals_0; // @[Gem5CacheLogic.scala 355:37]
  wire  _T_24 = signals_2 | _T_23; // @[Gem5CacheLogic.scala 355:21]
  wire [7:0] _T_25 = set * 6'h2; // @[Gem5CacheLogic.scala 356:46]
  wire [7:0] _GEN_14 = _T_24 ? _T_25 : 8'h0; // @[Gem5CacheLogic.scala 355:53]
  wire [7:0] _T_29 = 8'h1 << way; // @[Gem5CacheLogic.scala 326:34]
  wire  signals_4 = decoder_io_outSignals_4; // @[Gem5CacheLogic.scala 216:21 Gem5CacheLogic.scala 287:11]
  wire  signals_3 = decoder_io_outSignals_3; // @[Gem5CacheLogic.scala 216:21 Gem5CacheLogic.scala 287:11]
  wire [7:0] _GEN_53 = {{5'd0}, way}; // @[Gem5CacheLogic.scala 391:50]
  wire [7:0] _T_44 = _T_25 + _GEN_53; // @[Gem5CacheLogic.scala 391:50]
  wire [31:0] _T_47 = tagFinder_io_value_valid ? tagFinder_io_value_bits : 32'h2; // @[Gem5CacheLogic.scala 412:25]
  wire [2:0] _GEN_41 = signals_2 ? way : 3'h2; // @[Gem5CacheLogic.scala 413:28]
  wire [31:0] _GEN_43 = _T_23 ? _T_47 : {{29'd0}, _GEN_41}; // @[Gem5CacheLogic.scala 411:39]
  wire  signals_5 = decoder_io_outSignals_5; // @[Gem5CacheLogic.scala 216:21 Gem5CacheLogic.scala 287:11]
  wire  signals_6 = decoder_io_outSignals_6; // @[Gem5CacheLogic.scala 216:21 Gem5CacheLogic.scala 287:11]
  wire  _T_52 = ~signals_6; // @[Gem5CacheLogic.scala 434:50]
  reg  _T_54; // @[Gem5CacheLogic.scala 443:38]
  reg  _T_57; // @[Gem5CacheLogic.scala 444:81]
  wire  _T_59 = ~emptyLine_io_value_valid; // @[Gem5CacheLogic.scala 448:26]
  wire  _T_60 = signals_2 & _T_59; // @[Gem5CacheLogic.scala 448:23]
  wire  _T_62 = ~reset; // @[Gem5CacheLogic.scala 449:13]
  wire [2:0] targetWayWire = _GEN_43[2:0]; // @[Gem5CacheLogic.scala 412:19 Gem5CacheLogic.scala 414:19]
  Decoder decoder ( // @[Gem5CacheLogic.scala 176:23]
    .io_inAction(decoder_io_inAction),
    .io_outSignals_0(decoder_io_outSignals_0),
    .io_outSignals_1(decoder_io_outSignals_1),
    .io_outSignals_2(decoder_io_outSignals_2),
    .io_outSignals_3(decoder_io_outSignals_3),
    .io_outSignals_4(decoder_io_outSignals_4),
    .io_outSignals_5(decoder_io_outSignals_5),
    .io_outSignals_6(decoder_io_outSignals_6),
    .io_outSignals_7(decoder_io_outSignals_7),
    .io_outSignals_8(decoder_io_outSignals_8)
  );
  FindEmptyLine emptyLine ( // @[Gem5CacheLogic.scala 347:25]
    .io_data_0(emptyLine_io_data_0),
    .io_data_1(emptyLine_io_data_1),
    .io_value_valid(emptyLine_io_value_valid)
  );
  Find tagFinder ( // @[Gem5CacheLogic.scala 350:25]
    .io_key_tag(tagFinder_io_key_tag),
    .io_data_0_tag(tagFinder_io_data_0_tag),
    .io_data_1_tag(tagFinder_io_data_1_tag),
    .io_valid_0(tagFinder_io_valid_0),
    .io_valid_1(tagFinder_io_valid_1),
    .io_value_valid(tagFinder_io_value_valid),
    .io_value_bits(tagFinder_io_value_bits)
  );
  assign io_cpu_req_ready = 1'h1; // @[Gem5CacheLogic.scala 290:20]
  assign io_cpu_resp_valid = _T_24 | _T_57; // @[Gem5CacheLogic.scala 444:24]
  assign io_cpu_resp_bits_iswrite = _T_54; // @[Gem5CacheLogic.scala 443:28]
  assign io_cpu_resp_bits_way = targetWayWire[1:0]; // @[Gem5CacheLogic.scala 441:24]
  assign io_metaMem_write_valid = signals_3 ? 1'h0 : signals_4; // @[Gem5CacheLogic.scala 334:26 Gem5CacheLogic.scala 318:19]
  assign io_metaMem_write_bits_bank = _T_29[1:0]; // @[Gem5CacheLogic.scala 326:27]
  assign io_metaMem_write_bits_address = set; // @[Gem5CacheLogic.scala 327:30]
  assign io_metaMem_write_bits_inputValue_0_tag = tag; // @[Gem5CacheLogic.scala 406:45]
  assign io_metaMem_write_bits_inputValue_1_tag = tag; // @[Gem5CacheLogic.scala 406:45]
  assign io_dataMem_write_valid = decoder_io_outSignals_7; // @[Gem5CacheLogic.scala 335:26 Gem5CacheLogic.scala 318:19]
  assign io_dataMem_write_bits_address = {{19'd0}, _T_8}; // @[Gem5CacheLogic.scala 322:30]
  assign io_dataMem_write_bits_inputValue_0 = cpu_data; // @[Gem5CacheLogic.scala 385:38]
  assign io_validTagBits_write_valid = signals_5 | signals_6; // @[Gem5CacheLogic.scala 433:31]
  assign io_validTagBits_write_bits_addr = {{56'd0}, _T_44}; // @[Gem5CacheLogic.scala 432:35]
  assign io_validTagBits_write_bits_value = signals_5 | _T_52; // @[Gem5CacheLogic.scala 434:36]
  assign io_validTagBits_read_in_valid = signals_2 | _T_23; // @[Gem5CacheLogic.scala 361:33]
  assign io_validTagBits_read_in_bits_addr = {{56'd0}, _GEN_14}; // @[Gem5CacheLogic.scala 356:39 Gem5CacheLogic.scala 358:39]
  assign decoder_io_inAction = cpu_command; // @[Gem5CacheLogic.scala 286:23]
  assign emptyLine_io_data_0 = io_validTagBits_read_out_0; // @[Gem5CacheLogic.scala 348:21]
  assign emptyLine_io_data_1 = io_validTagBits_read_out_1; // @[Gem5CacheLogic.scala 348:21]
  assign tagFinder_io_key_tag = tag; // @[Gem5CacheLogic.scala 351:20]
  assign tagFinder_io_data_0_tag = 26'h0; // @[Gem5CacheLogic.scala 352:21]
  assign tagFinder_io_data_1_tag = 26'h0; // @[Gem5CacheLogic.scala 352:21]
  assign tagFinder_io_valid_0 = io_validTagBits_read_out_0; // @[Gem5CacheLogic.scala 353:22]
  assign tagFinder_io_valid_1 = io_validTagBits_read_out_1; // @[Gem5CacheLogic.scala 353:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  addr_reg = _RAND_0[31:0];
  _RAND_1 = {2{`RANDOM}};
  cpu_data = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  cpu_command = _RAND_2[27:0];
  _RAND_3 = {1{`RANDOM}};
  tag = _RAND_3[25:0];
  _RAND_4 = {1{`RANDOM}};
  set = _RAND_4[5:0];
  _RAND_5 = {1{`RANDOM}};
  wayInput = _RAND_5[2:0];
  _RAND_6 = {1{`RANDOM}};
  replaceWayInput = _RAND_6[2:0];
  _RAND_7 = {1{`RANDOM}};
  _T_54 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  _T_57 = _RAND_8[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      addr_reg <= 32'h0;
    end else if (_T_3) begin
      addr_reg <= io_cpu_req_bits_addr;
    end
    if (reset) begin
      cpu_data <= 64'h0;
    end else if (_T_3) begin
      cpu_data <= io_cpu_req_bits_data;
    end
    if (reset) begin
      cpu_command <= 28'h0;
    end else if (_T_3) begin
      cpu_command <= io_cpu_req_bits_command;
    end
    if (reset) begin
      tag <= 26'h0;
    end else if (_T_3) begin
      tag <= io_cpu_req_bits_addr[31:6];
    end
    if (reset) begin
      set <= 6'h0;
    end else if (_T_3) begin
      set <= io_cpu_req_bits_addr[5:0];
    end
    if (reset) begin
      wayInput <= 3'h2;
    end else if (_T_3) begin
      wayInput <= {{1'd0}, io_cpu_req_bits_way};
    end
    if (reset) begin
      replaceWayInput <= 3'h2;
    end else if (_T_3) begin
      replaceWayInput <= {{1'd0}, io_cpu_req_bits_replaceWay};
    end
    _T_54 <= decoder_io_outSignals_8;
    _T_57 <= decoder_io_outSignals_8;
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_60 & _T_62) begin
          $fwrite(32'h80000002,"Replacement in Set: %d, Way: %d, Addr: %d\n",set,way,addr_reg); // @[Gem5CacheLogic.scala 449:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module FindMultiLine(
  input  [25:0] io_key_tag,
  input  [25:0] io_data_0_tag,
  input  [25:0] io_data_1_tag,
  output        io_value_bits_0,
  output        io_value_bits_1
);
  wire  _T = io_data_0_tag == io_key_tag; // @[elements.scala 54:54]
  wire  _T_1 = io_data_1_tag == io_key_tag; // @[elements.scala 54:54]
  wire [1:0] bitmap = {_T_1,_T}; // @[Cat.scala 29:58]
  assign io_value_bits_0 = bitmap[0]; // @[elements.scala 57:19]
  assign io_value_bits_1 = bitmap[1]; // @[elements.scala 57:19]
endmodule
module ProbeUnit(
  input         clock,
  input         reset,
  output        io_cpu_req_ready,
  input         io_cpu_req_valid,
  input  [31:0] io_cpu_req_bits_addr,
  input  [27:0] io_cpu_req_bits_command,
  output        io_cpu_resp_valid,
  output [1:0]  io_cpu_resp_bits_way,
  output        io_cpu_multiWay_valid,
  output [1:0]  io_cpu_multiWay_bits_way_0,
  output [1:0]  io_cpu_multiWay_bits_way_1,
  output [31:0] io_cpu_multiWay_bits_addr,
  output        io_metaMem_read_in_valid,
  output [5:0]  io_metaMem_read_in_bits_address,
  input  [25:0] io_metaMem_read_outputValue_0_tag,
  input  [25:0] io_metaMem_read_outputValue_1_tag,
  output        io_validTagBits_write_valid,
  output [63:0] io_validTagBits_write_bits_addr,
  output        io_validTagBits_write_bits_value,
  output        io_validTagBits_read_in_valid,
  output [63:0] io_validTagBits_read_in_bits_addr,
  input         io_validTagBits_read_out_0,
  input         io_validTagBits_read_out_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  wire [27:0] decoder_io_inAction; // @[ProbeUnit.scala 48:23]
  wire  decoder_io_outSignals_0; // @[ProbeUnit.scala 48:23]
  wire  decoder_io_outSignals_1; // @[ProbeUnit.scala 48:23]
  wire  decoder_io_outSignals_2; // @[ProbeUnit.scala 48:23]
  wire  decoder_io_outSignals_3; // @[ProbeUnit.scala 48:23]
  wire  decoder_io_outSignals_4; // @[ProbeUnit.scala 48:23]
  wire  decoder_io_outSignals_5; // @[ProbeUnit.scala 48:23]
  wire  decoder_io_outSignals_6; // @[ProbeUnit.scala 48:23]
  wire  decoder_io_outSignals_7; // @[ProbeUnit.scala 48:23]
  wire  decoder_io_outSignals_8; // @[ProbeUnit.scala 48:23]
  wire  emptyLine_io_data_0; // @[ProbeUnit.scala 217:25]
  wire  emptyLine_io_data_1; // @[ProbeUnit.scala 217:25]
  wire  emptyLine_io_value_valid; // @[ProbeUnit.scala 217:25]
  wire [25:0] multiTagFinder_io_key_tag; // @[ProbeUnit.scala 220:30]
  wire [25:0] multiTagFinder_io_data_0_tag; // @[ProbeUnit.scala 220:30]
  wire [25:0] multiTagFinder_io_data_1_tag; // @[ProbeUnit.scala 220:30]
  wire  multiTagFinder_io_value_bits_0; // @[ProbeUnit.scala 220:30]
  wire  multiTagFinder_io_value_bits_1; // @[ProbeUnit.scala 220:30]
  wire [25:0] tagFinder_io_key_tag; // @[ProbeUnit.scala 221:25]
  wire [25:0] tagFinder_io_data_0_tag; // @[ProbeUnit.scala 221:25]
  wire [25:0] tagFinder_io_data_1_tag; // @[ProbeUnit.scala 221:25]
  wire  tagFinder_io_valid_0; // @[ProbeUnit.scala 221:25]
  wire  tagFinder_io_valid_1; // @[ProbeUnit.scala 221:25]
  wire  tagFinder_io_value_valid; // @[ProbeUnit.scala 221:25]
  wire [31:0] tagFinder_io_value_bits; // @[ProbeUnit.scala 221:25]
  reg [31:0] addr_reg; // @[ProbeUnit.scala 61:25]
  reg [27:0] cpu_command; // @[ProbeUnit.scala 64:28]
  reg [25:0] tag; // @[ProbeUnit.scala 66:20]
  reg [5:0] set; // @[ProbeUnit.scala 67:20]
  reg [2:0] wayInput; // @[ProbeUnit.scala 68:25]
  reg [2:0] replaceWayInput; // @[ProbeUnit.scala 69:32]
  wire  _T_4 = io_cpu_req_ready & io_cpu_req_valid; // @[Decoupled.scala 40:37]
  wire  signals_2 = decoder_io_outSignals_2; // @[ProbeUnit.scala 87:21 ProbeUnit.scala 156:11]
  wire  wayInvalid = wayInput == 3'h2; // @[ProbeUnit.scala 209:27]
  wire  _T_30 = ~wayInvalid; // @[ProbeUnit.scala 245:14]
  wire [2:0] _GEN_15 = _T_30 ? wayInput : 3'h2; // @[ProbeUnit.scala 245:26]
  wire [2:0] way = signals_2 ? replaceWayInput : _GEN_15; // @[ProbeUnit.scala 243:23]
  wire  signals_1 = decoder_io_outSignals_1; // @[ProbeUnit.scala 87:21 ProbeUnit.scala 156:11]
  wire  signals_0 = decoder_io_outSignals_0; // @[ProbeUnit.scala 87:21 ProbeUnit.scala 156:11]
  wire  _T_25 = signals_1 & signals_0; // @[ProbeUnit.scala 234:37]
  wire  _T_26 = signals_2 | _T_25; // @[ProbeUnit.scala 234:21]
  wire [7:0] _T_27 = set * 6'h2; // @[ProbeUnit.scala 235:46]
  wire [7:0] _GEN_14 = _T_26 ? _T_27 : 8'h0; // @[ProbeUnit.scala 234:53]
  wire [7:0] _GEN_53 = {{5'd0}, way}; // @[ProbeUnit.scala 270:50]
  wire [7:0] _T_46 = _T_27 + _GEN_53; // @[ProbeUnit.scala 270:50]
  wire [31:0] _T_49 = tagFinder_io_value_valid ? tagFinder_io_value_bits : 32'h2; // @[ProbeUnit.scala 287:25]
  wire [2:0] _GEN_41 = signals_2 ? way : 3'h2; // @[ProbeUnit.scala 288:28]
  wire [31:0] _GEN_42 = _T_25 ? _T_49 : {{29'd0}, _GEN_41}; // @[ProbeUnit.scala 286:39]
  wire  _T_51 = multiTagFinder_io_value_bits_0; // @[ProbeUnit.scala 294:74]
  wire [1:0] _T_52 = _T_51 ? 2'h0 : 2'h2; // @[ProbeUnit.scala 294:35]
  wire  _T_53 = multiTagFinder_io_value_bits_1; // @[ProbeUnit.scala 294:74]
  wire [1:0] _T_54 = _T_53 ? 2'h1 : 2'h2; // @[ProbeUnit.scala 294:35]
  wire  signals_5 = decoder_io_outSignals_5; // @[ProbeUnit.scala 87:21 ProbeUnit.scala 156:11]
  wire  signals_6 = decoder_io_outSignals_6; // @[ProbeUnit.scala 87:21 ProbeUnit.scala 156:11]
  wire  _T_59 = ~signals_6; // @[ProbeUnit.scala 311:50]
  wire [2:0] targetWayWire = _GEN_42[2:0]; // @[ProbeUnit.scala 287:19 ProbeUnit.scala 289:19]
  Decoder decoder ( // @[ProbeUnit.scala 48:23]
    .io_inAction(decoder_io_inAction),
    .io_outSignals_0(decoder_io_outSignals_0),
    .io_outSignals_1(decoder_io_outSignals_1),
    .io_outSignals_2(decoder_io_outSignals_2),
    .io_outSignals_3(decoder_io_outSignals_3),
    .io_outSignals_4(decoder_io_outSignals_4),
    .io_outSignals_5(decoder_io_outSignals_5),
    .io_outSignals_6(decoder_io_outSignals_6),
    .io_outSignals_7(decoder_io_outSignals_7),
    .io_outSignals_8(decoder_io_outSignals_8)
  );
  FindEmptyLine emptyLine ( // @[ProbeUnit.scala 217:25]
    .io_data_0(emptyLine_io_data_0),
    .io_data_1(emptyLine_io_data_1),
    .io_value_valid(emptyLine_io_value_valid)
  );
  FindMultiLine multiTagFinder ( // @[ProbeUnit.scala 220:30]
    .io_key_tag(multiTagFinder_io_key_tag),
    .io_data_0_tag(multiTagFinder_io_data_0_tag),
    .io_data_1_tag(multiTagFinder_io_data_1_tag),
    .io_value_bits_0(multiTagFinder_io_value_bits_0),
    .io_value_bits_1(multiTagFinder_io_value_bits_1)
  );
  Find tagFinder ( // @[ProbeUnit.scala 221:25]
    .io_key_tag(tagFinder_io_key_tag),
    .io_data_0_tag(tagFinder_io_data_0_tag),
    .io_data_1_tag(tagFinder_io_data_1_tag),
    .io_valid_0(tagFinder_io_valid_0),
    .io_valid_1(tagFinder_io_valid_1),
    .io_value_valid(tagFinder_io_value_valid),
    .io_value_bits(tagFinder_io_value_bits)
  );
  assign io_cpu_req_ready = 1'h1; // @[ProbeUnit.scala 159:20]
  assign io_cpu_resp_valid = signals_1 & signals_0; // @[ProbeUnit.scala 321:24]
  assign io_cpu_resp_bits_way = targetWayWire[1:0]; // @[ProbeUnit.scala 318:24]
  assign io_cpu_multiWay_valid = io_cpu_resp_valid; // @[ProbeUnit.scala 322:25]
  assign io_cpu_multiWay_bits_way_0 = _T_25 ? _T_52 : 2'h0; // @[ProbeUnit.scala 315:28]
  assign io_cpu_multiWay_bits_way_1 = _T_25 ? _T_54 : 2'h0; // @[ProbeUnit.scala 315:28]
  assign io_cpu_multiWay_bits_addr = addr_reg; // @[ProbeUnit.scala 316:29]
  assign io_metaMem_read_in_valid = decoder_io_outSignals_3; // @[ProbeUnit.scala 206:28 ProbeUnit.scala 172:21]
  assign io_metaMem_read_in_bits_address = set; // @[ProbeUnit.scala 181:32]
  assign io_validTagBits_write_valid = signals_5 | signals_6; // @[ProbeUnit.scala 310:31]
  assign io_validTagBits_write_bits_addr = {{56'd0}, _T_46}; // @[ProbeUnit.scala 309:35]
  assign io_validTagBits_write_bits_value = signals_5 | _T_59; // @[ProbeUnit.scala 311:36]
  assign io_validTagBits_read_in_valid = signals_2 | _T_25; // @[ProbeUnit.scala 240:33]
  assign io_validTagBits_read_in_bits_addr = {{56'd0}, _GEN_14}; // @[ProbeUnit.scala 235:39 ProbeUnit.scala 237:39]
  assign decoder_io_inAction = cpu_command; // @[ProbeUnit.scala 155:23]
  assign emptyLine_io_data_0 = io_validTagBits_read_out_0; // @[ProbeUnit.scala 218:21]
  assign emptyLine_io_data_1 = io_validTagBits_read_out_1; // @[ProbeUnit.scala 218:21]
  assign multiTagFinder_io_key_tag = tag; // @[ProbeUnit.scala 227:25]
  assign multiTagFinder_io_data_0_tag = io_metaMem_read_outputValue_0_tag; // @[ProbeUnit.scala 228:26]
  assign multiTagFinder_io_data_1_tag = io_metaMem_read_outputValue_1_tag; // @[ProbeUnit.scala 228:26]
  assign tagFinder_io_key_tag = tag; // @[ProbeUnit.scala 223:20]
  assign tagFinder_io_data_0_tag = io_metaMem_read_outputValue_0_tag; // @[ProbeUnit.scala 224:21]
  assign tagFinder_io_data_1_tag = io_metaMem_read_outputValue_1_tag; // @[ProbeUnit.scala 224:21]
  assign tagFinder_io_valid_0 = io_validTagBits_read_out_0; // @[ProbeUnit.scala 225:22]
  assign tagFinder_io_valid_1 = io_validTagBits_read_out_1; // @[ProbeUnit.scala 225:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  addr_reg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  cpu_command = _RAND_1[27:0];
  _RAND_2 = {1{`RANDOM}};
  tag = _RAND_2[25:0];
  _RAND_3 = {1{`RANDOM}};
  set = _RAND_3[5:0];
  _RAND_4 = {1{`RANDOM}};
  wayInput = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  replaceWayInput = _RAND_5[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      addr_reg <= 32'h0;
    end else if (_T_4) begin
      addr_reg <= io_cpu_req_bits_addr;
    end
    if (reset) begin
      cpu_command <= 28'h0;
    end else if (_T_4) begin
      cpu_command <= io_cpu_req_bits_command;
    end else begin
      cpu_command <= 28'h0;
    end
    if (reset) begin
      tag <= 26'h0;
    end else if (_T_4) begin
      tag <= io_cpu_req_bits_addr[31:6];
    end
    if (reset) begin
      set <= 6'h0;
    end else if (_T_4) begin
      set <= io_cpu_req_bits_addr[5:0];
    end
    if (reset) begin
      wayInput <= 3'h2;
    end else if (_T_4) begin
      wayInput <= 3'h0;
    end
    if (reset) begin
      replaceWayInput <= 3'h2;
    end else if (_T_4) begin
      replaceWayInput <= 3'h0;
    end
  end
endmodule
module paralReg_1(
  input         clock,
  input         reset,
  input         io_port_0_write_valid,
  input  [63:0] io_port_0_write_bits_addr,
  input         io_port_0_write_bits_value,
  input         io_port_0_read_in_valid,
  input  [63:0] io_port_0_read_in_bits_addr,
  output        io_port_0_read_out_0,
  output        io_port_0_read_out_1,
  input         io_port_1_write_valid,
  input  [63:0] io_port_1_write_bits_addr,
  input         io_port_1_write_bits_value,
  input         io_port_1_read_in_valid,
  input  [63:0] io_port_1_read_in_bits_addr,
  output        io_port_1_read_out_0,
  output        io_port_1_read_out_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
`endif // RANDOMIZE_REG_INIT
  reg  content_0; // @[elements.scala 107:26]
  reg  content_1; // @[elements.scala 107:26]
  reg  content_2; // @[elements.scala 107:26]
  reg  content_3; // @[elements.scala 107:26]
  reg  content_4; // @[elements.scala 107:26]
  reg  content_5; // @[elements.scala 107:26]
  reg  content_6; // @[elements.scala 107:26]
  reg  content_7; // @[elements.scala 107:26]
  reg  content_8; // @[elements.scala 107:26]
  reg  content_9; // @[elements.scala 107:26]
  reg  content_10; // @[elements.scala 107:26]
  reg  content_11; // @[elements.scala 107:26]
  reg  content_12; // @[elements.scala 107:26]
  reg  content_13; // @[elements.scala 107:26]
  reg  content_14; // @[elements.scala 107:26]
  reg  content_15; // @[elements.scala 107:26]
  reg  content_16; // @[elements.scala 107:26]
  reg  content_17; // @[elements.scala 107:26]
  reg  content_18; // @[elements.scala 107:26]
  reg  content_19; // @[elements.scala 107:26]
  reg  content_20; // @[elements.scala 107:26]
  reg  content_21; // @[elements.scala 107:26]
  reg  content_22; // @[elements.scala 107:26]
  reg  content_23; // @[elements.scala 107:26]
  reg  content_24; // @[elements.scala 107:26]
  reg  content_25; // @[elements.scala 107:26]
  reg  content_26; // @[elements.scala 107:26]
  reg  content_27; // @[elements.scala 107:26]
  reg  content_28; // @[elements.scala 107:26]
  reg  content_29; // @[elements.scala 107:26]
  reg  content_30; // @[elements.scala 107:26]
  reg  content_31; // @[elements.scala 107:26]
  reg  content_32; // @[elements.scala 107:26]
  reg  content_33; // @[elements.scala 107:26]
  reg  content_34; // @[elements.scala 107:26]
  reg  content_35; // @[elements.scala 107:26]
  reg  content_36; // @[elements.scala 107:26]
  reg  content_37; // @[elements.scala 107:26]
  reg  content_38; // @[elements.scala 107:26]
  reg  content_39; // @[elements.scala 107:26]
  reg  content_40; // @[elements.scala 107:26]
  reg  content_41; // @[elements.scala 107:26]
  reg  content_42; // @[elements.scala 107:26]
  reg  content_43; // @[elements.scala 107:26]
  reg  content_44; // @[elements.scala 107:26]
  reg  content_45; // @[elements.scala 107:26]
  reg  content_46; // @[elements.scala 107:26]
  reg  content_47; // @[elements.scala 107:26]
  reg  content_48; // @[elements.scala 107:26]
  reg  content_49; // @[elements.scala 107:26]
  reg  content_50; // @[elements.scala 107:26]
  reg  content_51; // @[elements.scala 107:26]
  reg  content_52; // @[elements.scala 107:26]
  reg  content_53; // @[elements.scala 107:26]
  reg  content_54; // @[elements.scala 107:26]
  reg  content_55; // @[elements.scala 107:26]
  reg  content_56; // @[elements.scala 107:26]
  reg  content_57; // @[elements.scala 107:26]
  reg  content_58; // @[elements.scala 107:26]
  reg  content_59; // @[elements.scala 107:26]
  reg  content_60; // @[elements.scala 107:26]
  reg  content_61; // @[elements.scala 107:26]
  reg  content_62; // @[elements.scala 107:26]
  reg  content_63; // @[elements.scala 107:26]
  reg  content_64; // @[elements.scala 107:26]
  reg  content_65; // @[elements.scala 107:26]
  reg  content_66; // @[elements.scala 107:26]
  reg  content_67; // @[elements.scala 107:26]
  reg  content_68; // @[elements.scala 107:26]
  reg  content_69; // @[elements.scala 107:26]
  reg  content_70; // @[elements.scala 107:26]
  reg  content_71; // @[elements.scala 107:26]
  reg  content_72; // @[elements.scala 107:26]
  reg  content_73; // @[elements.scala 107:26]
  reg  content_74; // @[elements.scala 107:26]
  reg  content_75; // @[elements.scala 107:26]
  reg  content_76; // @[elements.scala 107:26]
  reg  content_77; // @[elements.scala 107:26]
  reg  content_78; // @[elements.scala 107:26]
  reg  content_79; // @[elements.scala 107:26]
  reg  content_80; // @[elements.scala 107:26]
  reg  content_81; // @[elements.scala 107:26]
  reg  content_82; // @[elements.scala 107:26]
  reg  content_83; // @[elements.scala 107:26]
  reg  content_84; // @[elements.scala 107:26]
  reg  content_85; // @[elements.scala 107:26]
  reg  content_86; // @[elements.scala 107:26]
  reg  content_87; // @[elements.scala 107:26]
  reg  content_88; // @[elements.scala 107:26]
  reg  content_89; // @[elements.scala 107:26]
  reg  content_90; // @[elements.scala 107:26]
  reg  content_91; // @[elements.scala 107:26]
  reg  content_92; // @[elements.scala 107:26]
  reg  content_93; // @[elements.scala 107:26]
  reg  content_94; // @[elements.scala 107:26]
  reg  content_95; // @[elements.scala 107:26]
  reg  content_96; // @[elements.scala 107:26]
  reg  content_97; // @[elements.scala 107:26]
  reg  content_98; // @[elements.scala 107:26]
  reg  content_99; // @[elements.scala 107:26]
  reg  content_100; // @[elements.scala 107:26]
  reg  content_101; // @[elements.scala 107:26]
  reg  content_102; // @[elements.scala 107:26]
  reg  content_103; // @[elements.scala 107:26]
  reg  content_104; // @[elements.scala 107:26]
  reg  content_105; // @[elements.scala 107:26]
  reg  content_106; // @[elements.scala 107:26]
  reg  content_107; // @[elements.scala 107:26]
  reg  content_108; // @[elements.scala 107:26]
  reg  content_109; // @[elements.scala 107:26]
  reg  content_110; // @[elements.scala 107:26]
  reg  content_111; // @[elements.scala 107:26]
  reg  content_112; // @[elements.scala 107:26]
  reg  content_113; // @[elements.scala 107:26]
  reg  content_114; // @[elements.scala 107:26]
  reg  content_115; // @[elements.scala 107:26]
  reg  content_116; // @[elements.scala 107:26]
  reg  content_117; // @[elements.scala 107:26]
  reg  content_118; // @[elements.scala 107:26]
  reg  content_119; // @[elements.scala 107:26]
  reg  content_120; // @[elements.scala 107:26]
  reg  content_121; // @[elements.scala 107:26]
  reg  content_122; // @[elements.scala 107:26]
  reg  content_123; // @[elements.scala 107:26]
  reg  content_124; // @[elements.scala 107:26]
  reg  content_125; // @[elements.scala 107:26]
  reg  content_126; // @[elements.scala 107:26]
  reg  content_127; // @[elements.scala 107:26]
  wire [64:0] _T_1 = {{1'd0}, io_port_0_read_in_bits_addr}; // @[elements.scala 118:104]
  wire [63:0] _T_5 = io_port_0_read_in_bits_addr + 64'h1; // @[elements.scala 118:104]
  wire  _GEN_1 = 7'h1 == _T_5[6:0] ? content_1 : content_0; // @[Cat.scala 29:58]
  wire  _GEN_2 = 7'h2 == _T_5[6:0] ? content_2 : _GEN_1; // @[Cat.scala 29:58]
  wire  _GEN_3 = 7'h3 == _T_5[6:0] ? content_3 : _GEN_2; // @[Cat.scala 29:58]
  wire  _GEN_4 = 7'h4 == _T_5[6:0] ? content_4 : _GEN_3; // @[Cat.scala 29:58]
  wire  _GEN_5 = 7'h5 == _T_5[6:0] ? content_5 : _GEN_4; // @[Cat.scala 29:58]
  wire  _GEN_6 = 7'h6 == _T_5[6:0] ? content_6 : _GEN_5; // @[Cat.scala 29:58]
  wire  _GEN_7 = 7'h7 == _T_5[6:0] ? content_7 : _GEN_6; // @[Cat.scala 29:58]
  wire  _GEN_8 = 7'h8 == _T_5[6:0] ? content_8 : _GEN_7; // @[Cat.scala 29:58]
  wire  _GEN_9 = 7'h9 == _T_5[6:0] ? content_9 : _GEN_8; // @[Cat.scala 29:58]
  wire  _GEN_10 = 7'ha == _T_5[6:0] ? content_10 : _GEN_9; // @[Cat.scala 29:58]
  wire  _GEN_11 = 7'hb == _T_5[6:0] ? content_11 : _GEN_10; // @[Cat.scala 29:58]
  wire  _GEN_12 = 7'hc == _T_5[6:0] ? content_12 : _GEN_11; // @[Cat.scala 29:58]
  wire  _GEN_13 = 7'hd == _T_5[6:0] ? content_13 : _GEN_12; // @[Cat.scala 29:58]
  wire  _GEN_14 = 7'he == _T_5[6:0] ? content_14 : _GEN_13; // @[Cat.scala 29:58]
  wire  _GEN_15 = 7'hf == _T_5[6:0] ? content_15 : _GEN_14; // @[Cat.scala 29:58]
  wire  _GEN_16 = 7'h10 == _T_5[6:0] ? content_16 : _GEN_15; // @[Cat.scala 29:58]
  wire  _GEN_17 = 7'h11 == _T_5[6:0] ? content_17 : _GEN_16; // @[Cat.scala 29:58]
  wire  _GEN_18 = 7'h12 == _T_5[6:0] ? content_18 : _GEN_17; // @[Cat.scala 29:58]
  wire  _GEN_19 = 7'h13 == _T_5[6:0] ? content_19 : _GEN_18; // @[Cat.scala 29:58]
  wire  _GEN_20 = 7'h14 == _T_5[6:0] ? content_20 : _GEN_19; // @[Cat.scala 29:58]
  wire  _GEN_21 = 7'h15 == _T_5[6:0] ? content_21 : _GEN_20; // @[Cat.scala 29:58]
  wire  _GEN_22 = 7'h16 == _T_5[6:0] ? content_22 : _GEN_21; // @[Cat.scala 29:58]
  wire  _GEN_23 = 7'h17 == _T_5[6:0] ? content_23 : _GEN_22; // @[Cat.scala 29:58]
  wire  _GEN_24 = 7'h18 == _T_5[6:0] ? content_24 : _GEN_23; // @[Cat.scala 29:58]
  wire  _GEN_25 = 7'h19 == _T_5[6:0] ? content_25 : _GEN_24; // @[Cat.scala 29:58]
  wire  _GEN_26 = 7'h1a == _T_5[6:0] ? content_26 : _GEN_25; // @[Cat.scala 29:58]
  wire  _GEN_27 = 7'h1b == _T_5[6:0] ? content_27 : _GEN_26; // @[Cat.scala 29:58]
  wire  _GEN_28 = 7'h1c == _T_5[6:0] ? content_28 : _GEN_27; // @[Cat.scala 29:58]
  wire  _GEN_29 = 7'h1d == _T_5[6:0] ? content_29 : _GEN_28; // @[Cat.scala 29:58]
  wire  _GEN_30 = 7'h1e == _T_5[6:0] ? content_30 : _GEN_29; // @[Cat.scala 29:58]
  wire  _GEN_31 = 7'h1f == _T_5[6:0] ? content_31 : _GEN_30; // @[Cat.scala 29:58]
  wire  _GEN_32 = 7'h20 == _T_5[6:0] ? content_32 : _GEN_31; // @[Cat.scala 29:58]
  wire  _GEN_33 = 7'h21 == _T_5[6:0] ? content_33 : _GEN_32; // @[Cat.scala 29:58]
  wire  _GEN_34 = 7'h22 == _T_5[6:0] ? content_34 : _GEN_33; // @[Cat.scala 29:58]
  wire  _GEN_35 = 7'h23 == _T_5[6:0] ? content_35 : _GEN_34; // @[Cat.scala 29:58]
  wire  _GEN_36 = 7'h24 == _T_5[6:0] ? content_36 : _GEN_35; // @[Cat.scala 29:58]
  wire  _GEN_37 = 7'h25 == _T_5[6:0] ? content_37 : _GEN_36; // @[Cat.scala 29:58]
  wire  _GEN_38 = 7'h26 == _T_5[6:0] ? content_38 : _GEN_37; // @[Cat.scala 29:58]
  wire  _GEN_39 = 7'h27 == _T_5[6:0] ? content_39 : _GEN_38; // @[Cat.scala 29:58]
  wire  _GEN_40 = 7'h28 == _T_5[6:0] ? content_40 : _GEN_39; // @[Cat.scala 29:58]
  wire  _GEN_41 = 7'h29 == _T_5[6:0] ? content_41 : _GEN_40; // @[Cat.scala 29:58]
  wire  _GEN_42 = 7'h2a == _T_5[6:0] ? content_42 : _GEN_41; // @[Cat.scala 29:58]
  wire  _GEN_43 = 7'h2b == _T_5[6:0] ? content_43 : _GEN_42; // @[Cat.scala 29:58]
  wire  _GEN_44 = 7'h2c == _T_5[6:0] ? content_44 : _GEN_43; // @[Cat.scala 29:58]
  wire  _GEN_45 = 7'h2d == _T_5[6:0] ? content_45 : _GEN_44; // @[Cat.scala 29:58]
  wire  _GEN_46 = 7'h2e == _T_5[6:0] ? content_46 : _GEN_45; // @[Cat.scala 29:58]
  wire  _GEN_47 = 7'h2f == _T_5[6:0] ? content_47 : _GEN_46; // @[Cat.scala 29:58]
  wire  _GEN_48 = 7'h30 == _T_5[6:0] ? content_48 : _GEN_47; // @[Cat.scala 29:58]
  wire  _GEN_49 = 7'h31 == _T_5[6:0] ? content_49 : _GEN_48; // @[Cat.scala 29:58]
  wire  _GEN_50 = 7'h32 == _T_5[6:0] ? content_50 : _GEN_49; // @[Cat.scala 29:58]
  wire  _GEN_51 = 7'h33 == _T_5[6:0] ? content_51 : _GEN_50; // @[Cat.scala 29:58]
  wire  _GEN_52 = 7'h34 == _T_5[6:0] ? content_52 : _GEN_51; // @[Cat.scala 29:58]
  wire  _GEN_53 = 7'h35 == _T_5[6:0] ? content_53 : _GEN_52; // @[Cat.scala 29:58]
  wire  _GEN_54 = 7'h36 == _T_5[6:0] ? content_54 : _GEN_53; // @[Cat.scala 29:58]
  wire  _GEN_55 = 7'h37 == _T_5[6:0] ? content_55 : _GEN_54; // @[Cat.scala 29:58]
  wire  _GEN_56 = 7'h38 == _T_5[6:0] ? content_56 : _GEN_55; // @[Cat.scala 29:58]
  wire  _GEN_57 = 7'h39 == _T_5[6:0] ? content_57 : _GEN_56; // @[Cat.scala 29:58]
  wire  _GEN_58 = 7'h3a == _T_5[6:0] ? content_58 : _GEN_57; // @[Cat.scala 29:58]
  wire  _GEN_59 = 7'h3b == _T_5[6:0] ? content_59 : _GEN_58; // @[Cat.scala 29:58]
  wire  _GEN_60 = 7'h3c == _T_5[6:0] ? content_60 : _GEN_59; // @[Cat.scala 29:58]
  wire  _GEN_61 = 7'h3d == _T_5[6:0] ? content_61 : _GEN_60; // @[Cat.scala 29:58]
  wire  _GEN_62 = 7'h3e == _T_5[6:0] ? content_62 : _GEN_61; // @[Cat.scala 29:58]
  wire  _GEN_63 = 7'h3f == _T_5[6:0] ? content_63 : _GEN_62; // @[Cat.scala 29:58]
  wire  _GEN_64 = 7'h40 == _T_5[6:0] ? content_64 : _GEN_63; // @[Cat.scala 29:58]
  wire  _GEN_65 = 7'h41 == _T_5[6:0] ? content_65 : _GEN_64; // @[Cat.scala 29:58]
  wire  _GEN_66 = 7'h42 == _T_5[6:0] ? content_66 : _GEN_65; // @[Cat.scala 29:58]
  wire  _GEN_67 = 7'h43 == _T_5[6:0] ? content_67 : _GEN_66; // @[Cat.scala 29:58]
  wire  _GEN_68 = 7'h44 == _T_5[6:0] ? content_68 : _GEN_67; // @[Cat.scala 29:58]
  wire  _GEN_69 = 7'h45 == _T_5[6:0] ? content_69 : _GEN_68; // @[Cat.scala 29:58]
  wire  _GEN_70 = 7'h46 == _T_5[6:0] ? content_70 : _GEN_69; // @[Cat.scala 29:58]
  wire  _GEN_71 = 7'h47 == _T_5[6:0] ? content_71 : _GEN_70; // @[Cat.scala 29:58]
  wire  _GEN_72 = 7'h48 == _T_5[6:0] ? content_72 : _GEN_71; // @[Cat.scala 29:58]
  wire  _GEN_73 = 7'h49 == _T_5[6:0] ? content_73 : _GEN_72; // @[Cat.scala 29:58]
  wire  _GEN_74 = 7'h4a == _T_5[6:0] ? content_74 : _GEN_73; // @[Cat.scala 29:58]
  wire  _GEN_75 = 7'h4b == _T_5[6:0] ? content_75 : _GEN_74; // @[Cat.scala 29:58]
  wire  _GEN_76 = 7'h4c == _T_5[6:0] ? content_76 : _GEN_75; // @[Cat.scala 29:58]
  wire  _GEN_77 = 7'h4d == _T_5[6:0] ? content_77 : _GEN_76; // @[Cat.scala 29:58]
  wire  _GEN_78 = 7'h4e == _T_5[6:0] ? content_78 : _GEN_77; // @[Cat.scala 29:58]
  wire  _GEN_79 = 7'h4f == _T_5[6:0] ? content_79 : _GEN_78; // @[Cat.scala 29:58]
  wire  _GEN_80 = 7'h50 == _T_5[6:0] ? content_80 : _GEN_79; // @[Cat.scala 29:58]
  wire  _GEN_81 = 7'h51 == _T_5[6:0] ? content_81 : _GEN_80; // @[Cat.scala 29:58]
  wire  _GEN_82 = 7'h52 == _T_5[6:0] ? content_82 : _GEN_81; // @[Cat.scala 29:58]
  wire  _GEN_83 = 7'h53 == _T_5[6:0] ? content_83 : _GEN_82; // @[Cat.scala 29:58]
  wire  _GEN_84 = 7'h54 == _T_5[6:0] ? content_84 : _GEN_83; // @[Cat.scala 29:58]
  wire  _GEN_85 = 7'h55 == _T_5[6:0] ? content_85 : _GEN_84; // @[Cat.scala 29:58]
  wire  _GEN_86 = 7'h56 == _T_5[6:0] ? content_86 : _GEN_85; // @[Cat.scala 29:58]
  wire  _GEN_87 = 7'h57 == _T_5[6:0] ? content_87 : _GEN_86; // @[Cat.scala 29:58]
  wire  _GEN_88 = 7'h58 == _T_5[6:0] ? content_88 : _GEN_87; // @[Cat.scala 29:58]
  wire  _GEN_89 = 7'h59 == _T_5[6:0] ? content_89 : _GEN_88; // @[Cat.scala 29:58]
  wire  _GEN_90 = 7'h5a == _T_5[6:0] ? content_90 : _GEN_89; // @[Cat.scala 29:58]
  wire  _GEN_91 = 7'h5b == _T_5[6:0] ? content_91 : _GEN_90; // @[Cat.scala 29:58]
  wire  _GEN_92 = 7'h5c == _T_5[6:0] ? content_92 : _GEN_91; // @[Cat.scala 29:58]
  wire  _GEN_93 = 7'h5d == _T_5[6:0] ? content_93 : _GEN_92; // @[Cat.scala 29:58]
  wire  _GEN_94 = 7'h5e == _T_5[6:0] ? content_94 : _GEN_93; // @[Cat.scala 29:58]
  wire  _GEN_95 = 7'h5f == _T_5[6:0] ? content_95 : _GEN_94; // @[Cat.scala 29:58]
  wire  _GEN_96 = 7'h60 == _T_5[6:0] ? content_96 : _GEN_95; // @[Cat.scala 29:58]
  wire  _GEN_97 = 7'h61 == _T_5[6:0] ? content_97 : _GEN_96; // @[Cat.scala 29:58]
  wire  _GEN_98 = 7'h62 == _T_5[6:0] ? content_98 : _GEN_97; // @[Cat.scala 29:58]
  wire  _GEN_99 = 7'h63 == _T_5[6:0] ? content_99 : _GEN_98; // @[Cat.scala 29:58]
  wire  _GEN_100 = 7'h64 == _T_5[6:0] ? content_100 : _GEN_99; // @[Cat.scala 29:58]
  wire  _GEN_101 = 7'h65 == _T_5[6:0] ? content_101 : _GEN_100; // @[Cat.scala 29:58]
  wire  _GEN_102 = 7'h66 == _T_5[6:0] ? content_102 : _GEN_101; // @[Cat.scala 29:58]
  wire  _GEN_103 = 7'h67 == _T_5[6:0] ? content_103 : _GEN_102; // @[Cat.scala 29:58]
  wire  _GEN_104 = 7'h68 == _T_5[6:0] ? content_104 : _GEN_103; // @[Cat.scala 29:58]
  wire  _GEN_105 = 7'h69 == _T_5[6:0] ? content_105 : _GEN_104; // @[Cat.scala 29:58]
  wire  _GEN_106 = 7'h6a == _T_5[6:0] ? content_106 : _GEN_105; // @[Cat.scala 29:58]
  wire  _GEN_107 = 7'h6b == _T_5[6:0] ? content_107 : _GEN_106; // @[Cat.scala 29:58]
  wire  _GEN_108 = 7'h6c == _T_5[6:0] ? content_108 : _GEN_107; // @[Cat.scala 29:58]
  wire  _GEN_109 = 7'h6d == _T_5[6:0] ? content_109 : _GEN_108; // @[Cat.scala 29:58]
  wire  _GEN_110 = 7'h6e == _T_5[6:0] ? content_110 : _GEN_109; // @[Cat.scala 29:58]
  wire  _GEN_111 = 7'h6f == _T_5[6:0] ? content_111 : _GEN_110; // @[Cat.scala 29:58]
  wire  _GEN_112 = 7'h70 == _T_5[6:0] ? content_112 : _GEN_111; // @[Cat.scala 29:58]
  wire  _GEN_113 = 7'h71 == _T_5[6:0] ? content_113 : _GEN_112; // @[Cat.scala 29:58]
  wire  _GEN_114 = 7'h72 == _T_5[6:0] ? content_114 : _GEN_113; // @[Cat.scala 29:58]
  wire  _GEN_115 = 7'h73 == _T_5[6:0] ? content_115 : _GEN_114; // @[Cat.scala 29:58]
  wire  _GEN_116 = 7'h74 == _T_5[6:0] ? content_116 : _GEN_115; // @[Cat.scala 29:58]
  wire  _GEN_117 = 7'h75 == _T_5[6:0] ? content_117 : _GEN_116; // @[Cat.scala 29:58]
  wire  _GEN_118 = 7'h76 == _T_5[6:0] ? content_118 : _GEN_117; // @[Cat.scala 29:58]
  wire  _GEN_119 = 7'h77 == _T_5[6:0] ? content_119 : _GEN_118; // @[Cat.scala 29:58]
  wire  _GEN_120 = 7'h78 == _T_5[6:0] ? content_120 : _GEN_119; // @[Cat.scala 29:58]
  wire  _GEN_121 = 7'h79 == _T_5[6:0] ? content_121 : _GEN_120; // @[Cat.scala 29:58]
  wire  _GEN_122 = 7'h7a == _T_5[6:0] ? content_122 : _GEN_121; // @[Cat.scala 29:58]
  wire  _GEN_123 = 7'h7b == _T_5[6:0] ? content_123 : _GEN_122; // @[Cat.scala 29:58]
  wire  _GEN_124 = 7'h7c == _T_5[6:0] ? content_124 : _GEN_123; // @[Cat.scala 29:58]
  wire  _GEN_125 = 7'h7d == _T_5[6:0] ? content_125 : _GEN_124; // @[Cat.scala 29:58]
  wire  _GEN_126 = 7'h7e == _T_5[6:0] ? content_126 : _GEN_125; // @[Cat.scala 29:58]
  wire  _GEN_127 = 7'h7f == _T_5[6:0] ? content_127 : _GEN_126; // @[Cat.scala 29:58]
  wire  _GEN_129 = 7'h1 == _T_1[6:0] ? content_1 : content_0; // @[Cat.scala 29:58]
  wire  _GEN_130 = 7'h2 == _T_1[6:0] ? content_2 : _GEN_129; // @[Cat.scala 29:58]
  wire  _GEN_131 = 7'h3 == _T_1[6:0] ? content_3 : _GEN_130; // @[Cat.scala 29:58]
  wire  _GEN_132 = 7'h4 == _T_1[6:0] ? content_4 : _GEN_131; // @[Cat.scala 29:58]
  wire  _GEN_133 = 7'h5 == _T_1[6:0] ? content_5 : _GEN_132; // @[Cat.scala 29:58]
  wire  _GEN_134 = 7'h6 == _T_1[6:0] ? content_6 : _GEN_133; // @[Cat.scala 29:58]
  wire  _GEN_135 = 7'h7 == _T_1[6:0] ? content_7 : _GEN_134; // @[Cat.scala 29:58]
  wire  _GEN_136 = 7'h8 == _T_1[6:0] ? content_8 : _GEN_135; // @[Cat.scala 29:58]
  wire  _GEN_137 = 7'h9 == _T_1[6:0] ? content_9 : _GEN_136; // @[Cat.scala 29:58]
  wire  _GEN_138 = 7'ha == _T_1[6:0] ? content_10 : _GEN_137; // @[Cat.scala 29:58]
  wire  _GEN_139 = 7'hb == _T_1[6:0] ? content_11 : _GEN_138; // @[Cat.scala 29:58]
  wire  _GEN_140 = 7'hc == _T_1[6:0] ? content_12 : _GEN_139; // @[Cat.scala 29:58]
  wire  _GEN_141 = 7'hd == _T_1[6:0] ? content_13 : _GEN_140; // @[Cat.scala 29:58]
  wire  _GEN_142 = 7'he == _T_1[6:0] ? content_14 : _GEN_141; // @[Cat.scala 29:58]
  wire  _GEN_143 = 7'hf == _T_1[6:0] ? content_15 : _GEN_142; // @[Cat.scala 29:58]
  wire  _GEN_144 = 7'h10 == _T_1[6:0] ? content_16 : _GEN_143; // @[Cat.scala 29:58]
  wire  _GEN_145 = 7'h11 == _T_1[6:0] ? content_17 : _GEN_144; // @[Cat.scala 29:58]
  wire  _GEN_146 = 7'h12 == _T_1[6:0] ? content_18 : _GEN_145; // @[Cat.scala 29:58]
  wire  _GEN_147 = 7'h13 == _T_1[6:0] ? content_19 : _GEN_146; // @[Cat.scala 29:58]
  wire  _GEN_148 = 7'h14 == _T_1[6:0] ? content_20 : _GEN_147; // @[Cat.scala 29:58]
  wire  _GEN_149 = 7'h15 == _T_1[6:0] ? content_21 : _GEN_148; // @[Cat.scala 29:58]
  wire  _GEN_150 = 7'h16 == _T_1[6:0] ? content_22 : _GEN_149; // @[Cat.scala 29:58]
  wire  _GEN_151 = 7'h17 == _T_1[6:0] ? content_23 : _GEN_150; // @[Cat.scala 29:58]
  wire  _GEN_152 = 7'h18 == _T_1[6:0] ? content_24 : _GEN_151; // @[Cat.scala 29:58]
  wire  _GEN_153 = 7'h19 == _T_1[6:0] ? content_25 : _GEN_152; // @[Cat.scala 29:58]
  wire  _GEN_154 = 7'h1a == _T_1[6:0] ? content_26 : _GEN_153; // @[Cat.scala 29:58]
  wire  _GEN_155 = 7'h1b == _T_1[6:0] ? content_27 : _GEN_154; // @[Cat.scala 29:58]
  wire  _GEN_156 = 7'h1c == _T_1[6:0] ? content_28 : _GEN_155; // @[Cat.scala 29:58]
  wire  _GEN_157 = 7'h1d == _T_1[6:0] ? content_29 : _GEN_156; // @[Cat.scala 29:58]
  wire  _GEN_158 = 7'h1e == _T_1[6:0] ? content_30 : _GEN_157; // @[Cat.scala 29:58]
  wire  _GEN_159 = 7'h1f == _T_1[6:0] ? content_31 : _GEN_158; // @[Cat.scala 29:58]
  wire  _GEN_160 = 7'h20 == _T_1[6:0] ? content_32 : _GEN_159; // @[Cat.scala 29:58]
  wire  _GEN_161 = 7'h21 == _T_1[6:0] ? content_33 : _GEN_160; // @[Cat.scala 29:58]
  wire  _GEN_162 = 7'h22 == _T_1[6:0] ? content_34 : _GEN_161; // @[Cat.scala 29:58]
  wire  _GEN_163 = 7'h23 == _T_1[6:0] ? content_35 : _GEN_162; // @[Cat.scala 29:58]
  wire  _GEN_164 = 7'h24 == _T_1[6:0] ? content_36 : _GEN_163; // @[Cat.scala 29:58]
  wire  _GEN_165 = 7'h25 == _T_1[6:0] ? content_37 : _GEN_164; // @[Cat.scala 29:58]
  wire  _GEN_166 = 7'h26 == _T_1[6:0] ? content_38 : _GEN_165; // @[Cat.scala 29:58]
  wire  _GEN_167 = 7'h27 == _T_1[6:0] ? content_39 : _GEN_166; // @[Cat.scala 29:58]
  wire  _GEN_168 = 7'h28 == _T_1[6:0] ? content_40 : _GEN_167; // @[Cat.scala 29:58]
  wire  _GEN_169 = 7'h29 == _T_1[6:0] ? content_41 : _GEN_168; // @[Cat.scala 29:58]
  wire  _GEN_170 = 7'h2a == _T_1[6:0] ? content_42 : _GEN_169; // @[Cat.scala 29:58]
  wire  _GEN_171 = 7'h2b == _T_1[6:0] ? content_43 : _GEN_170; // @[Cat.scala 29:58]
  wire  _GEN_172 = 7'h2c == _T_1[6:0] ? content_44 : _GEN_171; // @[Cat.scala 29:58]
  wire  _GEN_173 = 7'h2d == _T_1[6:0] ? content_45 : _GEN_172; // @[Cat.scala 29:58]
  wire  _GEN_174 = 7'h2e == _T_1[6:0] ? content_46 : _GEN_173; // @[Cat.scala 29:58]
  wire  _GEN_175 = 7'h2f == _T_1[6:0] ? content_47 : _GEN_174; // @[Cat.scala 29:58]
  wire  _GEN_176 = 7'h30 == _T_1[6:0] ? content_48 : _GEN_175; // @[Cat.scala 29:58]
  wire  _GEN_177 = 7'h31 == _T_1[6:0] ? content_49 : _GEN_176; // @[Cat.scala 29:58]
  wire  _GEN_178 = 7'h32 == _T_1[6:0] ? content_50 : _GEN_177; // @[Cat.scala 29:58]
  wire  _GEN_179 = 7'h33 == _T_1[6:0] ? content_51 : _GEN_178; // @[Cat.scala 29:58]
  wire  _GEN_180 = 7'h34 == _T_1[6:0] ? content_52 : _GEN_179; // @[Cat.scala 29:58]
  wire  _GEN_181 = 7'h35 == _T_1[6:0] ? content_53 : _GEN_180; // @[Cat.scala 29:58]
  wire  _GEN_182 = 7'h36 == _T_1[6:0] ? content_54 : _GEN_181; // @[Cat.scala 29:58]
  wire  _GEN_183 = 7'h37 == _T_1[6:0] ? content_55 : _GEN_182; // @[Cat.scala 29:58]
  wire  _GEN_184 = 7'h38 == _T_1[6:0] ? content_56 : _GEN_183; // @[Cat.scala 29:58]
  wire  _GEN_185 = 7'h39 == _T_1[6:0] ? content_57 : _GEN_184; // @[Cat.scala 29:58]
  wire  _GEN_186 = 7'h3a == _T_1[6:0] ? content_58 : _GEN_185; // @[Cat.scala 29:58]
  wire  _GEN_187 = 7'h3b == _T_1[6:0] ? content_59 : _GEN_186; // @[Cat.scala 29:58]
  wire  _GEN_188 = 7'h3c == _T_1[6:0] ? content_60 : _GEN_187; // @[Cat.scala 29:58]
  wire  _GEN_189 = 7'h3d == _T_1[6:0] ? content_61 : _GEN_188; // @[Cat.scala 29:58]
  wire  _GEN_190 = 7'h3e == _T_1[6:0] ? content_62 : _GEN_189; // @[Cat.scala 29:58]
  wire  _GEN_191 = 7'h3f == _T_1[6:0] ? content_63 : _GEN_190; // @[Cat.scala 29:58]
  wire  _GEN_192 = 7'h40 == _T_1[6:0] ? content_64 : _GEN_191; // @[Cat.scala 29:58]
  wire  _GEN_193 = 7'h41 == _T_1[6:0] ? content_65 : _GEN_192; // @[Cat.scala 29:58]
  wire  _GEN_194 = 7'h42 == _T_1[6:0] ? content_66 : _GEN_193; // @[Cat.scala 29:58]
  wire  _GEN_195 = 7'h43 == _T_1[6:0] ? content_67 : _GEN_194; // @[Cat.scala 29:58]
  wire  _GEN_196 = 7'h44 == _T_1[6:0] ? content_68 : _GEN_195; // @[Cat.scala 29:58]
  wire  _GEN_197 = 7'h45 == _T_1[6:0] ? content_69 : _GEN_196; // @[Cat.scala 29:58]
  wire  _GEN_198 = 7'h46 == _T_1[6:0] ? content_70 : _GEN_197; // @[Cat.scala 29:58]
  wire  _GEN_199 = 7'h47 == _T_1[6:0] ? content_71 : _GEN_198; // @[Cat.scala 29:58]
  wire  _GEN_200 = 7'h48 == _T_1[6:0] ? content_72 : _GEN_199; // @[Cat.scala 29:58]
  wire  _GEN_201 = 7'h49 == _T_1[6:0] ? content_73 : _GEN_200; // @[Cat.scala 29:58]
  wire  _GEN_202 = 7'h4a == _T_1[6:0] ? content_74 : _GEN_201; // @[Cat.scala 29:58]
  wire  _GEN_203 = 7'h4b == _T_1[6:0] ? content_75 : _GEN_202; // @[Cat.scala 29:58]
  wire  _GEN_204 = 7'h4c == _T_1[6:0] ? content_76 : _GEN_203; // @[Cat.scala 29:58]
  wire  _GEN_205 = 7'h4d == _T_1[6:0] ? content_77 : _GEN_204; // @[Cat.scala 29:58]
  wire  _GEN_206 = 7'h4e == _T_1[6:0] ? content_78 : _GEN_205; // @[Cat.scala 29:58]
  wire  _GEN_207 = 7'h4f == _T_1[6:0] ? content_79 : _GEN_206; // @[Cat.scala 29:58]
  wire  _GEN_208 = 7'h50 == _T_1[6:0] ? content_80 : _GEN_207; // @[Cat.scala 29:58]
  wire  _GEN_209 = 7'h51 == _T_1[6:0] ? content_81 : _GEN_208; // @[Cat.scala 29:58]
  wire  _GEN_210 = 7'h52 == _T_1[6:0] ? content_82 : _GEN_209; // @[Cat.scala 29:58]
  wire  _GEN_211 = 7'h53 == _T_1[6:0] ? content_83 : _GEN_210; // @[Cat.scala 29:58]
  wire  _GEN_212 = 7'h54 == _T_1[6:0] ? content_84 : _GEN_211; // @[Cat.scala 29:58]
  wire  _GEN_213 = 7'h55 == _T_1[6:0] ? content_85 : _GEN_212; // @[Cat.scala 29:58]
  wire  _GEN_214 = 7'h56 == _T_1[6:0] ? content_86 : _GEN_213; // @[Cat.scala 29:58]
  wire  _GEN_215 = 7'h57 == _T_1[6:0] ? content_87 : _GEN_214; // @[Cat.scala 29:58]
  wire  _GEN_216 = 7'h58 == _T_1[6:0] ? content_88 : _GEN_215; // @[Cat.scala 29:58]
  wire  _GEN_217 = 7'h59 == _T_1[6:0] ? content_89 : _GEN_216; // @[Cat.scala 29:58]
  wire  _GEN_218 = 7'h5a == _T_1[6:0] ? content_90 : _GEN_217; // @[Cat.scala 29:58]
  wire  _GEN_219 = 7'h5b == _T_1[6:0] ? content_91 : _GEN_218; // @[Cat.scala 29:58]
  wire  _GEN_220 = 7'h5c == _T_1[6:0] ? content_92 : _GEN_219; // @[Cat.scala 29:58]
  wire  _GEN_221 = 7'h5d == _T_1[6:0] ? content_93 : _GEN_220; // @[Cat.scala 29:58]
  wire  _GEN_222 = 7'h5e == _T_1[6:0] ? content_94 : _GEN_221; // @[Cat.scala 29:58]
  wire  _GEN_223 = 7'h5f == _T_1[6:0] ? content_95 : _GEN_222; // @[Cat.scala 29:58]
  wire  _GEN_224 = 7'h60 == _T_1[6:0] ? content_96 : _GEN_223; // @[Cat.scala 29:58]
  wire  _GEN_225 = 7'h61 == _T_1[6:0] ? content_97 : _GEN_224; // @[Cat.scala 29:58]
  wire  _GEN_226 = 7'h62 == _T_1[6:0] ? content_98 : _GEN_225; // @[Cat.scala 29:58]
  wire  _GEN_227 = 7'h63 == _T_1[6:0] ? content_99 : _GEN_226; // @[Cat.scala 29:58]
  wire  _GEN_228 = 7'h64 == _T_1[6:0] ? content_100 : _GEN_227; // @[Cat.scala 29:58]
  wire  _GEN_229 = 7'h65 == _T_1[6:0] ? content_101 : _GEN_228; // @[Cat.scala 29:58]
  wire  _GEN_230 = 7'h66 == _T_1[6:0] ? content_102 : _GEN_229; // @[Cat.scala 29:58]
  wire  _GEN_231 = 7'h67 == _T_1[6:0] ? content_103 : _GEN_230; // @[Cat.scala 29:58]
  wire  _GEN_232 = 7'h68 == _T_1[6:0] ? content_104 : _GEN_231; // @[Cat.scala 29:58]
  wire  _GEN_233 = 7'h69 == _T_1[6:0] ? content_105 : _GEN_232; // @[Cat.scala 29:58]
  wire  _GEN_234 = 7'h6a == _T_1[6:0] ? content_106 : _GEN_233; // @[Cat.scala 29:58]
  wire  _GEN_235 = 7'h6b == _T_1[6:0] ? content_107 : _GEN_234; // @[Cat.scala 29:58]
  wire  _GEN_236 = 7'h6c == _T_1[6:0] ? content_108 : _GEN_235; // @[Cat.scala 29:58]
  wire  _GEN_237 = 7'h6d == _T_1[6:0] ? content_109 : _GEN_236; // @[Cat.scala 29:58]
  wire  _GEN_238 = 7'h6e == _T_1[6:0] ? content_110 : _GEN_237; // @[Cat.scala 29:58]
  wire  _GEN_239 = 7'h6f == _T_1[6:0] ? content_111 : _GEN_238; // @[Cat.scala 29:58]
  wire  _GEN_240 = 7'h70 == _T_1[6:0] ? content_112 : _GEN_239; // @[Cat.scala 29:58]
  wire  _GEN_241 = 7'h71 == _T_1[6:0] ? content_113 : _GEN_240; // @[Cat.scala 29:58]
  wire  _GEN_242 = 7'h72 == _T_1[6:0] ? content_114 : _GEN_241; // @[Cat.scala 29:58]
  wire  _GEN_243 = 7'h73 == _T_1[6:0] ? content_115 : _GEN_242; // @[Cat.scala 29:58]
  wire  _GEN_244 = 7'h74 == _T_1[6:0] ? content_116 : _GEN_243; // @[Cat.scala 29:58]
  wire  _GEN_245 = 7'h75 == _T_1[6:0] ? content_117 : _GEN_244; // @[Cat.scala 29:58]
  wire  _GEN_246 = 7'h76 == _T_1[6:0] ? content_118 : _GEN_245; // @[Cat.scala 29:58]
  wire  _GEN_247 = 7'h77 == _T_1[6:0] ? content_119 : _GEN_246; // @[Cat.scala 29:58]
  wire  _GEN_248 = 7'h78 == _T_1[6:0] ? content_120 : _GEN_247; // @[Cat.scala 29:58]
  wire  _GEN_249 = 7'h79 == _T_1[6:0] ? content_121 : _GEN_248; // @[Cat.scala 29:58]
  wire  _GEN_250 = 7'h7a == _T_1[6:0] ? content_122 : _GEN_249; // @[Cat.scala 29:58]
  wire  _GEN_251 = 7'h7b == _T_1[6:0] ? content_123 : _GEN_250; // @[Cat.scala 29:58]
  wire  _GEN_252 = 7'h7c == _T_1[6:0] ? content_124 : _GEN_251; // @[Cat.scala 29:58]
  wire  _GEN_253 = 7'h7d == _T_1[6:0] ? content_125 : _GEN_252; // @[Cat.scala 29:58]
  wire  _GEN_254 = 7'h7e == _T_1[6:0] ? content_126 : _GEN_253; // @[Cat.scala 29:58]
  wire  _GEN_255 = 7'h7f == _T_1[6:0] ? content_127 : _GEN_254; // @[Cat.scala 29:58]
  wire [1:0] _T_7 = {_GEN_127,_GEN_255}; // @[Cat.scala 29:58]
  wire [64:0] _T_18 = {{1'd0}, io_port_1_read_in_bits_addr}; // @[elements.scala 118:104]
  wire [63:0] _T_22 = io_port_1_read_in_bits_addr + 64'h1; // @[elements.scala 118:104]
  wire  _GEN_515 = 7'h1 == _T_22[6:0] ? content_1 : content_0; // @[Cat.scala 29:58]
  wire  _GEN_516 = 7'h2 == _T_22[6:0] ? content_2 : _GEN_515; // @[Cat.scala 29:58]
  wire  _GEN_517 = 7'h3 == _T_22[6:0] ? content_3 : _GEN_516; // @[Cat.scala 29:58]
  wire  _GEN_518 = 7'h4 == _T_22[6:0] ? content_4 : _GEN_517; // @[Cat.scala 29:58]
  wire  _GEN_519 = 7'h5 == _T_22[6:0] ? content_5 : _GEN_518; // @[Cat.scala 29:58]
  wire  _GEN_520 = 7'h6 == _T_22[6:0] ? content_6 : _GEN_519; // @[Cat.scala 29:58]
  wire  _GEN_521 = 7'h7 == _T_22[6:0] ? content_7 : _GEN_520; // @[Cat.scala 29:58]
  wire  _GEN_522 = 7'h8 == _T_22[6:0] ? content_8 : _GEN_521; // @[Cat.scala 29:58]
  wire  _GEN_523 = 7'h9 == _T_22[6:0] ? content_9 : _GEN_522; // @[Cat.scala 29:58]
  wire  _GEN_524 = 7'ha == _T_22[6:0] ? content_10 : _GEN_523; // @[Cat.scala 29:58]
  wire  _GEN_525 = 7'hb == _T_22[6:0] ? content_11 : _GEN_524; // @[Cat.scala 29:58]
  wire  _GEN_526 = 7'hc == _T_22[6:0] ? content_12 : _GEN_525; // @[Cat.scala 29:58]
  wire  _GEN_527 = 7'hd == _T_22[6:0] ? content_13 : _GEN_526; // @[Cat.scala 29:58]
  wire  _GEN_528 = 7'he == _T_22[6:0] ? content_14 : _GEN_527; // @[Cat.scala 29:58]
  wire  _GEN_529 = 7'hf == _T_22[6:0] ? content_15 : _GEN_528; // @[Cat.scala 29:58]
  wire  _GEN_530 = 7'h10 == _T_22[6:0] ? content_16 : _GEN_529; // @[Cat.scala 29:58]
  wire  _GEN_531 = 7'h11 == _T_22[6:0] ? content_17 : _GEN_530; // @[Cat.scala 29:58]
  wire  _GEN_532 = 7'h12 == _T_22[6:0] ? content_18 : _GEN_531; // @[Cat.scala 29:58]
  wire  _GEN_533 = 7'h13 == _T_22[6:0] ? content_19 : _GEN_532; // @[Cat.scala 29:58]
  wire  _GEN_534 = 7'h14 == _T_22[6:0] ? content_20 : _GEN_533; // @[Cat.scala 29:58]
  wire  _GEN_535 = 7'h15 == _T_22[6:0] ? content_21 : _GEN_534; // @[Cat.scala 29:58]
  wire  _GEN_536 = 7'h16 == _T_22[6:0] ? content_22 : _GEN_535; // @[Cat.scala 29:58]
  wire  _GEN_537 = 7'h17 == _T_22[6:0] ? content_23 : _GEN_536; // @[Cat.scala 29:58]
  wire  _GEN_538 = 7'h18 == _T_22[6:0] ? content_24 : _GEN_537; // @[Cat.scala 29:58]
  wire  _GEN_539 = 7'h19 == _T_22[6:0] ? content_25 : _GEN_538; // @[Cat.scala 29:58]
  wire  _GEN_540 = 7'h1a == _T_22[6:0] ? content_26 : _GEN_539; // @[Cat.scala 29:58]
  wire  _GEN_541 = 7'h1b == _T_22[6:0] ? content_27 : _GEN_540; // @[Cat.scala 29:58]
  wire  _GEN_542 = 7'h1c == _T_22[6:0] ? content_28 : _GEN_541; // @[Cat.scala 29:58]
  wire  _GEN_543 = 7'h1d == _T_22[6:0] ? content_29 : _GEN_542; // @[Cat.scala 29:58]
  wire  _GEN_544 = 7'h1e == _T_22[6:0] ? content_30 : _GEN_543; // @[Cat.scala 29:58]
  wire  _GEN_545 = 7'h1f == _T_22[6:0] ? content_31 : _GEN_544; // @[Cat.scala 29:58]
  wire  _GEN_546 = 7'h20 == _T_22[6:0] ? content_32 : _GEN_545; // @[Cat.scala 29:58]
  wire  _GEN_547 = 7'h21 == _T_22[6:0] ? content_33 : _GEN_546; // @[Cat.scala 29:58]
  wire  _GEN_548 = 7'h22 == _T_22[6:0] ? content_34 : _GEN_547; // @[Cat.scala 29:58]
  wire  _GEN_549 = 7'h23 == _T_22[6:0] ? content_35 : _GEN_548; // @[Cat.scala 29:58]
  wire  _GEN_550 = 7'h24 == _T_22[6:0] ? content_36 : _GEN_549; // @[Cat.scala 29:58]
  wire  _GEN_551 = 7'h25 == _T_22[6:0] ? content_37 : _GEN_550; // @[Cat.scala 29:58]
  wire  _GEN_552 = 7'h26 == _T_22[6:0] ? content_38 : _GEN_551; // @[Cat.scala 29:58]
  wire  _GEN_553 = 7'h27 == _T_22[6:0] ? content_39 : _GEN_552; // @[Cat.scala 29:58]
  wire  _GEN_554 = 7'h28 == _T_22[6:0] ? content_40 : _GEN_553; // @[Cat.scala 29:58]
  wire  _GEN_555 = 7'h29 == _T_22[6:0] ? content_41 : _GEN_554; // @[Cat.scala 29:58]
  wire  _GEN_556 = 7'h2a == _T_22[6:0] ? content_42 : _GEN_555; // @[Cat.scala 29:58]
  wire  _GEN_557 = 7'h2b == _T_22[6:0] ? content_43 : _GEN_556; // @[Cat.scala 29:58]
  wire  _GEN_558 = 7'h2c == _T_22[6:0] ? content_44 : _GEN_557; // @[Cat.scala 29:58]
  wire  _GEN_559 = 7'h2d == _T_22[6:0] ? content_45 : _GEN_558; // @[Cat.scala 29:58]
  wire  _GEN_560 = 7'h2e == _T_22[6:0] ? content_46 : _GEN_559; // @[Cat.scala 29:58]
  wire  _GEN_561 = 7'h2f == _T_22[6:0] ? content_47 : _GEN_560; // @[Cat.scala 29:58]
  wire  _GEN_562 = 7'h30 == _T_22[6:0] ? content_48 : _GEN_561; // @[Cat.scala 29:58]
  wire  _GEN_563 = 7'h31 == _T_22[6:0] ? content_49 : _GEN_562; // @[Cat.scala 29:58]
  wire  _GEN_564 = 7'h32 == _T_22[6:0] ? content_50 : _GEN_563; // @[Cat.scala 29:58]
  wire  _GEN_565 = 7'h33 == _T_22[6:0] ? content_51 : _GEN_564; // @[Cat.scala 29:58]
  wire  _GEN_566 = 7'h34 == _T_22[6:0] ? content_52 : _GEN_565; // @[Cat.scala 29:58]
  wire  _GEN_567 = 7'h35 == _T_22[6:0] ? content_53 : _GEN_566; // @[Cat.scala 29:58]
  wire  _GEN_568 = 7'h36 == _T_22[6:0] ? content_54 : _GEN_567; // @[Cat.scala 29:58]
  wire  _GEN_569 = 7'h37 == _T_22[6:0] ? content_55 : _GEN_568; // @[Cat.scala 29:58]
  wire  _GEN_570 = 7'h38 == _T_22[6:0] ? content_56 : _GEN_569; // @[Cat.scala 29:58]
  wire  _GEN_571 = 7'h39 == _T_22[6:0] ? content_57 : _GEN_570; // @[Cat.scala 29:58]
  wire  _GEN_572 = 7'h3a == _T_22[6:0] ? content_58 : _GEN_571; // @[Cat.scala 29:58]
  wire  _GEN_573 = 7'h3b == _T_22[6:0] ? content_59 : _GEN_572; // @[Cat.scala 29:58]
  wire  _GEN_574 = 7'h3c == _T_22[6:0] ? content_60 : _GEN_573; // @[Cat.scala 29:58]
  wire  _GEN_575 = 7'h3d == _T_22[6:0] ? content_61 : _GEN_574; // @[Cat.scala 29:58]
  wire  _GEN_576 = 7'h3e == _T_22[6:0] ? content_62 : _GEN_575; // @[Cat.scala 29:58]
  wire  _GEN_577 = 7'h3f == _T_22[6:0] ? content_63 : _GEN_576; // @[Cat.scala 29:58]
  wire  _GEN_578 = 7'h40 == _T_22[6:0] ? content_64 : _GEN_577; // @[Cat.scala 29:58]
  wire  _GEN_579 = 7'h41 == _T_22[6:0] ? content_65 : _GEN_578; // @[Cat.scala 29:58]
  wire  _GEN_580 = 7'h42 == _T_22[6:0] ? content_66 : _GEN_579; // @[Cat.scala 29:58]
  wire  _GEN_581 = 7'h43 == _T_22[6:0] ? content_67 : _GEN_580; // @[Cat.scala 29:58]
  wire  _GEN_582 = 7'h44 == _T_22[6:0] ? content_68 : _GEN_581; // @[Cat.scala 29:58]
  wire  _GEN_583 = 7'h45 == _T_22[6:0] ? content_69 : _GEN_582; // @[Cat.scala 29:58]
  wire  _GEN_584 = 7'h46 == _T_22[6:0] ? content_70 : _GEN_583; // @[Cat.scala 29:58]
  wire  _GEN_585 = 7'h47 == _T_22[6:0] ? content_71 : _GEN_584; // @[Cat.scala 29:58]
  wire  _GEN_586 = 7'h48 == _T_22[6:0] ? content_72 : _GEN_585; // @[Cat.scala 29:58]
  wire  _GEN_587 = 7'h49 == _T_22[6:0] ? content_73 : _GEN_586; // @[Cat.scala 29:58]
  wire  _GEN_588 = 7'h4a == _T_22[6:0] ? content_74 : _GEN_587; // @[Cat.scala 29:58]
  wire  _GEN_589 = 7'h4b == _T_22[6:0] ? content_75 : _GEN_588; // @[Cat.scala 29:58]
  wire  _GEN_590 = 7'h4c == _T_22[6:0] ? content_76 : _GEN_589; // @[Cat.scala 29:58]
  wire  _GEN_591 = 7'h4d == _T_22[6:0] ? content_77 : _GEN_590; // @[Cat.scala 29:58]
  wire  _GEN_592 = 7'h4e == _T_22[6:0] ? content_78 : _GEN_591; // @[Cat.scala 29:58]
  wire  _GEN_593 = 7'h4f == _T_22[6:0] ? content_79 : _GEN_592; // @[Cat.scala 29:58]
  wire  _GEN_594 = 7'h50 == _T_22[6:0] ? content_80 : _GEN_593; // @[Cat.scala 29:58]
  wire  _GEN_595 = 7'h51 == _T_22[6:0] ? content_81 : _GEN_594; // @[Cat.scala 29:58]
  wire  _GEN_596 = 7'h52 == _T_22[6:0] ? content_82 : _GEN_595; // @[Cat.scala 29:58]
  wire  _GEN_597 = 7'h53 == _T_22[6:0] ? content_83 : _GEN_596; // @[Cat.scala 29:58]
  wire  _GEN_598 = 7'h54 == _T_22[6:0] ? content_84 : _GEN_597; // @[Cat.scala 29:58]
  wire  _GEN_599 = 7'h55 == _T_22[6:0] ? content_85 : _GEN_598; // @[Cat.scala 29:58]
  wire  _GEN_600 = 7'h56 == _T_22[6:0] ? content_86 : _GEN_599; // @[Cat.scala 29:58]
  wire  _GEN_601 = 7'h57 == _T_22[6:0] ? content_87 : _GEN_600; // @[Cat.scala 29:58]
  wire  _GEN_602 = 7'h58 == _T_22[6:0] ? content_88 : _GEN_601; // @[Cat.scala 29:58]
  wire  _GEN_603 = 7'h59 == _T_22[6:0] ? content_89 : _GEN_602; // @[Cat.scala 29:58]
  wire  _GEN_604 = 7'h5a == _T_22[6:0] ? content_90 : _GEN_603; // @[Cat.scala 29:58]
  wire  _GEN_605 = 7'h5b == _T_22[6:0] ? content_91 : _GEN_604; // @[Cat.scala 29:58]
  wire  _GEN_606 = 7'h5c == _T_22[6:0] ? content_92 : _GEN_605; // @[Cat.scala 29:58]
  wire  _GEN_607 = 7'h5d == _T_22[6:0] ? content_93 : _GEN_606; // @[Cat.scala 29:58]
  wire  _GEN_608 = 7'h5e == _T_22[6:0] ? content_94 : _GEN_607; // @[Cat.scala 29:58]
  wire  _GEN_609 = 7'h5f == _T_22[6:0] ? content_95 : _GEN_608; // @[Cat.scala 29:58]
  wire  _GEN_610 = 7'h60 == _T_22[6:0] ? content_96 : _GEN_609; // @[Cat.scala 29:58]
  wire  _GEN_611 = 7'h61 == _T_22[6:0] ? content_97 : _GEN_610; // @[Cat.scala 29:58]
  wire  _GEN_612 = 7'h62 == _T_22[6:0] ? content_98 : _GEN_611; // @[Cat.scala 29:58]
  wire  _GEN_613 = 7'h63 == _T_22[6:0] ? content_99 : _GEN_612; // @[Cat.scala 29:58]
  wire  _GEN_614 = 7'h64 == _T_22[6:0] ? content_100 : _GEN_613; // @[Cat.scala 29:58]
  wire  _GEN_615 = 7'h65 == _T_22[6:0] ? content_101 : _GEN_614; // @[Cat.scala 29:58]
  wire  _GEN_616 = 7'h66 == _T_22[6:0] ? content_102 : _GEN_615; // @[Cat.scala 29:58]
  wire  _GEN_617 = 7'h67 == _T_22[6:0] ? content_103 : _GEN_616; // @[Cat.scala 29:58]
  wire  _GEN_618 = 7'h68 == _T_22[6:0] ? content_104 : _GEN_617; // @[Cat.scala 29:58]
  wire  _GEN_619 = 7'h69 == _T_22[6:0] ? content_105 : _GEN_618; // @[Cat.scala 29:58]
  wire  _GEN_620 = 7'h6a == _T_22[6:0] ? content_106 : _GEN_619; // @[Cat.scala 29:58]
  wire  _GEN_621 = 7'h6b == _T_22[6:0] ? content_107 : _GEN_620; // @[Cat.scala 29:58]
  wire  _GEN_622 = 7'h6c == _T_22[6:0] ? content_108 : _GEN_621; // @[Cat.scala 29:58]
  wire  _GEN_623 = 7'h6d == _T_22[6:0] ? content_109 : _GEN_622; // @[Cat.scala 29:58]
  wire  _GEN_624 = 7'h6e == _T_22[6:0] ? content_110 : _GEN_623; // @[Cat.scala 29:58]
  wire  _GEN_625 = 7'h6f == _T_22[6:0] ? content_111 : _GEN_624; // @[Cat.scala 29:58]
  wire  _GEN_626 = 7'h70 == _T_22[6:0] ? content_112 : _GEN_625; // @[Cat.scala 29:58]
  wire  _GEN_627 = 7'h71 == _T_22[6:0] ? content_113 : _GEN_626; // @[Cat.scala 29:58]
  wire  _GEN_628 = 7'h72 == _T_22[6:0] ? content_114 : _GEN_627; // @[Cat.scala 29:58]
  wire  _GEN_629 = 7'h73 == _T_22[6:0] ? content_115 : _GEN_628; // @[Cat.scala 29:58]
  wire  _GEN_630 = 7'h74 == _T_22[6:0] ? content_116 : _GEN_629; // @[Cat.scala 29:58]
  wire  _GEN_631 = 7'h75 == _T_22[6:0] ? content_117 : _GEN_630; // @[Cat.scala 29:58]
  wire  _GEN_632 = 7'h76 == _T_22[6:0] ? content_118 : _GEN_631; // @[Cat.scala 29:58]
  wire  _GEN_633 = 7'h77 == _T_22[6:0] ? content_119 : _GEN_632; // @[Cat.scala 29:58]
  wire  _GEN_634 = 7'h78 == _T_22[6:0] ? content_120 : _GEN_633; // @[Cat.scala 29:58]
  wire  _GEN_635 = 7'h79 == _T_22[6:0] ? content_121 : _GEN_634; // @[Cat.scala 29:58]
  wire  _GEN_636 = 7'h7a == _T_22[6:0] ? content_122 : _GEN_635; // @[Cat.scala 29:58]
  wire  _GEN_637 = 7'h7b == _T_22[6:0] ? content_123 : _GEN_636; // @[Cat.scala 29:58]
  wire  _GEN_638 = 7'h7c == _T_22[6:0] ? content_124 : _GEN_637; // @[Cat.scala 29:58]
  wire  _GEN_639 = 7'h7d == _T_22[6:0] ? content_125 : _GEN_638; // @[Cat.scala 29:58]
  wire  _GEN_640 = 7'h7e == _T_22[6:0] ? content_126 : _GEN_639; // @[Cat.scala 29:58]
  wire  _GEN_641 = 7'h7f == _T_22[6:0] ? content_127 : _GEN_640; // @[Cat.scala 29:58]
  wire  _GEN_643 = 7'h1 == _T_18[6:0] ? content_1 : content_0; // @[Cat.scala 29:58]
  wire  _GEN_644 = 7'h2 == _T_18[6:0] ? content_2 : _GEN_643; // @[Cat.scala 29:58]
  wire  _GEN_645 = 7'h3 == _T_18[6:0] ? content_3 : _GEN_644; // @[Cat.scala 29:58]
  wire  _GEN_646 = 7'h4 == _T_18[6:0] ? content_4 : _GEN_645; // @[Cat.scala 29:58]
  wire  _GEN_647 = 7'h5 == _T_18[6:0] ? content_5 : _GEN_646; // @[Cat.scala 29:58]
  wire  _GEN_648 = 7'h6 == _T_18[6:0] ? content_6 : _GEN_647; // @[Cat.scala 29:58]
  wire  _GEN_649 = 7'h7 == _T_18[6:0] ? content_7 : _GEN_648; // @[Cat.scala 29:58]
  wire  _GEN_650 = 7'h8 == _T_18[6:0] ? content_8 : _GEN_649; // @[Cat.scala 29:58]
  wire  _GEN_651 = 7'h9 == _T_18[6:0] ? content_9 : _GEN_650; // @[Cat.scala 29:58]
  wire  _GEN_652 = 7'ha == _T_18[6:0] ? content_10 : _GEN_651; // @[Cat.scala 29:58]
  wire  _GEN_653 = 7'hb == _T_18[6:0] ? content_11 : _GEN_652; // @[Cat.scala 29:58]
  wire  _GEN_654 = 7'hc == _T_18[6:0] ? content_12 : _GEN_653; // @[Cat.scala 29:58]
  wire  _GEN_655 = 7'hd == _T_18[6:0] ? content_13 : _GEN_654; // @[Cat.scala 29:58]
  wire  _GEN_656 = 7'he == _T_18[6:0] ? content_14 : _GEN_655; // @[Cat.scala 29:58]
  wire  _GEN_657 = 7'hf == _T_18[6:0] ? content_15 : _GEN_656; // @[Cat.scala 29:58]
  wire  _GEN_658 = 7'h10 == _T_18[6:0] ? content_16 : _GEN_657; // @[Cat.scala 29:58]
  wire  _GEN_659 = 7'h11 == _T_18[6:0] ? content_17 : _GEN_658; // @[Cat.scala 29:58]
  wire  _GEN_660 = 7'h12 == _T_18[6:0] ? content_18 : _GEN_659; // @[Cat.scala 29:58]
  wire  _GEN_661 = 7'h13 == _T_18[6:0] ? content_19 : _GEN_660; // @[Cat.scala 29:58]
  wire  _GEN_662 = 7'h14 == _T_18[6:0] ? content_20 : _GEN_661; // @[Cat.scala 29:58]
  wire  _GEN_663 = 7'h15 == _T_18[6:0] ? content_21 : _GEN_662; // @[Cat.scala 29:58]
  wire  _GEN_664 = 7'h16 == _T_18[6:0] ? content_22 : _GEN_663; // @[Cat.scala 29:58]
  wire  _GEN_665 = 7'h17 == _T_18[6:0] ? content_23 : _GEN_664; // @[Cat.scala 29:58]
  wire  _GEN_666 = 7'h18 == _T_18[6:0] ? content_24 : _GEN_665; // @[Cat.scala 29:58]
  wire  _GEN_667 = 7'h19 == _T_18[6:0] ? content_25 : _GEN_666; // @[Cat.scala 29:58]
  wire  _GEN_668 = 7'h1a == _T_18[6:0] ? content_26 : _GEN_667; // @[Cat.scala 29:58]
  wire  _GEN_669 = 7'h1b == _T_18[6:0] ? content_27 : _GEN_668; // @[Cat.scala 29:58]
  wire  _GEN_670 = 7'h1c == _T_18[6:0] ? content_28 : _GEN_669; // @[Cat.scala 29:58]
  wire  _GEN_671 = 7'h1d == _T_18[6:0] ? content_29 : _GEN_670; // @[Cat.scala 29:58]
  wire  _GEN_672 = 7'h1e == _T_18[6:0] ? content_30 : _GEN_671; // @[Cat.scala 29:58]
  wire  _GEN_673 = 7'h1f == _T_18[6:0] ? content_31 : _GEN_672; // @[Cat.scala 29:58]
  wire  _GEN_674 = 7'h20 == _T_18[6:0] ? content_32 : _GEN_673; // @[Cat.scala 29:58]
  wire  _GEN_675 = 7'h21 == _T_18[6:0] ? content_33 : _GEN_674; // @[Cat.scala 29:58]
  wire  _GEN_676 = 7'h22 == _T_18[6:0] ? content_34 : _GEN_675; // @[Cat.scala 29:58]
  wire  _GEN_677 = 7'h23 == _T_18[6:0] ? content_35 : _GEN_676; // @[Cat.scala 29:58]
  wire  _GEN_678 = 7'h24 == _T_18[6:0] ? content_36 : _GEN_677; // @[Cat.scala 29:58]
  wire  _GEN_679 = 7'h25 == _T_18[6:0] ? content_37 : _GEN_678; // @[Cat.scala 29:58]
  wire  _GEN_680 = 7'h26 == _T_18[6:0] ? content_38 : _GEN_679; // @[Cat.scala 29:58]
  wire  _GEN_681 = 7'h27 == _T_18[6:0] ? content_39 : _GEN_680; // @[Cat.scala 29:58]
  wire  _GEN_682 = 7'h28 == _T_18[6:0] ? content_40 : _GEN_681; // @[Cat.scala 29:58]
  wire  _GEN_683 = 7'h29 == _T_18[6:0] ? content_41 : _GEN_682; // @[Cat.scala 29:58]
  wire  _GEN_684 = 7'h2a == _T_18[6:0] ? content_42 : _GEN_683; // @[Cat.scala 29:58]
  wire  _GEN_685 = 7'h2b == _T_18[6:0] ? content_43 : _GEN_684; // @[Cat.scala 29:58]
  wire  _GEN_686 = 7'h2c == _T_18[6:0] ? content_44 : _GEN_685; // @[Cat.scala 29:58]
  wire  _GEN_687 = 7'h2d == _T_18[6:0] ? content_45 : _GEN_686; // @[Cat.scala 29:58]
  wire  _GEN_688 = 7'h2e == _T_18[6:0] ? content_46 : _GEN_687; // @[Cat.scala 29:58]
  wire  _GEN_689 = 7'h2f == _T_18[6:0] ? content_47 : _GEN_688; // @[Cat.scala 29:58]
  wire  _GEN_690 = 7'h30 == _T_18[6:0] ? content_48 : _GEN_689; // @[Cat.scala 29:58]
  wire  _GEN_691 = 7'h31 == _T_18[6:0] ? content_49 : _GEN_690; // @[Cat.scala 29:58]
  wire  _GEN_692 = 7'h32 == _T_18[6:0] ? content_50 : _GEN_691; // @[Cat.scala 29:58]
  wire  _GEN_693 = 7'h33 == _T_18[6:0] ? content_51 : _GEN_692; // @[Cat.scala 29:58]
  wire  _GEN_694 = 7'h34 == _T_18[6:0] ? content_52 : _GEN_693; // @[Cat.scala 29:58]
  wire  _GEN_695 = 7'h35 == _T_18[6:0] ? content_53 : _GEN_694; // @[Cat.scala 29:58]
  wire  _GEN_696 = 7'h36 == _T_18[6:0] ? content_54 : _GEN_695; // @[Cat.scala 29:58]
  wire  _GEN_697 = 7'h37 == _T_18[6:0] ? content_55 : _GEN_696; // @[Cat.scala 29:58]
  wire  _GEN_698 = 7'h38 == _T_18[6:0] ? content_56 : _GEN_697; // @[Cat.scala 29:58]
  wire  _GEN_699 = 7'h39 == _T_18[6:0] ? content_57 : _GEN_698; // @[Cat.scala 29:58]
  wire  _GEN_700 = 7'h3a == _T_18[6:0] ? content_58 : _GEN_699; // @[Cat.scala 29:58]
  wire  _GEN_701 = 7'h3b == _T_18[6:0] ? content_59 : _GEN_700; // @[Cat.scala 29:58]
  wire  _GEN_702 = 7'h3c == _T_18[6:0] ? content_60 : _GEN_701; // @[Cat.scala 29:58]
  wire  _GEN_703 = 7'h3d == _T_18[6:0] ? content_61 : _GEN_702; // @[Cat.scala 29:58]
  wire  _GEN_704 = 7'h3e == _T_18[6:0] ? content_62 : _GEN_703; // @[Cat.scala 29:58]
  wire  _GEN_705 = 7'h3f == _T_18[6:0] ? content_63 : _GEN_704; // @[Cat.scala 29:58]
  wire  _GEN_706 = 7'h40 == _T_18[6:0] ? content_64 : _GEN_705; // @[Cat.scala 29:58]
  wire  _GEN_707 = 7'h41 == _T_18[6:0] ? content_65 : _GEN_706; // @[Cat.scala 29:58]
  wire  _GEN_708 = 7'h42 == _T_18[6:0] ? content_66 : _GEN_707; // @[Cat.scala 29:58]
  wire  _GEN_709 = 7'h43 == _T_18[6:0] ? content_67 : _GEN_708; // @[Cat.scala 29:58]
  wire  _GEN_710 = 7'h44 == _T_18[6:0] ? content_68 : _GEN_709; // @[Cat.scala 29:58]
  wire  _GEN_711 = 7'h45 == _T_18[6:0] ? content_69 : _GEN_710; // @[Cat.scala 29:58]
  wire  _GEN_712 = 7'h46 == _T_18[6:0] ? content_70 : _GEN_711; // @[Cat.scala 29:58]
  wire  _GEN_713 = 7'h47 == _T_18[6:0] ? content_71 : _GEN_712; // @[Cat.scala 29:58]
  wire  _GEN_714 = 7'h48 == _T_18[6:0] ? content_72 : _GEN_713; // @[Cat.scala 29:58]
  wire  _GEN_715 = 7'h49 == _T_18[6:0] ? content_73 : _GEN_714; // @[Cat.scala 29:58]
  wire  _GEN_716 = 7'h4a == _T_18[6:0] ? content_74 : _GEN_715; // @[Cat.scala 29:58]
  wire  _GEN_717 = 7'h4b == _T_18[6:0] ? content_75 : _GEN_716; // @[Cat.scala 29:58]
  wire  _GEN_718 = 7'h4c == _T_18[6:0] ? content_76 : _GEN_717; // @[Cat.scala 29:58]
  wire  _GEN_719 = 7'h4d == _T_18[6:0] ? content_77 : _GEN_718; // @[Cat.scala 29:58]
  wire  _GEN_720 = 7'h4e == _T_18[6:0] ? content_78 : _GEN_719; // @[Cat.scala 29:58]
  wire  _GEN_721 = 7'h4f == _T_18[6:0] ? content_79 : _GEN_720; // @[Cat.scala 29:58]
  wire  _GEN_722 = 7'h50 == _T_18[6:0] ? content_80 : _GEN_721; // @[Cat.scala 29:58]
  wire  _GEN_723 = 7'h51 == _T_18[6:0] ? content_81 : _GEN_722; // @[Cat.scala 29:58]
  wire  _GEN_724 = 7'h52 == _T_18[6:0] ? content_82 : _GEN_723; // @[Cat.scala 29:58]
  wire  _GEN_725 = 7'h53 == _T_18[6:0] ? content_83 : _GEN_724; // @[Cat.scala 29:58]
  wire  _GEN_726 = 7'h54 == _T_18[6:0] ? content_84 : _GEN_725; // @[Cat.scala 29:58]
  wire  _GEN_727 = 7'h55 == _T_18[6:0] ? content_85 : _GEN_726; // @[Cat.scala 29:58]
  wire  _GEN_728 = 7'h56 == _T_18[6:0] ? content_86 : _GEN_727; // @[Cat.scala 29:58]
  wire  _GEN_729 = 7'h57 == _T_18[6:0] ? content_87 : _GEN_728; // @[Cat.scala 29:58]
  wire  _GEN_730 = 7'h58 == _T_18[6:0] ? content_88 : _GEN_729; // @[Cat.scala 29:58]
  wire  _GEN_731 = 7'h59 == _T_18[6:0] ? content_89 : _GEN_730; // @[Cat.scala 29:58]
  wire  _GEN_732 = 7'h5a == _T_18[6:0] ? content_90 : _GEN_731; // @[Cat.scala 29:58]
  wire  _GEN_733 = 7'h5b == _T_18[6:0] ? content_91 : _GEN_732; // @[Cat.scala 29:58]
  wire  _GEN_734 = 7'h5c == _T_18[6:0] ? content_92 : _GEN_733; // @[Cat.scala 29:58]
  wire  _GEN_735 = 7'h5d == _T_18[6:0] ? content_93 : _GEN_734; // @[Cat.scala 29:58]
  wire  _GEN_736 = 7'h5e == _T_18[6:0] ? content_94 : _GEN_735; // @[Cat.scala 29:58]
  wire  _GEN_737 = 7'h5f == _T_18[6:0] ? content_95 : _GEN_736; // @[Cat.scala 29:58]
  wire  _GEN_738 = 7'h60 == _T_18[6:0] ? content_96 : _GEN_737; // @[Cat.scala 29:58]
  wire  _GEN_739 = 7'h61 == _T_18[6:0] ? content_97 : _GEN_738; // @[Cat.scala 29:58]
  wire  _GEN_740 = 7'h62 == _T_18[6:0] ? content_98 : _GEN_739; // @[Cat.scala 29:58]
  wire  _GEN_741 = 7'h63 == _T_18[6:0] ? content_99 : _GEN_740; // @[Cat.scala 29:58]
  wire  _GEN_742 = 7'h64 == _T_18[6:0] ? content_100 : _GEN_741; // @[Cat.scala 29:58]
  wire  _GEN_743 = 7'h65 == _T_18[6:0] ? content_101 : _GEN_742; // @[Cat.scala 29:58]
  wire  _GEN_744 = 7'h66 == _T_18[6:0] ? content_102 : _GEN_743; // @[Cat.scala 29:58]
  wire  _GEN_745 = 7'h67 == _T_18[6:0] ? content_103 : _GEN_744; // @[Cat.scala 29:58]
  wire  _GEN_746 = 7'h68 == _T_18[6:0] ? content_104 : _GEN_745; // @[Cat.scala 29:58]
  wire  _GEN_747 = 7'h69 == _T_18[6:0] ? content_105 : _GEN_746; // @[Cat.scala 29:58]
  wire  _GEN_748 = 7'h6a == _T_18[6:0] ? content_106 : _GEN_747; // @[Cat.scala 29:58]
  wire  _GEN_749 = 7'h6b == _T_18[6:0] ? content_107 : _GEN_748; // @[Cat.scala 29:58]
  wire  _GEN_750 = 7'h6c == _T_18[6:0] ? content_108 : _GEN_749; // @[Cat.scala 29:58]
  wire  _GEN_751 = 7'h6d == _T_18[6:0] ? content_109 : _GEN_750; // @[Cat.scala 29:58]
  wire  _GEN_752 = 7'h6e == _T_18[6:0] ? content_110 : _GEN_751; // @[Cat.scala 29:58]
  wire  _GEN_753 = 7'h6f == _T_18[6:0] ? content_111 : _GEN_752; // @[Cat.scala 29:58]
  wire  _GEN_754 = 7'h70 == _T_18[6:0] ? content_112 : _GEN_753; // @[Cat.scala 29:58]
  wire  _GEN_755 = 7'h71 == _T_18[6:0] ? content_113 : _GEN_754; // @[Cat.scala 29:58]
  wire  _GEN_756 = 7'h72 == _T_18[6:0] ? content_114 : _GEN_755; // @[Cat.scala 29:58]
  wire  _GEN_757 = 7'h73 == _T_18[6:0] ? content_115 : _GEN_756; // @[Cat.scala 29:58]
  wire  _GEN_758 = 7'h74 == _T_18[6:0] ? content_116 : _GEN_757; // @[Cat.scala 29:58]
  wire  _GEN_759 = 7'h75 == _T_18[6:0] ? content_117 : _GEN_758; // @[Cat.scala 29:58]
  wire  _GEN_760 = 7'h76 == _T_18[6:0] ? content_118 : _GEN_759; // @[Cat.scala 29:58]
  wire  _GEN_761 = 7'h77 == _T_18[6:0] ? content_119 : _GEN_760; // @[Cat.scala 29:58]
  wire  _GEN_762 = 7'h78 == _T_18[6:0] ? content_120 : _GEN_761; // @[Cat.scala 29:58]
  wire  _GEN_763 = 7'h79 == _T_18[6:0] ? content_121 : _GEN_762; // @[Cat.scala 29:58]
  wire  _GEN_764 = 7'h7a == _T_18[6:0] ? content_122 : _GEN_763; // @[Cat.scala 29:58]
  wire  _GEN_765 = 7'h7b == _T_18[6:0] ? content_123 : _GEN_764; // @[Cat.scala 29:58]
  wire  _GEN_766 = 7'h7c == _T_18[6:0] ? content_124 : _GEN_765; // @[Cat.scala 29:58]
  wire  _GEN_767 = 7'h7d == _T_18[6:0] ? content_125 : _GEN_766; // @[Cat.scala 29:58]
  wire  _GEN_768 = 7'h7e == _T_18[6:0] ? content_126 : _GEN_767; // @[Cat.scala 29:58]
  wire  _GEN_769 = 7'h7f == _T_18[6:0] ? content_127 : _GEN_768; // @[Cat.scala 29:58]
  wire [1:0] _T_24 = {_GEN_641,_GEN_769}; // @[Cat.scala 29:58]
  assign io_port_0_read_out_0 = io_port_0_read_in_valid & _T_7[0]; // @[elements.scala 118:33 elements.scala 120:33]
  assign io_port_0_read_out_1 = io_port_0_read_in_valid & _T_7[1]; // @[elements.scala 118:33 elements.scala 120:33]
  assign io_port_1_read_out_0 = io_port_1_read_in_valid & _T_24[0]; // @[elements.scala 118:33 elements.scala 120:33]
  assign io_port_1_read_out_1 = io_port_1_read_in_valid & _T_24[1]; // @[elements.scala 118:33 elements.scala 120:33]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  content_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  content_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  content_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  content_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  content_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  content_5 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  content_6 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  content_7 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  content_8 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  content_9 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  content_10 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  content_11 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  content_12 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  content_13 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  content_14 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  content_15 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  content_16 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  content_17 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  content_18 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  content_19 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  content_20 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  content_21 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  content_22 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  content_23 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  content_24 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  content_25 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  content_26 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  content_27 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  content_28 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  content_29 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  content_30 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  content_31 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  content_32 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  content_33 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  content_34 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  content_35 = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  content_36 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  content_37 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  content_38 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  content_39 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  content_40 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  content_41 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  content_42 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  content_43 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  content_44 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  content_45 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  content_46 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  content_47 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  content_48 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  content_49 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  content_50 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  content_51 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  content_52 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  content_53 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  content_54 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  content_55 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  content_56 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  content_57 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  content_58 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  content_59 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  content_60 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  content_61 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  content_62 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  content_63 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  content_64 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  content_65 = _RAND_65[0:0];
  _RAND_66 = {1{`RANDOM}};
  content_66 = _RAND_66[0:0];
  _RAND_67 = {1{`RANDOM}};
  content_67 = _RAND_67[0:0];
  _RAND_68 = {1{`RANDOM}};
  content_68 = _RAND_68[0:0];
  _RAND_69 = {1{`RANDOM}};
  content_69 = _RAND_69[0:0];
  _RAND_70 = {1{`RANDOM}};
  content_70 = _RAND_70[0:0];
  _RAND_71 = {1{`RANDOM}};
  content_71 = _RAND_71[0:0];
  _RAND_72 = {1{`RANDOM}};
  content_72 = _RAND_72[0:0];
  _RAND_73 = {1{`RANDOM}};
  content_73 = _RAND_73[0:0];
  _RAND_74 = {1{`RANDOM}};
  content_74 = _RAND_74[0:0];
  _RAND_75 = {1{`RANDOM}};
  content_75 = _RAND_75[0:0];
  _RAND_76 = {1{`RANDOM}};
  content_76 = _RAND_76[0:0];
  _RAND_77 = {1{`RANDOM}};
  content_77 = _RAND_77[0:0];
  _RAND_78 = {1{`RANDOM}};
  content_78 = _RAND_78[0:0];
  _RAND_79 = {1{`RANDOM}};
  content_79 = _RAND_79[0:0];
  _RAND_80 = {1{`RANDOM}};
  content_80 = _RAND_80[0:0];
  _RAND_81 = {1{`RANDOM}};
  content_81 = _RAND_81[0:0];
  _RAND_82 = {1{`RANDOM}};
  content_82 = _RAND_82[0:0];
  _RAND_83 = {1{`RANDOM}};
  content_83 = _RAND_83[0:0];
  _RAND_84 = {1{`RANDOM}};
  content_84 = _RAND_84[0:0];
  _RAND_85 = {1{`RANDOM}};
  content_85 = _RAND_85[0:0];
  _RAND_86 = {1{`RANDOM}};
  content_86 = _RAND_86[0:0];
  _RAND_87 = {1{`RANDOM}};
  content_87 = _RAND_87[0:0];
  _RAND_88 = {1{`RANDOM}};
  content_88 = _RAND_88[0:0];
  _RAND_89 = {1{`RANDOM}};
  content_89 = _RAND_89[0:0];
  _RAND_90 = {1{`RANDOM}};
  content_90 = _RAND_90[0:0];
  _RAND_91 = {1{`RANDOM}};
  content_91 = _RAND_91[0:0];
  _RAND_92 = {1{`RANDOM}};
  content_92 = _RAND_92[0:0];
  _RAND_93 = {1{`RANDOM}};
  content_93 = _RAND_93[0:0];
  _RAND_94 = {1{`RANDOM}};
  content_94 = _RAND_94[0:0];
  _RAND_95 = {1{`RANDOM}};
  content_95 = _RAND_95[0:0];
  _RAND_96 = {1{`RANDOM}};
  content_96 = _RAND_96[0:0];
  _RAND_97 = {1{`RANDOM}};
  content_97 = _RAND_97[0:0];
  _RAND_98 = {1{`RANDOM}};
  content_98 = _RAND_98[0:0];
  _RAND_99 = {1{`RANDOM}};
  content_99 = _RAND_99[0:0];
  _RAND_100 = {1{`RANDOM}};
  content_100 = _RAND_100[0:0];
  _RAND_101 = {1{`RANDOM}};
  content_101 = _RAND_101[0:0];
  _RAND_102 = {1{`RANDOM}};
  content_102 = _RAND_102[0:0];
  _RAND_103 = {1{`RANDOM}};
  content_103 = _RAND_103[0:0];
  _RAND_104 = {1{`RANDOM}};
  content_104 = _RAND_104[0:0];
  _RAND_105 = {1{`RANDOM}};
  content_105 = _RAND_105[0:0];
  _RAND_106 = {1{`RANDOM}};
  content_106 = _RAND_106[0:0];
  _RAND_107 = {1{`RANDOM}};
  content_107 = _RAND_107[0:0];
  _RAND_108 = {1{`RANDOM}};
  content_108 = _RAND_108[0:0];
  _RAND_109 = {1{`RANDOM}};
  content_109 = _RAND_109[0:0];
  _RAND_110 = {1{`RANDOM}};
  content_110 = _RAND_110[0:0];
  _RAND_111 = {1{`RANDOM}};
  content_111 = _RAND_111[0:0];
  _RAND_112 = {1{`RANDOM}};
  content_112 = _RAND_112[0:0];
  _RAND_113 = {1{`RANDOM}};
  content_113 = _RAND_113[0:0];
  _RAND_114 = {1{`RANDOM}};
  content_114 = _RAND_114[0:0];
  _RAND_115 = {1{`RANDOM}};
  content_115 = _RAND_115[0:0];
  _RAND_116 = {1{`RANDOM}};
  content_116 = _RAND_116[0:0];
  _RAND_117 = {1{`RANDOM}};
  content_117 = _RAND_117[0:0];
  _RAND_118 = {1{`RANDOM}};
  content_118 = _RAND_118[0:0];
  _RAND_119 = {1{`RANDOM}};
  content_119 = _RAND_119[0:0];
  _RAND_120 = {1{`RANDOM}};
  content_120 = _RAND_120[0:0];
  _RAND_121 = {1{`RANDOM}};
  content_121 = _RAND_121[0:0];
  _RAND_122 = {1{`RANDOM}};
  content_122 = _RAND_122[0:0];
  _RAND_123 = {1{`RANDOM}};
  content_123 = _RAND_123[0:0];
  _RAND_124 = {1{`RANDOM}};
  content_124 = _RAND_124[0:0];
  _RAND_125 = {1{`RANDOM}};
  content_125 = _RAND_125[0:0];
  _RAND_126 = {1{`RANDOM}};
  content_126 = _RAND_126[0:0];
  _RAND_127 = {1{`RANDOM}};
  content_127 = _RAND_127[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      content_0 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h0 == io_port_1_write_bits_addr[6:0]) begin
        content_0 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h0 == io_port_0_write_bits_addr[6:0]) begin
          content_0 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h0 == io_port_0_write_bits_addr[6:0]) begin
        content_0 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_1 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h1 == io_port_1_write_bits_addr[6:0]) begin
        content_1 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h1 == io_port_0_write_bits_addr[6:0]) begin
          content_1 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h1 == io_port_0_write_bits_addr[6:0]) begin
        content_1 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_2 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h2 == io_port_1_write_bits_addr[6:0]) begin
        content_2 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h2 == io_port_0_write_bits_addr[6:0]) begin
          content_2 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h2 == io_port_0_write_bits_addr[6:0]) begin
        content_2 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_3 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h3 == io_port_1_write_bits_addr[6:0]) begin
        content_3 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h3 == io_port_0_write_bits_addr[6:0]) begin
          content_3 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h3 == io_port_0_write_bits_addr[6:0]) begin
        content_3 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_4 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h4 == io_port_1_write_bits_addr[6:0]) begin
        content_4 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h4 == io_port_0_write_bits_addr[6:0]) begin
          content_4 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h4 == io_port_0_write_bits_addr[6:0]) begin
        content_4 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_5 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h5 == io_port_1_write_bits_addr[6:0]) begin
        content_5 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h5 == io_port_0_write_bits_addr[6:0]) begin
          content_5 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h5 == io_port_0_write_bits_addr[6:0]) begin
        content_5 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_6 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h6 == io_port_1_write_bits_addr[6:0]) begin
        content_6 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h6 == io_port_0_write_bits_addr[6:0]) begin
          content_6 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h6 == io_port_0_write_bits_addr[6:0]) begin
        content_6 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_7 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h7 == io_port_1_write_bits_addr[6:0]) begin
        content_7 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h7 == io_port_0_write_bits_addr[6:0]) begin
          content_7 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h7 == io_port_0_write_bits_addr[6:0]) begin
        content_7 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_8 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h8 == io_port_1_write_bits_addr[6:0]) begin
        content_8 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h8 == io_port_0_write_bits_addr[6:0]) begin
          content_8 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h8 == io_port_0_write_bits_addr[6:0]) begin
        content_8 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_9 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h9 == io_port_1_write_bits_addr[6:0]) begin
        content_9 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h9 == io_port_0_write_bits_addr[6:0]) begin
          content_9 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h9 == io_port_0_write_bits_addr[6:0]) begin
        content_9 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_10 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'ha == io_port_1_write_bits_addr[6:0]) begin
        content_10 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'ha == io_port_0_write_bits_addr[6:0]) begin
          content_10 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'ha == io_port_0_write_bits_addr[6:0]) begin
        content_10 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_11 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'hb == io_port_1_write_bits_addr[6:0]) begin
        content_11 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'hb == io_port_0_write_bits_addr[6:0]) begin
          content_11 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'hb == io_port_0_write_bits_addr[6:0]) begin
        content_11 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_12 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'hc == io_port_1_write_bits_addr[6:0]) begin
        content_12 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'hc == io_port_0_write_bits_addr[6:0]) begin
          content_12 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'hc == io_port_0_write_bits_addr[6:0]) begin
        content_12 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_13 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'hd == io_port_1_write_bits_addr[6:0]) begin
        content_13 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'hd == io_port_0_write_bits_addr[6:0]) begin
          content_13 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'hd == io_port_0_write_bits_addr[6:0]) begin
        content_13 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_14 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'he == io_port_1_write_bits_addr[6:0]) begin
        content_14 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'he == io_port_0_write_bits_addr[6:0]) begin
          content_14 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'he == io_port_0_write_bits_addr[6:0]) begin
        content_14 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_15 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'hf == io_port_1_write_bits_addr[6:0]) begin
        content_15 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'hf == io_port_0_write_bits_addr[6:0]) begin
          content_15 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'hf == io_port_0_write_bits_addr[6:0]) begin
        content_15 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_16 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h10 == io_port_1_write_bits_addr[6:0]) begin
        content_16 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h10 == io_port_0_write_bits_addr[6:0]) begin
          content_16 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h10 == io_port_0_write_bits_addr[6:0]) begin
        content_16 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_17 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h11 == io_port_1_write_bits_addr[6:0]) begin
        content_17 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h11 == io_port_0_write_bits_addr[6:0]) begin
          content_17 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h11 == io_port_0_write_bits_addr[6:0]) begin
        content_17 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_18 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h12 == io_port_1_write_bits_addr[6:0]) begin
        content_18 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h12 == io_port_0_write_bits_addr[6:0]) begin
          content_18 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h12 == io_port_0_write_bits_addr[6:0]) begin
        content_18 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_19 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h13 == io_port_1_write_bits_addr[6:0]) begin
        content_19 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h13 == io_port_0_write_bits_addr[6:0]) begin
          content_19 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h13 == io_port_0_write_bits_addr[6:0]) begin
        content_19 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_20 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h14 == io_port_1_write_bits_addr[6:0]) begin
        content_20 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h14 == io_port_0_write_bits_addr[6:0]) begin
          content_20 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h14 == io_port_0_write_bits_addr[6:0]) begin
        content_20 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_21 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h15 == io_port_1_write_bits_addr[6:0]) begin
        content_21 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h15 == io_port_0_write_bits_addr[6:0]) begin
          content_21 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h15 == io_port_0_write_bits_addr[6:0]) begin
        content_21 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_22 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h16 == io_port_1_write_bits_addr[6:0]) begin
        content_22 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h16 == io_port_0_write_bits_addr[6:0]) begin
          content_22 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h16 == io_port_0_write_bits_addr[6:0]) begin
        content_22 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_23 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h17 == io_port_1_write_bits_addr[6:0]) begin
        content_23 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h17 == io_port_0_write_bits_addr[6:0]) begin
          content_23 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h17 == io_port_0_write_bits_addr[6:0]) begin
        content_23 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_24 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h18 == io_port_1_write_bits_addr[6:0]) begin
        content_24 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h18 == io_port_0_write_bits_addr[6:0]) begin
          content_24 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h18 == io_port_0_write_bits_addr[6:0]) begin
        content_24 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_25 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h19 == io_port_1_write_bits_addr[6:0]) begin
        content_25 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h19 == io_port_0_write_bits_addr[6:0]) begin
          content_25 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h19 == io_port_0_write_bits_addr[6:0]) begin
        content_25 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_26 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h1a == io_port_1_write_bits_addr[6:0]) begin
        content_26 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h1a == io_port_0_write_bits_addr[6:0]) begin
          content_26 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h1a == io_port_0_write_bits_addr[6:0]) begin
        content_26 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_27 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h1b == io_port_1_write_bits_addr[6:0]) begin
        content_27 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h1b == io_port_0_write_bits_addr[6:0]) begin
          content_27 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h1b == io_port_0_write_bits_addr[6:0]) begin
        content_27 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_28 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h1c == io_port_1_write_bits_addr[6:0]) begin
        content_28 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h1c == io_port_0_write_bits_addr[6:0]) begin
          content_28 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h1c == io_port_0_write_bits_addr[6:0]) begin
        content_28 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_29 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h1d == io_port_1_write_bits_addr[6:0]) begin
        content_29 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h1d == io_port_0_write_bits_addr[6:0]) begin
          content_29 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h1d == io_port_0_write_bits_addr[6:0]) begin
        content_29 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_30 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h1e == io_port_1_write_bits_addr[6:0]) begin
        content_30 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h1e == io_port_0_write_bits_addr[6:0]) begin
          content_30 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h1e == io_port_0_write_bits_addr[6:0]) begin
        content_30 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_31 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h1f == io_port_1_write_bits_addr[6:0]) begin
        content_31 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h1f == io_port_0_write_bits_addr[6:0]) begin
          content_31 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h1f == io_port_0_write_bits_addr[6:0]) begin
        content_31 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_32 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h20 == io_port_1_write_bits_addr[6:0]) begin
        content_32 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h20 == io_port_0_write_bits_addr[6:0]) begin
          content_32 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h20 == io_port_0_write_bits_addr[6:0]) begin
        content_32 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_33 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h21 == io_port_1_write_bits_addr[6:0]) begin
        content_33 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h21 == io_port_0_write_bits_addr[6:0]) begin
          content_33 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h21 == io_port_0_write_bits_addr[6:0]) begin
        content_33 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_34 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h22 == io_port_1_write_bits_addr[6:0]) begin
        content_34 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h22 == io_port_0_write_bits_addr[6:0]) begin
          content_34 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h22 == io_port_0_write_bits_addr[6:0]) begin
        content_34 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_35 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h23 == io_port_1_write_bits_addr[6:0]) begin
        content_35 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h23 == io_port_0_write_bits_addr[6:0]) begin
          content_35 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h23 == io_port_0_write_bits_addr[6:0]) begin
        content_35 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_36 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h24 == io_port_1_write_bits_addr[6:0]) begin
        content_36 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h24 == io_port_0_write_bits_addr[6:0]) begin
          content_36 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h24 == io_port_0_write_bits_addr[6:0]) begin
        content_36 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_37 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h25 == io_port_1_write_bits_addr[6:0]) begin
        content_37 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h25 == io_port_0_write_bits_addr[6:0]) begin
          content_37 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h25 == io_port_0_write_bits_addr[6:0]) begin
        content_37 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_38 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h26 == io_port_1_write_bits_addr[6:0]) begin
        content_38 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h26 == io_port_0_write_bits_addr[6:0]) begin
          content_38 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h26 == io_port_0_write_bits_addr[6:0]) begin
        content_38 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_39 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h27 == io_port_1_write_bits_addr[6:0]) begin
        content_39 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h27 == io_port_0_write_bits_addr[6:0]) begin
          content_39 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h27 == io_port_0_write_bits_addr[6:0]) begin
        content_39 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_40 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h28 == io_port_1_write_bits_addr[6:0]) begin
        content_40 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h28 == io_port_0_write_bits_addr[6:0]) begin
          content_40 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h28 == io_port_0_write_bits_addr[6:0]) begin
        content_40 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_41 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h29 == io_port_1_write_bits_addr[6:0]) begin
        content_41 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h29 == io_port_0_write_bits_addr[6:0]) begin
          content_41 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h29 == io_port_0_write_bits_addr[6:0]) begin
        content_41 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_42 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h2a == io_port_1_write_bits_addr[6:0]) begin
        content_42 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h2a == io_port_0_write_bits_addr[6:0]) begin
          content_42 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h2a == io_port_0_write_bits_addr[6:0]) begin
        content_42 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_43 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h2b == io_port_1_write_bits_addr[6:0]) begin
        content_43 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h2b == io_port_0_write_bits_addr[6:0]) begin
          content_43 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h2b == io_port_0_write_bits_addr[6:0]) begin
        content_43 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_44 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h2c == io_port_1_write_bits_addr[6:0]) begin
        content_44 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h2c == io_port_0_write_bits_addr[6:0]) begin
          content_44 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h2c == io_port_0_write_bits_addr[6:0]) begin
        content_44 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_45 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h2d == io_port_1_write_bits_addr[6:0]) begin
        content_45 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h2d == io_port_0_write_bits_addr[6:0]) begin
          content_45 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h2d == io_port_0_write_bits_addr[6:0]) begin
        content_45 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_46 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h2e == io_port_1_write_bits_addr[6:0]) begin
        content_46 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h2e == io_port_0_write_bits_addr[6:0]) begin
          content_46 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h2e == io_port_0_write_bits_addr[6:0]) begin
        content_46 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_47 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h2f == io_port_1_write_bits_addr[6:0]) begin
        content_47 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h2f == io_port_0_write_bits_addr[6:0]) begin
          content_47 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h2f == io_port_0_write_bits_addr[6:0]) begin
        content_47 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_48 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h30 == io_port_1_write_bits_addr[6:0]) begin
        content_48 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h30 == io_port_0_write_bits_addr[6:0]) begin
          content_48 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h30 == io_port_0_write_bits_addr[6:0]) begin
        content_48 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_49 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h31 == io_port_1_write_bits_addr[6:0]) begin
        content_49 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h31 == io_port_0_write_bits_addr[6:0]) begin
          content_49 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h31 == io_port_0_write_bits_addr[6:0]) begin
        content_49 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_50 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h32 == io_port_1_write_bits_addr[6:0]) begin
        content_50 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h32 == io_port_0_write_bits_addr[6:0]) begin
          content_50 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h32 == io_port_0_write_bits_addr[6:0]) begin
        content_50 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_51 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h33 == io_port_1_write_bits_addr[6:0]) begin
        content_51 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h33 == io_port_0_write_bits_addr[6:0]) begin
          content_51 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h33 == io_port_0_write_bits_addr[6:0]) begin
        content_51 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_52 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h34 == io_port_1_write_bits_addr[6:0]) begin
        content_52 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h34 == io_port_0_write_bits_addr[6:0]) begin
          content_52 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h34 == io_port_0_write_bits_addr[6:0]) begin
        content_52 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_53 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h35 == io_port_1_write_bits_addr[6:0]) begin
        content_53 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h35 == io_port_0_write_bits_addr[6:0]) begin
          content_53 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h35 == io_port_0_write_bits_addr[6:0]) begin
        content_53 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_54 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h36 == io_port_1_write_bits_addr[6:0]) begin
        content_54 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h36 == io_port_0_write_bits_addr[6:0]) begin
          content_54 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h36 == io_port_0_write_bits_addr[6:0]) begin
        content_54 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_55 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h37 == io_port_1_write_bits_addr[6:0]) begin
        content_55 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h37 == io_port_0_write_bits_addr[6:0]) begin
          content_55 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h37 == io_port_0_write_bits_addr[6:0]) begin
        content_55 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_56 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h38 == io_port_1_write_bits_addr[6:0]) begin
        content_56 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h38 == io_port_0_write_bits_addr[6:0]) begin
          content_56 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h38 == io_port_0_write_bits_addr[6:0]) begin
        content_56 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_57 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h39 == io_port_1_write_bits_addr[6:0]) begin
        content_57 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h39 == io_port_0_write_bits_addr[6:0]) begin
          content_57 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h39 == io_port_0_write_bits_addr[6:0]) begin
        content_57 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_58 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h3a == io_port_1_write_bits_addr[6:0]) begin
        content_58 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h3a == io_port_0_write_bits_addr[6:0]) begin
          content_58 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h3a == io_port_0_write_bits_addr[6:0]) begin
        content_58 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_59 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h3b == io_port_1_write_bits_addr[6:0]) begin
        content_59 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h3b == io_port_0_write_bits_addr[6:0]) begin
          content_59 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h3b == io_port_0_write_bits_addr[6:0]) begin
        content_59 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_60 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h3c == io_port_1_write_bits_addr[6:0]) begin
        content_60 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h3c == io_port_0_write_bits_addr[6:0]) begin
          content_60 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h3c == io_port_0_write_bits_addr[6:0]) begin
        content_60 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_61 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h3d == io_port_1_write_bits_addr[6:0]) begin
        content_61 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h3d == io_port_0_write_bits_addr[6:0]) begin
          content_61 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h3d == io_port_0_write_bits_addr[6:0]) begin
        content_61 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_62 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h3e == io_port_1_write_bits_addr[6:0]) begin
        content_62 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h3e == io_port_0_write_bits_addr[6:0]) begin
          content_62 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h3e == io_port_0_write_bits_addr[6:0]) begin
        content_62 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_63 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h3f == io_port_1_write_bits_addr[6:0]) begin
        content_63 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h3f == io_port_0_write_bits_addr[6:0]) begin
          content_63 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h3f == io_port_0_write_bits_addr[6:0]) begin
        content_63 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_64 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h40 == io_port_1_write_bits_addr[6:0]) begin
        content_64 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h40 == io_port_0_write_bits_addr[6:0]) begin
          content_64 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h40 == io_port_0_write_bits_addr[6:0]) begin
        content_64 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_65 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h41 == io_port_1_write_bits_addr[6:0]) begin
        content_65 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h41 == io_port_0_write_bits_addr[6:0]) begin
          content_65 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h41 == io_port_0_write_bits_addr[6:0]) begin
        content_65 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_66 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h42 == io_port_1_write_bits_addr[6:0]) begin
        content_66 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h42 == io_port_0_write_bits_addr[6:0]) begin
          content_66 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h42 == io_port_0_write_bits_addr[6:0]) begin
        content_66 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_67 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h43 == io_port_1_write_bits_addr[6:0]) begin
        content_67 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h43 == io_port_0_write_bits_addr[6:0]) begin
          content_67 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h43 == io_port_0_write_bits_addr[6:0]) begin
        content_67 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_68 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h44 == io_port_1_write_bits_addr[6:0]) begin
        content_68 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h44 == io_port_0_write_bits_addr[6:0]) begin
          content_68 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h44 == io_port_0_write_bits_addr[6:0]) begin
        content_68 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_69 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h45 == io_port_1_write_bits_addr[6:0]) begin
        content_69 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h45 == io_port_0_write_bits_addr[6:0]) begin
          content_69 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h45 == io_port_0_write_bits_addr[6:0]) begin
        content_69 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_70 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h46 == io_port_1_write_bits_addr[6:0]) begin
        content_70 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h46 == io_port_0_write_bits_addr[6:0]) begin
          content_70 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h46 == io_port_0_write_bits_addr[6:0]) begin
        content_70 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_71 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h47 == io_port_1_write_bits_addr[6:0]) begin
        content_71 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h47 == io_port_0_write_bits_addr[6:0]) begin
          content_71 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h47 == io_port_0_write_bits_addr[6:0]) begin
        content_71 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_72 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h48 == io_port_1_write_bits_addr[6:0]) begin
        content_72 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h48 == io_port_0_write_bits_addr[6:0]) begin
          content_72 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h48 == io_port_0_write_bits_addr[6:0]) begin
        content_72 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_73 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h49 == io_port_1_write_bits_addr[6:0]) begin
        content_73 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h49 == io_port_0_write_bits_addr[6:0]) begin
          content_73 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h49 == io_port_0_write_bits_addr[6:0]) begin
        content_73 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_74 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h4a == io_port_1_write_bits_addr[6:0]) begin
        content_74 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h4a == io_port_0_write_bits_addr[6:0]) begin
          content_74 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h4a == io_port_0_write_bits_addr[6:0]) begin
        content_74 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_75 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h4b == io_port_1_write_bits_addr[6:0]) begin
        content_75 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h4b == io_port_0_write_bits_addr[6:0]) begin
          content_75 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h4b == io_port_0_write_bits_addr[6:0]) begin
        content_75 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_76 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h4c == io_port_1_write_bits_addr[6:0]) begin
        content_76 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h4c == io_port_0_write_bits_addr[6:0]) begin
          content_76 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h4c == io_port_0_write_bits_addr[6:0]) begin
        content_76 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_77 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h4d == io_port_1_write_bits_addr[6:0]) begin
        content_77 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h4d == io_port_0_write_bits_addr[6:0]) begin
          content_77 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h4d == io_port_0_write_bits_addr[6:0]) begin
        content_77 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_78 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h4e == io_port_1_write_bits_addr[6:0]) begin
        content_78 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h4e == io_port_0_write_bits_addr[6:0]) begin
          content_78 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h4e == io_port_0_write_bits_addr[6:0]) begin
        content_78 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_79 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h4f == io_port_1_write_bits_addr[6:0]) begin
        content_79 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h4f == io_port_0_write_bits_addr[6:0]) begin
          content_79 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h4f == io_port_0_write_bits_addr[6:0]) begin
        content_79 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_80 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h50 == io_port_1_write_bits_addr[6:0]) begin
        content_80 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h50 == io_port_0_write_bits_addr[6:0]) begin
          content_80 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h50 == io_port_0_write_bits_addr[6:0]) begin
        content_80 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_81 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h51 == io_port_1_write_bits_addr[6:0]) begin
        content_81 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h51 == io_port_0_write_bits_addr[6:0]) begin
          content_81 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h51 == io_port_0_write_bits_addr[6:0]) begin
        content_81 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_82 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h52 == io_port_1_write_bits_addr[6:0]) begin
        content_82 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h52 == io_port_0_write_bits_addr[6:0]) begin
          content_82 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h52 == io_port_0_write_bits_addr[6:0]) begin
        content_82 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_83 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h53 == io_port_1_write_bits_addr[6:0]) begin
        content_83 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h53 == io_port_0_write_bits_addr[6:0]) begin
          content_83 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h53 == io_port_0_write_bits_addr[6:0]) begin
        content_83 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_84 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h54 == io_port_1_write_bits_addr[6:0]) begin
        content_84 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h54 == io_port_0_write_bits_addr[6:0]) begin
          content_84 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h54 == io_port_0_write_bits_addr[6:0]) begin
        content_84 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_85 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h55 == io_port_1_write_bits_addr[6:0]) begin
        content_85 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h55 == io_port_0_write_bits_addr[6:0]) begin
          content_85 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h55 == io_port_0_write_bits_addr[6:0]) begin
        content_85 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_86 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h56 == io_port_1_write_bits_addr[6:0]) begin
        content_86 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h56 == io_port_0_write_bits_addr[6:0]) begin
          content_86 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h56 == io_port_0_write_bits_addr[6:0]) begin
        content_86 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_87 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h57 == io_port_1_write_bits_addr[6:0]) begin
        content_87 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h57 == io_port_0_write_bits_addr[6:0]) begin
          content_87 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h57 == io_port_0_write_bits_addr[6:0]) begin
        content_87 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_88 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h58 == io_port_1_write_bits_addr[6:0]) begin
        content_88 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h58 == io_port_0_write_bits_addr[6:0]) begin
          content_88 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h58 == io_port_0_write_bits_addr[6:0]) begin
        content_88 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_89 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h59 == io_port_1_write_bits_addr[6:0]) begin
        content_89 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h59 == io_port_0_write_bits_addr[6:0]) begin
          content_89 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h59 == io_port_0_write_bits_addr[6:0]) begin
        content_89 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_90 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h5a == io_port_1_write_bits_addr[6:0]) begin
        content_90 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h5a == io_port_0_write_bits_addr[6:0]) begin
          content_90 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h5a == io_port_0_write_bits_addr[6:0]) begin
        content_90 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_91 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h5b == io_port_1_write_bits_addr[6:0]) begin
        content_91 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h5b == io_port_0_write_bits_addr[6:0]) begin
          content_91 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h5b == io_port_0_write_bits_addr[6:0]) begin
        content_91 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_92 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h5c == io_port_1_write_bits_addr[6:0]) begin
        content_92 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h5c == io_port_0_write_bits_addr[6:0]) begin
          content_92 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h5c == io_port_0_write_bits_addr[6:0]) begin
        content_92 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_93 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h5d == io_port_1_write_bits_addr[6:0]) begin
        content_93 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h5d == io_port_0_write_bits_addr[6:0]) begin
          content_93 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h5d == io_port_0_write_bits_addr[6:0]) begin
        content_93 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_94 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h5e == io_port_1_write_bits_addr[6:0]) begin
        content_94 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h5e == io_port_0_write_bits_addr[6:0]) begin
          content_94 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h5e == io_port_0_write_bits_addr[6:0]) begin
        content_94 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_95 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h5f == io_port_1_write_bits_addr[6:0]) begin
        content_95 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h5f == io_port_0_write_bits_addr[6:0]) begin
          content_95 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h5f == io_port_0_write_bits_addr[6:0]) begin
        content_95 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_96 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h60 == io_port_1_write_bits_addr[6:0]) begin
        content_96 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h60 == io_port_0_write_bits_addr[6:0]) begin
          content_96 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h60 == io_port_0_write_bits_addr[6:0]) begin
        content_96 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_97 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h61 == io_port_1_write_bits_addr[6:0]) begin
        content_97 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h61 == io_port_0_write_bits_addr[6:0]) begin
          content_97 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h61 == io_port_0_write_bits_addr[6:0]) begin
        content_97 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_98 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h62 == io_port_1_write_bits_addr[6:0]) begin
        content_98 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h62 == io_port_0_write_bits_addr[6:0]) begin
          content_98 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h62 == io_port_0_write_bits_addr[6:0]) begin
        content_98 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_99 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h63 == io_port_1_write_bits_addr[6:0]) begin
        content_99 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h63 == io_port_0_write_bits_addr[6:0]) begin
          content_99 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h63 == io_port_0_write_bits_addr[6:0]) begin
        content_99 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_100 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h64 == io_port_1_write_bits_addr[6:0]) begin
        content_100 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h64 == io_port_0_write_bits_addr[6:0]) begin
          content_100 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h64 == io_port_0_write_bits_addr[6:0]) begin
        content_100 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_101 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h65 == io_port_1_write_bits_addr[6:0]) begin
        content_101 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h65 == io_port_0_write_bits_addr[6:0]) begin
          content_101 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h65 == io_port_0_write_bits_addr[6:0]) begin
        content_101 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_102 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h66 == io_port_1_write_bits_addr[6:0]) begin
        content_102 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h66 == io_port_0_write_bits_addr[6:0]) begin
          content_102 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h66 == io_port_0_write_bits_addr[6:0]) begin
        content_102 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_103 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h67 == io_port_1_write_bits_addr[6:0]) begin
        content_103 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h67 == io_port_0_write_bits_addr[6:0]) begin
          content_103 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h67 == io_port_0_write_bits_addr[6:0]) begin
        content_103 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_104 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h68 == io_port_1_write_bits_addr[6:0]) begin
        content_104 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h68 == io_port_0_write_bits_addr[6:0]) begin
          content_104 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h68 == io_port_0_write_bits_addr[6:0]) begin
        content_104 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_105 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h69 == io_port_1_write_bits_addr[6:0]) begin
        content_105 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h69 == io_port_0_write_bits_addr[6:0]) begin
          content_105 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h69 == io_port_0_write_bits_addr[6:0]) begin
        content_105 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_106 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h6a == io_port_1_write_bits_addr[6:0]) begin
        content_106 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h6a == io_port_0_write_bits_addr[6:0]) begin
          content_106 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h6a == io_port_0_write_bits_addr[6:0]) begin
        content_106 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_107 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h6b == io_port_1_write_bits_addr[6:0]) begin
        content_107 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h6b == io_port_0_write_bits_addr[6:0]) begin
          content_107 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h6b == io_port_0_write_bits_addr[6:0]) begin
        content_107 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_108 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h6c == io_port_1_write_bits_addr[6:0]) begin
        content_108 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h6c == io_port_0_write_bits_addr[6:0]) begin
          content_108 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h6c == io_port_0_write_bits_addr[6:0]) begin
        content_108 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_109 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h6d == io_port_1_write_bits_addr[6:0]) begin
        content_109 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h6d == io_port_0_write_bits_addr[6:0]) begin
          content_109 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h6d == io_port_0_write_bits_addr[6:0]) begin
        content_109 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_110 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h6e == io_port_1_write_bits_addr[6:0]) begin
        content_110 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h6e == io_port_0_write_bits_addr[6:0]) begin
          content_110 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h6e == io_port_0_write_bits_addr[6:0]) begin
        content_110 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_111 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h6f == io_port_1_write_bits_addr[6:0]) begin
        content_111 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h6f == io_port_0_write_bits_addr[6:0]) begin
          content_111 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h6f == io_port_0_write_bits_addr[6:0]) begin
        content_111 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_112 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h70 == io_port_1_write_bits_addr[6:0]) begin
        content_112 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h70 == io_port_0_write_bits_addr[6:0]) begin
          content_112 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h70 == io_port_0_write_bits_addr[6:0]) begin
        content_112 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_113 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h71 == io_port_1_write_bits_addr[6:0]) begin
        content_113 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h71 == io_port_0_write_bits_addr[6:0]) begin
          content_113 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h71 == io_port_0_write_bits_addr[6:0]) begin
        content_113 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_114 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h72 == io_port_1_write_bits_addr[6:0]) begin
        content_114 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h72 == io_port_0_write_bits_addr[6:0]) begin
          content_114 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h72 == io_port_0_write_bits_addr[6:0]) begin
        content_114 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_115 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h73 == io_port_1_write_bits_addr[6:0]) begin
        content_115 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h73 == io_port_0_write_bits_addr[6:0]) begin
          content_115 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h73 == io_port_0_write_bits_addr[6:0]) begin
        content_115 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_116 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h74 == io_port_1_write_bits_addr[6:0]) begin
        content_116 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h74 == io_port_0_write_bits_addr[6:0]) begin
          content_116 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h74 == io_port_0_write_bits_addr[6:0]) begin
        content_116 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_117 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h75 == io_port_1_write_bits_addr[6:0]) begin
        content_117 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h75 == io_port_0_write_bits_addr[6:0]) begin
          content_117 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h75 == io_port_0_write_bits_addr[6:0]) begin
        content_117 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_118 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h76 == io_port_1_write_bits_addr[6:0]) begin
        content_118 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h76 == io_port_0_write_bits_addr[6:0]) begin
          content_118 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h76 == io_port_0_write_bits_addr[6:0]) begin
        content_118 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_119 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h77 == io_port_1_write_bits_addr[6:0]) begin
        content_119 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h77 == io_port_0_write_bits_addr[6:0]) begin
          content_119 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h77 == io_port_0_write_bits_addr[6:0]) begin
        content_119 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_120 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h78 == io_port_1_write_bits_addr[6:0]) begin
        content_120 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h78 == io_port_0_write_bits_addr[6:0]) begin
          content_120 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h78 == io_port_0_write_bits_addr[6:0]) begin
        content_120 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_121 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h79 == io_port_1_write_bits_addr[6:0]) begin
        content_121 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h79 == io_port_0_write_bits_addr[6:0]) begin
          content_121 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h79 == io_port_0_write_bits_addr[6:0]) begin
        content_121 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_122 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h7a == io_port_1_write_bits_addr[6:0]) begin
        content_122 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h7a == io_port_0_write_bits_addr[6:0]) begin
          content_122 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h7a == io_port_0_write_bits_addr[6:0]) begin
        content_122 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_123 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h7b == io_port_1_write_bits_addr[6:0]) begin
        content_123 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h7b == io_port_0_write_bits_addr[6:0]) begin
          content_123 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h7b == io_port_0_write_bits_addr[6:0]) begin
        content_123 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_124 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h7c == io_port_1_write_bits_addr[6:0]) begin
        content_124 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h7c == io_port_0_write_bits_addr[6:0]) begin
          content_124 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h7c == io_port_0_write_bits_addr[6:0]) begin
        content_124 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_125 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h7d == io_port_1_write_bits_addr[6:0]) begin
        content_125 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h7d == io_port_0_write_bits_addr[6:0]) begin
          content_125 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h7d == io_port_0_write_bits_addr[6:0]) begin
        content_125 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_126 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h7e == io_port_1_write_bits_addr[6:0]) begin
        content_126 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h7e == io_port_0_write_bits_addr[6:0]) begin
          content_126 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h7e == io_port_0_write_bits_addr[6:0]) begin
        content_126 <= io_port_0_write_bits_value;
      end
    end
    if (reset) begin
      content_127 <= 1'h0;
    end else if (io_port_1_write_valid) begin
      if (7'h7f == io_port_1_write_bits_addr[6:0]) begin
        content_127 <= io_port_1_write_bits_value;
      end else if (io_port_0_write_valid) begin
        if (7'h7f == io_port_0_write_bits_addr[6:0]) begin
          content_127 <= io_port_0_write_bits_value;
        end
      end
    end else if (io_port_0_write_valid) begin
      if (7'h7f == io_port_0_write_bits_addr[6:0]) begin
        content_127 <= io_port_0_write_bits_value;
      end
    end
  end
endmodule
module Arbiter_2(
  input         io_in_0_valid,
  input  [1:0]  io_in_0_bits_bank,
  input  [5:0]  io_in_0_bits_address,
  input  [25:0] io_in_0_bits_inputValue_0_tag,
  input  [25:0] io_in_0_bits_inputValue_1_tag,
  output        io_out_valid,
  output [1:0]  io_out_bits_bank,
  output [5:0]  io_out_bits_address,
  output [25:0] io_out_bits_inputValue_0_tag,
  output [25:0] io_out_bits_inputValue_1_tag
);
  assign io_out_valid = io_in_0_valid; // @[Arbiter.scala 135:16]
  assign io_out_bits_bank = io_in_0_bits_bank; // @[Arbiter.scala 124:15]
  assign io_out_bits_address = io_in_0_bits_address; // @[Arbiter.scala 124:15]
  assign io_out_bits_inputValue_0_tag = io_in_0_bits_inputValue_0_tag; // @[Arbiter.scala 124:15]
  assign io_out_bits_inputValue_1_tag = io_in_0_bits_inputValue_1_tag; // @[Arbiter.scala 124:15]
endmodule
module Gem5Cache(
  input         clock,
  input         reset,
  input         io_cpu_0_req_valid,
  input  [31:0] io_cpu_0_req_bits_addr,
  input  [63:0] io_cpu_0_req_bits_data,
  input  [27:0] io_cpu_0_req_bits_command,
  input  [1:0]  io_cpu_0_req_bits_way,
  input  [1:0]  io_cpu_0_req_bits_replaceWay,
  output        io_cpu_0_resp_valid,
  output        io_cpu_0_resp_bits_iswrite,
  output [1:0]  io_cpu_0_resp_bits_way,
  input         io_probe_req_valid,
  input  [31:0] io_probe_req_bits_addr,
  input  [27:0] io_probe_req_bits_command,
  output        io_probe_resp_valid,
  output [1:0]  io_probe_resp_bits_way,
  output        io_probe_multiWay_valid,
  output [1:0]  io_probe_multiWay_bits_way_0,
  output [1:0]  io_probe_multiWay_bits_way_1,
  output [31:0] io_probe_multiWay_bits_addr,
  input         io_bipassLD_in_valid,
  input  [31:0] io_bipassLD_in_bits_addr,
  input  [2:0]  io_bipassLD_in_bits_way,
  output        io_bipassLD_out_valid,
  output [63:0] io_bipassLD_out_bits_data
);
  wire  biPassModule_clock; // @[AXICache.scala 61:28]
  wire  biPassModule_reset; // @[AXICache.scala 61:28]
  wire  biPassModule_io_in_valid; // @[AXICache.scala 61:28]
  wire [31:0] biPassModule_io_in_bits_addr; // @[AXICache.scala 61:28]
  wire [2:0] biPassModule_io_in_bits_way; // @[AXICache.scala 61:28]
  wire  biPassModule_io_dataMem_in_valid; // @[AXICache.scala 61:28]
  wire [31:0] biPassModule_io_dataMem_in_bits_address; // @[AXICache.scala 61:28]
  wire [63:0] biPassModule_io_dataMem_outputValue_0; // @[AXICache.scala 61:28]
  wire  biPassModule_io_out_valid; // @[AXICache.scala 61:28]
  wire [63:0] biPassModule_io_out_bits_data; // @[AXICache.scala 61:28]
  wire  dataMemory_clock; // @[AXICache.scala 77:26]
  wire  dataMemory_io_read_in_valid; // @[AXICache.scala 77:26]
  wire [31:0] dataMemory_io_read_in_bits_address; // @[AXICache.scala 77:26]
  wire [63:0] dataMemory_io_read_outputValue_0; // @[AXICache.scala 77:26]
  wire  dataMemory_io_write_valid; // @[AXICache.scala 77:26]
  wire [31:0] dataMemory_io_write_bits_address; // @[AXICache.scala 77:26]
  wire [63:0] dataMemory_io_write_bits_inputValue_0; // @[AXICache.scala 77:26]
  wire  metaMemory_clock; // @[AXICache.scala 78:26]
  wire  metaMemory_io_read_in_valid; // @[AXICache.scala 78:26]
  wire [5:0] metaMemory_io_read_in_bits_address; // @[AXICache.scala 78:26]
  wire [25:0] metaMemory_io_read_outputValue_0_tag; // @[AXICache.scala 78:26]
  wire [25:0] metaMemory_io_read_outputValue_1_tag; // @[AXICache.scala 78:26]
  wire  metaMemory_io_write_valid; // @[AXICache.scala 78:26]
  wire [1:0] metaMemory_io_write_bits_bank; // @[AXICache.scala 78:26]
  wire [5:0] metaMemory_io_write_bits_address; // @[AXICache.scala 78:26]
  wire [25:0] metaMemory_io_write_bits_inputValue_0_tag; // @[AXICache.scala 78:26]
  wire [25:0] metaMemory_io_write_bits_inputValue_1_tag; // @[AXICache.scala 78:26]
  wire  cacheLogic_0_clock; // @[AXICache.scala 81:28]
  wire  cacheLogic_0_reset; // @[AXICache.scala 81:28]
  wire  cacheLogic_0_io_cpu_req_ready; // @[AXICache.scala 81:28]
  wire  cacheLogic_0_io_cpu_req_valid; // @[AXICache.scala 81:28]
  wire [31:0] cacheLogic_0_io_cpu_req_bits_addr; // @[AXICache.scala 81:28]
  wire [63:0] cacheLogic_0_io_cpu_req_bits_data; // @[AXICache.scala 81:28]
  wire [27:0] cacheLogic_0_io_cpu_req_bits_command; // @[AXICache.scala 81:28]
  wire [1:0] cacheLogic_0_io_cpu_req_bits_way; // @[AXICache.scala 81:28]
  wire [1:0] cacheLogic_0_io_cpu_req_bits_replaceWay; // @[AXICache.scala 81:28]
  wire  cacheLogic_0_io_cpu_resp_valid; // @[AXICache.scala 81:28]
  wire  cacheLogic_0_io_cpu_resp_bits_iswrite; // @[AXICache.scala 81:28]
  wire [1:0] cacheLogic_0_io_cpu_resp_bits_way; // @[AXICache.scala 81:28]
  wire  cacheLogic_0_io_metaMem_write_valid; // @[AXICache.scala 81:28]
  wire [1:0] cacheLogic_0_io_metaMem_write_bits_bank; // @[AXICache.scala 81:28]
  wire [5:0] cacheLogic_0_io_metaMem_write_bits_address; // @[AXICache.scala 81:28]
  wire [25:0] cacheLogic_0_io_metaMem_write_bits_inputValue_0_tag; // @[AXICache.scala 81:28]
  wire [25:0] cacheLogic_0_io_metaMem_write_bits_inputValue_1_tag; // @[AXICache.scala 81:28]
  wire  cacheLogic_0_io_dataMem_write_valid; // @[AXICache.scala 81:28]
  wire [31:0] cacheLogic_0_io_dataMem_write_bits_address; // @[AXICache.scala 81:28]
  wire [63:0] cacheLogic_0_io_dataMem_write_bits_inputValue_0; // @[AXICache.scala 81:28]
  wire  cacheLogic_0_io_validTagBits_write_valid; // @[AXICache.scala 81:28]
  wire [63:0] cacheLogic_0_io_validTagBits_write_bits_addr; // @[AXICache.scala 81:28]
  wire  cacheLogic_0_io_validTagBits_write_bits_value; // @[AXICache.scala 81:28]
  wire  cacheLogic_0_io_validTagBits_read_in_valid; // @[AXICache.scala 81:28]
  wire [63:0] cacheLogic_0_io_validTagBits_read_in_bits_addr; // @[AXICache.scala 81:28]
  wire  cacheLogic_0_io_validTagBits_read_out_0; // @[AXICache.scala 81:28]
  wire  cacheLogic_0_io_validTagBits_read_out_1; // @[AXICache.scala 81:28]
  wire  probeUnit_clock; // @[AXICache.scala 85:26]
  wire  probeUnit_reset; // @[AXICache.scala 85:26]
  wire  probeUnit_io_cpu_req_ready; // @[AXICache.scala 85:26]
  wire  probeUnit_io_cpu_req_valid; // @[AXICache.scala 85:26]
  wire [31:0] probeUnit_io_cpu_req_bits_addr; // @[AXICache.scala 85:26]
  wire [27:0] probeUnit_io_cpu_req_bits_command; // @[AXICache.scala 85:26]
  wire  probeUnit_io_cpu_resp_valid; // @[AXICache.scala 85:26]
  wire [1:0] probeUnit_io_cpu_resp_bits_way; // @[AXICache.scala 85:26]
  wire  probeUnit_io_cpu_multiWay_valid; // @[AXICache.scala 85:26]
  wire [1:0] probeUnit_io_cpu_multiWay_bits_way_0; // @[AXICache.scala 85:26]
  wire [1:0] probeUnit_io_cpu_multiWay_bits_way_1; // @[AXICache.scala 85:26]
  wire [31:0] probeUnit_io_cpu_multiWay_bits_addr; // @[AXICache.scala 85:26]
  wire  probeUnit_io_metaMem_read_in_valid; // @[AXICache.scala 85:26]
  wire [5:0] probeUnit_io_metaMem_read_in_bits_address; // @[AXICache.scala 85:26]
  wire [25:0] probeUnit_io_metaMem_read_outputValue_0_tag; // @[AXICache.scala 85:26]
  wire [25:0] probeUnit_io_metaMem_read_outputValue_1_tag; // @[AXICache.scala 85:26]
  wire  probeUnit_io_validTagBits_write_valid; // @[AXICache.scala 85:26]
  wire [63:0] probeUnit_io_validTagBits_write_bits_addr; // @[AXICache.scala 85:26]
  wire  probeUnit_io_validTagBits_write_bits_value; // @[AXICache.scala 85:26]
  wire  probeUnit_io_validTagBits_read_in_valid; // @[AXICache.scala 85:26]
  wire [63:0] probeUnit_io_validTagBits_read_in_bits_addr; // @[AXICache.scala 85:26]
  wire  probeUnit_io_validTagBits_read_out_0; // @[AXICache.scala 85:26]
  wire  probeUnit_io_validTagBits_read_out_1; // @[AXICache.scala 85:26]
  wire  validTagBits_clock; // @[AXICache.scala 88:28]
  wire  validTagBits_reset; // @[AXICache.scala 88:28]
  wire  validTagBits_io_port_0_write_valid; // @[AXICache.scala 88:28]
  wire [63:0] validTagBits_io_port_0_write_bits_addr; // @[AXICache.scala 88:28]
  wire  validTagBits_io_port_0_write_bits_value; // @[AXICache.scala 88:28]
  wire  validTagBits_io_port_0_read_in_valid; // @[AXICache.scala 88:28]
  wire [63:0] validTagBits_io_port_0_read_in_bits_addr; // @[AXICache.scala 88:28]
  wire  validTagBits_io_port_0_read_out_0; // @[AXICache.scala 88:28]
  wire  validTagBits_io_port_0_read_out_1; // @[AXICache.scala 88:28]
  wire  validTagBits_io_port_1_write_valid; // @[AXICache.scala 88:28]
  wire [63:0] validTagBits_io_port_1_write_bits_addr; // @[AXICache.scala 88:28]
  wire  validTagBits_io_port_1_write_bits_value; // @[AXICache.scala 88:28]
  wire  validTagBits_io_port_1_read_in_valid; // @[AXICache.scala 88:28]
  wire [63:0] validTagBits_io_port_1_read_in_bits_addr; // @[AXICache.scala 88:28]
  wire  validTagBits_io_port_1_read_out_0; // @[AXICache.scala 88:28]
  wire  validTagBits_io_port_1_read_out_1; // @[AXICache.scala 88:28]
  wire  metaWrArb_io_in_0_valid; // @[AXICache.scala 91:27]
  wire [1:0] metaWrArb_io_in_0_bits_bank; // @[AXICache.scala 91:27]
  wire [5:0] metaWrArb_io_in_0_bits_address; // @[AXICache.scala 91:27]
  wire [25:0] metaWrArb_io_in_0_bits_inputValue_0_tag; // @[AXICache.scala 91:27]
  wire [25:0] metaWrArb_io_in_0_bits_inputValue_1_tag; // @[AXICache.scala 91:27]
  wire  metaWrArb_io_out_valid; // @[AXICache.scala 91:27]
  wire [1:0] metaWrArb_io_out_bits_bank; // @[AXICache.scala 91:27]
  wire [5:0] metaWrArb_io_out_bits_address; // @[AXICache.scala 91:27]
  wire [25:0] metaWrArb_io_out_bits_inputValue_0_tag; // @[AXICache.scala 91:27]
  wire [25:0] metaWrArb_io_out_bits_inputValue_1_tag; // @[AXICache.scala 91:27]
  bipassLD biPassModule ( // @[AXICache.scala 61:28]
    .clock(biPassModule_clock),
    .reset(biPassModule_reset),
    .io_in_valid(biPassModule_io_in_valid),
    .io_in_bits_addr(biPassModule_io_in_bits_addr),
    .io_in_bits_way(biPassModule_io_in_bits_way),
    .io_dataMem_in_valid(biPassModule_io_dataMem_in_valid),
    .io_dataMem_in_bits_address(biPassModule_io_dataMem_in_bits_address),
    .io_dataMem_outputValue_0(biPassModule_io_dataMem_outputValue_0),
    .io_out_valid(biPassModule_io_out_valid),
    .io_out_bits_data(biPassModule_io_out_bits_data)
  );
  MemBank dataMemory ( // @[AXICache.scala 77:26]
    .clock(dataMemory_clock),
    .io_read_in_valid(dataMemory_io_read_in_valid),
    .io_read_in_bits_address(dataMemory_io_read_in_bits_address),
    .io_read_outputValue_0(dataMemory_io_read_outputValue_0),
    .io_write_valid(dataMemory_io_write_valid),
    .io_write_bits_address(dataMemory_io_write_bits_address),
    .io_write_bits_inputValue_0(dataMemory_io_write_bits_inputValue_0)
  );
  MemBank_1 metaMemory ( // @[AXICache.scala 78:26]
    .clock(metaMemory_clock),
    .io_read_in_valid(metaMemory_io_read_in_valid),
    .io_read_in_bits_address(metaMemory_io_read_in_bits_address),
    .io_read_outputValue_0_tag(metaMemory_io_read_outputValue_0_tag),
    .io_read_outputValue_1_tag(metaMemory_io_read_outputValue_1_tag),
    .io_write_valid(metaMemory_io_write_valid),
    .io_write_bits_bank(metaMemory_io_write_bits_bank),
    .io_write_bits_address(metaMemory_io_write_bits_address),
    .io_write_bits_inputValue_0_tag(metaMemory_io_write_bits_inputValue_0_tag),
    .io_write_bits_inputValue_1_tag(metaMemory_io_write_bits_inputValue_1_tag)
  );
  Gem5CacheLogic cacheLogic_0 ( // @[AXICache.scala 81:28]
    .clock(cacheLogic_0_clock),
    .reset(cacheLogic_0_reset),
    .io_cpu_req_ready(cacheLogic_0_io_cpu_req_ready),
    .io_cpu_req_valid(cacheLogic_0_io_cpu_req_valid),
    .io_cpu_req_bits_addr(cacheLogic_0_io_cpu_req_bits_addr),
    .io_cpu_req_bits_data(cacheLogic_0_io_cpu_req_bits_data),
    .io_cpu_req_bits_command(cacheLogic_0_io_cpu_req_bits_command),
    .io_cpu_req_bits_way(cacheLogic_0_io_cpu_req_bits_way),
    .io_cpu_req_bits_replaceWay(cacheLogic_0_io_cpu_req_bits_replaceWay),
    .io_cpu_resp_valid(cacheLogic_0_io_cpu_resp_valid),
    .io_cpu_resp_bits_iswrite(cacheLogic_0_io_cpu_resp_bits_iswrite),
    .io_cpu_resp_bits_way(cacheLogic_0_io_cpu_resp_bits_way),
    .io_metaMem_write_valid(cacheLogic_0_io_metaMem_write_valid),
    .io_metaMem_write_bits_bank(cacheLogic_0_io_metaMem_write_bits_bank),
    .io_metaMem_write_bits_address(cacheLogic_0_io_metaMem_write_bits_address),
    .io_metaMem_write_bits_inputValue_0_tag(cacheLogic_0_io_metaMem_write_bits_inputValue_0_tag),
    .io_metaMem_write_bits_inputValue_1_tag(cacheLogic_0_io_metaMem_write_bits_inputValue_1_tag),
    .io_dataMem_write_valid(cacheLogic_0_io_dataMem_write_valid),
    .io_dataMem_write_bits_address(cacheLogic_0_io_dataMem_write_bits_address),
    .io_dataMem_write_bits_inputValue_0(cacheLogic_0_io_dataMem_write_bits_inputValue_0),
    .io_validTagBits_write_valid(cacheLogic_0_io_validTagBits_write_valid),
    .io_validTagBits_write_bits_addr(cacheLogic_0_io_validTagBits_write_bits_addr),
    .io_validTagBits_write_bits_value(cacheLogic_0_io_validTagBits_write_bits_value),
    .io_validTagBits_read_in_valid(cacheLogic_0_io_validTagBits_read_in_valid),
    .io_validTagBits_read_in_bits_addr(cacheLogic_0_io_validTagBits_read_in_bits_addr),
    .io_validTagBits_read_out_0(cacheLogic_0_io_validTagBits_read_out_0),
    .io_validTagBits_read_out_1(cacheLogic_0_io_validTagBits_read_out_1)
  );
  ProbeUnit probeUnit ( // @[AXICache.scala 85:26]
    .clock(probeUnit_clock),
    .reset(probeUnit_reset),
    .io_cpu_req_ready(probeUnit_io_cpu_req_ready),
    .io_cpu_req_valid(probeUnit_io_cpu_req_valid),
    .io_cpu_req_bits_addr(probeUnit_io_cpu_req_bits_addr),
    .io_cpu_req_bits_command(probeUnit_io_cpu_req_bits_command),
    .io_cpu_resp_valid(probeUnit_io_cpu_resp_valid),
    .io_cpu_resp_bits_way(probeUnit_io_cpu_resp_bits_way),
    .io_cpu_multiWay_valid(probeUnit_io_cpu_multiWay_valid),
    .io_cpu_multiWay_bits_way_0(probeUnit_io_cpu_multiWay_bits_way_0),
    .io_cpu_multiWay_bits_way_1(probeUnit_io_cpu_multiWay_bits_way_1),
    .io_cpu_multiWay_bits_addr(probeUnit_io_cpu_multiWay_bits_addr),
    .io_metaMem_read_in_valid(probeUnit_io_metaMem_read_in_valid),
    .io_metaMem_read_in_bits_address(probeUnit_io_metaMem_read_in_bits_address),
    .io_metaMem_read_outputValue_0_tag(probeUnit_io_metaMem_read_outputValue_0_tag),
    .io_metaMem_read_outputValue_1_tag(probeUnit_io_metaMem_read_outputValue_1_tag),
    .io_validTagBits_write_valid(probeUnit_io_validTagBits_write_valid),
    .io_validTagBits_write_bits_addr(probeUnit_io_validTagBits_write_bits_addr),
    .io_validTagBits_write_bits_value(probeUnit_io_validTagBits_write_bits_value),
    .io_validTagBits_read_in_valid(probeUnit_io_validTagBits_read_in_valid),
    .io_validTagBits_read_in_bits_addr(probeUnit_io_validTagBits_read_in_bits_addr),
    .io_validTagBits_read_out_0(probeUnit_io_validTagBits_read_out_0),
    .io_validTagBits_read_out_1(probeUnit_io_validTagBits_read_out_1)
  );
  paralReg_1 validTagBits ( // @[AXICache.scala 88:28]
    .clock(validTagBits_clock),
    .reset(validTagBits_reset),
    .io_port_0_write_valid(validTagBits_io_port_0_write_valid),
    .io_port_0_write_bits_addr(validTagBits_io_port_0_write_bits_addr),
    .io_port_0_write_bits_value(validTagBits_io_port_0_write_bits_value),
    .io_port_0_read_in_valid(validTagBits_io_port_0_read_in_valid),
    .io_port_0_read_in_bits_addr(validTagBits_io_port_0_read_in_bits_addr),
    .io_port_0_read_out_0(validTagBits_io_port_0_read_out_0),
    .io_port_0_read_out_1(validTagBits_io_port_0_read_out_1),
    .io_port_1_write_valid(validTagBits_io_port_1_write_valid),
    .io_port_1_write_bits_addr(validTagBits_io_port_1_write_bits_addr),
    .io_port_1_write_bits_value(validTagBits_io_port_1_write_bits_value),
    .io_port_1_read_in_valid(validTagBits_io_port_1_read_in_valid),
    .io_port_1_read_in_bits_addr(validTagBits_io_port_1_read_in_bits_addr),
    .io_port_1_read_out_0(validTagBits_io_port_1_read_out_0),
    .io_port_1_read_out_1(validTagBits_io_port_1_read_out_1)
  );
  Arbiter_2 metaWrArb ( // @[AXICache.scala 91:27]
    .io_in_0_valid(metaWrArb_io_in_0_valid),
    .io_in_0_bits_bank(metaWrArb_io_in_0_bits_bank),
    .io_in_0_bits_address(metaWrArb_io_in_0_bits_address),
    .io_in_0_bits_inputValue_0_tag(metaWrArb_io_in_0_bits_inputValue_0_tag),
    .io_in_0_bits_inputValue_1_tag(metaWrArb_io_in_0_bits_inputValue_1_tag),
    .io_out_valid(metaWrArb_io_out_valid),
    .io_out_bits_bank(metaWrArb_io_out_bits_bank),
    .io_out_bits_address(metaWrArb_io_out_bits_address),
    .io_out_bits_inputValue_0_tag(metaWrArb_io_out_bits_inputValue_0_tag),
    .io_out_bits_inputValue_1_tag(metaWrArb_io_out_bits_inputValue_1_tag)
  );
  assign io_cpu_0_resp_valid = cacheLogic_0_io_cpu_resp_valid; // @[AXICache.scala 128:20]
  assign io_cpu_0_resp_bits_iswrite = cacheLogic_0_io_cpu_resp_bits_iswrite; // @[AXICache.scala 128:20]
  assign io_cpu_0_resp_bits_way = cacheLogic_0_io_cpu_resp_bits_way; // @[AXICache.scala 128:20]
  assign io_probe_resp_valid = probeUnit_io_cpu_resp_valid; // @[AXICache.scala 133:17]
  assign io_probe_resp_bits_way = probeUnit_io_cpu_resp_bits_way; // @[AXICache.scala 133:17]
  assign io_probe_multiWay_valid = probeUnit_io_cpu_multiWay_valid; // @[AXICache.scala 133:17]
  assign io_probe_multiWay_bits_way_0 = probeUnit_io_cpu_multiWay_bits_way_0; // @[AXICache.scala 133:17]
  assign io_probe_multiWay_bits_way_1 = probeUnit_io_cpu_multiWay_bits_way_1; // @[AXICache.scala 133:17]
  assign io_probe_multiWay_bits_addr = probeUnit_io_cpu_multiWay_bits_addr; // @[AXICache.scala 133:17]
  assign io_bipassLD_out_valid = biPassModule_io_out_valid; // @[AXICache.scala 95:23]
  assign io_bipassLD_out_bits_data = biPassModule_io_out_bits_data; // @[AXICache.scala 95:23]
  assign biPassModule_clock = clock;
  assign biPassModule_reset = reset;
  assign biPassModule_io_in_valid = io_bipassLD_in_valid; // @[AXICache.scala 94:23]
  assign biPassModule_io_in_bits_addr = io_bipassLD_in_bits_addr; // @[AXICache.scala 94:23]
  assign biPassModule_io_in_bits_way = io_bipassLD_in_bits_way; // @[AXICache.scala 94:23]
  assign biPassModule_io_dataMem_outputValue_0 = dataMemory_io_read_outputValue_0; // @[AXICache.scala 97:42]
  assign dataMemory_clock = clock;
  assign dataMemory_io_read_in_valid = biPassModule_io_dataMem_in_valid; // @[AXICache.scala 97:42]
  assign dataMemory_io_read_in_bits_address = biPassModule_io_dataMem_in_bits_address; // @[AXICache.scala 97:42]
  assign dataMemory_io_write_valid = cacheLogic_0_io_dataMem_write_valid; // @[AXICache.scala 104:35]
  assign dataMemory_io_write_bits_address = cacheLogic_0_io_dataMem_write_bits_address; // @[AXICache.scala 104:35]
  assign dataMemory_io_write_bits_inputValue_0 = cacheLogic_0_io_dataMem_write_bits_inputValue_0; // @[AXICache.scala 104:35]
  assign metaMemory_clock = clock;
  assign metaMemory_io_read_in_valid = probeUnit_io_metaMem_read_in_valid; // @[AXICache.scala 98:29]
  assign metaMemory_io_read_in_bits_address = probeUnit_io_metaMem_read_in_bits_address; // @[AXICache.scala 98:29]
  assign metaMemory_io_write_valid = metaWrArb_io_out_valid; // @[AXICache.scala 116:29]
  assign metaMemory_io_write_bits_bank = metaWrArb_io_out_bits_bank; // @[AXICache.scala 113:36]
  assign metaMemory_io_write_bits_address = metaWrArb_io_out_bits_address; // @[AXICache.scala 114:39]
  assign metaMemory_io_write_bits_inputValue_0_tag = metaWrArb_io_out_bits_inputValue_0_tag; // @[AXICache.scala 115:39]
  assign metaMemory_io_write_bits_inputValue_1_tag = metaWrArb_io_out_bits_inputValue_1_tag; // @[AXICache.scala 115:39]
  assign cacheLogic_0_clock = clock;
  assign cacheLogic_0_reset = reset;
  assign cacheLogic_0_io_cpu_req_valid = io_cpu_0_req_valid; // @[AXICache.scala 128:20]
  assign cacheLogic_0_io_cpu_req_bits_addr = io_cpu_0_req_bits_addr; // @[AXICache.scala 128:20]
  assign cacheLogic_0_io_cpu_req_bits_data = io_cpu_0_req_bits_data; // @[AXICache.scala 128:20]
  assign cacheLogic_0_io_cpu_req_bits_command = io_cpu_0_req_bits_command; // @[AXICache.scala 128:20]
  assign cacheLogic_0_io_cpu_req_bits_way = io_cpu_0_req_bits_way; // @[AXICache.scala 128:20]
  assign cacheLogic_0_io_cpu_req_bits_replaceWay = io_cpu_0_req_bits_replaceWay; // @[AXICache.scala 128:20]
  assign cacheLogic_0_io_validTagBits_read_out_0 = validTagBits_io_port_0_read_out_0; // @[AXICache.scala 127:35]
  assign cacheLogic_0_io_validTagBits_read_out_1 = validTagBits_io_port_0_read_out_1; // @[AXICache.scala 127:35]
  assign probeUnit_clock = clock;
  assign probeUnit_reset = reset;
  assign probeUnit_io_cpu_req_valid = io_probe_req_valid; // @[AXICache.scala 133:17]
  assign probeUnit_io_cpu_req_bits_addr = io_probe_req_bits_addr; // @[AXICache.scala 133:17]
  assign probeUnit_io_cpu_req_bits_command = io_probe_req_bits_command; // @[AXICache.scala 133:17]
  assign probeUnit_io_metaMem_read_outputValue_0_tag = metaMemory_io_read_outputValue_0_tag; // @[AXICache.scala 98:29]
  assign probeUnit_io_metaMem_read_outputValue_1_tag = metaMemory_io_read_outputValue_1_tag; // @[AXICache.scala 98:29]
  assign probeUnit_io_validTagBits_read_out_0 = validTagBits_io_port_1_read_out_0; // @[AXICache.scala 132:29]
  assign probeUnit_io_validTagBits_read_out_1 = validTagBits_io_port_1_read_out_1; // @[AXICache.scala 132:29]
  assign validTagBits_clock = clock;
  assign validTagBits_reset = reset;
  assign validTagBits_io_port_0_write_valid = cacheLogic_0_io_validTagBits_write_valid; // @[AXICache.scala 127:35]
  assign validTagBits_io_port_0_write_bits_addr = cacheLogic_0_io_validTagBits_write_bits_addr; // @[AXICache.scala 127:35]
  assign validTagBits_io_port_0_write_bits_value = cacheLogic_0_io_validTagBits_write_bits_value; // @[AXICache.scala 127:35]
  assign validTagBits_io_port_0_read_in_valid = cacheLogic_0_io_validTagBits_read_in_valid; // @[AXICache.scala 127:35]
  assign validTagBits_io_port_0_read_in_bits_addr = cacheLogic_0_io_validTagBits_read_in_bits_addr; // @[AXICache.scala 127:35]
  assign validTagBits_io_port_1_write_valid = probeUnit_io_validTagBits_write_valid; // @[AXICache.scala 132:29]
  assign validTagBits_io_port_1_write_bits_addr = probeUnit_io_validTagBits_write_bits_addr; // @[AXICache.scala 132:29]
  assign validTagBits_io_port_1_write_bits_value = probeUnit_io_validTagBits_write_bits_value; // @[AXICache.scala 132:29]
  assign validTagBits_io_port_1_read_in_valid = probeUnit_io_validTagBits_read_in_valid; // @[AXICache.scala 132:29]
  assign validTagBits_io_port_1_read_in_bits_addr = probeUnit_io_validTagBits_read_in_bits_addr; // @[AXICache.scala 132:29]
  assign metaWrArb_io_in_0_valid = cacheLogic_0_io_metaMem_write_valid; // @[AXICache.scala 108:33]
  assign metaWrArb_io_in_0_bits_bank = cacheLogic_0_io_metaMem_write_bits_bank; // @[AXICache.scala 105:43]
  assign metaWrArb_io_in_0_bits_address = cacheLogic_0_io_metaMem_write_bits_address; // @[AXICache.scala 106:43]
  assign metaWrArb_io_in_0_bits_inputValue_0_tag = cacheLogic_0_io_metaMem_write_bits_inputValue_0_tag; // @[AXICache.scala 107:43]
  assign metaWrArb_io_in_0_bits_inputValue_1_tag = cacheLogic_0_io_metaMem_write_bits_inputValue_1_tag; // @[AXICache.scala 107:43]
endmodule
module FindEmptyLine_2(
  input        io_data_0,
  input        io_data_1,
  input        io_data_2,
  input        io_data_3,
  input        io_data_4,
  input        io_data_5,
  input        io_data_6,
  input        io_data_7,
  output [2:0] io_value_bits
);
  wire  _T = ~io_data_0; // @[elements.scala 74:53]
  wire  _T_1 = ~io_data_1; // @[elements.scala 74:53]
  wire  _T_2 = ~io_data_2; // @[elements.scala 74:53]
  wire  _T_3 = ~io_data_3; // @[elements.scala 74:53]
  wire  _T_4 = ~io_data_4; // @[elements.scala 74:53]
  wire  _T_5 = ~io_data_5; // @[elements.scala 74:53]
  wire  _T_6 = ~io_data_6; // @[elements.scala 74:53]
  wire  _T_7 = ~io_data_7; // @[elements.scala 74:53]
  wire [3:0] _GEN_0 = _T_7 ? 4'h7 : 4'h8; // @[elements.scala 74:66]
  wire [3:0] _GEN_2 = _T_6 ? 4'h6 : _GEN_0; // @[elements.scala 74:66]
  wire [3:0] _GEN_4 = _T_5 ? 4'h5 : _GEN_2; // @[elements.scala 74:66]
  wire [3:0] _GEN_6 = _T_4 ? 4'h4 : _GEN_4; // @[elements.scala 74:66]
  wire [3:0] _GEN_8 = _T_3 ? 4'h3 : _GEN_6; // @[elements.scala 74:66]
  wire [3:0] _GEN_10 = _T_2 ? 4'h2 : _GEN_8; // @[elements.scala 74:66]
  wire [3:0] _GEN_12 = _T_1 ? 4'h1 : _GEN_10; // @[elements.scala 74:66]
  wire [3:0] idx = _T ? 4'h0 : _GEN_12; // @[elements.scala 74:66]
  assign io_value_bits = idx[2:0]; // @[elements.scala 79:19]
endmodule
module Find_2(
  input  [31:0] io_key,
  input  [31:0] io_data_0,
  input  [31:0] io_data_1,
  input  [31:0] io_data_2,
  input  [31:0] io_data_3,
  input  [31:0] io_data_4,
  input  [31:0] io_data_5,
  input  [31:0] io_data_6,
  input  [31:0] io_data_7,
  input         io_valid_0,
  input         io_valid_1,
  input         io_valid_2,
  input         io_valid_3,
  input         io_valid_4,
  input         io_valid_5,
  input         io_valid_6,
  input         io_valid_7,
  output        io_value_valid,
  output [2:0]  io_value_bits
);
  wire  _T = io_data_0 == io_key; // @[elements.scala 35:54]
  wire  _T_1 = io_data_1 == io_key; // @[elements.scala 35:54]
  wire  _T_2 = io_data_2 == io_key; // @[elements.scala 35:54]
  wire  _T_3 = io_data_3 == io_key; // @[elements.scala 35:54]
  wire  _T_4 = io_data_4 == io_key; // @[elements.scala 35:54]
  wire  _T_5 = io_data_5 == io_key; // @[elements.scala 35:54]
  wire  _T_6 = io_data_6 == io_key; // @[elements.scala 35:54]
  wire  _T_7 = io_data_7 == io_key; // @[elements.scala 35:54]
  wire [7:0] bitmap = {_T_7,_T_6,_T_5,_T_4,_T_3,_T_2,_T_1,_T}; // @[Cat.scala 29:58]
  wire [7:0] _T_21 = {io_valid_7,io_valid_6,io_valid_5,io_valid_4,io_valid_3,io_valid_2,io_valid_1,io_valid_0}; // @[elements.scala 36:46]
  wire [7:0] _T_22 = bitmap & _T_21; // @[elements.scala 36:29]
  wire  _T_25 = |_T_22[7:4]; // @[OneHot.scala 32:14]
  wire [3:0] _T_26 = _T_22[7:4] | _T_22[3:0]; // @[OneHot.scala 32:28]
  wire  _T_29 = |_T_26[3:2]; // @[OneHot.scala 32:14]
  wire [1:0] _T_30 = _T_26[3:2] | _T_26[1:0]; // @[OneHot.scala 32:28]
  wire [1:0] _T_32 = {_T_29,_T_30[1]}; // @[Cat.scala 29:58]
  assign io_value_valid = _T_22 != 8'h0; // @[elements.scala 39:20]
  assign io_value_bits = {_T_25,_T_32}; // @[elements.scala 38:19]
endmodule
module TBETable(
  input         clock,
  input         reset,
  input         io_write_0_valid,
  input  [63:0] io_write_0_bits_addr,
  input  [1:0]  io_write_0_bits_command,
  input         io_write_0_bits_mask,
  input  [1:0]  io_write_0_bits_inputTBE_state_state,
  input  [2:0]  io_write_0_bits_inputTBE_way,
  input  [31:0] io_write_0_bits_inputTBE_fields_0,
  input         io_read_valid,
  input  [63:0] io_read_bits_addr,
  output [1:0]  io_outputTBE_bits_state_state,
  output [2:0]  io_outputTBE_bits_way,
  output [31:0] io_outputTBE_bits_fields_0,
  output        io_isFull
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
`endif // RANDOMIZE_REG_INIT
  wire  allocLine_io_data_0; // @[TBE.scala 79:25]
  wire  allocLine_io_data_1; // @[TBE.scala 79:25]
  wire  allocLine_io_data_2; // @[TBE.scala 79:25]
  wire  allocLine_io_data_3; // @[TBE.scala 79:25]
  wire  allocLine_io_data_4; // @[TBE.scala 79:25]
  wire  allocLine_io_data_5; // @[TBE.scala 79:25]
  wire  allocLine_io_data_6; // @[TBE.scala 79:25]
  wire  allocLine_io_data_7; // @[TBE.scala 79:25]
  wire [2:0] allocLine_io_value_bits; // @[TBE.scala 79:25]
  wire [31:0] finder_0_io_key; // @[TBE.scala 84:24]
  wire [31:0] finder_0_io_data_0; // @[TBE.scala 84:24]
  wire [31:0] finder_0_io_data_1; // @[TBE.scala 84:24]
  wire [31:0] finder_0_io_data_2; // @[TBE.scala 84:24]
  wire [31:0] finder_0_io_data_3; // @[TBE.scala 84:24]
  wire [31:0] finder_0_io_data_4; // @[TBE.scala 84:24]
  wire [31:0] finder_0_io_data_5; // @[TBE.scala 84:24]
  wire [31:0] finder_0_io_data_6; // @[TBE.scala 84:24]
  wire [31:0] finder_0_io_data_7; // @[TBE.scala 84:24]
  wire  finder_0_io_valid_0; // @[TBE.scala 84:24]
  wire  finder_0_io_valid_1; // @[TBE.scala 84:24]
  wire  finder_0_io_valid_2; // @[TBE.scala 84:24]
  wire  finder_0_io_valid_3; // @[TBE.scala 84:24]
  wire  finder_0_io_valid_4; // @[TBE.scala 84:24]
  wire  finder_0_io_valid_5; // @[TBE.scala 84:24]
  wire  finder_0_io_valid_6; // @[TBE.scala 84:24]
  wire  finder_0_io_valid_7; // @[TBE.scala 84:24]
  wire  finder_0_io_value_valid; // @[TBE.scala 84:24]
  wire [2:0] finder_0_io_value_bits; // @[TBE.scala 84:24]
  wire [31:0] finder_1_io_key; // @[TBE.scala 84:24]
  wire [31:0] finder_1_io_data_0; // @[TBE.scala 84:24]
  wire [31:0] finder_1_io_data_1; // @[TBE.scala 84:24]
  wire [31:0] finder_1_io_data_2; // @[TBE.scala 84:24]
  wire [31:0] finder_1_io_data_3; // @[TBE.scala 84:24]
  wire [31:0] finder_1_io_data_4; // @[TBE.scala 84:24]
  wire [31:0] finder_1_io_data_5; // @[TBE.scala 84:24]
  wire [31:0] finder_1_io_data_6; // @[TBE.scala 84:24]
  wire [31:0] finder_1_io_data_7; // @[TBE.scala 84:24]
  wire  finder_1_io_valid_0; // @[TBE.scala 84:24]
  wire  finder_1_io_valid_1; // @[TBE.scala 84:24]
  wire  finder_1_io_valid_2; // @[TBE.scala 84:24]
  wire  finder_1_io_valid_3; // @[TBE.scala 84:24]
  wire  finder_1_io_valid_4; // @[TBE.scala 84:24]
  wire  finder_1_io_valid_5; // @[TBE.scala 84:24]
  wire  finder_1_io_valid_6; // @[TBE.scala 84:24]
  wire  finder_1_io_valid_7; // @[TBE.scala 84:24]
  wire  finder_1_io_value_valid; // @[TBE.scala 84:24]
  wire [2:0] finder_1_io_value_bits; // @[TBE.scala 84:24]
  reg [1:0] TBEMemory_0_state_state; // @[TBE.scala 62:26]
  reg [2:0] TBEMemory_0_way; // @[TBE.scala 62:26]
  reg [31:0] TBEMemory_0_fields_0; // @[TBE.scala 62:26]
  reg [1:0] TBEMemory_1_state_state; // @[TBE.scala 62:26]
  reg [2:0] TBEMemory_1_way; // @[TBE.scala 62:26]
  reg [31:0] TBEMemory_1_fields_0; // @[TBE.scala 62:26]
  reg [1:0] TBEMemory_2_state_state; // @[TBE.scala 62:26]
  reg [2:0] TBEMemory_2_way; // @[TBE.scala 62:26]
  reg [31:0] TBEMemory_2_fields_0; // @[TBE.scala 62:26]
  reg [1:0] TBEMemory_3_state_state; // @[TBE.scala 62:26]
  reg [2:0] TBEMemory_3_way; // @[TBE.scala 62:26]
  reg [31:0] TBEMemory_3_fields_0; // @[TBE.scala 62:26]
  reg [1:0] TBEMemory_4_state_state; // @[TBE.scala 62:26]
  reg [2:0] TBEMemory_4_way; // @[TBE.scala 62:26]
  reg [31:0] TBEMemory_4_fields_0; // @[TBE.scala 62:26]
  reg [1:0] TBEMemory_5_state_state; // @[TBE.scala 62:26]
  reg [2:0] TBEMemory_5_way; // @[TBE.scala 62:26]
  reg [31:0] TBEMemory_5_fields_0; // @[TBE.scala 62:26]
  reg [1:0] TBEMemory_6_state_state; // @[TBE.scala 62:26]
  reg [2:0] TBEMemory_6_way; // @[TBE.scala 62:26]
  reg [31:0] TBEMemory_6_fields_0; // @[TBE.scala 62:26]
  reg [1:0] TBEMemory_7_state_state; // @[TBE.scala 62:26]
  reg [2:0] TBEMemory_7_way; // @[TBE.scala 62:26]
  reg [31:0] TBEMemory_7_fields_0; // @[TBE.scala 62:26]
  reg  TBEValid_0; // @[TBE.scala 63:25]
  reg  TBEValid_1; // @[TBE.scala 63:25]
  reg  TBEValid_2; // @[TBE.scala 63:25]
  reg  TBEValid_3; // @[TBE.scala 63:25]
  reg  TBEValid_4; // @[TBE.scala 63:25]
  reg  TBEValid_5; // @[TBE.scala 63:25]
  reg  TBEValid_6; // @[TBE.scala 63:25]
  reg  TBEValid_7; // @[TBE.scala 63:25]
  reg [31:0] TBEAddr_0; // @[TBE.scala 64:24]
  reg [31:0] TBEAddr_1; // @[TBE.scala 64:24]
  reg [31:0] TBEAddr_2; // @[TBE.scala 64:24]
  reg [31:0] TBEAddr_3; // @[TBE.scala 64:24]
  reg [31:0] TBEAddr_4; // @[TBE.scala 64:24]
  reg [31:0] TBEAddr_5; // @[TBE.scala 64:24]
  reg [31:0] TBEAddr_6; // @[TBE.scala 64:24]
  reg [31:0] TBEAddr_7; // @[TBE.scala 64:24]
  reg [4:0] counter; // @[TBE.scala 75:24]
  wire [3:0] _T_38 = 4'h8 - 4'h3; // @[TBE.scala 90:40]
  wire [4:0] _GEN_282 = {{1'd0}, _T_38}; // @[TBE.scala 90:26]
  wire  _T_39 = counter > _GEN_282; // @[TBE.scala 90:26]
  wire  _T_40 = _T_39 & io_read_valid; // @[TBE.scala 90:58]
  wire  _T_41 = ~finder_1_io_value_valid; // @[TBE.scala 90:69]
  wire  idxReadValid = finder_1_io_value_valid & io_read_valid; // @[TBE.scala 96:50]
  wire [3:0] idxAlloc = {{1'd0}, allocLine_io_value_bits}; // @[TBE.scala 71:22 TBE.scala 81:12]
  wire  _GEN_283 = 3'h0 == idxAlloc[2:0]; // @[TBE.scala 112:26]
  wire  _GEN_32 = _GEN_283 | TBEValid_0; // @[TBE.scala 112:26]
  wire  _GEN_284 = 3'h1 == idxAlloc[2:0]; // @[TBE.scala 112:26]
  wire  _GEN_33 = _GEN_284 | TBEValid_1; // @[TBE.scala 112:26]
  wire  _GEN_285 = 3'h2 == idxAlloc[2:0]; // @[TBE.scala 112:26]
  wire  _GEN_34 = _GEN_285 | TBEValid_2; // @[TBE.scala 112:26]
  wire  _GEN_286 = 3'h3 == idxAlloc[2:0]; // @[TBE.scala 112:26]
  wire  _GEN_35 = _GEN_286 | TBEValid_3; // @[TBE.scala 112:26]
  wire  _GEN_287 = 3'h4 == idxAlloc[2:0]; // @[TBE.scala 112:26]
  wire  _GEN_36 = _GEN_287 | TBEValid_4; // @[TBE.scala 112:26]
  wire  _GEN_288 = 3'h5 == idxAlloc[2:0]; // @[TBE.scala 112:26]
  wire  _GEN_37 = _GEN_288 | TBEValid_5; // @[TBE.scala 112:26]
  wire  _GEN_289 = 3'h6 == idxAlloc[2:0]; // @[TBE.scala 112:26]
  wire  _GEN_38 = _GEN_289 | TBEValid_6; // @[TBE.scala 112:26]
  wire  _GEN_290 = 3'h7 == idxAlloc[2:0]; // @[TBE.scala 112:26]
  wire  _GEN_39 = _GEN_290 | TBEValid_7; // @[TBE.scala 112:26]
  wire [4:0] _T_51 = counter + 5'h1; // @[TBE.scala 113:26]
  wire  _T_74 = io_write_0_bits_command == 2'h2; // @[TBE.scala 137:46]
  wire  isDealloc_0 = _T_74 & io_write_0_valid; // @[TBE.scala 137:58]
  wire  _T_52 = isDealloc_0 & finder_0_io_value_valid; // @[TBE.scala 114:31]
  wire [3:0] idxUpdate_0 = {{1'd0}, finder_0_io_value_bits}; // @[TBE.scala 73:23 TBE.scala 104:18]
  wire [4:0] _T_59 = counter - 5'h1; // @[TBE.scala 118:26]
  wire  _T_76 = io_write_0_bits_command == 2'h3; // @[TBE.scala 138:44]
  wire  isWrite_0 = _T_76 & io_write_0_valid; // @[TBE.scala 138:55]
  wire  _T_60 = isWrite_0 & finder_0_io_value_valid; // @[TBE.scala 119:29]
  wire  _T_61 = ~io_write_0_bits_mask; // @[TBE.scala 120:35]
  wire  _T_65 = ~reset; // @[TBE.scala 122:15]
  wire [31:0] _GEN_93 = 3'h1 == idxUpdate_0[2:0] ? TBEMemory_1_fields_0 : TBEMemory_0_fields_0; // @[TBE.scala 122:15]
  wire [31:0] _GEN_96 = 3'h2 == idxUpdate_0[2:0] ? TBEMemory_2_fields_0 : _GEN_93; // @[TBE.scala 122:15]
  wire [31:0] _GEN_99 = 3'h3 == idxUpdate_0[2:0] ? TBEMemory_3_fields_0 : _GEN_96; // @[TBE.scala 122:15]
  wire [31:0] _GEN_102 = 3'h4 == idxUpdate_0[2:0] ? TBEMemory_4_fields_0 : _GEN_99; // @[TBE.scala 122:15]
  wire [31:0] _GEN_105 = 3'h5 == idxUpdate_0[2:0] ? TBEMemory_5_fields_0 : _GEN_102; // @[TBE.scala 122:15]
  wire [31:0] _GEN_108 = 3'h6 == idxUpdate_0[2:0] ? TBEMemory_6_fields_0 : _GEN_105; // @[TBE.scala 122:15]
  wire [31:0] _GEN_111 = 3'h7 == idxUpdate_0[2:0] ? TBEMemory_7_fields_0 : _GEN_108; // @[TBE.scala 122:15]
  wire  _T_72 = io_write_0_bits_command == 2'h1; // @[TBE.scala 136:44]
  wire  isAlloc_0 = _T_72 & io_write_0_valid; // @[TBE.scala 136:54]
  wire [3:0] idxRead = {{1'd0}, finder_1_io_value_bits}; // @[TBE.scala 72:21 TBE.scala 95:11]
  wire [1:0] _GEN_261 = 3'h1 == idxRead[2:0] ? TBEMemory_1_state_state : TBEMemory_0_state_state; // @[TBE.scala 132:27]
  wire [2:0] _GEN_262 = 3'h1 == idxRead[2:0] ? TBEMemory_1_way : TBEMemory_0_way; // @[TBE.scala 132:27]
  wire [31:0] _GEN_263 = 3'h1 == idxRead[2:0] ? TBEMemory_1_fields_0 : TBEMemory_0_fields_0; // @[TBE.scala 132:27]
  wire [1:0] _GEN_264 = 3'h2 == idxRead[2:0] ? TBEMemory_2_state_state : _GEN_261; // @[TBE.scala 132:27]
  wire [2:0] _GEN_265 = 3'h2 == idxRead[2:0] ? TBEMemory_2_way : _GEN_262; // @[TBE.scala 132:27]
  wire [31:0] _GEN_266 = 3'h2 == idxRead[2:0] ? TBEMemory_2_fields_0 : _GEN_263; // @[TBE.scala 132:27]
  wire [1:0] _GEN_267 = 3'h3 == idxRead[2:0] ? TBEMemory_3_state_state : _GEN_264; // @[TBE.scala 132:27]
  wire [2:0] _GEN_268 = 3'h3 == idxRead[2:0] ? TBEMemory_3_way : _GEN_265; // @[TBE.scala 132:27]
  wire [31:0] _GEN_269 = 3'h3 == idxRead[2:0] ? TBEMemory_3_fields_0 : _GEN_266; // @[TBE.scala 132:27]
  wire [1:0] _GEN_270 = 3'h4 == idxRead[2:0] ? TBEMemory_4_state_state : _GEN_267; // @[TBE.scala 132:27]
  wire [2:0] _GEN_271 = 3'h4 == idxRead[2:0] ? TBEMemory_4_way : _GEN_268; // @[TBE.scala 132:27]
  wire [31:0] _GEN_272 = 3'h4 == idxRead[2:0] ? TBEMemory_4_fields_0 : _GEN_269; // @[TBE.scala 132:27]
  wire [1:0] _GEN_273 = 3'h5 == idxRead[2:0] ? TBEMemory_5_state_state : _GEN_270; // @[TBE.scala 132:27]
  wire [2:0] _GEN_274 = 3'h5 == idxRead[2:0] ? TBEMemory_5_way : _GEN_271; // @[TBE.scala 132:27]
  wire [31:0] _GEN_275 = 3'h5 == idxRead[2:0] ? TBEMemory_5_fields_0 : _GEN_272; // @[TBE.scala 132:27]
  wire [1:0] _GEN_276 = 3'h6 == idxRead[2:0] ? TBEMemory_6_state_state : _GEN_273; // @[TBE.scala 132:27]
  wire [2:0] _GEN_277 = 3'h6 == idxRead[2:0] ? TBEMemory_6_way : _GEN_274; // @[TBE.scala 132:27]
  wire [31:0] _GEN_278 = 3'h6 == idxRead[2:0] ? TBEMemory_6_fields_0 : _GEN_275; // @[TBE.scala 132:27]
  wire [1:0] _GEN_279 = 3'h7 == idxRead[2:0] ? TBEMemory_7_state_state : _GEN_276; // @[TBE.scala 132:27]
  wire [2:0] _GEN_280 = 3'h7 == idxRead[2:0] ? TBEMemory_7_way : _GEN_277; // @[TBE.scala 132:27]
  wire [31:0] _GEN_281 = 3'h7 == idxRead[2:0] ? TBEMemory_7_fields_0 : _GEN_278; // @[TBE.scala 132:27]
  wire  _GEN_291 = ~isAlloc_0; // @[TBE.scala 122:15]
  wire  _GEN_292 = ~_T_52; // @[TBE.scala 122:15]
  wire  _GEN_293 = _GEN_291 & _GEN_292; // @[TBE.scala 122:15]
  wire  _GEN_294 = _GEN_293 & _T_60; // @[TBE.scala 122:15]
  wire  _GEN_295 = _GEN_294 & _T_61; // @[TBE.scala 122:15]
  FindEmptyLine_2 allocLine ( // @[TBE.scala 79:25]
    .io_data_0(allocLine_io_data_0),
    .io_data_1(allocLine_io_data_1),
    .io_data_2(allocLine_io_data_2),
    .io_data_3(allocLine_io_data_3),
    .io_data_4(allocLine_io_data_4),
    .io_data_5(allocLine_io_data_5),
    .io_data_6(allocLine_io_data_6),
    .io_data_7(allocLine_io_data_7),
    .io_value_bits(allocLine_io_value_bits)
  );
  Find_2 finder_0 ( // @[TBE.scala 84:24]
    .io_key(finder_0_io_key),
    .io_data_0(finder_0_io_data_0),
    .io_data_1(finder_0_io_data_1),
    .io_data_2(finder_0_io_data_2),
    .io_data_3(finder_0_io_data_3),
    .io_data_4(finder_0_io_data_4),
    .io_data_5(finder_0_io_data_5),
    .io_data_6(finder_0_io_data_6),
    .io_data_7(finder_0_io_data_7),
    .io_valid_0(finder_0_io_valid_0),
    .io_valid_1(finder_0_io_valid_1),
    .io_valid_2(finder_0_io_valid_2),
    .io_valid_3(finder_0_io_valid_3),
    .io_valid_4(finder_0_io_valid_4),
    .io_valid_5(finder_0_io_valid_5),
    .io_valid_6(finder_0_io_valid_6),
    .io_valid_7(finder_0_io_valid_7),
    .io_value_valid(finder_0_io_value_valid),
    .io_value_bits(finder_0_io_value_bits)
  );
  Find_2 finder_1 ( // @[TBE.scala 84:24]
    .io_key(finder_1_io_key),
    .io_data_0(finder_1_io_data_0),
    .io_data_1(finder_1_io_data_1),
    .io_data_2(finder_1_io_data_2),
    .io_data_3(finder_1_io_data_3),
    .io_data_4(finder_1_io_data_4),
    .io_data_5(finder_1_io_data_5),
    .io_data_6(finder_1_io_data_6),
    .io_data_7(finder_1_io_data_7),
    .io_valid_0(finder_1_io_valid_0),
    .io_valid_1(finder_1_io_valid_1),
    .io_valid_2(finder_1_io_valid_2),
    .io_valid_3(finder_1_io_valid_3),
    .io_valid_4(finder_1_io_valid_4),
    .io_valid_5(finder_1_io_valid_5),
    .io_valid_6(finder_1_io_valid_6),
    .io_valid_7(finder_1_io_valid_7),
    .io_value_valid(finder_1_io_value_valid),
    .io_value_bits(finder_1_io_value_bits)
  );
  assign io_outputTBE_bits_state_state = idxReadValid ? _GEN_279 : 2'h0; // @[TBE.scala 132:21]
  assign io_outputTBE_bits_way = idxReadValid ? _GEN_280 : 3'h2; // @[TBE.scala 132:21]
  assign io_outputTBE_bits_fields_0 = idxReadValid ? _GEN_281 : 32'h0; // @[TBE.scala 132:21]
  assign io_isFull = _T_40 & _T_41; // @[TBE.scala 90:13]
  assign allocLine_io_data_0 = TBEValid_0; // @[TBE.scala 80:21]
  assign allocLine_io_data_1 = TBEValid_1; // @[TBE.scala 80:21]
  assign allocLine_io_data_2 = TBEValid_2; // @[TBE.scala 80:21]
  assign allocLine_io_data_3 = TBEValid_3; // @[TBE.scala 80:21]
  assign allocLine_io_data_4 = TBEValid_4; // @[TBE.scala 80:21]
  assign allocLine_io_data_5 = TBEValid_5; // @[TBE.scala 80:21]
  assign allocLine_io_data_6 = TBEValid_6; // @[TBE.scala 80:21]
  assign allocLine_io_data_7 = TBEValid_7; // @[TBE.scala 80:21]
  assign finder_0_io_key = io_write_0_bits_addr[31:0]; // @[TBE.scala 100:22]
  assign finder_0_io_data_0 = TBEAddr_0; // @[TBE.scala 101:23]
  assign finder_0_io_data_1 = TBEAddr_1; // @[TBE.scala 101:23]
  assign finder_0_io_data_2 = TBEAddr_2; // @[TBE.scala 101:23]
  assign finder_0_io_data_3 = TBEAddr_3; // @[TBE.scala 101:23]
  assign finder_0_io_data_4 = TBEAddr_4; // @[TBE.scala 101:23]
  assign finder_0_io_data_5 = TBEAddr_5; // @[TBE.scala 101:23]
  assign finder_0_io_data_6 = TBEAddr_6; // @[TBE.scala 101:23]
  assign finder_0_io_data_7 = TBEAddr_7; // @[TBE.scala 101:23]
  assign finder_0_io_valid_0 = TBEValid_0; // @[TBE.scala 102:24]
  assign finder_0_io_valid_1 = TBEValid_1; // @[TBE.scala 102:24]
  assign finder_0_io_valid_2 = TBEValid_2; // @[TBE.scala 102:24]
  assign finder_0_io_valid_3 = TBEValid_3; // @[TBE.scala 102:24]
  assign finder_0_io_valid_4 = TBEValid_4; // @[TBE.scala 102:24]
  assign finder_0_io_valid_5 = TBEValid_5; // @[TBE.scala 102:24]
  assign finder_0_io_valid_6 = TBEValid_6; // @[TBE.scala 102:24]
  assign finder_0_io_valid_7 = TBEValid_7; // @[TBE.scala 102:24]
  assign finder_1_io_key = io_read_bits_addr[31:0]; // @[TBE.scala 92:25]
  assign finder_1_io_data_0 = TBEAddr_0; // @[TBE.scala 93:26]
  assign finder_1_io_data_1 = TBEAddr_1; // @[TBE.scala 93:26]
  assign finder_1_io_data_2 = TBEAddr_2; // @[TBE.scala 93:26]
  assign finder_1_io_data_3 = TBEAddr_3; // @[TBE.scala 93:26]
  assign finder_1_io_data_4 = TBEAddr_4; // @[TBE.scala 93:26]
  assign finder_1_io_data_5 = TBEAddr_5; // @[TBE.scala 93:26]
  assign finder_1_io_data_6 = TBEAddr_6; // @[TBE.scala 93:26]
  assign finder_1_io_data_7 = TBEAddr_7; // @[TBE.scala 93:26]
  assign finder_1_io_valid_0 = TBEValid_0; // @[TBE.scala 94:27]
  assign finder_1_io_valid_1 = TBEValid_1; // @[TBE.scala 94:27]
  assign finder_1_io_valid_2 = TBEValid_2; // @[TBE.scala 94:27]
  assign finder_1_io_valid_3 = TBEValid_3; // @[TBE.scala 94:27]
  assign finder_1_io_valid_4 = TBEValid_4; // @[TBE.scala 94:27]
  assign finder_1_io_valid_5 = TBEValid_5; // @[TBE.scala 94:27]
  assign finder_1_io_valid_6 = TBEValid_6; // @[TBE.scala 94:27]
  assign finder_1_io_valid_7 = TBEValid_7; // @[TBE.scala 94:27]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  TBEMemory_0_state_state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  TBEMemory_0_way = _RAND_1[2:0];
  _RAND_2 = {1{`RANDOM}};
  TBEMemory_0_fields_0 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  TBEMemory_1_state_state = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  TBEMemory_1_way = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  TBEMemory_1_fields_0 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  TBEMemory_2_state_state = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  TBEMemory_2_way = _RAND_7[2:0];
  _RAND_8 = {1{`RANDOM}};
  TBEMemory_2_fields_0 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  TBEMemory_3_state_state = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  TBEMemory_3_way = _RAND_10[2:0];
  _RAND_11 = {1{`RANDOM}};
  TBEMemory_3_fields_0 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  TBEMemory_4_state_state = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  TBEMemory_4_way = _RAND_13[2:0];
  _RAND_14 = {1{`RANDOM}};
  TBEMemory_4_fields_0 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  TBEMemory_5_state_state = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  TBEMemory_5_way = _RAND_16[2:0];
  _RAND_17 = {1{`RANDOM}};
  TBEMemory_5_fields_0 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  TBEMemory_6_state_state = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  TBEMemory_6_way = _RAND_19[2:0];
  _RAND_20 = {1{`RANDOM}};
  TBEMemory_6_fields_0 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  TBEMemory_7_state_state = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  TBEMemory_7_way = _RAND_22[2:0];
  _RAND_23 = {1{`RANDOM}};
  TBEMemory_7_fields_0 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  TBEValid_0 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  TBEValid_1 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  TBEValid_2 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  TBEValid_3 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  TBEValid_4 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  TBEValid_5 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  TBEValid_6 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  TBEValid_7 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  TBEAddr_0 = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  TBEAddr_1 = _RAND_33[31:0];
  _RAND_34 = {1{`RANDOM}};
  TBEAddr_2 = _RAND_34[31:0];
  _RAND_35 = {1{`RANDOM}};
  TBEAddr_3 = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  TBEAddr_4 = _RAND_36[31:0];
  _RAND_37 = {1{`RANDOM}};
  TBEAddr_5 = _RAND_37[31:0];
  _RAND_38 = {1{`RANDOM}};
  TBEAddr_6 = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  TBEAddr_7 = _RAND_39[31:0];
  _RAND_40 = {1{`RANDOM}};
  counter = _RAND_40[4:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      TBEMemory_0_state_state <= 2'h0;
    end else if (isAlloc_0) begin
      if (3'h0 == idxAlloc[2:0]) begin
        TBEMemory_0_state_state <= io_write_0_bits_inputTBE_state_state;
      end
    end else if (_T_52) begin
      if (3'h0 == idxUpdate_0[2:0]) begin
        TBEMemory_0_state_state <= 2'h0;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h0 == idxUpdate_0[2:0]) begin
          TBEMemory_0_state_state <= io_write_0_bits_inputTBE_state_state;
        end
      end
    end
    if (reset) begin
      TBEMemory_0_way <= 3'h2;
    end else if (isAlloc_0) begin
      if (3'h0 == idxAlloc[2:0]) begin
        TBEMemory_0_way <= io_write_0_bits_inputTBE_way;
      end
    end else if (_T_52) begin
      if (3'h0 == idxUpdate_0[2:0]) begin
        TBEMemory_0_way <= 3'h2;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h0 == idxUpdate_0[2:0]) begin
          TBEMemory_0_way <= io_write_0_bits_inputTBE_way;
        end
      end
    end
    if (reset) begin
      TBEMemory_0_fields_0 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h0 == idxAlloc[2:0]) begin
        TBEMemory_0_fields_0 <= io_write_0_bits_inputTBE_fields_0;
      end
    end else if (_T_52) begin
      if (3'h0 == idxUpdate_0[2:0]) begin
        TBEMemory_0_fields_0 <= 32'h0;
      end
    end else if (_T_60) begin
      if (_T_61) begin
        if (3'h0 == idxUpdate_0[2:0]) begin
          TBEMemory_0_fields_0 <= io_write_0_bits_inputTBE_fields_0;
        end
      end
    end
    if (reset) begin
      TBEMemory_1_state_state <= 2'h0;
    end else if (isAlloc_0) begin
      if (3'h1 == idxAlloc[2:0]) begin
        TBEMemory_1_state_state <= io_write_0_bits_inputTBE_state_state;
      end
    end else if (_T_52) begin
      if (3'h1 == idxUpdate_0[2:0]) begin
        TBEMemory_1_state_state <= 2'h0;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h1 == idxUpdate_0[2:0]) begin
          TBEMemory_1_state_state <= io_write_0_bits_inputTBE_state_state;
        end
      end
    end
    if (reset) begin
      TBEMemory_1_way <= 3'h2;
    end else if (isAlloc_0) begin
      if (3'h1 == idxAlloc[2:0]) begin
        TBEMemory_1_way <= io_write_0_bits_inputTBE_way;
      end
    end else if (_T_52) begin
      if (3'h1 == idxUpdate_0[2:0]) begin
        TBEMemory_1_way <= 3'h2;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h1 == idxUpdate_0[2:0]) begin
          TBEMemory_1_way <= io_write_0_bits_inputTBE_way;
        end
      end
    end
    if (reset) begin
      TBEMemory_1_fields_0 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h1 == idxAlloc[2:0]) begin
        TBEMemory_1_fields_0 <= io_write_0_bits_inputTBE_fields_0;
      end
    end else if (_T_52) begin
      if (3'h1 == idxUpdate_0[2:0]) begin
        TBEMemory_1_fields_0 <= 32'h0;
      end
    end else if (_T_60) begin
      if (_T_61) begin
        if (3'h1 == idxUpdate_0[2:0]) begin
          TBEMemory_1_fields_0 <= io_write_0_bits_inputTBE_fields_0;
        end
      end
    end
    if (reset) begin
      TBEMemory_2_state_state <= 2'h0;
    end else if (isAlloc_0) begin
      if (3'h2 == idxAlloc[2:0]) begin
        TBEMemory_2_state_state <= io_write_0_bits_inputTBE_state_state;
      end
    end else if (_T_52) begin
      if (3'h2 == idxUpdate_0[2:0]) begin
        TBEMemory_2_state_state <= 2'h0;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h2 == idxUpdate_0[2:0]) begin
          TBEMemory_2_state_state <= io_write_0_bits_inputTBE_state_state;
        end
      end
    end
    if (reset) begin
      TBEMemory_2_way <= 3'h2;
    end else if (isAlloc_0) begin
      if (3'h2 == idxAlloc[2:0]) begin
        TBEMemory_2_way <= io_write_0_bits_inputTBE_way;
      end
    end else if (_T_52) begin
      if (3'h2 == idxUpdate_0[2:0]) begin
        TBEMemory_2_way <= 3'h2;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h2 == idxUpdate_0[2:0]) begin
          TBEMemory_2_way <= io_write_0_bits_inputTBE_way;
        end
      end
    end
    if (reset) begin
      TBEMemory_2_fields_0 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h2 == idxAlloc[2:0]) begin
        TBEMemory_2_fields_0 <= io_write_0_bits_inputTBE_fields_0;
      end
    end else if (_T_52) begin
      if (3'h2 == idxUpdate_0[2:0]) begin
        TBEMemory_2_fields_0 <= 32'h0;
      end
    end else if (_T_60) begin
      if (_T_61) begin
        if (3'h2 == idxUpdate_0[2:0]) begin
          TBEMemory_2_fields_0 <= io_write_0_bits_inputTBE_fields_0;
        end
      end
    end
    if (reset) begin
      TBEMemory_3_state_state <= 2'h0;
    end else if (isAlloc_0) begin
      if (3'h3 == idxAlloc[2:0]) begin
        TBEMemory_3_state_state <= io_write_0_bits_inputTBE_state_state;
      end
    end else if (_T_52) begin
      if (3'h3 == idxUpdate_0[2:0]) begin
        TBEMemory_3_state_state <= 2'h0;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h3 == idxUpdate_0[2:0]) begin
          TBEMemory_3_state_state <= io_write_0_bits_inputTBE_state_state;
        end
      end
    end
    if (reset) begin
      TBEMemory_3_way <= 3'h2;
    end else if (isAlloc_0) begin
      if (3'h3 == idxAlloc[2:0]) begin
        TBEMemory_3_way <= io_write_0_bits_inputTBE_way;
      end
    end else if (_T_52) begin
      if (3'h3 == idxUpdate_0[2:0]) begin
        TBEMemory_3_way <= 3'h2;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h3 == idxUpdate_0[2:0]) begin
          TBEMemory_3_way <= io_write_0_bits_inputTBE_way;
        end
      end
    end
    if (reset) begin
      TBEMemory_3_fields_0 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h3 == idxAlloc[2:0]) begin
        TBEMemory_3_fields_0 <= io_write_0_bits_inputTBE_fields_0;
      end
    end else if (_T_52) begin
      if (3'h3 == idxUpdate_0[2:0]) begin
        TBEMemory_3_fields_0 <= 32'h0;
      end
    end else if (_T_60) begin
      if (_T_61) begin
        if (3'h3 == idxUpdate_0[2:0]) begin
          TBEMemory_3_fields_0 <= io_write_0_bits_inputTBE_fields_0;
        end
      end
    end
    if (reset) begin
      TBEMemory_4_state_state <= 2'h0;
    end else if (isAlloc_0) begin
      if (3'h4 == idxAlloc[2:0]) begin
        TBEMemory_4_state_state <= io_write_0_bits_inputTBE_state_state;
      end
    end else if (_T_52) begin
      if (3'h4 == idxUpdate_0[2:0]) begin
        TBEMemory_4_state_state <= 2'h0;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h4 == idxUpdate_0[2:0]) begin
          TBEMemory_4_state_state <= io_write_0_bits_inputTBE_state_state;
        end
      end
    end
    if (reset) begin
      TBEMemory_4_way <= 3'h2;
    end else if (isAlloc_0) begin
      if (3'h4 == idxAlloc[2:0]) begin
        TBEMemory_4_way <= io_write_0_bits_inputTBE_way;
      end
    end else if (_T_52) begin
      if (3'h4 == idxUpdate_0[2:0]) begin
        TBEMemory_4_way <= 3'h2;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h4 == idxUpdate_0[2:0]) begin
          TBEMemory_4_way <= io_write_0_bits_inputTBE_way;
        end
      end
    end
    if (reset) begin
      TBEMemory_4_fields_0 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h4 == idxAlloc[2:0]) begin
        TBEMemory_4_fields_0 <= io_write_0_bits_inputTBE_fields_0;
      end
    end else if (_T_52) begin
      if (3'h4 == idxUpdate_0[2:0]) begin
        TBEMemory_4_fields_0 <= 32'h0;
      end
    end else if (_T_60) begin
      if (_T_61) begin
        if (3'h4 == idxUpdate_0[2:0]) begin
          TBEMemory_4_fields_0 <= io_write_0_bits_inputTBE_fields_0;
        end
      end
    end
    if (reset) begin
      TBEMemory_5_state_state <= 2'h0;
    end else if (isAlloc_0) begin
      if (3'h5 == idxAlloc[2:0]) begin
        TBEMemory_5_state_state <= io_write_0_bits_inputTBE_state_state;
      end
    end else if (_T_52) begin
      if (3'h5 == idxUpdate_0[2:0]) begin
        TBEMemory_5_state_state <= 2'h0;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h5 == idxUpdate_0[2:0]) begin
          TBEMemory_5_state_state <= io_write_0_bits_inputTBE_state_state;
        end
      end
    end
    if (reset) begin
      TBEMemory_5_way <= 3'h2;
    end else if (isAlloc_0) begin
      if (3'h5 == idxAlloc[2:0]) begin
        TBEMemory_5_way <= io_write_0_bits_inputTBE_way;
      end
    end else if (_T_52) begin
      if (3'h5 == idxUpdate_0[2:0]) begin
        TBEMemory_5_way <= 3'h2;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h5 == idxUpdate_0[2:0]) begin
          TBEMemory_5_way <= io_write_0_bits_inputTBE_way;
        end
      end
    end
    if (reset) begin
      TBEMemory_5_fields_0 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h5 == idxAlloc[2:0]) begin
        TBEMemory_5_fields_0 <= io_write_0_bits_inputTBE_fields_0;
      end
    end else if (_T_52) begin
      if (3'h5 == idxUpdate_0[2:0]) begin
        TBEMemory_5_fields_0 <= 32'h0;
      end
    end else if (_T_60) begin
      if (_T_61) begin
        if (3'h5 == idxUpdate_0[2:0]) begin
          TBEMemory_5_fields_0 <= io_write_0_bits_inputTBE_fields_0;
        end
      end
    end
    if (reset) begin
      TBEMemory_6_state_state <= 2'h0;
    end else if (isAlloc_0) begin
      if (3'h6 == idxAlloc[2:0]) begin
        TBEMemory_6_state_state <= io_write_0_bits_inputTBE_state_state;
      end
    end else if (_T_52) begin
      if (3'h6 == idxUpdate_0[2:0]) begin
        TBEMemory_6_state_state <= 2'h0;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h6 == idxUpdate_0[2:0]) begin
          TBEMemory_6_state_state <= io_write_0_bits_inputTBE_state_state;
        end
      end
    end
    if (reset) begin
      TBEMemory_6_way <= 3'h2;
    end else if (isAlloc_0) begin
      if (3'h6 == idxAlloc[2:0]) begin
        TBEMemory_6_way <= io_write_0_bits_inputTBE_way;
      end
    end else if (_T_52) begin
      if (3'h6 == idxUpdate_0[2:0]) begin
        TBEMemory_6_way <= 3'h2;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h6 == idxUpdate_0[2:0]) begin
          TBEMemory_6_way <= io_write_0_bits_inputTBE_way;
        end
      end
    end
    if (reset) begin
      TBEMemory_6_fields_0 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h6 == idxAlloc[2:0]) begin
        TBEMemory_6_fields_0 <= io_write_0_bits_inputTBE_fields_0;
      end
    end else if (_T_52) begin
      if (3'h6 == idxUpdate_0[2:0]) begin
        TBEMemory_6_fields_0 <= 32'h0;
      end
    end else if (_T_60) begin
      if (_T_61) begin
        if (3'h6 == idxUpdate_0[2:0]) begin
          TBEMemory_6_fields_0 <= io_write_0_bits_inputTBE_fields_0;
        end
      end
    end
    if (reset) begin
      TBEMemory_7_state_state <= 2'h0;
    end else if (isAlloc_0) begin
      if (3'h7 == idxAlloc[2:0]) begin
        TBEMemory_7_state_state <= io_write_0_bits_inputTBE_state_state;
      end
    end else if (_T_52) begin
      if (3'h7 == idxUpdate_0[2:0]) begin
        TBEMemory_7_state_state <= 2'h0;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h7 == idxUpdate_0[2:0]) begin
          TBEMemory_7_state_state <= io_write_0_bits_inputTBE_state_state;
        end
      end
    end
    if (reset) begin
      TBEMemory_7_way <= 3'h2;
    end else if (isAlloc_0) begin
      if (3'h7 == idxAlloc[2:0]) begin
        TBEMemory_7_way <= io_write_0_bits_inputTBE_way;
      end
    end else if (_T_52) begin
      if (3'h7 == idxUpdate_0[2:0]) begin
        TBEMemory_7_way <= 3'h2;
      end
    end else if (_T_60) begin
      if (!(_T_61)) begin
        if (3'h7 == idxUpdate_0[2:0]) begin
          TBEMemory_7_way <= io_write_0_bits_inputTBE_way;
        end
      end
    end
    if (reset) begin
      TBEMemory_7_fields_0 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h7 == idxAlloc[2:0]) begin
        TBEMemory_7_fields_0 <= io_write_0_bits_inputTBE_fields_0;
      end
    end else if (_T_52) begin
      if (3'h7 == idxUpdate_0[2:0]) begin
        TBEMemory_7_fields_0 <= 32'h0;
      end
    end else if (_T_60) begin
      if (_T_61) begin
        if (3'h7 == idxUpdate_0[2:0]) begin
          TBEMemory_7_fields_0 <= io_write_0_bits_inputTBE_fields_0;
        end
      end
    end
    if (reset) begin
      TBEValid_0 <= 1'h0;
    end else if (isAlloc_0) begin
      TBEValid_0 <= _GEN_32;
    end else if (_T_52) begin
      if (3'h0 == idxUpdate_0[2:0]) begin
        TBEValid_0 <= 1'h0;
      end
    end
    if (reset) begin
      TBEValid_1 <= 1'h0;
    end else if (isAlloc_0) begin
      TBEValid_1 <= _GEN_33;
    end else if (_T_52) begin
      if (3'h1 == idxUpdate_0[2:0]) begin
        TBEValid_1 <= 1'h0;
      end
    end
    if (reset) begin
      TBEValid_2 <= 1'h0;
    end else if (isAlloc_0) begin
      TBEValid_2 <= _GEN_34;
    end else if (_T_52) begin
      if (3'h2 == idxUpdate_0[2:0]) begin
        TBEValid_2 <= 1'h0;
      end
    end
    if (reset) begin
      TBEValid_3 <= 1'h0;
    end else if (isAlloc_0) begin
      TBEValid_3 <= _GEN_35;
    end else if (_T_52) begin
      if (3'h3 == idxUpdate_0[2:0]) begin
        TBEValid_3 <= 1'h0;
      end
    end
    if (reset) begin
      TBEValid_4 <= 1'h0;
    end else if (isAlloc_0) begin
      TBEValid_4 <= _GEN_36;
    end else if (_T_52) begin
      if (3'h4 == idxUpdate_0[2:0]) begin
        TBEValid_4 <= 1'h0;
      end
    end
    if (reset) begin
      TBEValid_5 <= 1'h0;
    end else if (isAlloc_0) begin
      TBEValid_5 <= _GEN_37;
    end else if (_T_52) begin
      if (3'h5 == idxUpdate_0[2:0]) begin
        TBEValid_5 <= 1'h0;
      end
    end
    if (reset) begin
      TBEValid_6 <= 1'h0;
    end else if (isAlloc_0) begin
      TBEValid_6 <= _GEN_38;
    end else if (_T_52) begin
      if (3'h6 == idxUpdate_0[2:0]) begin
        TBEValid_6 <= 1'h0;
      end
    end
    if (reset) begin
      TBEValid_7 <= 1'h0;
    end else if (isAlloc_0) begin
      TBEValid_7 <= _GEN_39;
    end else if (_T_52) begin
      if (3'h7 == idxUpdate_0[2:0]) begin
        TBEValid_7 <= 1'h0;
      end
    end
    if (reset) begin
      TBEAddr_0 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h0 == idxAlloc[2:0]) begin
        TBEAddr_0 <= io_write_0_bits_addr[31:0];
      end
    end else if (_T_52) begin
      if (3'h0 == idxUpdate_0[2:0]) begin
        TBEAddr_0 <= 32'h0;
      end
    end
    if (reset) begin
      TBEAddr_1 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h1 == idxAlloc[2:0]) begin
        TBEAddr_1 <= io_write_0_bits_addr[31:0];
      end
    end else if (_T_52) begin
      if (3'h1 == idxUpdate_0[2:0]) begin
        TBEAddr_1 <= 32'h0;
      end
    end
    if (reset) begin
      TBEAddr_2 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h2 == idxAlloc[2:0]) begin
        TBEAddr_2 <= io_write_0_bits_addr[31:0];
      end
    end else if (_T_52) begin
      if (3'h2 == idxUpdate_0[2:0]) begin
        TBEAddr_2 <= 32'h0;
      end
    end
    if (reset) begin
      TBEAddr_3 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h3 == idxAlloc[2:0]) begin
        TBEAddr_3 <= io_write_0_bits_addr[31:0];
      end
    end else if (_T_52) begin
      if (3'h3 == idxUpdate_0[2:0]) begin
        TBEAddr_3 <= 32'h0;
      end
    end
    if (reset) begin
      TBEAddr_4 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h4 == idxAlloc[2:0]) begin
        TBEAddr_4 <= io_write_0_bits_addr[31:0];
      end
    end else if (_T_52) begin
      if (3'h4 == idxUpdate_0[2:0]) begin
        TBEAddr_4 <= 32'h0;
      end
    end
    if (reset) begin
      TBEAddr_5 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h5 == idxAlloc[2:0]) begin
        TBEAddr_5 <= io_write_0_bits_addr[31:0];
      end
    end else if (_T_52) begin
      if (3'h5 == idxUpdate_0[2:0]) begin
        TBEAddr_5 <= 32'h0;
      end
    end
    if (reset) begin
      TBEAddr_6 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h6 == idxAlloc[2:0]) begin
        TBEAddr_6 <= io_write_0_bits_addr[31:0];
      end
    end else if (_T_52) begin
      if (3'h6 == idxUpdate_0[2:0]) begin
        TBEAddr_6 <= 32'h0;
      end
    end
    if (reset) begin
      TBEAddr_7 <= 32'h0;
    end else if (isAlloc_0) begin
      if (3'h7 == idxAlloc[2:0]) begin
        TBEAddr_7 <= io_write_0_bits_addr[31:0];
      end
    end else if (_T_52) begin
      if (3'h7 == idxUpdate_0[2:0]) begin
        TBEAddr_7 <= 32'h0;
      end
    end
    if (reset) begin
      counter <= 5'h0;
    end else if (isAlloc_0) begin
      counter <= _T_51;
    end else if (_T_52) begin
      counter <= _T_59;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_295 & _T_65) begin
          $fwrite(32'h80000002,"TBE Field Check %d\n",_GEN_111); // @[TBE.scala 122:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module lockVector(
  input         clock,
  input         reset,
  input         io_lock_in_valid,
  input  [31:0] io_lock_in_bits_addr,
  output        io_probe_out_valid,
  output        io_probe_out_bits,
  input         io_probe_in_valid,
  input  [31:0] io_probe_in_bits_addr,
  input         io_unLock_0_in_valid,
  input  [31:0] io_unLock_0_in_bits_addr
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
`endif // RANDOMIZE_REG_INIT
  wire [31:0] finder_0_io_key; // @[elements.scala 158:28]
  wire [31:0] finder_0_io_data_0; // @[elements.scala 158:28]
  wire [31:0] finder_0_io_data_1; // @[elements.scala 158:28]
  wire [31:0] finder_0_io_data_2; // @[elements.scala 158:28]
  wire [31:0] finder_0_io_data_3; // @[elements.scala 158:28]
  wire [31:0] finder_0_io_data_4; // @[elements.scala 158:28]
  wire [31:0] finder_0_io_data_5; // @[elements.scala 158:28]
  wire [31:0] finder_0_io_data_6; // @[elements.scala 158:28]
  wire [31:0] finder_0_io_data_7; // @[elements.scala 158:28]
  wire  finder_0_io_valid_0; // @[elements.scala 158:28]
  wire  finder_0_io_valid_1; // @[elements.scala 158:28]
  wire  finder_0_io_valid_2; // @[elements.scala 158:28]
  wire  finder_0_io_valid_3; // @[elements.scala 158:28]
  wire  finder_0_io_valid_4; // @[elements.scala 158:28]
  wire  finder_0_io_valid_5; // @[elements.scala 158:28]
  wire  finder_0_io_valid_6; // @[elements.scala 158:28]
  wire  finder_0_io_valid_7; // @[elements.scala 158:28]
  wire  finder_0_io_value_valid; // @[elements.scala 158:28]
  wire [2:0] finder_0_io_value_bits; // @[elements.scala 158:28]
  reg [31:0] addrVec_0; // @[elements.scala 148:26]
  reg [31:0] addrVec_1; // @[elements.scala 148:26]
  reg [31:0] addrVec_2; // @[elements.scala 148:26]
  reg [31:0] addrVec_3; // @[elements.scala 148:26]
  reg [31:0] addrVec_4; // @[elements.scala 148:26]
  reg [31:0] addrVec_5; // @[elements.scala 148:26]
  reg [31:0] addrVec_6; // @[elements.scala 148:26]
  reg [31:0] addrVec_7; // @[elements.scala 148:26]
  reg  valid_0; // @[elements.scala 149:26]
  reg  valid_1; // @[elements.scala 149:26]
  reg  valid_2; // @[elements.scala 149:26]
  reg  valid_3; // @[elements.scala 149:26]
  reg  valid_4; // @[elements.scala 149:26]
  reg  valid_5; // @[elements.scala 149:26]
  reg  valid_6; // @[elements.scala 149:26]
  reg  valid_7; // @[elements.scala 149:26]
  wire  _T_23 = addrVec_7 == io_probe_in_bits_addr; // @[elements.scala 175:53]
  wire  _T_21 = addrVec_6 == io_probe_in_bits_addr; // @[elements.scala 175:53]
  wire  _T_19 = addrVec_5 == io_probe_in_bits_addr; // @[elements.scala 175:53]
  wire  _T_17 = addrVec_4 == io_probe_in_bits_addr; // @[elements.scala 175:53]
  wire  _T_15 = addrVec_3 == io_probe_in_bits_addr; // @[elements.scala 175:53]
  wire  _T_13 = addrVec_2 == io_probe_in_bits_addr; // @[elements.scala 175:53]
  wire  _T_11 = addrVec_1 == io_probe_in_bits_addr; // @[elements.scala 175:53]
  wire  _T_9 = addrVec_0 == io_probe_in_bits_addr; // @[elements.scala 175:53]
  wire [7:0] bitmapProbe = {_T_23,_T_21,_T_19,_T_17,_T_15,_T_13,_T_11,_T_9}; // @[Cat.scala 29:58]
  wire [7:0] _T_69 = {valid_7,valid_6,valid_5,valid_4,valid_3,valid_2,valid_1,valid_0}; // @[elements.scala 201:45]
  wire [7:0] _T_70 = bitmapProbe & _T_69; // @[elements.scala 201:31]
  wire  isLocked = _T_70 != 8'h0; // @[elements.scala 201:49]
  wire  _T_4 = ~isLocked; // @[elements.scala 171:28]
  wire  write = _T_4 & io_lock_in_valid; // @[elements.scala 171:38]
  wire  _T_53 = io_unLock_0_in_valid & finder_0_io_value_valid; // @[elements.scala 189:23]
  wire [7:0] idxUnlock_0 = {{5'd0}, finder_0_io_value_bits}; // @[elements.scala 155:26 elements.scala 185:22]
  wire  _GEN_0 = 3'h0 == idxUnlock_0[2:0] ? 1'h0 : valid_0; // @[elements.scala 190:33]
  wire  _GEN_1 = 3'h1 == idxUnlock_0[2:0] ? 1'h0 : valid_1; // @[elements.scala 190:33]
  wire  _GEN_2 = 3'h2 == idxUnlock_0[2:0] ? 1'h0 : valid_2; // @[elements.scala 190:33]
  wire  _GEN_3 = 3'h3 == idxUnlock_0[2:0] ? 1'h0 : valid_3; // @[elements.scala 190:33]
  wire  _GEN_4 = 3'h4 == idxUnlock_0[2:0] ? 1'h0 : valid_4; // @[elements.scala 190:33]
  wire  _GEN_5 = 3'h5 == idxUnlock_0[2:0] ? 1'h0 : valid_5; // @[elements.scala 190:33]
  wire  _GEN_6 = 3'h6 == idxUnlock_0[2:0] ? 1'h0 : valid_6; // @[elements.scala 190:33]
  wire  _GEN_7 = 3'h7 == idxUnlock_0[2:0] ? 1'h0 : valid_7; // @[elements.scala 190:33]
  wire  _GEN_8 = _T_53 ? _GEN_0 : valid_0; // @[elements.scala 189:52]
  wire  _GEN_9 = _T_53 ? _GEN_1 : valid_1; // @[elements.scala 189:52]
  wire  _GEN_10 = _T_53 ? _GEN_2 : valid_2; // @[elements.scala 189:52]
  wire  _GEN_11 = _T_53 ? _GEN_3 : valid_3; // @[elements.scala 189:52]
  wire  _GEN_12 = _T_53 ? _GEN_4 : valid_4; // @[elements.scala 189:52]
  wire  _GEN_13 = _T_53 ? _GEN_5 : valid_5; // @[elements.scala 189:52]
  wire  _GEN_14 = _T_53 ? _GEN_6 : valid_6; // @[elements.scala 189:52]
  wire  _GEN_15 = _T_53 ? _GEN_7 : valid_7; // @[elements.scala 189:52]
  wire  _T_55 = ~valid_0; // @[elements.scala 196:46]
  wire  _T_56 = ~valid_1; // @[elements.scala 196:46]
  wire  _T_57 = ~valid_2; // @[elements.scala 196:46]
  wire  _T_58 = ~valid_3; // @[elements.scala 196:46]
  wire  _T_59 = ~valid_4; // @[elements.scala 196:46]
  wire  _T_60 = ~valid_5; // @[elements.scala 196:46]
  wire  _T_61 = ~valid_6; // @[elements.scala 196:46]
  wire  _T_62 = ~valid_7; // @[elements.scala 196:46]
  wire [3:0] _GEN_16 = _T_62 ? 4'h7 : 4'h8; // @[elements.scala 196:59]
  wire [3:0] _GEN_17 = _T_61 ? 4'h6 : _GEN_16; // @[elements.scala 196:59]
  wire [3:0] _GEN_18 = _T_60 ? 4'h5 : _GEN_17; // @[elements.scala 196:59]
  wire [3:0] _GEN_19 = _T_59 ? 4'h4 : _GEN_18; // @[elements.scala 196:59]
  wire [3:0] _GEN_20 = _T_58 ? 4'h3 : _GEN_19; // @[elements.scala 196:59]
  wire [3:0] _GEN_21 = _T_57 ? 4'h2 : _GEN_20; // @[elements.scala 196:59]
  wire [3:0] _GEN_22 = _T_56 ? 4'h1 : _GEN_21; // @[elements.scala 196:59]
  wire [3:0] _GEN_23 = _T_55 ? 4'h0 : _GEN_22; // @[elements.scala 196:59]
  wire [7:0] idxLocking = {{4'd0}, _GEN_23}; // @[elements.scala 153:26 elements.scala 177:16 elements.scala 197:28 elements.scala 197:28 elements.scala 197:28 elements.scala 197:28 elements.scala 197:28 elements.scala 197:28 elements.scala 197:28 elements.scala 197:28]
  wire  _GEN_57 = 3'h0 == idxLocking[2:0]; // @[elements.scala 212:27]
  wire  _GEN_41 = _GEN_57 | _GEN_8; // @[elements.scala 212:27]
  wire  _GEN_58 = 3'h1 == idxLocking[2:0]; // @[elements.scala 212:27]
  wire  _GEN_42 = _GEN_58 | _GEN_9; // @[elements.scala 212:27]
  wire  _GEN_59 = 3'h2 == idxLocking[2:0]; // @[elements.scala 212:27]
  wire  _GEN_43 = _GEN_59 | _GEN_10; // @[elements.scala 212:27]
  wire  _GEN_60 = 3'h3 == idxLocking[2:0]; // @[elements.scala 212:27]
  wire  _GEN_44 = _GEN_60 | _GEN_11; // @[elements.scala 212:27]
  wire  _GEN_61 = 3'h4 == idxLocking[2:0]; // @[elements.scala 212:27]
  wire  _GEN_45 = _GEN_61 | _GEN_12; // @[elements.scala 212:27]
  wire  _GEN_62 = 3'h5 == idxLocking[2:0]; // @[elements.scala 212:27]
  wire  _GEN_46 = _GEN_62 | _GEN_13; // @[elements.scala 212:27]
  wire  _GEN_63 = 3'h6 == idxLocking[2:0]; // @[elements.scala 212:27]
  wire  _GEN_47 = _GEN_63 | _GEN_14; // @[elements.scala 212:27]
  wire  _GEN_64 = 3'h7 == idxLocking[2:0]; // @[elements.scala 212:27]
  wire  _GEN_48 = _GEN_64 | _GEN_15; // @[elements.scala 212:27]
  Find_2 finder_0 ( // @[elements.scala 158:28]
    .io_key(finder_0_io_key),
    .io_data_0(finder_0_io_data_0),
    .io_data_1(finder_0_io_data_1),
    .io_data_2(finder_0_io_data_2),
    .io_data_3(finder_0_io_data_3),
    .io_data_4(finder_0_io_data_4),
    .io_data_5(finder_0_io_data_5),
    .io_data_6(finder_0_io_data_6),
    .io_data_7(finder_0_io_data_7),
    .io_valid_0(finder_0_io_valid_0),
    .io_valid_1(finder_0_io_valid_1),
    .io_valid_2(finder_0_io_valid_2),
    .io_valid_3(finder_0_io_valid_3),
    .io_valid_4(finder_0_io_valid_4),
    .io_valid_5(finder_0_io_valid_5),
    .io_valid_6(finder_0_io_valid_6),
    .io_valid_7(finder_0_io_valid_7),
    .io_value_valid(finder_0_io_value_valid),
    .io_value_bits(finder_0_io_value_bits)
  );
  assign io_probe_out_valid = io_probe_in_valid; // @[elements.scala 203:24]
  assign io_probe_out_bits = _T_70 != 8'h0; // @[elements.scala 202:23]
  assign finder_0_io_key = io_unLock_0_in_bits_addr; // @[elements.scala 183:26]
  assign finder_0_io_data_0 = addrVec_0; // @[elements.scala 182:27]
  assign finder_0_io_data_1 = addrVec_1; // @[elements.scala 182:27]
  assign finder_0_io_data_2 = addrVec_2; // @[elements.scala 182:27]
  assign finder_0_io_data_3 = addrVec_3; // @[elements.scala 182:27]
  assign finder_0_io_data_4 = addrVec_4; // @[elements.scala 182:27]
  assign finder_0_io_data_5 = addrVec_5; // @[elements.scala 182:27]
  assign finder_0_io_data_6 = addrVec_6; // @[elements.scala 182:27]
  assign finder_0_io_data_7 = addrVec_7; // @[elements.scala 182:27]
  assign finder_0_io_valid_0 = valid_0; // @[elements.scala 184:28]
  assign finder_0_io_valid_1 = valid_1; // @[elements.scala 184:28]
  assign finder_0_io_valid_2 = valid_2; // @[elements.scala 184:28]
  assign finder_0_io_valid_3 = valid_3; // @[elements.scala 184:28]
  assign finder_0_io_valid_4 = valid_4; // @[elements.scala 184:28]
  assign finder_0_io_valid_5 = valid_5; // @[elements.scala 184:28]
  assign finder_0_io_valid_6 = valid_6; // @[elements.scala 184:28]
  assign finder_0_io_valid_7 = valid_7; // @[elements.scala 184:28]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  addrVec_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  addrVec_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  addrVec_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  addrVec_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  addrVec_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  addrVec_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  addrVec_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  addrVec_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  valid_0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  valid_1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  valid_2 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  valid_3 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  valid_4 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  valid_5 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  valid_6 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  valid_7 = _RAND_15[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      addrVec_0 <= 32'h0;
    end else if (write) begin
      if (3'h0 == idxLocking[2:0]) begin
        addrVec_0 <= io_lock_in_bits_addr;
      end
    end
    if (reset) begin
      addrVec_1 <= 32'h0;
    end else if (write) begin
      if (3'h1 == idxLocking[2:0]) begin
        addrVec_1 <= io_lock_in_bits_addr;
      end
    end
    if (reset) begin
      addrVec_2 <= 32'h0;
    end else if (write) begin
      if (3'h2 == idxLocking[2:0]) begin
        addrVec_2 <= io_lock_in_bits_addr;
      end
    end
    if (reset) begin
      addrVec_3 <= 32'h0;
    end else if (write) begin
      if (3'h3 == idxLocking[2:0]) begin
        addrVec_3 <= io_lock_in_bits_addr;
      end
    end
    if (reset) begin
      addrVec_4 <= 32'h0;
    end else if (write) begin
      if (3'h4 == idxLocking[2:0]) begin
        addrVec_4 <= io_lock_in_bits_addr;
      end
    end
    if (reset) begin
      addrVec_5 <= 32'h0;
    end else if (write) begin
      if (3'h5 == idxLocking[2:0]) begin
        addrVec_5 <= io_lock_in_bits_addr;
      end
    end
    if (reset) begin
      addrVec_6 <= 32'h0;
    end else if (write) begin
      if (3'h6 == idxLocking[2:0]) begin
        addrVec_6 <= io_lock_in_bits_addr;
      end
    end
    if (reset) begin
      addrVec_7 <= 32'h0;
    end else if (write) begin
      if (3'h7 == idxLocking[2:0]) begin
        addrVec_7 <= io_lock_in_bits_addr;
      end
    end
    if (reset) begin
      valid_0 <= 1'h0;
    end else if (write) begin
      valid_0 <= _GEN_41;
    end else if (_T_53) begin
      if (3'h0 == idxUnlock_0[2:0]) begin
        valid_0 <= 1'h0;
      end
    end
    if (reset) begin
      valid_1 <= 1'h0;
    end else if (write) begin
      valid_1 <= _GEN_42;
    end else if (_T_53) begin
      if (3'h1 == idxUnlock_0[2:0]) begin
        valid_1 <= 1'h0;
      end
    end
    if (reset) begin
      valid_2 <= 1'h0;
    end else if (write) begin
      valid_2 <= _GEN_43;
    end else if (_T_53) begin
      if (3'h2 == idxUnlock_0[2:0]) begin
        valid_2 <= 1'h0;
      end
    end
    if (reset) begin
      valid_3 <= 1'h0;
    end else if (write) begin
      valid_3 <= _GEN_44;
    end else if (_T_53) begin
      if (3'h3 == idxUnlock_0[2:0]) begin
        valid_3 <= 1'h0;
      end
    end
    if (reset) begin
      valid_4 <= 1'h0;
    end else if (write) begin
      valid_4 <= _GEN_45;
    end else if (_T_53) begin
      if (3'h4 == idxUnlock_0[2:0]) begin
        valid_4 <= 1'h0;
      end
    end
    if (reset) begin
      valid_5 <= 1'h0;
    end else if (write) begin
      valid_5 <= _GEN_46;
    end else if (_T_53) begin
      if (3'h5 == idxUnlock_0[2:0]) begin
        valid_5 <= 1'h0;
      end
    end
    if (reset) begin
      valid_6 <= 1'h0;
    end else if (write) begin
      valid_6 <= _GEN_47;
    end else if (_T_53) begin
      if (3'h6 == idxUnlock_0[2:0]) begin
        valid_6 <= 1'h0;
      end
    end
    if (reset) begin
      valid_7 <= 1'h0;
    end else if (write) begin
      valid_7 <= _GEN_48;
    end else if (_T_53) begin
      if (3'h7 == idxUnlock_0[2:0]) begin
        valid_7 <= 1'h0;
      end
    end
  end
endmodule
module stateMem(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [1:0]  io_in_0_bits_state_state,
  input  [31:0] io_in_0_bits_addr,
  input  [1:0]  io_in_0_bits_way,
  input         io_in_1_valid,
  input  [31:0] io_in_1_bits_addr,
  input  [1:0]  io_in_1_bits_way,
  output        io_out_valid,
  output [1:0]  io_out_bits_state
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [31:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [31:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
  reg [31:0] _RAND_76;
  reg [31:0] _RAND_77;
  reg [31:0] _RAND_78;
  reg [31:0] _RAND_79;
  reg [31:0] _RAND_80;
  reg [31:0] _RAND_81;
  reg [31:0] _RAND_82;
  reg [31:0] _RAND_83;
  reg [31:0] _RAND_84;
  reg [31:0] _RAND_85;
  reg [31:0] _RAND_86;
  reg [31:0] _RAND_87;
  reg [31:0] _RAND_88;
  reg [31:0] _RAND_89;
  reg [31:0] _RAND_90;
  reg [31:0] _RAND_91;
  reg [31:0] _RAND_92;
  reg [31:0] _RAND_93;
  reg [31:0] _RAND_94;
  reg [31:0] _RAND_95;
  reg [31:0] _RAND_96;
  reg [31:0] _RAND_97;
  reg [31:0] _RAND_98;
  reg [31:0] _RAND_99;
  reg [31:0] _RAND_100;
  reg [31:0] _RAND_101;
  reg [31:0] _RAND_102;
  reg [31:0] _RAND_103;
  reg [31:0] _RAND_104;
  reg [31:0] _RAND_105;
  reg [31:0] _RAND_106;
  reg [31:0] _RAND_107;
  reg [31:0] _RAND_108;
  reg [31:0] _RAND_109;
  reg [31:0] _RAND_110;
  reg [31:0] _RAND_111;
  reg [31:0] _RAND_112;
  reg [31:0] _RAND_113;
  reg [31:0] _RAND_114;
  reg [31:0] _RAND_115;
  reg [31:0] _RAND_116;
  reg [31:0] _RAND_117;
  reg [31:0] _RAND_118;
  reg [31:0] _RAND_119;
  reg [31:0] _RAND_120;
  reg [31:0] _RAND_121;
  reg [31:0] _RAND_122;
  reg [31:0] _RAND_123;
  reg [31:0] _RAND_124;
  reg [31:0] _RAND_125;
  reg [31:0] _RAND_126;
  reg [31:0] _RAND_127;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] states_0_state; // @[elements.scala 234:25]
  reg [1:0] states_1_state; // @[elements.scala 234:25]
  reg [1:0] states_2_state; // @[elements.scala 234:25]
  reg [1:0] states_3_state; // @[elements.scala 234:25]
  reg [1:0] states_4_state; // @[elements.scala 234:25]
  reg [1:0] states_5_state; // @[elements.scala 234:25]
  reg [1:0] states_6_state; // @[elements.scala 234:25]
  reg [1:0] states_7_state; // @[elements.scala 234:25]
  reg [1:0] states_8_state; // @[elements.scala 234:25]
  reg [1:0] states_9_state; // @[elements.scala 234:25]
  reg [1:0] states_10_state; // @[elements.scala 234:25]
  reg [1:0] states_11_state; // @[elements.scala 234:25]
  reg [1:0] states_12_state; // @[elements.scala 234:25]
  reg [1:0] states_13_state; // @[elements.scala 234:25]
  reg [1:0] states_14_state; // @[elements.scala 234:25]
  reg [1:0] states_15_state; // @[elements.scala 234:25]
  reg [1:0] states_16_state; // @[elements.scala 234:25]
  reg [1:0] states_17_state; // @[elements.scala 234:25]
  reg [1:0] states_18_state; // @[elements.scala 234:25]
  reg [1:0] states_19_state; // @[elements.scala 234:25]
  reg [1:0] states_20_state; // @[elements.scala 234:25]
  reg [1:0] states_21_state; // @[elements.scala 234:25]
  reg [1:0] states_22_state; // @[elements.scala 234:25]
  reg [1:0] states_23_state; // @[elements.scala 234:25]
  reg [1:0] states_24_state; // @[elements.scala 234:25]
  reg [1:0] states_25_state; // @[elements.scala 234:25]
  reg [1:0] states_26_state; // @[elements.scala 234:25]
  reg [1:0] states_27_state; // @[elements.scala 234:25]
  reg [1:0] states_28_state; // @[elements.scala 234:25]
  reg [1:0] states_29_state; // @[elements.scala 234:25]
  reg [1:0] states_30_state; // @[elements.scala 234:25]
  reg [1:0] states_31_state; // @[elements.scala 234:25]
  reg [1:0] states_32_state; // @[elements.scala 234:25]
  reg [1:0] states_33_state; // @[elements.scala 234:25]
  reg [1:0] states_34_state; // @[elements.scala 234:25]
  reg [1:0] states_35_state; // @[elements.scala 234:25]
  reg [1:0] states_36_state; // @[elements.scala 234:25]
  reg [1:0] states_37_state; // @[elements.scala 234:25]
  reg [1:0] states_38_state; // @[elements.scala 234:25]
  reg [1:0] states_39_state; // @[elements.scala 234:25]
  reg [1:0] states_40_state; // @[elements.scala 234:25]
  reg [1:0] states_41_state; // @[elements.scala 234:25]
  reg [1:0] states_42_state; // @[elements.scala 234:25]
  reg [1:0] states_43_state; // @[elements.scala 234:25]
  reg [1:0] states_44_state; // @[elements.scala 234:25]
  reg [1:0] states_45_state; // @[elements.scala 234:25]
  reg [1:0] states_46_state; // @[elements.scala 234:25]
  reg [1:0] states_47_state; // @[elements.scala 234:25]
  reg [1:0] states_48_state; // @[elements.scala 234:25]
  reg [1:0] states_49_state; // @[elements.scala 234:25]
  reg [1:0] states_50_state; // @[elements.scala 234:25]
  reg [1:0] states_51_state; // @[elements.scala 234:25]
  reg [1:0] states_52_state; // @[elements.scala 234:25]
  reg [1:0] states_53_state; // @[elements.scala 234:25]
  reg [1:0] states_54_state; // @[elements.scala 234:25]
  reg [1:0] states_55_state; // @[elements.scala 234:25]
  reg [1:0] states_56_state; // @[elements.scala 234:25]
  reg [1:0] states_57_state; // @[elements.scala 234:25]
  reg [1:0] states_58_state; // @[elements.scala 234:25]
  reg [1:0] states_59_state; // @[elements.scala 234:25]
  reg [1:0] states_60_state; // @[elements.scala 234:25]
  reg [1:0] states_61_state; // @[elements.scala 234:25]
  reg [1:0] states_62_state; // @[elements.scala 234:25]
  reg [1:0] states_63_state; // @[elements.scala 234:25]
  reg [1:0] states_64_state; // @[elements.scala 234:25]
  reg [1:0] states_65_state; // @[elements.scala 234:25]
  reg [1:0] states_66_state; // @[elements.scala 234:25]
  reg [1:0] states_67_state; // @[elements.scala 234:25]
  reg [1:0] states_68_state; // @[elements.scala 234:25]
  reg [1:0] states_69_state; // @[elements.scala 234:25]
  reg [1:0] states_70_state; // @[elements.scala 234:25]
  reg [1:0] states_71_state; // @[elements.scala 234:25]
  reg [1:0] states_72_state; // @[elements.scala 234:25]
  reg [1:0] states_73_state; // @[elements.scala 234:25]
  reg [1:0] states_74_state; // @[elements.scala 234:25]
  reg [1:0] states_75_state; // @[elements.scala 234:25]
  reg [1:0] states_76_state; // @[elements.scala 234:25]
  reg [1:0] states_77_state; // @[elements.scala 234:25]
  reg [1:0] states_78_state; // @[elements.scala 234:25]
  reg [1:0] states_79_state; // @[elements.scala 234:25]
  reg [1:0] states_80_state; // @[elements.scala 234:25]
  reg [1:0] states_81_state; // @[elements.scala 234:25]
  reg [1:0] states_82_state; // @[elements.scala 234:25]
  reg [1:0] states_83_state; // @[elements.scala 234:25]
  reg [1:0] states_84_state; // @[elements.scala 234:25]
  reg [1:0] states_85_state; // @[elements.scala 234:25]
  reg [1:0] states_86_state; // @[elements.scala 234:25]
  reg [1:0] states_87_state; // @[elements.scala 234:25]
  reg [1:0] states_88_state; // @[elements.scala 234:25]
  reg [1:0] states_89_state; // @[elements.scala 234:25]
  reg [1:0] states_90_state; // @[elements.scala 234:25]
  reg [1:0] states_91_state; // @[elements.scala 234:25]
  reg [1:0] states_92_state; // @[elements.scala 234:25]
  reg [1:0] states_93_state; // @[elements.scala 234:25]
  reg [1:0] states_94_state; // @[elements.scala 234:25]
  reg [1:0] states_95_state; // @[elements.scala 234:25]
  reg [1:0] states_96_state; // @[elements.scala 234:25]
  reg [1:0] states_97_state; // @[elements.scala 234:25]
  reg [1:0] states_98_state; // @[elements.scala 234:25]
  reg [1:0] states_99_state; // @[elements.scala 234:25]
  reg [1:0] states_100_state; // @[elements.scala 234:25]
  reg [1:0] states_101_state; // @[elements.scala 234:25]
  reg [1:0] states_102_state; // @[elements.scala 234:25]
  reg [1:0] states_103_state; // @[elements.scala 234:25]
  reg [1:0] states_104_state; // @[elements.scala 234:25]
  reg [1:0] states_105_state; // @[elements.scala 234:25]
  reg [1:0] states_106_state; // @[elements.scala 234:25]
  reg [1:0] states_107_state; // @[elements.scala 234:25]
  reg [1:0] states_108_state; // @[elements.scala 234:25]
  reg [1:0] states_109_state; // @[elements.scala 234:25]
  reg [1:0] states_110_state; // @[elements.scala 234:25]
  reg [1:0] states_111_state; // @[elements.scala 234:25]
  reg [1:0] states_112_state; // @[elements.scala 234:25]
  reg [1:0] states_113_state; // @[elements.scala 234:25]
  reg [1:0] states_114_state; // @[elements.scala 234:25]
  reg [1:0] states_115_state; // @[elements.scala 234:25]
  reg [1:0] states_116_state; // @[elements.scala 234:25]
  reg [1:0] states_117_state; // @[elements.scala 234:25]
  reg [1:0] states_118_state; // @[elements.scala 234:25]
  reg [1:0] states_119_state; // @[elements.scala 234:25]
  reg [1:0] states_120_state; // @[elements.scala 234:25]
  reg [1:0] states_121_state; // @[elements.scala 234:25]
  reg [1:0] states_122_state; // @[elements.scala 234:25]
  reg [1:0] states_123_state; // @[elements.scala 234:25]
  reg [1:0] states_124_state; // @[elements.scala 234:25]
  reg [1:0] states_125_state; // @[elements.scala 234:25]
  reg [1:0] states_126_state; // @[elements.scala 234:25]
  reg [1:0] states_127_state; // @[elements.scala 234:25]
  wire  _T_131 = io_in_1_bits_way != 2'h2; // @[elements.scala 237:91]
  wire  isGet = io_in_1_valid & _T_131; // @[elements.scala 237:66]
  wire  _T_133 = io_in_0_bits_way != 2'h2; // @[elements.scala 243:81]
  wire  isSet_0 = io_in_0_valid & _T_133; // @[elements.scala 243:61]
  wire [7:0] _T_137 = io_in_0_bits_addr[5:0] * 6'h2; // @[elements.scala 244:88]
  wire [7:0] _GEN_384 = {{6'd0}, io_in_0_bits_way}; // @[elements.scala 244:98]
  wire [7:0] _T_139 = _T_137 + _GEN_384; // @[elements.scala 244:98]
  wire [7:0] _T_140 = _T_133 ? _T_139 : 8'h0; // @[elements.scala 244:26]
  wire [6:0] idxSet_0 = _T_140[6:0]; // @[elements.scala 240:23 elements.scala 244:20]
  wire [7:0] _T_143 = io_in_1_bits_addr[5:0] * 6'h2; // @[elements.scala 253:91]
  wire [7:0] _GEN_385 = {{6'd0}, io_in_1_bits_way}; // @[elements.scala 253:101]
  wire [7:0] _T_145 = _T_143 + _GEN_385; // @[elements.scala 253:101]
  wire [7:0] _T_146 = _T_131 ? _T_145 : 8'h0; // @[elements.scala 253:19]
  wire [6:0] idxGet = _T_146[6:0]; // @[elements.scala 239:22 elements.scala 253:12]
  wire [1:0] _GEN_257 = 7'h1 == idxGet ? states_1_state : states_0_state; // @[elements.scala 254:17]
  wire [1:0] _GEN_258 = 7'h2 == idxGet ? states_2_state : _GEN_257; // @[elements.scala 254:17]
  wire [1:0] _GEN_259 = 7'h3 == idxGet ? states_3_state : _GEN_258; // @[elements.scala 254:17]
  wire [1:0] _GEN_260 = 7'h4 == idxGet ? states_4_state : _GEN_259; // @[elements.scala 254:17]
  wire [1:0] _GEN_261 = 7'h5 == idxGet ? states_5_state : _GEN_260; // @[elements.scala 254:17]
  wire [1:0] _GEN_262 = 7'h6 == idxGet ? states_6_state : _GEN_261; // @[elements.scala 254:17]
  wire [1:0] _GEN_263 = 7'h7 == idxGet ? states_7_state : _GEN_262; // @[elements.scala 254:17]
  wire [1:0] _GEN_264 = 7'h8 == idxGet ? states_8_state : _GEN_263; // @[elements.scala 254:17]
  wire [1:0] _GEN_265 = 7'h9 == idxGet ? states_9_state : _GEN_264; // @[elements.scala 254:17]
  wire [1:0] _GEN_266 = 7'ha == idxGet ? states_10_state : _GEN_265; // @[elements.scala 254:17]
  wire [1:0] _GEN_267 = 7'hb == idxGet ? states_11_state : _GEN_266; // @[elements.scala 254:17]
  wire [1:0] _GEN_268 = 7'hc == idxGet ? states_12_state : _GEN_267; // @[elements.scala 254:17]
  wire [1:0] _GEN_269 = 7'hd == idxGet ? states_13_state : _GEN_268; // @[elements.scala 254:17]
  wire [1:0] _GEN_270 = 7'he == idxGet ? states_14_state : _GEN_269; // @[elements.scala 254:17]
  wire [1:0] _GEN_271 = 7'hf == idxGet ? states_15_state : _GEN_270; // @[elements.scala 254:17]
  wire [1:0] _GEN_272 = 7'h10 == idxGet ? states_16_state : _GEN_271; // @[elements.scala 254:17]
  wire [1:0] _GEN_273 = 7'h11 == idxGet ? states_17_state : _GEN_272; // @[elements.scala 254:17]
  wire [1:0] _GEN_274 = 7'h12 == idxGet ? states_18_state : _GEN_273; // @[elements.scala 254:17]
  wire [1:0] _GEN_275 = 7'h13 == idxGet ? states_19_state : _GEN_274; // @[elements.scala 254:17]
  wire [1:0] _GEN_276 = 7'h14 == idxGet ? states_20_state : _GEN_275; // @[elements.scala 254:17]
  wire [1:0] _GEN_277 = 7'h15 == idxGet ? states_21_state : _GEN_276; // @[elements.scala 254:17]
  wire [1:0] _GEN_278 = 7'h16 == idxGet ? states_22_state : _GEN_277; // @[elements.scala 254:17]
  wire [1:0] _GEN_279 = 7'h17 == idxGet ? states_23_state : _GEN_278; // @[elements.scala 254:17]
  wire [1:0] _GEN_280 = 7'h18 == idxGet ? states_24_state : _GEN_279; // @[elements.scala 254:17]
  wire [1:0] _GEN_281 = 7'h19 == idxGet ? states_25_state : _GEN_280; // @[elements.scala 254:17]
  wire [1:0] _GEN_282 = 7'h1a == idxGet ? states_26_state : _GEN_281; // @[elements.scala 254:17]
  wire [1:0] _GEN_283 = 7'h1b == idxGet ? states_27_state : _GEN_282; // @[elements.scala 254:17]
  wire [1:0] _GEN_284 = 7'h1c == idxGet ? states_28_state : _GEN_283; // @[elements.scala 254:17]
  wire [1:0] _GEN_285 = 7'h1d == idxGet ? states_29_state : _GEN_284; // @[elements.scala 254:17]
  wire [1:0] _GEN_286 = 7'h1e == idxGet ? states_30_state : _GEN_285; // @[elements.scala 254:17]
  wire [1:0] _GEN_287 = 7'h1f == idxGet ? states_31_state : _GEN_286; // @[elements.scala 254:17]
  wire [1:0] _GEN_288 = 7'h20 == idxGet ? states_32_state : _GEN_287; // @[elements.scala 254:17]
  wire [1:0] _GEN_289 = 7'h21 == idxGet ? states_33_state : _GEN_288; // @[elements.scala 254:17]
  wire [1:0] _GEN_290 = 7'h22 == idxGet ? states_34_state : _GEN_289; // @[elements.scala 254:17]
  wire [1:0] _GEN_291 = 7'h23 == idxGet ? states_35_state : _GEN_290; // @[elements.scala 254:17]
  wire [1:0] _GEN_292 = 7'h24 == idxGet ? states_36_state : _GEN_291; // @[elements.scala 254:17]
  wire [1:0] _GEN_293 = 7'h25 == idxGet ? states_37_state : _GEN_292; // @[elements.scala 254:17]
  wire [1:0] _GEN_294 = 7'h26 == idxGet ? states_38_state : _GEN_293; // @[elements.scala 254:17]
  wire [1:0] _GEN_295 = 7'h27 == idxGet ? states_39_state : _GEN_294; // @[elements.scala 254:17]
  wire [1:0] _GEN_296 = 7'h28 == idxGet ? states_40_state : _GEN_295; // @[elements.scala 254:17]
  wire [1:0] _GEN_297 = 7'h29 == idxGet ? states_41_state : _GEN_296; // @[elements.scala 254:17]
  wire [1:0] _GEN_298 = 7'h2a == idxGet ? states_42_state : _GEN_297; // @[elements.scala 254:17]
  wire [1:0] _GEN_299 = 7'h2b == idxGet ? states_43_state : _GEN_298; // @[elements.scala 254:17]
  wire [1:0] _GEN_300 = 7'h2c == idxGet ? states_44_state : _GEN_299; // @[elements.scala 254:17]
  wire [1:0] _GEN_301 = 7'h2d == idxGet ? states_45_state : _GEN_300; // @[elements.scala 254:17]
  wire [1:0] _GEN_302 = 7'h2e == idxGet ? states_46_state : _GEN_301; // @[elements.scala 254:17]
  wire [1:0] _GEN_303 = 7'h2f == idxGet ? states_47_state : _GEN_302; // @[elements.scala 254:17]
  wire [1:0] _GEN_304 = 7'h30 == idxGet ? states_48_state : _GEN_303; // @[elements.scala 254:17]
  wire [1:0] _GEN_305 = 7'h31 == idxGet ? states_49_state : _GEN_304; // @[elements.scala 254:17]
  wire [1:0] _GEN_306 = 7'h32 == idxGet ? states_50_state : _GEN_305; // @[elements.scala 254:17]
  wire [1:0] _GEN_307 = 7'h33 == idxGet ? states_51_state : _GEN_306; // @[elements.scala 254:17]
  wire [1:0] _GEN_308 = 7'h34 == idxGet ? states_52_state : _GEN_307; // @[elements.scala 254:17]
  wire [1:0] _GEN_309 = 7'h35 == idxGet ? states_53_state : _GEN_308; // @[elements.scala 254:17]
  wire [1:0] _GEN_310 = 7'h36 == idxGet ? states_54_state : _GEN_309; // @[elements.scala 254:17]
  wire [1:0] _GEN_311 = 7'h37 == idxGet ? states_55_state : _GEN_310; // @[elements.scala 254:17]
  wire [1:0] _GEN_312 = 7'h38 == idxGet ? states_56_state : _GEN_311; // @[elements.scala 254:17]
  wire [1:0] _GEN_313 = 7'h39 == idxGet ? states_57_state : _GEN_312; // @[elements.scala 254:17]
  wire [1:0] _GEN_314 = 7'h3a == idxGet ? states_58_state : _GEN_313; // @[elements.scala 254:17]
  wire [1:0] _GEN_315 = 7'h3b == idxGet ? states_59_state : _GEN_314; // @[elements.scala 254:17]
  wire [1:0] _GEN_316 = 7'h3c == idxGet ? states_60_state : _GEN_315; // @[elements.scala 254:17]
  wire [1:0] _GEN_317 = 7'h3d == idxGet ? states_61_state : _GEN_316; // @[elements.scala 254:17]
  wire [1:0] _GEN_318 = 7'h3e == idxGet ? states_62_state : _GEN_317; // @[elements.scala 254:17]
  wire [1:0] _GEN_319 = 7'h3f == idxGet ? states_63_state : _GEN_318; // @[elements.scala 254:17]
  wire [1:0] _GEN_320 = 7'h40 == idxGet ? states_64_state : _GEN_319; // @[elements.scala 254:17]
  wire [1:0] _GEN_321 = 7'h41 == idxGet ? states_65_state : _GEN_320; // @[elements.scala 254:17]
  wire [1:0] _GEN_322 = 7'h42 == idxGet ? states_66_state : _GEN_321; // @[elements.scala 254:17]
  wire [1:0] _GEN_323 = 7'h43 == idxGet ? states_67_state : _GEN_322; // @[elements.scala 254:17]
  wire [1:0] _GEN_324 = 7'h44 == idxGet ? states_68_state : _GEN_323; // @[elements.scala 254:17]
  wire [1:0] _GEN_325 = 7'h45 == idxGet ? states_69_state : _GEN_324; // @[elements.scala 254:17]
  wire [1:0] _GEN_326 = 7'h46 == idxGet ? states_70_state : _GEN_325; // @[elements.scala 254:17]
  wire [1:0] _GEN_327 = 7'h47 == idxGet ? states_71_state : _GEN_326; // @[elements.scala 254:17]
  wire [1:0] _GEN_328 = 7'h48 == idxGet ? states_72_state : _GEN_327; // @[elements.scala 254:17]
  wire [1:0] _GEN_329 = 7'h49 == idxGet ? states_73_state : _GEN_328; // @[elements.scala 254:17]
  wire [1:0] _GEN_330 = 7'h4a == idxGet ? states_74_state : _GEN_329; // @[elements.scala 254:17]
  wire [1:0] _GEN_331 = 7'h4b == idxGet ? states_75_state : _GEN_330; // @[elements.scala 254:17]
  wire [1:0] _GEN_332 = 7'h4c == idxGet ? states_76_state : _GEN_331; // @[elements.scala 254:17]
  wire [1:0] _GEN_333 = 7'h4d == idxGet ? states_77_state : _GEN_332; // @[elements.scala 254:17]
  wire [1:0] _GEN_334 = 7'h4e == idxGet ? states_78_state : _GEN_333; // @[elements.scala 254:17]
  wire [1:0] _GEN_335 = 7'h4f == idxGet ? states_79_state : _GEN_334; // @[elements.scala 254:17]
  wire [1:0] _GEN_336 = 7'h50 == idxGet ? states_80_state : _GEN_335; // @[elements.scala 254:17]
  wire [1:0] _GEN_337 = 7'h51 == idxGet ? states_81_state : _GEN_336; // @[elements.scala 254:17]
  wire [1:0] _GEN_338 = 7'h52 == idxGet ? states_82_state : _GEN_337; // @[elements.scala 254:17]
  wire [1:0] _GEN_339 = 7'h53 == idxGet ? states_83_state : _GEN_338; // @[elements.scala 254:17]
  wire [1:0] _GEN_340 = 7'h54 == idxGet ? states_84_state : _GEN_339; // @[elements.scala 254:17]
  wire [1:0] _GEN_341 = 7'h55 == idxGet ? states_85_state : _GEN_340; // @[elements.scala 254:17]
  wire [1:0] _GEN_342 = 7'h56 == idxGet ? states_86_state : _GEN_341; // @[elements.scala 254:17]
  wire [1:0] _GEN_343 = 7'h57 == idxGet ? states_87_state : _GEN_342; // @[elements.scala 254:17]
  wire [1:0] _GEN_344 = 7'h58 == idxGet ? states_88_state : _GEN_343; // @[elements.scala 254:17]
  wire [1:0] _GEN_345 = 7'h59 == idxGet ? states_89_state : _GEN_344; // @[elements.scala 254:17]
  wire [1:0] _GEN_346 = 7'h5a == idxGet ? states_90_state : _GEN_345; // @[elements.scala 254:17]
  wire [1:0] _GEN_347 = 7'h5b == idxGet ? states_91_state : _GEN_346; // @[elements.scala 254:17]
  wire [1:0] _GEN_348 = 7'h5c == idxGet ? states_92_state : _GEN_347; // @[elements.scala 254:17]
  wire [1:0] _GEN_349 = 7'h5d == idxGet ? states_93_state : _GEN_348; // @[elements.scala 254:17]
  wire [1:0] _GEN_350 = 7'h5e == idxGet ? states_94_state : _GEN_349; // @[elements.scala 254:17]
  wire [1:0] _GEN_351 = 7'h5f == idxGet ? states_95_state : _GEN_350; // @[elements.scala 254:17]
  wire [1:0] _GEN_352 = 7'h60 == idxGet ? states_96_state : _GEN_351; // @[elements.scala 254:17]
  wire [1:0] _GEN_353 = 7'h61 == idxGet ? states_97_state : _GEN_352; // @[elements.scala 254:17]
  wire [1:0] _GEN_354 = 7'h62 == idxGet ? states_98_state : _GEN_353; // @[elements.scala 254:17]
  wire [1:0] _GEN_355 = 7'h63 == idxGet ? states_99_state : _GEN_354; // @[elements.scala 254:17]
  wire [1:0] _GEN_356 = 7'h64 == idxGet ? states_100_state : _GEN_355; // @[elements.scala 254:17]
  wire [1:0] _GEN_357 = 7'h65 == idxGet ? states_101_state : _GEN_356; // @[elements.scala 254:17]
  wire [1:0] _GEN_358 = 7'h66 == idxGet ? states_102_state : _GEN_357; // @[elements.scala 254:17]
  wire [1:0] _GEN_359 = 7'h67 == idxGet ? states_103_state : _GEN_358; // @[elements.scala 254:17]
  wire [1:0] _GEN_360 = 7'h68 == idxGet ? states_104_state : _GEN_359; // @[elements.scala 254:17]
  wire [1:0] _GEN_361 = 7'h69 == idxGet ? states_105_state : _GEN_360; // @[elements.scala 254:17]
  wire [1:0] _GEN_362 = 7'h6a == idxGet ? states_106_state : _GEN_361; // @[elements.scala 254:17]
  wire [1:0] _GEN_363 = 7'h6b == idxGet ? states_107_state : _GEN_362; // @[elements.scala 254:17]
  wire [1:0] _GEN_364 = 7'h6c == idxGet ? states_108_state : _GEN_363; // @[elements.scala 254:17]
  wire [1:0] _GEN_365 = 7'h6d == idxGet ? states_109_state : _GEN_364; // @[elements.scala 254:17]
  wire [1:0] _GEN_366 = 7'h6e == idxGet ? states_110_state : _GEN_365; // @[elements.scala 254:17]
  wire [1:0] _GEN_367 = 7'h6f == idxGet ? states_111_state : _GEN_366; // @[elements.scala 254:17]
  wire [1:0] _GEN_368 = 7'h70 == idxGet ? states_112_state : _GEN_367; // @[elements.scala 254:17]
  wire [1:0] _GEN_369 = 7'h71 == idxGet ? states_113_state : _GEN_368; // @[elements.scala 254:17]
  wire [1:0] _GEN_370 = 7'h72 == idxGet ? states_114_state : _GEN_369; // @[elements.scala 254:17]
  wire [1:0] _GEN_371 = 7'h73 == idxGet ? states_115_state : _GEN_370; // @[elements.scala 254:17]
  wire [1:0] _GEN_372 = 7'h74 == idxGet ? states_116_state : _GEN_371; // @[elements.scala 254:17]
  wire [1:0] _GEN_373 = 7'h75 == idxGet ? states_117_state : _GEN_372; // @[elements.scala 254:17]
  wire [1:0] _GEN_374 = 7'h76 == idxGet ? states_118_state : _GEN_373; // @[elements.scala 254:17]
  wire [1:0] _GEN_375 = 7'h77 == idxGet ? states_119_state : _GEN_374; // @[elements.scala 254:17]
  wire [1:0] _GEN_376 = 7'h78 == idxGet ? states_120_state : _GEN_375; // @[elements.scala 254:17]
  wire [1:0] _GEN_377 = 7'h79 == idxGet ? states_121_state : _GEN_376; // @[elements.scala 254:17]
  wire [1:0] _GEN_378 = 7'h7a == idxGet ? states_122_state : _GEN_377; // @[elements.scala 254:17]
  wire [1:0] _GEN_379 = 7'h7b == idxGet ? states_123_state : _GEN_378; // @[elements.scala 254:17]
  wire [1:0] _GEN_380 = 7'h7c == idxGet ? states_124_state : _GEN_379; // @[elements.scala 254:17]
  wire [1:0] _GEN_381 = 7'h7d == idxGet ? states_125_state : _GEN_380; // @[elements.scala 254:17]
  wire [1:0] _GEN_382 = 7'h7e == idxGet ? states_126_state : _GEN_381; // @[elements.scala 254:17]
  assign io_out_valid = _T_131 & isGet; // @[elements.scala 255:18]
  assign io_out_bits_state = 7'h7f == idxGet ? states_127_state : _GEN_382; // @[elements.scala 254:17]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  states_0_state = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  states_1_state = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  states_2_state = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  states_3_state = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  states_4_state = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  states_5_state = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  states_6_state = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  states_7_state = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  states_8_state = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  states_9_state = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  states_10_state = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  states_11_state = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  states_12_state = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  states_13_state = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  states_14_state = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  states_15_state = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  states_16_state = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  states_17_state = _RAND_17[1:0];
  _RAND_18 = {1{`RANDOM}};
  states_18_state = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  states_19_state = _RAND_19[1:0];
  _RAND_20 = {1{`RANDOM}};
  states_20_state = _RAND_20[1:0];
  _RAND_21 = {1{`RANDOM}};
  states_21_state = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  states_22_state = _RAND_22[1:0];
  _RAND_23 = {1{`RANDOM}};
  states_23_state = _RAND_23[1:0];
  _RAND_24 = {1{`RANDOM}};
  states_24_state = _RAND_24[1:0];
  _RAND_25 = {1{`RANDOM}};
  states_25_state = _RAND_25[1:0];
  _RAND_26 = {1{`RANDOM}};
  states_26_state = _RAND_26[1:0];
  _RAND_27 = {1{`RANDOM}};
  states_27_state = _RAND_27[1:0];
  _RAND_28 = {1{`RANDOM}};
  states_28_state = _RAND_28[1:0];
  _RAND_29 = {1{`RANDOM}};
  states_29_state = _RAND_29[1:0];
  _RAND_30 = {1{`RANDOM}};
  states_30_state = _RAND_30[1:0];
  _RAND_31 = {1{`RANDOM}};
  states_31_state = _RAND_31[1:0];
  _RAND_32 = {1{`RANDOM}};
  states_32_state = _RAND_32[1:0];
  _RAND_33 = {1{`RANDOM}};
  states_33_state = _RAND_33[1:0];
  _RAND_34 = {1{`RANDOM}};
  states_34_state = _RAND_34[1:0];
  _RAND_35 = {1{`RANDOM}};
  states_35_state = _RAND_35[1:0];
  _RAND_36 = {1{`RANDOM}};
  states_36_state = _RAND_36[1:0];
  _RAND_37 = {1{`RANDOM}};
  states_37_state = _RAND_37[1:0];
  _RAND_38 = {1{`RANDOM}};
  states_38_state = _RAND_38[1:0];
  _RAND_39 = {1{`RANDOM}};
  states_39_state = _RAND_39[1:0];
  _RAND_40 = {1{`RANDOM}};
  states_40_state = _RAND_40[1:0];
  _RAND_41 = {1{`RANDOM}};
  states_41_state = _RAND_41[1:0];
  _RAND_42 = {1{`RANDOM}};
  states_42_state = _RAND_42[1:0];
  _RAND_43 = {1{`RANDOM}};
  states_43_state = _RAND_43[1:0];
  _RAND_44 = {1{`RANDOM}};
  states_44_state = _RAND_44[1:0];
  _RAND_45 = {1{`RANDOM}};
  states_45_state = _RAND_45[1:0];
  _RAND_46 = {1{`RANDOM}};
  states_46_state = _RAND_46[1:0];
  _RAND_47 = {1{`RANDOM}};
  states_47_state = _RAND_47[1:0];
  _RAND_48 = {1{`RANDOM}};
  states_48_state = _RAND_48[1:0];
  _RAND_49 = {1{`RANDOM}};
  states_49_state = _RAND_49[1:0];
  _RAND_50 = {1{`RANDOM}};
  states_50_state = _RAND_50[1:0];
  _RAND_51 = {1{`RANDOM}};
  states_51_state = _RAND_51[1:0];
  _RAND_52 = {1{`RANDOM}};
  states_52_state = _RAND_52[1:0];
  _RAND_53 = {1{`RANDOM}};
  states_53_state = _RAND_53[1:0];
  _RAND_54 = {1{`RANDOM}};
  states_54_state = _RAND_54[1:0];
  _RAND_55 = {1{`RANDOM}};
  states_55_state = _RAND_55[1:0];
  _RAND_56 = {1{`RANDOM}};
  states_56_state = _RAND_56[1:0];
  _RAND_57 = {1{`RANDOM}};
  states_57_state = _RAND_57[1:0];
  _RAND_58 = {1{`RANDOM}};
  states_58_state = _RAND_58[1:0];
  _RAND_59 = {1{`RANDOM}};
  states_59_state = _RAND_59[1:0];
  _RAND_60 = {1{`RANDOM}};
  states_60_state = _RAND_60[1:0];
  _RAND_61 = {1{`RANDOM}};
  states_61_state = _RAND_61[1:0];
  _RAND_62 = {1{`RANDOM}};
  states_62_state = _RAND_62[1:0];
  _RAND_63 = {1{`RANDOM}};
  states_63_state = _RAND_63[1:0];
  _RAND_64 = {1{`RANDOM}};
  states_64_state = _RAND_64[1:0];
  _RAND_65 = {1{`RANDOM}};
  states_65_state = _RAND_65[1:0];
  _RAND_66 = {1{`RANDOM}};
  states_66_state = _RAND_66[1:0];
  _RAND_67 = {1{`RANDOM}};
  states_67_state = _RAND_67[1:0];
  _RAND_68 = {1{`RANDOM}};
  states_68_state = _RAND_68[1:0];
  _RAND_69 = {1{`RANDOM}};
  states_69_state = _RAND_69[1:0];
  _RAND_70 = {1{`RANDOM}};
  states_70_state = _RAND_70[1:0];
  _RAND_71 = {1{`RANDOM}};
  states_71_state = _RAND_71[1:0];
  _RAND_72 = {1{`RANDOM}};
  states_72_state = _RAND_72[1:0];
  _RAND_73 = {1{`RANDOM}};
  states_73_state = _RAND_73[1:0];
  _RAND_74 = {1{`RANDOM}};
  states_74_state = _RAND_74[1:0];
  _RAND_75 = {1{`RANDOM}};
  states_75_state = _RAND_75[1:0];
  _RAND_76 = {1{`RANDOM}};
  states_76_state = _RAND_76[1:0];
  _RAND_77 = {1{`RANDOM}};
  states_77_state = _RAND_77[1:0];
  _RAND_78 = {1{`RANDOM}};
  states_78_state = _RAND_78[1:0];
  _RAND_79 = {1{`RANDOM}};
  states_79_state = _RAND_79[1:0];
  _RAND_80 = {1{`RANDOM}};
  states_80_state = _RAND_80[1:0];
  _RAND_81 = {1{`RANDOM}};
  states_81_state = _RAND_81[1:0];
  _RAND_82 = {1{`RANDOM}};
  states_82_state = _RAND_82[1:0];
  _RAND_83 = {1{`RANDOM}};
  states_83_state = _RAND_83[1:0];
  _RAND_84 = {1{`RANDOM}};
  states_84_state = _RAND_84[1:0];
  _RAND_85 = {1{`RANDOM}};
  states_85_state = _RAND_85[1:0];
  _RAND_86 = {1{`RANDOM}};
  states_86_state = _RAND_86[1:0];
  _RAND_87 = {1{`RANDOM}};
  states_87_state = _RAND_87[1:0];
  _RAND_88 = {1{`RANDOM}};
  states_88_state = _RAND_88[1:0];
  _RAND_89 = {1{`RANDOM}};
  states_89_state = _RAND_89[1:0];
  _RAND_90 = {1{`RANDOM}};
  states_90_state = _RAND_90[1:0];
  _RAND_91 = {1{`RANDOM}};
  states_91_state = _RAND_91[1:0];
  _RAND_92 = {1{`RANDOM}};
  states_92_state = _RAND_92[1:0];
  _RAND_93 = {1{`RANDOM}};
  states_93_state = _RAND_93[1:0];
  _RAND_94 = {1{`RANDOM}};
  states_94_state = _RAND_94[1:0];
  _RAND_95 = {1{`RANDOM}};
  states_95_state = _RAND_95[1:0];
  _RAND_96 = {1{`RANDOM}};
  states_96_state = _RAND_96[1:0];
  _RAND_97 = {1{`RANDOM}};
  states_97_state = _RAND_97[1:0];
  _RAND_98 = {1{`RANDOM}};
  states_98_state = _RAND_98[1:0];
  _RAND_99 = {1{`RANDOM}};
  states_99_state = _RAND_99[1:0];
  _RAND_100 = {1{`RANDOM}};
  states_100_state = _RAND_100[1:0];
  _RAND_101 = {1{`RANDOM}};
  states_101_state = _RAND_101[1:0];
  _RAND_102 = {1{`RANDOM}};
  states_102_state = _RAND_102[1:0];
  _RAND_103 = {1{`RANDOM}};
  states_103_state = _RAND_103[1:0];
  _RAND_104 = {1{`RANDOM}};
  states_104_state = _RAND_104[1:0];
  _RAND_105 = {1{`RANDOM}};
  states_105_state = _RAND_105[1:0];
  _RAND_106 = {1{`RANDOM}};
  states_106_state = _RAND_106[1:0];
  _RAND_107 = {1{`RANDOM}};
  states_107_state = _RAND_107[1:0];
  _RAND_108 = {1{`RANDOM}};
  states_108_state = _RAND_108[1:0];
  _RAND_109 = {1{`RANDOM}};
  states_109_state = _RAND_109[1:0];
  _RAND_110 = {1{`RANDOM}};
  states_110_state = _RAND_110[1:0];
  _RAND_111 = {1{`RANDOM}};
  states_111_state = _RAND_111[1:0];
  _RAND_112 = {1{`RANDOM}};
  states_112_state = _RAND_112[1:0];
  _RAND_113 = {1{`RANDOM}};
  states_113_state = _RAND_113[1:0];
  _RAND_114 = {1{`RANDOM}};
  states_114_state = _RAND_114[1:0];
  _RAND_115 = {1{`RANDOM}};
  states_115_state = _RAND_115[1:0];
  _RAND_116 = {1{`RANDOM}};
  states_116_state = _RAND_116[1:0];
  _RAND_117 = {1{`RANDOM}};
  states_117_state = _RAND_117[1:0];
  _RAND_118 = {1{`RANDOM}};
  states_118_state = _RAND_118[1:0];
  _RAND_119 = {1{`RANDOM}};
  states_119_state = _RAND_119[1:0];
  _RAND_120 = {1{`RANDOM}};
  states_120_state = _RAND_120[1:0];
  _RAND_121 = {1{`RANDOM}};
  states_121_state = _RAND_121[1:0];
  _RAND_122 = {1{`RANDOM}};
  states_122_state = _RAND_122[1:0];
  _RAND_123 = {1{`RANDOM}};
  states_123_state = _RAND_123[1:0];
  _RAND_124 = {1{`RANDOM}};
  states_124_state = _RAND_124[1:0];
  _RAND_125 = {1{`RANDOM}};
  states_125_state = _RAND_125[1:0];
  _RAND_126 = {1{`RANDOM}};
  states_126_state = _RAND_126[1:0];
  _RAND_127 = {1{`RANDOM}};
  states_127_state = _RAND_127[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      states_0_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h0 == idxSet_0) begin
        states_0_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_1_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h1 == idxSet_0) begin
        states_1_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_2_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h2 == idxSet_0) begin
        states_2_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_3_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h3 == idxSet_0) begin
        states_3_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_4_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h4 == idxSet_0) begin
        states_4_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_5_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h5 == idxSet_0) begin
        states_5_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_6_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h6 == idxSet_0) begin
        states_6_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_7_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h7 == idxSet_0) begin
        states_7_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_8_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h8 == idxSet_0) begin
        states_8_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_9_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h9 == idxSet_0) begin
        states_9_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_10_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'ha == idxSet_0) begin
        states_10_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_11_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'hb == idxSet_0) begin
        states_11_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_12_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'hc == idxSet_0) begin
        states_12_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_13_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'hd == idxSet_0) begin
        states_13_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_14_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'he == idxSet_0) begin
        states_14_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_15_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'hf == idxSet_0) begin
        states_15_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_16_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h10 == idxSet_0) begin
        states_16_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_17_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h11 == idxSet_0) begin
        states_17_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_18_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h12 == idxSet_0) begin
        states_18_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_19_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h13 == idxSet_0) begin
        states_19_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_20_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h14 == idxSet_0) begin
        states_20_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_21_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h15 == idxSet_0) begin
        states_21_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_22_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h16 == idxSet_0) begin
        states_22_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_23_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h17 == idxSet_0) begin
        states_23_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_24_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h18 == idxSet_0) begin
        states_24_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_25_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h19 == idxSet_0) begin
        states_25_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_26_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h1a == idxSet_0) begin
        states_26_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_27_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h1b == idxSet_0) begin
        states_27_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_28_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h1c == idxSet_0) begin
        states_28_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_29_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h1d == idxSet_0) begin
        states_29_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_30_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h1e == idxSet_0) begin
        states_30_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_31_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h1f == idxSet_0) begin
        states_31_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_32_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h20 == idxSet_0) begin
        states_32_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_33_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h21 == idxSet_0) begin
        states_33_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_34_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h22 == idxSet_0) begin
        states_34_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_35_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h23 == idxSet_0) begin
        states_35_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_36_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h24 == idxSet_0) begin
        states_36_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_37_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h25 == idxSet_0) begin
        states_37_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_38_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h26 == idxSet_0) begin
        states_38_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_39_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h27 == idxSet_0) begin
        states_39_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_40_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h28 == idxSet_0) begin
        states_40_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_41_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h29 == idxSet_0) begin
        states_41_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_42_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h2a == idxSet_0) begin
        states_42_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_43_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h2b == idxSet_0) begin
        states_43_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_44_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h2c == idxSet_0) begin
        states_44_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_45_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h2d == idxSet_0) begin
        states_45_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_46_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h2e == idxSet_0) begin
        states_46_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_47_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h2f == idxSet_0) begin
        states_47_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_48_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h30 == idxSet_0) begin
        states_48_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_49_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h31 == idxSet_0) begin
        states_49_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_50_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h32 == idxSet_0) begin
        states_50_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_51_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h33 == idxSet_0) begin
        states_51_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_52_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h34 == idxSet_0) begin
        states_52_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_53_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h35 == idxSet_0) begin
        states_53_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_54_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h36 == idxSet_0) begin
        states_54_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_55_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h37 == idxSet_0) begin
        states_55_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_56_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h38 == idxSet_0) begin
        states_56_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_57_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h39 == idxSet_0) begin
        states_57_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_58_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h3a == idxSet_0) begin
        states_58_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_59_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h3b == idxSet_0) begin
        states_59_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_60_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h3c == idxSet_0) begin
        states_60_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_61_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h3d == idxSet_0) begin
        states_61_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_62_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h3e == idxSet_0) begin
        states_62_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_63_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h3f == idxSet_0) begin
        states_63_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_64_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h40 == idxSet_0) begin
        states_64_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_65_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h41 == idxSet_0) begin
        states_65_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_66_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h42 == idxSet_0) begin
        states_66_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_67_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h43 == idxSet_0) begin
        states_67_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_68_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h44 == idxSet_0) begin
        states_68_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_69_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h45 == idxSet_0) begin
        states_69_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_70_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h46 == idxSet_0) begin
        states_70_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_71_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h47 == idxSet_0) begin
        states_71_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_72_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h48 == idxSet_0) begin
        states_72_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_73_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h49 == idxSet_0) begin
        states_73_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_74_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h4a == idxSet_0) begin
        states_74_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_75_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h4b == idxSet_0) begin
        states_75_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_76_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h4c == idxSet_0) begin
        states_76_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_77_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h4d == idxSet_0) begin
        states_77_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_78_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h4e == idxSet_0) begin
        states_78_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_79_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h4f == idxSet_0) begin
        states_79_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_80_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h50 == idxSet_0) begin
        states_80_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_81_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h51 == idxSet_0) begin
        states_81_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_82_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h52 == idxSet_0) begin
        states_82_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_83_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h53 == idxSet_0) begin
        states_83_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_84_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h54 == idxSet_0) begin
        states_84_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_85_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h55 == idxSet_0) begin
        states_85_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_86_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h56 == idxSet_0) begin
        states_86_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_87_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h57 == idxSet_0) begin
        states_87_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_88_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h58 == idxSet_0) begin
        states_88_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_89_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h59 == idxSet_0) begin
        states_89_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_90_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h5a == idxSet_0) begin
        states_90_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_91_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h5b == idxSet_0) begin
        states_91_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_92_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h5c == idxSet_0) begin
        states_92_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_93_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h5d == idxSet_0) begin
        states_93_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_94_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h5e == idxSet_0) begin
        states_94_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_95_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h5f == idxSet_0) begin
        states_95_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_96_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h60 == idxSet_0) begin
        states_96_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_97_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h61 == idxSet_0) begin
        states_97_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_98_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h62 == idxSet_0) begin
        states_98_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_99_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h63 == idxSet_0) begin
        states_99_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_100_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h64 == idxSet_0) begin
        states_100_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_101_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h65 == idxSet_0) begin
        states_101_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_102_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h66 == idxSet_0) begin
        states_102_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_103_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h67 == idxSet_0) begin
        states_103_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_104_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h68 == idxSet_0) begin
        states_104_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_105_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h69 == idxSet_0) begin
        states_105_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_106_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h6a == idxSet_0) begin
        states_106_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_107_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h6b == idxSet_0) begin
        states_107_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_108_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h6c == idxSet_0) begin
        states_108_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_109_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h6d == idxSet_0) begin
        states_109_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_110_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h6e == idxSet_0) begin
        states_110_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_111_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h6f == idxSet_0) begin
        states_111_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_112_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h70 == idxSet_0) begin
        states_112_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_113_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h71 == idxSet_0) begin
        states_113_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_114_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h72 == idxSet_0) begin
        states_114_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_115_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h73 == idxSet_0) begin
        states_115_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_116_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h74 == idxSet_0) begin
        states_116_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_117_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h75 == idxSet_0) begin
        states_117_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_118_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h76 == idxSet_0) begin
        states_118_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_119_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h77 == idxSet_0) begin
        states_119_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_120_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h78 == idxSet_0) begin
        states_120_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_121_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h79 == idxSet_0) begin
        states_121_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_122_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h7a == idxSet_0) begin
        states_122_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_123_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h7b == idxSet_0) begin
        states_123_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_124_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h7c == idxSet_0) begin
        states_124_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_125_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h7d == idxSet_0) begin
        states_125_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_126_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h7e == idxSet_0) begin
        states_126_state <= io_in_0_bits_state_state;
      end
    end
    if (reset) begin
      states_127_state <= 2'h0;
    end else if (isSet_0) begin
      if (7'h7f == idxSet_0) begin
        states_127_state <= io_in_0_bits_state_state;
      end
    end
  end
endmodule
module FindEmptyLine_3(
  input   io_data_0,
  output  io_value_valid,
  output  io_value_bits
);
  wire  _T = ~io_data_0; // @[elements.scala 74:53]
  wire [1:0] idx = _T ? 2'h0 : 2'h1; // @[elements.scala 74:66]
  assign io_value_valid = ~io_data_0; // @[elements.scala 68:20 elements.scala 76:32]
  assign io_value_bits = idx[0]; // @[elements.scala 79:19]
endmodule
module PC(
  input         clock,
  input         reset,
  output        io_write_ready,
  input         io_write_valid,
  input  [31:0] io_write_bits_addr,
  input  [1:0]  io_write_bits_way,
  input  [63:0] io_write_bits_data,
  input  [1:0]  io_write_bits_replaceWay,
  input  [31:0] io_write_bits_tbeFields_0,
  input  [15:0] io_write_bits_pc,
  input  [1:0]  io_read_0_in_bits_data_way,
  input  [15:0] io_read_0_in_bits_data_pc,
  input         io_read_0_in_bits_data_valid,
  output [31:0] io_read_0_out_bits_addr,
  output [1:0]  io_read_0_out_bits_way,
  output [63:0] io_read_0_out_bits_data,
  output [1:0]  io_read_0_out_bits_replaceWay,
  output [31:0] io_read_0_out_bits_tbeFields_0,
  output [15:0] io_read_0_out_bits_pc,
  output        io_read_0_out_bits_valid,
  output        io_isFull
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  wire  findNewLine_io_data_0; // @[elements.scala 278:29]
  wire  findNewLine_io_value_valid; // @[elements.scala 278:29]
  wire  findNewLine_io_value_bits; // @[elements.scala 278:29]
  reg [31:0] pcContent_0_addr; // @[elements.scala 274:29]
  reg [1:0] pcContent_0_way; // @[elements.scala 274:29]
  reg [63:0] pcContent_0_data; // @[elements.scala 274:29]
  reg [1:0] pcContent_0_replaceWay; // @[elements.scala 274:29]
  reg [31:0] pcContent_0_tbeFields_0; // @[elements.scala 274:29]
  reg [15:0] pcContent_0_pc; // @[elements.scala 274:29]
  reg  pcContent_0_valid; // @[elements.scala 274:29]
  wire  write = io_write_ready & io_write_valid; // @[Decoupled.scala 40:37]
  wire  _T_113 = ~write; // @[elements.scala 288:14]
  wire  writeIdx = findNewLine_io_value_bits;
  wire  _T_115 = write & writeIdx; // @[elements.scala 288:30]
  wire  _T_116 = _T_113 | _T_115; // @[elements.scala 288:21]
  wire  _GEN_1 = _T_116 ? io_read_0_in_bits_data_valid : pcContent_0_valid; // @[elements.scala 288:50]
  wire  _GEN_10 = write | _GEN_1; // @[elements.scala 295:17]
  FindEmptyLine_3 findNewLine ( // @[elements.scala 278:29]
    .io_data_0(findNewLine_io_data_0),
    .io_value_valid(findNewLine_io_value_valid),
    .io_value_bits(findNewLine_io_value_bits)
  );
  assign io_write_ready = findNewLine_io_value_valid; // @[elements.scala 299:20]
  assign io_read_0_out_bits_addr = pcContent_0_addr; // @[elements.scala 283:30]
  assign io_read_0_out_bits_way = pcContent_0_way; // @[elements.scala 283:30]
  assign io_read_0_out_bits_data = pcContent_0_data; // @[elements.scala 283:30]
  assign io_read_0_out_bits_replaceWay = pcContent_0_replaceWay; // @[elements.scala 283:30]
  assign io_read_0_out_bits_tbeFields_0 = pcContent_0_tbeFields_0; // @[elements.scala 283:30]
  assign io_read_0_out_bits_pc = pcContent_0_pc; // @[elements.scala 283:30]
  assign io_read_0_out_bits_valid = pcContent_0_valid; // @[elements.scala 283:30]
  assign io_isFull = ~io_write_ready; // @[elements.scala 300:15]
  assign findNewLine_io_data_0 = pcContent_0_valid; // @[elements.scala 279:25]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pcContent_0_addr = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  pcContent_0_way = _RAND_1[1:0];
  _RAND_2 = {2{`RANDOM}};
  pcContent_0_data = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  pcContent_0_replaceWay = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  pcContent_0_tbeFields_0 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  pcContent_0_pc = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  pcContent_0_valid = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      pcContent_0_addr <= 32'h0;
    end else if (write) begin
      pcContent_0_addr <= io_write_bits_addr;
    end
    if (reset) begin
      pcContent_0_way <= 2'h2;
    end else if (write) begin
      pcContent_0_way <= io_write_bits_way;
    end else if (_T_116) begin
      pcContent_0_way <= io_read_0_in_bits_data_way;
    end
    if (reset) begin
      pcContent_0_data <= 64'h0;
    end else if (write) begin
      pcContent_0_data <= io_write_bits_data;
    end
    if (reset) begin
      pcContent_0_replaceWay <= 2'h0;
    end else if (write) begin
      pcContent_0_replaceWay <= io_write_bits_replaceWay;
    end
    if (reset) begin
      pcContent_0_tbeFields_0 <= 32'h0;
    end else if (write) begin
      pcContent_0_tbeFields_0 <= io_write_bits_tbeFields_0;
    end
    if (reset) begin
      pcContent_0_pc <= 16'h0;
    end else if (write) begin
      pcContent_0_pc <= io_write_bits_pc;
    end else if (_T_116) begin
      pcContent_0_pc <= io_read_0_in_bits_data_pc;
    end
    if (reset) begin
      pcContent_0_valid <= 1'h0;
    end else begin
      pcContent_0_valid <= _GEN_10;
    end
  end
endmodule
module RRArbiter_2(
  input         clock,
  input         io_in_0_valid,
  input  [1:0]  io_in_0_bits_event,
  input  [31:0] io_in_0_bits_addr,
  input  [63:0] io_in_0_bits_data,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [1:0]  io_in_1_bits_event,
  input  [31:0] io_in_1_bits_addr,
  input  [63:0] io_in_1_bits_data,
  input         io_in_2_valid,
  input  [1:0]  io_in_2_bits_event,
  input  [31:0] io_in_2_bits_addr,
  input  [63:0] io_in_2_bits_data,
  input         io_in_3_valid,
  input  [1:0]  io_in_3_bits_event,
  input  [31:0] io_in_3_bits_addr,
  input  [63:0] io_in_3_bits_data,
  input         io_out_ready,
  output        io_out_valid,
  output [1:0]  io_out_bits_event,
  output [31:0] io_out_bits_addr,
  output [63:0] io_out_bits_data,
  output [1:0]  io_chosen
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  _GEN_6 = 2'h1 == io_chosen ? io_in_1_valid : io_in_0_valid; // @[Arbiter.scala 41:16]
  wire [1:0] _GEN_7 = 2'h1 == io_chosen ? io_in_1_bits_event : io_in_0_bits_event; // @[Arbiter.scala 41:16]
  wire [31:0] _GEN_8 = 2'h1 == io_chosen ? io_in_1_bits_addr : io_in_0_bits_addr; // @[Arbiter.scala 41:16]
  wire [63:0] _GEN_9 = 2'h1 == io_chosen ? io_in_1_bits_data : io_in_0_bits_data; // @[Arbiter.scala 41:16]
  wire  _GEN_11 = 2'h2 == io_chosen ? io_in_2_valid : _GEN_6; // @[Arbiter.scala 41:16]
  wire [1:0] _GEN_12 = 2'h2 == io_chosen ? io_in_2_bits_event : _GEN_7; // @[Arbiter.scala 41:16]
  wire [31:0] _GEN_13 = 2'h2 == io_chosen ? io_in_2_bits_addr : _GEN_8; // @[Arbiter.scala 41:16]
  wire [63:0] _GEN_14 = 2'h2 == io_chosen ? io_in_2_bits_data : _GEN_9; // @[Arbiter.scala 41:16]
  wire  _T = io_out_ready & io_out_valid; // @[Decoupled.scala 40:37]
  reg [1:0] lastGrant; // @[Reg.scala 15:16]
  wire  grantMask_1 = 2'h1 > lastGrant; // @[Arbiter.scala 67:49]
  wire  grantMask_2 = 2'h2 > lastGrant; // @[Arbiter.scala 67:49]
  wire  grantMask_3 = 2'h3 > lastGrant; // @[Arbiter.scala 67:49]
  wire  validMask_1 = io_in_1_valid & grantMask_1; // @[Arbiter.scala 68:75]
  wire  validMask_2 = io_in_2_valid & grantMask_2; // @[Arbiter.scala 68:75]
  wire  validMask_3 = io_in_3_valid & grantMask_3; // @[Arbiter.scala 68:75]
  wire  _T_2 = validMask_1 | validMask_2; // @[Arbiter.scala 31:68]
  wire  _T_3 = _T_2 | validMask_3; // @[Arbiter.scala 31:68]
  wire  _T_4 = _T_3 | io_in_0_valid; // @[Arbiter.scala 31:68]
  wire  _T_11 = ~_T_4; // @[Arbiter.scala 31:78]
  wire  _T_17 = grantMask_1 | _T_11; // @[Arbiter.scala 72:50]
  wire [1:0] _GEN_21 = io_in_2_valid ? 2'h2 : 2'h3; // @[Arbiter.scala 77:27]
  wire [1:0] _GEN_22 = io_in_1_valid ? 2'h1 : _GEN_21; // @[Arbiter.scala 77:27]
  wire [1:0] _GEN_23 = io_in_0_valid ? 2'h0 : _GEN_22; // @[Arbiter.scala 77:27]
  wire [1:0] _GEN_24 = validMask_3 ? 2'h3 : _GEN_23; // @[Arbiter.scala 79:25]
  wire [1:0] _GEN_25 = validMask_2 ? 2'h2 : _GEN_24; // @[Arbiter.scala 79:25]
  assign io_in_1_ready = _T_17 & io_out_ready; // @[Arbiter.scala 60:16]
  assign io_out_valid = 2'h3 == io_chosen ? io_in_3_valid : _GEN_11; // @[Arbiter.scala 41:16]
  assign io_out_bits_event = 2'h3 == io_chosen ? io_in_3_bits_event : _GEN_12; // @[Arbiter.scala 42:15]
  assign io_out_bits_addr = 2'h3 == io_chosen ? io_in_3_bits_addr : _GEN_13; // @[Arbiter.scala 42:15]
  assign io_out_bits_data = 2'h3 == io_chosen ? io_in_3_bits_data : _GEN_14; // @[Arbiter.scala 42:15]
  assign io_chosen = validMask_1 ? 2'h1 : _GEN_25; // @[Arbiter.scala 40:13]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  lastGrant = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (_T) begin
      lastGrant <= io_chosen;
    end
  end
endmodule
module Arbiter_3(
  input         io_in_0_valid,
  input  [31:0] io_in_0_bits_req_addr,
  input  [63:0] io_in_0_bits_req_data,
  output        io_out_valid,
  output [31:0] io_out_bits_req_addr,
  output [63:0] io_out_bits_req_data
);
  assign io_out_valid = io_in_0_valid; // @[Arbiter.scala 135:16]
  assign io_out_bits_req_addr = io_in_0_bits_req_addr; // @[Arbiter.scala 124:15]
  assign io_out_bits_req_data = io_in_0_bits_req_data; // @[Arbiter.scala 124:15]
endmodule
module Arbiter_4(
  input         io_in_0_valid,
  input  [31:0] io_in_0_bits_addr,
  input         io_in_1_valid,
  input  [31:0] io_in_1_bits_addr,
  output        io_out_valid,
  output [31:0] io_out_bits_addr
);
  wire  grant_1 = ~io_in_0_valid; // @[Arbiter.scala 31:78]
  wire  _T_2 = ~grant_1; // @[Arbiter.scala 135:19]
  assign io_out_valid = _T_2 | io_in_1_valid; // @[Arbiter.scala 135:16]
  assign io_out_bits_addr = io_in_0_valid ? io_in_0_bits_addr : io_in_1_bits_addr; // @[Arbiter.scala 124:15 Arbiter.scala 128:19]
endmodule
module Arbiter_5(
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [1:0]  io_in_0_bits_event,
  input  [31:0] io_in_0_bits_addr,
  input  [63:0] io_in_0_bits_data,
  input         io_out_ready,
  output        io_out_valid,
  output [1:0]  io_out_bits_event,
  output [31:0] io_out_bits_addr,
  output [63:0] io_out_bits_data
);
  assign io_in_0_ready = io_out_ready; // @[Arbiter.scala 134:14]
  assign io_out_valid = io_in_0_valid; // @[Arbiter.scala 135:16]
  assign io_out_bits_event = io_in_0_bits_event; // @[Arbiter.scala 124:15]
  assign io_out_bits_addr = io_in_0_bits_addr; // @[Arbiter.scala 124:15]
  assign io_out_bits_data = io_in_0_bits_data; // @[Arbiter.scala 124:15]
endmodule
module Queue_7(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [1:0]  io_enq_bits_inst_event,
  input  [31:0] io_enq_bits_inst_addr,
  input  [63:0] io_enq_bits_inst_data,
  input  [1:0]  io_enq_bits_tbeOut_state_state,
  input  [2:0]  io_enq_bits_tbeOut_way,
  input  [31:0] io_enq_bits_tbeOut_fields_0,
  input         io_deq_ready,
  output        io_deq_valid,
  output [1:0]  io_deq_bits_inst_event,
  output [31:0] io_deq_bits_inst_addr,
  output [63:0] io_deq_bits_inst_data,
  output [1:0]  io_deq_bits_tbeOut_state_state,
  output [2:0]  io_deq_bits_tbeOut_way,
  output [31:0] io_deq_bits_tbeOut_fields_0
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] ram_inst_event [0:0]; // @[Decoupled.scala 209:16]
  wire [1:0] ram_inst_event__T_7_data; // @[Decoupled.scala 209:16]
  wire  ram_inst_event__T_7_addr; // @[Decoupled.scala 209:16]
  wire [1:0] ram_inst_event__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_inst_event__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_inst_event__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_inst_event__T_3_en; // @[Decoupled.scala 209:16]
  reg [31:0] ram_inst_addr [0:0]; // @[Decoupled.scala 209:16]
  wire [31:0] ram_inst_addr__T_7_data; // @[Decoupled.scala 209:16]
  wire  ram_inst_addr__T_7_addr; // @[Decoupled.scala 209:16]
  wire [31:0] ram_inst_addr__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_inst_addr__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_inst_addr__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_inst_addr__T_3_en; // @[Decoupled.scala 209:16]
  reg [63:0] ram_inst_data [0:0]; // @[Decoupled.scala 209:16]
  wire [63:0] ram_inst_data__T_7_data; // @[Decoupled.scala 209:16]
  wire  ram_inst_data__T_7_addr; // @[Decoupled.scala 209:16]
  wire [63:0] ram_inst_data__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_inst_data__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_inst_data__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_inst_data__T_3_en; // @[Decoupled.scala 209:16]
  reg [1:0] ram_tbeOut_state_state [0:0]; // @[Decoupled.scala 209:16]
  wire [1:0] ram_tbeOut_state_state__T_7_data; // @[Decoupled.scala 209:16]
  wire  ram_tbeOut_state_state__T_7_addr; // @[Decoupled.scala 209:16]
  wire [1:0] ram_tbeOut_state_state__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_tbeOut_state_state__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_tbeOut_state_state__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_tbeOut_state_state__T_3_en; // @[Decoupled.scala 209:16]
  reg [2:0] ram_tbeOut_way [0:0]; // @[Decoupled.scala 209:16]
  wire [2:0] ram_tbeOut_way__T_7_data; // @[Decoupled.scala 209:16]
  wire  ram_tbeOut_way__T_7_addr; // @[Decoupled.scala 209:16]
  wire [2:0] ram_tbeOut_way__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_tbeOut_way__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_tbeOut_way__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_tbeOut_way__T_3_en; // @[Decoupled.scala 209:16]
  reg [31:0] ram_tbeOut_fields_0 [0:0]; // @[Decoupled.scala 209:16]
  wire [31:0] ram_tbeOut_fields_0__T_7_data; // @[Decoupled.scala 209:16]
  wire  ram_tbeOut_fields_0__T_7_addr; // @[Decoupled.scala 209:16]
  wire [31:0] ram_tbeOut_fields_0__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_tbeOut_fields_0__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_tbeOut_fields_0__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_tbeOut_fields_0__T_3_en; // @[Decoupled.scala 209:16]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  empty = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire  _T_4 = do_enq != do_deq; // @[Decoupled.scala 227:16]
  assign ram_inst_event__T_7_addr = 1'h0;
  assign ram_inst_event__T_7_data = ram_inst_event[ram_inst_event__T_7_addr]; // @[Decoupled.scala 209:16]
  assign ram_inst_event__T_3_data = io_enq_bits_inst_event;
  assign ram_inst_event__T_3_addr = 1'h0;
  assign ram_inst_event__T_3_mask = 1'h1;
  assign ram_inst_event__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_inst_addr__T_7_addr = 1'h0;
  assign ram_inst_addr__T_7_data = ram_inst_addr[ram_inst_addr__T_7_addr]; // @[Decoupled.scala 209:16]
  assign ram_inst_addr__T_3_data = io_enq_bits_inst_addr;
  assign ram_inst_addr__T_3_addr = 1'h0;
  assign ram_inst_addr__T_3_mask = 1'h1;
  assign ram_inst_addr__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_inst_data__T_7_addr = 1'h0;
  assign ram_inst_data__T_7_data = ram_inst_data[ram_inst_data__T_7_addr]; // @[Decoupled.scala 209:16]
  assign ram_inst_data__T_3_data = io_enq_bits_inst_data;
  assign ram_inst_data__T_3_addr = 1'h0;
  assign ram_inst_data__T_3_mask = 1'h1;
  assign ram_inst_data__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_tbeOut_state_state__T_7_addr = 1'h0;
  assign ram_tbeOut_state_state__T_7_data = ram_tbeOut_state_state[ram_tbeOut_state_state__T_7_addr]; // @[Decoupled.scala 209:16]
  assign ram_tbeOut_state_state__T_3_data = io_enq_bits_tbeOut_state_state;
  assign ram_tbeOut_state_state__T_3_addr = 1'h0;
  assign ram_tbeOut_state_state__T_3_mask = 1'h1;
  assign ram_tbeOut_state_state__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_tbeOut_way__T_7_addr = 1'h0;
  assign ram_tbeOut_way__T_7_data = ram_tbeOut_way[ram_tbeOut_way__T_7_addr]; // @[Decoupled.scala 209:16]
  assign ram_tbeOut_way__T_3_data = io_enq_bits_tbeOut_way;
  assign ram_tbeOut_way__T_3_addr = 1'h0;
  assign ram_tbeOut_way__T_3_mask = 1'h1;
  assign ram_tbeOut_way__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_tbeOut_fields_0__T_7_addr = 1'h0;
  assign ram_tbeOut_fields_0__T_7_data = ram_tbeOut_fields_0[ram_tbeOut_fields_0__T_7_addr]; // @[Decoupled.scala 209:16]
  assign ram_tbeOut_fields_0__T_3_data = io_enq_bits_tbeOut_fields_0;
  assign ram_tbeOut_fields_0__T_3_addr = 1'h0;
  assign ram_tbeOut_fields_0__T_3_mask = 1'h1;
  assign ram_tbeOut_fields_0__T_3_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = io_deq_ready | empty; // @[Decoupled.scala 232:16 Decoupled.scala 245:40]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 231:16]
  assign io_deq_bits_inst_event = ram_inst_event__T_7_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_inst_addr = ram_inst_addr__T_7_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_inst_data = ram_inst_data__T_7_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_tbeOut_state_state = ram_tbeOut_state_state__T_7_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_tbeOut_way = ram_tbeOut_way__T_7_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_tbeOut_fields_0 = ram_tbeOut_fields_0__T_7_data; // @[Decoupled.scala 233:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_inst_event[initvar] = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_inst_addr[initvar] = _RAND_1[31:0];
  _RAND_2 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_inst_data[initvar] = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_tbeOut_state_state[initvar] = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_tbeOut_way[initvar] = _RAND_4[2:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_tbeOut_fields_0[initvar] = _RAND_5[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  maybe_full = _RAND_6[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram_inst_event__T_3_en & ram_inst_event__T_3_mask) begin
      ram_inst_event[ram_inst_event__T_3_addr] <= ram_inst_event__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_inst_addr__T_3_en & ram_inst_addr__T_3_mask) begin
      ram_inst_addr[ram_inst_addr__T_3_addr] <= ram_inst_addr__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_inst_data__T_3_en & ram_inst_data__T_3_mask) begin
      ram_inst_data[ram_inst_data__T_3_addr] <= ram_inst_data__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_tbeOut_state_state__T_3_en & ram_tbeOut_state_state__T_3_mask) begin
      ram_tbeOut_state_state[ram_tbeOut_state_state__T_3_addr] <= ram_tbeOut_state_state__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_tbeOut_way__T_3_en & ram_tbeOut_way__T_3_mask) begin
      ram_tbeOut_way[ram_tbeOut_way__T_3_addr] <= ram_tbeOut_way__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_tbeOut_fields_0__T_3_en & ram_tbeOut_fields_0__T_3_mask) begin
      ram_tbeOut_fields_0[ram_tbeOut_fields_0__T_3_addr] <= ram_tbeOut_fields_0__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_4) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module Queue_8(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [1:0]  io_enq_bits_event,
  input  [31:0] io_enq_bits_addr,
  input  [63:0] io_enq_bits_data,
  input         io_deq_ready,
  output        io_deq_valid,
  output [1:0]  io_deq_bits_event,
  output [31:0] io_deq_bits_addr,
  output [63:0] io_deq_bits_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] ram_event [0:15]; // @[Decoupled.scala 209:16]
  wire [1:0] ram_event__T_11_data; // @[Decoupled.scala 209:16]
  wire [3:0] ram_event__T_11_addr; // @[Decoupled.scala 209:16]
  wire [1:0] ram_event__T_3_data; // @[Decoupled.scala 209:16]
  wire [3:0] ram_event__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_event__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_event__T_3_en; // @[Decoupled.scala 209:16]
  reg [31:0] ram_addr [0:15]; // @[Decoupled.scala 209:16]
  wire [31:0] ram_addr__T_11_data; // @[Decoupled.scala 209:16]
  wire [3:0] ram_addr__T_11_addr; // @[Decoupled.scala 209:16]
  wire [31:0] ram_addr__T_3_data; // @[Decoupled.scala 209:16]
  wire [3:0] ram_addr__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_en; // @[Decoupled.scala 209:16]
  reg [63:0] ram_data [0:15]; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_11_data; // @[Decoupled.scala 209:16]
  wire [3:0] ram_data__T_11_addr; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_3_data; // @[Decoupled.scala 209:16]
  wire [3:0] ram_data__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_en; // @[Decoupled.scala 209:16]
  reg [3:0] enq_ptr_value; // @[Counter.scala 29:33]
  reg [3:0] deq_ptr_value; // @[Counter.scala 29:33]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 214:33]
  wire  _T = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  empty = ptr_match & _T; // @[Decoupled.scala 215:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 216:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire [3:0] _T_5 = enq_ptr_value + 4'h1; // @[Counter.scala 39:22]
  wire [3:0] _T_7 = deq_ptr_value + 4'h1; // @[Counter.scala 39:22]
  wire  _T_8 = do_enq != do_deq; // @[Decoupled.scala 227:16]
  wire  _T_10 = ~full; // @[Decoupled.scala 232:19]
  assign ram_event__T_11_addr = deq_ptr_value;
  assign ram_event__T_11_data = ram_event[ram_event__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_event__T_3_data = io_enq_bits_event;
  assign ram_event__T_3_addr = enq_ptr_value;
  assign ram_event__T_3_mask = 1'h1;
  assign ram_event__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_addr__T_11_addr = deq_ptr_value;
  assign ram_addr__T_11_data = ram_addr[ram_addr__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_addr__T_3_data = io_enq_bits_addr;
  assign ram_addr__T_3_addr = enq_ptr_value;
  assign ram_addr__T_3_mask = 1'h1;
  assign ram_addr__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_data__T_11_addr = deq_ptr_value;
  assign ram_data__T_11_data = ram_data[ram_data__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram_data__T_3_data = io_enq_bits_data;
  assign ram_data__T_3_addr = enq_ptr_value;
  assign ram_data__T_3_mask = 1'h1;
  assign ram_data__T_3_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = io_deq_ready | _T_10; // @[Decoupled.scala 232:16 Decoupled.scala 245:40]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 231:16]
  assign io_deq_bits_event = ram_event__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_addr = ram_addr__T_11_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_data = ram_data__T_11_data; // @[Decoupled.scala 233:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram_event[initvar] = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram_addr[initvar] = _RAND_1[31:0];
  _RAND_2 = {2{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram_data[initvar] = _RAND_2[63:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  enq_ptr_value = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  deq_ptr_value = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  maybe_full = _RAND_5[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram_event__T_3_en & ram_event__T_3_mask) begin
      ram_event[ram_event__T_3_addr] <= ram_event__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_addr__T_3_en & ram_addr__T_3_mask) begin
      ram_addr[ram_addr__T_3_addr] <= ram_addr__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_data__T_3_en & ram_data__T_3_mask) begin
      ram_data[ram_data__T_3_addr] <= ram_data__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      enq_ptr_value <= 4'h0;
    end else if (do_enq) begin
      enq_ptr_value <= _T_5;
    end
    if (reset) begin
      deq_ptr_value <= 4'h0;
    end else if (do_deq) begin
      deq_ptr_value <= _T_7;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_8) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module Queue_11(
  input        clock,
  input        reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [1:0] io_enq_bits,
  input        io_deq_ready,
  output       io_deq_valid,
  output [1:0] io_deq_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] ram [0:15]; // @[Decoupled.scala 209:16]
  wire [1:0] ram__T_11_data; // @[Decoupled.scala 209:16]
  wire [3:0] ram__T_11_addr; // @[Decoupled.scala 209:16]
  wire [1:0] ram__T_3_data; // @[Decoupled.scala 209:16]
  wire [3:0] ram__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram__T_3_en; // @[Decoupled.scala 209:16]
  reg [3:0] enq_ptr_value; // @[Counter.scala 29:33]
  reg [3:0] deq_ptr_value; // @[Counter.scala 29:33]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 214:33]
  wire  _T = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  empty = ptr_match & _T; // @[Decoupled.scala 215:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 216:24]
  wire  _T_1 = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  _T_2 = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire [3:0] _T_5 = enq_ptr_value + 4'h1; // @[Counter.scala 39:22]
  wire  _GEN_9 = io_deq_ready ? 1'h0 : _T_1; // @[Decoupled.scala 240:27]
  wire  do_enq = empty ? _GEN_9 : _T_1; // @[Decoupled.scala 237:18]
  wire [3:0] _T_7 = deq_ptr_value + 4'h1; // @[Counter.scala 39:22]
  wire  do_deq = empty ? 1'h0 : _T_2; // @[Decoupled.scala 237:18]
  wire  _T_8 = do_enq != do_deq; // @[Decoupled.scala 227:16]
  wire  _T_9 = ~empty; // @[Decoupled.scala 231:19]
  wire  _T_10 = ~full; // @[Decoupled.scala 232:19]
  assign ram__T_11_addr = deq_ptr_value;
  assign ram__T_11_data = ram[ram__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram__T_3_data = io_enq_bits;
  assign ram__T_3_addr = enq_ptr_value;
  assign ram__T_3_mask = 1'h1;
  assign ram__T_3_en = empty ? _GEN_9 : _T_1;
  assign io_enq_ready = io_deq_ready | _T_10; // @[Decoupled.scala 232:16 Decoupled.scala 245:40]
  assign io_deq_valid = io_enq_valid | _T_9; // @[Decoupled.scala 231:16 Decoupled.scala 236:40]
  assign io_deq_bits = empty ? io_enq_bits : ram__T_11_data; // @[Decoupled.scala 233:15 Decoupled.scala 238:19]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram[initvar] = _RAND_0[1:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram__T_3_en & ram__T_3_mask) begin
      ram[ram__T_3_addr] <= ram__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      enq_ptr_value <= 4'h0;
    end else if (do_enq) begin
      enq_ptr_value <= _T_5;
    end
    if (reset) begin
      deq_ptr_value <= 4'h0;
    end else if (do_deq) begin
      deq_ptr_value <= _T_7;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_8) begin
      if (empty) begin
        if (io_deq_ready) begin
          maybe_full <= 1'h0;
        end else begin
          maybe_full <= _T_1;
        end
      end else begin
        maybe_full <= _T_1;
      end
    end
  end
endmodule
module Queue_13(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [15:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [15:0] io_deq_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [15:0] ram [0:0]; // @[Decoupled.scala 209:16]
  wire [15:0] ram__T_7_data; // @[Decoupled.scala 209:16]
  wire  ram__T_7_addr; // @[Decoupled.scala 209:16]
  wire [15:0] ram__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram__T_3_en; // @[Decoupled.scala 209:16]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  empty = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire  _T_4 = do_enq != do_deq; // @[Decoupled.scala 227:16]
  assign ram__T_7_addr = 1'h0;
  assign ram__T_7_data = ram[ram__T_7_addr]; // @[Decoupled.scala 209:16]
  assign ram__T_3_data = io_enq_bits;
  assign ram__T_3_addr = 1'h0;
  assign ram__T_3_mask = 1'h1;
  assign ram__T_3_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = io_deq_ready | empty; // @[Decoupled.scala 232:16 Decoupled.scala 245:40]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 231:16]
  assign io_deq_bits = ram__T_7_data; // @[Decoupled.scala 233:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram[initvar] = _RAND_0[15:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  maybe_full = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram__T_3_en & ram__T_3_mask) begin
      ram[ram__T_3_addr] <= ram__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_4) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module Queue_14(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits_addr,
  input  [1:0]  io_enq_bits_way,
  input  [63:0] io_enq_bits_data,
  input  [1:0]  io_enq_bits_replaceWay,
  input  [31:0] io_enq_bits_tbeFields_0,
  input  [27:0] io_enq_bits_action_signals,
  input  [3:0]  io_enq_bits_action_actionType,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits_addr,
  output [1:0]  io_deq_bits_way,
  output [63:0] io_deq_bits_data,
  output [1:0]  io_deq_bits_replaceWay,
  output [31:0] io_deq_bits_tbeFields_0,
  output [27:0] io_deq_bits_action_signals,
  output [3:0]  io_deq_bits_action_actionType
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_7;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram_addr [0:0]; // @[Decoupled.scala 209:16]
  wire [31:0] ram_addr__T_33_data; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_33_addr; // @[Decoupled.scala 209:16]
  wire [31:0] ram_addr__T_27_data; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_27_addr; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_27_mask; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_27_en; // @[Decoupled.scala 209:16]
  reg [1:0] ram_way [0:0]; // @[Decoupled.scala 209:16]
  wire [1:0] ram_way__T_33_data; // @[Decoupled.scala 209:16]
  wire  ram_way__T_33_addr; // @[Decoupled.scala 209:16]
  wire [1:0] ram_way__T_27_data; // @[Decoupled.scala 209:16]
  wire  ram_way__T_27_addr; // @[Decoupled.scala 209:16]
  wire  ram_way__T_27_mask; // @[Decoupled.scala 209:16]
  wire  ram_way__T_27_en; // @[Decoupled.scala 209:16]
  reg [63:0] ram_data [0:0]; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_33_data; // @[Decoupled.scala 209:16]
  wire  ram_data__T_33_addr; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_27_data; // @[Decoupled.scala 209:16]
  wire  ram_data__T_27_addr; // @[Decoupled.scala 209:16]
  wire  ram_data__T_27_mask; // @[Decoupled.scala 209:16]
  wire  ram_data__T_27_en; // @[Decoupled.scala 209:16]
  reg [1:0] ram_replaceWay [0:0]; // @[Decoupled.scala 209:16]
  wire [1:0] ram_replaceWay__T_33_data; // @[Decoupled.scala 209:16]
  wire  ram_replaceWay__T_33_addr; // @[Decoupled.scala 209:16]
  wire [1:0] ram_replaceWay__T_27_data; // @[Decoupled.scala 209:16]
  wire  ram_replaceWay__T_27_addr; // @[Decoupled.scala 209:16]
  wire  ram_replaceWay__T_27_mask; // @[Decoupled.scala 209:16]
  wire  ram_replaceWay__T_27_en; // @[Decoupled.scala 209:16]
  reg [31:0] ram_tbeFields_0 [0:0]; // @[Decoupled.scala 209:16]
  wire [31:0] ram_tbeFields_0__T_33_data; // @[Decoupled.scala 209:16]
  wire  ram_tbeFields_0__T_33_addr; // @[Decoupled.scala 209:16]
  wire [31:0] ram_tbeFields_0__T_27_data; // @[Decoupled.scala 209:16]
  wire  ram_tbeFields_0__T_27_addr; // @[Decoupled.scala 209:16]
  wire  ram_tbeFields_0__T_27_mask; // @[Decoupled.scala 209:16]
  wire  ram_tbeFields_0__T_27_en; // @[Decoupled.scala 209:16]
  reg [27:0] ram_action_signals [0:0]; // @[Decoupled.scala 209:16]
  wire [27:0] ram_action_signals__T_33_data; // @[Decoupled.scala 209:16]
  wire  ram_action_signals__T_33_addr; // @[Decoupled.scala 209:16]
  wire [27:0] ram_action_signals__T_27_data; // @[Decoupled.scala 209:16]
  wire  ram_action_signals__T_27_addr; // @[Decoupled.scala 209:16]
  wire  ram_action_signals__T_27_mask; // @[Decoupled.scala 209:16]
  wire  ram_action_signals__T_27_en; // @[Decoupled.scala 209:16]
  reg [3:0] ram_action_actionType [0:0]; // @[Decoupled.scala 209:16]
  wire [3:0] ram_action_actionType__T_33_data; // @[Decoupled.scala 209:16]
  wire  ram_action_actionType__T_33_addr; // @[Decoupled.scala 209:16]
  wire [3:0] ram_action_actionType__T_27_data; // @[Decoupled.scala 209:16]
  wire  ram_action_actionType__T_27_addr; // @[Decoupled.scala 209:16]
  wire  ram_action_actionType__T_27_mask; // @[Decoupled.scala 209:16]
  wire  ram_action_actionType__T_27_en; // @[Decoupled.scala 209:16]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  empty = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  _T_30 = do_enq != io_deq_valid; // @[Decoupled.scala 227:16]
  assign ram_addr__T_33_addr = 1'h0;
  assign ram_addr__T_33_data = ram_addr[ram_addr__T_33_addr]; // @[Decoupled.scala 209:16]
  assign ram_addr__T_27_data = io_enq_bits_addr;
  assign ram_addr__T_27_addr = 1'h0;
  assign ram_addr__T_27_mask = 1'h1;
  assign ram_addr__T_27_en = io_enq_ready & io_enq_valid;
  assign ram_way__T_33_addr = 1'h0;
  assign ram_way__T_33_data = ram_way[ram_way__T_33_addr]; // @[Decoupled.scala 209:16]
  assign ram_way__T_27_data = io_enq_bits_way;
  assign ram_way__T_27_addr = 1'h0;
  assign ram_way__T_27_mask = 1'h1;
  assign ram_way__T_27_en = io_enq_ready & io_enq_valid;
  assign ram_data__T_33_addr = 1'h0;
  assign ram_data__T_33_data = ram_data[ram_data__T_33_addr]; // @[Decoupled.scala 209:16]
  assign ram_data__T_27_data = io_enq_bits_data;
  assign ram_data__T_27_addr = 1'h0;
  assign ram_data__T_27_mask = 1'h1;
  assign ram_data__T_27_en = io_enq_ready & io_enq_valid;
  assign ram_replaceWay__T_33_addr = 1'h0;
  assign ram_replaceWay__T_33_data = ram_replaceWay[ram_replaceWay__T_33_addr]; // @[Decoupled.scala 209:16]
  assign ram_replaceWay__T_27_data = io_enq_bits_replaceWay;
  assign ram_replaceWay__T_27_addr = 1'h0;
  assign ram_replaceWay__T_27_mask = 1'h1;
  assign ram_replaceWay__T_27_en = io_enq_ready & io_enq_valid;
  assign ram_tbeFields_0__T_33_addr = 1'h0;
  assign ram_tbeFields_0__T_33_data = ram_tbeFields_0[ram_tbeFields_0__T_33_addr]; // @[Decoupled.scala 209:16]
  assign ram_tbeFields_0__T_27_data = io_enq_bits_tbeFields_0;
  assign ram_tbeFields_0__T_27_addr = 1'h0;
  assign ram_tbeFields_0__T_27_mask = 1'h1;
  assign ram_tbeFields_0__T_27_en = io_enq_ready & io_enq_valid;
  assign ram_action_signals__T_33_addr = 1'h0;
  assign ram_action_signals__T_33_data = ram_action_signals[ram_action_signals__T_33_addr]; // @[Decoupled.scala 209:16]
  assign ram_action_signals__T_27_data = io_enq_bits_action_signals;
  assign ram_action_signals__T_27_addr = 1'h0;
  assign ram_action_signals__T_27_mask = 1'h1;
  assign ram_action_signals__T_27_en = io_enq_ready & io_enq_valid;
  assign ram_action_actionType__T_33_addr = 1'h0;
  assign ram_action_actionType__T_33_data = ram_action_actionType[ram_action_actionType__T_33_addr]; // @[Decoupled.scala 209:16]
  assign ram_action_actionType__T_27_data = io_enq_bits_action_actionType;
  assign ram_action_actionType__T_27_addr = 1'h0;
  assign ram_action_actionType__T_27_mask = 1'h1;
  assign ram_action_actionType__T_27_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = 1'h1; // @[Decoupled.scala 232:16 Decoupled.scala 245:40]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 231:16]
  assign io_deq_bits_addr = ram_addr__T_33_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_way = ram_way__T_33_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_data = ram_data__T_33_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_replaceWay = ram_replaceWay__T_33_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_tbeFields_0 = ram_tbeFields_0__T_33_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_action_signals = ram_action_signals__T_33_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_action_actionType = ram_action_actionType__T_33_data; // @[Decoupled.scala 233:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_addr[initvar] = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_way[initvar] = _RAND_1[1:0];
  _RAND_2 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_data[initvar] = _RAND_2[63:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_replaceWay[initvar] = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_tbeFields_0[initvar] = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_action_signals[initvar] = _RAND_5[27:0];
  _RAND_6 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_action_actionType[initvar] = _RAND_6[3:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  maybe_full = _RAND_7[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram_addr__T_27_en & ram_addr__T_27_mask) begin
      ram_addr[ram_addr__T_27_addr] <= ram_addr__T_27_data; // @[Decoupled.scala 209:16]
    end
    if(ram_way__T_27_en & ram_way__T_27_mask) begin
      ram_way[ram_way__T_27_addr] <= ram_way__T_27_data; // @[Decoupled.scala 209:16]
    end
    if(ram_data__T_27_en & ram_data__T_27_mask) begin
      ram_data[ram_data__T_27_addr] <= ram_data__T_27_data; // @[Decoupled.scala 209:16]
    end
    if(ram_replaceWay__T_27_en & ram_replaceWay__T_27_mask) begin
      ram_replaceWay[ram_replaceWay__T_27_addr] <= ram_replaceWay__T_27_data; // @[Decoupled.scala 209:16]
    end
    if(ram_tbeFields_0__T_27_en & ram_tbeFields_0__T_27_mask) begin
      ram_tbeFields_0[ram_tbeFields_0__T_27_addr] <= ram_tbeFields_0__T_27_data; // @[Decoupled.scala 209:16]
    end
    if(ram_action_signals__T_27_en & ram_action_signals__T_27_mask) begin
      ram_action_signals[ram_action_signals__T_27_addr] <= ram_action_signals__T_27_data; // @[Decoupled.scala 209:16]
    end
    if(ram_action_actionType__T_27_en & ram_action_actionType__T_27_mask) begin
      ram_action_actionType[ram_action_actionType__T_27_addr] <= ram_action_actionType__T_27_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_30) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module MIMOQueue(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [1:0]  io_enq_bits_0_way,
  input  [31:0] io_enq_bits_0_addr,
  input  [1:0]  io_enq_bits_1_way,
  input  [31:0] io_enq_bits_1_addr,
  output        io_deq_valid,
  output [1:0]  io_deq_bits_0_way,
  output [31:0] io_deq_bits_0_addr,
  output [7:0]  io_count
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] ram_way [0:127]; // @[MIMOQueue.scala 56:16]
  wire [1:0] ram_way__T_22_data; // @[MIMOQueue.scala 56:16]
  wire [6:0] ram_way__T_22_addr; // @[MIMOQueue.scala 56:16]
  wire [1:0] ram_way__T_7_data; // @[MIMOQueue.scala 56:16]
  wire [6:0] ram_way__T_7_addr; // @[MIMOQueue.scala 56:16]
  wire  ram_way__T_7_mask; // @[MIMOQueue.scala 56:16]
  wire  ram_way__T_7_en; // @[MIMOQueue.scala 56:16]
  wire [1:0] ram_way__T_10_data; // @[MIMOQueue.scala 56:16]
  wire [6:0] ram_way__T_10_addr; // @[MIMOQueue.scala 56:16]
  wire  ram_way__T_10_mask; // @[MIMOQueue.scala 56:16]
  wire  ram_way__T_10_en; // @[MIMOQueue.scala 56:16]
  reg [31:0] ram_addr [0:127]; // @[MIMOQueue.scala 56:16]
  wire [31:0] ram_addr__T_22_data; // @[MIMOQueue.scala 56:16]
  wire [6:0] ram_addr__T_22_addr; // @[MIMOQueue.scala 56:16]
  wire [31:0] ram_addr__T_7_data; // @[MIMOQueue.scala 56:16]
  wire [6:0] ram_addr__T_7_addr; // @[MIMOQueue.scala 56:16]
  wire  ram_addr__T_7_mask; // @[MIMOQueue.scala 56:16]
  wire  ram_addr__T_7_en; // @[MIMOQueue.scala 56:16]
  wire [31:0] ram_addr__T_10_data; // @[MIMOQueue.scala 56:16]
  wire [6:0] ram_addr__T_10_addr; // @[MIMOQueue.scala 56:16]
  wire  ram_addr__T_10_mask; // @[MIMOQueue.scala 56:16]
  wire  ram_addr__T_10_en; // @[MIMOQueue.scala 56:16]
  reg [6:0] value; // @[Counter.scala 29:33]
  reg [6:0] value_1; // @[Counter.scala 29:33]
  reg  maybe_full; // @[MIMOQueue.scala 59:27]
  wire  ptr_match = value == value_1; // @[MIMOQueue.scala 62:33]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire [7:0] _T_5 = {{1'd0}, value}; // @[MIMOQueue.scala 77:25]
  wire [6:0] _T_12 = value + 7'h2; // @[MIMOQueue.scala 79:36]
  wire [6:0] _T_14 = value_1 + 7'h1; // @[MIMOQueue.scala 86:36]
  wire  _T_15 = do_enq != io_deq_valid; // @[MIMOQueue.scala 91:16]
  wire [6:0] ptr_diff = value - value_1; // @[MIMOQueue.scala 97:32]
  wire  _T_18 = io_count > 8'h0; // @[MIMOQueue.scala 100:18]
  wire [7:0] _T_20 = {{1'd0}, value_1}; // @[MIMOQueue.scala 106:73]
  wire  _T_25 = maybe_full & ptr_match; // @[MIMOQueue.scala 123:32]
  assign ram_way__T_22_addr = _T_20[6:0];
  assign ram_way__T_22_data = ram_way[ram_way__T_22_addr]; // @[MIMOQueue.scala 56:16]
  assign ram_way__T_7_data = io_enq_bits_0_way;
  assign ram_way__T_7_addr = _T_5[6:0];
  assign ram_way__T_7_mask = 1'h1;
  assign ram_way__T_7_en = io_enq_ready & io_enq_valid;
  assign ram_way__T_10_data = io_enq_bits_1_way;
  assign ram_way__T_10_addr = value + 7'h1;
  assign ram_way__T_10_mask = 1'h1;
  assign ram_way__T_10_en = io_enq_ready & io_enq_valid;
  assign ram_addr__T_22_addr = _T_20[6:0];
  assign ram_addr__T_22_data = ram_addr[ram_addr__T_22_addr]; // @[MIMOQueue.scala 56:16]
  assign ram_addr__T_7_data = io_enq_bits_0_addr;
  assign ram_addr__T_7_addr = _T_5[6:0];
  assign ram_addr__T_7_mask = 1'h1;
  assign ram_addr__T_7_en = io_enq_ready & io_enq_valid;
  assign ram_addr__T_10_data = io_enq_bits_1_addr;
  assign ram_addr__T_10_addr = value + 7'h1;
  assign ram_addr__T_10_mask = 1'h1;
  assign ram_addr__T_10_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = 1'h1; // @[MIMOQueue.scala 95:16 MIMOQueue.scala 119:40]
  assign io_deq_valid = io_count > 8'h0; // @[MIMOQueue.scala 101:18 MIMOQueue.scala 103:18]
  assign io_deq_bits_0_way = _T_18 ? ram_way__T_22_data : 2'h0; // @[MIMOQueue.scala 106:20]
  assign io_deq_bits_0_addr = _T_18 ? ram_addr__T_22_data : 32'h0; // @[MIMOQueue.scala 106:20]
  assign io_count = _T_25 ? 8'h80 : {{1'd0}, ptr_diff}; // @[MIMOQueue.scala 123:14]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    ram_way[initvar] = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 128; initvar = initvar+1)
    ram_addr[initvar] = _RAND_1[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  value = _RAND_2[6:0];
  _RAND_3 = {1{`RANDOM}};
  value_1 = _RAND_3[6:0];
  _RAND_4 = {1{`RANDOM}};
  maybe_full = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram_way__T_7_en & ram_way__T_7_mask) begin
      ram_way[ram_way__T_7_addr] <= ram_way__T_7_data; // @[MIMOQueue.scala 56:16]
    end
    if(ram_way__T_10_en & ram_way__T_10_mask) begin
      ram_way[ram_way__T_10_addr] <= ram_way__T_10_data; // @[MIMOQueue.scala 56:16]
    end
    if(ram_addr__T_7_en & ram_addr__T_7_mask) begin
      ram_addr[ram_addr__T_7_addr] <= ram_addr__T_7_data; // @[MIMOQueue.scala 56:16]
    end
    if(ram_addr__T_10_en & ram_addr__T_10_mask) begin
      ram_addr[ram_addr__T_10_addr] <= ram_addr__T_10_data; // @[MIMOQueue.scala 56:16]
    end
    if (reset) begin
      value <= 7'h0;
    end else if (do_enq) begin
      value <= _T_12;
    end
    if (reset) begin
      value_1 <= 7'h0;
    end else if (io_deq_valid) begin
      value_1 <= _T_14;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_15) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module Computation(
  input         clock,
  input         reset,
  input         io_instruction_valid,
  input  [27:0] io_instruction_bits,
  input         io_clear,
  input         io_op1_valid,
  input  [63:0] io_op1_bits,
  input         io_op2_valid,
  input  [63:0] io_op2_bits,
  output [15:0] io_pc,
  output [63:0] io_reg_file_0,
  output [63:0] io_reg_file_1,
  output [63:0] io_reg_file_2,
  output [63:0] io_reg_file_3
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire [3:0] function_ = io_instruction_bits[3:0]; // @[Computation.scala 69:42]
  wire [5:0] write_addr = io_instruction_bits[9:4]; // @[Computation.scala 70:42]
  wire [1:0] read_addr1 = io_instruction_bits[11:10]; // @[Computation.scala 73:42]
  wire [15:0] read_addr2 = io_instruction_bits[27:12]; // @[Computation.scala 74:42]
  reg [63:0] reg_file_3; // @[Computation.scala 86:27]
  reg [63:0] reg_file_2; // @[Computation.scala 86:27]
  reg [63:0] reg_file_1; // @[Computation.scala 86:27]
  reg [63:0] reg_file_0; // @[Computation.scala 86:27]
  wire [63:0] _GEN_13 = 2'h1 == read_addr1 ? reg_file_1 : reg_file_0; // @[Computation.scala 92:14]
  wire [63:0] _GEN_14 = 2'h2 == read_addr1 ? reg_file_2 : _GEN_13; // @[Computation.scala 92:14]
  wire [63:0] reg_out1 = 2'h3 == read_addr1 ? reg_file_3 : _GEN_14; // @[Computation.scala 92:14]
  wire [63:0] alu_in1 = io_op1_valid ? io_op1_bits : reg_out1; // @[Computation.scala 82:19]
  wire [63:0] _GEN_17 = 2'h1 == read_addr2[1:0] ? reg_file_1 : reg_file_0; // @[Computation.scala 93:14]
  wire [63:0] _GEN_18 = 2'h2 == read_addr2[1:0] ? reg_file_2 : _GEN_17; // @[Computation.scala 93:14]
  wire [63:0] reg_out2 = 2'h3 == read_addr2[1:0] ? reg_file_3 : _GEN_18; // @[Computation.scala 93:14]
  wire [63:0] alu_in2 = io_op2_valid ? io_op2_bits : reg_out2; // @[Computation.scala 83:19]
  wire  _T_3 = function_ != 4'h6; // @[Computation.scala 88:55]
  wire  _T_4 = function_ != 4'h7; // @[Computation.scala 88:75]
  wire  _T_5 = _T_3 & _T_4; // @[Computation.scala 88:63]
  wire  write_en = io_instruction_valid & _T_5; // @[Computation.scala 88:42]
  wire  _T_10 = 4'h0 == function_; // @[Conditional.scala 37:30]
  wire [63:0] _T_12 = alu_in1 + alu_in2; // @[Computation.scala 33:38]
  wire  _T_13 = 4'h1 == function_; // @[Conditional.scala 37:30]
  wire [63:0] _T_14 = alu_in1 & alu_in2; // @[Computation.scala 34:38]
  wire  _T_15 = 4'h2 == function_; // @[Conditional.scala 37:30]
  wire [63:0] _T_17 = alu_in1 - alu_in2; // @[Computation.scala 35:38]
  wire  _T_18 = 4'h3 == function_; // @[Conditional.scala 37:30]
  wire [63:0] _T_19 = alu_in1 >> alu_in2; // @[Computation.scala 36:42]
  wire  _T_20 = 4'h4 == function_; // @[Conditional.scala 37:30]
  wire [318:0] _GEN_29 = {{255'd0}, alu_in1}; // @[Computation.scala 37:42]
  wire [318:0] _T_22 = _GEN_29 << alu_in2[7:0]; // @[Computation.scala 37:42]
  wire  _T_23 = 4'h5 == function_; // @[Conditional.scala 37:30]
  wire [63:0] _T_24 = alu_in1 ^ alu_in2; // @[Computation.scala 38:38]
  wire  _T_25 = 4'h6 == function_; // @[Conditional.scala 37:30]
  wire  _T_26 = alu_in1 < alu_in2; // @[Computation.scala 39:43]
  wire [63:0] _T_8 = {{58'd0}, write_addr}; // @[Computation.scala 97:93 Computation.scala 97:93]
  wire [63:0] _T_27 = _T_26 ? _T_8 : 64'h0; // @[Computation.scala 39:38]
  wire  _T_28 = 4'h7 == function_; // @[Conditional.scala 37:30]
  wire  _T_29 = alu_in1 != alu_in2; // @[Computation.scala 40:43]
  wire [63:0] _T_30 = _T_29 ? _T_8 : 64'h0; // @[Computation.scala 40:38]
  wire  _T_31 = 4'h8 == function_; // @[Conditional.scala 37:30]
  wire [63:0] _T_32 = alu_in1 | alu_in2; // @[Computation.scala 41:37]
  wire [63:0] _GEN_20 = _T_31 ? _T_32 : 64'h0; // @[Conditional.scala 39:67]
  wire [63:0] _GEN_21 = _T_28 ? _T_30 : _GEN_20; // @[Conditional.scala 39:67]
  wire [63:0] _GEN_22 = _T_25 ? _T_27 : _GEN_21; // @[Conditional.scala 39:67]
  wire [63:0] _GEN_23 = _T_23 ? _T_24 : _GEN_22; // @[Conditional.scala 39:67]
  wire [318:0] _GEN_24 = _T_20 ? _T_22 : {{255'd0}, _GEN_23}; // @[Conditional.scala 39:67]
  wire [318:0] _GEN_25 = _T_18 ? {{255'd0}, _T_19} : _GEN_24; // @[Conditional.scala 39:67]
  wire [318:0] _GEN_26 = _T_15 ? {{255'd0}, _T_17} : _GEN_25; // @[Conditional.scala 39:67]
  wire [318:0] _GEN_27 = _T_13 ? {{255'd0}, _T_14} : _GEN_26; // @[Conditional.scala 39:67]
  wire [318:0] _GEN_28 = _T_10 ? {{255'd0}, _T_12} : _GEN_27; // @[Conditional.scala 40:58]
  wire [63:0] result = io_instruction_valid ? _GEN_28[63:0] : 64'h0; // @[Computation.scala 97:18]
  assign io_pc = _T_5 ? 16'h0 : result[15:0]; // @[Computation.scala 98:11]
  assign io_reg_file_0 = reg_file_0; // @[Computation.scala 94:17]
  assign io_reg_file_1 = reg_file_1; // @[Computation.scala 94:17]
  assign io_reg_file_2 = reg_file_2; // @[Computation.scala 94:17]
  assign io_reg_file_3 = reg_file_3; // @[Computation.scala 94:17]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  reg_file_3 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  reg_file_2 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  reg_file_1 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  reg_file_0 = _RAND_3[63:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      reg_file_3 <= 64'h0;
    end else if (io_clear) begin
      reg_file_3 <= 64'h0;
    end else if (write_en) begin
      if (2'h3 == write_addr[1:0]) begin
        if (io_instruction_valid) begin
          reg_file_3 <= _GEN_28[63:0];
        end else begin
          reg_file_3 <= 64'h0;
        end
      end
    end
    if (reset) begin
      reg_file_2 <= 64'h0;
    end else if (io_clear) begin
      reg_file_2 <= 64'h0;
    end else if (write_en) begin
      if (2'h2 == write_addr[1:0]) begin
        if (io_instruction_valid) begin
          reg_file_2 <= _GEN_28[63:0];
        end else begin
          reg_file_2 <= 64'h0;
        end
      end
    end
    if (reset) begin
      reg_file_1 <= 64'h0;
    end else if (io_clear) begin
      reg_file_1 <= 64'h0;
    end else if (write_en) begin
      if (2'h1 == write_addr[1:0]) begin
        if (io_instruction_valid) begin
          reg_file_1 <= _GEN_28[63:0];
        end else begin
          reg_file_1 <= 64'h0;
        end
      end
    end
    if (reset) begin
      reg_file_0 <= 64'h0;
    end else if (io_clear) begin
      reg_file_0 <= 64'h0;
    end else if (write_en) begin
      if (2'h0 == write_addr[1:0]) begin
        if (io_instruction_valid) begin
          reg_file_0 <= _GEN_28[63:0];
        end else begin
          reg_file_0 <= 64'h0;
        end
      end
    end
  end
endmodule
module Mux3(
  input  [63:0] io_in_hardCoded,
  input  [63:0] io_in_data,
  input  [63:0] io_in_tbe,
  input  [1:0]  io_in_select,
  output        io_out_valid,
  output [63:0] io_out_bits
);
  wire  _T = io_in_select == 2'h3; // @[ComputationUtils.scala 27:24]
  wire  _T_1 = io_in_select == 2'h2; // @[ComputationUtils.scala 29:31]
  wire  _T_2 = io_in_select == 2'h1; // @[ComputationUtils.scala 31:31]
  wire [63:0] _GEN_0 = _T_2 ? io_in_tbe : 64'h0; // @[ComputationUtils.scala 31:40]
  wire [63:0] _GEN_1 = _T_1 ? io_in_data : _GEN_0; // @[ComputationUtils.scala 29:40]
  wire [63:0] result = _T ? io_in_hardCoded : _GEN_1; // @[ComputationUtils.scala 27:33]
  assign io_out_valid = result != 64'h0; // @[ComputationUtils.scala 38:18]
  assign io_out_bits = _T ? io_in_hardCoded : _GEN_1; // @[ComputationUtils.scala 37:17]
endmodule
module programmableCache(
  input         clock,
  input         reset,
  output        io_in_cpu_ready,
  input         io_in_cpu_valid,
  input  [1:0]  io_in_cpu_bits_event,
  input  [31:0] io_in_cpu_bits_addr,
  input  [63:0] io_in_cpu_bits_data,
  output        io_in_memCtrl_ready,
  input         io_in_memCtrl_valid,
  input  [1:0]  io_in_memCtrl_bits_event,
  input  [31:0] io_in_memCtrl_bits_addr,
  input  [63:0] io_in_memCtrl_bits_data,
  output        io_in_otherNodes_ready,
  input         io_in_otherNodes_valid,
  input  [1:0]  io_in_otherNodes_bits_event,
  input  [31:0] io_in_otherNodes_bits_addr,
  input  [63:0] io_in_otherNodes_bits_data,
  output        io_out_req_valid,
  output [31:0] io_out_req_bits_req_addr,
  output [63:0] io_out_req_bits_req_data,
  output        io_out_resp_valid,
  output [31:0] io_out_resp_bits_addr,
  output        _T_242_0,
  output        _T_236_0,
  output        _T_249_0,
  output        hitLD_0,
  output        missLD_0,
  output        _T_239_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
  reg [31:0] _RAND_58;
  reg [31:0] _RAND_59;
  reg [31:0] _RAND_60;
  reg [31:0] _RAND_61;
  reg [31:0] _RAND_62;
  reg [31:0] _RAND_63;
  reg [31:0] _RAND_64;
  reg [31:0] _RAND_65;
  reg [31:0] _RAND_66;
  reg [31:0] _RAND_67;
  reg [31:0] _RAND_68;
  reg [63:0] _RAND_69;
  reg [31:0] _RAND_70;
  reg [31:0] _RAND_71;
  reg [31:0] _RAND_72;
  reg [63:0] _RAND_73;
  reg [31:0] _RAND_74;
  reg [31:0] _RAND_75;
`endif // RANDOMIZE_REG_INIT
  wire  cache_clock; // @[programmableCache.scala 52:26]
  wire  cache_reset; // @[programmableCache.scala 52:26]
  wire  cache_io_cpu_0_req_valid; // @[programmableCache.scala 52:26]
  wire [31:0] cache_io_cpu_0_req_bits_addr; // @[programmableCache.scala 52:26]
  wire [63:0] cache_io_cpu_0_req_bits_data; // @[programmableCache.scala 52:26]
  wire [27:0] cache_io_cpu_0_req_bits_command; // @[programmableCache.scala 52:26]
  wire [1:0] cache_io_cpu_0_req_bits_way; // @[programmableCache.scala 52:26]
  wire [1:0] cache_io_cpu_0_req_bits_replaceWay; // @[programmableCache.scala 52:26]
  wire  cache_io_cpu_0_resp_valid; // @[programmableCache.scala 52:26]
  wire  cache_io_cpu_0_resp_bits_iswrite; // @[programmableCache.scala 52:26]
  wire [1:0] cache_io_cpu_0_resp_bits_way; // @[programmableCache.scala 52:26]
  wire  cache_io_probe_req_valid; // @[programmableCache.scala 52:26]
  wire [31:0] cache_io_probe_req_bits_addr; // @[programmableCache.scala 52:26]
  wire [27:0] cache_io_probe_req_bits_command; // @[programmableCache.scala 52:26]
  wire  cache_io_probe_resp_valid; // @[programmableCache.scala 52:26]
  wire [1:0] cache_io_probe_resp_bits_way; // @[programmableCache.scala 52:26]
  wire  cache_io_probe_multiWay_valid; // @[programmableCache.scala 52:26]
  wire [1:0] cache_io_probe_multiWay_bits_way_0; // @[programmableCache.scala 52:26]
  wire [1:0] cache_io_probe_multiWay_bits_way_1; // @[programmableCache.scala 52:26]
  wire [31:0] cache_io_probe_multiWay_bits_addr; // @[programmableCache.scala 52:26]
  wire  cache_io_bipassLD_in_valid; // @[programmableCache.scala 52:26]
  wire [31:0] cache_io_bipassLD_in_bits_addr; // @[programmableCache.scala 52:26]
  wire [2:0] cache_io_bipassLD_in_bits_way; // @[programmableCache.scala 52:26]
  wire  cache_io_bipassLD_out_valid; // @[programmableCache.scala 52:26]
  wire [63:0] cache_io_bipassLD_out_bits_data; // @[programmableCache.scala 52:26]
  wire  tbe_clock; // @[programmableCache.scala 53:26]
  wire  tbe_reset; // @[programmableCache.scala 53:26]
  wire  tbe_io_write_0_valid; // @[programmableCache.scala 53:26]
  wire [63:0] tbe_io_write_0_bits_addr; // @[programmableCache.scala 53:26]
  wire [1:0] tbe_io_write_0_bits_command; // @[programmableCache.scala 53:26]
  wire  tbe_io_write_0_bits_mask; // @[programmableCache.scala 53:26]
  wire [1:0] tbe_io_write_0_bits_inputTBE_state_state; // @[programmableCache.scala 53:26]
  wire [2:0] tbe_io_write_0_bits_inputTBE_way; // @[programmableCache.scala 53:26]
  wire [31:0] tbe_io_write_0_bits_inputTBE_fields_0; // @[programmableCache.scala 53:26]
  wire  tbe_io_read_valid; // @[programmableCache.scala 53:26]
  wire [63:0] tbe_io_read_bits_addr; // @[programmableCache.scala 53:26]
  wire [1:0] tbe_io_outputTBE_bits_state_state; // @[programmableCache.scala 53:26]
  wire [2:0] tbe_io_outputTBE_bits_way; // @[programmableCache.scala 53:26]
  wire [31:0] tbe_io_outputTBE_bits_fields_0; // @[programmableCache.scala 53:26]
  wire  tbe_io_isFull; // @[programmableCache.scala 53:26]
  wire  lockMem_clock; // @[programmableCache.scala 54:26]
  wire  lockMem_reset; // @[programmableCache.scala 54:26]
  wire  lockMem_io_lock_in_valid; // @[programmableCache.scala 54:26]
  wire [31:0] lockMem_io_lock_in_bits_addr; // @[programmableCache.scala 54:26]
  wire  lockMem_io_probe_out_valid; // @[programmableCache.scala 54:26]
  wire  lockMem_io_probe_out_bits; // @[programmableCache.scala 54:26]
  wire  lockMem_io_probe_in_valid; // @[programmableCache.scala 54:26]
  wire [31:0] lockMem_io_probe_in_bits_addr; // @[programmableCache.scala 54:26]
  wire  lockMem_io_unLock_0_in_valid; // @[programmableCache.scala 54:26]
  wire [31:0] lockMem_io_unLock_0_in_bits_addr; // @[programmableCache.scala 54:26]
  wire  stateMem_clock; // @[programmableCache.scala 55:27]
  wire  stateMem_reset; // @[programmableCache.scala 55:27]
  wire  stateMem_io_in_0_valid; // @[programmableCache.scala 55:27]
  wire [1:0] stateMem_io_in_0_bits_state_state; // @[programmableCache.scala 55:27]
  wire [31:0] stateMem_io_in_0_bits_addr; // @[programmableCache.scala 55:27]
  wire [1:0] stateMem_io_in_0_bits_way; // @[programmableCache.scala 55:27]
  wire  stateMem_io_in_1_valid; // @[programmableCache.scala 55:27]
  wire [31:0] stateMem_io_in_1_bits_addr; // @[programmableCache.scala 55:27]
  wire [1:0] stateMem_io_in_1_bits_way; // @[programmableCache.scala 55:27]
  wire  stateMem_io_out_valid; // @[programmableCache.scala 55:27]
  wire [1:0] stateMem_io_out_bits_state; // @[programmableCache.scala 55:27]
  wire  pc_clock; // @[programmableCache.scala 56:26]
  wire  pc_reset; // @[programmableCache.scala 56:26]
  wire  pc_io_write_ready; // @[programmableCache.scala 56:26]
  wire  pc_io_write_valid; // @[programmableCache.scala 56:26]
  wire [31:0] pc_io_write_bits_addr; // @[programmableCache.scala 56:26]
  wire [1:0] pc_io_write_bits_way; // @[programmableCache.scala 56:26]
  wire [63:0] pc_io_write_bits_data; // @[programmableCache.scala 56:26]
  wire [1:0] pc_io_write_bits_replaceWay; // @[programmableCache.scala 56:26]
  wire [31:0] pc_io_write_bits_tbeFields_0; // @[programmableCache.scala 56:26]
  wire [15:0] pc_io_write_bits_pc; // @[programmableCache.scala 56:26]
  wire [1:0] pc_io_read_0_in_bits_data_way; // @[programmableCache.scala 56:26]
  wire [15:0] pc_io_read_0_in_bits_data_pc; // @[programmableCache.scala 56:26]
  wire  pc_io_read_0_in_bits_data_valid; // @[programmableCache.scala 56:26]
  wire [31:0] pc_io_read_0_out_bits_addr; // @[programmableCache.scala 56:26]
  wire [1:0] pc_io_read_0_out_bits_way; // @[programmableCache.scala 56:26]
  wire [63:0] pc_io_read_0_out_bits_data; // @[programmableCache.scala 56:26]
  wire [1:0] pc_io_read_0_out_bits_replaceWay; // @[programmableCache.scala 56:26]
  wire [31:0] pc_io_read_0_out_bits_tbeFields_0; // @[programmableCache.scala 56:26]
  wire [15:0] pc_io_read_0_out_bits_pc; // @[programmableCache.scala 56:26]
  wire  pc_io_read_0_out_bits_valid; // @[programmableCache.scala 56:26]
  wire  pc_io_isFull; // @[programmableCache.scala 56:26]
  wire  inputArbiter_clock; // @[programmableCache.scala 57:33]
  wire  inputArbiter_io_in_0_valid; // @[programmableCache.scala 57:33]
  wire [1:0] inputArbiter_io_in_0_bits_event; // @[programmableCache.scala 57:33]
  wire [31:0] inputArbiter_io_in_0_bits_addr; // @[programmableCache.scala 57:33]
  wire [63:0] inputArbiter_io_in_0_bits_data; // @[programmableCache.scala 57:33]
  wire  inputArbiter_io_in_1_ready; // @[programmableCache.scala 57:33]
  wire  inputArbiter_io_in_1_valid; // @[programmableCache.scala 57:33]
  wire [1:0] inputArbiter_io_in_1_bits_event; // @[programmableCache.scala 57:33]
  wire [31:0] inputArbiter_io_in_1_bits_addr; // @[programmableCache.scala 57:33]
  wire [63:0] inputArbiter_io_in_1_bits_data; // @[programmableCache.scala 57:33]
  wire  inputArbiter_io_in_2_valid; // @[programmableCache.scala 57:33]
  wire [1:0] inputArbiter_io_in_2_bits_event; // @[programmableCache.scala 57:33]
  wire [31:0] inputArbiter_io_in_2_bits_addr; // @[programmableCache.scala 57:33]
  wire [63:0] inputArbiter_io_in_2_bits_data; // @[programmableCache.scala 57:33]
  wire  inputArbiter_io_in_3_valid; // @[programmableCache.scala 57:33]
  wire [1:0] inputArbiter_io_in_3_bits_event; // @[programmableCache.scala 57:33]
  wire [31:0] inputArbiter_io_in_3_bits_addr; // @[programmableCache.scala 57:33]
  wire [63:0] inputArbiter_io_in_3_bits_data; // @[programmableCache.scala 57:33]
  wire  inputArbiter_io_out_ready; // @[programmableCache.scala 57:33]
  wire  inputArbiter_io_out_valid; // @[programmableCache.scala 57:33]
  wire [1:0] inputArbiter_io_out_bits_event; // @[programmableCache.scala 57:33]
  wire [31:0] inputArbiter_io_out_bits_addr; // @[programmableCache.scala 57:33]
  wire [63:0] inputArbiter_io_out_bits_data; // @[programmableCache.scala 57:33]
  wire [1:0] inputArbiter_io_chosen; // @[programmableCache.scala 57:33]
  wire  outReqArbiter_io_in_0_valid; // @[programmableCache.scala 58:33]
  wire [31:0] outReqArbiter_io_in_0_bits_req_addr; // @[programmableCache.scala 58:33]
  wire [63:0] outReqArbiter_io_in_0_bits_req_data; // @[programmableCache.scala 58:33]
  wire  outReqArbiter_io_out_valid; // @[programmableCache.scala 58:33]
  wire [31:0] outReqArbiter_io_out_bits_req_addr; // @[programmableCache.scala 58:33]
  wire [63:0] outReqArbiter_io_out_bits_req_data; // @[programmableCache.scala 58:33]
  wire  outRespArbiter_io_in_0_valid; // @[programmableCache.scala 59:33]
  wire [31:0] outRespArbiter_io_in_0_bits_addr; // @[programmableCache.scala 59:33]
  wire  outRespArbiter_io_in_1_valid; // @[programmableCache.scala 59:33]
  wire [31:0] outRespArbiter_io_in_1_bits_addr; // @[programmableCache.scala 59:33]
  wire  outRespArbiter_io_out_valid; // @[programmableCache.scala 59:33]
  wire [31:0] outRespArbiter_io_out_bits_addr; // @[programmableCache.scala 59:33]
  wire  feedbackArbiter_io_in_0_ready; // @[programmableCache.scala 60:34]
  wire  feedbackArbiter_io_in_0_valid; // @[programmableCache.scala 60:34]
  wire [1:0] feedbackArbiter_io_in_0_bits_event; // @[programmableCache.scala 60:34]
  wire [31:0] feedbackArbiter_io_in_0_bits_addr; // @[programmableCache.scala 60:34]
  wire [63:0] feedbackArbiter_io_in_0_bits_data; // @[programmableCache.scala 60:34]
  wire  feedbackArbiter_io_out_ready; // @[programmableCache.scala 60:34]
  wire  feedbackArbiter_io_out_valid; // @[programmableCache.scala 60:34]
  wire [1:0] feedbackArbiter_io_out_bits_event; // @[programmableCache.scala 60:34]
  wire [31:0] feedbackArbiter_io_out_bits_addr; // @[programmableCache.scala 60:34]
  wire [63:0] feedbackArbiter_io_out_bits_data; // @[programmableCache.scala 60:34]
  wire  input__clock; // @[programmableCache.scala 90:23]
  wire  input__reset; // @[programmableCache.scala 90:23]
  wire  input__io_enq_ready; // @[programmableCache.scala 90:23]
  wire  input__io_enq_valid; // @[programmableCache.scala 90:23]
  wire [1:0] input__io_enq_bits_inst_event; // @[programmableCache.scala 90:23]
  wire [31:0] input__io_enq_bits_inst_addr; // @[programmableCache.scala 90:23]
  wire [63:0] input__io_enq_bits_inst_data; // @[programmableCache.scala 90:23]
  wire [1:0] input__io_enq_bits_tbeOut_state_state; // @[programmableCache.scala 90:23]
  wire [2:0] input__io_enq_bits_tbeOut_way; // @[programmableCache.scala 90:23]
  wire [31:0] input__io_enq_bits_tbeOut_fields_0; // @[programmableCache.scala 90:23]
  wire  input__io_deq_ready; // @[programmableCache.scala 90:23]
  wire  input__io_deq_valid; // @[programmableCache.scala 90:23]
  wire [1:0] input__io_deq_bits_inst_event; // @[programmableCache.scala 90:23]
  wire [31:0] input__io_deq_bits_inst_addr; // @[programmableCache.scala 90:23]
  wire [63:0] input__io_deq_bits_inst_data; // @[programmableCache.scala 90:23]
  wire [1:0] input__io_deq_bits_tbeOut_state_state; // @[programmableCache.scala 90:23]
  wire [2:0] input__io_deq_bits_tbeOut_way; // @[programmableCache.scala 90:23]
  wire [31:0] input__io_deq_bits_tbeOut_fields_0; // @[programmableCache.scala 90:23]
  wire  respPortQueue_0_clock; // @[programmableCache.scala 93:27]
  wire  respPortQueue_0_reset; // @[programmableCache.scala 93:27]
  wire  respPortQueue_0_io_enq_ready; // @[programmableCache.scala 93:27]
  wire  respPortQueue_0_io_enq_valid; // @[programmableCache.scala 93:27]
  wire [1:0] respPortQueue_0_io_enq_bits_event; // @[programmableCache.scala 93:27]
  wire [31:0] respPortQueue_0_io_enq_bits_addr; // @[programmableCache.scala 93:27]
  wire [63:0] respPortQueue_0_io_enq_bits_data; // @[programmableCache.scala 93:27]
  wire  respPortQueue_0_io_deq_ready; // @[programmableCache.scala 93:27]
  wire  respPortQueue_0_io_deq_valid; // @[programmableCache.scala 93:27]
  wire [1:0] respPortQueue_0_io_deq_bits_event; // @[programmableCache.scala 93:27]
  wire [31:0] respPortQueue_0_io_deq_bits_addr; // @[programmableCache.scala 93:27]
  wire [63:0] respPortQueue_0_io_deq_bits_data; // @[programmableCache.scala 93:27]
  wire  respPortQueue_1_clock; // @[programmableCache.scala 93:27]
  wire  respPortQueue_1_reset; // @[programmableCache.scala 93:27]
  wire  respPortQueue_1_io_enq_ready; // @[programmableCache.scala 93:27]
  wire  respPortQueue_1_io_enq_valid; // @[programmableCache.scala 93:27]
  wire [1:0] respPortQueue_1_io_enq_bits_event; // @[programmableCache.scala 93:27]
  wire [31:0] respPortQueue_1_io_enq_bits_addr; // @[programmableCache.scala 93:27]
  wire [63:0] respPortQueue_1_io_enq_bits_data; // @[programmableCache.scala 93:27]
  wire  respPortQueue_1_io_deq_ready; // @[programmableCache.scala 93:27]
  wire  respPortQueue_1_io_deq_valid; // @[programmableCache.scala 93:27]
  wire [1:0] respPortQueue_1_io_deq_bits_event; // @[programmableCache.scala 93:27]
  wire [31:0] respPortQueue_1_io_deq_bits_addr; // @[programmableCache.scala 93:27]
  wire [63:0] respPortQueue_1_io_deq_bits_data; // @[programmableCache.scala 93:27]
  wire  feedbackInQueue_0_clock; // @[programmableCache.scala 98:27]
  wire  feedbackInQueue_0_reset; // @[programmableCache.scala 98:27]
  wire  feedbackInQueue_0_io_enq_ready; // @[programmableCache.scala 98:27]
  wire  feedbackInQueue_0_io_enq_valid; // @[programmableCache.scala 98:27]
  wire [1:0] feedbackInQueue_0_io_enq_bits_event; // @[programmableCache.scala 98:27]
  wire [31:0] feedbackInQueue_0_io_enq_bits_addr; // @[programmableCache.scala 98:27]
  wire [63:0] feedbackInQueue_0_io_enq_bits_data; // @[programmableCache.scala 98:27]
  wire  feedbackInQueue_0_io_deq_ready; // @[programmableCache.scala 98:27]
  wire  feedbackInQueue_0_io_deq_valid; // @[programmableCache.scala 98:27]
  wire [1:0] feedbackInQueue_0_io_deq_bits_event; // @[programmableCache.scala 98:27]
  wire [31:0] feedbackInQueue_0_io_deq_bits_addr; // @[programmableCache.scala 98:27]
  wire [63:0] feedbackInQueue_0_io_deq_bits_data; // @[programmableCache.scala 98:27]
  wire  probeWay_clock; // @[programmableCache.scala 102:26]
  wire  probeWay_reset; // @[programmableCache.scala 102:26]
  wire  probeWay_io_enq_ready; // @[programmableCache.scala 102:26]
  wire  probeWay_io_enq_valid; // @[programmableCache.scala 102:26]
  wire [1:0] probeWay_io_enq_bits; // @[programmableCache.scala 102:26]
  wire  probeWay_io_deq_ready; // @[programmableCache.scala 102:26]
  wire  probeWay_io_deq_valid; // @[programmableCache.scala 102:26]
  wire [1:0] probeWay_io_deq_bits; // @[programmableCache.scala 102:26]
  wire  feedbackOutQueue_clock; // @[programmableCache.scala 159:34]
  wire  feedbackOutQueue_reset; // @[programmableCache.scala 159:34]
  wire  feedbackOutQueue_io_enq_ready; // @[programmableCache.scala 159:34]
  wire  feedbackOutQueue_io_enq_valid; // @[programmableCache.scala 159:34]
  wire [1:0] feedbackOutQueue_io_enq_bits_event; // @[programmableCache.scala 159:34]
  wire [31:0] feedbackOutQueue_io_enq_bits_addr; // @[programmableCache.scala 159:34]
  wire [63:0] feedbackOutQueue_io_enq_bits_data; // @[programmableCache.scala 159:34]
  wire  feedbackOutQueue_io_deq_ready; // @[programmableCache.scala 159:34]
  wire  feedbackOutQueue_io_deq_valid; // @[programmableCache.scala 159:34]
  wire [1:0] feedbackOutQueue_io_deq_bits_event; // @[programmableCache.scala 159:34]
  wire [31:0] feedbackOutQueue_io_deq_bits_addr; // @[programmableCache.scala 159:34]
  wire [63:0] feedbackOutQueue_io_deq_bits_data; // @[programmableCache.scala 159:34]
  wire  routineQueue_clock; // @[programmableCache.scala 160:30]
  wire  routineQueue_reset; // @[programmableCache.scala 160:30]
  wire  routineQueue_io_enq_ready; // @[programmableCache.scala 160:30]
  wire  routineQueue_io_enq_valid; // @[programmableCache.scala 160:30]
  wire [15:0] routineQueue_io_enq_bits; // @[programmableCache.scala 160:30]
  wire  routineQueue_io_deq_ready; // @[programmableCache.scala 160:30]
  wire  routineQueue_io_deq_valid; // @[programmableCache.scala 160:30]
  wire [15:0] routineQueue_io_deq_bits; // @[programmableCache.scala 160:30]
  wire  actionReg_0_clock; // @[programmableCache.scala 163:32]
  wire  actionReg_0_reset; // @[programmableCache.scala 163:32]
  wire  actionReg_0_io_enq_ready; // @[programmableCache.scala 163:32]
  wire  actionReg_0_io_enq_valid; // @[programmableCache.scala 163:32]
  wire [31:0] actionReg_0_io_enq_bits_addr; // @[programmableCache.scala 163:32]
  wire [1:0] actionReg_0_io_enq_bits_way; // @[programmableCache.scala 163:32]
  wire [63:0] actionReg_0_io_enq_bits_data; // @[programmableCache.scala 163:32]
  wire [1:0] actionReg_0_io_enq_bits_replaceWay; // @[programmableCache.scala 163:32]
  wire [31:0] actionReg_0_io_enq_bits_tbeFields_0; // @[programmableCache.scala 163:32]
  wire [27:0] actionReg_0_io_enq_bits_action_signals; // @[programmableCache.scala 163:32]
  wire [3:0] actionReg_0_io_enq_bits_action_actionType; // @[programmableCache.scala 163:32]
  wire  actionReg_0_io_deq_ready; // @[programmableCache.scala 163:32]
  wire  actionReg_0_io_deq_valid; // @[programmableCache.scala 163:32]
  wire [31:0] actionReg_0_io_deq_bits_addr; // @[programmableCache.scala 163:32]
  wire [1:0] actionReg_0_io_deq_bits_way; // @[programmableCache.scala 163:32]
  wire [63:0] actionReg_0_io_deq_bits_data; // @[programmableCache.scala 163:32]
  wire [1:0] actionReg_0_io_deq_bits_replaceWay; // @[programmableCache.scala 163:32]
  wire [31:0] actionReg_0_io_deq_bits_tbeFields_0; // @[programmableCache.scala 163:32]
  wire [27:0] actionReg_0_io_deq_bits_action_signals; // @[programmableCache.scala 163:32]
  wire [3:0] actionReg_0_io_deq_bits_action_actionType; // @[programmableCache.scala 163:32]
  wire  mimoQ_clock; // @[programmableCache.scala 167:24]
  wire  mimoQ_reset; // @[programmableCache.scala 167:24]
  wire  mimoQ_io_enq_ready; // @[programmableCache.scala 167:24]
  wire  mimoQ_io_enq_valid; // @[programmableCache.scala 167:24]
  wire [1:0] mimoQ_io_enq_bits_0_way; // @[programmableCache.scala 167:24]
  wire [31:0] mimoQ_io_enq_bits_0_addr; // @[programmableCache.scala 167:24]
  wire [1:0] mimoQ_io_enq_bits_1_way; // @[programmableCache.scala 167:24]
  wire [31:0] mimoQ_io_enq_bits_1_addr; // @[programmableCache.scala 167:24]
  wire  mimoQ_io_deq_valid; // @[programmableCache.scala 167:24]
  wire [1:0] mimoQ_io_deq_bits_0_way; // @[programmableCache.scala 167:24]
  wire [31:0] mimoQ_io_deq_bits_0_addr; // @[programmableCache.scala 167:24]
  wire [7:0] mimoQ_io_count; // @[programmableCache.scala 167:24]
  wire  compUnit_0_clock; // @[programmableCache.scala 171:27]
  wire  compUnit_0_reset; // @[programmableCache.scala 171:27]
  wire  compUnit_0_io_instruction_valid; // @[programmableCache.scala 171:27]
  wire [27:0] compUnit_0_io_instruction_bits; // @[programmableCache.scala 171:27]
  wire  compUnit_0_io_clear; // @[programmableCache.scala 171:27]
  wire  compUnit_0_io_op1_valid; // @[programmableCache.scala 171:27]
  wire [63:0] compUnit_0_io_op1_bits; // @[programmableCache.scala 171:27]
  wire  compUnit_0_io_op2_valid; // @[programmableCache.scala 171:27]
  wire [63:0] compUnit_0_io_op2_bits; // @[programmableCache.scala 171:27]
  wire [15:0] compUnit_0_io_pc; // @[programmableCache.scala 171:27]
  wire [63:0] compUnit_0_io_reg_file_0; // @[programmableCache.scala 171:27]
  wire [63:0] compUnit_0_io_reg_file_1; // @[programmableCache.scala 171:27]
  wire [63:0] compUnit_0_io_reg_file_2; // @[programmableCache.scala 171:27]
  wire [63:0] compUnit_0_io_reg_file_3; // @[programmableCache.scala 171:27]
  wire [63:0] compUnitInput1_0_io_in_hardCoded; // @[programmableCache.scala 176:30]
  wire [63:0] compUnitInput1_0_io_in_data; // @[programmableCache.scala 176:30]
  wire [63:0] compUnitInput1_0_io_in_tbe; // @[programmableCache.scala 176:30]
  wire [1:0] compUnitInput1_0_io_in_select; // @[programmableCache.scala 176:30]
  wire  compUnitInput1_0_io_out_valid; // @[programmableCache.scala 176:30]
  wire [63:0] compUnitInput1_0_io_out_bits; // @[programmableCache.scala 176:30]
  wire [63:0] compUnitInput2_0_io_in_hardCoded; // @[programmableCache.scala 182:30]
  wire [63:0] compUnitInput2_0_io_in_data; // @[programmableCache.scala 182:30]
  wire [63:0] compUnitInput2_0_io_in_tbe; // @[programmableCache.scala 182:30]
  wire [1:0] compUnitInput2_0_io_in_select; // @[programmableCache.scala 182:30]
  wire  compUnitInput2_0_io_out_valid; // @[programmableCache.scala 182:30]
  wire [63:0] compUnitInput2_0_io_out_bits; // @[programmableCache.scala 182:30]
  wire  _T_93 = input__io_deq_bits_tbeOut_state_state != 2'h0; // @[programmableCache.scala 287:55]
  wire [1:0] _T_94 = stateMem_io_out_valid ? stateMem_io_out_bits_state : 2'h0; // @[programmableCache.scala 287:120]
  wire [1:0] state = _T_93 ? input__io_deq_bits_tbeOut_state_state : _T_94; // @[programmableCache.scala 287:17]
  wire [3:0] routine = {input__io_deq_bits_inst_event,state}; // @[Cat.scala 29:58]
  reg  instUsed; // @[programmableCache.scala 191:27]
  reg  replStateReg_0; // @[programmableCache.scala 198:31]
  reg  replStateReg_1; // @[programmableCache.scala 198:31]
  reg  replStateReg_2; // @[programmableCache.scala 198:31]
  reg  replStateReg_3; // @[programmableCache.scala 198:31]
  reg  replStateReg_4; // @[programmableCache.scala 198:31]
  reg  replStateReg_5; // @[programmableCache.scala 198:31]
  reg  replStateReg_6; // @[programmableCache.scala 198:31]
  reg  replStateReg_7; // @[programmableCache.scala 198:31]
  reg  replStateReg_8; // @[programmableCache.scala 198:31]
  reg  replStateReg_9; // @[programmableCache.scala 198:31]
  reg  replStateReg_10; // @[programmableCache.scala 198:31]
  reg  replStateReg_11; // @[programmableCache.scala 198:31]
  reg  replStateReg_12; // @[programmableCache.scala 198:31]
  reg  replStateReg_13; // @[programmableCache.scala 198:31]
  reg  replStateReg_14; // @[programmableCache.scala 198:31]
  reg  replStateReg_15; // @[programmableCache.scala 198:31]
  reg  replStateReg_16; // @[programmableCache.scala 198:31]
  reg  replStateReg_17; // @[programmableCache.scala 198:31]
  reg  replStateReg_18; // @[programmableCache.scala 198:31]
  reg  replStateReg_19; // @[programmableCache.scala 198:31]
  reg  replStateReg_20; // @[programmableCache.scala 198:31]
  reg  replStateReg_21; // @[programmableCache.scala 198:31]
  reg  replStateReg_22; // @[programmableCache.scala 198:31]
  reg  replStateReg_23; // @[programmableCache.scala 198:31]
  reg  replStateReg_24; // @[programmableCache.scala 198:31]
  reg  replStateReg_25; // @[programmableCache.scala 198:31]
  reg  replStateReg_26; // @[programmableCache.scala 198:31]
  reg  replStateReg_27; // @[programmableCache.scala 198:31]
  reg  replStateReg_28; // @[programmableCache.scala 198:31]
  reg  replStateReg_29; // @[programmableCache.scala 198:31]
  reg  replStateReg_30; // @[programmableCache.scala 198:31]
  reg  replStateReg_31; // @[programmableCache.scala 198:31]
  reg  replStateReg_32; // @[programmableCache.scala 198:31]
  reg  replStateReg_33; // @[programmableCache.scala 198:31]
  reg  replStateReg_34; // @[programmableCache.scala 198:31]
  reg  replStateReg_35; // @[programmableCache.scala 198:31]
  reg  replStateReg_36; // @[programmableCache.scala 198:31]
  reg  replStateReg_37; // @[programmableCache.scala 198:31]
  reg  replStateReg_38; // @[programmableCache.scala 198:31]
  reg  replStateReg_39; // @[programmableCache.scala 198:31]
  reg  replStateReg_40; // @[programmableCache.scala 198:31]
  reg  replStateReg_41; // @[programmableCache.scala 198:31]
  reg  replStateReg_42; // @[programmableCache.scala 198:31]
  reg  replStateReg_43; // @[programmableCache.scala 198:31]
  reg  replStateReg_44; // @[programmableCache.scala 198:31]
  reg  replStateReg_45; // @[programmableCache.scala 198:31]
  reg  replStateReg_46; // @[programmableCache.scala 198:31]
  reg  replStateReg_47; // @[programmableCache.scala 198:31]
  reg  replStateReg_48; // @[programmableCache.scala 198:31]
  reg  replStateReg_49; // @[programmableCache.scala 198:31]
  reg  replStateReg_50; // @[programmableCache.scala 198:31]
  reg  replStateReg_51; // @[programmableCache.scala 198:31]
  reg  replStateReg_52; // @[programmableCache.scala 198:31]
  reg  replStateReg_53; // @[programmableCache.scala 198:31]
  reg  replStateReg_54; // @[programmableCache.scala 198:31]
  reg  replStateReg_55; // @[programmableCache.scala 198:31]
  reg  replStateReg_56; // @[programmableCache.scala 198:31]
  reg  replStateReg_57; // @[programmableCache.scala 198:31]
  reg  replStateReg_58; // @[programmableCache.scala 198:31]
  reg  replStateReg_59; // @[programmableCache.scala 198:31]
  reg  replStateReg_60; // @[programmableCache.scala 198:31]
  reg  replStateReg_61; // @[programmableCache.scala 198:31]
  reg  replStateReg_62; // @[programmableCache.scala 198:31]
  reg  replStateReg_63; // @[programmableCache.scala 198:31]
  wire [31:0] _GEN_376 = {{24'd0}, actionReg_0_io_deq_bits_action_signals[7:0]}; // @[programmableCache.scala 241:78]
  wire [63:0] _GEN_377 = {{60'd0}, actionReg_0_io_deq_bits_action_signals[11:8]}; // @[programmableCache.scala 243:78]
  wire  isLocked = lockMem_io_probe_out_valid & lockMem_io_probe_out_bits; // @[programmableCache.scala 317:21]
  wire  stallInput = isLocked | tbe_io_isFull; // @[programmableCache.scala 254:28]
  wire  _T_45 = 2'h0 == input__io_deq_bits_inst_event; // @[programmableCache.scala 258:35]
  wire  _T_46 = 2'h1 == input__io_deq_bits_inst_event; // @[programmableCache.scala 258:35]
  wire  hitEvent = _T_45 | _T_46; // @[programmableCache.scala 258:35]
  wire  _T_82 = ~tbe_io_isFull; // @[programmableCache.scala 278:48]
  wire  _T_83 = input__io_enq_ready & _T_82; // @[programmableCache.scala 278:45]
  wire  _T_84 = ~stallInput; // @[programmableCache.scala 278:66]
  wire  instruction_ready = _T_83 & _T_84; // @[programmableCache.scala 278:63]
  wire  instruction_valid = inputArbiter_io_out_valid; // @[programmableCache.scala 104:27 programmableCache.scala 246:17]
  wire  _T_50 = instruction_ready & instruction_valid; // @[Decoupled.scala 40:37]
  wire [1:0] instruction_bits_event = inputArbiter_io_out_bits_event; // @[programmableCache.scala 104:27 programmableCache.scala 246:17]
  wire  _T_51 = 2'h0 == instruction_bits_event; // @[programmableCache.scala 261:59]
  wire  _T_52 = 2'h1 == instruction_bits_event; // @[programmableCache.scala 261:59]
  wire  _T_54 = _T_51 | _T_52; // @[programmableCache.scala 261:59]
  wire  probeStart = _T_50 & _T_54; // @[programmableCache.scala 261:38]
  wire  getState = input__io_deq_ready & input__io_deq_valid; // @[Decoupled.scala 40:37]
  wire  _T_60 = probeWay_io_deq_bits != 2'h2; // @[programmableCache.scala 269:46]
  wire  _T_61 = getState & _T_60; // @[programmableCache.scala 269:21]
  wire  _T_62 = stateMem_io_out_bits_state == 2'h2; // @[programmableCache.scala 269:90]
  wire  hit = _T_61 & _T_62; // @[programmableCache.scala 269:59]
  wire  _T_64 = hit & hitEvent; // @[programmableCache.scala 270:20]
  wire  _T_65 = getState & hitEvent; // @[programmableCache.scala 271:24]
  wire  _T_66 = stateMem_io_out_bits_state == 2'h0; // @[programmableCache.scala 271:71]
  wire  _T_67 = _T_65 & _T_66; // @[programmableCache.scala 271:39]
  wire  _T_69 = inputArbiter_io_chosen == 2'h0; // @[programmableCache.scala 273:77]
  wire  _T_70 = _T_50 & _T_69; // @[programmableCache.scala 273:51]
  wire  _T_72 = inputArbiter_io_chosen == 2'h3; // @[programmableCache.scala 274:76]
  wire  _T_73 = _T_50 & _T_72; // @[programmableCache.scala 274:50]
  wire  _T_75 = inputArbiter_io_chosen == 2'h2; // @[programmableCache.scala 275:77]
  wire  _T_78 = ~_T_50; // @[programmableCache.scala 277:20]
  wire  _T_79 = input__io_enq_ready & input__io_enq_valid; // @[Decoupled.scala 40:37]
  wire  _T_80 = _T_79 | instUsed; // @[programmableCache.scala 277:63]
  wire  _T_81 = _T_78 & _T_80; // @[programmableCache.scala 277:40]
  wire  _T_86 = ~instUsed; // @[programmableCache.scala 280:48]
  wire  _T_87 = instruction_valid & _T_86; // @[programmableCache.scala 280:45]
  wire  _T_89 = _T_87 & _T_82; // @[programmableCache.scala 280:58]
  wire  maskField_0 = actionReg_0_io_deq_bits_action_signals[2]; // @[Gem5CacheLogic.scala 104:54]
  wire  _T_96 = ~maskField_0; // @[programmableCache.scala 297:84]
  wire [63:0] _GEN_368 = compUnit_0_io_reg_file_0; // @[programmableCache.scala 411:31]
  wire [63:0] _GEN_369 = 2'h1 == actionReg_0_io_deq_bits_action_signals[4:3] ? compUnit_0_io_reg_file_1 : _GEN_368; // @[programmableCache.scala 411:31]
  wire [63:0] _GEN_370 = 2'h2 == actionReg_0_io_deq_bits_action_signals[4:3] ? compUnit_0_io_reg_file_2 : _GEN_369; // @[programmableCache.scala 411:31]
  wire [63:0] _GEN_371 = 2'h3 == actionReg_0_io_deq_bits_action_signals[4:3] ? compUnit_0_io_reg_file_3 : _GEN_370; // @[programmableCache.scala 411:31]
  wire [31:0] tbeFieldUpdateSrc_0 = _GEN_371[31:0]; // @[programmableCache.scala 132:33 programmableCache.scala 411:31]
  wire  _T_149 = actionReg_0_io_deq_bits_action_actionType == 4'h3; // @[programmableCache.scala 367:73]
  wire  isStateAction_0 = _T_149 & actionReg_0_io_deq_valid; // @[programmableCache.scala 367:82]
  wire [1:0] tbeAction_0 = actionReg_0_io_deq_bits_action_signals[1:0]; // @[Gem5CacheLogic.scala 105:54]
  wire  _T_143 = actionReg_0_io_deq_bits_action_actionType == 4'h1; // @[programmableCache.scala 364:73]
  wire  isTBEAction_0 = _T_143 & actionReg_0_io_deq_valid; // @[programmableCache.scala 364:82]
  wire [4:0] _GEN_1 = 4'h1 == routine ? 5'h0 : 5'h1; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_2 = 4'h2 == routine ? 5'h0 : _GEN_1; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_3 = 4'h3 == routine ? 5'h0 : _GEN_2; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_4 = 4'h4 == routine ? 5'h5 : _GEN_3; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_5 = 4'h5 == routine ? 5'h10 : _GEN_4; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_6 = 4'h6 == routine ? 5'h0 : _GEN_5; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_7 = 4'h7 == routine ? 5'h0 : _GEN_6; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_8 = 4'h8 == routine ? 5'h0 : _GEN_7; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_9 = 4'h9 == routine ? 5'h1a : _GEN_8; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_10 = 4'ha == routine ? 5'h0 : _GEN_9; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_11 = 4'hb == routine ? 5'h0 : _GEN_10; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_12 = 4'hc == routine ? 5'h0 : _GEN_11; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_13 = 4'hd == routine ? 5'h0 : _GEN_12; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_14 = 4'he == routine ? 5'h0 : _GEN_13; // @[programmableCache.scala 343:30]
  wire [4:0] _GEN_15 = 4'hf == routine ? 5'h0 : _GEN_14; // @[programmableCache.scala 343:30]
  wire [31:0] addrReplacer = {{26'd0}, input__io_deq_bits_inst_addr[5:0]}; // @[programmableCache.scala 201:28 programmableCache.scala 350:18]
  wire  _GEN_17 = 6'h1 == addrReplacer[5:0] ? replStateReg_1 : replStateReg_0; // @[Replacement.scala 97:41]
  wire  _GEN_18 = 6'h2 == addrReplacer[5:0] ? replStateReg_2 : _GEN_17; // @[Replacement.scala 97:41]
  wire  _GEN_19 = 6'h3 == addrReplacer[5:0] ? replStateReg_3 : _GEN_18; // @[Replacement.scala 97:41]
  wire  _GEN_20 = 6'h4 == addrReplacer[5:0] ? replStateReg_4 : _GEN_19; // @[Replacement.scala 97:41]
  wire  _GEN_21 = 6'h5 == addrReplacer[5:0] ? replStateReg_5 : _GEN_20; // @[Replacement.scala 97:41]
  wire  _GEN_22 = 6'h6 == addrReplacer[5:0] ? replStateReg_6 : _GEN_21; // @[Replacement.scala 97:41]
  wire  _GEN_23 = 6'h7 == addrReplacer[5:0] ? replStateReg_7 : _GEN_22; // @[Replacement.scala 97:41]
  wire  _GEN_24 = 6'h8 == addrReplacer[5:0] ? replStateReg_8 : _GEN_23; // @[Replacement.scala 97:41]
  wire  _GEN_25 = 6'h9 == addrReplacer[5:0] ? replStateReg_9 : _GEN_24; // @[Replacement.scala 97:41]
  wire  _GEN_26 = 6'ha == addrReplacer[5:0] ? replStateReg_10 : _GEN_25; // @[Replacement.scala 97:41]
  wire  _GEN_27 = 6'hb == addrReplacer[5:0] ? replStateReg_11 : _GEN_26; // @[Replacement.scala 97:41]
  wire  _GEN_28 = 6'hc == addrReplacer[5:0] ? replStateReg_12 : _GEN_27; // @[Replacement.scala 97:41]
  wire  _GEN_29 = 6'hd == addrReplacer[5:0] ? replStateReg_13 : _GEN_28; // @[Replacement.scala 97:41]
  wire  _GEN_30 = 6'he == addrReplacer[5:0] ? replStateReg_14 : _GEN_29; // @[Replacement.scala 97:41]
  wire  _GEN_31 = 6'hf == addrReplacer[5:0] ? replStateReg_15 : _GEN_30; // @[Replacement.scala 97:41]
  wire  _GEN_32 = 6'h10 == addrReplacer[5:0] ? replStateReg_16 : _GEN_31; // @[Replacement.scala 97:41]
  wire  _GEN_33 = 6'h11 == addrReplacer[5:0] ? replStateReg_17 : _GEN_32; // @[Replacement.scala 97:41]
  wire  _GEN_34 = 6'h12 == addrReplacer[5:0] ? replStateReg_18 : _GEN_33; // @[Replacement.scala 97:41]
  wire  _GEN_35 = 6'h13 == addrReplacer[5:0] ? replStateReg_19 : _GEN_34; // @[Replacement.scala 97:41]
  wire  _GEN_36 = 6'h14 == addrReplacer[5:0] ? replStateReg_20 : _GEN_35; // @[Replacement.scala 97:41]
  wire  _GEN_37 = 6'h15 == addrReplacer[5:0] ? replStateReg_21 : _GEN_36; // @[Replacement.scala 97:41]
  wire  _GEN_38 = 6'h16 == addrReplacer[5:0] ? replStateReg_22 : _GEN_37; // @[Replacement.scala 97:41]
  wire  _GEN_39 = 6'h17 == addrReplacer[5:0] ? replStateReg_23 : _GEN_38; // @[Replacement.scala 97:41]
  wire  _GEN_40 = 6'h18 == addrReplacer[5:0] ? replStateReg_24 : _GEN_39; // @[Replacement.scala 97:41]
  wire  _GEN_41 = 6'h19 == addrReplacer[5:0] ? replStateReg_25 : _GEN_40; // @[Replacement.scala 97:41]
  wire  _GEN_42 = 6'h1a == addrReplacer[5:0] ? replStateReg_26 : _GEN_41; // @[Replacement.scala 97:41]
  wire  _GEN_43 = 6'h1b == addrReplacer[5:0] ? replStateReg_27 : _GEN_42; // @[Replacement.scala 97:41]
  wire  _GEN_44 = 6'h1c == addrReplacer[5:0] ? replStateReg_28 : _GEN_43; // @[Replacement.scala 97:41]
  wire  _GEN_45 = 6'h1d == addrReplacer[5:0] ? replStateReg_29 : _GEN_44; // @[Replacement.scala 97:41]
  wire  _GEN_46 = 6'h1e == addrReplacer[5:0] ? replStateReg_30 : _GEN_45; // @[Replacement.scala 97:41]
  wire  _GEN_47 = 6'h1f == addrReplacer[5:0] ? replStateReg_31 : _GEN_46; // @[Replacement.scala 97:41]
  wire  _GEN_48 = 6'h20 == addrReplacer[5:0] ? replStateReg_32 : _GEN_47; // @[Replacement.scala 97:41]
  wire  _GEN_49 = 6'h21 == addrReplacer[5:0] ? replStateReg_33 : _GEN_48; // @[Replacement.scala 97:41]
  wire  _GEN_50 = 6'h22 == addrReplacer[5:0] ? replStateReg_34 : _GEN_49; // @[Replacement.scala 97:41]
  wire  _GEN_51 = 6'h23 == addrReplacer[5:0] ? replStateReg_35 : _GEN_50; // @[Replacement.scala 97:41]
  wire  _GEN_52 = 6'h24 == addrReplacer[5:0] ? replStateReg_36 : _GEN_51; // @[Replacement.scala 97:41]
  wire  _GEN_53 = 6'h25 == addrReplacer[5:0] ? replStateReg_37 : _GEN_52; // @[Replacement.scala 97:41]
  wire  _GEN_54 = 6'h26 == addrReplacer[5:0] ? replStateReg_38 : _GEN_53; // @[Replacement.scala 97:41]
  wire  _GEN_55 = 6'h27 == addrReplacer[5:0] ? replStateReg_39 : _GEN_54; // @[Replacement.scala 97:41]
  wire  _GEN_56 = 6'h28 == addrReplacer[5:0] ? replStateReg_40 : _GEN_55; // @[Replacement.scala 97:41]
  wire  _GEN_57 = 6'h29 == addrReplacer[5:0] ? replStateReg_41 : _GEN_56; // @[Replacement.scala 97:41]
  wire  _GEN_58 = 6'h2a == addrReplacer[5:0] ? replStateReg_42 : _GEN_57; // @[Replacement.scala 97:41]
  wire  _GEN_59 = 6'h2b == addrReplacer[5:0] ? replStateReg_43 : _GEN_58; // @[Replacement.scala 97:41]
  wire  _GEN_60 = 6'h2c == addrReplacer[5:0] ? replStateReg_44 : _GEN_59; // @[Replacement.scala 97:41]
  wire  _GEN_61 = 6'h2d == addrReplacer[5:0] ? replStateReg_45 : _GEN_60; // @[Replacement.scala 97:41]
  wire  _GEN_62 = 6'h2e == addrReplacer[5:0] ? replStateReg_46 : _GEN_61; // @[Replacement.scala 97:41]
  wire  _GEN_63 = 6'h2f == addrReplacer[5:0] ? replStateReg_47 : _GEN_62; // @[Replacement.scala 97:41]
  wire  _GEN_64 = 6'h30 == addrReplacer[5:0] ? replStateReg_48 : _GEN_63; // @[Replacement.scala 97:41]
  wire  _GEN_65 = 6'h31 == addrReplacer[5:0] ? replStateReg_49 : _GEN_64; // @[Replacement.scala 97:41]
  wire  _GEN_66 = 6'h32 == addrReplacer[5:0] ? replStateReg_50 : _GEN_65; // @[Replacement.scala 97:41]
  wire  _GEN_67 = 6'h33 == addrReplacer[5:0] ? replStateReg_51 : _GEN_66; // @[Replacement.scala 97:41]
  wire  _GEN_68 = 6'h34 == addrReplacer[5:0] ? replStateReg_52 : _GEN_67; // @[Replacement.scala 97:41]
  wire  _GEN_69 = 6'h35 == addrReplacer[5:0] ? replStateReg_53 : _GEN_68; // @[Replacement.scala 97:41]
  wire  _GEN_70 = 6'h36 == addrReplacer[5:0] ? replStateReg_54 : _GEN_69; // @[Replacement.scala 97:41]
  wire  _GEN_71 = 6'h37 == addrReplacer[5:0] ? replStateReg_55 : _GEN_70; // @[Replacement.scala 97:41]
  wire  _GEN_72 = 6'h38 == addrReplacer[5:0] ? replStateReg_56 : _GEN_71; // @[Replacement.scala 97:41]
  wire  _GEN_73 = 6'h39 == addrReplacer[5:0] ? replStateReg_57 : _GEN_72; // @[Replacement.scala 97:41]
  wire  _GEN_74 = 6'h3a == addrReplacer[5:0] ? replStateReg_58 : _GEN_73; // @[Replacement.scala 97:41]
  wire  _GEN_75 = 6'h3b == addrReplacer[5:0] ? replStateReg_59 : _GEN_74; // @[Replacement.scala 97:41]
  wire  _GEN_76 = 6'h3c == addrReplacer[5:0] ? replStateReg_60 : _GEN_75; // @[Replacement.scala 97:41]
  wire  _GEN_77 = 6'h3d == addrReplacer[5:0] ? replStateReg_61 : _GEN_76; // @[Replacement.scala 97:41]
  wire  _GEN_78 = 6'h3e == addrReplacer[5:0] ? replStateReg_62 : _GEN_77; // @[Replacement.scala 97:41]
  wire  _GEN_79 = 6'h3f == addrReplacer[5:0] ? replStateReg_63 : _GEN_78; // @[Replacement.scala 97:41]
  wire [1:0] _T_110 = {_GEN_79,1'h0}; // @[Cat.scala 29:58]
  wire  _T_112 = &_T_110[1]; // @[Replacement.scala 133:103]
  wire  _T_115 = ~_T_110[1]; // @[Replacement.scala 134:89]
  wire [1:0] _T_117 = {_T_115,_T_112}; // @[Cat.scala 29:58]
  wire  replacerWayWire = _T_117[1]; // @[CircuitMath.scala 30:8]
  wire [1:0] _T_126 = 2'h1 << replacerWayWire; // @[OneHot.scala 65:12]
  wire  _T_128 = ~replacerWayWire; // @[Replacement.scala 111:25]
  wire [1:0] _T_129 = _T_110 | _T_126; // @[Replacement.scala 111:72]
  wire [1:0] _T_130 = _T_128 ? 2'h0 : _T_129; // @[Replacement.scala 111:20]
  wire  missLD = _T_67; // @[programmableCache.scala 105:22 programmableCache.scala 271:12]
  wire [2:0] tbeWay = input__io_deq_bits_tbeOut_way; // @[programmableCache.scala 288:12]
  wire  _T_132 = tbeWay == 3'h2; // @[programmableCache.scala 357:44]
  reg [2:0] wayInputCache; // @[Reg.scala 27:20]
  reg [31:0] tbeFields_0; // @[Reg.scala 27:20]
  reg [1:0] _T_139; // @[Reg.scala 27:20]
  reg [31:0] inputToPC_addr; // @[Reg.scala 27:20]
  reg [63:0] inputToPC_data; // @[Reg.scala 27:20]
  wire  _T_145 = actionReg_0_io_deq_bits_action_actionType == 4'h0; // @[programmableCache.scala 365:73]
  wire  isCacheAction_0 = _T_145 & actionReg_0_io_deq_valid; // @[programmableCache.scala 365:82]
  wire  _T_147 = actionReg_0_io_deq_bits_action_actionType == 4'h2; // @[programmableCache.scala 366:77]
  wire  _T_151 = actionReg_0_io_deq_bits_action_actionType == 4'h4; // @[programmableCache.scala 368:72]
  wire  _T_153 = actionReg_0_io_deq_bits_action_actionType >= 4'h8; // @[programmableCache.scala 369:73]
  wire [15:0] pcWire_0_pc = pc_io_read_0_out_bits_pc; // @[programmableCache.scala 110:22 programmableCache.scala 401:19]
  wire [31:0] _GEN_279 = 5'h1 == pcWire_0_pc[4:0] ? 32'h34 : 32'h0; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_280 = 5'h2 == pcWire_0_pc[4:0] ? 32'h80 : _GEN_279; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_281 = 5'h3 == pcWire_0_pc[4:0] ? 32'h30000001 : _GEN_280; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_282 = 5'h4 == pcWire_0_pc[4:0] ? 32'h0 : _GEN_281; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_283 = 5'h5 == pcWire_0_pc[4:0] ? 32'hc0000827 : _GEN_282; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_284 = 5'h6 == pcWire_0_pc[4:0] ? 32'h10000000 : _GEN_283; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_285 = 5'h7 == pcWire_0_pc[4:0] ? 32'h30000001 : _GEN_284; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_286 = 5'h8 == pcWire_0_pc[4:0] ? 32'h0 : _GEN_285; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_287 = 5'h9 == pcWire_0_pc[4:0] ? 32'h10000001 : _GEN_286; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_288 = 5'ha == pcWire_0_pc[4:0] ? 32'h34 : _GEN_287; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_289 = 5'hb == pcWire_0_pc[4:0] ? 32'he2000010 : _GEN_288; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_290 = 5'hc == pcWire_0_pc[4:0] ? 32'h40000203 : _GEN_289; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_291 = 5'hd == pcWire_0_pc[4:0] ? 32'h20001101 : _GEN_290; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_292 = 5'he == pcWire_0_pc[4:0] ? 32'h30000001 : _GEN_291; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_293 = 5'hf == pcWire_0_pc[4:0] ? 32'h0 : _GEN_292; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_294 = 5'h10 == pcWire_0_pc[4:0] ? 32'hc0000827 : _GEN_293; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_295 = 5'h11 == pcWire_0_pc[4:0] ? 32'h10000000 : _GEN_294; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_296 = 5'h12 == pcWire_0_pc[4:0] ? 32'h30000001 : _GEN_295; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_297 = 5'h13 == pcWire_0_pc[4:0] ? 32'h0 : _GEN_296; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_298 = 5'h14 == pcWire_0_pc[4:0] ? 32'h10000001 : _GEN_297; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_299 = 5'h15 == pcWire_0_pc[4:0] ? 32'he2000010 : _GEN_298; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_300 = 5'h16 == pcWire_0_pc[4:0] ? 32'h40000203 : _GEN_299; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_301 = 5'h17 == pcWire_0_pc[4:0] ? 32'h20001101 : _GEN_300; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_302 = 5'h18 == pcWire_0_pc[4:0] ? 32'h30000001 : _GEN_301; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_303 = 5'h19 == pcWire_0_pc[4:0] ? 32'h0 : _GEN_302; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_304 = 5'h1a == pcWire_0_pc[4:0] ? 32'h10000002 : _GEN_303; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_305 = 5'h1b == pcWire_0_pc[4:0] ? 32'h80 : _GEN_304; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_306 = 5'h1c == pcWire_0_pc[4:0] ? 32'h100 : _GEN_305; // @[Gem5CacheLogic.scala 100:53]
  wire [31:0] _GEN_307 = 5'h1d == pcWire_0_pc[4:0] ? 32'h30000001 : _GEN_306; // @[Gem5CacheLogic.scala 100:53]
  wire  _T_168 = pc_io_read_0_out_bits_way == 2'h2; // @[programmableCache.scala 390:52]
  wire  updateWay_0 = _T_168 & cache_io_cpu_0_resp_valid; // @[programmableCache.scala 390:64]
  wire [2:0] cacheWayWire_0 = {{1'd0}, cache_io_cpu_0_resp_bits_way}; // @[programmableCache.scala 148:28 programmableCache.scala 207:25]
  wire [1:0] pcWire_0_way = pc_io_read_0_out_bits_way; // @[programmableCache.scala 110:22 programmableCache.scala 401:19]
  wire [2:0] _T_159 = updateWay_0 ? cacheWayWire_0 : {{1'd0}, pcWire_0_way}; // @[programmableCache.scala 380:45]
  wire  firstLineNextRoutine_0 = _GEN_307 == 32'h0; // @[programmableCache.scala 386:72]
  wire [15:0] _T_163 = pcWire_0_pc + 16'h1; // @[programmableCache.scala 387:81]
  wire [15:0] _T_165 = _T_163 + compUnit_0_io_pc; // @[programmableCache.scala 387:87]
  wire [2:0] _T_170 = updateWay_0 ? cacheWayWire_0 : {{1'd0}, pc_io_read_0_out_bits_way}; // @[programmableCache.scala 392:46]
  wire [31:0] instruction_bits_addr = inputArbiter_io_out_bits_addr; // @[programmableCache.scala 104:27 programmableCache.scala 246:17]
  wire  _T_204 = mimoQ_io_deq_bits_0_way != 2'h2; // @[programmableCache.scala 465:83]
  wire [63:0] _GEN_373 = 2'h1 == actionReg_0_io_deq_bits_action_signals[2:1] ? compUnit_0_io_reg_file_1 : _GEN_368; // @[programmableCache.scala 473:51]
  wire [63:0] _GEN_374 = 2'h2 == actionReg_0_io_deq_bits_action_signals[2:1] ? compUnit_0_io_reg_file_2 : _GEN_373; // @[programmableCache.scala 473:51]
  wire [63:0] _GEN_375 = 2'h3 == actionReg_0_io_deq_bits_action_signals[2:1] ? compUnit_0_io_reg_file_3 : _GEN_374; // @[programmableCache.scala 473:51]
  reg [31:0] _T_211; // @[programmableCache.scala 496:55]
  wire  _T_212 = probeWay_io_deq_ready & probeWay_io_deq_valid; // @[Decoupled.scala 40:37]
  reg [1:0] _T_213; // @[programmableCache.scala 516:49]
  reg [31:0] _T_214; // @[programmableCache.scala 516:90]
  reg [63:0] _T_215; // @[programmableCache.scala 516:138]
  wire  _T_217 = ~reset; // @[programmableCache.scala 516:15]
  reg [1:0] _T_218; // @[programmableCache.scala 517:21]
  wire  _T_219 = _T_218 == 2'h3; // @[programmableCache.scala 517:46]
  reg  _T_226; // @[programmableCache.scala 523:31]
  wire  _T_236 = instruction_ready & instruction_valid; // @[Decoupled.scala 40:37]
  wire  _T_239 = _T_50 & _T_72; // @[programmableCache.scala 542:48]
  wire  _T_242 = _T_50 & _T_69; // @[programmableCache.scala 543:48]
  wire  _T_249 = _T_50 & _T_54; // @[programmableCache.scala 544:48]
  wire  hitLD = _T_64; // @[programmableCache.scala 128:29 programmableCache.scala 270:11]
  wire [2:0] replaceWayInputCache = {{1'd0}, _T_139}; // @[programmableCache.scala 156:36 programmableCache.scala 359:26]
  wire  _GEN_381 = _T_212 & _T_219; // @[programmableCache.scala 518:19]
  wire  _GEN_383 = _GEN_381 & hitLD; // @[programmableCache.scala 520:23]
  wire  _GEN_385 = ~hitLD; // @[programmableCache.scala 522:23]
  wire  _GEN_386 = _GEN_381 & _GEN_385; // @[programmableCache.scala 522:23]
  wire  _GEN_387 = _GEN_386 & isLocked; // @[programmableCache.scala 522:23]
  wire  _GEN_391 = ~isLocked; // @[programmableCache.scala 524:23]
  wire  _GEN_392 = _GEN_386 & _GEN_391; // @[programmableCache.scala 524:23]
  wire  _GEN_393 = _GEN_392 & _T_226; // @[programmableCache.scala 524:23]
  wire  _GEN_399 = ~_T_226; // @[programmableCache.scala 526:23]
  wire  _GEN_400 = _GEN_392 & _GEN_399; // @[programmableCache.scala 526:23]
  wire  _GEN_401 = _GEN_400 & hit; // @[programmableCache.scala 526:23]
  wire  _GEN_409 = ~hit; // @[programmableCache.scala 528:23]
  wire  _GEN_410 = _GEN_400 & _GEN_409; // @[programmableCache.scala 528:23]
  Gem5Cache cache ( // @[programmableCache.scala 52:26]
    .clock(cache_clock),
    .reset(cache_reset),
    .io_cpu_0_req_valid(cache_io_cpu_0_req_valid),
    .io_cpu_0_req_bits_addr(cache_io_cpu_0_req_bits_addr),
    .io_cpu_0_req_bits_data(cache_io_cpu_0_req_bits_data),
    .io_cpu_0_req_bits_command(cache_io_cpu_0_req_bits_command),
    .io_cpu_0_req_bits_way(cache_io_cpu_0_req_bits_way),
    .io_cpu_0_req_bits_replaceWay(cache_io_cpu_0_req_bits_replaceWay),
    .io_cpu_0_resp_valid(cache_io_cpu_0_resp_valid),
    .io_cpu_0_resp_bits_iswrite(cache_io_cpu_0_resp_bits_iswrite),
    .io_cpu_0_resp_bits_way(cache_io_cpu_0_resp_bits_way),
    .io_probe_req_valid(cache_io_probe_req_valid),
    .io_probe_req_bits_addr(cache_io_probe_req_bits_addr),
    .io_probe_req_bits_command(cache_io_probe_req_bits_command),
    .io_probe_resp_valid(cache_io_probe_resp_valid),
    .io_probe_resp_bits_way(cache_io_probe_resp_bits_way),
    .io_probe_multiWay_valid(cache_io_probe_multiWay_valid),
    .io_probe_multiWay_bits_way_0(cache_io_probe_multiWay_bits_way_0),
    .io_probe_multiWay_bits_way_1(cache_io_probe_multiWay_bits_way_1),
    .io_probe_multiWay_bits_addr(cache_io_probe_multiWay_bits_addr),
    .io_bipassLD_in_valid(cache_io_bipassLD_in_valid),
    .io_bipassLD_in_bits_addr(cache_io_bipassLD_in_bits_addr),
    .io_bipassLD_in_bits_way(cache_io_bipassLD_in_bits_way),
    .io_bipassLD_out_valid(cache_io_bipassLD_out_valid),
    .io_bipassLD_out_bits_data(cache_io_bipassLD_out_bits_data)
  );
  TBETable tbe ( // @[programmableCache.scala 53:26]
    .clock(tbe_clock),
    .reset(tbe_reset),
    .io_write_0_valid(tbe_io_write_0_valid),
    .io_write_0_bits_addr(tbe_io_write_0_bits_addr),
    .io_write_0_bits_command(tbe_io_write_0_bits_command),
    .io_write_0_bits_mask(tbe_io_write_0_bits_mask),
    .io_write_0_bits_inputTBE_state_state(tbe_io_write_0_bits_inputTBE_state_state),
    .io_write_0_bits_inputTBE_way(tbe_io_write_0_bits_inputTBE_way),
    .io_write_0_bits_inputTBE_fields_0(tbe_io_write_0_bits_inputTBE_fields_0),
    .io_read_valid(tbe_io_read_valid),
    .io_read_bits_addr(tbe_io_read_bits_addr),
    .io_outputTBE_bits_state_state(tbe_io_outputTBE_bits_state_state),
    .io_outputTBE_bits_way(tbe_io_outputTBE_bits_way),
    .io_outputTBE_bits_fields_0(tbe_io_outputTBE_bits_fields_0),
    .io_isFull(tbe_io_isFull)
  );
  lockVector lockMem ( // @[programmableCache.scala 54:26]
    .clock(lockMem_clock),
    .reset(lockMem_reset),
    .io_lock_in_valid(lockMem_io_lock_in_valid),
    .io_lock_in_bits_addr(lockMem_io_lock_in_bits_addr),
    .io_probe_out_valid(lockMem_io_probe_out_valid),
    .io_probe_out_bits(lockMem_io_probe_out_bits),
    .io_probe_in_valid(lockMem_io_probe_in_valid),
    .io_probe_in_bits_addr(lockMem_io_probe_in_bits_addr),
    .io_unLock_0_in_valid(lockMem_io_unLock_0_in_valid),
    .io_unLock_0_in_bits_addr(lockMem_io_unLock_0_in_bits_addr)
  );
  stateMem stateMem ( // @[programmableCache.scala 55:27]
    .clock(stateMem_clock),
    .reset(stateMem_reset),
    .io_in_0_valid(stateMem_io_in_0_valid),
    .io_in_0_bits_state_state(stateMem_io_in_0_bits_state_state),
    .io_in_0_bits_addr(stateMem_io_in_0_bits_addr),
    .io_in_0_bits_way(stateMem_io_in_0_bits_way),
    .io_in_1_valid(stateMem_io_in_1_valid),
    .io_in_1_bits_addr(stateMem_io_in_1_bits_addr),
    .io_in_1_bits_way(stateMem_io_in_1_bits_way),
    .io_out_valid(stateMem_io_out_valid),
    .io_out_bits_state(stateMem_io_out_bits_state)
  );
  PC pc ( // @[programmableCache.scala 56:26]
    .clock(pc_clock),
    .reset(pc_reset),
    .io_write_ready(pc_io_write_ready),
    .io_write_valid(pc_io_write_valid),
    .io_write_bits_addr(pc_io_write_bits_addr),
    .io_write_bits_way(pc_io_write_bits_way),
    .io_write_bits_data(pc_io_write_bits_data),
    .io_write_bits_replaceWay(pc_io_write_bits_replaceWay),
    .io_write_bits_tbeFields_0(pc_io_write_bits_tbeFields_0),
    .io_write_bits_pc(pc_io_write_bits_pc),
    .io_read_0_in_bits_data_way(pc_io_read_0_in_bits_data_way),
    .io_read_0_in_bits_data_pc(pc_io_read_0_in_bits_data_pc),
    .io_read_0_in_bits_data_valid(pc_io_read_0_in_bits_data_valid),
    .io_read_0_out_bits_addr(pc_io_read_0_out_bits_addr),
    .io_read_0_out_bits_way(pc_io_read_0_out_bits_way),
    .io_read_0_out_bits_data(pc_io_read_0_out_bits_data),
    .io_read_0_out_bits_replaceWay(pc_io_read_0_out_bits_replaceWay),
    .io_read_0_out_bits_tbeFields_0(pc_io_read_0_out_bits_tbeFields_0),
    .io_read_0_out_bits_pc(pc_io_read_0_out_bits_pc),
    .io_read_0_out_bits_valid(pc_io_read_0_out_bits_valid),
    .io_isFull(pc_io_isFull)
  );
  RRArbiter_2 inputArbiter ( // @[programmableCache.scala 57:33]
    .clock(inputArbiter_clock),
    .io_in_0_valid(inputArbiter_io_in_0_valid),
    .io_in_0_bits_event(inputArbiter_io_in_0_bits_event),
    .io_in_0_bits_addr(inputArbiter_io_in_0_bits_addr),
    .io_in_0_bits_data(inputArbiter_io_in_0_bits_data),
    .io_in_1_ready(inputArbiter_io_in_1_ready),
    .io_in_1_valid(inputArbiter_io_in_1_valid),
    .io_in_1_bits_event(inputArbiter_io_in_1_bits_event),
    .io_in_1_bits_addr(inputArbiter_io_in_1_bits_addr),
    .io_in_1_bits_data(inputArbiter_io_in_1_bits_data),
    .io_in_2_valid(inputArbiter_io_in_2_valid),
    .io_in_2_bits_event(inputArbiter_io_in_2_bits_event),
    .io_in_2_bits_addr(inputArbiter_io_in_2_bits_addr),
    .io_in_2_bits_data(inputArbiter_io_in_2_bits_data),
    .io_in_3_valid(inputArbiter_io_in_3_valid),
    .io_in_3_bits_event(inputArbiter_io_in_3_bits_event),
    .io_in_3_bits_addr(inputArbiter_io_in_3_bits_addr),
    .io_in_3_bits_data(inputArbiter_io_in_3_bits_data),
    .io_out_ready(inputArbiter_io_out_ready),
    .io_out_valid(inputArbiter_io_out_valid),
    .io_out_bits_event(inputArbiter_io_out_bits_event),
    .io_out_bits_addr(inputArbiter_io_out_bits_addr),
    .io_out_bits_data(inputArbiter_io_out_bits_data),
    .io_chosen(inputArbiter_io_chosen)
  );
  Arbiter_3 outReqArbiter ( // @[programmableCache.scala 58:33]
    .io_in_0_valid(outReqArbiter_io_in_0_valid),
    .io_in_0_bits_req_addr(outReqArbiter_io_in_0_bits_req_addr),
    .io_in_0_bits_req_data(outReqArbiter_io_in_0_bits_req_data),
    .io_out_valid(outReqArbiter_io_out_valid),
    .io_out_bits_req_addr(outReqArbiter_io_out_bits_req_addr),
    .io_out_bits_req_data(outReqArbiter_io_out_bits_req_data)
  );
  Arbiter_4 outRespArbiter ( // @[programmableCache.scala 59:33]
    .io_in_0_valid(outRespArbiter_io_in_0_valid),
    .io_in_0_bits_addr(outRespArbiter_io_in_0_bits_addr),
    .io_in_1_valid(outRespArbiter_io_in_1_valid),
    .io_in_1_bits_addr(outRespArbiter_io_in_1_bits_addr),
    .io_out_valid(outRespArbiter_io_out_valid),
    .io_out_bits_addr(outRespArbiter_io_out_bits_addr)
  );
  Arbiter_5 feedbackArbiter ( // @[programmableCache.scala 60:34]
    .io_in_0_ready(feedbackArbiter_io_in_0_ready),
    .io_in_0_valid(feedbackArbiter_io_in_0_valid),
    .io_in_0_bits_event(feedbackArbiter_io_in_0_bits_event),
    .io_in_0_bits_addr(feedbackArbiter_io_in_0_bits_addr),
    .io_in_0_bits_data(feedbackArbiter_io_in_0_bits_data),
    .io_out_ready(feedbackArbiter_io_out_ready),
    .io_out_valid(feedbackArbiter_io_out_valid),
    .io_out_bits_event(feedbackArbiter_io_out_bits_event),
    .io_out_bits_addr(feedbackArbiter_io_out_bits_addr),
    .io_out_bits_data(feedbackArbiter_io_out_bits_data)
  );
  Queue_7 input_ ( // @[programmableCache.scala 90:23]
    .clock(input__clock),
    .reset(input__reset),
    .io_enq_ready(input__io_enq_ready),
    .io_enq_valid(input__io_enq_valid),
    .io_enq_bits_inst_event(input__io_enq_bits_inst_event),
    .io_enq_bits_inst_addr(input__io_enq_bits_inst_addr),
    .io_enq_bits_inst_data(input__io_enq_bits_inst_data),
    .io_enq_bits_tbeOut_state_state(input__io_enq_bits_tbeOut_state_state),
    .io_enq_bits_tbeOut_way(input__io_enq_bits_tbeOut_way),
    .io_enq_bits_tbeOut_fields_0(input__io_enq_bits_tbeOut_fields_0),
    .io_deq_ready(input__io_deq_ready),
    .io_deq_valid(input__io_deq_valid),
    .io_deq_bits_inst_event(input__io_deq_bits_inst_event),
    .io_deq_bits_inst_addr(input__io_deq_bits_inst_addr),
    .io_deq_bits_inst_data(input__io_deq_bits_inst_data),
    .io_deq_bits_tbeOut_state_state(input__io_deq_bits_tbeOut_state_state),
    .io_deq_bits_tbeOut_way(input__io_deq_bits_tbeOut_way),
    .io_deq_bits_tbeOut_fields_0(input__io_deq_bits_tbeOut_fields_0)
  );
  Queue_8 respPortQueue_0 ( // @[programmableCache.scala 93:27]
    .clock(respPortQueue_0_clock),
    .reset(respPortQueue_0_reset),
    .io_enq_ready(respPortQueue_0_io_enq_ready),
    .io_enq_valid(respPortQueue_0_io_enq_valid),
    .io_enq_bits_event(respPortQueue_0_io_enq_bits_event),
    .io_enq_bits_addr(respPortQueue_0_io_enq_bits_addr),
    .io_enq_bits_data(respPortQueue_0_io_enq_bits_data),
    .io_deq_ready(respPortQueue_0_io_deq_ready),
    .io_deq_valid(respPortQueue_0_io_deq_valid),
    .io_deq_bits_event(respPortQueue_0_io_deq_bits_event),
    .io_deq_bits_addr(respPortQueue_0_io_deq_bits_addr),
    .io_deq_bits_data(respPortQueue_0_io_deq_bits_data)
  );
  Queue_8 respPortQueue_1 ( // @[programmableCache.scala 93:27]
    .clock(respPortQueue_1_clock),
    .reset(respPortQueue_1_reset),
    .io_enq_ready(respPortQueue_1_io_enq_ready),
    .io_enq_valid(respPortQueue_1_io_enq_valid),
    .io_enq_bits_event(respPortQueue_1_io_enq_bits_event),
    .io_enq_bits_addr(respPortQueue_1_io_enq_bits_addr),
    .io_enq_bits_data(respPortQueue_1_io_enq_bits_data),
    .io_deq_ready(respPortQueue_1_io_deq_ready),
    .io_deq_valid(respPortQueue_1_io_deq_valid),
    .io_deq_bits_event(respPortQueue_1_io_deq_bits_event),
    .io_deq_bits_addr(respPortQueue_1_io_deq_bits_addr),
    .io_deq_bits_data(respPortQueue_1_io_deq_bits_data)
  );
  Queue_8 feedbackInQueue_0 ( // @[programmableCache.scala 98:27]
    .clock(feedbackInQueue_0_clock),
    .reset(feedbackInQueue_0_reset),
    .io_enq_ready(feedbackInQueue_0_io_enq_ready),
    .io_enq_valid(feedbackInQueue_0_io_enq_valid),
    .io_enq_bits_event(feedbackInQueue_0_io_enq_bits_event),
    .io_enq_bits_addr(feedbackInQueue_0_io_enq_bits_addr),
    .io_enq_bits_data(feedbackInQueue_0_io_enq_bits_data),
    .io_deq_ready(feedbackInQueue_0_io_deq_ready),
    .io_deq_valid(feedbackInQueue_0_io_deq_valid),
    .io_deq_bits_event(feedbackInQueue_0_io_deq_bits_event),
    .io_deq_bits_addr(feedbackInQueue_0_io_deq_bits_addr),
    .io_deq_bits_data(feedbackInQueue_0_io_deq_bits_data)
  );
  Queue_11 probeWay ( // @[programmableCache.scala 102:26]
    .clock(probeWay_clock),
    .reset(probeWay_reset),
    .io_enq_ready(probeWay_io_enq_ready),
    .io_enq_valid(probeWay_io_enq_valid),
    .io_enq_bits(probeWay_io_enq_bits),
    .io_deq_ready(probeWay_io_deq_ready),
    .io_deq_valid(probeWay_io_deq_valid),
    .io_deq_bits(probeWay_io_deq_bits)
  );
  Queue_8 feedbackOutQueue ( // @[programmableCache.scala 159:34]
    .clock(feedbackOutQueue_clock),
    .reset(feedbackOutQueue_reset),
    .io_enq_ready(feedbackOutQueue_io_enq_ready),
    .io_enq_valid(feedbackOutQueue_io_enq_valid),
    .io_enq_bits_event(feedbackOutQueue_io_enq_bits_event),
    .io_enq_bits_addr(feedbackOutQueue_io_enq_bits_addr),
    .io_enq_bits_data(feedbackOutQueue_io_enq_bits_data),
    .io_deq_ready(feedbackOutQueue_io_deq_ready),
    .io_deq_valid(feedbackOutQueue_io_deq_valid),
    .io_deq_bits_event(feedbackOutQueue_io_deq_bits_event),
    .io_deq_bits_addr(feedbackOutQueue_io_deq_bits_addr),
    .io_deq_bits_data(feedbackOutQueue_io_deq_bits_data)
  );
  Queue_13 routineQueue ( // @[programmableCache.scala 160:30]
    .clock(routineQueue_clock),
    .reset(routineQueue_reset),
    .io_enq_ready(routineQueue_io_enq_ready),
    .io_enq_valid(routineQueue_io_enq_valid),
    .io_enq_bits(routineQueue_io_enq_bits),
    .io_deq_ready(routineQueue_io_deq_ready),
    .io_deq_valid(routineQueue_io_deq_valid),
    .io_deq_bits(routineQueue_io_deq_bits)
  );
  Queue_14 actionReg_0 ( // @[programmableCache.scala 163:32]
    .clock(actionReg_0_clock),
    .reset(actionReg_0_reset),
    .io_enq_ready(actionReg_0_io_enq_ready),
    .io_enq_valid(actionReg_0_io_enq_valid),
    .io_enq_bits_addr(actionReg_0_io_enq_bits_addr),
    .io_enq_bits_way(actionReg_0_io_enq_bits_way),
    .io_enq_bits_data(actionReg_0_io_enq_bits_data),
    .io_enq_bits_replaceWay(actionReg_0_io_enq_bits_replaceWay),
    .io_enq_bits_tbeFields_0(actionReg_0_io_enq_bits_tbeFields_0),
    .io_enq_bits_action_signals(actionReg_0_io_enq_bits_action_signals),
    .io_enq_bits_action_actionType(actionReg_0_io_enq_bits_action_actionType),
    .io_deq_ready(actionReg_0_io_deq_ready),
    .io_deq_valid(actionReg_0_io_deq_valid),
    .io_deq_bits_addr(actionReg_0_io_deq_bits_addr),
    .io_deq_bits_way(actionReg_0_io_deq_bits_way),
    .io_deq_bits_data(actionReg_0_io_deq_bits_data),
    .io_deq_bits_replaceWay(actionReg_0_io_deq_bits_replaceWay),
    .io_deq_bits_tbeFields_0(actionReg_0_io_deq_bits_tbeFields_0),
    .io_deq_bits_action_signals(actionReg_0_io_deq_bits_action_signals),
    .io_deq_bits_action_actionType(actionReg_0_io_deq_bits_action_actionType)
  );
  MIMOQueue mimoQ ( // @[programmableCache.scala 167:24]
    .clock(mimoQ_clock),
    .reset(mimoQ_reset),
    .io_enq_ready(mimoQ_io_enq_ready),
    .io_enq_valid(mimoQ_io_enq_valid),
    .io_enq_bits_0_way(mimoQ_io_enq_bits_0_way),
    .io_enq_bits_0_addr(mimoQ_io_enq_bits_0_addr),
    .io_enq_bits_1_way(mimoQ_io_enq_bits_1_way),
    .io_enq_bits_1_addr(mimoQ_io_enq_bits_1_addr),
    .io_deq_valid(mimoQ_io_deq_valid),
    .io_deq_bits_0_way(mimoQ_io_deq_bits_0_way),
    .io_deq_bits_0_addr(mimoQ_io_deq_bits_0_addr),
    .io_count(mimoQ_io_count)
  );
  Computation compUnit_0 ( // @[programmableCache.scala 171:27]
    .clock(compUnit_0_clock),
    .reset(compUnit_0_reset),
    .io_instruction_valid(compUnit_0_io_instruction_valid),
    .io_instruction_bits(compUnit_0_io_instruction_bits),
    .io_clear(compUnit_0_io_clear),
    .io_op1_valid(compUnit_0_io_op1_valid),
    .io_op1_bits(compUnit_0_io_op1_bits),
    .io_op2_valid(compUnit_0_io_op2_valid),
    .io_op2_bits(compUnit_0_io_op2_bits),
    .io_pc(compUnit_0_io_pc),
    .io_reg_file_0(compUnit_0_io_reg_file_0),
    .io_reg_file_1(compUnit_0_io_reg_file_1),
    .io_reg_file_2(compUnit_0_io_reg_file_2),
    .io_reg_file_3(compUnit_0_io_reg_file_3)
  );
  Mux3 compUnitInput1_0 ( // @[programmableCache.scala 176:30]
    .io_in_hardCoded(compUnitInput1_0_io_in_hardCoded),
    .io_in_data(compUnitInput1_0_io_in_data),
    .io_in_tbe(compUnitInput1_0_io_in_tbe),
    .io_in_select(compUnitInput1_0_io_in_select),
    .io_out_valid(compUnitInput1_0_io_out_valid),
    .io_out_bits(compUnitInput1_0_io_out_bits)
  );
  Mux3 compUnitInput2_0 ( // @[programmableCache.scala 182:30]
    .io_in_hardCoded(compUnitInput2_0_io_in_hardCoded),
    .io_in_data(compUnitInput2_0_io_in_data),
    .io_in_tbe(compUnitInput2_0_io_in_tbe),
    .io_in_select(compUnitInput2_0_io_in_select),
    .io_out_valid(compUnitInput2_0_io_out_valid),
    .io_out_bits(compUnitInput2_0_io_out_bits)
  );
  assign io_in_cpu_ready = _T_50 & _T_72; // @[programmableCache.scala 234:37 programmableCache.scala 274:28]
  assign io_in_memCtrl_ready = _T_50 & _T_69; // @[programmableCache.scala 235:41 programmableCache.scala 273:28]
  assign io_in_otherNodes_ready = _T_50 & _T_75; // @[programmableCache.scala 233:44 programmableCache.scala 275:28]
  assign io_out_req_valid = outReqArbiter_io_out_valid; // @[programmableCache.scala 484:22]
  assign io_out_req_bits_req_addr = outReqArbiter_io_out_bits_req_addr; // @[programmableCache.scala 482:30]
  assign io_out_req_bits_req_data = outReqArbiter_io_out_bits_req_data; // @[programmableCache.scala 481:30]
  assign io_out_resp_valid = outRespArbiter_io_out_valid; // @[programmableCache.scala 510:27]
  assign io_out_resp_bits_addr = outRespArbiter_io_out_bits_addr; // @[programmableCache.scala 509:27]
  assign _T_242_0 = _T_70;
  assign _T_236_0 = _T_50;
  assign _T_249_0 = probeStart;
  assign hitLD_0 = hitLD;
  assign missLD_0 = missLD;
  assign _T_239_0 = _T_73;
  assign cache_clock = clock;
  assign cache_reset = reset;
  assign cache_io_cpu_0_req_valid = actionReg_0_io_deq_ready & actionReg_0_io_deq_valid; // @[programmableCache.scala 454:35]
  assign cache_io_cpu_0_req_bits_addr = actionReg_0_io_deq_bits_addr; // @[programmableCache.scala 453:39]
  assign cache_io_cpu_0_req_bits_data = actionReg_0_io_deq_bits_data; // @[programmableCache.scala 455:39]
  assign cache_io_cpu_0_req_bits_command = isCacheAction_0 ? actionReg_0_io_deq_bits_action_signals : 28'h0; // @[programmableCache.scala 452:42]
  assign cache_io_cpu_0_req_bits_way = actionReg_0_io_deq_bits_way; // @[programmableCache.scala 451:38]
  assign cache_io_cpu_0_req_bits_replaceWay = actionReg_0_io_deq_bits_replaceWay; // @[programmableCache.scala 456:45]
  assign cache_io_probe_req_valid = _T_50 & _T_54; // @[programmableCache.scala 462:30]
  assign cache_io_probe_req_bits_addr = probeStart ? instruction_bits_addr : 32'h0; // @[programmableCache.scala 460:34]
  assign cache_io_probe_req_bits_command = probeStart ? 28'hb : 28'h0; // @[programmableCache.scala 459:37]
  assign cache_io_bipassLD_in_valid = mimoQ_io_deq_valid & _T_204; // @[programmableCache.scala 465:32]
  assign cache_io_bipassLD_in_bits_addr = mimoQ_io_deq_bits_0_addr; // @[programmableCache.scala 466:37]
  assign cache_io_bipassLD_in_bits_way = {{1'd0}, mimoQ_io_deq_bits_0_way}; // @[programmableCache.scala 467:35]
  assign tbe_clock = clock;
  assign tbe_reset = reset;
  assign tbe_io_write_0_valid = isTBEAction_0 | isStateAction_0; // @[programmableCache.scala 303:31]
  assign tbe_io_write_0_bits_addr = {{32'd0}, actionReg_0_io_deq_bits_addr}; // @[programmableCache.scala 300:35]
  assign tbe_io_write_0_bits_command = isStateAction_0 ? 2'h3 : tbeAction_0; // @[programmableCache.scala 299:38]
  assign tbe_io_write_0_bits_mask = isStateAction_0 | maskField_0; // @[programmableCache.scala 302:35]
  assign tbe_io_write_0_bits_inputTBE_state_state = isStateAction_0 ? tbeAction_0 : 2'h0; // @[programmableCache.scala 301:39]
  assign tbe_io_write_0_bits_inputTBE_way = {{1'd0}, actionReg_0_io_deq_bits_way}; // @[programmableCache.scala 301:39]
  assign tbe_io_write_0_bits_inputTBE_fields_0 = _T_96 ? tbeFieldUpdateSrc_0 : 32'h0; // @[programmableCache.scala 301:39]
  assign tbe_io_read_valid = inputArbiter_io_out_valid; // @[programmableCache.scala 291:23]
  assign tbe_io_read_bits_addr = {{32'd0}, inputArbiter_io_out_bits_addr}; // @[programmableCache.scala 292:27]
  assign lockMem_clock = clock;
  assign lockMem_reset = reset;
  assign lockMem_io_lock_in_valid = instruction_ready & instruction_valid; // @[programmableCache.scala 314:35]
  assign lockMem_io_lock_in_bits_addr = inputArbiter_io_out_bits_addr; // @[programmableCache.scala 313:35]
  assign lockMem_io_probe_in_valid = inputArbiter_io_out_valid; // @[programmableCache.scala 309:35]
  assign lockMem_io_probe_in_bits_addr = inputArbiter_io_out_bits_addr; // @[programmableCache.scala 308:35]
  assign lockMem_io_unLock_0_in_valid = _T_149 & actionReg_0_io_deq_valid; // @[programmableCache.scala 322:39]
  assign lockMem_io_unLock_0_in_bits_addr = actionReg_0_io_deq_bits_addr; // @[programmableCache.scala 320:43]
  assign stateMem_clock = clock;
  assign stateMem_reset = reset;
  assign stateMem_io_in_0_valid = _T_149 & actionReg_0_io_deq_valid; // @[programmableCache.scala 332:33]
  assign stateMem_io_in_0_bits_state_state = isStateAction_0 ? tbeAction_0 : 2'h0; // @[programmableCache.scala 330:38]
  assign stateMem_io_in_0_bits_addr = actionReg_0_io_deq_bits_addr; // @[programmableCache.scala 329:37]
  assign stateMem_io_in_0_bits_way = actionReg_0_io_deq_bits_way; // @[programmableCache.scala 331:36]
  assign stateMem_io_in_1_valid = input__io_deq_ready & input__io_deq_valid; // @[programmableCache.scala 339:34]
  assign stateMem_io_in_1_bits_addr = input__io_deq_bits_inst_addr; // @[programmableCache.scala 336:38]
  assign stateMem_io_in_1_bits_way = probeWay_io_deq_bits; // @[programmableCache.scala 338:37]
  assign pc_clock = clock;
  assign pc_reset = reset;
  assign pc_io_write_valid = routineQueue_io_deq_ready & routineQueue_io_deq_valid; // @[programmableCache.scala 445:23]
  assign pc_io_write_bits_addr = inputToPC_addr; // @[programmableCache.scala 437:27]
  assign pc_io_write_bits_way = wayInputCache[1:0]; // @[programmableCache.scala 438:26]
  assign pc_io_write_bits_data = inputToPC_data; // @[programmableCache.scala 442:27]
  assign pc_io_write_bits_replaceWay = replaceWayInputCache[1:0]; // @[programmableCache.scala 440:33]
  assign pc_io_write_bits_tbeFields_0 = tbeFields_0; // @[programmableCache.scala 439:32]
  assign pc_io_write_bits_pc = routineQueue_io_deq_bits; // @[programmableCache.scala 441:25]
  assign pc_io_read_0_in_bits_data_way = _T_170[1:0]; // @[programmableCache.scala 392:40]
  assign pc_io_read_0_in_bits_data_pc = firstLineNextRoutine_0 ? pcWire_0_pc : _T_165; // @[programmableCache.scala 394:39]
  assign pc_io_read_0_in_bits_data_valid = ~firstLineNextRoutine_0; // @[programmableCache.scala 397:42]
  assign inputArbiter_clock = clock;
  assign inputArbiter_io_in_0_valid = io_in_memCtrl_valid; // @[programmableCache.scala 235:41]
  assign inputArbiter_io_in_0_bits_event = io_in_memCtrl_bits_event; // @[programmableCache.scala 235:41]
  assign inputArbiter_io_in_0_bits_addr = io_in_memCtrl_bits_addr; // @[programmableCache.scala 235:41]
  assign inputArbiter_io_in_0_bits_data = io_in_memCtrl_bits_data; // @[programmableCache.scala 235:41]
  assign inputArbiter_io_in_1_valid = feedbackOutQueue_io_deq_valid; // @[programmableCache.scala 236:42]
  assign inputArbiter_io_in_1_bits_event = feedbackOutQueue_io_deq_bits_event; // @[programmableCache.scala 236:42]
  assign inputArbiter_io_in_1_bits_addr = feedbackOutQueue_io_deq_bits_addr; // @[programmableCache.scala 236:42]
  assign inputArbiter_io_in_1_bits_data = feedbackOutQueue_io_deq_bits_data; // @[programmableCache.scala 236:42]
  assign inputArbiter_io_in_2_valid = io_in_otherNodes_valid; // @[programmableCache.scala 233:44]
  assign inputArbiter_io_in_2_bits_event = io_in_otherNodes_bits_event; // @[programmableCache.scala 233:44]
  assign inputArbiter_io_in_2_bits_addr = io_in_otherNodes_bits_addr; // @[programmableCache.scala 233:44]
  assign inputArbiter_io_in_2_bits_data = io_in_otherNodes_bits_data; // @[programmableCache.scala 233:44]
  assign inputArbiter_io_in_3_valid = io_in_cpu_valid; // @[programmableCache.scala 234:37]
  assign inputArbiter_io_in_3_bits_event = io_in_cpu_bits_event; // @[programmableCache.scala 234:37]
  assign inputArbiter_io_in_3_bits_addr = io_in_cpu_bits_addr; // @[programmableCache.scala 234:37]
  assign inputArbiter_io_in_3_bits_data = io_in_cpu_bits_data; // @[programmableCache.scala 234:37]
  assign inputArbiter_io_out_ready = _T_83 & _T_84; // @[programmableCache.scala 246:17]
  assign outReqArbiter_io_in_0_valid = _T_151 & actionReg_0_io_deq_valid; // @[programmableCache.scala 477:38]
  assign outReqArbiter_io_in_0_bits_req_addr = actionReg_0_io_deq_bits_addr; // @[programmableCache.scala 474:46]
  assign outReqArbiter_io_in_0_bits_req_data = actionReg_0_io_deq_bits_action_signals[0] ? _GEN_375 : {{32'd0}, actionReg_0_io_deq_bits_addr}; // @[programmableCache.scala 473:45]
  assign outRespArbiter_io_in_0_valid = respPortQueue_0_io_deq_valid; // @[programmableCache.scala 503:44]
  assign outRespArbiter_io_in_0_bits_addr = respPortQueue_0_io_deq_bits_addr; // @[programmableCache.scala 502:44]
  assign outRespArbiter_io_in_1_valid = respPortQueue_1_io_deq_valid; // @[programmableCache.scala 503:44]
  assign outRespArbiter_io_in_1_bits_addr = respPortQueue_1_io_deq_bits_addr; // @[programmableCache.scala 502:44]
  assign feedbackArbiter_io_in_0_valid = feedbackInQueue_0_io_deq_valid; // @[programmableCache.scala 240:34]
  assign feedbackArbiter_io_in_0_bits_event = feedbackInQueue_0_io_deq_bits_event; // @[programmableCache.scala 240:34]
  assign feedbackArbiter_io_in_0_bits_addr = feedbackInQueue_0_io_deq_bits_addr; // @[programmableCache.scala 240:34]
  assign feedbackArbiter_io_in_0_bits_data = feedbackInQueue_0_io_deq_bits_data; // @[programmableCache.scala 240:34]
  assign feedbackArbiter_io_out_ready = feedbackOutQueue_io_enq_ready; // @[programmableCache.scala 238:29]
  assign input__clock = clock;
  assign input__reset = reset;
  assign input__io_enq_valid = _T_89 & _T_84; // @[programmableCache.scala 280:24]
  assign input__io_enq_bits_inst_event = inputArbiter_io_out_bits_event; // @[programmableCache.scala 282:28]
  assign input__io_enq_bits_inst_addr = inputArbiter_io_out_bits_addr; // @[programmableCache.scala 282:28]
  assign input__io_enq_bits_inst_data = inputArbiter_io_out_bits_data; // @[programmableCache.scala 282:28]
  assign input__io_enq_bits_tbeOut_state_state = tbe_io_outputTBE_bits_state_state; // @[programmableCache.scala 283:30]
  assign input__io_enq_bits_tbeOut_way = tbe_io_outputTBE_bits_way; // @[programmableCache.scala 283:30]
  assign input__io_enq_bits_tbeOut_fields_0 = tbe_io_outputTBE_bits_fields_0; // @[programmableCache.scala 283:30]
  assign input__io_deq_ready = routineQueue_io_enq_ready; // @[programmableCache.scala 345:24]
  assign respPortQueue_0_clock = clock;
  assign respPortQueue_0_reset = reset;
  assign respPortQueue_0_io_enq_valid = cache_io_cpu_0_resp_valid & cache_io_cpu_0_resp_bits_iswrite; // @[programmableCache.scala 491:44]
  assign respPortQueue_0_io_enq_bits_event = 2'h0; // @[programmableCache.scala 489:44]
  assign respPortQueue_0_io_enq_bits_addr = actionReg_0_io_deq_bits_addr; // @[programmableCache.scala 490:44]
  assign respPortQueue_0_io_enq_bits_data = 64'h0; // @[programmableCache.scala 488:44]
  assign respPortQueue_0_io_deq_ready = 1'h1; // @[programmableCache.scala 504:39]
  assign respPortQueue_1_clock = clock;
  assign respPortQueue_1_reset = reset;
  assign respPortQueue_1_io_enq_valid = cache_io_bipassLD_out_valid; // @[programmableCache.scala 497:45]
  assign respPortQueue_1_io_enq_bits_event = 2'h0; // @[programmableCache.scala 495:45]
  assign respPortQueue_1_io_enq_bits_addr = _T_211; // @[programmableCache.scala 496:45]
  assign respPortQueue_1_io_enq_bits_data = cache_io_bipassLD_out_bits_data; // @[programmableCache.scala 494:45]
  assign respPortQueue_1_io_deq_ready = 1'h1; // @[programmableCache.scala 504:39]
  assign feedbackInQueue_0_clock = clock;
  assign feedbackInQueue_0_reset = reset;
  assign feedbackInQueue_0_io_enq_valid = _T_147 & actionReg_0_io_deq_valid; // @[programmableCache.scala 244:41]
  assign feedbackInQueue_0_io_enq_bits_event = actionReg_0_io_deq_bits_action_signals[13:12]; // @[programmableCache.scala 242:46]
  assign feedbackInQueue_0_io_enq_bits_addr = actionReg_0_io_deq_bits_addr + _GEN_376; // @[programmableCache.scala 241:45]
  assign feedbackInQueue_0_io_enq_bits_data = actionReg_0_io_deq_bits_data - _GEN_377; // @[programmableCache.scala 243:45]
  assign feedbackInQueue_0_io_deq_ready = feedbackArbiter_io_in_0_ready; // @[programmableCache.scala 240:34]
  assign probeWay_clock = clock;
  assign probeWay_reset = reset;
  assign probeWay_io_enq_valid = cache_io_probe_resp_valid; // @[programmableCache.scala 211:29]
  assign probeWay_io_enq_bits = cache_io_probe_resp_bits_way; // @[programmableCache.scala 210:28]
  assign probeWay_io_deq_ready = input__io_deq_ready & input__io_deq_valid; // @[programmableCache.scala 221:29]
  assign feedbackOutQueue_clock = clock;
  assign feedbackOutQueue_reset = reset;
  assign feedbackOutQueue_io_enq_valid = feedbackArbiter_io_out_valid; // @[programmableCache.scala 238:29]
  assign feedbackOutQueue_io_enq_bits_event = feedbackArbiter_io_out_bits_event; // @[programmableCache.scala 238:29]
  assign feedbackOutQueue_io_enq_bits_addr = feedbackArbiter_io_out_bits_addr; // @[programmableCache.scala 238:29]
  assign feedbackOutQueue_io_enq_bits_data = feedbackArbiter_io_out_bits_data; // @[programmableCache.scala 238:29]
  assign feedbackOutQueue_io_deq_ready = inputArbiter_io_in_1_ready; // @[programmableCache.scala 236:42]
  assign routineQueue_clock = clock;
  assign routineQueue_reset = reset;
  assign routineQueue_io_enq_valid = input__io_deq_valid; // @[programmableCache.scala 344:31]
  assign routineQueue_io_enq_bits = {{11'd0}, _GEN_15}; // @[programmableCache.scala 343:30]
  assign routineQueue_io_deq_ready = ~pc_io_isFull; // @[programmableCache.scala 346:31]
  assign actionReg_0_clock = clock;
  assign actionReg_0_reset = reset;
  assign actionReg_0_io_enq_valid = pc_io_read_0_out_bits_valid; // @[programmableCache.scala 432:35]
  assign actionReg_0_io_enq_bits_addr = pc_io_read_0_out_bits_addr; // @[programmableCache.scala 379:39]
  assign actionReg_0_io_enq_bits_way = _T_159[1:0]; // @[programmableCache.scala 380:39]
  assign actionReg_0_io_enq_bits_data = pc_io_read_0_out_bits_data; // @[programmableCache.scala 381:39]
  assign actionReg_0_io_enq_bits_replaceWay = pc_io_read_0_out_bits_replaceWay; // @[programmableCache.scala 382:45]
  assign actionReg_0_io_enq_bits_tbeFields_0 = pc_io_read_0_out_bits_tbeFields_0; // @[programmableCache.scala 384:44]
  assign actionReg_0_io_enq_bits_action_signals = _GEN_307[27:0]; // @[programmableCache.scala 377:49]
  assign actionReg_0_io_enq_bits_action_actionType = _GEN_307[31:28]; // @[programmableCache.scala 378:52]
  assign actionReg_0_io_deq_ready = 1'h1; // @[programmableCache.scala 431:35]
  assign mimoQ_clock = clock;
  assign mimoQ_reset = reset;
  assign mimoQ_io_enq_valid = cache_io_probe_multiWay_valid; // @[programmableCache.scala 216:24]
  assign mimoQ_io_enq_bits_0_way = cache_io_probe_multiWay_bits_way_0; // @[programmableCache.scala 213:56]
  assign mimoQ_io_enq_bits_0_addr = cache_io_probe_multiWay_bits_addr; // @[programmableCache.scala 214:57]
  assign mimoQ_io_enq_bits_1_way = cache_io_probe_multiWay_bits_way_1; // @[programmableCache.scala 213:56]
  assign mimoQ_io_enq_bits_1_addr = cache_io_probe_multiWay_bits_addr; // @[programmableCache.scala 214:57]
  assign compUnit_0_clock = clock;
  assign compUnit_0_reset = reset;
  assign compUnit_0_io_instruction_valid = _T_153 & actionReg_0_io_deq_valid; // @[programmableCache.scala 429:42]
  assign compUnit_0_io_instruction_bits = actionReg_0_io_deq_bits_action_signals; // @[programmableCache.scala 428:41]
  assign compUnit_0_io_clear = _T_149 & actionReg_0_io_deq_valid; // @[programmableCache.scala 375:30]
  assign compUnit_0_io_op1_valid = compUnitInput1_0_io_out_valid; // @[programmableCache.scala 419:28]
  assign compUnit_0_io_op1_bits = compUnitInput1_0_io_out_bits; // @[programmableCache.scala 419:28]
  assign compUnit_0_io_op2_valid = compUnitInput2_0_io_out_valid; // @[programmableCache.scala 426:28]
  assign compUnit_0_io_op2_bits = compUnitInput2_0_io_out_bits; // @[programmableCache.scala 426:28]
  assign compUnitInput1_0_io_in_hardCoded = 64'h0;
  assign compUnitInput1_0_io_in_data = 64'h0;
  assign compUnitInput1_0_io_in_tbe = {{32'd0}, actionReg_0_io_deq_bits_addr}; // @[programmableCache.scala 416:38]
  assign compUnitInput1_0_io_in_select = {{1'd0}, actionReg_0_io_deq_bits_action_actionType[0]}; // @[programmableCache.scala 418:40]
  assign compUnitInput2_0_io_in_hardCoded = {{48'd0}, actionReg_0_io_deq_bits_action_signals[27:12]}; // @[programmableCache.scala 424:43]
  assign compUnitInput2_0_io_in_data = actionReg_0_io_deq_bits_data; // @[programmableCache.scala 422:38]
  assign compUnitInput2_0_io_in_tbe = {{32'd0}, actionReg_0_io_deq_bits_tbeFields_0}; // @[programmableCache.scala 423:38]
  assign compUnitInput2_0_io_in_select = actionReg_0_io_deq_bits_action_actionType[2:1]; // @[programmableCache.scala 425:40]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  instUsed = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  replStateReg_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  replStateReg_1 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  replStateReg_2 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  replStateReg_3 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  replStateReg_4 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  replStateReg_5 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  replStateReg_6 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  replStateReg_7 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  replStateReg_8 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  replStateReg_9 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  replStateReg_10 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  replStateReg_11 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  replStateReg_12 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  replStateReg_13 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  replStateReg_14 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  replStateReg_15 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  replStateReg_16 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  replStateReg_17 = _RAND_18[0:0];
  _RAND_19 = {1{`RANDOM}};
  replStateReg_18 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  replStateReg_19 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  replStateReg_20 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  replStateReg_21 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  replStateReg_22 = _RAND_23[0:0];
  _RAND_24 = {1{`RANDOM}};
  replStateReg_23 = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  replStateReg_24 = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  replStateReg_25 = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  replStateReg_26 = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  replStateReg_27 = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  replStateReg_28 = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  replStateReg_29 = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  replStateReg_30 = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  replStateReg_31 = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  replStateReg_32 = _RAND_33[0:0];
  _RAND_34 = {1{`RANDOM}};
  replStateReg_33 = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  replStateReg_34 = _RAND_35[0:0];
  _RAND_36 = {1{`RANDOM}};
  replStateReg_35 = _RAND_36[0:0];
  _RAND_37 = {1{`RANDOM}};
  replStateReg_36 = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  replStateReg_37 = _RAND_38[0:0];
  _RAND_39 = {1{`RANDOM}};
  replStateReg_38 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  replStateReg_39 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  replStateReg_40 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  replStateReg_41 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  replStateReg_42 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  replStateReg_43 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  replStateReg_44 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  replStateReg_45 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  replStateReg_46 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  replStateReg_47 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  replStateReg_48 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  replStateReg_49 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  replStateReg_50 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  replStateReg_51 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  replStateReg_52 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  replStateReg_53 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  replStateReg_54 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  replStateReg_55 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  replStateReg_56 = _RAND_57[0:0];
  _RAND_58 = {1{`RANDOM}};
  replStateReg_57 = _RAND_58[0:0];
  _RAND_59 = {1{`RANDOM}};
  replStateReg_58 = _RAND_59[0:0];
  _RAND_60 = {1{`RANDOM}};
  replStateReg_59 = _RAND_60[0:0];
  _RAND_61 = {1{`RANDOM}};
  replStateReg_60 = _RAND_61[0:0];
  _RAND_62 = {1{`RANDOM}};
  replStateReg_61 = _RAND_62[0:0];
  _RAND_63 = {1{`RANDOM}};
  replStateReg_62 = _RAND_63[0:0];
  _RAND_64 = {1{`RANDOM}};
  replStateReg_63 = _RAND_64[0:0];
  _RAND_65 = {1{`RANDOM}};
  wayInputCache = _RAND_65[2:0];
  _RAND_66 = {1{`RANDOM}};
  tbeFields_0 = _RAND_66[31:0];
  _RAND_67 = {1{`RANDOM}};
  _T_139 = _RAND_67[1:0];
  _RAND_68 = {1{`RANDOM}};
  inputToPC_addr = _RAND_68[31:0];
  _RAND_69 = {2{`RANDOM}};
  inputToPC_data = _RAND_69[63:0];
  _RAND_70 = {1{`RANDOM}};
  _T_211 = _RAND_70[31:0];
  _RAND_71 = {1{`RANDOM}};
  _T_213 = _RAND_71[1:0];
  _RAND_72 = {1{`RANDOM}};
  _T_214 = _RAND_72[31:0];
  _RAND_73 = {2{`RANDOM}};
  _T_215 = _RAND_73[63:0];
  _RAND_74 = {1{`RANDOM}};
  _T_218 = _RAND_74[1:0];
  _RAND_75 = {1{`RANDOM}};
  _T_226 = _RAND_75[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      instUsed <= 1'h0;
    end else begin
      instUsed <= _T_81;
    end
    if (reset) begin
      replStateReg_0 <= 1'h0;
    end else if (missLD) begin
      if (6'h0 == addrReplacer[5:0]) begin
        replStateReg_0 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_1 <= 1'h0;
    end else if (missLD) begin
      if (6'h1 == addrReplacer[5:0]) begin
        replStateReg_1 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_2 <= 1'h0;
    end else if (missLD) begin
      if (6'h2 == addrReplacer[5:0]) begin
        replStateReg_2 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_3 <= 1'h0;
    end else if (missLD) begin
      if (6'h3 == addrReplacer[5:0]) begin
        replStateReg_3 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_4 <= 1'h0;
    end else if (missLD) begin
      if (6'h4 == addrReplacer[5:0]) begin
        replStateReg_4 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_5 <= 1'h0;
    end else if (missLD) begin
      if (6'h5 == addrReplacer[5:0]) begin
        replStateReg_5 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_6 <= 1'h0;
    end else if (missLD) begin
      if (6'h6 == addrReplacer[5:0]) begin
        replStateReg_6 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_7 <= 1'h0;
    end else if (missLD) begin
      if (6'h7 == addrReplacer[5:0]) begin
        replStateReg_7 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_8 <= 1'h0;
    end else if (missLD) begin
      if (6'h8 == addrReplacer[5:0]) begin
        replStateReg_8 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_9 <= 1'h0;
    end else if (missLD) begin
      if (6'h9 == addrReplacer[5:0]) begin
        replStateReg_9 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_10 <= 1'h0;
    end else if (missLD) begin
      if (6'ha == addrReplacer[5:0]) begin
        replStateReg_10 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_11 <= 1'h0;
    end else if (missLD) begin
      if (6'hb == addrReplacer[5:0]) begin
        replStateReg_11 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_12 <= 1'h0;
    end else if (missLD) begin
      if (6'hc == addrReplacer[5:0]) begin
        replStateReg_12 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_13 <= 1'h0;
    end else if (missLD) begin
      if (6'hd == addrReplacer[5:0]) begin
        replStateReg_13 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_14 <= 1'h0;
    end else if (missLD) begin
      if (6'he == addrReplacer[5:0]) begin
        replStateReg_14 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_15 <= 1'h0;
    end else if (missLD) begin
      if (6'hf == addrReplacer[5:0]) begin
        replStateReg_15 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_16 <= 1'h0;
    end else if (missLD) begin
      if (6'h10 == addrReplacer[5:0]) begin
        replStateReg_16 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_17 <= 1'h0;
    end else if (missLD) begin
      if (6'h11 == addrReplacer[5:0]) begin
        replStateReg_17 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_18 <= 1'h0;
    end else if (missLD) begin
      if (6'h12 == addrReplacer[5:0]) begin
        replStateReg_18 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_19 <= 1'h0;
    end else if (missLD) begin
      if (6'h13 == addrReplacer[5:0]) begin
        replStateReg_19 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_20 <= 1'h0;
    end else if (missLD) begin
      if (6'h14 == addrReplacer[5:0]) begin
        replStateReg_20 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_21 <= 1'h0;
    end else if (missLD) begin
      if (6'h15 == addrReplacer[5:0]) begin
        replStateReg_21 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_22 <= 1'h0;
    end else if (missLD) begin
      if (6'h16 == addrReplacer[5:0]) begin
        replStateReg_22 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_23 <= 1'h0;
    end else if (missLD) begin
      if (6'h17 == addrReplacer[5:0]) begin
        replStateReg_23 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_24 <= 1'h0;
    end else if (missLD) begin
      if (6'h18 == addrReplacer[5:0]) begin
        replStateReg_24 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_25 <= 1'h0;
    end else if (missLD) begin
      if (6'h19 == addrReplacer[5:0]) begin
        replStateReg_25 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_26 <= 1'h0;
    end else if (missLD) begin
      if (6'h1a == addrReplacer[5:0]) begin
        replStateReg_26 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_27 <= 1'h0;
    end else if (missLD) begin
      if (6'h1b == addrReplacer[5:0]) begin
        replStateReg_27 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_28 <= 1'h0;
    end else if (missLD) begin
      if (6'h1c == addrReplacer[5:0]) begin
        replStateReg_28 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_29 <= 1'h0;
    end else if (missLD) begin
      if (6'h1d == addrReplacer[5:0]) begin
        replStateReg_29 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_30 <= 1'h0;
    end else if (missLD) begin
      if (6'h1e == addrReplacer[5:0]) begin
        replStateReg_30 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_31 <= 1'h0;
    end else if (missLD) begin
      if (6'h1f == addrReplacer[5:0]) begin
        replStateReg_31 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_32 <= 1'h0;
    end else if (missLD) begin
      if (6'h20 == addrReplacer[5:0]) begin
        replStateReg_32 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_33 <= 1'h0;
    end else if (missLD) begin
      if (6'h21 == addrReplacer[5:0]) begin
        replStateReg_33 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_34 <= 1'h0;
    end else if (missLD) begin
      if (6'h22 == addrReplacer[5:0]) begin
        replStateReg_34 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_35 <= 1'h0;
    end else if (missLD) begin
      if (6'h23 == addrReplacer[5:0]) begin
        replStateReg_35 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_36 <= 1'h0;
    end else if (missLD) begin
      if (6'h24 == addrReplacer[5:0]) begin
        replStateReg_36 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_37 <= 1'h0;
    end else if (missLD) begin
      if (6'h25 == addrReplacer[5:0]) begin
        replStateReg_37 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_38 <= 1'h0;
    end else if (missLD) begin
      if (6'h26 == addrReplacer[5:0]) begin
        replStateReg_38 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_39 <= 1'h0;
    end else if (missLD) begin
      if (6'h27 == addrReplacer[5:0]) begin
        replStateReg_39 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_40 <= 1'h0;
    end else if (missLD) begin
      if (6'h28 == addrReplacer[5:0]) begin
        replStateReg_40 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_41 <= 1'h0;
    end else if (missLD) begin
      if (6'h29 == addrReplacer[5:0]) begin
        replStateReg_41 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_42 <= 1'h0;
    end else if (missLD) begin
      if (6'h2a == addrReplacer[5:0]) begin
        replStateReg_42 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_43 <= 1'h0;
    end else if (missLD) begin
      if (6'h2b == addrReplacer[5:0]) begin
        replStateReg_43 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_44 <= 1'h0;
    end else if (missLD) begin
      if (6'h2c == addrReplacer[5:0]) begin
        replStateReg_44 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_45 <= 1'h0;
    end else if (missLD) begin
      if (6'h2d == addrReplacer[5:0]) begin
        replStateReg_45 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_46 <= 1'h0;
    end else if (missLD) begin
      if (6'h2e == addrReplacer[5:0]) begin
        replStateReg_46 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_47 <= 1'h0;
    end else if (missLD) begin
      if (6'h2f == addrReplacer[5:0]) begin
        replStateReg_47 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_48 <= 1'h0;
    end else if (missLD) begin
      if (6'h30 == addrReplacer[5:0]) begin
        replStateReg_48 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_49 <= 1'h0;
    end else if (missLD) begin
      if (6'h31 == addrReplacer[5:0]) begin
        replStateReg_49 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_50 <= 1'h0;
    end else if (missLD) begin
      if (6'h32 == addrReplacer[5:0]) begin
        replStateReg_50 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_51 <= 1'h0;
    end else if (missLD) begin
      if (6'h33 == addrReplacer[5:0]) begin
        replStateReg_51 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_52 <= 1'h0;
    end else if (missLD) begin
      if (6'h34 == addrReplacer[5:0]) begin
        replStateReg_52 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_53 <= 1'h0;
    end else if (missLD) begin
      if (6'h35 == addrReplacer[5:0]) begin
        replStateReg_53 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_54 <= 1'h0;
    end else if (missLD) begin
      if (6'h36 == addrReplacer[5:0]) begin
        replStateReg_54 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_55 <= 1'h0;
    end else if (missLD) begin
      if (6'h37 == addrReplacer[5:0]) begin
        replStateReg_55 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_56 <= 1'h0;
    end else if (missLD) begin
      if (6'h38 == addrReplacer[5:0]) begin
        replStateReg_56 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_57 <= 1'h0;
    end else if (missLD) begin
      if (6'h39 == addrReplacer[5:0]) begin
        replStateReg_57 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_58 <= 1'h0;
    end else if (missLD) begin
      if (6'h3a == addrReplacer[5:0]) begin
        replStateReg_58 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_59 <= 1'h0;
    end else if (missLD) begin
      if (6'h3b == addrReplacer[5:0]) begin
        replStateReg_59 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_60 <= 1'h0;
    end else if (missLD) begin
      if (6'h3c == addrReplacer[5:0]) begin
        replStateReg_60 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_61 <= 1'h0;
    end else if (missLD) begin
      if (6'h3d == addrReplacer[5:0]) begin
        replStateReg_61 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_62 <= 1'h0;
    end else if (missLD) begin
      if (6'h3e == addrReplacer[5:0]) begin
        replStateReg_62 <= _T_130[1];
      end
    end
    if (reset) begin
      replStateReg_63 <= 1'h0;
    end else if (missLD) begin
      if (6'h3f == addrReplacer[5:0]) begin
        replStateReg_63 <= _T_130[1];
      end
    end
    if (reset) begin
      wayInputCache <= 3'h2;
    end else if (getState) begin
      if (_T_132) begin
        wayInputCache <= {{1'd0}, probeWay_io_deq_bits};
      end else begin
        wayInputCache <= tbeWay;
      end
    end
    if (reset) begin
      tbeFields_0 <= 32'h0;
    end else if (getState) begin
      tbeFields_0 <= input__io_deq_bits_tbeOut_fields_0;
    end
    if (reset) begin
      _T_139 <= 2'h2;
    end else if (getState) begin
      _T_139 <= {{1'd0}, replacerWayWire};
    end
    if (reset) begin
      inputToPC_addr <= 32'h0;
    end else if (getState) begin
      inputToPC_addr <= input__io_deq_bits_inst_addr;
    end
    if (reset) begin
      inputToPC_data <= 64'h0;
    end else if (getState) begin
      inputToPC_data <= input__io_deq_bits_inst_data;
    end
    _T_211 <= cache_io_bipassLD_in_bits_addr;
    _T_213 <= inputArbiter_io_chosen;
    _T_214 <= inputArbiter_io_out_bits_addr;
    _T_215 <= inputArbiter_io_out_bits_data;
    _T_218 <= inputArbiter_io_chosen;
    _T_226 <= tbe_io_isFull;
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_212 & _T_217) begin
          $fwrite(32'h80000002,"Cache: %d req from %d Addr: %d Data: %d\n",1'h0,_T_213,_T_214,_T_215); // @[programmableCache.scala 516:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_381 & _T_217) begin
          $fwrite(32'h80000002,"Cache: %d ",1'h0); // @[programmableCache.scala 518:19]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_383 & _T_217) begin
          $fwrite(32'h80000002," Load hit for addr %d\n",input__io_deq_bits_inst_addr); // @[programmableCache.scala 520:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_387 & _T_217) begin
          $fwrite(32'h80000002,"addr %d is locked\n",input__io_deq_bits_inst_addr); // @[programmableCache.scala 522:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_393 & _T_217) begin
          $fwrite(32'h80000002,"TBE is full addr %d\n",input__io_deq_bits_inst_addr); // @[programmableCache.scala 524:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_401 & _T_217) begin
          $fwrite(32'h80000002,"Hit (store probably) for addr %d\n",input__io_deq_bits_inst_addr); // @[programmableCache.scala 526:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_410 & _T_217) begin
          $fwrite(32'h80000002,"miss for addr %d\n",input__io_deq_bits_inst_addr); // @[programmableCache.scala 528:23]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (getState & _T_217) begin
          $fwrite(32'h80000002,"Event %d Addr: %d Data: %d\n",input__io_deq_bits_inst_event,input__io_deq_bits_inst_addr,input__io_deq_bits_inst_data); // @[programmableCache.scala 534:15]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module Queue_15(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits_addr,
  input  [7:0]  io_enq_bits_inst,
  input  [63:0] io_enq_bits_data,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits_addr,
  output [7:0]  io_deq_bits_inst,
  output [63:0] io_deq_bits_data
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [63:0] _RAND_2;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram_addr [0:0]; // @[Decoupled.scala 209:16]
  wire [31:0] ram_addr__T_7_data; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_7_addr; // @[Decoupled.scala 209:16]
  wire [31:0] ram_addr__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_addr__T_3_en; // @[Decoupled.scala 209:16]
  reg [7:0] ram_inst [0:0]; // @[Decoupled.scala 209:16]
  wire [7:0] ram_inst__T_7_data; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_7_addr; // @[Decoupled.scala 209:16]
  wire [7:0] ram_inst__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_inst__T_3_en; // @[Decoupled.scala 209:16]
  reg [63:0] ram_data [0:0]; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_7_data; // @[Decoupled.scala 209:16]
  wire  ram_data__T_7_addr; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_3_data; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_en; // @[Decoupled.scala 209:16]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  empty = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire  _T_4 = do_enq != do_deq; // @[Decoupled.scala 227:16]
  assign ram_addr__T_7_addr = 1'h0;
  assign ram_addr__T_7_data = ram_addr[ram_addr__T_7_addr]; // @[Decoupled.scala 209:16]
  assign ram_addr__T_3_data = io_enq_bits_addr;
  assign ram_addr__T_3_addr = 1'h0;
  assign ram_addr__T_3_mask = 1'h1;
  assign ram_addr__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_inst__T_7_addr = 1'h0;
  assign ram_inst__T_7_data = ram_inst[ram_inst__T_7_addr]; // @[Decoupled.scala 209:16]
  assign ram_inst__T_3_data = io_enq_bits_inst;
  assign ram_inst__T_3_addr = 1'h0;
  assign ram_inst__T_3_mask = 1'h1;
  assign ram_inst__T_3_en = io_enq_ready & io_enq_valid;
  assign ram_data__T_7_addr = 1'h0;
  assign ram_data__T_7_data = ram_data[ram_data__T_7_addr]; // @[Decoupled.scala 209:16]
  assign ram_data__T_3_data = io_enq_bits_data;
  assign ram_data__T_3_addr = 1'h0;
  assign ram_data__T_3_mask = 1'h1;
  assign ram_data__T_3_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = io_deq_ready | empty; // @[Decoupled.scala 232:16 Decoupled.scala 245:40]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 231:16]
  assign io_deq_bits_addr = ram_addr__T_7_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_inst = ram_inst__T_7_data; // @[Decoupled.scala 233:15]
  assign io_deq_bits_data = ram_data__T_7_data; // @[Decoupled.scala 233:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_addr[initvar] = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_inst[initvar] = _RAND_1[7:0];
  _RAND_2 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1; initvar = initvar+1)
    ram_data[initvar] = _RAND_2[63:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram_addr__T_3_en & ram_addr__T_3_mask) begin
      ram_addr[ram_addr__T_3_addr] <= ram_addr__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_inst__T_3_en & ram_inst__T_3_mask) begin
      ram_inst[ram_inst__T_3_addr] <= ram_inst__T_3_data; // @[Decoupled.scala 209:16]
    end
    if(ram_data__T_3_en & ram_data__T_3_mask) begin
      ram_data[ram_data__T_3_addr] <= ram_data__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_4) begin
      maybe_full <= do_enq;
    end
  end
endmodule
module CacheNode(
  input         clock,
  input         reset,
  output        io_in_cpu_ready,
  input         io_in_cpu_valid,
  input  [31:0] io_in_cpu_bits_addr,
  input  [7:0]  io_in_cpu_bits_inst,
  input  [63:0] io_in_cpu_bits_data,
  output        io_in_network_ready,
  input         io_in_network_valid,
  input  [31:0] io_in_network_bits_addr,
  input  [7:0]  io_in_network_bits_inst,
  input  [63:0] io_in_network_bits_data,
  input  [1:0]  io_in_network_bits_msgType,
  output        io_out_network_valid,
  output [31:0] io_out_network_bits_addr,
  output [63:0] io_out_network_bits_data,
  output        io_out_cpu_valid,
  output [31:0] io_out_cpu_bits_addr,
  output        _T_242,
  output        _T_236,
  output        _T_249,
  output        hitLD,
  output        missLD,
  output        _T_239
);
  wire  cache_clock; // @[cacheNode.scala 33:21]
  wire  cache_reset; // @[cacheNode.scala 33:21]
  wire  cache_io_in_cpu_ready; // @[cacheNode.scala 33:21]
  wire  cache_io_in_cpu_valid; // @[cacheNode.scala 33:21]
  wire [1:0] cache_io_in_cpu_bits_event; // @[cacheNode.scala 33:21]
  wire [31:0] cache_io_in_cpu_bits_addr; // @[cacheNode.scala 33:21]
  wire [63:0] cache_io_in_cpu_bits_data; // @[cacheNode.scala 33:21]
  wire  cache_io_in_memCtrl_ready; // @[cacheNode.scala 33:21]
  wire  cache_io_in_memCtrl_valid; // @[cacheNode.scala 33:21]
  wire [1:0] cache_io_in_memCtrl_bits_event; // @[cacheNode.scala 33:21]
  wire [31:0] cache_io_in_memCtrl_bits_addr; // @[cacheNode.scala 33:21]
  wire [63:0] cache_io_in_memCtrl_bits_data; // @[cacheNode.scala 33:21]
  wire  cache_io_in_otherNodes_ready; // @[cacheNode.scala 33:21]
  wire  cache_io_in_otherNodes_valid; // @[cacheNode.scala 33:21]
  wire [1:0] cache_io_in_otherNodes_bits_event; // @[cacheNode.scala 33:21]
  wire [31:0] cache_io_in_otherNodes_bits_addr; // @[cacheNode.scala 33:21]
  wire [63:0] cache_io_in_otherNodes_bits_data; // @[cacheNode.scala 33:21]
  wire  cache_io_out_req_valid; // @[cacheNode.scala 33:21]
  wire [31:0] cache_io_out_req_bits_req_addr; // @[cacheNode.scala 33:21]
  wire [63:0] cache_io_out_req_bits_req_data; // @[cacheNode.scala 33:21]
  wire  cache_io_out_resp_valid; // @[cacheNode.scala 33:21]
  wire [31:0] cache_io_out_resp_bits_addr; // @[cacheNode.scala 33:21]
  wire  cache__T_242_0; // @[cacheNode.scala 33:21]
  wire  cache__T_236_0; // @[cacheNode.scala 33:21]
  wire  cache__T_249_0; // @[cacheNode.scala 33:21]
  wire  cache_hitLD_0; // @[cacheNode.scala 33:21]
  wire  cache_missLD_0; // @[cacheNode.scala 33:21]
  wire  cache__T_239_0; // @[cacheNode.scala 33:21]
  wire  cpuQueue_clock; // @[cacheNode.scala 34:24]
  wire  cpuQueue_reset; // @[cacheNode.scala 34:24]
  wire  cpuQueue_io_enq_ready; // @[cacheNode.scala 34:24]
  wire  cpuQueue_io_enq_valid; // @[cacheNode.scala 34:24]
  wire [31:0] cpuQueue_io_enq_bits_addr; // @[cacheNode.scala 34:24]
  wire [7:0] cpuQueue_io_enq_bits_inst; // @[cacheNode.scala 34:24]
  wire [63:0] cpuQueue_io_enq_bits_data; // @[cacheNode.scala 34:24]
  wire  cpuQueue_io_deq_ready; // @[cacheNode.scala 34:24]
  wire  cpuQueue_io_deq_valid; // @[cacheNode.scala 34:24]
  wire [31:0] cpuQueue_io_deq_bits_addr; // @[cacheNode.scala 34:24]
  wire [7:0] cpuQueue_io_deq_bits_inst; // @[cacheNode.scala 34:24]
  wire [63:0] cpuQueue_io_deq_bits_data; // @[cacheNode.scala 34:24]
  wire  memCtrlQueue_clock; // @[cacheNode.scala 35:28]
  wire  memCtrlQueue_reset; // @[cacheNode.scala 35:28]
  wire  memCtrlQueue_io_enq_ready; // @[cacheNode.scala 35:28]
  wire  memCtrlQueue_io_enq_valid; // @[cacheNode.scala 35:28]
  wire [31:0] memCtrlQueue_io_enq_bits_addr; // @[cacheNode.scala 35:28]
  wire [7:0] memCtrlQueue_io_enq_bits_inst; // @[cacheNode.scala 35:28]
  wire [63:0] memCtrlQueue_io_enq_bits_data; // @[cacheNode.scala 35:28]
  wire  memCtrlQueue_io_deq_ready; // @[cacheNode.scala 35:28]
  wire  memCtrlQueue_io_deq_valid; // @[cacheNode.scala 35:28]
  wire [31:0] memCtrlQueue_io_deq_bits_addr; // @[cacheNode.scala 35:28]
  wire [7:0] memCtrlQueue_io_deq_bits_inst; // @[cacheNode.scala 35:28]
  wire [63:0] memCtrlQueue_io_deq_bits_data; // @[cacheNode.scala 35:28]
  wire  otherNodesQueue_clock; // @[cacheNode.scala 36:31]
  wire  otherNodesQueue_reset; // @[cacheNode.scala 36:31]
  wire  otherNodesQueue_io_enq_ready; // @[cacheNode.scala 36:31]
  wire  otherNodesQueue_io_enq_valid; // @[cacheNode.scala 36:31]
  wire [31:0] otherNodesQueue_io_enq_bits_addr; // @[cacheNode.scala 36:31]
  wire [7:0] otherNodesQueue_io_enq_bits_inst; // @[cacheNode.scala 36:31]
  wire [63:0] otherNodesQueue_io_enq_bits_data; // @[cacheNode.scala 36:31]
  wire  otherNodesQueue_io_deq_ready; // @[cacheNode.scala 36:31]
  wire  otherNodesQueue_io_deq_valid; // @[cacheNode.scala 36:31]
  wire [31:0] otherNodesQueue_io_deq_bits_addr; // @[cacheNode.scala 36:31]
  wire [7:0] otherNodesQueue_io_deq_bits_inst; // @[cacheNode.scala 36:31]
  wire [63:0] otherNodesQueue_io_deq_bits_data; // @[cacheNode.scala 36:31]
  wire  _T_1 = io_in_network_ready & io_in_network_valid; // @[Decoupled.scala 40:37]
  wire  _T_2 = io_in_network_bits_msgType == 2'h0; // @[cacheNode.scala 54:37]
  wire  _T_3 = io_in_network_bits_msgType == 2'h1; // @[cacheNode.scala 56:43]
  wire  _GEN_2 = _T_2 ? 1'h0 : _T_3; // @[cacheNode.scala 54:45]
  programmableCache cache ( // @[cacheNode.scala 33:21]
    .clock(cache_clock),
    .reset(cache_reset),
    .io_in_cpu_ready(cache_io_in_cpu_ready),
    .io_in_cpu_valid(cache_io_in_cpu_valid),
    .io_in_cpu_bits_event(cache_io_in_cpu_bits_event),
    .io_in_cpu_bits_addr(cache_io_in_cpu_bits_addr),
    .io_in_cpu_bits_data(cache_io_in_cpu_bits_data),
    .io_in_memCtrl_ready(cache_io_in_memCtrl_ready),
    .io_in_memCtrl_valid(cache_io_in_memCtrl_valid),
    .io_in_memCtrl_bits_event(cache_io_in_memCtrl_bits_event),
    .io_in_memCtrl_bits_addr(cache_io_in_memCtrl_bits_addr),
    .io_in_memCtrl_bits_data(cache_io_in_memCtrl_bits_data),
    .io_in_otherNodes_ready(cache_io_in_otherNodes_ready),
    .io_in_otherNodes_valid(cache_io_in_otherNodes_valid),
    .io_in_otherNodes_bits_event(cache_io_in_otherNodes_bits_event),
    .io_in_otherNodes_bits_addr(cache_io_in_otherNodes_bits_addr),
    .io_in_otherNodes_bits_data(cache_io_in_otherNodes_bits_data),
    .io_out_req_valid(cache_io_out_req_valid),
    .io_out_req_bits_req_addr(cache_io_out_req_bits_req_addr),
    .io_out_req_bits_req_data(cache_io_out_req_bits_req_data),
    .io_out_resp_valid(cache_io_out_resp_valid),
    .io_out_resp_bits_addr(cache_io_out_resp_bits_addr),
    ._T_242_0(cache__T_242_0),
    ._T_236_0(cache__T_236_0),
    ._T_249_0(cache__T_249_0),
    .hitLD_0(cache_hitLD_0),
    .missLD_0(cache_missLD_0),
    ._T_239_0(cache__T_239_0)
  );
  Queue_15 cpuQueue ( // @[cacheNode.scala 34:24]
    .clock(cpuQueue_clock),
    .reset(cpuQueue_reset),
    .io_enq_ready(cpuQueue_io_enq_ready),
    .io_enq_valid(cpuQueue_io_enq_valid),
    .io_enq_bits_addr(cpuQueue_io_enq_bits_addr),
    .io_enq_bits_inst(cpuQueue_io_enq_bits_inst),
    .io_enq_bits_data(cpuQueue_io_enq_bits_data),
    .io_deq_ready(cpuQueue_io_deq_ready),
    .io_deq_valid(cpuQueue_io_deq_valid),
    .io_deq_bits_addr(cpuQueue_io_deq_bits_addr),
    .io_deq_bits_inst(cpuQueue_io_deq_bits_inst),
    .io_deq_bits_data(cpuQueue_io_deq_bits_data)
  );
  Queue_15 memCtrlQueue ( // @[cacheNode.scala 35:28]
    .clock(memCtrlQueue_clock),
    .reset(memCtrlQueue_reset),
    .io_enq_ready(memCtrlQueue_io_enq_ready),
    .io_enq_valid(memCtrlQueue_io_enq_valid),
    .io_enq_bits_addr(memCtrlQueue_io_enq_bits_addr),
    .io_enq_bits_inst(memCtrlQueue_io_enq_bits_inst),
    .io_enq_bits_data(memCtrlQueue_io_enq_bits_data),
    .io_deq_ready(memCtrlQueue_io_deq_ready),
    .io_deq_valid(memCtrlQueue_io_deq_valid),
    .io_deq_bits_addr(memCtrlQueue_io_deq_bits_addr),
    .io_deq_bits_inst(memCtrlQueue_io_deq_bits_inst),
    .io_deq_bits_data(memCtrlQueue_io_deq_bits_data)
  );
  Queue_15 otherNodesQueue ( // @[cacheNode.scala 36:31]
    .clock(otherNodesQueue_clock),
    .reset(otherNodesQueue_reset),
    .io_enq_ready(otherNodesQueue_io_enq_ready),
    .io_enq_valid(otherNodesQueue_io_enq_valid),
    .io_enq_bits_addr(otherNodesQueue_io_enq_bits_addr),
    .io_enq_bits_inst(otherNodesQueue_io_enq_bits_inst),
    .io_enq_bits_data(otherNodesQueue_io_enq_bits_data),
    .io_deq_ready(otherNodesQueue_io_deq_ready),
    .io_deq_valid(otherNodesQueue_io_deq_valid),
    .io_deq_bits_addr(otherNodesQueue_io_deq_bits_addr),
    .io_deq_bits_inst(otherNodesQueue_io_deq_bits_inst),
    .io_deq_bits_data(otherNodesQueue_io_deq_bits_data)
  );
  assign io_in_cpu_ready = cpuQueue_io_enq_ready; // @[cacheNode.scala 38:19]
  assign io_in_network_ready = memCtrlQueue_io_enq_ready & otherNodesQueue_io_enq_ready; // @[cacheNode.scala 47:23]
  assign io_out_network_valid = cache_io_out_req_valid; // @[cacheNode.scala 81:24]
  assign io_out_network_bits_addr = cache_io_out_req_bits_req_addr; // @[cacheNode.scala 86:28]
  assign io_out_network_bits_data = cache_io_out_req_bits_req_data; // @[cacheNode.scala 85:28]
  assign io_out_cpu_valid = cache_io_out_resp_valid; // @[cacheNode.scala 92:20]
  assign io_out_cpu_bits_addr = cache_io_out_resp_bits_addr; // @[cacheNode.scala 90:24]
  assign _T_242 = cache__T_242_0;
  assign _T_236 = cache__T_236_0;
  assign _T_249 = cache__T_249_0;
  assign hitLD = cache_hitLD_0;
  assign missLD = cache_missLD_0;
  assign _T_239 = cache__T_239_0;
  assign cache_clock = clock;
  assign cache_reset = reset;
  assign cache_io_in_cpu_valid = cpuQueue_io_deq_valid; // @[cacheNode.scala 64:30]
  assign cache_io_in_cpu_bits_event = cpuQueue_io_deq_bits_inst[1:0]; // @[cacheNode.scala 61:30]
  assign cache_io_in_cpu_bits_addr = cpuQueue_io_deq_bits_addr; // @[cacheNode.scala 62:30]
  assign cache_io_in_cpu_bits_data = cpuQueue_io_deq_bits_data; // @[cacheNode.scala 63:30]
  assign cache_io_in_memCtrl_valid = memCtrlQueue_io_deq_valid; // @[cacheNode.scala 70:34]
  assign cache_io_in_memCtrl_bits_event = memCtrlQueue_io_deq_bits_inst[1:0]; // @[cacheNode.scala 67:34]
  assign cache_io_in_memCtrl_bits_addr = memCtrlQueue_io_deq_bits_addr; // @[cacheNode.scala 68:34]
  assign cache_io_in_memCtrl_bits_data = memCtrlQueue_io_deq_bits_data; // @[cacheNode.scala 69:34]
  assign cache_io_in_otherNodes_valid = otherNodesQueue_io_deq_valid; // @[cacheNode.scala 76:37]
  assign cache_io_in_otherNodes_bits_event = otherNodesQueue_io_deq_bits_inst[1:0]; // @[cacheNode.scala 73:37]
  assign cache_io_in_otherNodes_bits_addr = otherNodesQueue_io_deq_bits_addr; // @[cacheNode.scala 74:37]
  assign cache_io_in_otherNodes_bits_data = otherNodesQueue_io_deq_bits_data; // @[cacheNode.scala 75:37]
  assign cpuQueue_clock = clock;
  assign cpuQueue_reset = reset;
  assign cpuQueue_io_enq_valid = io_in_cpu_valid; // @[cacheNode.scala 38:19]
  assign cpuQueue_io_enq_bits_addr = io_in_cpu_bits_addr; // @[cacheNode.scala 38:19]
  assign cpuQueue_io_enq_bits_inst = io_in_cpu_bits_inst; // @[cacheNode.scala 38:19]
  assign cpuQueue_io_enq_bits_data = io_in_cpu_bits_data; // @[cacheNode.scala 38:19]
  assign cpuQueue_io_deq_ready = cache_io_in_cpu_ready; // @[cacheNode.scala 65:25]
  assign memCtrlQueue_clock = clock;
  assign memCtrlQueue_reset = reset;
  assign memCtrlQueue_io_enq_valid = _T_1 & _T_2; // @[cacheNode.scala 49:29 cacheNode.scala 55:33]
  assign memCtrlQueue_io_enq_bits_addr = io_in_network_bits_addr; // @[cacheNode.scala 39:33]
  assign memCtrlQueue_io_enq_bits_inst = io_in_network_bits_inst; // @[cacheNode.scala 41:33]
  assign memCtrlQueue_io_enq_bits_data = io_in_network_bits_data; // @[cacheNode.scala 40:33]
  assign memCtrlQueue_io_deq_ready = cache_io_in_memCtrl_ready; // @[cacheNode.scala 71:29]
  assign otherNodesQueue_clock = clock;
  assign otherNodesQueue_reset = reset;
  assign otherNodesQueue_io_enq_valid = _T_1 & _GEN_2; // @[cacheNode.scala 50:32 cacheNode.scala 57:36]
  assign otherNodesQueue_io_enq_bits_addr = io_in_network_bits_addr; // @[cacheNode.scala 43:36]
  assign otherNodesQueue_io_enq_bits_inst = io_in_network_bits_inst; // @[cacheNode.scala 45:36]
  assign otherNodesQueue_io_enq_bits_data = io_in_network_bits_data; // @[cacheNode.scala 44:36]
  assign otherNodesQueue_io_deq_ready = cache_io_in_otherNodes_ready; // @[cacheNode.scala 77:32]
endmodule
module Bore(
  input         clock,
  input         reset,
  output [31:0] io_events_0,
  output [31:0] io_events_1,
  output [31:0] io_events_2,
  output [31:0] io_events_3,
  output [31:0] io_events_4,
  output [31:0] io_events_5,
  input         memCtrlReq_0,
  input         instCount_0,
  input         ldReq_0,
  input         hitLD_0,
  input         missLD_0,
  input         cpuReq_0
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [23:0] _T_1; // @[Counter.scala 29:33]
  wire  _T_3 = _T_1 == 24'h98967f; // @[Counter.scala 38:24]
  wire [23:0] _T_5 = _T_1 + 24'h1; // @[Counter.scala 39:22]
  reg [23:0] _T_6; // @[Counter.scala 29:33]
  wire  _T_8 = _T_6 == 24'h98967f; // @[Counter.scala 38:24]
  wire [23:0] _T_10 = _T_6 + 24'h1; // @[Counter.scala 39:22]
  reg [23:0] _T_11; // @[Counter.scala 29:33]
  wire  _T_13 = _T_11 == 24'h98967f; // @[Counter.scala 38:24]
  wire [23:0] _T_15 = _T_11 + 24'h1; // @[Counter.scala 39:22]
  reg [23:0] _T_16; // @[Counter.scala 29:33]
  wire  _T_18 = _T_16 == 24'h98967f; // @[Counter.scala 38:24]
  wire [23:0] _T_20 = _T_16 + 24'h1; // @[Counter.scala 39:22]
  reg [23:0] _T_21; // @[Counter.scala 29:33]
  wire  _T_23 = _T_21 == 24'h98967f; // @[Counter.scala 38:24]
  wire [23:0] _T_25 = _T_21 + 24'h1; // @[Counter.scala 39:22]
  reg [23:0] _T_26; // @[Counter.scala 29:33]
  wire  _T_28 = _T_26 == 24'h98967f; // @[Counter.scala 38:24]
  wire [23:0] _T_30 = _T_26 + 24'h1; // @[Counter.scala 39:22]
  assign io_events_0 = {{8'd0}, _T_1}; // @[memGenTopLevel.scala 40:15]
  assign io_events_1 = {{8'd0}, _T_6}; // @[memGenTopLevel.scala 40:15]
  assign io_events_2 = {{8'd0}, _T_11}; // @[memGenTopLevel.scala 40:15]
  assign io_events_3 = {{8'd0}, _T_16}; // @[memGenTopLevel.scala 40:15]
  assign io_events_4 = {{8'd0}, _T_21}; // @[memGenTopLevel.scala 40:15]
  assign io_events_5 = {{8'd0}, _T_26}; // @[memGenTopLevel.scala 40:15]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  _T_1 = _RAND_0[23:0];
  _RAND_1 = {1{`RANDOM}};
  _T_6 = _RAND_1[23:0];
  _RAND_2 = {1{`RANDOM}};
  _T_11 = _RAND_2[23:0];
  _RAND_3 = {1{`RANDOM}};
  _T_16 = _RAND_3[23:0];
  _RAND_4 = {1{`RANDOM}};
  _T_21 = _RAND_4[23:0];
  _RAND_5 = {1{`RANDOM}};
  _T_26 = _RAND_5[23:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      _T_1 <= 24'h0;
    end else if (missLD_0) begin
      if (_T_3) begin
        _T_1 <= 24'h0;
      end else begin
        _T_1 <= _T_5;
      end
    end
    if (reset) begin
      _T_6 <= 24'h0;
    end else if (hitLD_0) begin
      if (_T_8) begin
        _T_6 <= 24'h0;
      end else begin
        _T_6 <= _T_10;
      end
    end
    if (reset) begin
      _T_11 <= 24'h0;
    end else if (instCount_0) begin
      if (_T_13) begin
        _T_11 <= 24'h0;
      end else begin
        _T_11 <= _T_15;
      end
    end
    if (reset) begin
      _T_16 <= 24'h0;
    end else if (cpuReq_0) begin
      if (_T_18) begin
        _T_16 <= 24'h0;
      end else begin
        _T_16 <= _T_20;
      end
    end
    if (reset) begin
      _T_21 <= 24'h0;
    end else if (memCtrlReq_0) begin
      if (_T_23) begin
        _T_21 <= 24'h0;
      end else begin
        _T_21 <= _T_25;
      end
    end
    if (reset) begin
      _T_26 <= 24'h0;
    end else if (ldReq_0) begin
      if (_T_28) begin
        _T_26 <= 24'h0;
      end else begin
        _T_26 <= _T_30;
      end
    end
  end
endmodule
module memGenTopLevel(
  input         clock,
  input         reset,
  output        io_instruction_0_ready,
  input         io_instruction_0_valid,
  input  [31:0] io_instruction_0_bits_addr,
  input  [7:0]  io_instruction_0_bits_inst,
  input  [63:0] io_instruction_0_bits_data,
  output        io_resp_0_valid,
  output [31:0] io_resp_0_bits_addr,
  output [31:0] io_events_bits_0,
  output [31:0] io_events_bits_1,
  output [31:0] io_events_bits_2,
  output [31:0] io_events_bits_3,
  output [31:0] io_events_bits_4,
  output [31:0] io_events_bits_5,
  input         io_mem_aw_ready,
  output        io_mem_aw_valid,
  output [31:0] io_mem_aw_bits_addr,
  input         io_mem_w_ready,
  output        io_mem_w_valid,
  output [63:0] io_mem_w_bits_data,
  output        io_mem_b_ready,
  input         io_mem_ar_ready,
  output        io_mem_ar_valid,
  output [31:0] io_mem_ar_bits_addr,
  output [15:0] io_mem_ar_bits_len,
  output        io_mem_r_ready,
  input         io_mem_r_valid,
  input  [63:0] io_mem_r_bits_data,
  input         io_mem_r_bits_last
);
  wire  memCtrl_clock; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_reset; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_in_ready; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_in_valid; // @[memGenTopLevel.scala 67:25]
  wire [31:0] memCtrl_io_in_bits_addr; // @[memGenTopLevel.scala 67:25]
  wire [7:0] memCtrl_io_in_bits_inst; // @[memGenTopLevel.scala 67:25]
  wire [63:0] memCtrl_io_in_bits_data; // @[memGenTopLevel.scala 67:25]
  wire [2:0] memCtrl_io_in_bits_src; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_mem_aw_ready; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_mem_aw_valid; // @[memGenTopLevel.scala 67:25]
  wire [31:0] memCtrl_io_mem_aw_bits_addr; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_mem_w_ready; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_mem_w_valid; // @[memGenTopLevel.scala 67:25]
  wire [63:0] memCtrl_io_mem_w_bits_data; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_mem_b_ready; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_mem_ar_ready; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_mem_ar_valid; // @[memGenTopLevel.scala 67:25]
  wire [31:0] memCtrl_io_mem_ar_bits_addr; // @[memGenTopLevel.scala 67:25]
  wire [15:0] memCtrl_io_mem_ar_bits_len; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_mem_r_ready; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_mem_r_valid; // @[memGenTopLevel.scala 67:25]
  wire [63:0] memCtrl_io_mem_r_bits_data; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_mem_r_bits_last; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_out_ready; // @[memGenTopLevel.scala 67:25]
  wire  memCtrl_io_out_valid; // @[memGenTopLevel.scala 67:25]
  wire [31:0] memCtrl_io_out_bits_addr; // @[memGenTopLevel.scala 67:25]
  wire [63:0] memCtrl_io_out_bits_data; // @[memGenTopLevel.scala 67:25]
  wire [2:0] memCtrl_io_out_bits_dst; // @[memGenTopLevel.scala 67:25]
  wire  memCtrlInputQueue_clock; // @[memGenTopLevel.scala 68:35]
  wire  memCtrlInputQueue_reset; // @[memGenTopLevel.scala 68:35]
  wire  memCtrlInputQueue_io_enq_ready; // @[memGenTopLevel.scala 68:35]
  wire  memCtrlInputQueue_io_enq_valid; // @[memGenTopLevel.scala 68:35]
  wire [31:0] memCtrlInputQueue_io_enq_bits_addr; // @[memGenTopLevel.scala 68:35]
  wire [7:0] memCtrlInputQueue_io_enq_bits_inst; // @[memGenTopLevel.scala 68:35]
  wire [63:0] memCtrlInputQueue_io_enq_bits_data; // @[memGenTopLevel.scala 68:35]
  wire [2:0] memCtrlInputQueue_io_enq_bits_src; // @[memGenTopLevel.scala 68:35]
  wire  memCtrlInputQueue_io_deq_ready; // @[memGenTopLevel.scala 68:35]
  wire  memCtrlInputQueue_io_deq_valid; // @[memGenTopLevel.scala 68:35]
  wire [31:0] memCtrlInputQueue_io_deq_bits_addr; // @[memGenTopLevel.scala 68:35]
  wire [7:0] memCtrlInputQueue_io_deq_bits_inst; // @[memGenTopLevel.scala 68:35]
  wire [63:0] memCtrlInputQueue_io_deq_bits_data; // @[memGenTopLevel.scala 68:35]
  wire [2:0] memCtrlInputQueue_io_deq_bits_src; // @[memGenTopLevel.scala 68:35]
  wire  routerNode_0_clock; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_0_reset; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_0_io_cacheIn_valid; // @[memGenTopLevel.scala 70:28]
  wire [31:0] routerNode_0_io_cacheIn_bits_addr; // @[memGenTopLevel.scala 70:28]
  wire [63:0] routerNode_0_io_cacheIn_bits_data; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_0_io_cacheOut_ready; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_0_io_cacheOut_valid; // @[memGenTopLevel.scala 70:28]
  wire [31:0] routerNode_0_io_cacheOut_bits_addr; // @[memGenTopLevel.scala 70:28]
  wire [7:0] routerNode_0_io_cacheOut_bits_inst; // @[memGenTopLevel.scala 70:28]
  wire [63:0] routerNode_0_io_cacheOut_bits_data; // @[memGenTopLevel.scala 70:28]
  wire [1:0] routerNode_0_io_cacheOut_bits_msgType; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_0_io_in_ready; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_0_io_in_valid; // @[memGenTopLevel.scala 70:28]
  wire [31:0] routerNode_0_io_in_bits_addr; // @[memGenTopLevel.scala 70:28]
  wire [7:0] routerNode_0_io_in_bits_inst; // @[memGenTopLevel.scala 70:28]
  wire [63:0] routerNode_0_io_in_bits_data; // @[memGenTopLevel.scala 70:28]
  wire [2:0] routerNode_0_io_in_bits_src; // @[memGenTopLevel.scala 70:28]
  wire [2:0] routerNode_0_io_in_bits_dst; // @[memGenTopLevel.scala 70:28]
  wire [1:0] routerNode_0_io_in_bits_msgType; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_0_io_out_ready; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_0_io_out_valid; // @[memGenTopLevel.scala 70:28]
  wire [31:0] routerNode_0_io_out_bits_addr; // @[memGenTopLevel.scala 70:28]
  wire [7:0] routerNode_0_io_out_bits_inst; // @[memGenTopLevel.scala 70:28]
  wire [63:0] routerNode_0_io_out_bits_data; // @[memGenTopLevel.scala 70:28]
  wire [2:0] routerNode_0_io_out_bits_src; // @[memGenTopLevel.scala 70:28]
  wire [2:0] routerNode_0_io_out_bits_dst; // @[memGenTopLevel.scala 70:28]
  wire [1:0] routerNode_0_io_out_bits_msgType; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_1_clock; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_1_reset; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_1_io_cacheIn_ready; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_1_io_cacheIn_valid; // @[memGenTopLevel.scala 70:28]
  wire [31:0] routerNode_1_io_cacheIn_bits_addr; // @[memGenTopLevel.scala 70:28]
  wire [63:0] routerNode_1_io_cacheIn_bits_data; // @[memGenTopLevel.scala 70:28]
  wire [2:0] routerNode_1_io_cacheIn_bits_dst; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_1_io_cacheOut_ready; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_1_io_cacheOut_valid; // @[memGenTopLevel.scala 70:28]
  wire [31:0] routerNode_1_io_cacheOut_bits_addr; // @[memGenTopLevel.scala 70:28]
  wire [7:0] routerNode_1_io_cacheOut_bits_inst; // @[memGenTopLevel.scala 70:28]
  wire [63:0] routerNode_1_io_cacheOut_bits_data; // @[memGenTopLevel.scala 70:28]
  wire [2:0] routerNode_1_io_cacheOut_bits_src; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_1_io_in_ready; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_1_io_in_valid; // @[memGenTopLevel.scala 70:28]
  wire [31:0] routerNode_1_io_in_bits_addr; // @[memGenTopLevel.scala 70:28]
  wire [7:0] routerNode_1_io_in_bits_inst; // @[memGenTopLevel.scala 70:28]
  wire [63:0] routerNode_1_io_in_bits_data; // @[memGenTopLevel.scala 70:28]
  wire [2:0] routerNode_1_io_in_bits_src; // @[memGenTopLevel.scala 70:28]
  wire [2:0] routerNode_1_io_in_bits_dst; // @[memGenTopLevel.scala 70:28]
  wire [1:0] routerNode_1_io_in_bits_msgType; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_1_io_out_ready; // @[memGenTopLevel.scala 70:28]
  wire  routerNode_1_io_out_valid; // @[memGenTopLevel.scala 70:28]
  wire [31:0] routerNode_1_io_out_bits_addr; // @[memGenTopLevel.scala 70:28]
  wire [7:0] routerNode_1_io_out_bits_inst; // @[memGenTopLevel.scala 70:28]
  wire [63:0] routerNode_1_io_out_bits_data; // @[memGenTopLevel.scala 70:28]
  wire [2:0] routerNode_1_io_out_bits_src; // @[memGenTopLevel.scala 70:28]
  wire [2:0] routerNode_1_io_out_bits_dst; // @[memGenTopLevel.scala 70:28]
  wire [1:0] routerNode_1_io_out_bits_msgType; // @[memGenTopLevel.scala 70:28]
  wire  cacheNode_0_clock; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0_reset; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0_io_in_cpu_ready; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0_io_in_cpu_valid; // @[memGenTopLevel.scala 74:28]
  wire [31:0] cacheNode_0_io_in_cpu_bits_addr; // @[memGenTopLevel.scala 74:28]
  wire [7:0] cacheNode_0_io_in_cpu_bits_inst; // @[memGenTopLevel.scala 74:28]
  wire [63:0] cacheNode_0_io_in_cpu_bits_data; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0_io_in_network_ready; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0_io_in_network_valid; // @[memGenTopLevel.scala 74:28]
  wire [31:0] cacheNode_0_io_in_network_bits_addr; // @[memGenTopLevel.scala 74:28]
  wire [7:0] cacheNode_0_io_in_network_bits_inst; // @[memGenTopLevel.scala 74:28]
  wire [63:0] cacheNode_0_io_in_network_bits_data; // @[memGenTopLevel.scala 74:28]
  wire [1:0] cacheNode_0_io_in_network_bits_msgType; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0_io_out_network_valid; // @[memGenTopLevel.scala 74:28]
  wire [31:0] cacheNode_0_io_out_network_bits_addr; // @[memGenTopLevel.scala 74:28]
  wire [63:0] cacheNode_0_io_out_network_bits_data; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0_io_out_cpu_valid; // @[memGenTopLevel.scala 74:28]
  wire [31:0] cacheNode_0_io_out_cpu_bits_addr; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0__T_242; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0__T_236; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0__T_249; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0_hitLD; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0_missLD; // @[memGenTopLevel.scala 74:28]
  wire  cacheNode_0__T_239; // @[memGenTopLevel.scala 74:28]
  wire  bore_clock; // @[memGenTopLevel.scala 78:22]
  wire  bore_reset; // @[memGenTopLevel.scala 78:22]
  wire [31:0] bore_io_events_0; // @[memGenTopLevel.scala 78:22]
  wire [31:0] bore_io_events_1; // @[memGenTopLevel.scala 78:22]
  wire [31:0] bore_io_events_2; // @[memGenTopLevel.scala 78:22]
  wire [31:0] bore_io_events_3; // @[memGenTopLevel.scala 78:22]
  wire [31:0] bore_io_events_4; // @[memGenTopLevel.scala 78:22]
  wire [31:0] bore_io_events_5; // @[memGenTopLevel.scala 78:22]
  wire  bore_memCtrlReq_0; // @[memGenTopLevel.scala 78:22]
  wire  bore_instCount_0; // @[memGenTopLevel.scala 78:22]
  wire  bore_ldReq_0; // @[memGenTopLevel.scala 78:22]
  wire  bore_hitLD_0; // @[memGenTopLevel.scala 78:22]
  wire  bore_missLD_0; // @[memGenTopLevel.scala 78:22]
  wire  bore_cpuReq_0; // @[memGenTopLevel.scala 78:22]
  memoryWrapper memCtrl ( // @[memGenTopLevel.scala 67:25]
    .clock(memCtrl_clock),
    .reset(memCtrl_reset),
    .io_in_ready(memCtrl_io_in_ready),
    .io_in_valid(memCtrl_io_in_valid),
    .io_in_bits_addr(memCtrl_io_in_bits_addr),
    .io_in_bits_inst(memCtrl_io_in_bits_inst),
    .io_in_bits_data(memCtrl_io_in_bits_data),
    .io_in_bits_src(memCtrl_io_in_bits_src),
    .io_mem_aw_ready(memCtrl_io_mem_aw_ready),
    .io_mem_aw_valid(memCtrl_io_mem_aw_valid),
    .io_mem_aw_bits_addr(memCtrl_io_mem_aw_bits_addr),
    .io_mem_w_ready(memCtrl_io_mem_w_ready),
    .io_mem_w_valid(memCtrl_io_mem_w_valid),
    .io_mem_w_bits_data(memCtrl_io_mem_w_bits_data),
    .io_mem_b_ready(memCtrl_io_mem_b_ready),
    .io_mem_ar_ready(memCtrl_io_mem_ar_ready),
    .io_mem_ar_valid(memCtrl_io_mem_ar_valid),
    .io_mem_ar_bits_addr(memCtrl_io_mem_ar_bits_addr),
    .io_mem_ar_bits_len(memCtrl_io_mem_ar_bits_len),
    .io_mem_r_ready(memCtrl_io_mem_r_ready),
    .io_mem_r_valid(memCtrl_io_mem_r_valid),
    .io_mem_r_bits_data(memCtrl_io_mem_r_bits_data),
    .io_mem_r_bits_last(memCtrl_io_mem_r_bits_last),
    .io_out_ready(memCtrl_io_out_ready),
    .io_out_valid(memCtrl_io_out_valid),
    .io_out_bits_addr(memCtrl_io_out_bits_addr),
    .io_out_bits_data(memCtrl_io_out_bits_data),
    .io_out_bits_dst(memCtrl_io_out_bits_dst)
  );
  Queue memCtrlInputQueue ( // @[memGenTopLevel.scala 68:35]
    .clock(memCtrlInputQueue_clock),
    .reset(memCtrlInputQueue_reset),
    .io_enq_ready(memCtrlInputQueue_io_enq_ready),
    .io_enq_valid(memCtrlInputQueue_io_enq_valid),
    .io_enq_bits_addr(memCtrlInputQueue_io_enq_bits_addr),
    .io_enq_bits_inst(memCtrlInputQueue_io_enq_bits_inst),
    .io_enq_bits_data(memCtrlInputQueue_io_enq_bits_data),
    .io_enq_bits_src(memCtrlInputQueue_io_enq_bits_src),
    .io_deq_ready(memCtrlInputQueue_io_deq_ready),
    .io_deq_valid(memCtrlInputQueue_io_deq_valid),
    .io_deq_bits_addr(memCtrlInputQueue_io_deq_bits_addr),
    .io_deq_bits_inst(memCtrlInputQueue_io_deq_bits_inst),
    .io_deq_bits_data(memCtrlInputQueue_io_deq_bits_data),
    .io_deq_bits_src(memCtrlInputQueue_io_deq_bits_src)
  );
  Router routerNode_0 ( // @[memGenTopLevel.scala 70:28]
    .clock(routerNode_0_clock),
    .reset(routerNode_0_reset),
    .io_cacheIn_valid(routerNode_0_io_cacheIn_valid),
    .io_cacheIn_bits_addr(routerNode_0_io_cacheIn_bits_addr),
    .io_cacheIn_bits_data(routerNode_0_io_cacheIn_bits_data),
    .io_cacheOut_ready(routerNode_0_io_cacheOut_ready),
    .io_cacheOut_valid(routerNode_0_io_cacheOut_valid),
    .io_cacheOut_bits_addr(routerNode_0_io_cacheOut_bits_addr),
    .io_cacheOut_bits_inst(routerNode_0_io_cacheOut_bits_inst),
    .io_cacheOut_bits_data(routerNode_0_io_cacheOut_bits_data),
    .io_cacheOut_bits_msgType(routerNode_0_io_cacheOut_bits_msgType),
    .io_in_ready(routerNode_0_io_in_ready),
    .io_in_valid(routerNode_0_io_in_valid),
    .io_in_bits_addr(routerNode_0_io_in_bits_addr),
    .io_in_bits_inst(routerNode_0_io_in_bits_inst),
    .io_in_bits_data(routerNode_0_io_in_bits_data),
    .io_in_bits_src(routerNode_0_io_in_bits_src),
    .io_in_bits_dst(routerNode_0_io_in_bits_dst),
    .io_in_bits_msgType(routerNode_0_io_in_bits_msgType),
    .io_out_ready(routerNode_0_io_out_ready),
    .io_out_valid(routerNode_0_io_out_valid),
    .io_out_bits_addr(routerNode_0_io_out_bits_addr),
    .io_out_bits_inst(routerNode_0_io_out_bits_inst),
    .io_out_bits_data(routerNode_0_io_out_bits_data),
    .io_out_bits_src(routerNode_0_io_out_bits_src),
    .io_out_bits_dst(routerNode_0_io_out_bits_dst),
    .io_out_bits_msgType(routerNode_0_io_out_bits_msgType)
  );
  Router_1 routerNode_1 ( // @[memGenTopLevel.scala 70:28]
    .clock(routerNode_1_clock),
    .reset(routerNode_1_reset),
    .io_cacheIn_ready(routerNode_1_io_cacheIn_ready),
    .io_cacheIn_valid(routerNode_1_io_cacheIn_valid),
    .io_cacheIn_bits_addr(routerNode_1_io_cacheIn_bits_addr),
    .io_cacheIn_bits_data(routerNode_1_io_cacheIn_bits_data),
    .io_cacheIn_bits_dst(routerNode_1_io_cacheIn_bits_dst),
    .io_cacheOut_ready(routerNode_1_io_cacheOut_ready),
    .io_cacheOut_valid(routerNode_1_io_cacheOut_valid),
    .io_cacheOut_bits_addr(routerNode_1_io_cacheOut_bits_addr),
    .io_cacheOut_bits_inst(routerNode_1_io_cacheOut_bits_inst),
    .io_cacheOut_bits_data(routerNode_1_io_cacheOut_bits_data),
    .io_cacheOut_bits_src(routerNode_1_io_cacheOut_bits_src),
    .io_in_ready(routerNode_1_io_in_ready),
    .io_in_valid(routerNode_1_io_in_valid),
    .io_in_bits_addr(routerNode_1_io_in_bits_addr),
    .io_in_bits_inst(routerNode_1_io_in_bits_inst),
    .io_in_bits_data(routerNode_1_io_in_bits_data),
    .io_in_bits_src(routerNode_1_io_in_bits_src),
    .io_in_bits_dst(routerNode_1_io_in_bits_dst),
    .io_in_bits_msgType(routerNode_1_io_in_bits_msgType),
    .io_out_ready(routerNode_1_io_out_ready),
    .io_out_valid(routerNode_1_io_out_valid),
    .io_out_bits_addr(routerNode_1_io_out_bits_addr),
    .io_out_bits_inst(routerNode_1_io_out_bits_inst),
    .io_out_bits_data(routerNode_1_io_out_bits_data),
    .io_out_bits_src(routerNode_1_io_out_bits_src),
    .io_out_bits_dst(routerNode_1_io_out_bits_dst),
    .io_out_bits_msgType(routerNode_1_io_out_bits_msgType)
  );
  CacheNode cacheNode_0 ( // @[memGenTopLevel.scala 74:28]
    .clock(cacheNode_0_clock),
    .reset(cacheNode_0_reset),
    .io_in_cpu_ready(cacheNode_0_io_in_cpu_ready),
    .io_in_cpu_valid(cacheNode_0_io_in_cpu_valid),
    .io_in_cpu_bits_addr(cacheNode_0_io_in_cpu_bits_addr),
    .io_in_cpu_bits_inst(cacheNode_0_io_in_cpu_bits_inst),
    .io_in_cpu_bits_data(cacheNode_0_io_in_cpu_bits_data),
    .io_in_network_ready(cacheNode_0_io_in_network_ready),
    .io_in_network_valid(cacheNode_0_io_in_network_valid),
    .io_in_network_bits_addr(cacheNode_0_io_in_network_bits_addr),
    .io_in_network_bits_inst(cacheNode_0_io_in_network_bits_inst),
    .io_in_network_bits_data(cacheNode_0_io_in_network_bits_data),
    .io_in_network_bits_msgType(cacheNode_0_io_in_network_bits_msgType),
    .io_out_network_valid(cacheNode_0_io_out_network_valid),
    .io_out_network_bits_addr(cacheNode_0_io_out_network_bits_addr),
    .io_out_network_bits_data(cacheNode_0_io_out_network_bits_data),
    .io_out_cpu_valid(cacheNode_0_io_out_cpu_valid),
    .io_out_cpu_bits_addr(cacheNode_0_io_out_cpu_bits_addr),
    ._T_242(cacheNode_0__T_242),
    ._T_236(cacheNode_0__T_236),
    ._T_249(cacheNode_0__T_249),
    .hitLD(cacheNode_0_hitLD),
    .missLD(cacheNode_0_missLD),
    ._T_239(cacheNode_0__T_239)
  );
  Bore bore ( // @[memGenTopLevel.scala 78:22]
    .clock(bore_clock),
    .reset(bore_reset),
    .io_events_0(bore_io_events_0),
    .io_events_1(bore_io_events_1),
    .io_events_2(bore_io_events_2),
    .io_events_3(bore_io_events_3),
    .io_events_4(bore_io_events_4),
    .io_events_5(bore_io_events_5),
    .memCtrlReq_0(bore_memCtrlReq_0),
    .instCount_0(bore_instCount_0),
    .ldReq_0(bore_ldReq_0),
    .hitLD_0(bore_hitLD_0),
    .missLD_0(bore_missLD_0),
    .cpuReq_0(bore_cpuReq_0)
  );
  assign io_instruction_0_ready = cacheNode_0_io_in_cpu_ready; // @[memGenTopLevel.scala 88:33]
  assign io_resp_0_valid = cacheNode_0_io_out_cpu_valid; // @[memGenTopLevel.scala 89:20]
  assign io_resp_0_bits_addr = cacheNode_0_io_out_cpu_bits_addr; // @[memGenTopLevel.scala 89:20]
  assign io_events_bits_0 = bore_io_events_0; // @[memGenTopLevel.scala 82:20]
  assign io_events_bits_1 = bore_io_events_1; // @[memGenTopLevel.scala 82:20]
  assign io_events_bits_2 = bore_io_events_2; // @[memGenTopLevel.scala 82:20]
  assign io_events_bits_3 = bore_io_events_3; // @[memGenTopLevel.scala 82:20]
  assign io_events_bits_4 = bore_io_events_4; // @[memGenTopLevel.scala 82:20]
  assign io_events_bits_5 = bore_io_events_5; // @[memGenTopLevel.scala 82:20]
  assign io_mem_aw_valid = memCtrl_io_mem_aw_valid; // @[memGenTopLevel.scala 100:12]
  assign io_mem_aw_bits_addr = memCtrl_io_mem_aw_bits_addr; // @[memGenTopLevel.scala 100:12]
  assign io_mem_w_valid = memCtrl_io_mem_w_valid; // @[memGenTopLevel.scala 100:12]
  assign io_mem_w_bits_data = memCtrl_io_mem_w_bits_data; // @[memGenTopLevel.scala 100:12]
  assign io_mem_b_ready = memCtrl_io_mem_b_ready; // @[memGenTopLevel.scala 100:12]
  assign io_mem_ar_valid = memCtrl_io_mem_ar_valid; // @[memGenTopLevel.scala 100:12]
  assign io_mem_ar_bits_addr = memCtrl_io_mem_ar_bits_addr; // @[memGenTopLevel.scala 100:12]
  assign io_mem_ar_bits_len = memCtrl_io_mem_ar_bits_len; // @[memGenTopLevel.scala 100:12]
  assign io_mem_r_ready = memCtrl_io_mem_r_ready; // @[memGenTopLevel.scala 100:12]
  assign memCtrl_clock = clock;
  assign memCtrl_reset = reset;
  assign memCtrl_io_in_valid = memCtrlInputQueue_io_deq_valid; // @[memGenTopLevel.scala 98:19]
  assign memCtrl_io_in_bits_addr = memCtrlInputQueue_io_deq_bits_addr; // @[memGenTopLevel.scala 98:19]
  assign memCtrl_io_in_bits_inst = memCtrlInputQueue_io_deq_bits_inst; // @[memGenTopLevel.scala 98:19]
  assign memCtrl_io_in_bits_data = memCtrlInputQueue_io_deq_bits_data; // @[memGenTopLevel.scala 98:19]
  assign memCtrl_io_in_bits_src = memCtrlInputQueue_io_deq_bits_src; // @[memGenTopLevel.scala 98:19]
  assign memCtrl_io_mem_aw_ready = io_mem_aw_ready; // @[memGenTopLevel.scala 100:12]
  assign memCtrl_io_mem_w_ready = io_mem_w_ready; // @[memGenTopLevel.scala 100:12]
  assign memCtrl_io_mem_ar_ready = io_mem_ar_ready; // @[memGenTopLevel.scala 100:12]
  assign memCtrl_io_mem_r_valid = io_mem_r_valid; // @[memGenTopLevel.scala 100:12]
  assign memCtrl_io_mem_r_bits_data = io_mem_r_bits_data; // @[memGenTopLevel.scala 100:12]
  assign memCtrl_io_mem_r_bits_last = io_mem_r_bits_last; // @[memGenTopLevel.scala 100:12]
  assign memCtrl_io_out_ready = routerNode_1_io_cacheIn_ready; // @[memGenTopLevel.scala 99:52]
  assign memCtrlInputQueue_clock = clock;
  assign memCtrlInputQueue_reset = reset;
  assign memCtrlInputQueue_io_enq_valid = routerNode_1_io_cacheOut_valid; // @[memGenTopLevel.scala 97:30]
  assign memCtrlInputQueue_io_enq_bits_addr = routerNode_1_io_cacheOut_bits_addr; // @[memGenTopLevel.scala 97:30]
  assign memCtrlInputQueue_io_enq_bits_inst = routerNode_1_io_cacheOut_bits_inst; // @[memGenTopLevel.scala 97:30]
  assign memCtrlInputQueue_io_enq_bits_data = routerNode_1_io_cacheOut_bits_data; // @[memGenTopLevel.scala 97:30]
  assign memCtrlInputQueue_io_enq_bits_src = routerNode_1_io_cacheOut_bits_src; // @[memGenTopLevel.scala 97:30]
  assign memCtrlInputQueue_io_deq_ready = memCtrl_io_in_ready; // @[memGenTopLevel.scala 98:19]
  assign routerNode_0_clock = clock;
  assign routerNode_0_reset = reset;
  assign routerNode_0_io_cacheIn_valid = cacheNode_0_io_out_network_valid; // @[memGenTopLevel.scala 93:34]
  assign routerNode_0_io_cacheIn_bits_addr = cacheNode_0_io_out_network_bits_addr; // @[memGenTopLevel.scala 93:34]
  assign routerNode_0_io_cacheIn_bits_data = cacheNode_0_io_out_network_bits_data; // @[memGenTopLevel.scala 93:34]
  assign routerNode_0_io_cacheOut_ready = cacheNode_0_io_in_network_ready; // @[memGenTopLevel.scala 94:36]
  assign routerNode_0_io_in_valid = routerNode_1_io_out_valid; // @[memGenTopLevel.scala 105:25]
  assign routerNode_0_io_in_bits_addr = routerNode_1_io_out_bits_addr; // @[memGenTopLevel.scala 105:25]
  assign routerNode_0_io_in_bits_inst = routerNode_1_io_out_bits_inst; // @[memGenTopLevel.scala 105:25]
  assign routerNode_0_io_in_bits_data = routerNode_1_io_out_bits_data; // @[memGenTopLevel.scala 105:25]
  assign routerNode_0_io_in_bits_src = routerNode_1_io_out_bits_src; // @[memGenTopLevel.scala 105:25]
  assign routerNode_0_io_in_bits_dst = routerNode_1_io_out_bits_dst; // @[memGenTopLevel.scala 105:25]
  assign routerNode_0_io_in_bits_msgType = routerNode_1_io_out_bits_msgType; // @[memGenTopLevel.scala 105:25]
  assign routerNode_0_io_out_ready = routerNode_1_io_in_ready; // @[memGenTopLevel.scala 103:32]
  assign routerNode_1_clock = clock;
  assign routerNode_1_reset = reset;
  assign routerNode_1_io_cacheIn_valid = memCtrl_io_out_valid; // @[memGenTopLevel.scala 99:52]
  assign routerNode_1_io_cacheIn_bits_addr = memCtrl_io_out_bits_addr; // @[memGenTopLevel.scala 99:52]
  assign routerNode_1_io_cacheIn_bits_data = memCtrl_io_out_bits_data; // @[memGenTopLevel.scala 99:52]
  assign routerNode_1_io_cacheIn_bits_dst = memCtrl_io_out_bits_dst; // @[memGenTopLevel.scala 99:52]
  assign routerNode_1_io_cacheOut_ready = memCtrlInputQueue_io_enq_ready; // @[memGenTopLevel.scala 97:30]
  assign routerNode_1_io_in_valid = routerNode_0_io_out_valid; // @[memGenTopLevel.scala 103:32]
  assign routerNode_1_io_in_bits_addr = routerNode_0_io_out_bits_addr; // @[memGenTopLevel.scala 103:32]
  assign routerNode_1_io_in_bits_inst = routerNode_0_io_out_bits_inst; // @[memGenTopLevel.scala 103:32]
  assign routerNode_1_io_in_bits_data = routerNode_0_io_out_bits_data; // @[memGenTopLevel.scala 103:32]
  assign routerNode_1_io_in_bits_src = routerNode_0_io_out_bits_src; // @[memGenTopLevel.scala 103:32]
  assign routerNode_1_io_in_bits_dst = routerNode_0_io_out_bits_dst; // @[memGenTopLevel.scala 103:32]
  assign routerNode_1_io_in_bits_msgType = routerNode_0_io_out_bits_msgType; // @[memGenTopLevel.scala 103:32]
  assign routerNode_1_io_out_ready = routerNode_0_io_in_ready; // @[memGenTopLevel.scala 105:25]
  assign cacheNode_0_clock = clock;
  assign cacheNode_0_reset = reset;
  assign cacheNode_0_io_in_cpu_valid = io_instruction_0_valid; // @[memGenTopLevel.scala 87:38]
  assign cacheNode_0_io_in_cpu_bits_addr = io_instruction_0_bits_addr; // @[memGenTopLevel.scala 86:34]
  assign cacheNode_0_io_in_cpu_bits_inst = io_instruction_0_bits_inst; // @[memGenTopLevel.scala 86:34]
  assign cacheNode_0_io_in_cpu_bits_data = io_instruction_0_bits_data; // @[memGenTopLevel.scala 86:34]
  assign cacheNode_0_io_in_network_valid = routerNode_0_io_cacheOut_valid; // @[memGenTopLevel.scala 94:36]
  assign cacheNode_0_io_in_network_bits_addr = routerNode_0_io_cacheOut_bits_addr; // @[memGenTopLevel.scala 94:36]
  assign cacheNode_0_io_in_network_bits_inst = routerNode_0_io_cacheOut_bits_inst; // @[memGenTopLevel.scala 94:36]
  assign cacheNode_0_io_in_network_bits_data = routerNode_0_io_cacheOut_bits_data; // @[memGenTopLevel.scala 94:36]
  assign cacheNode_0_io_in_network_bits_msgType = routerNode_0_io_cacheOut_bits_msgType; // @[memGenTopLevel.scala 94:36]
  assign bore_clock = clock;
  assign bore_reset = reset;
  assign bore_memCtrlReq_0 = cacheNode_0__T_242;
  assign bore_instCount_0 = cacheNode_0__T_236;
  assign bore_ldReq_0 = cacheNode_0__T_249;
  assign bore_hitLD_0 = cacheNode_0_hitLD;
  assign bore_missLD_0 = cacheNode_0_missLD;
  assign bore_cpuReq_0 = cacheNode_0__T_239;
endmodule
module Arbiter_6(
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [31:0] io_in_0_bits,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits
);
  assign io_in_0_ready = io_out_ready; // @[Arbiter.scala 134:14]
  assign io_out_valid = io_in_0_valid; // @[Arbiter.scala 135:16]
  assign io_out_bits = io_in_0_bits; // @[Arbiter.scala 124:15]
endmodule
module Queue_18(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram [0:15]; // @[Decoupled.scala 209:16]
  wire [31:0] ram__T_11_data; // @[Decoupled.scala 209:16]
  wire [3:0] ram__T_11_addr; // @[Decoupled.scala 209:16]
  wire [31:0] ram__T_3_data; // @[Decoupled.scala 209:16]
  wire [3:0] ram__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram__T_3_en; // @[Decoupled.scala 209:16]
  reg [3:0] enq_ptr_value; // @[Counter.scala 29:33]
  reg [3:0] deq_ptr_value; // @[Counter.scala 29:33]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 214:33]
  wire  _T = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  empty = ptr_match & _T; // @[Decoupled.scala 215:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 216:24]
  wire  _T_1 = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  _T_2 = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire [3:0] _T_5 = enq_ptr_value + 4'h1; // @[Counter.scala 39:22]
  wire  _GEN_9 = io_deq_ready ? 1'h0 : _T_1; // @[Decoupled.scala 240:27]
  wire  do_enq = empty ? _GEN_9 : _T_1; // @[Decoupled.scala 237:18]
  wire [3:0] _T_7 = deq_ptr_value + 4'h1; // @[Counter.scala 39:22]
  wire  do_deq = empty ? 1'h0 : _T_2; // @[Decoupled.scala 237:18]
  wire  _T_8 = do_enq != do_deq; // @[Decoupled.scala 227:16]
  wire  _T_9 = ~empty; // @[Decoupled.scala 231:19]
  wire  _T_10 = ~full; // @[Decoupled.scala 232:19]
  assign ram__T_11_addr = deq_ptr_value;
  assign ram__T_11_data = ram[ram__T_11_addr]; // @[Decoupled.scala 209:16]
  assign ram__T_3_data = io_enq_bits;
  assign ram__T_3_addr = enq_ptr_value;
  assign ram__T_3_mask = 1'h1;
  assign ram__T_3_en = empty ? _GEN_9 : _T_1;
  assign io_enq_ready = io_deq_ready | _T_10; // @[Decoupled.scala 232:16 Decoupled.scala 245:40]
  assign io_deq_valid = io_enq_valid | _T_9; // @[Decoupled.scala 231:16 Decoupled.scala 236:40]
  assign io_deq_bits = empty ? io_enq_bits : ram__T_11_data; // @[Decoupled.scala 233:15 Decoupled.scala 238:19]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram__T_3_en & ram__T_3_mask) begin
      ram[ram__T_3_addr] <= ram__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      enq_ptr_value <= 4'h0;
    end else if (do_enq) begin
      enq_ptr_value <= _T_5;
    end
    if (reset) begin
      deq_ptr_value <= 4'h0;
    end else if (do_deq) begin
      deq_ptr_value <= _T_7;
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_8) begin
      if (empty) begin
        if (io_deq_ready) begin
          maybe_full <= 1'h0;
        end else begin
          maybe_full <= _T_1;
        end
      end else begin
        maybe_full <= _T_1;
      end
    end
  end
endmodule
module memGenAccel(
  input         clock,
  input         reset,
  output        io_in_ready,
  input         io_in_valid,
  input  [63:0] io_in_bits_dataVals_field2_data,
  input  [63:0] io_in_bits_dataVals_field1_data,
  input  [63:0] io_in_bits_dataVals_field0_data,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits_data_field1_data,
  output [31:0] io_events_bits_0,
  output [31:0] io_events_bits_1,
  output [31:0] io_events_bits_2,
  output [31:0] io_events_bits_3,
  output [31:0] io_events_bits_4,
  output [31:0] io_events_bits_5,
  input         io_mem_aw_ready,
  output        io_mem_aw_valid,
  output [31:0] io_mem_aw_bits_addr,
  input         io_mem_w_ready,
  output        io_mem_w_valid,
  output [63:0] io_mem_w_bits_data,
  output        io_mem_b_ready,
  input         io_mem_ar_ready,
  output        io_mem_ar_valid,
  output [31:0] io_mem_ar_bits_addr,
  output [15:0] io_mem_ar_bits_len,
  output        io_mem_r_ready,
  input         io_mem_r_valid,
  input  [63:0] io_mem_r_bits_data,
  input         io_mem_r_bits_last
);
  wire  accel_clock; // @[memGenCacheShell.scala 24:22]
  wire  accel_reset; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_instruction_0_ready; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_instruction_0_valid; // @[memGenCacheShell.scala 24:22]
  wire [31:0] accel_io_instruction_0_bits_addr; // @[memGenCacheShell.scala 24:22]
  wire [7:0] accel_io_instruction_0_bits_inst; // @[memGenCacheShell.scala 24:22]
  wire [63:0] accel_io_instruction_0_bits_data; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_resp_0_valid; // @[memGenCacheShell.scala 24:22]
  wire [31:0] accel_io_resp_0_bits_addr; // @[memGenCacheShell.scala 24:22]
  wire [31:0] accel_io_events_bits_0; // @[memGenCacheShell.scala 24:22]
  wire [31:0] accel_io_events_bits_1; // @[memGenCacheShell.scala 24:22]
  wire [31:0] accel_io_events_bits_2; // @[memGenCacheShell.scala 24:22]
  wire [31:0] accel_io_events_bits_3; // @[memGenCacheShell.scala 24:22]
  wire [31:0] accel_io_events_bits_4; // @[memGenCacheShell.scala 24:22]
  wire [31:0] accel_io_events_bits_5; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_mem_aw_ready; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_mem_aw_valid; // @[memGenCacheShell.scala 24:22]
  wire [31:0] accel_io_mem_aw_bits_addr; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_mem_w_ready; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_mem_w_valid; // @[memGenCacheShell.scala 24:22]
  wire [63:0] accel_io_mem_w_bits_data; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_mem_b_ready; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_mem_ar_ready; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_mem_ar_valid; // @[memGenCacheShell.scala 24:22]
  wire [31:0] accel_io_mem_ar_bits_addr; // @[memGenCacheShell.scala 24:22]
  wire [15:0] accel_io_mem_ar_bits_len; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_mem_r_ready; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_mem_r_valid; // @[memGenCacheShell.scala 24:22]
  wire [63:0] accel_io_mem_r_bits_data; // @[memGenCacheShell.scala 24:22]
  wire  accel_io_mem_r_bits_last; // @[memGenCacheShell.scala 24:22]
  wire  outArb_io_in_0_ready; // @[memGenCacheShell.scala 33:22]
  wire  outArb_io_in_0_valid; // @[memGenCacheShell.scala 33:22]
  wire [31:0] outArb_io_in_0_bits; // @[memGenCacheShell.scala 33:22]
  wire  outArb_io_out_ready; // @[memGenCacheShell.scala 33:22]
  wire  outArb_io_out_valid; // @[memGenCacheShell.scala 33:22]
  wire [31:0] outArb_io_out_bits; // @[memGenCacheShell.scala 33:22]
  wire  outAddrQueue_0_clock; // @[memGenCacheShell.scala 36:19]
  wire  outAddrQueue_0_reset; // @[memGenCacheShell.scala 36:19]
  wire  outAddrQueue_0_io_enq_ready; // @[memGenCacheShell.scala 36:19]
  wire  outAddrQueue_0_io_enq_valid; // @[memGenCacheShell.scala 36:19]
  wire [31:0] outAddrQueue_0_io_enq_bits; // @[memGenCacheShell.scala 36:19]
  wire  outAddrQueue_0_io_deq_ready; // @[memGenCacheShell.scala 36:19]
  wire  outAddrQueue_0_io_deq_valid; // @[memGenCacheShell.scala 36:19]
  wire [31:0] outAddrQueue_0_io_deq_bits; // @[memGenCacheShell.scala 36:19]
  wire  _T = io_in_bits_dataVals_field0_data == 64'h4; // @[memGenCacheShell.scala 47:54]
  wire [63:0] _GEN_1 = _T ? 64'h0 : io_in_bits_dataVals_field0_data; // @[memGenCacheShell.scala 47:68]
  memGenTopLevel accel ( // @[memGenCacheShell.scala 24:22]
    .clock(accel_clock),
    .reset(accel_reset),
    .io_instruction_0_ready(accel_io_instruction_0_ready),
    .io_instruction_0_valid(accel_io_instruction_0_valid),
    .io_instruction_0_bits_addr(accel_io_instruction_0_bits_addr),
    .io_instruction_0_bits_inst(accel_io_instruction_0_bits_inst),
    .io_instruction_0_bits_data(accel_io_instruction_0_bits_data),
    .io_resp_0_valid(accel_io_resp_0_valid),
    .io_resp_0_bits_addr(accel_io_resp_0_bits_addr),
    .io_events_bits_0(accel_io_events_bits_0),
    .io_events_bits_1(accel_io_events_bits_1),
    .io_events_bits_2(accel_io_events_bits_2),
    .io_events_bits_3(accel_io_events_bits_3),
    .io_events_bits_4(accel_io_events_bits_4),
    .io_events_bits_5(accel_io_events_bits_5),
    .io_mem_aw_ready(accel_io_mem_aw_ready),
    .io_mem_aw_valid(accel_io_mem_aw_valid),
    .io_mem_aw_bits_addr(accel_io_mem_aw_bits_addr),
    .io_mem_w_ready(accel_io_mem_w_ready),
    .io_mem_w_valid(accel_io_mem_w_valid),
    .io_mem_w_bits_data(accel_io_mem_w_bits_data),
    .io_mem_b_ready(accel_io_mem_b_ready),
    .io_mem_ar_ready(accel_io_mem_ar_ready),
    .io_mem_ar_valid(accel_io_mem_ar_valid),
    .io_mem_ar_bits_addr(accel_io_mem_ar_bits_addr),
    .io_mem_ar_bits_len(accel_io_mem_ar_bits_len),
    .io_mem_r_ready(accel_io_mem_r_ready),
    .io_mem_r_valid(accel_io_mem_r_valid),
    .io_mem_r_bits_data(accel_io_mem_r_bits_data),
    .io_mem_r_bits_last(accel_io_mem_r_bits_last)
  );
  Arbiter_6 outArb ( // @[memGenCacheShell.scala 33:22]
    .io_in_0_ready(outArb_io_in_0_ready),
    .io_in_0_valid(outArb_io_in_0_valid),
    .io_in_0_bits(outArb_io_in_0_bits),
    .io_out_ready(outArb_io_out_ready),
    .io_out_valid(outArb_io_out_valid),
    .io_out_bits(outArb_io_out_bits)
  );
  Queue_18 outAddrQueue_0 ( // @[memGenCacheShell.scala 36:19]
    .clock(outAddrQueue_0_clock),
    .reset(outAddrQueue_0_reset),
    .io_enq_ready(outAddrQueue_0_io_enq_ready),
    .io_enq_valid(outAddrQueue_0_io_enq_valid),
    .io_enq_bits(outAddrQueue_0_io_enq_bits),
    .io_deq_ready(outAddrQueue_0_io_deq_ready),
    .io_deq_valid(outAddrQueue_0_io_deq_valid),
    .io_deq_bits(outAddrQueue_0_io_deq_bits)
  );
  assign io_in_ready = accel_io_instruction_0_ready; // @[memGenCacheShell.scala 45:15 memGenCacheShell.scala 56:17]
  assign io_out_valid = outArb_io_out_valid; // @[memGenCacheShell.scala 74:16]
  assign io_out_bits_data_field1_data = outArb_io_out_bits; // @[memGenCacheShell.scala 75:35]
  assign io_events_bits_0 = accel_io_events_bits_0; // @[memGenCacheShell.scala 78:13]
  assign io_events_bits_1 = accel_io_events_bits_1; // @[memGenCacheShell.scala 78:13]
  assign io_events_bits_2 = accel_io_events_bits_2; // @[memGenCacheShell.scala 78:13]
  assign io_events_bits_3 = accel_io_events_bits_3; // @[memGenCacheShell.scala 78:13]
  assign io_events_bits_4 = accel_io_events_bits_4; // @[memGenCacheShell.scala 78:13]
  assign io_events_bits_5 = accel_io_events_bits_5; // @[memGenCacheShell.scala 78:13]
  assign io_mem_aw_valid = accel_io_mem_aw_valid; // @[memGenCacheShell.scala 80:10]
  assign io_mem_aw_bits_addr = accel_io_mem_aw_bits_addr; // @[memGenCacheShell.scala 80:10]
  assign io_mem_w_valid = accel_io_mem_w_valid; // @[memGenCacheShell.scala 80:10]
  assign io_mem_w_bits_data = accel_io_mem_w_bits_data; // @[memGenCacheShell.scala 80:10]
  assign io_mem_b_ready = accel_io_mem_b_ready; // @[memGenCacheShell.scala 80:10]
  assign io_mem_ar_valid = accel_io_mem_ar_valid; // @[memGenCacheShell.scala 80:10]
  assign io_mem_ar_bits_addr = accel_io_mem_ar_bits_addr; // @[memGenCacheShell.scala 80:10]
  assign io_mem_ar_bits_len = accel_io_mem_ar_bits_len; // @[memGenCacheShell.scala 80:10]
  assign io_mem_r_ready = accel_io_mem_r_ready; // @[memGenCacheShell.scala 80:10]
  assign accel_clock = clock;
  assign accel_reset = reset;
  assign accel_io_instruction_0_valid = io_in_valid; // @[memGenCacheShell.scala 39:41 memGenCacheShell.scala 57:41]
  assign accel_io_instruction_0_bits_addr = io_in_bits_dataVals_field1_data[31:0]; // @[memGenCacheShell.scala 41:45 memGenCacheShell.scala 58:45]
  assign accel_io_instruction_0_bits_inst = _GEN_1[7:0]; // @[memGenCacheShell.scala 40:45 memGenCacheShell.scala 50:47 memGenCacheShell.scala 52:49]
  assign accel_io_instruction_0_bits_data = io_in_bits_dataVals_field2_data; // @[memGenCacheShell.scala 42:45 memGenCacheShell.scala 59:45]
  assign accel_io_mem_aw_ready = io_mem_aw_ready; // @[memGenCacheShell.scala 80:10]
  assign accel_io_mem_w_ready = io_mem_w_ready; // @[memGenCacheShell.scala 80:10]
  assign accel_io_mem_ar_ready = io_mem_ar_ready; // @[memGenCacheShell.scala 80:10]
  assign accel_io_mem_r_valid = io_mem_r_valid; // @[memGenCacheShell.scala 80:10]
  assign accel_io_mem_r_bits_data = io_mem_r_bits_data; // @[memGenCacheShell.scala 80:10]
  assign accel_io_mem_r_bits_last = io_mem_r_bits_last; // @[memGenCacheShell.scala 80:10]
  assign outArb_io_in_0_valid = outAddrQueue_0_io_deq_valid; // @[memGenCacheShell.scala 71:21]
  assign outArb_io_in_0_bits = outAddrQueue_0_io_deq_bits; // @[memGenCacheShell.scala 71:21]
  assign outArb_io_out_ready = io_out_ready; // @[memGenCacheShell.scala 76:23]
  assign outAddrQueue_0_clock = clock;
  assign outAddrQueue_0_reset = reset;
  assign outAddrQueue_0_io_enq_valid = accel_io_resp_0_valid; // @[memGenCacheShell.scala 68:34]
  assign outAddrQueue_0_io_enq_bits = accel_io_resp_0_valid ? accel_io_resp_0_bits_addr : 32'h0; // @[memGenCacheShell.scala 67:33]
  assign outAddrQueue_0_io_deq_ready = outArb_io_in_0_ready; // @[memGenCacheShell.scala 71:21]
endmodule
module Queue_19(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [63:0] io_enq_bits_data,
  input         io_deq_ready,
  output        io_deq_valid,
  output [63:0] io_deq_bits_data
);
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [63:0] _RAND_1;
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  reg [63:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [63:0] ram_data [0:999999]; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_11_data; // @[Decoupled.scala 209:16]
  wire [19:0] ram_data__T_11_addr; // @[Decoupled.scala 209:16]
  wire [63:0] ram_data__T_3_data; // @[Decoupled.scala 209:16]
  wire [19:0] ram_data__T_3_addr; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_mask; // @[Decoupled.scala 209:16]
  wire  ram_data__T_3_en; // @[Decoupled.scala 209:16]
  reg [19:0] enq_ptr_value; // @[Counter.scala 29:33]
  reg [19:0] deq_ptr_value; // @[Counter.scala 29:33]
  reg  maybe_full; // @[Decoupled.scala 212:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 214:33]
  wire  _T = ~maybe_full; // @[Decoupled.scala 215:28]
  wire  empty = ptr_match & _T; // @[Decoupled.scala 215:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 216:24]
  wire  _T_1 = io_enq_ready & io_enq_valid; // @[Decoupled.scala 40:37]
  wire  _T_2 = io_deq_ready & io_deq_valid; // @[Decoupled.scala 40:37]
  wire  wrap = enq_ptr_value == 20'hf423f; // @[Counter.scala 38:24]
  wire [19:0] _T_5 = enq_ptr_value + 20'h1; // @[Counter.scala 39:22]
  wire  _GEN_13 = io_deq_ready ? 1'h0 : _T_1; // @[Decoupled.scala 240:27]
  wire  do_enq = empty ? _GEN_13 : _T_1; // @[Decoupled.scala 237:18]
  wire  wrap_1 = deq_ptr_value == 20'hf423f; // @[Counter.scala 38:24]
  wire [19:0] _T_7 = deq_ptr_value + 20'h1; // @[Counter.scala 39:22]
  wire  do_deq = empty ? 1'h0 : _T_2; // @[Decoupled.scala 237:18]
  wire  _T_8 = do_enq != do_deq; // @[Decoupled.scala 227:16]
  wire  _T_9 = ~empty; // @[Decoupled.scala 231:19]
  wire  _T_10 = ~full; // @[Decoupled.scala 232:19]
  assign ram_data__T_11_addr = deq_ptr_value;
  `ifndef RANDOMIZE_GARBAGE_ASSIGN
  assign ram_data__T_11_data = ram_data[ram_data__T_11_addr]; // @[Decoupled.scala 209:16]
  `else
  assign ram_data__T_11_data = ram_data__T_11_addr >= 20'hf4240 ? _RAND_1[63:0] : ram_data[ram_data__T_11_addr]; // @[Decoupled.scala 209:16]
  `endif // RANDOMIZE_GARBAGE_ASSIGN
  assign ram_data__T_3_data = io_enq_bits_data;
  assign ram_data__T_3_addr = enq_ptr_value;
  assign ram_data__T_3_mask = 1'h1;
  assign ram_data__T_3_en = empty ? _GEN_13 : _T_1;
  assign io_enq_ready = io_deq_ready | _T_10; // @[Decoupled.scala 232:16 Decoupled.scala 245:40]
  assign io_deq_valid = io_enq_valid | _T_9; // @[Decoupled.scala 231:16 Decoupled.scala 236:40]
  assign io_deq_bits_data = empty ? io_enq_bits_data : ram_data__T_11_data; // @[Decoupled.scala 233:15 Decoupled.scala 238:19]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_GARBAGE_ASSIGN
  _RAND_1 = {2{`RANDOM}};
`endif // RANDOMIZE_GARBAGE_ASSIGN
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {2{`RANDOM}};
  for (initvar = 0; initvar < 1000000; initvar = initvar+1)
    ram_data[initvar] = _RAND_0[63:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  enq_ptr_value = _RAND_2[19:0];
  _RAND_3 = {1{`RANDOM}};
  deq_ptr_value = _RAND_3[19:0];
  _RAND_4 = {1{`RANDOM}};
  maybe_full = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if(ram_data__T_3_en & ram_data__T_3_mask) begin
      ram_data[ram_data__T_3_addr] <= ram_data__T_3_data; // @[Decoupled.scala 209:16]
    end
    if (reset) begin
      enq_ptr_value <= 20'h0;
    end else if (do_enq) begin
      if (wrap) begin
        enq_ptr_value <= 20'h0;
      end else begin
        enq_ptr_value <= _T_5;
      end
    end
    if (reset) begin
      deq_ptr_value <= 20'h0;
    end else if (do_deq) begin
      if (wrap_1) begin
        deq_ptr_value <= 20'h0;
      end else begin
        deq_ptr_value <= _T_7;
      end
    end
    if (reset) begin
      maybe_full <= 1'h0;
    end else if (_T_8) begin
      if (empty) begin
        if (io_deq_ready) begin
          maybe_full <= 1'h0;
        end else begin
          maybe_full <= _T_1;
        end
      end else begin
        maybe_full <= _T_1;
      end
    end
  end
endmodule
module memGenDCRCacheShell(
  input         clock,
  input         reset,
  output        io_host_aw_ready,
  input         io_host_aw_valid,
  input  [31:0] io_host_aw_bits_addr,
  output        io_host_w_ready,
  input         io_host_w_valid,
  input  [63:0] io_host_w_bits_data,
  input         io_host_b_ready,
  output        io_host_b_valid,
  output        io_host_ar_ready,
  input         io_host_ar_valid,
  input  [31:0] io_host_ar_bits_addr,
  input         io_host_r_ready,
  output        io_host_r_valid,
  output [63:0] io_host_r_bits_data,
  input         io_mem_aw_ready,
  output        io_mem_aw_valid,
  output [31:0] io_mem_aw_bits_addr,
  output [31:0] io_mem_aw_bits_len,
  input         io_mem_w_ready,
  output        io_mem_w_valid,
  output [63:0] io_mem_w_bits_data,
  output        io_mem_w_bits_last,
  output        io_mem_b_ready,
  input         io_mem_b_valid,
  input         io_mem_ar_ready,
  output        io_mem_ar_valid,
  output [31:0] io_mem_ar_bits_addr,
  output [31:0] io_mem_ar_bits_len,
  output        io_mem_r_ready,
  input         io_mem_r_valid,
  input  [63:0] io_mem_r_bits_data,
  input         io_mem_r_bits_last
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
`endif // RANDOMIZE_REG_INIT
  wire  vcr_clock; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_reset; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_host_aw_ready; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_host_aw_valid; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_host_aw_bits_addr; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_host_w_ready; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_host_w_valid; // @[memGenDCRCacheShell.scala 37:19]
  wire [63:0] vcr_io_host_w_bits_data; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_host_b_ready; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_host_b_valid; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_host_ar_ready; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_host_ar_valid; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_host_ar_bits_addr; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_host_r_ready; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_host_r_valid; // @[memGenDCRCacheShell.scala 37:19]
  wire [63:0] vcr_io_host_r_bits_data; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_dcr_launch; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_dcr_finish; // @[memGenDCRCacheShell.scala 37:19]
  wire  vcr_io_dcr_ecnt_0_valid; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_dcr_ecnt_0_bits; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_dcr_ecnt_1_bits; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_dcr_ecnt_2_bits; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_dcr_ecnt_3_bits; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_dcr_ecnt_4_bits; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_dcr_ecnt_5_bits; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_dcr_ecnt_6_bits; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_dcr_vals_0; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_dcr_ptrs_0; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_dcr_ptrs_1; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_dcr_ptrs_2; // @[memGenDCRCacheShell.scala 37:19]
  wire [31:0] vcr_io_dcr_ptrs_3; // @[memGenDCRCacheShell.scala 37:19]
  wire  dmem_clock; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_reset; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_mem_aw_ready; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_mem_aw_valid; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_mem_w_ready; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_mem_w_valid; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_mem_w_bits_last; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_mem_b_ready; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_mem_b_valid; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_mem_ar_ready; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_mem_ar_valid; // @[memGenDCRCacheShell.scala 38:20]
  wire [31:0] dmem_io_mem_ar_bits_addr; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_mem_r_ready; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_mem_r_valid; // @[memGenDCRCacheShell.scala 38:20]
  wire [63:0] dmem_io_mem_r_bits_data; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_mem_r_bits_last; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_dme_rd_0_cmd_valid; // @[memGenDCRCacheShell.scala 38:20]
  wire [31:0] dmem_io_dme_rd_0_cmd_bits_addr; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_dme_rd_0_data_ready; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_dme_rd_0_data_valid; // @[memGenDCRCacheShell.scala 38:20]
  wire [63:0] dmem_io_dme_rd_0_data_bits; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_dme_rd_1_cmd_valid; // @[memGenDCRCacheShell.scala 38:20]
  wire [31:0] dmem_io_dme_rd_1_cmd_bits_addr; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_dme_rd_1_data_ready; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_dme_rd_1_data_valid; // @[memGenDCRCacheShell.scala 38:20]
  wire [63:0] dmem_io_dme_rd_1_data_bits; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_dme_rd_2_cmd_valid; // @[memGenDCRCacheShell.scala 38:20]
  wire [31:0] dmem_io_dme_rd_2_cmd_bits_addr; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_dme_rd_2_data_ready; // @[memGenDCRCacheShell.scala 38:20]
  wire  dmem_io_dme_rd_2_data_valid; // @[memGenDCRCacheShell.scala 38:20]
  wire [63:0] dmem_io_dme_rd_2_data_bits; // @[memGenDCRCacheShell.scala 38:20]
  wire  accel_clock; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_reset; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_in_ready; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_in_valid; // @[memGenDCRCacheShell.scala 40:21]
  wire [63:0] accel_io_in_bits_dataVals_field2_data; // @[memGenDCRCacheShell.scala 40:21]
  wire [63:0] accel_io_in_bits_dataVals_field1_data; // @[memGenDCRCacheShell.scala 40:21]
  wire [63:0] accel_io_in_bits_dataVals_field0_data; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_out_ready; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_out_valid; // @[memGenDCRCacheShell.scala 40:21]
  wire [31:0] accel_io_out_bits_data_field1_data; // @[memGenDCRCacheShell.scala 40:21]
  wire [31:0] accel_io_events_bits_0; // @[memGenDCRCacheShell.scala 40:21]
  wire [31:0] accel_io_events_bits_1; // @[memGenDCRCacheShell.scala 40:21]
  wire [31:0] accel_io_events_bits_2; // @[memGenDCRCacheShell.scala 40:21]
  wire [31:0] accel_io_events_bits_3; // @[memGenDCRCacheShell.scala 40:21]
  wire [31:0] accel_io_events_bits_4; // @[memGenDCRCacheShell.scala 40:21]
  wire [31:0] accel_io_events_bits_5; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_mem_aw_ready; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_mem_aw_valid; // @[memGenDCRCacheShell.scala 40:21]
  wire [31:0] accel_io_mem_aw_bits_addr; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_mem_w_ready; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_mem_w_valid; // @[memGenDCRCacheShell.scala 40:21]
  wire [63:0] accel_io_mem_w_bits_data; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_mem_b_ready; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_mem_ar_ready; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_mem_ar_valid; // @[memGenDCRCacheShell.scala 40:21]
  wire [31:0] accel_io_mem_ar_bits_addr; // @[memGenDCRCacheShell.scala 40:21]
  wire [15:0] accel_io_mem_ar_bits_len; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_mem_r_ready; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_mem_r_valid; // @[memGenDCRCacheShell.scala 40:21]
  wire [63:0] accel_io_mem_r_bits_data; // @[memGenDCRCacheShell.scala 40:21]
  wire  accel_io_mem_r_bits_last; // @[memGenDCRCacheShell.scala 40:21]
  wire  inputQ_0_clock; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_0_reset; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_0_io_enq_ready; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_0_io_enq_valid; // @[memGenDCRCacheShell.scala 113:25]
  wire [63:0] inputQ_0_io_enq_bits_data; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_0_io_deq_ready; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_0_io_deq_valid; // @[memGenDCRCacheShell.scala 113:25]
  wire [63:0] inputQ_0_io_deq_bits_data; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_1_clock; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_1_reset; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_1_io_enq_ready; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_1_io_enq_valid; // @[memGenDCRCacheShell.scala 113:25]
  wire [63:0] inputQ_1_io_enq_bits_data; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_1_io_deq_ready; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_1_io_deq_valid; // @[memGenDCRCacheShell.scala 113:25]
  wire [63:0] inputQ_1_io_deq_bits_data; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_2_clock; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_2_reset; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_2_io_enq_ready; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_2_io_enq_valid; // @[memGenDCRCacheShell.scala 113:25]
  wire [63:0] inputQ_2_io_enq_bits_data; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_2_io_deq_ready; // @[memGenDCRCacheShell.scala 113:25]
  wire  inputQ_2_io_deq_valid; // @[memGenDCRCacheShell.scala 113:25]
  wire [63:0] inputQ_2_io_deq_bits_data; // @[memGenDCRCacheShell.scala 113:25]
  reg [2:0] state; // @[memGenDCRCacheShell.scala 46:22]
  reg [31:0] cycles; // @[memGenDCRCacheShell.scala 47:23]
  wire  last = state == 3'h5; // @[memGenDCRCacheShell.scala 48:20]
  wire  is_busy = state == 3'h2; // @[memGenDCRCacheShell.scala 49:23]
  reg [31:0] lastCycle; // @[memGenDCRCacheShell.scala 53:21]
  reg [14:0] cycle; // @[Counter.scala 29:33]
  wire  _T_1 = cycle == 15'h752f; // @[Counter.scala 38:24]
  wire [14:0] _T_3 = cycle + 15'h1; // @[Counter.scala 39:22]
  wire  stopSim = last & _T_1; // @[Counter.scala 67:17]
  wire  _T_4 = state == 3'h0; // @[memGenDCRCacheShell.scala 74:128]
  reg [63:0] vals_0; // @[Reg.scala 27:20]
  reg [63:0] ptrs_0; // @[Reg.scala 27:20]
  wire  _T_75 = 3'h0 == state; // @[Conditional.scala 37:30]
  wire  _T_76 = 3'h1 == state; // @[Conditional.scala 37:30]
  wire  _T_77 = 3'h2 == state; // @[Conditional.scala 37:30]
  wire  _T_78 = ~inputQ_0_io_deq_valid; // @[memGenDCRCacheShell.scala 169:37]
  wire  _T_79 = inputQ_0_io_deq_bits_data == 64'h2; // @[memGenDCRCacheShell.scala 171:54]
  wire  _T_82 = inputQ_0_io_deq_bits_data == 64'h4; // @[memGenDCRCacheShell.scala 174:53]
  wire  _T_83 = accel_io_in_ready & accel_io_in_valid; // @[Decoupled.scala 40:37]
  wire  _GEN_28 = _T_82 | _T_83; // @[memGenDCRCacheShell.scala 174:66]
  wire  _GEN_31 = _T_79 ? 1'h0 : _GEN_28; // @[memGenDCRCacheShell.scala 171:68]
  wire  _GEN_34 = _T_78 ? 1'h0 : _GEN_31; // @[memGenDCRCacheShell.scala 169:93]
  wire  _T_86 = 3'h4 == state; // @[Conditional.scala 37:30]
  reg [19:0] ackCounter; // @[Counter.scala 29:33]
  wire [63:0] _GEN_112 = {{44'd0}, ackCounter}; // @[memGenDCRCacheShell.scala 186:26]
  wire  _T_87 = _GEN_112 >= inputQ_2_io_deq_bits_data; // @[memGenDCRCacheShell.scala 186:26]
  wire  _GEN_41 = _T_86 & _T_87; // @[Conditional.scala 39:67]
  wire  _GEN_43 = _T_77 ? _GEN_34 : _GEN_41; // @[Conditional.scala 39:67]
  wire  _GEN_47 = _T_76 ? 1'h0 : _GEN_43; // @[Conditional.scala 39:67]
  wire  _T_19 = ackCounter == 20'hf423f; // @[Counter.scala 38:24]
  wire [19:0] _T_21 = ackCounter + 20'h1; // @[Counter.scala 39:22]
  wire  _GEN_45 = _T_77 ? 1'h0 : _GEN_41; // @[Conditional.scala 39:67]
  wire  _GEN_49 = _T_76 ? 1'h0 : _GEN_45; // @[Conditional.scala 39:67]
  wire  resetAckCounter = _T_75 ? 1'h0 : _GEN_49; // @[Conditional.scala 40:58]
  reg [31:0] fillCounter; // @[memGenDCRCacheShell.scala 79:28]
  wire  _T_22 = dmem_io_mem_r_ready & dmem_io_mem_r_valid; // @[Decoupled.scala 40:37]
  reg [31:0] _T_29; // @[memGenDCRCacheShell.scala 92:22]
  wire [63:0] _T_30 = vals_0 / 64'h1; // @[memGenDCRCacheShell.scala 92:50]
  wire [63:0] _T_32 = _T_30 - 64'h1; // @[memGenDCRCacheShell.scala 92:61]
  wire [63:0] _GEN_113 = {{32'd0}, _T_29}; // @[memGenDCRCacheShell.scala 92:36]
  wire  fillWrap = _GEN_113 == _T_32; // @[memGenDCRCacheShell.scala 92:36]
  wire  _T_23 = fillWrap & _T_22; // @[memGenDCRCacheShell.scala 85:18]
  wire  _T_24 = _T_23 & dmem_io_mem_r_bits_last; // @[memGenDCRCacheShell.scala 85:42]
  wire  _T_26 = _T_22 & dmem_io_mem_r_bits_last; // @[memGenDCRCacheShell.scala 87:35]
  wire [31:0] _T_28 = fillCounter + 32'h1; // @[memGenDCRCacheShell.scala 88:32]
  reg [1:0] numQ; // @[Counter.scala 29:33]
  wire [1:0] _T_40 = numQ + 2'h1; // @[Counter.scala 39:22]
  wire  _T_43 = numQ == 2'h2; // @[memGenDCRCacheShell.scala 95:72]
  wire  _T_44 = _T_26 & _T_43; // @[memGenDCRCacheShell.scala 95:64]
  wire  goToBusy = _T_44 & fillWrap; // @[memGenDCRCacheShell.scala 95:80]
  wire [31:0] _T_47 = cycles + 32'h1; // @[memGenDCRCacheShell.scala 100:22]
  wire  _T_48 = accel_io_out_ready & accel_io_out_valid; // @[Decoupled.scala 40:37]
  wire  _T_50 = ~reset; // @[memGenDCRCacheShell.scala 107:13]
  wire [32:0] _T_53 = fillCounter * 32'h1; // @[memGenDCRCacheShell.scala 120:79]
  wire [36:0] _T_54 = _T_53 * 33'h8; // @[memGenDCRCacheShell.scala 120:89]
  wire [36:0] _GEN_114 = {{5'd0}, vcr_io_dcr_ptrs_1}; // @[memGenDCRCacheShell.scala 120:65]
  wire [36:0] _T_56 = _GEN_114 + _T_54; // @[memGenDCRCacheShell.scala 120:65]
  wire [36:0] _GEN_115 = {{5'd0}, vcr_io_dcr_ptrs_2}; // @[memGenDCRCacheShell.scala 120:65]
  wire [36:0] _T_61 = _GEN_115 + _T_54; // @[memGenDCRCacheShell.scala 120:65]
  wire [36:0] _GEN_116 = {{5'd0}, vcr_io_dcr_ptrs_3}; // @[memGenDCRCacheShell.scala 120:65]
  wire [36:0] _T_66 = _GEN_116 + _T_54; // @[memGenDCRCacheShell.scala 120:65]
  wire  _T_68 = state == 3'h1; // @[memGenDCRCacheShell.scala 131:47]
  wire  _GEN_117 = 2'h0 == numQ; // @[memGenDCRCacheShell.scala 131:36]
  wire  _GEN_118 = 2'h1 == numQ; // @[memGenDCRCacheShell.scala 131:36]
  wire  _GEN_119 = 2'h2 == numQ; // @[memGenDCRCacheShell.scala 131:36]
  wire  _T_69 = inputQ_0_io_deq_bits_data == 64'h0; // @[memGenDCRCacheShell.scala 143:36]
  wire  _T_72 = is_busy | last; // @[memGenDCRCacheShell.scala 151:33]
  wire  _T_73 = state == 3'h4; // @[memGenDCRCacheShell.scala 151:59]
  wire  _GEN_29 = _T_82 ? 1'h0 : 1'h1; // @[memGenDCRCacheShell.scala 174:66]
  wire  _GEN_32 = _T_79 ? 1'h0 : _GEN_29; // @[memGenDCRCacheShell.scala 171:68]
  wire  _GEN_35 = _T_78 ? 1'h0 : _GEN_32; // @[memGenDCRCacheShell.scala 169:93]
  wire  _T_88 = 3'h5 == state; // @[Conditional.scala 37:30]
  wire  _GEN_44 = _T_77 & _GEN_35; // @[Conditional.scala 39:67]
  wire  _GEN_48 = _T_76 ? 1'h0 : _GEN_44; // @[Conditional.scala 39:67]
  wire  _GEN_123 = ~_T_75; // @[memGenDCRCacheShell.scala 173:17]
  wire  _GEN_124 = ~_T_76; // @[memGenDCRCacheShell.scala 173:17]
  wire  _GEN_125 = _GEN_123 & _GEN_124; // @[memGenDCRCacheShell.scala 173:17]
  wire  _GEN_126 = _GEN_125 & _T_77; // @[memGenDCRCacheShell.scala 173:17]
  wire  _GEN_127 = ~_T_78; // @[memGenDCRCacheShell.scala 173:17]
  wire  _GEN_128 = _GEN_126 & _GEN_127; // @[memGenDCRCacheShell.scala 173:17]
  wire  _GEN_129 = _GEN_128 & _T_79; // @[memGenDCRCacheShell.scala 173:17]
  wire  _GEN_136 = ~_T_79; // @[memGenDCRCacheShell.scala 179:21]
  wire  _GEN_137 = _GEN_128 & _GEN_136; // @[memGenDCRCacheShell.scala 179:21]
  wire  _GEN_138 = ~_T_82; // @[memGenDCRCacheShell.scala 179:21]
  wire  _GEN_139 = _GEN_137 & _GEN_138; // @[memGenDCRCacheShell.scala 179:21]
  wire  _GEN_140 = _GEN_139 & _T_83; // @[memGenDCRCacheShell.scala 179:21]
  DCR vcr ( // @[memGenDCRCacheShell.scala 37:19]
    .clock(vcr_clock),
    .reset(vcr_reset),
    .io_host_aw_ready(vcr_io_host_aw_ready),
    .io_host_aw_valid(vcr_io_host_aw_valid),
    .io_host_aw_bits_addr(vcr_io_host_aw_bits_addr),
    .io_host_w_ready(vcr_io_host_w_ready),
    .io_host_w_valid(vcr_io_host_w_valid),
    .io_host_w_bits_data(vcr_io_host_w_bits_data),
    .io_host_b_ready(vcr_io_host_b_ready),
    .io_host_b_valid(vcr_io_host_b_valid),
    .io_host_ar_ready(vcr_io_host_ar_ready),
    .io_host_ar_valid(vcr_io_host_ar_valid),
    .io_host_ar_bits_addr(vcr_io_host_ar_bits_addr),
    .io_host_r_ready(vcr_io_host_r_ready),
    .io_host_r_valid(vcr_io_host_r_valid),
    .io_host_r_bits_data(vcr_io_host_r_bits_data),
    .io_dcr_launch(vcr_io_dcr_launch),
    .io_dcr_finish(vcr_io_dcr_finish),
    .io_dcr_ecnt_0_valid(vcr_io_dcr_ecnt_0_valid),
    .io_dcr_ecnt_0_bits(vcr_io_dcr_ecnt_0_bits),
    .io_dcr_ecnt_1_bits(vcr_io_dcr_ecnt_1_bits),
    .io_dcr_ecnt_2_bits(vcr_io_dcr_ecnt_2_bits),
    .io_dcr_ecnt_3_bits(vcr_io_dcr_ecnt_3_bits),
    .io_dcr_ecnt_4_bits(vcr_io_dcr_ecnt_4_bits),
    .io_dcr_ecnt_5_bits(vcr_io_dcr_ecnt_5_bits),
    .io_dcr_ecnt_6_bits(vcr_io_dcr_ecnt_6_bits),
    .io_dcr_vals_0(vcr_io_dcr_vals_0),
    .io_dcr_ptrs_0(vcr_io_dcr_ptrs_0),
    .io_dcr_ptrs_1(vcr_io_dcr_ptrs_1),
    .io_dcr_ptrs_2(vcr_io_dcr_ptrs_2),
    .io_dcr_ptrs_3(vcr_io_dcr_ptrs_3)
  );
  DME dmem ( // @[memGenDCRCacheShell.scala 38:20]
    .clock(dmem_clock),
    .reset(dmem_reset),
    .io_mem_aw_ready(dmem_io_mem_aw_ready),
    .io_mem_aw_valid(dmem_io_mem_aw_valid),
    .io_mem_w_ready(dmem_io_mem_w_ready),
    .io_mem_w_valid(dmem_io_mem_w_valid),
    .io_mem_w_bits_last(dmem_io_mem_w_bits_last),
    .io_mem_b_ready(dmem_io_mem_b_ready),
    .io_mem_b_valid(dmem_io_mem_b_valid),
    .io_mem_ar_ready(dmem_io_mem_ar_ready),
    .io_mem_ar_valid(dmem_io_mem_ar_valid),
    .io_mem_ar_bits_addr(dmem_io_mem_ar_bits_addr),
    .io_mem_r_ready(dmem_io_mem_r_ready),
    .io_mem_r_valid(dmem_io_mem_r_valid),
    .io_mem_r_bits_data(dmem_io_mem_r_bits_data),
    .io_mem_r_bits_last(dmem_io_mem_r_bits_last),
    .io_dme_rd_0_cmd_valid(dmem_io_dme_rd_0_cmd_valid),
    .io_dme_rd_0_cmd_bits_addr(dmem_io_dme_rd_0_cmd_bits_addr),
    .io_dme_rd_0_data_ready(dmem_io_dme_rd_0_data_ready),
    .io_dme_rd_0_data_valid(dmem_io_dme_rd_0_data_valid),
    .io_dme_rd_0_data_bits(dmem_io_dme_rd_0_data_bits),
    .io_dme_rd_1_cmd_valid(dmem_io_dme_rd_1_cmd_valid),
    .io_dme_rd_1_cmd_bits_addr(dmem_io_dme_rd_1_cmd_bits_addr),
    .io_dme_rd_1_data_ready(dmem_io_dme_rd_1_data_ready),
    .io_dme_rd_1_data_valid(dmem_io_dme_rd_1_data_valid),
    .io_dme_rd_1_data_bits(dmem_io_dme_rd_1_data_bits),
    .io_dme_rd_2_cmd_valid(dmem_io_dme_rd_2_cmd_valid),
    .io_dme_rd_2_cmd_bits_addr(dmem_io_dme_rd_2_cmd_bits_addr),
    .io_dme_rd_2_data_ready(dmem_io_dme_rd_2_data_ready),
    .io_dme_rd_2_data_valid(dmem_io_dme_rd_2_data_valid),
    .io_dme_rd_2_data_bits(dmem_io_dme_rd_2_data_bits)
  );
  memGenAccel accel ( // @[memGenDCRCacheShell.scala 40:21]
    .clock(accel_clock),
    .reset(accel_reset),
    .io_in_ready(accel_io_in_ready),
    .io_in_valid(accel_io_in_valid),
    .io_in_bits_dataVals_field2_data(accel_io_in_bits_dataVals_field2_data),
    .io_in_bits_dataVals_field1_data(accel_io_in_bits_dataVals_field1_data),
    .io_in_bits_dataVals_field0_data(accel_io_in_bits_dataVals_field0_data),
    .io_out_ready(accel_io_out_ready),
    .io_out_valid(accel_io_out_valid),
    .io_out_bits_data_field1_data(accel_io_out_bits_data_field1_data),
    .io_events_bits_0(accel_io_events_bits_0),
    .io_events_bits_1(accel_io_events_bits_1),
    .io_events_bits_2(accel_io_events_bits_2),
    .io_events_bits_3(accel_io_events_bits_3),
    .io_events_bits_4(accel_io_events_bits_4),
    .io_events_bits_5(accel_io_events_bits_5),
    .io_mem_aw_ready(accel_io_mem_aw_ready),
    .io_mem_aw_valid(accel_io_mem_aw_valid),
    .io_mem_aw_bits_addr(accel_io_mem_aw_bits_addr),
    .io_mem_w_ready(accel_io_mem_w_ready),
    .io_mem_w_valid(accel_io_mem_w_valid),
    .io_mem_w_bits_data(accel_io_mem_w_bits_data),
    .io_mem_b_ready(accel_io_mem_b_ready),
    .io_mem_ar_ready(accel_io_mem_ar_ready),
    .io_mem_ar_valid(accel_io_mem_ar_valid),
    .io_mem_ar_bits_addr(accel_io_mem_ar_bits_addr),
    .io_mem_ar_bits_len(accel_io_mem_ar_bits_len),
    .io_mem_r_ready(accel_io_mem_r_ready),
    .io_mem_r_valid(accel_io_mem_r_valid),
    .io_mem_r_bits_data(accel_io_mem_r_bits_data),
    .io_mem_r_bits_last(accel_io_mem_r_bits_last)
  );
  Queue_19 inputQ_0 ( // @[memGenDCRCacheShell.scala 113:25]
    .clock(inputQ_0_clock),
    .reset(inputQ_0_reset),
    .io_enq_ready(inputQ_0_io_enq_ready),
    .io_enq_valid(inputQ_0_io_enq_valid),
    .io_enq_bits_data(inputQ_0_io_enq_bits_data),
    .io_deq_ready(inputQ_0_io_deq_ready),
    .io_deq_valid(inputQ_0_io_deq_valid),
    .io_deq_bits_data(inputQ_0_io_deq_bits_data)
  );
  Queue_19 inputQ_1 ( // @[memGenDCRCacheShell.scala 113:25]
    .clock(inputQ_1_clock),
    .reset(inputQ_1_reset),
    .io_enq_ready(inputQ_1_io_enq_ready),
    .io_enq_valid(inputQ_1_io_enq_valid),
    .io_enq_bits_data(inputQ_1_io_enq_bits_data),
    .io_deq_ready(inputQ_1_io_deq_ready),
    .io_deq_valid(inputQ_1_io_deq_valid),
    .io_deq_bits_data(inputQ_1_io_deq_bits_data)
  );
  Queue_19 inputQ_2 ( // @[memGenDCRCacheShell.scala 113:25]
    .clock(inputQ_2_clock),
    .reset(inputQ_2_reset),
    .io_enq_ready(inputQ_2_io_enq_ready),
    .io_enq_valid(inputQ_2_io_enq_valid),
    .io_enq_bits_data(inputQ_2_io_enq_bits_data),
    .io_deq_ready(inputQ_2_io_deq_ready),
    .io_deq_valid(inputQ_2_io_deq_valid),
    .io_deq_bits_data(inputQ_2_io_deq_bits_data)
  );
  assign io_host_aw_ready = vcr_io_host_aw_ready; // @[memGenDCRCacheShell.scala 210:11]
  assign io_host_w_ready = vcr_io_host_w_ready; // @[memGenDCRCacheShell.scala 210:11]
  assign io_host_b_valid = vcr_io_host_b_valid; // @[memGenDCRCacheShell.scala 210:11]
  assign io_host_ar_ready = vcr_io_host_ar_ready; // @[memGenDCRCacheShell.scala 210:11]
  assign io_host_r_valid = vcr_io_host_r_valid; // @[memGenDCRCacheShell.scala 210:11]
  assign io_host_r_bits_data = vcr_io_host_r_bits_data; // @[memGenDCRCacheShell.scala 210:11]
  assign io_mem_aw_valid = _T_68 ? dmem_io_mem_aw_valid : accel_io_mem_aw_valid; // @[memGenDCRCacheShell.scala 203:12 memGenDCRCacheShell.scala 206:13]
  assign io_mem_aw_bits_addr = _T_68 ? 32'h0 : accel_io_mem_aw_bits_addr; // @[memGenDCRCacheShell.scala 203:12 memGenDCRCacheShell.scala 206:13]
  assign io_mem_aw_bits_len = _T_68 ? 32'h0 : 32'h1; // @[memGenDCRCacheShell.scala 203:12 memGenDCRCacheShell.scala 206:13]
  assign io_mem_w_valid = _T_68 ? 1'h0 : accel_io_mem_w_valid; // @[memGenDCRCacheShell.scala 203:12 memGenDCRCacheShell.scala 206:13]
  assign io_mem_w_bits_data = _T_68 ? 64'h0 : accel_io_mem_w_bits_data; // @[memGenDCRCacheShell.scala 203:12 memGenDCRCacheShell.scala 206:13]
  assign io_mem_w_bits_last = _T_68 & dmem_io_mem_w_bits_last; // @[memGenDCRCacheShell.scala 203:12 memGenDCRCacheShell.scala 206:13]
  assign io_mem_b_ready = _T_68 ? dmem_io_mem_b_ready : accel_io_mem_b_ready; // @[memGenDCRCacheShell.scala 203:12 memGenDCRCacheShell.scala 206:13]
  assign io_mem_ar_valid = _T_68 ? dmem_io_mem_ar_valid : accel_io_mem_ar_valid; // @[memGenDCRCacheShell.scala 203:12 memGenDCRCacheShell.scala 206:13]
  assign io_mem_ar_bits_addr = _T_68 ? dmem_io_mem_ar_bits_addr : accel_io_mem_ar_bits_addr; // @[memGenDCRCacheShell.scala 203:12 memGenDCRCacheShell.scala 206:13]
  assign io_mem_ar_bits_len = _T_68 ? 32'h0 : {{16'd0}, accel_io_mem_ar_bits_len}; // @[memGenDCRCacheShell.scala 203:12 memGenDCRCacheShell.scala 206:13]
  assign io_mem_r_ready = _T_68 ? dmem_io_mem_r_ready : accel_io_mem_r_ready; // @[memGenDCRCacheShell.scala 203:12 memGenDCRCacheShell.scala 206:13]
  assign vcr_clock = clock;
  assign vcr_reset = reset;
  assign vcr_io_host_aw_valid = io_host_aw_valid; // @[memGenDCRCacheShell.scala 210:11]
  assign vcr_io_host_aw_bits_addr = io_host_aw_bits_addr; // @[memGenDCRCacheShell.scala 210:11]
  assign vcr_io_host_w_valid = io_host_w_valid; // @[memGenDCRCacheShell.scala 210:11]
  assign vcr_io_host_w_bits_data = io_host_w_bits_data; // @[memGenDCRCacheShell.scala 210:11]
  assign vcr_io_host_b_ready = io_host_b_ready; // @[memGenDCRCacheShell.scala 210:11]
  assign vcr_io_host_ar_valid = io_host_ar_valid; // @[memGenDCRCacheShell.scala 210:11]
  assign vcr_io_host_ar_bits_addr = io_host_ar_bits_addr; // @[memGenDCRCacheShell.scala 210:11]
  assign vcr_io_host_r_ready = io_host_r_ready; // @[memGenDCRCacheShell.scala 210:11]
  assign vcr_io_dcr_finish = last & stopSim; // @[memGenDCRCacheShell.scala 200:21]
  assign vcr_io_dcr_ecnt_0_valid = state == 3'h5; // @[memGenDCRCacheShell.scala 103:27]
  assign vcr_io_dcr_ecnt_0_bits = lastCycle; // @[memGenDCRCacheShell.scala 104:26]
  assign vcr_io_dcr_ecnt_1_bits = accel_io_events_bits_0; // @[memGenDCRCacheShell.scala 63:31]
  assign vcr_io_dcr_ecnt_2_bits = accel_io_events_bits_1; // @[memGenDCRCacheShell.scala 63:31]
  assign vcr_io_dcr_ecnt_3_bits = accel_io_events_bits_2; // @[memGenDCRCacheShell.scala 63:31]
  assign vcr_io_dcr_ecnt_4_bits = accel_io_events_bits_3; // @[memGenDCRCacheShell.scala 63:31]
  assign vcr_io_dcr_ecnt_5_bits = accel_io_events_bits_4; // @[memGenDCRCacheShell.scala 63:31]
  assign vcr_io_dcr_ecnt_6_bits = accel_io_events_bits_5; // @[memGenDCRCacheShell.scala 63:31]
  assign dmem_clock = clock;
  assign dmem_reset = reset;
  assign dmem_io_mem_aw_ready = io_mem_aw_ready; // @[memGenDCRCacheShell.scala 203:12]
  assign dmem_io_mem_w_ready = io_mem_w_ready; // @[memGenDCRCacheShell.scala 203:12]
  assign dmem_io_mem_b_valid = io_mem_b_valid; // @[memGenDCRCacheShell.scala 203:12]
  assign dmem_io_mem_ar_ready = io_mem_ar_ready; // @[memGenDCRCacheShell.scala 203:12]
  assign dmem_io_mem_r_valid = io_mem_r_valid; // @[memGenDCRCacheShell.scala 203:12]
  assign dmem_io_mem_r_bits_data = io_mem_r_bits_data; // @[memGenDCRCacheShell.scala 203:12]
  assign dmem_io_mem_r_bits_last = io_mem_r_bits_last; // @[memGenDCRCacheShell.scala 203:12]
  assign dmem_io_dme_rd_0_cmd_valid = _GEN_117 & _T_68; // @[memGenDCRCacheShell.scala 122:39 memGenDCRCacheShell.scala 131:36]
  assign dmem_io_dme_rd_0_cmd_bits_addr = _T_56[31:0]; // @[memGenDCRCacheShell.scala 120:39]
  assign dmem_io_dme_rd_0_data_ready = inputQ_0_io_enq_ready; // @[memGenDCRCacheShell.scala 123:36]
  assign dmem_io_dme_rd_1_cmd_valid = _GEN_118 & _T_68; // @[memGenDCRCacheShell.scala 122:39 memGenDCRCacheShell.scala 131:36]
  assign dmem_io_dme_rd_1_cmd_bits_addr = _T_61[31:0]; // @[memGenDCRCacheShell.scala 120:39]
  assign dmem_io_dme_rd_1_data_ready = inputQ_1_io_enq_ready; // @[memGenDCRCacheShell.scala 123:36]
  assign dmem_io_dme_rd_2_cmd_valid = _GEN_119 & _T_68; // @[memGenDCRCacheShell.scala 122:39 memGenDCRCacheShell.scala 131:36]
  assign dmem_io_dme_rd_2_cmd_bits_addr = _T_66[31:0]; // @[memGenDCRCacheShell.scala 120:39]
  assign dmem_io_dme_rd_2_data_ready = inputQ_2_io_enq_ready; // @[memGenDCRCacheShell.scala 123:36]
  assign accel_clock = clock;
  assign accel_reset = reset;
  assign accel_io_in_valid = _T_75 ? 1'h0 : _GEN_48; // @[memGenDCRCacheShell.scala 150:21 memGenDCRCacheShell.scala 177:31]
  assign accel_io_in_bits_dataVals_field2_data = _T_69 ? ptrs_0 : inputQ_2_io_deq_bits_data; // @[memGenDCRCacheShell.scala 144:47 memGenDCRCacheShell.scala 146:42]
  assign accel_io_in_bits_dataVals_field1_data = inputQ_1_io_deq_bits_data; // @[memGenDCRCacheShell.scala 140:45]
  assign accel_io_in_bits_dataVals_field0_data = inputQ_0_io_deq_bits_data; // @[memGenDCRCacheShell.scala 140:45]
  assign accel_io_out_ready = _T_72 | _T_73; // @[memGenDCRCacheShell.scala 151:22]
  assign accel_io_mem_aw_ready = io_mem_aw_ready; // @[memGenDCRCacheShell.scala 206:13]
  assign accel_io_mem_w_ready = io_mem_w_ready; // @[memGenDCRCacheShell.scala 206:13]
  assign accel_io_mem_ar_ready = io_mem_ar_ready; // @[memGenDCRCacheShell.scala 206:13]
  assign accel_io_mem_r_valid = io_mem_r_valid; // @[memGenDCRCacheShell.scala 206:13]
  assign accel_io_mem_r_bits_data = io_mem_r_bits_data; // @[memGenDCRCacheShell.scala 206:13]
  assign accel_io_mem_r_bits_last = io_mem_r_bits_last; // @[memGenDCRCacheShell.scala 206:13]
  assign inputQ_0_clock = clock;
  assign inputQ_0_reset = reset;
  assign inputQ_0_io_enq_valid = dmem_io_dme_rd_0_data_valid; // @[memGenDCRCacheShell.scala 126:30]
  assign inputQ_0_io_enq_bits_data = dmem_io_dme_rd_0_data_bits; // @[memGenDCRCacheShell.scala 125:29]
  assign inputQ_0_io_deq_ready = _T_75 ? 1'h0 : _GEN_47; // @[memGenDCRCacheShell.scala 127:30]
  assign inputQ_1_clock = clock;
  assign inputQ_1_reset = reset;
  assign inputQ_1_io_enq_valid = dmem_io_dme_rd_1_data_valid; // @[memGenDCRCacheShell.scala 126:30]
  assign inputQ_1_io_enq_bits_data = dmem_io_dme_rd_1_data_bits; // @[memGenDCRCacheShell.scala 125:29]
  assign inputQ_1_io_deq_ready = _T_75 ? 1'h0 : _GEN_47; // @[memGenDCRCacheShell.scala 127:30]
  assign inputQ_2_clock = clock;
  assign inputQ_2_reset = reset;
  assign inputQ_2_io_enq_valid = dmem_io_dme_rd_2_data_valid; // @[memGenDCRCacheShell.scala 126:30]
  assign inputQ_2_io_enq_bits_data = dmem_io_dme_rd_2_data_bits; // @[memGenDCRCacheShell.scala 125:29]
  assign inputQ_2_io_deq_ready = _T_75 ? 1'h0 : _GEN_47; // @[memGenDCRCacheShell.scala 127:30]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  state = _RAND_0[2:0];
  _RAND_1 = {1{`RANDOM}};
  cycles = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  lastCycle = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  cycle = _RAND_3[14:0];
  _RAND_4 = {2{`RANDOM}};
  vals_0 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  ptrs_0 = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  ackCounter = _RAND_6[19:0];
  _RAND_7 = {1{`RANDOM}};
  fillCounter = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  _T_29 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  numQ = _RAND_9[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      state <= 3'h0;
    end else if (_T_75) begin
      if (vcr_io_dcr_launch) begin
        state <= 3'h1;
      end
    end else if (_T_76) begin
      if (goToBusy) begin
        state <= 3'h2;
      end
    end else if (_T_77) begin
      if (_T_78) begin
        state <= 3'h5;
      end else if (_T_79) begin
        state <= 3'h4;
      end
    end else if (_T_86) begin
      if (_T_87) begin
        state <= 3'h2;
      end
    end else if (_T_88) begin
      if (stopSim) begin
        state <= 3'h0;
      end
    end
    if (reset) begin
      cycles <= 32'h0;
    end else if (goToBusy) begin
      cycles <= 32'h0;
    end else begin
      cycles <= _T_47;
    end
    if (_T_48) begin
      lastCycle <= cycles;
    end
    if (reset) begin
      cycle <= 15'h0;
    end else if (last) begin
      if (_T_1) begin
        cycle <= 15'h0;
      end else begin
        cycle <= _T_3;
      end
    end
    if (reset) begin
      vals_0 <= 64'h0;
    end else if (_T_4) begin
      vals_0 <= {{32'd0}, vcr_io_dcr_vals_0};
    end
    if (reset) begin
      ptrs_0 <= 64'h0;
    end else if (_T_4) begin
      ptrs_0 <= {{32'd0}, vcr_io_dcr_ptrs_0};
    end
    if (reset) begin
      ackCounter <= 20'h0;
    end else if (resetAckCounter) begin
      ackCounter <= 20'h0;
    end else if (accel_io_out_valid) begin
      if (_T_19) begin
        ackCounter <= 20'h0;
      end else begin
        ackCounter <= _T_21;
      end
    end
    if (reset) begin
      fillCounter <= 32'h0;
    end else if (_T_24) begin
      fillCounter <= 32'h0;
    end else if (_T_26) begin
      fillCounter <= _T_28;
    end
    _T_29 <= fillCounter;
    if (reset) begin
      numQ <= 2'h0;
    end else if (_T_24) begin
      numQ <= _T_40;
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_48 & _T_50) begin
          $fwrite(32'h80000002,"Data back for addr %d cycle %d \n",accel_io_out_bits_data_field1_data,cycles); // @[memGenDCRCacheShell.scala 107:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_48 & _T_50) begin
          $fwrite(32'h80000002,"ackCounter :%d\n",ackCounter); // @[memGenDCRCacheShell.scala 108:13]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_129 & _T_50) begin
          $fwrite(32'h80000002,"Ack \n"); // @[memGenDCRCacheShell.scala 173:17]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_GEN_140 & _T_50) begin
          $fwrite(32'h80000002,"\nInst : %d for addr %d with data %d cycle %d \n",accel_io_in_bits_dataVals_field0_data,accel_io_in_bits_dataVals_field1_data,accel_io_in_bits_dataVals_field2_data,cycles); // @[memGenDCRCacheShell.scala 179:21]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module DandelionSimDCRAccel(
  input   clock,
  input   reset,
  input   sim_clock,
  output  sim_wait
);
  wire  sim_shell_clock; // @[DCRAccel.scala 52:25]
  wire  sim_shell_reset; // @[DCRAccel.scala 52:25]
  wire  sim_shell_mem_aw_ready; // @[DCRAccel.scala 52:25]
  wire  sim_shell_mem_aw_valid; // @[DCRAccel.scala 52:25]
  wire [31:0] sim_shell_mem_aw_bits_addr; // @[DCRAccel.scala 52:25]
  wire [31:0] sim_shell_mem_aw_bits_len; // @[DCRAccel.scala 52:25]
  wire  sim_shell_mem_w_ready; // @[DCRAccel.scala 52:25]
  wire  sim_shell_mem_w_valid; // @[DCRAccel.scala 52:25]
  wire [63:0] sim_shell_mem_w_bits_data; // @[DCRAccel.scala 52:25]
  wire  sim_shell_mem_w_bits_last; // @[DCRAccel.scala 52:25]
  wire  sim_shell_mem_b_ready; // @[DCRAccel.scala 52:25]
  wire  sim_shell_mem_b_valid; // @[DCRAccel.scala 52:25]
  wire  sim_shell_mem_ar_ready; // @[DCRAccel.scala 52:25]
  wire  sim_shell_mem_ar_valid; // @[DCRAccel.scala 52:25]
  wire [31:0] sim_shell_mem_ar_bits_addr; // @[DCRAccel.scala 52:25]
  wire [31:0] sim_shell_mem_ar_bits_len; // @[DCRAccel.scala 52:25]
  wire  sim_shell_mem_r_ready; // @[DCRAccel.scala 52:25]
  wire  sim_shell_mem_r_valid; // @[DCRAccel.scala 52:25]
  wire [63:0] sim_shell_mem_r_bits_data; // @[DCRAccel.scala 52:25]
  wire  sim_shell_mem_r_bits_last; // @[DCRAccel.scala 52:25]
  wire  sim_shell_host_aw_ready; // @[DCRAccel.scala 52:25]
  wire  sim_shell_host_aw_valid; // @[DCRAccel.scala 52:25]
  wire [31:0] sim_shell_host_aw_bits_addr; // @[DCRAccel.scala 52:25]
  wire  sim_shell_host_w_ready; // @[DCRAccel.scala 52:25]
  wire  sim_shell_host_w_valid; // @[DCRAccel.scala 52:25]
  wire [63:0] sim_shell_host_w_bits_data; // @[DCRAccel.scala 52:25]
  wire  sim_shell_host_b_ready; // @[DCRAccel.scala 52:25]
  wire  sim_shell_host_b_valid; // @[DCRAccel.scala 52:25]
  wire  sim_shell_host_ar_ready; // @[DCRAccel.scala 52:25]
  wire  sim_shell_host_ar_valid; // @[DCRAccel.scala 52:25]
  wire [31:0] sim_shell_host_ar_bits_addr; // @[DCRAccel.scala 52:25]
  wire  sim_shell_host_r_ready; // @[DCRAccel.scala 52:25]
  wire  sim_shell_host_r_valid; // @[DCRAccel.scala 52:25]
  wire [63:0] sim_shell_host_r_bits_data; // @[DCRAccel.scala 52:25]
  wire  sim_shell_sim_clock; // @[DCRAccel.scala 52:25]
  wire  sim_shell_sim_wait; // @[DCRAccel.scala 52:25]
  wire  shell_clock; // @[DCRAccel.scala 53:21]
  wire  shell_reset; // @[DCRAccel.scala 53:21]
  wire  shell_io_host_aw_ready; // @[DCRAccel.scala 53:21]
  wire  shell_io_host_aw_valid; // @[DCRAccel.scala 53:21]
  wire [31:0] shell_io_host_aw_bits_addr; // @[DCRAccel.scala 53:21]
  wire  shell_io_host_w_ready; // @[DCRAccel.scala 53:21]
  wire  shell_io_host_w_valid; // @[DCRAccel.scala 53:21]
  wire [63:0] shell_io_host_w_bits_data; // @[DCRAccel.scala 53:21]
  wire  shell_io_host_b_ready; // @[DCRAccel.scala 53:21]
  wire  shell_io_host_b_valid; // @[DCRAccel.scala 53:21]
  wire  shell_io_host_ar_ready; // @[DCRAccel.scala 53:21]
  wire  shell_io_host_ar_valid; // @[DCRAccel.scala 53:21]
  wire [31:0] shell_io_host_ar_bits_addr; // @[DCRAccel.scala 53:21]
  wire  shell_io_host_r_ready; // @[DCRAccel.scala 53:21]
  wire  shell_io_host_r_valid; // @[DCRAccel.scala 53:21]
  wire [63:0] shell_io_host_r_bits_data; // @[DCRAccel.scala 53:21]
  wire  shell_io_mem_aw_ready; // @[DCRAccel.scala 53:21]
  wire  shell_io_mem_aw_valid; // @[DCRAccel.scala 53:21]
  wire [31:0] shell_io_mem_aw_bits_addr; // @[DCRAccel.scala 53:21]
  wire [31:0] shell_io_mem_aw_bits_len; // @[DCRAccel.scala 53:21]
  wire  shell_io_mem_w_ready; // @[DCRAccel.scala 53:21]
  wire  shell_io_mem_w_valid; // @[DCRAccel.scala 53:21]
  wire [63:0] shell_io_mem_w_bits_data; // @[DCRAccel.scala 53:21]
  wire  shell_io_mem_w_bits_last; // @[DCRAccel.scala 53:21]
  wire  shell_io_mem_b_ready; // @[DCRAccel.scala 53:21]
  wire  shell_io_mem_b_valid; // @[DCRAccel.scala 53:21]
  wire  shell_io_mem_ar_ready; // @[DCRAccel.scala 53:21]
  wire  shell_io_mem_ar_valid; // @[DCRAccel.scala 53:21]
  wire [31:0] shell_io_mem_ar_bits_addr; // @[DCRAccel.scala 53:21]
  wire [31:0] shell_io_mem_ar_bits_len; // @[DCRAccel.scala 53:21]
  wire  shell_io_mem_r_ready; // @[DCRAccel.scala 53:21]
  wire  shell_io_mem_r_valid; // @[DCRAccel.scala 53:21]
  wire [63:0] shell_io_mem_r_bits_data; // @[DCRAccel.scala 53:21]
  wire  shell_io_mem_r_bits_last; // @[DCRAccel.scala 53:21]
  AXISimShell sim_shell ( // @[DCRAccel.scala 52:25]
    .clock(sim_shell_clock),
    .reset(sim_shell_reset),
    .mem_aw_ready(sim_shell_mem_aw_ready),
    .mem_aw_valid(sim_shell_mem_aw_valid),
    .mem_aw_bits_addr(sim_shell_mem_aw_bits_addr),
    .mem_aw_bits_len(sim_shell_mem_aw_bits_len),
    .mem_w_ready(sim_shell_mem_w_ready),
    .mem_w_valid(sim_shell_mem_w_valid),
    .mem_w_bits_data(sim_shell_mem_w_bits_data),
    .mem_w_bits_last(sim_shell_mem_w_bits_last),
    .mem_b_ready(sim_shell_mem_b_ready),
    .mem_b_valid(sim_shell_mem_b_valid),
    .mem_ar_ready(sim_shell_mem_ar_ready),
    .mem_ar_valid(sim_shell_mem_ar_valid),
    .mem_ar_bits_addr(sim_shell_mem_ar_bits_addr),
    .mem_ar_bits_len(sim_shell_mem_ar_bits_len),
    .mem_r_ready(sim_shell_mem_r_ready),
    .mem_r_valid(sim_shell_mem_r_valid),
    .mem_r_bits_data(sim_shell_mem_r_bits_data),
    .mem_r_bits_last(sim_shell_mem_r_bits_last),
    .host_aw_ready(sim_shell_host_aw_ready),
    .host_aw_valid(sim_shell_host_aw_valid),
    .host_aw_bits_addr(sim_shell_host_aw_bits_addr),
    .host_w_ready(sim_shell_host_w_ready),
    .host_w_valid(sim_shell_host_w_valid),
    .host_w_bits_data(sim_shell_host_w_bits_data),
    .host_b_ready(sim_shell_host_b_ready),
    .host_b_valid(sim_shell_host_b_valid),
    .host_ar_ready(sim_shell_host_ar_ready),
    .host_ar_valid(sim_shell_host_ar_valid),
    .host_ar_bits_addr(sim_shell_host_ar_bits_addr),
    .host_r_ready(sim_shell_host_r_ready),
    .host_r_valid(sim_shell_host_r_valid),
    .host_r_bits_data(sim_shell_host_r_bits_data),
    .sim_clock(sim_shell_sim_clock),
    .sim_wait(sim_shell_sim_wait)
  );
  memGenDCRCacheShell shell ( // @[DCRAccel.scala 53:21]
    .clock(shell_clock),
    .reset(shell_reset),
    .io_host_aw_ready(shell_io_host_aw_ready),
    .io_host_aw_valid(shell_io_host_aw_valid),
    .io_host_aw_bits_addr(shell_io_host_aw_bits_addr),
    .io_host_w_ready(shell_io_host_w_ready),
    .io_host_w_valid(shell_io_host_w_valid),
    .io_host_w_bits_data(shell_io_host_w_bits_data),
    .io_host_b_ready(shell_io_host_b_ready),
    .io_host_b_valid(shell_io_host_b_valid),
    .io_host_ar_ready(shell_io_host_ar_ready),
    .io_host_ar_valid(shell_io_host_ar_valid),
    .io_host_ar_bits_addr(shell_io_host_ar_bits_addr),
    .io_host_r_ready(shell_io_host_r_ready),
    .io_host_r_valid(shell_io_host_r_valid),
    .io_host_r_bits_data(shell_io_host_r_bits_data),
    .io_mem_aw_ready(shell_io_mem_aw_ready),
    .io_mem_aw_valid(shell_io_mem_aw_valid),
    .io_mem_aw_bits_addr(shell_io_mem_aw_bits_addr),
    .io_mem_aw_bits_len(shell_io_mem_aw_bits_len),
    .io_mem_w_ready(shell_io_mem_w_ready),
    .io_mem_w_valid(shell_io_mem_w_valid),
    .io_mem_w_bits_data(shell_io_mem_w_bits_data),
    .io_mem_w_bits_last(shell_io_mem_w_bits_last),
    .io_mem_b_ready(shell_io_mem_b_ready),
    .io_mem_b_valid(shell_io_mem_b_valid),
    .io_mem_ar_ready(shell_io_mem_ar_ready),
    .io_mem_ar_valid(shell_io_mem_ar_valid),
    .io_mem_ar_bits_addr(shell_io_mem_ar_bits_addr),
    .io_mem_ar_bits_len(shell_io_mem_ar_bits_len),
    .io_mem_r_ready(shell_io_mem_r_ready),
    .io_mem_r_valid(shell_io_mem_r_valid),
    .io_mem_r_bits_data(shell_io_mem_r_bits_data),
    .io_mem_r_bits_last(shell_io_mem_r_bits_last)
  );
  assign sim_wait = sim_shell_sim_wait; // @[DCRAccel.scala 56:12]
  assign sim_shell_clock = clock;
  assign sim_shell_reset = reset;
  assign sim_shell_mem_aw_valid = shell_io_mem_aw_valid; // @[DCRAccel.scala 62:20]
  assign sim_shell_mem_aw_bits_addr = shell_io_mem_aw_bits_addr; // @[DCRAccel.scala 62:20]
  assign sim_shell_mem_aw_bits_len = shell_io_mem_aw_bits_len; // @[DCRAccel.scala 62:20]
  assign sim_shell_mem_w_valid = shell_io_mem_w_valid; // @[DCRAccel.scala 63:19]
  assign sim_shell_mem_w_bits_data = shell_io_mem_w_bits_data; // @[DCRAccel.scala 63:19]
  assign sim_shell_mem_w_bits_last = shell_io_mem_w_bits_last; // @[DCRAccel.scala 63:19]
  assign sim_shell_mem_b_ready = shell_io_mem_b_ready; // @[DCRAccel.scala 64:18]
  assign sim_shell_mem_ar_valid = shell_io_mem_ar_valid; // @[DCRAccel.scala 61:20]
  assign sim_shell_mem_ar_bits_addr = shell_io_mem_ar_bits_addr; // @[DCRAccel.scala 61:20]
  assign sim_shell_mem_ar_bits_len = shell_io_mem_ar_bits_len; // @[DCRAccel.scala 61:20]
  assign sim_shell_mem_r_ready = shell_io_mem_r_ready; // @[DCRAccel.scala 65:18]
  assign sim_shell_host_aw_ready = shell_io_host_aw_ready; // @[DCRAccel.scala 70:20]
  assign sim_shell_host_w_ready = shell_io_host_w_ready; // @[DCRAccel.scala 71:19]
  assign sim_shell_host_b_valid = shell_io_host_b_valid; // @[DCRAccel.scala 67:20]
  assign sim_shell_host_ar_ready = shell_io_host_ar_ready; // @[DCRAccel.scala 69:20]
  assign sim_shell_host_r_valid = shell_io_host_r_valid; // @[DCRAccel.scala 68:20]
  assign sim_shell_host_r_bits_data = shell_io_host_r_bits_data; // @[DCRAccel.scala 68:20]
  assign sim_shell_sim_clock = sim_clock; // @[DCRAccel.scala 55:23]
  assign shell_clock = clock;
  assign shell_reset = reset;
  assign shell_io_host_aw_valid = sim_shell_host_aw_valid; // @[DCRAccel.scala 70:20]
  assign shell_io_host_aw_bits_addr = sim_shell_host_aw_bits_addr; // @[DCRAccel.scala 70:20]
  assign shell_io_host_w_valid = sim_shell_host_w_valid; // @[DCRAccel.scala 71:19]
  assign shell_io_host_w_bits_data = sim_shell_host_w_bits_data; // @[DCRAccel.scala 71:19]
  assign shell_io_host_b_ready = sim_shell_host_b_ready; // @[DCRAccel.scala 67:20]
  assign shell_io_host_ar_valid = sim_shell_host_ar_valid; // @[DCRAccel.scala 69:20]
  assign shell_io_host_ar_bits_addr = sim_shell_host_ar_bits_addr; // @[DCRAccel.scala 69:20]
  assign shell_io_host_r_ready = sim_shell_host_r_ready; // @[DCRAccel.scala 68:20]
  assign shell_io_mem_aw_ready = sim_shell_mem_aw_ready; // @[DCRAccel.scala 62:20]
  assign shell_io_mem_w_ready = sim_shell_mem_w_ready; // @[DCRAccel.scala 63:19]
  assign shell_io_mem_b_valid = sim_shell_mem_b_valid; // @[DCRAccel.scala 64:18]
  assign shell_io_mem_ar_ready = sim_shell_mem_ar_ready; // @[DCRAccel.scala 61:20]
  assign shell_io_mem_r_valid = sim_shell_mem_r_valid; // @[DCRAccel.scala 65:18]
  assign shell_io_mem_r_bits_data = sim_shell_mem_r_bits_data; // @[DCRAccel.scala 65:18]
  assign shell_io_mem_r_bits_last = sim_shell_mem_r_bits_last; // @[DCRAccel.scala 65:18]
endmodule
