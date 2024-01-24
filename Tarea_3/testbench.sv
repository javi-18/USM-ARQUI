module Test;

  // Señales
  reg clk;
  reg reset;
  wire [5:0] count;
  wire [18:0] rom_output;
  wire [2:0] num_out1;
  wire [7:0] num_out2;
  wire [7:0] num_out3;
  wire [7:0] salida; 
 


  CentralModule todo(
    .count(count),
    .rom_output(rom_output),
    .num_out1(num_out1),
    .num_out2(num_out2),
    .num_out3(num_out3),
    .salida(salida),
    .clk(clk),
    .reset(reset)

 );

  // Generar un pulso de reloj cada 1 unidad de tiempo
  always #1 clk = ~clk;

  initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0; // Pulso de reset más largo
    $display("______________________________________________________________________");
    $display("Instruccion (Hex)  Operacion  Inmediato A  Inmediato B  Resultado");
    $display("______________________________________________________________________");
    // Mostrar el valor del contador y la salida de la ROM durante 64 unidades de tiempo
    repeat (64) begin
      #2
      $display("     %h            %b      %b     %b    %b", rom_output, num_out1, num_out2, num_out3, salida);
    end

    // Terminar la simulación después de mostrar los valores del contador
    $finish;
  end
endmodule
