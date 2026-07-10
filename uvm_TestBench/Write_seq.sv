//Write Sequences
`ifndef SYNC_FIFO_WRITE_SEQUENCE_SV
`define SYNC_FIFO_WRITE_SEQUENCE_SV

class sync_fifo_write_sequence extends
      sync_fifo_base_sequence;

   `uvm_object_utils(sync_fifo_write_sequence)

   function new(string name="sync_fifo_write_sequence");
      super.new(name);
   endfunction

   task body();

      repeat(20)
      begin

         req = sync_fifo_transaction::
               type_id::create("req");

         start_item(req);

         assert(req.randomize() with
         {
            wr_en==1;
            rd_en==0;
         });

         finish_item(req);

      end

   endtask

endclass

`endif
