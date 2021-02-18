with ada.text_io, ada.calendar;
use ada.text_io, ada.calendar;

procedure Zad3 is
	task  t is
		entry Zeruj;
		entry Zegar(d:out duration);
		entry Stop;
	end t;

	task body t is
		t: time;
	begin
		loop
			select
				accept Zeruj do
					put_line("zeruj");
					t := clock;
				end Zeruj;
			or
				accept Zegar(d:out duration) do
					d := clock - t;
					put_line(d'img);
				end Zegar;
			or
				accept Stop do
					put_line("stop");
					return;
				end Stop;
				exit;
			end select;
		end loop;
	end t;
	d: duration;
begin
	t.Zeruj;
	for i in 1..12 loop
		if i mod 4 = 0 then
			t.Zeruj;
		end if;
		delay 0.1;
		t.Zegar(d);
	end loop;
	t.Stop;
end Zad3;
