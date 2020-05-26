Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E394B1E1EB3
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 11:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbgEZJhd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 05:37:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36776 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbgEZJhc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 May 2020 05:37:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04Q9bFA8034059;
        Tue, 26 May 2020 04:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590485835;
        bh=9aC5z2QPUSspxTgWIOcSf4RjNcIj4QMhk56xxtrcX2c=;
        h=From:To:CC:Subject:Date;
        b=nLVPrNIdpj0DwMapU7Wxvf2n+EVCK+A/Pkb7shPi+2vvPx+VHnu1lS0cLaQPjTcZz
         qFdrtCeZYGQKp6dkR/busOQnblTgRQeNvH4HA4TsTdyxAK3PEBNQQsxE9K8QRplAZz
         HCpOECDP3TZsaFYgub6+Gw3t1tmvDXFMG+lQv1bM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04Q9bFN2099815
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 04:37:15 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 May 2020 04:37:15 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 26 May 2020 04:37:15 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04Q9b9hJ066907;
        Tue, 26 May 2020 04:37:10 -0500
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
Subject: [PATCH v2 0/6] mtd: spi-nor: Move cadence-qaudspi to spi-mem framework
Date:   Tue, 26 May 2020 15:05:58 +0530
Message-ID: <20200526093604.11846-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

mtd: spi-nor: Move cadence-qaudspi to spi-mem framework

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

v2:
Rework patch 1/6 to keep "cdns,is-decoded-cs" property supported.


Ramuthevar Vadivel Murugan (2):
  mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework
  spi: Move cadence-quadspi driver to drivers/spi/

Vignesh Raghavendra (4):
  mtd: spi-nor: cadence-quadspi: Make driver independent of flash
    geometry
  mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
  mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on
    failure
  mtd: spi-nor: cadence-quadspi: Fix error path on failure to acquire
    reset lines

 drivers/mtd/spi-nor/controllers/Kconfig       |  11 -
 drivers/mtd/spi-nor/controllers/Makefile      |   1 -
 drivers/spi/Kconfig                           |  11 +
 drivers/spi/Makefile                          |   1 +
 .../spi-cadence-quadspi.c}                    | 521 +++++++-----------
 5 files changed, 206 insertions(+), 339 deletions(-)
 rename drivers/{mtd/spi-nor/controllers/cadence-quadspi.c => spi/spi-cadence-quadspi.c} (74%)

-- 
2.26.2

