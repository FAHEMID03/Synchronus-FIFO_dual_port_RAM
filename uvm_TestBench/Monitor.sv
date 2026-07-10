`ifndef SYNC_FIFO_MONITOR_SV
`define SYNC_FIFO_MONITOR_SV

class sync_fifo_write_monitor extends
      uvm_monitor;

   //------------------------------------------------------
   // Factory Registration
   //------------------------------------------------------

   `uvm_component_utils(sync_fifo_write_monitor)

   //------------------------------------------------------
   // Virtual Interface
   //------------------------------------------------------

   virtual sync_fifo_if vif;

   //------------------------------------------------------
   // Analysis Port
   //------------------------------------------------------

   uvm_analysis_port #(sync_fifo_transaction) ap;

   //------------------------------------------------------
   // Transaction Handle
   //------------------------------------------------------

   sync_fifo_transaction tr;

   //------------------------------------------------------
   // Constructor
   //------------------------------------------------------

   function new(string name="sync_fifo_write_monitor",
                uvm_component parent);

      super.new(name,parent);

      ap=new("ap",this);

   endfunction

   //------------------------------------------------------
   // Build Phase
   //------------------------------------------------------

   function void build_phase(uvm_phase phase);

      super.build_phase(phase);

      if(!uvm_config_db #(virtual sync_fifo_if)::get
      (
         this,
         "",
         "vif",
         vif
      ))
      begin
         `uvm_fatal("NOVIF",
                    "Virtual Interface Not Found")
      end

   endfunction

   //------------------------------------------------------
   // Run Phase
   //------------------------------------------------------

   task run_phase(uvm_phase phase);

      forever
      begin

         @(posedge vif.clk);

         if(vif.wr_en)

         begin

            tr=sync_fifo_transaction::
               type_id::create("tr");

            tr.wr_en=vif.wr_en;

            tr.din=vif.din;

            tr.full=vif.full;

            tr.empty=vif.empty;

            tr.almost_full=vif.almost_full;

            tr.almost_empty=vif.almost_empty;

            ap.write(tr);

         end

      end

   endtask

endclass
class sync_fifo_read_monitor extends
      uvm_monitor;

   `uvm_component_utils(sync_fifo_read_monitor)

   virtual sync_fifo_if vif;

   uvm_analysis_port #(sync_fifo_transaction) ap;

   sync_fifo_transaction tr;

   function new(string name="sync_fifo_read_monitor",
                uvm_component parent);

      super.new(name,parent);

      ap=new("ap",this);

   endfunction

   function void build_phase(uvm_phase phase);

      super.build_phase(phase);

      if(!uvm_config_db #(virtual sync_fifo_if)::get
      (
         this,
         "",
         "vif",
         vif
      ))
      begin
         `uvm_fatal("NOVIF",
                    "Virtual Interface Not Found")
      end

   endfunction

   task run_phase(uvm_phase phase);

      forever
      begin

         @(posedge vif.clk);

         if(vif.rd_en)

         begin

            tr=sync_fifo_transaction::
               type_id::create("tr");

            tr.rd_en=vif.rd_en;

            tr.dout=vif.dout;

            tr.full=vif.full;

            tr.empty=vif.empty;

            tr.almost_full=vif.almost_full;

            tr.almost_empty=vif.almost_empty;

            ap.write(tr);

         end

      end

   endtask

endclass

`endif
