# Line buffer class

class TextLineBuffer
  attr_reader :cursor
  
  def initialize(str, cursor = 0)
    @buffer = str.split("")
    @cursor = cursor
  end
  
  def to_s
    @buffer.join   
  end
  
  def insert_before(chr)
    @buffer.insert(@cursor, chr)
    @cursor = @cursor + 1
  end
  
  def insert_after(chr)
    @buffer.insert(@cursor + 1, chr)
  end
  
  # Returns nil if nothing to delete
  def delete_before
    return nil if @cursor == 0
    result = @buffer.delete_at(@cursor - 1)
    @buffer.compact! #needed?
    @cursor = @cursor - 1 if result != nil
    result
  end
  
  # Returns nil if nothing to delete
  def delete_after
    result = @buffer.delete_at(@cursor)
    @buffer.compact! #needed?
    result
  end
  
  def left
    return nil if @cursor == 0

    @cursor = @cursor - 1
    return @cursor == 0 ? nil : @buffer[@cursor - 1] # One more because on left-hand side
  end
  
  def right
    return nil if @cursor == @buffer.size

    @cursor = @cursor + 1
    return @buffer[@cursor]    
  end
end

# Text edit class (array of gap buffers, cursor Y)
class TextBuffer
  #* Move the cursor up or down a line and return nil/false only if a
  # line boundary could not be crossed. The cursor may be placed in
  # the most natural column for the data structure.
  
  def initialize
    @lines = []
    @line_num = 0
  end
  
  # Get current line and column numbers
  def col
    @lines[@line_num].cursor
  end
  
  def row
    @line_num
  end
  
  def up
    return nil if @line_num == 0
    @line_num = @line_num - 1
    true
  end
  
  def down
    return nil if @line_num == (@lines.size - 1)
    @line_num = @line_num + 1
    true
  end
  
  # Insert line after line_num (cursor)
  def insert_after
    @lines.insert(@line_num, TextLineBuffer.new(""))
    @line_num = @line_num + 1
  end
end

=begin

  TODO:
  
  * Copy some amount of text before or after the cursor and return
  this buffer.
  * Display some context around the cursor.
  * Cut some amount of text before or after the cursor and return
  this buffer.
  * Paste a copy/cut buffer before or after the cursor.
  * Insert a file.
  * Write to a file.
  * Goto a specific line or column.
  * Goto the begin/end of the line/buffer.
  * Copy or cut to a specific line/column.
  * Filter some text through a ruby block.
  * Search (and possibly replace) using a regular expression.
  * Undo/redo.
  
Major bonus points for the following where gap buffers probably won't work:

  * Only store changes to a file.
  * Handle multiple efficient cursors in a text buffer.  
=end
