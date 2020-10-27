Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0729A673
	for <lists+linux-spi@lfdr.de>; Tue, 27 Oct 2020 09:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894631AbgJ0IW7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Oct 2020 04:22:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:56613 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389898AbgJ0IW7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Oct 2020 04:22:59 -0400
IronPort-SDR: /NLgSCP6G1jFZyTfEQz9r2yaOemhwH96Xo+2RULxuNYXRicLIO7KoI93QQjJoQet9NjdSXN91/
 TSxZwFeml4cQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="229680962"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="229680962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 01:22:57 -0700
IronPort-SDR: yJvEEwg2rFeJjLDhaHPIA/8CCClPZtIYT7dNYNoOSy+rA6iTVQ2FCU1nbva5MA1RoY2pCcwco4
 EkQhi5D27l/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="424346666"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga001.fm.intel.com with ESMTP; 27 Oct 2020 01:22:54 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v4 0/6] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC
Date:   Tue, 27 Oct 2020 16:22:45 +0800
Message-Id: <20201027082251.30056-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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

 .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 ---------
 .../devicetree/bindings/spi/cadence-quadspi.yaml   | 149 +++++++++++++++++++++
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-cadence-quadspi.c                  |  31 +++++
 4 files changed, 181 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.yaml

-- 
2.11.0

