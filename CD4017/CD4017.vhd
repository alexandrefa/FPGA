library	ieee;
use	ieee.std_logic_1164.all;

entity CD4017 is
	generic	(
		tplh		:	time	:= 0 ns;
		tphl		:	time	:= 0 ns);
	port (
		cp0		:	in		std_logic;
		cp1_n		:	in		std_logic;
		mr			:	in		std_logic;
		o0			:	out		std_logic;
		o1			:	out		std_logic;
		o2			:	out		std_logic;
		o3			:	out		std_logic;
		o4			:	out		std_logic;
		o5			:	out		std_logic;
		o6			:	out		std_logic;
		o7			:	out		std_logic;
		o8			:	out		std_logic;
		o9			:	out		std_logic;
		co_n		:	out		std_logic);
end	entity;

architecture behaviour of CD4017 is
	signal	cp			: std_logic;
	signal	ff1			: std_logic := 'U';
	signal	ff2			: std_logic := 'U';
	signal	ff3			: std_logic := 'U';
	signal	ff4			: std_logic := 'U';
	signal	ff5			: std_logic := 'U';
begin
	cp <= cp0 and not(cp1_n);

	process	(cp, mr)
	begin
		if (to_bit(mr) = '1') then
			ff1 <= '0';
			ff2 <= '0';
			ff3 <= '0';
			ff4 <= '0';
			ff5 <= '0';
		else
			if rising_edge(cp) then
				ff1 <= not ff5;
				ff2 <= ff1;
				ff3 <= (ff1 or ff3) and ff2;
				ff4 <= ff3;
				ff5 <= ff4;
							
			
			end if;
		end	if;
	end	process;

	o0 <= '1' after tplh when not(ff1 or ff5) = '1' else
	      '0' after tphl;

	o1 <= '1' after tplh when not(ff2 or not ff1) = '1' else
		  '0' after tphl;

	o2 <= '1' after tplh when not(ff3 or not ff2) = '1' else
		  '0' after tphl;

	o3 <= '1' after tplh when not(ff4 or not ff3) = '1' else
		  '0' after tphl;

	o4 <= '1' after tplh when not(ff5 or not ff4) = '1' else
		  '0' after tphl;

	o5 <= '1' after tplh when not(not ff1 or not ff5) = '1' else
		  '0' after tphl;

	o6 <= '1' after tplh when not(ff1 or not ff2) = '1' else
		  '0' after tphl;

	o7 <= '1' after tplh when not(ff2 or not ff3) = '1' else
		  '0' after tphl;

	o8 <= '1' after tplh when not(ff3 or not ff4) = '1' else
		  '0' after tphl;

	o9 <= '1' after tplh when not(ff4 or not ff5) = '1' else
		  '0' after tphl;

	co_n <= '1' after tplh when ff5 = '0' else
			'0' after tphl;
end architecture;
