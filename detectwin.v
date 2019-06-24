// DetectWinner
// Detects whether either ain or bin has three in a row 
// Inputs:
//   ain, bin - (9-bit) current positions of type a and b
// Out:
//   win_line - (8-bit) if A/B wins, one hot indicates along which row, col or diag
//   win_line(0) = 1 means a win in row 8 7 6 (i.e., either ain or bin has all ones in this row)
//   win_line(1) = 1 means a win in row 5 4 3
//   win_line(2) = 1 means a win in row 2 1 0
//   win_line(3) = 1 means a win in col 8 5 2
//   win_line(4) = 1 means a win in col 7 4 1
//   win_line(5) = 1 means a win in col 6 3 0
//   win_line(6) = 1 means a win along the downward diagonal 8 4 0
//   win_line(7) = 1 means a win along the upward diagonal 2 4 6

module DetectWinner( ain, bin, win_line );
  // CPEN 211 LAB 3, PART 1: your implementation goes here

//Input and output declarations
input [8:0] ain, bin;
output [7:0] win_line;

	/*Using assign statements to show the line in which either player a or b has won in by having 3 ina row
	  Logic: if all three values in a line are 1's that would be a win. If we bitwise-AND all 
	  these values togetether, expected output is a 1. Because one player can win at any given time, 
	  the values for ain and bin can be OR'd in order to be able to select one winner(x or o, a or b)
	  and assign a one-bit value to each space in win_line. If no player has won along a given line, the ANDed 
	  value will be 0 and win_line at that space will also be 0.
	*/
	assign win_line[0] = &ain[8:6] | &bin[8:6];
	assign win_line[1] = &ain[5:3] | &bin[5:3];
	assign win_line[2] = &ain[2:0] | &bin[2:0];
	assign win_line[3] = ain[0] & ain[3] & ain [6] | bin[0] & bin[3] & bin[6];
	assign win_line[4] = ain[1] & ain[4] & ain [7] | bin[1] & bin[4] & bin[7];
	assign win_line[5] = ain[2] & ain[5] & ain [8] | bin[2] & bin[5] & bin[8];
	assign win_line[6] = ain[8] & ain[4] & ain [0] | bin[8] & bin[4] & bin[0];
	assign win_line[7] = ain[2] & ain[4] & ain [6] | bin[2] & bin[4] & bin[6];
 
	
endmodule

/*
Testbench module to detect multiple cases of ain winning, bin winning, and draws between both
*/
module detectwinner_tb();

	/*Paramaters are simulation values given to ain and bin by testbench in order to test wins and draws
	along with sim_win_line which predicts which line the win has occured by placing a 1 on that lines 
	given spot or draw(all 0's)
	*/
	reg [8:0] sim_a;
	reg [8:0] sim_b;
	wire [7:0] sim_win_line;
	
	/*
	passes simulation variables of device under testing (DUT) to DetectWinner
	*/
	DetectWinner dut( 
	   .ain(sim_a),
	   .bin(sim_b),
	   .win_line(sim_win_line));
	  

	//Beginning of simulation
	initial begin
	
	//setting initial values to all 0's (empty board)
	sim_a=9'b000000000;
	sim_b=9'b000000000;

	//wait 6 simulation timetsteps for changes to occur
	#6;

	//test top row [2:0]
	sim_a = 9'b000000111;
	sim_b=9'b000000000;
	
	/*expected(theoretical) output and actual(DetectWinner) output displayed
	If these are equal, code is correct
	repeat for all necessary cases
	*/
	$display("Output is: %b Expected is: %b", sim_win_line, 8'b00000100);
	
	//test mid row [5:3]
	sim_a = 9'b000111000;
	sim_b=9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b00000010);

	//test bot row [8:6]
	sim_a = 9'b111000000;
	sim_b=9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b00000001);

	//test leftc [6] [3] [0]
	sim_a = 9'b001001001;
	sim_b=9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b00100000);

	//test midc [7] [4] [1]
	sim_a = 9'b010010010;
	sim_b=9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b00010000);

	//test rightc [8] [5] [2]
	sim_a = 9'b100100100;
	sim_b=9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b00001000);

	//test updiag [2] [4] [6]
	sim_a = 9'b001010100;
	sim_b=9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b10000000);

	//test dwndiag [8] [4] [0]
	sim_a = 9'b100010001;
	sim_b=9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b01000000);




	//test top row [2:0]
	sim_b= 9'b000000111;
	sim_a= 9'b000000000;
	
	$display("Output is: %b Expected is: %b", sim_win_line, 8'b00000100);
	
	//test mid row [5:3]
	sim_b= 9'b000111000;
	sim_a= 9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b00000010);

	//test bot row [8:6]
	sim_b= 9'b111000000;
	sim_a= 9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b00000001);

	//test leftc [6] [3] [0]
	sim_b= 9'b001001001;
	sim_a= 9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b00100000);

	//test midc [7] [4] [1]
	sim_b= 9'b010010010;
	sim_a= 9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b00010000);

	//test rightc [8] [5] [2]
	sim_b= 9'b100100100;
	sim_a= 9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b00001000);

	//test updiag [2] [4] [6]
	sim_b= 9'b001010100;
	sim_a= 9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b10000000);

	//test dwndiag [8] [4] [0]
	sim_b= 9'b100010001;
	sim_a= 9'b000000000;
	#6;

	$display("Output is: %b Expected is: %b", sim_win_line, 8'b01000000);

	//testing for a scratch(no winners) case 1
        sim_a= 9'b011100101;
	sim_b= 9'b100011010;
	#6;

	$display("Output is: %b. Expected a draw", sim_win_line,);

	//testing for a scratch(no winners) case 2
        sim_a= 9'b110001101;
	sim_b= 9'b001110010;
	#6;

	$display("Output is: %b. Expected a draw", sim_win_line,);

	//testing for a scratch(no winners) case 3
        sim_a= 9'b010110101;
	sim_b= 9'b101001010;
	#6;

	$display("Output is: %b. Expected a draw", sim_win_line,);

	//testing for a scratch(no winners) case 4
        sim_a= 9'b100001110;
	sim_b= 9'b011110001;
	#6;

	$display("Output is: %b. Expected a draw", sim_win_line,);	

	//testing for a scratch(no winners) case 5
        sim_a= 9'b001110010;
	sim_b= 9'b110001101;
	#6;

	$display("Output is: %b. Expected a draw", sim_win_line,);	

	end

endmodule 