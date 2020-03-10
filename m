Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B5A17EE2E
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 02:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgCJBwe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 21:52:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:54728 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgCJBwe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Mar 2020 21:52:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 18:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="265455423"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2020 18:52:28 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, vigneshr@ti.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, boris.brezillon@free-electrons.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        tien.fong.chee@intel.com, marex@denx.de,
        linux-mtd@lists.infradead.org, dwmw2@infradead.org, richard@nod.at,
        computersforpeace@gmail.com, cyrille.pitchen@atmel.com,
        david.oberhollenzer@sigma-star.at, miquel.raynal@bootlin.com,
        tudor.ambarus@gmail.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v12 0/4] spi: cadence-quadspi: Add support for the Cadence QSPI controller
Date:   Tue, 10 Mar 2020 09:52:09 +0800
Message-Id: <20200310015213.1734-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for the Cadence QSPI controller. This controller is
present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.

This driver does not support generic SPI and also the implementation
only supports spi-mem interface to replace the existing driver in
mtd/spi-nor/cadence-quadspi.c, which supports SPI-NOR memory.

So we have decided that adapt spi-mem framework with existing driver 
to support SPI-NOR and SPI-NAND flash memories.

changes from v11
 -- Boris suggested to split the patches
 -- split 3 patches like below  
    i) spi-mem adaptation
    ii) convert the existing drivers to spi based.
    ii) add intel changes to above 2 patches.
 -- Rob's build issue resolved
 
changes from v10
 -- Rob's review comments update in dt_schema yaml.
 -- add valid contraints constraints. 

changes from v9:
 -- Mark's review comments address
 -- add check to shared interrupt handler
 -- add check decoder if present
 -- add error check for quirks capability data
 -- remove the existing cadence_quadspi.c from drivers/mtd/spi-nor path
 -- remove CONFIG macro from Kconfig in the above path
 -- remove cadence_quadspi.o build option from Makefile in the above path

changes from v8:
 -- remove the depends MTD macro
 -- comment into C++ style
 -- remove spaces and tabs where not applicable.
 -- align the macro string as same as existing one.
 -- replace QUAD to op->data.buswidth variable.
 -- add CQSPI_NEEDS_ADDR_SWAP instead of soc_selection variable

changes from v7:
 -- remove addr_buf kept like as original
 -- drop bus-num, chipselect variable
 -- add soc_selection varible to differetiate the features
 -- replace dev->ddev in dma function
 -- add seperate function to handle the 24bit slave device address
    translation for lgm soc
 -- correct sentence seems incomplete in Kconfig
 -- add cqspi->soc_selection check to keep the original TI platform
    working code.

changes from v6:
 -- Add the Signed-off-by Vignesh in commit message
 -- bus_num, num_chipselect added to avoid the garbage bus number
    during the probe and spi_register.
 -- master mode bits updated
 -- address sequence is different from TI and Intel SoC Ip handling
    so modified as per Intel and differentiating by use_dac_mode variable.
 -- dummy cycles also different b/w two platforms, so keeping separate check
 -- checkpatch errors which are intentional left as is for better readability

changes from v5:
 -- kbuild test robot warnings fixed
 -- Add Reported-By: Dan Carpenter <dan.carpenter@oracle.com>

changes from v4:
 -- kbuild test robot warnings fixed
 -- Add Reborted-by: tag

changes from v3:
spi-cadence-quadspi.c
 -- static to all functions wrt to local to the file.
 -- Prefix cqspi_ and make the function static
 -- cmd_ops, data_ops and dummy_ops dropped
 -- addr_ops kept since it is required for address calculation.
 -- devm_ used for supported functions , removed legacy API's
 -- removed "indirect" name from functions
 -- replaced by master->mode_bits = SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL | SPI_RX_OCTAL;
    as per Vignesh susggestion
 -- removed free functions since devm_ handles automatically.
 -- dropped all unused Macros

YAML file update:
 -- cadence,qspi.yaml file name replace by cdns,qspi-nor.yaml
 -- compatible string updated as per Vignesh suggestion
 -- for single entry, removed descriptions
 -- removed optional parameters
  Build Result:
   linux$ make DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml dt_binding_check
    CHKDT   Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
    SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
    DTC     Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml
    CHECK   Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dt.yaml


Ramuthevar Vadivel Murugan (2):
  dt-bindings: spi: Add schema for Cadence QSPI Controller driver
  spi: cadence-quadspi: Add support for the Cadence QSPI controller

 .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 ---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 142 +++++
 drivers/mtd/spi-nor/Kconfig                        |  11 -
 drivers/mtd/spi-nor/Makefile                       |   1 -
 drivers/spi/Kconfig                                |  10 +
 drivers/spi/Makefile                               |   1 +
 .../spi-cadence-quadspi.c}                         | 641 ++++++++++-----------
 7 files changed, 456 insertions(+), 417 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
 rename drivers/{mtd/spi-nor/cadence-quadspi.c => spi/spi-cadence-quadspi.c} (73%)

Ramuthevar Vadivel Murugan (4):
  dt-bindings: spi: Add schema for Cadence QSPI Controller driver
  mtd: spi-nor: add spi-mem support in cadence-quadspi controller driver
  spi: cadence-quadspi: Add support for the Cadence QSPI controller
  spi: cadence-quadspi: Add qspi support for Intel LGM SoC

 .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 ---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 127 ++++
 drivers/mtd/spi-nor/Kconfig                        |  11 -
 drivers/mtd/spi-nor/Makefile                       |   1 -
 drivers/spi/Kconfig                                |  10 +
 drivers/spi/Makefile                               |   1 +
 .../spi-cadence-quadspi.c}                         | 643 ++++++++++-----------
 7 files changed, 442 insertions(+), 418 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
 rename drivers/{mtd/spi-nor/cadence-quadspi.c => spi/spi-cadence-quadspi.c} (73%)

-- 
2.11.0

