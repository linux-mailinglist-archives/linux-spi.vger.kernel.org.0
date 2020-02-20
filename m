Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AE1165434
	for <lists+linux-spi@lfdr.de>; Thu, 20 Feb 2020 02:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgBTBXr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Feb 2020 20:23:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:49776 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgBTBXr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 Feb 2020 20:23:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 17:23:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,462,1574150400"; 
   d="scan'208";a="382987388"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 19 Feb 2020 17:23:43 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, vigneshr@ti.com
Cc:     robh+dt@kernel.org, simon.k.r.goldschmidt@gmail.com,
        dinguyen@kernel.org, tien.fong.chee@intel.com, marex@denx.de,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v10 0/2] spi: cadence-quadspi: Add support for the Cadence QSPI controller
Date:   Thu, 20 Feb 2020 09:23:33 +0800
Message-Id: <20200220012335.7059-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for the Cadence QSPI controller. This controller is
present in the Intel Lightning Mountain(LGM) SoCs, Altera and TI SoCs.
This driver has been tested on the Intel LGM SoCs.

This driver does not support generic SPI and also the implementation
only supports spi-mem interface to replace the existing driver in
mtd/spi-nor/cadence-quadspi.c, the existing driver only support SPI-NOR
flash memory.

Thanks Mark and Vignesh for the review, suggestion to optimize the patch.
Tested with mx25u12835f on LGM platform.

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
  spi: cadence-quadpsi: Add support for the Cadence QSPI controller

 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 147 +++++
 drivers/mtd/spi-nor/Kconfig                        |  11 -
 drivers/mtd/spi-nor/Makefile                       |   1 -
 drivers/spi/Kconfig                                |   8 +
 drivers/spi/Makefile                               |   1 +
 .../spi-cadence-quadspi.c}                         | 641 ++++++++++-----------
 6 files changed, 459 insertions(+), 350 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
 rename drivers/{mtd/spi-nor/cadence-quadspi.c => spi/spi-cadence-quadspi.c} (73%)

-- 
2.11.0

