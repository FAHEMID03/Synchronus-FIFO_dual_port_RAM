//Base_sequences//
`ifndef SYNC_FIFO_BASE_SEQUENCE_SV
`define SYNC_FIFO_BASE_SEQUENCE_SV
class_sync_fifo_base_seq extends uvm_sequences#(sync_fifo_transection);
`uvm_object_utils(sync_fifo_base_sequence)
function new(string name="sync_fifo_base_sequence") ;
  super.new(name);
endfunction
endclass
`endif
