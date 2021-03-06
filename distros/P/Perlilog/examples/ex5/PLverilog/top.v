`timescale 1ns / 10ps

module top;

  reg  clk;
  reg  rst;
  wire  we_via;
  wire [7:0] adr_via;
  wire [7:0] dout_via;
  wire  wb_slave_cyc_via;
  wire [1:0] wb_slave_adr_via;
  wire [7:0] wb_dat_o_via;
  wire  wb_ack_o_via;
  wire [7:0] zero_via;
  wire [7:0] one_via;
  wire [7:0] two_via;
  wire [7:0] three_via;
  wire [7:0] m_wb_dat_i_via;
  wire  m_wb_ack_i_via;
  wire  cyc_via;
  wire  stb_via;

   always #5 clk = ~clk;
    
   initial
      begin
	 // initial values
	 clk = 0;
	 
	 // reset system
	 rst = 1'b0; // negate reset
	 #2;
	 rst = 1'b1; // assert reset
	 repeat(4) @(posedge clk);
	 rst = 1'b0; // negate reset
      end

  test  test_ins(.din(m_wb_dat_i_via), .ack(m_wb_ack_i_via), .clk(clk),
    .rst(rst), .cyc(cyc_via), .stb(stb_via), .we(we_via), .adr(adr_via),
    .dout(dout_via));

  rom1  rom1_ins(.wb_clk_i(clk), .wb_rst_i(rst), .wb_we_i(we_via),
    .wb_stb_i(stb_via), .wb_cyc_i(wb_slave_cyc_via),
    .wb_adr_i(wb_slave_adr_via), .wb_dat_i(dout_via), .wb_dat_o(wb_dat_o_via),
    .wb_ack_o(wb_ack_o_via));

  rom2  rom2_ins(.zero(zero_via), .one(one_via), .two(two_via),
    .three(three_via));

  single_master_wb_controller  single_master_wb_controller_ins(.m_wb_clk_i(clk),
    .m_wb_rst_i(rst), .m_wb_adr_o(adr_via), .m_wb_dat_o(dout_via),
    .m_wb_dat_i(m_wb_dat_i_via), .m_wb_we_o(we_via), .m_wb_stb_o(stb_via),
    .m_wb_cyc_o(cyc_via), .m_wb_ack_i(m_wb_ack_i_via),
    .wb_slave_adr(wb_slave_adr_via), .wb_slave_cyc(wb_slave_cyc_via),
    .wb_slave_ack(wb_ack_o_via), .wb_slave_dat(wb_dat_o_via), .wb_clk_i(clk),
    .wb_rst_i(rst), .wb_dat_i(dout_via), .wb_we_i(we_via), .wb_stb_i(stb_via),
    .zero(zero_via), .one(one_via), .two(two_via), .three(three_via));

endmodule
