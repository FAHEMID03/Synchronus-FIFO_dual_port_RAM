`ifndef SYNC_FIFO_SEQUENCES_SV
`define SYNC_FIFO_SEQUENCES_SV

//==========================================================
// Base Sequence
//==========================================================

class sync_fifo_base_sequence extends
      uvm_sequence #(sync_fifo_transaction);

   `uvm_object_utils(sync_fifo_base_sequence)

   // Transaction Handle
   sync_fifo_transaction req;

   function new(string name="sync_fifo_base_sequence");
      super.new(name);
   endfunction

endclass


//==========================================================
// Write Sequence
//==========================================================

class sync_fifo_write_sequence extends
      sync_fifo_base_sequence;

   `uvm_object_utils(sync_fifo_write_sequence)

   function new(string name="sync_fifo_write_sequence");
      super.new(name);
   endfunction

   task body();

      repeat(20)
      begin

         req = sync_fifo_transaction::type_id::create("req");

         start_item(req);

         assert(req.randomize() with
         {
            wr_en == 1;
            rd_en == 0;
         });

         finish_item(req);

      end

   endtask

endclass


//==========================================================
// Read Sequence
//==========================================================

class sync_fifo_read_sequence extends
      sync_fifo_base_sequence;

   `uvm_object_utils(sync_fifo_read_sequence)

   function new(string name="sync_fifo_read_sequence");
      super.new(name);
   endfunction

   task body();

      repeat(20)
      begin

         req = sync_fifo_transaction::type_id::create("req");

         start_item(req);

         assert(req.randomize() with
         {
            wr_en == 0;
            rd_en == 1;
         });

         finish_item(req);

      end

   endtask

endclass


//==========================================================
// Random Sequence
//==========================================================

class sync_fifo_random_sequence extends
      sync_fifo_base_sequence;

   `uvm_object_utils(sync_fifo_random_sequence)

   function new(string name="sync_fifo_random_sequence");
      super.new(name);
   endfunction

   task body();

      repeat(500)
      begin

         req = sync_fifo_transaction::type_id::create("req");

         start_item(req);

         assert(req.randomize());

         finish_item(req);

      end

   endtask

endclass


//==========================================================
// Virtual Sequence
//==========================================================

class sync_fifo_virtual_sequence extends uvm_sequence;

   `uvm_object_utils(sync_fifo_virtual_sequence)

   `uvm_declare_p_sequencer(sync_fifo_virtual_sequencer)

   sync_fifo_write_sequence wr_seq;
   sync_fifo_read_sequence  rd_seq;

   function new(string name="sync_fifo_virtual_sequence");
      super.new(name);
   endfunction

   task body();

      wr_seq = sync_fifo_write_sequence::
               type_id::create("wr_seq");

      rd_seq = sync_fifo_read_sequence::
               type_id::create("rd_seq");

      fork

         wr_seq.start(p_sequencer.wr_seqr);

         rd_seq.start(p_sequencer.rd_seqr);

      join

   endtask

endclass

`endif
