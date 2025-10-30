task drive_simple_packet(htax_packet_c pkt);
    // TODO 1: Request the outport (one-hot encoding from pkt.dest_port)
    htax_tx_intf.tx_outport_req = 1 << pkt.dest_port/* YOUR CODE */;
    
    // TODO 2: Request the virtual channel
    htax_tx_intf.tx_vc_req = pkt.vc/* YOUR CODE */;
    
    @(posedge htax_tx_intf.clk);
    
    // TODO 3: Wait for grant using a while loop
    while((htax_tx_intf.tx_vc_gnt) == 0) begin
        @(posedge htax_tx_intf.clk);
    end
    
    // TODO 4: Assert SOT for the granted VC and drive first data
    // Hint: SOT should match the granted VC
    htax_tx_intf.tx_sot = htax_tx_intf.tx_vc_gnt/* YOUR CODE */;
    htax_tx_intf.tx_data = pkt.data[0];
    
    // TODO 5: Deassert request signals
    htax_tx_intf.tx_outport_req = '0;
    htax_tx_intf.tx_vc_req = '0;
    
    @(posedge htax_tx_intf.clk);
    
    // TODO 6: Drive second data beat (deassert SOT)
    htax_tx_intf.tx_sot = '0;
    htax_tx_intf.tx_data = pkt.data[0]/* YOUR CODE */;
	//one more
	@(posedge htax_tx_intf.clk);
	htax_tx_intf.tx_data = pkt.data[1];
	
    @(posedge htax_tx_intf.clk);
    
    // TODO 7: Drive last data beat with EOT asserted
    htax_tx_intf.tx_data = pkt.data[2];
    htax_tx_intf.tx_eot = 1/* YOUR CODE */;
    
    @(posedge htax_tx_intf.clk);
    
    // TODO 8: Reset EOT signal
    htax_tx_intf.tx_eot = 0/* YOUR CODE */;
endtask