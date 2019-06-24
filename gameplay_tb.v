/* 
playadjacent_tb tests different cases of players in opposite corners and hardware in the middle block.
If implemented correctly this testbench shows how PlayAdjacentEdge can improve game logic
by telling the computer where to play in certain conditions.
*/
module playadjacent_tb () ;
	
	/*
	Paramaters are simulation values given to ain and bin by testbench in order to test 
	adjacent conditions. output, adjacent, will return all 0's if corner case not satisfied
	or a 9 bit board position value of where to place the next move.
	*/
	reg [8:0] sim_a;
	reg [8:0] sim_b;
	wire [8:0] adjacent;
	
	/*
	passes simulation variables of device under testing (DUT) to PlayAdjacentEdge
	*/
	PlayAdjacentEdge dut( 
	   .ain(sim_a),
	   .bin(sim_b),
	   .out(adjacent));
	  

	//Beginning of simulation
	initial begin
	
	//setting initial values to all 0's (empty board)
	sim_a=9'b000000000;
	sim_b=9'b000000000;

	//wait 6 simulation timetsteps for changes to occur
	#6;

	//test ain in blocks [0] [8] (opposite corners) with bin in middle block
	sim_a = 9'b100000001;
	sim_b = 9'b000010000;
	#6;

	//displays our actual output (through module) and expected (theoretical)
	$display("Output is: %b Expected is: %b", adjacent, 9'b010101010);

	//test ain in blocks [2] [6] (opposite corners) with bin in middle block
	sim_a = 9'b001000100;
	sim_b = 9'b000010000;
	#6;

	$display("Output is: %b Expected is: %b", adjacent, 9'b010101010);

	//test bin in blocks [0] [8] (opposite corners) with ain in middle block
	sim_a = 9'b000010000;
	sim_b = 9'b100000001;
	#6;

	$display("Output is: %b Expected is: %b", adjacent, 9'b010101010);

	//test bin in blocks [2] [6] (opposite corners) with ain in middle block
	sim_a = 9'b000010000;
	sim_b = 9'b001000100;
	#6;

	$display("Output is: %b Expected is: %b", adjacent, 9'b010101010);

	//test no opposite corner condition without middle block filled (no adjacent output) 
	sim_a = 9'b110001000;
	sim_b = 9'b001100010;
	#6;

	$display("Output is: %b Expected is: %b", adjacent, 9'b00000000);

	end 

endmodule
