with Lights; pragma Unreferenced (Lights);

with Ada.Real_Time;

------------
-- pigeon --
------------

procedure pigeon is
begin
   loop
      delay until Ada.Real_Time.Time_Last;
   end loop;
end pigeon;
