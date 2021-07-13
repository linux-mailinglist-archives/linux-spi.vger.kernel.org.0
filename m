Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB913C70EF
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 15:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhGMNI7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 09:08:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51904 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhGMNI6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 09:08:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16DD5jfI073235;
        Tue, 13 Jul 2021 08:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626181545;
        bh=bv2q0ax7MknWkffZXc/s0ufmW/fG8UgHIGCH2D4ZhGU=;
        h=From:To:CC:Subject:Date;
        b=u+Gy9JzrYY6G9gLLKZsPJTjUkBT8Yomgt3O4skcTo+PS7YE9HUSq+GWTp4Kde4QPj
         CO4A8ACZkGoMdFU5XtzJvzQmy6aI1L7llYqtrymL61rrtyWHeFHdnhB5/j05zrWv5F
         RiocUxptyAtnLEuVDL2BfsIrTXa+tMJqfvO78iAE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16DD5jOR090842
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jul 2021 08:05:45 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Jul 2021 08:05:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Jul 2021 08:05:44 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16DD5daA109825;
        Tue, 13 Jul 2021 08:05:40 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 00/13] mtd: spinand: Add Octal DTR SPI (8D-8D-8D) mode support
Date:   Tue, 13 Jul 2021 13:05:25 +0000
Message-ID: <20210713130538.646-1-a-nandan@ti.com>
X-Mailer: git-send-email 2.31.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,
This series proposes patches for adding the following functionality
in SPI NAND core:

- Octal DTR SPI (8D-8D-8D) mode support

- Winbond W35N01JW SPI NAND chip support

- Power-on-Reset instruction support

This series has been tested on TI J721e EVM with the Winbond W35N01JW
flash with following test utilities:

- nandtest
  Test log: https://textbin.net/raw/fhypoz63f9

- mtd_stresstest
  Test log: https://textbin.net/raw/0xqjmqntj7

- UBIFS LTP stress test (NAND_XL_STRESS_DD_RW_UBIFS).
  Test log: https://textbin.net/raw/pyokws7wku

Datasheet: https://www.winbond.com/export/sites/winbond/datasheet/W35N01JW_Datasheet_Brief.pdf

Apurva Nandan (13):
  spi: spi-mem: Add DTR templates for cmd, address, dummy and data phase
  mtd: spinand: Add enum spinand_proto to indicate current SPI IO mode
  mtd: spinand: Setup spi_mem_op for the SPI IO protocol using reg_proto
  mtd: spinand: Fix odd byte addr and data phase in read/write reg op
    and write VCR op for Octal DTR mode
  mtd: spinand: Add adjust_op() in manufacturer_ops to modify the ops
    for manufacturer specific changes
  mtd: spinand: Add macros for Octal DTR page read and write operations
  mtd: spinand: Allow enabling Octal DTR mode in the core
  mtd: spinand: Reject 8D-8D-8D op_templates if octal_dtr_enale() is
    missing in manufacturer_op
  mtd: spinand: Add support for write volatile configuration register op
  mtd: spinand: Add octal_dtr_enable() for Winbond manufacturer_ops
  mtd: spinand: Add support for Power-on-Reset (PoR) instruction
  mtd: spinand: Perform Power-on-Reset when runtime_pm suspend is issued
  mtd: spinand: Add support for Winbond W35N01JW SPI NAND flash

 drivers/mtd/nand/spi/core.c    | 196 +++++++++++++++++++++++++++++++--
 drivers/mtd/nand/spi/winbond.c | 186 +++++++++++++++++++++++++++++--
 include/linux/mtd/spinand.h    |  67 +++++++++++
 include/linux/spi/spi-mem.h    |  87 ++++++++++-----
 4 files changed, 494 insertions(+), 42 deletions(-)

-- 
2.17.1

