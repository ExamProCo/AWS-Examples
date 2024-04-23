require 'curses'

Curses.init_screen
Curses.start_color
#Curses.nocbreak()
Curses.init_pair(1, Curses::COLOR_RED, Curses::COLOR_BLACK)

player_x = 5
player_y = 5

Curses.setpos(player_y, player_x)
Curses.attrset(Curses.color_pair(1))

Curses.refresh
Curses.addstr('P')

# game loop
while true do
  key = Curses.getch
  case key
  when 'a'
    player_x -= 1 
  when 'd'
    player_x += 1
  # close when pressing q key
  when 'q'
    # quit out of the while lop
    break
  end
  Curses.setpos(player_y, player_x) 
  Curses.addstr('P')
  Curses.refresh

end

Curses.close_screen



