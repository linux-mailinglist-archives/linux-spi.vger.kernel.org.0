Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A00A29FD41
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 06:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgJ3Fb7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 01:31:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:29693 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgJ3Fb7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Oct 2020 01:31:59 -0400
IronPort-SDR: U1wskGKyUx5cr+ZgRnf8HWvF+YVabt6Vi81MbY1ySCJTyJZKS+Uqp8GXGVRmSmkXo8EpWOulXA
 wkUSGRoM42EQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="165065156"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="165065156"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 22:31:59 -0700
IronPort-SDR: vxUjKadQ/48teY3wzsDK6UiTeYbmt2YJ4FjdSmjptCcDISmyYVkEAm3KtDbi79yTjx2r7mSjCG
 /SnEg+h4AwHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="304673625"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga008.fm.intel.com with ESMTP; 29 Oct 2020 22:31:55 -0700
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
Subject: [PATCH v6 0/6] spi: cadence-quadspi: Add QSPI controller support for Intel LGM SoC
Date:   Fri, 30 Oct 2020 13:31:47 +0800
Message-Id: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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

 .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 ---------
 .../devicetree/bindings/spi/cadence-quadspi.yaml   | 150 +++++++++++++++++++++
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-cadence-quadspi.c                  |  31 +++++
 4 files changed, 182 insertions(+), 68 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.yaml

-- 
2.11.0

