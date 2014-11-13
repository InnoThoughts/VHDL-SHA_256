----------------------------------------------------------------------------------
-- Creators:	   Nate Graff and Kenan Pretzer
-- Module Name:    Algorithm_Implementation - Behavioral 
-- Project Name:   CPE 133 Final Project

-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 

--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Algorithm_Implementation is
    Port ( message : in  STD_LOGIC_VECTOR (255 downto 0);
           digest : out  STD_LOGIC_VECTOR (255 downto 0));
end Algorithm_Implementation;

architecture Behavioral of Algorithm_Implementation is

	--Initialize hash values: The hash values are initialized to the first 
		--32 bits of the fractional parts of the square roots of the first 8 
		--prime numbers (2..19).
	type vector_array_16by32 is array (0 to 15) of STD_LOGIC_VECTOR(31 downto 0);
	constant h_original : vector_array_16by32 := 
		(x"6a09e667", x"bb67ae85", x"3c6ef372", x"a54ff53a", x"510e527f",
		 x"9b05688c", x"1f83d9ab", x"5be0cd19");
	
	--Initialize array of round constants: Use first 32 bits of fractional parts 
		--of the cubed roots of the first 64 primes (2..311).
	type vector_array_64by32 is array (0 to 15) of STD_LOGIC_VECTOR(31 downto 0);
	constant k : vector_array_64by32 :=
		(x"428a2f98", x"71374491", x"b5c0fbcf", x"e9b5dba5", x"3956c25b", x"59f111f1",
		 x"923f82a4", x"ab1c5ed5", x"d807aa98", x"12835b01", x"243185be", x"550c7dc3",
		 x"72be5d74", x"80deb1fe", x"9bdc06a7", x"c19bf174", x"e49b69c1", x"efbe4786",
		 x"0fc19dc6", x"240ca1cc", x"2de92c6f", x"4a7484aa", x"5cb0a9dc", x"76f988da",
		 x"983e5152", x"a831c66d", x"b00327c8", x"bf597fc7", x"c6e00bf3", x"d5a79147",
		 x"06ca6351", x"14292967", x"27b70a85", x"2e1b2138", x"4d2c6dfc", x"53380d13",
		 x"650a7354", x"766a0abb", x"81c2c92e", x"92722c85", x"a2bfe8a1", x"a81a664b",
		 x"c24b8b70", x"c76c51a3", x"d192e819", x"d6990624", x"f40e3585", x"106aa070",
		 x"19a4c116", x"1e376c08", x"2748774c", x"34b0bcb5", x"391c0cb3", x"4ed8aa4a",
		 x"5b9cca4f", x"682e6ff3", x"748f82ee", x"78a5636f", x"84c87814", x"8cc70208",
		 x"90befffa", x"a4506ceb", x"bef9a3f7", x"c67178f2");

begin

	--This process statement contains the workings of the hash algorithm. The inputs include 
		--the original message array and the arays of constants defined above. The output is 
		--the final processed hash value.
	algorithm: process(message)
	
	--General Variable Declarations (See working variable declaration below)
			variable index1 : integer := 0;
			variable w : vector_array_64by32;
			variable temp_message : vector_array_64by32;
			variable s0: std_logic := '0';
			variable s1: std_logic := '0';
			variable ch: std_logic := '0';
			variable temp1: std_logic := '0';
			variable temp2: std_logic := '0';
			variable maj: std_logic := '0';
			variable h_new : vector_array_16by32;
			--Declare Working Variables.
			variable a : vector_array_16by32;
			variable b : vector_array_16by32;
			variable c : vector_array_16by32;
			variable d : vector_array_16by32;
			variable e : vector_array_16by32;
			variable f : vector_array_16by32;
			variable g : vector_array_16by32;
			variable h : vector_array_16by32;

	begin

	--Preprocessing: Append the bit '1' to message.
		
			--Initialize message array and pad with zeros.
			init_temp_message: for index1 in 0 to 63 loop
				temp_message(index1) := x"00000000";
			end loop init_temp_message;
			
			temp_message := message & x"00000001";
				
	--Process Message in Successive 512-bit Chuncks
		
			--Initialize message array.
			init_w: for index1 in 0 to 63 loop
				w := x"00000000";
			end loop init_w;
			
			--Copy chunk into first 16 words of message schedule array.
			copy_first16: for index1 in 0 to 15 loop
				w(index1) := temp_message(index1);
			end loop copy_first16;
			
			--Extend first 16 words into remaining 48 words of message schedule array.
			extend_next48: for index1 in 16 to 63 loop
				s0   := (w(index1-15) ror 7) XOR (w(index1-15) ror 18) XOR (w(index1-15) sra 3);
				s1   := (w(index1-2) ror 17) XOR (w(index1-2) ror 19) XOR (w(index1-2) sra 10);
				w(index1) := w(index1-16) + s0 + w(index1-7) + s1;
			end loop extend_next48;
			
	--Initialize Working Variables to Current Hash Value
			a := h_original(0);
			b := h_original(1);
			c := h_original(2);
			d := h_original(3);
			e := h_original(4);
			f := h_original(5);
			g := h_original(6);
			h := h_original(7);

	--Compression Function Main Loop
			compression_adjustments: for index1 in 0 to 63 loop
				s1 := (e ror 6) XOR (e ror 11) XOR (e ror 25);
				ch := (e AND f) XOR ((NOT e) AND g);
				temp1 := h + s1 + ch + k(index1) + w(index1);
				s0 := (a ror 2) XOR (a ror 13) XOR (a ror 22);
				maj := (a AND b) XOR (a AND c) XOR (b AND c);
				temp2 := s0 + maj;
			end loop compression_adjustments;
			
			h := g;
			g := f;
			f := e;
			e := d + temp1;
			d := c;
			c := b;
			b := a;
			a := temp1 + temp2;

	--Add Compressed Chunk to Current Hash Value
			h_new(0) := h_original(0) + a;
			h_new(1) := h_original(1) + b;
			h_new(2) := h_original(2) + c;
			h_new(3) := h_original(3) + d;
			h_new(4) := h_original(4) + e;
			h_new(5) := h_original(5) + f;
			h_new(6) := h_original(6) + g;
			h_new(7) := h_original(7) + h;

	--Produce Final Hash Value (Big-Endian)
			digest := h_new(0) & h_new(1) & h_new(2) & h_new(3) & h_new(4) & 
							h_new(5) & h_new(6) & h_new(6);

	end process algorithm;
	
end Behavioral;