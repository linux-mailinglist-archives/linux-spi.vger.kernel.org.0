Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F82116867
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 09:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLIIkl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 03:40:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:61122 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfLIIkk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 03:40:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 00:40:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="295493949"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga001.jf.intel.com with ESMTP; 09 Dec 2019 00:40:37 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org, vigneshr@ti.com, robh+dt@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        "Ramuthevar Vadivel Muruganx" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v3 0/2] spi: cadence-quadpsi: Add support for the Cadence QSPI controller
Date:   Mon,  9 Dec 2019 16:40:33 +0800
Message-Id: <20191209084035.55603-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: "Ramuthevar Vadivel Muruganx" <vadivel.muruganx.ramuthevar@linux.intel.com>

Add support for the Cadence QSPI controller. This controller is
present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
This driver has been tested on the Intel LGM SoCs.

This driver does not support generic SPI and also the implementation
only supports spi-mem interface to replace the existing driver in
mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
flash memory.

Thank you Vignesh for the valuable review comments and guidance,
sorry for the delay since waitting for the merge window to rebase
and send it now by one-shot.

changes from V2:
1. Supports Octal mode as well. So its 1/2/4/8-bit wide                                       

2. Please be consistent with function names. Start all functions with 
   cadence_qspi_. If need you could have a shorter function prefix like cqspi_ 

   Also, this and few other functions below can be static and they are not 
   used outside of this module.                                                                                             

3. Could you please keep polling routines from original driver 
  (drivers/mtd/spi-nor/cadence-quadspi.c). If you really want to improve 
   these helpers, please do those changes in a separate patch later on in 
   the series. This will greatly help in reviewing the code. 

   Also, I see that you have dropped many inline comments in the code. 
   These comments are quite important and I suggest not to drop them unless 
   they are no longer applicable                                                                                        

3. s/docoder/decoder

4. Please use cqspi_wait_for_bit() that uses readl_relaxed_poll_timeout()    
    here. There are couple corner cases that above code does not take care of.

5. Why do we need flash type specific handling here? Does not spi-nand 
   driver provide appropriate dummy_clk values? Why is the driver always 
   adding 8 dummy clks always?                                                                                       

6. Nope, no custom handling or interpreting of opcodes in driver. 
   Just set addrwidth to quad in CQSPI_REG_WR_INSTR when op->addr.buswidth 
   is 4.

7. This was wait_for_completion_timeout() previously. Have you tested 
    interrupting the sleep and verified that driver handles this case correctly?  

8  rdid_length harcoded values are changed as generic                       

9. Please get ride of all flash type specific handling... There should be 
   no need for it. IF there are gaps in then lets discuss and fix it in 
   spi-nand and spi-nor frameworks and not in the driver. 

   spi-mem user should just take spi_mem_op template passed by the core and 
   execute it. No assumptions wrt flash type or opcode should be done.   


10. Decision to use STIG was INDAC mode can be done using: 

if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) { 
	if (!op->addr.nbytes) 
		mode = CQSPI_STIG_READ; 
	else 
		mode = IDC_READ_MODE; 
	} else { 
	if (!op->addr.nbytes || !op->data.buf.out) 
		 mode = CQSPI_STIG_WRITE; 
	else 
		mode = IDC_WRITE_MODE; 
	} 

   No need for rdid_length etc.                                                                                                                     

11. This is a big gap and there is lot of code sharing that can be done b/w 
   INDAC and DAC mode. 

   Looks like driver isn't quite close to being ready. I suggest you also 
   take a look at patches for spi-mem conversion of cadence-quadspi driver 
   in U-Boot as well: 

   https://patchwork.ozlabs.org/cover/1176362/                                           


12. Please dont add any new DT properties, there is no need for them. See 
    how this was handled in existing driver and reuse it                                      

13. Slave DMA was never supported and is not needed.                              

14. Octal? 

15. NACK, should be GPLv2 and no need for boilerplate text below when SPDX 
    Identifier is present.

Ramuthevar Vadivel Murugan (2):
  dt-bindings: spi: Add schema for Cadence QSPI Controller driver
  spi: cadence-quadpsi: Add support for the Cadence QSPI controller

 .../devicetree/bindings/spi/cadence,qspi.yaml      |  162 +++
 drivers/spi/Kconfig                                |    8 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-cadence-quadspi.c                  | 1228 ++++++++++++++++++++
 drivers/spi/spi-cadence-quadspi.h                  |  254 ++++
 5 files changed, 1653 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi.yaml
 create mode 100644 drivers/spi/spi-cadence-quadspi.c
 create mode 100644 drivers/spi/spi-cadence-quadspi.h

-- 
2.11.0

