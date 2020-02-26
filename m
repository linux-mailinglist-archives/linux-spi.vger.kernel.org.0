Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A28816FADE
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 10:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgBZJhl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Feb 2020 04:37:41 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40074 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgBZJhk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Feb 2020 04:37:40 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01Q9b9FN087050;
        Wed, 26 Feb 2020 03:37:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582709829;
        bh=fx7S2CDPaTW7xSXzGMie7/8qKHKT4vHfX8u8KvtoGKc=;
        h=From:To:CC:Subject:Date;
        b=eJwnt7bJM8WoM7V8AGiP7gRLIJXWrfsHi9HOrlifdKe1uqOiAW0KR6MtjzuYg4zpe
         blmiFN27FJ0DDZ9Esq3P6519ssqGujT+OyjgRWtaa/2LjtaUt6uczAV4cbdXvHbtWE
         NHqrNnGBs5VlgzSwfk2Dp92him1vrgyWsoK44BOY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01Q9b9aA122372
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 03:37:09 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 03:37:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 03:37:08 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01Q9b4A5110613;
        Wed, 26 Feb 2020 03:37:05 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 00/11] mtd: spi-nor: add xSPI Octal DTR support
Date:   Wed, 26 Feb 2020 15:06:52 +0530
Message-ID: <20200226093703.19765-1-p.yadav@ti.com>
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
and then adds hooks for the Cypress Semper flash which is an xSPI
compliant Octal DTR flash.

The Cadence QSPI controller driver is also updated to run in Octal DTR
mode.

Tested on TI J721e EVM with 1-bit ECC on the Cypress flash.

This series depends on [0]. v1 can be found at [1].

[0] https://patchwork.kernel.org/patch/11355593/
[1] https://lore.kernel.org/linux-mtd/20200211133348.15558-1-p.yadav@ti.com/

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

Pratyush Yadav (11):
  dt-bindings: spi: allow expressing DTR capability
  spi: set mode bits for "spi-rx-dtr" and "spi-tx-dtr"
  spi: spi-mem: allow specifying whether an op is DTR or not
  spi: spi-mem: allow specifying a command's extension
  spi: cadence-quadspi: Add support for octal DTR flashes
  mtd: spi-nor: add support for DTR protocol
  mtd: spi-nor: get command opcode extension type from BFPT
  mtd: spi-nor: parse xSPI Profile 1.0 table
  mtd: spi-nor: use dummy cycle and address width info from SFDP
  mtd: spi-nor: enable octal DTR mode when possible
  mtd: spi-nor: add support for Cypress Semper flash

 .../bindings/spi/spi-controller.yaml          |  10 +
 drivers/mtd/spi-nor/spi-nor.c                 | 594 ++++++++++++++++--
 drivers/spi/spi-cadence-quadspi.c             | 247 +++++++-
 drivers/spi/spi-mem.c                         |  46 ++
 drivers/spi/spi.c                             |  10 +-
 include/linux/mtd/spi-nor.h                   |  55 +-
 include/linux/spi/spi-mem.h                   |  32 +
 include/linux/spi/spi.h                       |   2 +
 8 files changed, 891 insertions(+), 105 deletions(-)

--
2.25.0

