`ifndef SYNC_FIFO_DRIVER_SV
`define SYNC_FIFO_DRIVER_SV
//---------------------------------------------//
//   Write Driver                              //
//--------------------------------------------//
class sync_fifo_write_driver extends
      uvm_driver #(sync_fifo_transaction);

   //--------------------------------------------
   // Factory Registration
   //--------------------------------------------

   `uvm_component_utils(sync_fifo_write_driver)

   //--------------------------------------------
   // Virtual Interface
   //--------------------------------------------

   virtual sync_fifo_if vif;

   //--------------------------------------------
   // Constructor
   //--------------------------------------------

   function new(string name="sync_fifo_write_driver",
                uvm_component parent);

      super.new(name,parent);

   endfunction

   //--------------------------------------------
   // Build Phase
   //--------------------------------------------

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
         "Virtual Interface not found")
      end

   endfunction

   //--------------------------------------------
   // Run Phase
   //--------------------------------------------

   task run_phase(uvm_phase phase);

      forever
      begin

         seq_item_port.get_next_item(req);

         drive_write(req);

         seq_item_port.item_done();

      end

   endtask

   //--------------------------------------------
   // Drive Task
   //--------------------------------------------

   task drive_write(sync_fifo_transaction tr);

      @(posedge vif.clk);

      vif.wr_en <= tr.wr_en;
      vif.din   <= tr.din;

      @(posedge vif.clk);

      vif.wr_en <= 0;

   endtask

endclass

//----------------------------------------//
//          Read driver                   //
//----------------------------------------//
class sync_fifo_read_driver extends uvm_driver #(sync_fifo_transaction);

   `uvm_component_utils(sync_fifo_read_driver)

   virtual sync_fifo_if vif;

   function new(string name="sync_fifo_read_driver",
                uvm_component parent);

      super.new(name,parent);

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
         "Virtual Interface not found")
      end

   endfunction

   task run_phase(uvm_phase phase);

      forever
      begin

         seq_item_port.get_next_item(req);

         drive_read(req);

         seq_item_port.item_done();

      end

   endtask

   task drive_read(sync_fifo_transaction tr);

      @(posedge vif.clk);

      vif.rd_en <= tr.rd_en;

      @(posedge vif.clk);

      vif.rd_en <= 0;

   endtask

endclass

`endif
