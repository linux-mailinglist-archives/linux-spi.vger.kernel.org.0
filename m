Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5382E2901F6
	for <lists+linux-spi@lfdr.de>; Fri, 16 Oct 2020 11:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405827AbgJPJck (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Oct 2020 05:32:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:13863 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394926AbgJPJck (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Oct 2020 05:32:40 -0400
IronPort-SDR: 8TjIjk4A7P2OdlrDY5KhLQMR42qkAOjvqliQ4TlA0YDiG+fd4SC4Lflq7i9T0v6hUB0iZpeLs3
 pTABurC6Mo4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="251262326"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="251262326"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:32:40 -0700
IronPort-SDR: b3IAJ/inc4Ors43S6Y/XBEMgQ4ArEtssPm3w5MiKzpq4v0R6V6QLk4Y5pZOOBIPknp+UFJYS1K
 uEiFenBq9I+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="346481812"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2020 02:31:44 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     vigneshr@ti.com, tudor.ambarus@microchip.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 0/6] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC
Date:   Fri, 16 Oct 2020 17:31:32 +0800
Message-Id: <20201016093138.28871-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add QSPI controller support for Intel LGM SoC.

Note from Vignesh(mtd subsystem maintainer):
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

Reference:
	https://lkml.org/lkml/2020/6/1/50

Ramuthevar Vadivel Murugan (6):
  spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
  dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
  dt-bindings: spi: Add compatible for Intel LGM SoC
  spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
  spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
  spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC

 .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 ---------
 .../devicetree/bindings/spi/cadence-quadspi.yaml   | 149 +++++++++++++++++++++
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-cadence-quadspi.c                  |  29 ++++
 4 files changed, 179 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.yaml

-- 
2.11.0

