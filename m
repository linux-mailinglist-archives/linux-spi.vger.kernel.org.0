Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF782B3BAF
	for <lists+linux-spi@lfdr.de>; Mon, 16 Nov 2020 04:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKPDKO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Nov 2020 22:10:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:42262 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgKPDKN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 15 Nov 2020 22:10:13 -0500
IronPort-SDR: djWTrLSP/YkzghHz+Qth35KN2pcVFPaVZkmWWFTfdebMijOpQD3M38OO7DVCCGFPcsKLL9PmRA
 8laHWVlbHqKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="188738386"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="188738386"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 19:10:10 -0800
IronPort-SDR: TaDzZTfWkaejxD4kS6h9W9HBW18eGESkAesfrzvY792ZwXvRrcwEtVfLipnTdIjiiY6i19NkXL
 vxN9QMeA1DsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="533266214"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2020 19:10:08 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, vigneshr@ti.com, p.yadav@ti.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v7 0/6] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC
Date:   Mon, 16 Nov 2020 11:09:57 +0800
Message-Id: <20201116031003.19062-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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

---
v7:
  - Rob's review comments address and fixed dt-schema warning 
  - Pratyush review comments address and update
  - DAC bit reset to 0 and 1 (enable/disable)
  - tested QSI-NOR flash mx25l12805d on LGM soc, it's working after disable DAC
  - Linus suggested to use 'num-cs' prperty instead of 'num-chipselect'
v6:
  - Rob's review comments update
  - add compatible string in properly aligned
  - remove cadence-qspi extra comaptible string in example
v5:
  - Rob's review comments update
  - const with single compatible string kept
v4:
  - Rob's review comments update
  - remove '|' no formatting to preserve
  - child node attributes follows under 'properties' under '@[0-9a-f]+$'.
v3:
  - Pratyush review comments update
  - CQSPI_SUPPORTS_MULTI_CHIPSELECT macro used instead of cqspi->use_direct_mode
  - disable DAC support placed in end of controller_init
v2:
  - Rob's review comments update for dt-bindings
  - add 'oneOf' for compatible selection
  - drop un-neccessary descriptions
  - add the cdns,is-decoded-cs and cdns,rclk-en properties as schema
  - remove 'allOf' in not required place
  - add AdditionalProperties false
  - add minItems/maxItems for qspi reset attributes

resend-v1:
  - As per Mark's suggestion , reorder the patch series 1-3 driver
    support patches, series 4-6 dt-bindings patches.
v1:
  - initial version

Ramuthevar Vadivel Murugan (6):
  spi: cadence-quadspi: Add QSPI support for Intel LGM SoC
  spi: cadence-quadspi: Disable the DAC for Intel LGM SoC
  spi: cadence-quadspi: Add multi-chipselect support for Intel LGM SoC
  spi: Move cadence-quadspi.txt to Documentation/devicetree/bindings/spi
  dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
  dt-bindings: spi: Add compatible for Intel LGM SoC

 .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 ----------
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 148 +++++++++++++++++++++
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-cadence-quadspi.c                  |  33 ++++-
 4 files changed, 178 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml

-- 
2.11.0

