module CentralModule(
  input wire [5:0] count,
  input wire [18:0] rom_output,
  input wire [2:0] num_out1,
  input wire [7:0] num_out2,
  input wire [7:0] num_out3,
  input wire [7:0] salida,
  input wire clk,
  input wire reset,

);
  // Señales
 
  // Instancias de los módulos
  Counter counter (
    .clk(clk),
    .reset(reset),
    .count(count)
  );

  ROM rom (
    .slot_number(count-1),
    .output_data(rom_output)
  );

  Splitter splitter (
    .data_in(rom_output),
    .num_out1(num_out1),
    .num_out2(num_out2),
    .num_out3(num_out3)
  );
  
  ALU alu (
    .a(num_out2),
    .b(num_out3),
    .control(num_out1),
    .salida(salida)
  );
  


endmodule




module Counter(
  input wire clk,
  input wire reset,
  output reg [5:0] count
);

  always @(posedge clk or posedge reset) begin
    if (reset)
      count <= 6'b0;
    else if (count == 6'b111111)
      count <= 6'b0;
    else if (count < 6'b111111)
      count <= count + 1;
  end

endmodule



module ROM(
  input wire [5:0] slot_number,
  output reg [18:0] output_data
);

  reg [18:0] rom_data [0:63];

  always @(slot_number) begin
    output_data <= rom_data[slot_number];
  end

  // Inicializar la memoria de la ROM con los valores deseados
initial begin
  rom_data[0] = 19'b0000001011100010011;
  rom_data[1] = 19'b0010000011101001100;
  rom_data[2] = 19'b0100001111100000101;
  rom_data[3] = 19'b0110001111100000010;
  rom_data[4] = 19'b1000101110101010010;
  rom_data[5] = 19'b1010101110101010010;
  rom_data[6] = 19'b1100101110101010010;
  rom_data[7] = 19'b1110101110111111111;
  rom_data[8] = 19'b000000000000001001;
  rom_data[9] = 19'b000000000000001010;
  rom_data[10] = 19'b000000000000001011;
  rom_data[11] = 19'b000000000000001100;
  rom_data[12] = 19'b000000000000001101;
  rom_data[13] = 19'b000000000000001110;
  rom_data[14] = 19'b000000000000001111;
  rom_data[15] = 19'b000000000000010000;
  rom_data[16] = 19'b000000000000010001;
  rom_data[17] = 19'b000000000000010010;
  rom_data[18] = 19'b000000000000010011;
  rom_data[19] = 19'b000000000000010100;
  rom_data[20] = 19'b000000000000010101;
  rom_data[21] = 19'b000000000000010110;
  rom_data[22] = 19'b000000000000010111;
  rom_data[23] = 19'b000000000000011000;
  rom_data[24] = 19'b000000000000011001;
  rom_data[25] = 19'b000000000000011010;
  rom_data[26] = 19'b000000000000011011;
  rom_data[27] = 19'b000000000000011100;
  rom_data[28] = 19'b000000000000011101;
  rom_data[29] = 19'b000000000000011110;
  rom_data[30] = 19'b000000000000011111;
  rom_data[31] = 19'b000000000000100000;
  rom_data[32] = 19'b000000000000100001;
  rom_data[33] = 19'b000000000000100010;
  rom_data[34] = 19'b000000000000100011;
  rom_data[35] = 19'b000000000000100100;
  rom_data[36] = 19'b000000000000100101;
  rom_data[37] = 19'b000000000000100110;
  rom_data[38] = 19'b000000000000100111;
  rom_data[39] = 19'b000000000000101000;
  rom_data[40] = 19'b000000000000101001;
  rom_data[41] = 19'b000000000000101010;
  rom_data[42] = 19'b000000000000101011;
  rom_data[43] = 19'b000000000000101100;
  rom_data[44] = 19'b000000000000101101;
  rom_data[45] = 19'b000000000000101110;
  rom_data[46] = 19'b000000000000101111;
  rom_data[47] = 19'b000000000000110000;
  rom_data[48] = 19'b000000000000110001;
  rom_data[49] = 19'b000000000000110010;
  rom_data[50] = 19'b000000000000110011;
  rom_data[51] = 19'b000000000000110100;
  rom_data[52] = 19'b000000000000110101;
  rom_data[53] = 19'b000000000000110110;
  rom_data[54] = 19'b000000000000110111;
  rom_data[55] = 19'b000000000000111000;
  rom_data[56] = 19'b000000000000111001;
  rom_data[57] = 19'b000000000000111010;
  rom_data[58] = 19'b000000000000111011;
  rom_data[59] = 19'b000000000000111100;
  rom_data[60] = 19'b000000000000111101;
  rom_data[61] = 19'b000000000000111110;
  rom_data[62] = 19'b000000000000111111;
  rom_data[63] = 19'b1111111111111111111;
end


endmodule

//design.sv del Splitter y la ALU
//Inicio del Splitter
module Splitter(
  input wire [18:0] data_in,
  output wire [2:0] num_out1,
  output wire [7:0] num_out2,
  output wire [7:0] num_out3
);

  assign num_out1= data_in [18:16];
  assign num_out2= data_in [15:8];
  assign num_out3= data_in [7:0];
  
endmodule

//Inicio de la ALU
module suma (
  input [7:0] a,
  input [7:0] b,
  output [7:0] sum,
);

  wire [7:0] auxiliar;
  wire [7:0] cin;
  
  assign cin[0] = 0;
  assign cin[1] = a[0] & b[0];
  assign cin[2] = (a[1] & b[1]) | (a[1] & cin[1]) | (b[1] & cin[1]);
  assign cin[3] = (a[2] & b[2]) | (a[2] & cin[2]) | (b[2] & cin[2]);
  assign cin[4] = (a[3] & b[3]) | (a[3] & cin[3]) | (b[3] & cin[3]);
  assign cin[5] = (a[4] & b[4]) | (a[4] & cin[4]) | (b[4] & cin[4]);
  assign cin[6] = (a[5] & b[5]) | (a[5] & cin[5]) | (b[5] & cin[5]);
  assign cin[7] = (a[6] & b[6]) | (a[6] & cin[6]) | (b[6] & cin[6]);
  
  assign auxiliar[0] = a[0] ^ b[0] ^ cin[0];
  assign auxiliar[1] = a[1] ^ b[1] ^ cin[1];
  assign auxiliar[2] = a[2] ^ b[2] ^ cin[2];
  assign auxiliar[3] = a[3] ^ b[3] ^ cin[3];
  assign auxiliar[4] = a[4] ^ b[4] ^ cin[4];
  assign auxiliar[5] = a[5] ^ b[5] ^ cin[5];
  assign auxiliar[6] = a[6] ^ b[6] ^ cin[6];
  assign auxiliar[7] = a[7] ^ b[7] ^ cin[7];

  assign sum = auxiliar;

endmodule

module resta (
  input [7:0] a,
  input [7:0] b,
  output [7:0] res,
);

  suma modulo(a,~b+1,res);
  
endmodule

module logica(input logic [7:0] a, b,
              output logic [7:0] y, o, x);
  
  assign y = a & b;
  assign o = a | b;
  assign x = a ^ b; // Operación XOR exclusiva
  
endmodule

module bitshift(input logic [7:0] a,
                input logic [2:0] b,
                output logic [7:0] Ishifted,
                output logic [7:0] Dshifted);
  
   assign Ishifted = a << b;
   assign Dshifted = a >> b;
  
endmodule

module ALU(
  input logic [7:0] a, b,
  input logic [2:0] control,
  output logic [7:0] salida
);
  logic [7:0] sum, res, y, o, Ishifted, Dshifted, xor_output;

  suma modulo1(a, b, sum);
  resta modulo2(a, b, res);
  logica modulo3(a, b, y, o, xor_output);
  bitshift modulo4(a, b, Ishifted, Dshifted);
  
  always_comb
    case (control)
      3'b000: salida = sum;
      3'b001: salida = res;
      3'b010: salida = y;
      3'b011: salida = o;
      3'b100: salida = Ishifted;
      3'b101: salida = Dshifted;
      3'b110: salida = xor_output;
      3'b111: salida = ~a;
      default: salida = 8'bxxxx_xxxx;
    endcase
endmodule