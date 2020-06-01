Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB31E9EBB
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jun 2020 09:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgFAHFY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jun 2020 03:05:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39674 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAHFY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jun 2020 03:05:24 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05175Cpv014656;
        Mon, 1 Jun 2020 02:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590995112;
        bh=NNHhHVmUs1TCxOahOCyW9vdh5Muz5GlQSSTsH/tgPvg=;
        h=From:To:CC:Subject:Date;
        b=hreMb2hhTAVAU5px8jp2lLKKNmyRkaHvkmlgRnAnZg6/UmHacEnVKE7vMHJOhUTDV
         z/j9HFep7TLFkGLcH3lMRhXykIpmIPa5uSv/tsYHGbxA63F6tVAzLfybkfmlOty88r
         QyWRbWrws/Uhtlk3wEVZeqSsEA0BfefsbgzNKoXY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05175C6F061784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Jun 2020 02:05:12 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Jun
 2020 02:05:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Jun 2020 02:05:12 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 051758s2016257;
        Mon, 1 Jun 2020 02:05:09 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: [RESEND PATCH v3 0/8] mtd: spi-nor: Move cadence-qaudspi to spi-mem framework
Date:   Mon, 1 Jun 2020 12:34:36 +0530
Message-ID: <20200601070444.16923-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series is a subset of "[PATCH v12 0/4] spi: cadence-quadspi: Add
support for the Cadence QSPI controller" by Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> that intended to move
cadence-quadspi driver to spi-mem framework

Those patches were trying to accomplish too many things in a single set
of patches and need to split into smaller patches. This is reduced
version of above series.

Changes that are intended to make migration easy are split into separate
patches. Patches 1 to 3 drop features that cannot be supported under
spi-mem at the moment (backward compatibility is maintained).
Patch 4-5 are trivial cleanups. Patch 6 does the actual conversion to
spi-mem and patch 7 moves the driver to drivers/spi folder.

I have tested both INDAC mode (used by non TI platforms like Altera
SoCFPGA) and DAC mode (used by TI platforms) on TI EVMs.

Patches to move move bindings over to
"Documentation/devicetree/bindings/spi/" directory and also conversion
of bindig doc to YAML will be posted separately.  Support for Intel
platform would follow that.

Resend v3:
Rebased onto v5.7-c1

v3:
Split handling of probe deferral into separate patch (out of 5/6)
Split dropping of redundant WREN to separate patch (out of 5/6)
Fix a possible memleak due to lack of spi_master_put()
Parse all SPI slave nodes in cqspi_setup_flash()
Address misc comments from Tudor on v2
Rebase onto latest spi-nor/next

v2:
Rework patch 1/6 to keep "cdns,is-decoded-cs" property supported.


Ramuthevar Vadivel Murugan (2):
  mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework
  spi: Move cadence-quadspi driver to drivers/spi/

Vignesh Raghavendra (6):
  mtd: spi-nor: cadence-quadspi: Make driver independent of flash
    geometry
  mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
  mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on
    failure
  mtd: spi-nor: cadence-quadspi: Fix error path on failure to acquire
    reset lines
  mtd: spi-nor: cadence-quadspi: Handle probe deferral while requesting
    DMA channel
  mtd: spi-nor: cadence-quadspi: Drop redundant WREN in erase path

 drivers/mtd/spi-nor/controllers/Kconfig       |  11 -
 drivers/mtd/spi-nor/controllers/Makefile      |   1 -
 drivers/spi/Kconfig                           |  11 +
 drivers/spi/Makefile                          |   1 +
 .../spi-cadence-quadspi.c}                    | 541 +++++++-----------
 5 files changed, 222 insertions(+), 343 deletions(-)
 rename drivers/{mtd/spi-nor/controllers/cadence-quadspi.c => spi/spi-cadence-quadspi.c} (74%)

-- 
2.26.2

