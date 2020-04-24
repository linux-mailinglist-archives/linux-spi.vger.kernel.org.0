Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7281B7E18
	for <lists+linux-spi@lfdr.de>; Fri, 24 Apr 2020 20:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgDXSop (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Apr 2020 14:44:45 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34746 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgDXSoo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Apr 2020 14:44:44 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03OIiFtv095101;
        Fri, 24 Apr 2020 13:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587753855;
        bh=VFINcID+LXtLDi1Q4myGuoi09lumoqP3uswm+yiXGGk=;
        h=From:To:CC:Subject:Date;
        b=EBbpK+Gz2vE9Dkt/3Kl348P4P8+bLO/B1RpOT2j+xDs2UmvDJENAHgTsk42scS4GY
         HzuaHq1Y6g35dBxw9yw2Z3zgbPE9KgNUsyBY0JBMQQL2K/FpjD01W2dakdFGPDwjm4
         JxfFownApX0161jaak10xFGy+WLDXVLPtrDdCrE4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03OIiFgk020650
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Apr 2020 13:44:15 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 13:44:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 13:44:15 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OIiAa6047967;
        Fri, 24 Apr 2020 13:44:11 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v4 00/16] mtd: spi-nor: add xSPI Octal DTR support
Date:   Sat, 25 Apr 2020 00:13:54 +0530
Message-ID: <20200424184410.8578-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This series adds support for octal DTR flashes in the spi-nor framework,
and then adds hooks for the Cypress Semper and Mircom Xcella flashes to
allow running them in octal DTR mode. This series assumes that the flash is handed to the kernel in Legacy SPI
mode.

Tested on TI J721e EVM with 1-bit ECC on the Cypress flash.

Changes in v4:
- Refactor the series to use the new spi-nor framework with the
  manufacturer-specific bits separated from the core.

- Add support for Micron MT35XU512ABA.

- Use cmd.nbytes as the criteria of whether the data phase exists or not
  instead of cmd.buf.in || cmd.buf.out in spi_nor_spimem_setup_op().

- Update Read FSR to use the same dummy cycles and address width as Read
  SR.

- Fix BFPT parsing stopping too early for JESD216 rev B flashes.

- Use 2 byte reads for Read SR and FSR commands in DTR mode.

Changes in v3:
- Drop the DT properties "spi-rx-dtr" and "spi-tx-dtr". Instead, if
  later a need is felt to disable DTR in case someone has a board with
  Octal DTR capable flash but does not support DTR transactions for some
  reason, a property like "spi-no-dtr" can be added.

- Remove mode bits SPI_RX_DTR and SPI_TX_DTR.

- Remove the Cadence Quadspi controller patch to un-block this series. I
  will submit it as a separate patch.

- Rebase on latest 'master' and fix merge conflicts.

- Update read and write dirmap templates to use DTR.

- Rename 'is_dtr' to 'dtr'.

- Make 'dtr' a bitfield.

- Reject DTR ops in spi_mem_default_supports_op().

- Update atmel-quadspi to reject DTR ops. All other controller drivers
  call spi_mem_default_supports_op() so they will automatically reject
  DTR ops.

- Add support for both enabling and disabling DTR modes.

- Perform a Software Reset on flashes that support it when shutting
  down.

- Disable Octal DTR mode on suspend, and re-enable it on resume.

- Drop enum 'spi_mem_cmd_ext' and make command opcode u16 instead.
  Update spi-nor to use the 2-byte command instead of the command
  extension. Since we still need a "extension type", mode that enum to
  spi-nor and name it 'spi_nor_cmd_ext'.

- Default variable address width to 3 to fix SMPT parsing.

- Drop non-volatile change to uniform sector mode and rely on parsing
  SMPT.

Changes in v2:
- Add DT properties "spi-rx-dtr" and "spi-tx-dtr" to allow expressing
  DTR capabilities.

- Set the mode bits SPI_RX_DTR and SPI_TX_DTR when we discover the DT
  properties "spi-rx-dtr" and spi-tx-dtr".

- spi_nor_cypress_octal_enable() was updating nor->params.read[] with
  the intention of setting the correct number of dummy cycles. But this
  function is called _after_ selecting the read so setting
  nor->params.read[] will have no effect. So, update nor->read_dummy
  directly.

- Fix spi_nor_spimem_check_readop() and spi_nor_spimem_check_pp()
  passing nor->read_proto and nor->write_proto to
  spi_nor_spimem_setup_op() instead of read->proto and pp->proto
  respectively.

- Move the call to cqspi_setup_opcode_ext() inside cqspi_enable_dtr().
  This avoids repeating the 'if (f_pdata->is_dtr)
  cqspi_setup_opcode_ext()...` snippet multiple times.

- Call the default 'supports_op()' from cqspi_supports_mem_op(). This
  makes sure the buswidth requirements are also enforced along with the
  DTR requirements.

- Drop the 'is_dtr' argument from spi_check_dtr_req(). We only call it
  when a phase is DTR so it is redundant.

Pratyush Yadav (16):
  spi: spi-mem: allow specifying whether an op is DTR or not
  spi: atmel-quadspi: reject DTR ops
  spi: spi-mem: allow specifying a command's extension
  mtd: spi-nor: add support for DTR protocol
  mtd: spi-nor: default to address width of 3 for configurable widths
  mtd: spi-nor: prepare BFPT parsing for JESD216 rev D
  mtd: spi-nor: get command opcode extension type from BFPT
  mtd: spi-nor: parse xSPI Profile 1.0 table
  mtd: spi-nor: use dummy cycle and address width info from SFDP
  mtd: spi-nor: do 2 byte reads for SR and FSR in DTR mode
  mtd: spi-nor: enable octal DTR mode when possible
  mtd: spi-nor: perform a Soft Reset on shutdown
  mtd: spi-nor: Disable Octal DTR mode on suspend.
  mtd: spi-nor: expose spi_nor_default_setup() in core.h
  mtd: spi-nor: add support for Cypress Semper flash
  mtd: spi-nor: allow using MT35XU512ABA in Octal DTR mode

 drivers/mtd/spi-nor/core.c      | 439 +++++++++++++++++++++++++++-----
 drivers/mtd/spi-nor/core.h      |  23 ++
 drivers/mtd/spi-nor/micron-st.c | 113 +++++++-
 drivers/mtd/spi-nor/sfdp.c      | 114 ++++++++-
 drivers/mtd/spi-nor/sfdp.h      |  11 +-
 drivers/mtd/spi-nor/spansion.c  | 167 ++++++++++++
 drivers/spi/atmel-quadspi.c     |   4 +
 drivers/spi/spi-mem.c           |   3 +
 include/linux/mtd/spi-nor.h     |  50 +++-
 include/linux/spi/spi-mem.h     |  13 +-
 10 files changed, 848 insertions(+), 89 deletions(-)

--
2.25.0

