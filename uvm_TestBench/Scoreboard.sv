`ifndef SYNC_FIFO_SCOREBOARD_SV
`define SYNC_FIFO_SCOREBOARD_SV

`uvm_analysis_imp_decl(_WR)
`uvm_analysis_imp_decl(_RD)

class sync_fifo_scoreboard extends uvm_scoreboard;

   //--------------------------------------------------
   // Factory Registration
   //--------------------------------------------------

   `uvm_component_utils(sync_fifo_scoreboard)

   //--------------------------------------------------
   // Analysis Ports
   //--------------------------------------------------

   uvm_analysis_imp_WR #(sync_fifo_transaction,
                         sync_fifo_scoreboard) write_imp;

   uvm_analysis_imp_RD #(sync_fifo_transaction,
                         sync_fifo_scoreboard) read_imp;

   //--------------------------------------------------
   // Reference Queue
   //--------------------------------------------------

   bit [31:0] exp_queue[$];

   //--------------------------------------------------
   // Variables
   //--------------------------------------------------

   bit [31:0] exp_data;

   //--------------------------------------------------
   // Constructor
   //--------------------------------------------------

   function new(string name,
                uvm_component parent);

      super.new(name,parent);

      write_imp = new("write_imp",this);

      read_imp  = new("read_imp",this);

   endfunction

   //--------------------------------------------------
   // Write Callback
   //--------------------------------------------------

   function void write_WR(sync_fifo_transaction tr);

      if(tr.wr_en)

      begin

         exp_queue.push_back(tr.din);

         `uvm_info("SCOREBOARD",
                   $sformatf("WRITE DATA = %0h Queue Size=%0d",
                             tr.din,
                             exp_queue.size()),
                   UVM_LOW)

      end

   endfunction

   //--------------------------------------------------
   // Read Callback
   //--------------------------------------------------

   function void write_RD(sync_fifo_transaction tr);

      if(tr.rd_en)

      begin

         //------------------------------------------
         // Queue Empty Check
         //------------------------------------------

         if(exp_queue.size()==0)

         begin

            `uvm_error("SCOREBOARD",
                       "Reference Queue Empty")

         end

         else

         begin

            //---------------------------------------
            // Expected Data
            //---------------------------------------

            exp_data = exp_queue.pop_front();

            //---------------------------------------
            // Compare
            //---------------------------------------

            if(exp_data == tr.dout)

            begin

               `uvm_info("SCOREBOARD",

               $sformatf(
               "PASS Expected=%0h Actual=%0h",
               exp_data,
               tr.dout),

               UVM_LOW)

            end

            else

            begin

               `uvm_error("SCOREBOARD",

               $sformatf(
               "FAIL Expected=%0h Actual=%0h",
               exp_data,
               tr.dout))

            end

         end

      end

   endfunction

endclass

`endif
