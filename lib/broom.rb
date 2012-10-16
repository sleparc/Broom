require 'rubygems'

module Broom
  VERSION = '0.0.1'

  class Alphabetize
    def retrieve_block(file)
      blocks = []
      n = 0
      lines = file.readlines
      file_size = lines.size

      alph = create_structure(lines, n)
      blocks.push(alph[0])
      traverse_structure(blocks)
    end

    def traverse_structure(structure)
      array_found = false
      n = 0

      while n < structure.size
        block = structure[n]
        if block.class.to_s == 'Array'
          array_found = true
          alphabetized_array = traverse_structure(block)
          structure[n] = alphabetized_array
          array_found = false
        end
        n+=1
      end

      if is_sortable?(structure)
        structure = structure.sort
      else
        structure = force_sort(structure)
      end
      structure = structure.to_s
    end

    def create_structure(lines, n)
      arr = []
      exit_func = false

      while !exit_func
        current_line = lines[n]
        if !current_line.nil?
          last_char = current_line.slice(-2,1)
          if last_char == '{'
            arr.push(current_line)
            alph = create_structure(lines, n+1)
            arr.push(alph[0])
            n = alph[1]
          elsif last_char == '}'
            arr.push(current_line)
            exit_func = true
          else
            arr.push(current_line)
          end
        else
          exit_func = true
        end
        n+=1
      end
      [arr, n-1]
    end

    def is_sortable?(arr)
      sortable = true
      arr.each do |line|
        sortable = false if !is_style_property?(line)
      end
      sortable
    end

    def is_style_property?(line)
      (!line.match(/.+:/).nil? || !line.match(/.+;/).nil? || !line.match(/.*\}+.*/).nil?) && (line.match(/\&.*/).nil? || line.match(/.*\{.*/).nil?)
    end

    def is_comment?(line)
      !line.match(/\/.*\//).nil?
    end

    def open_bracket?(line)
      !line.match(/.*\{.*/).nil?
    end

    def closed_bracket?(line)
      !line.match(/.*\}.*/).nil?
    end

    def force_sort(structure)
      n = 0
      final_struct = []
      sortable_struct = []

      while n < structure.size
        if is_style_property?(structure[n])
          sortable_struct.push(structure[n])
          n+=1
        else
          final_struct.push(sortable_struct.sort) if sortable_struct.size > 0
          if is_comment?(structure[n])
            unsortable_struct = structure[n]
            n+=1
          else
            unsortable_struct = grab_unsortable_struct(structure, n)
            n += unsortable_struct.size
          end
          final_struct.push(unsortable_struct)
          sortable_struct = []
        end
      end
      final_struct.push(sortable_struct.sort) if sortable_struct.size > 0
      final_struct
    end

    def grab_unsortable_struct(structure, n)
      level = 1
      output_struct = []
      output_struct.push(structure[n])
      n += 1
      while level != 0 && n < structure.size
        if open_bracket?(structure[n])
          level += 1
        elsif closed_bracket?(structure[n])
          level -= 1
        end
        output_struct.push(structure[n])
        n += 1
      end
      output_struct
    end
  end
end
