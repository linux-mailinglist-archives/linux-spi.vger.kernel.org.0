Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC36B476FD9
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 12:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhLPLRH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 06:17:07 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38103 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhLPLQ6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 06:16:58 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id ADFC5E0014;
        Thu, 16 Dec 2021 11:16:54 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v6 00/28] External ECC engines & Macronix support
Date:   Thu, 16 Dec 2021 12:16:26 +0100
Message-Id: <20211216111654.238086-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello all,

Here is a new iteration for this big series, this time I am reincluding
the initial binding changes because they changed very slightly and at
least it gives reviewers a better understanding of the entire work
again.

Once I'll get Rob's ack on the final DT change I will apply (in a topic
branch) all the patches until "mtd: nand: ecc: Provide a helper to
retrieve a pipelined engine device", which brings everything that is
needed to support external engines, as well as the Macronix example.

I will need further acknowledgments for the second half which brings
support for pipelined engines (even though I hope we are close to an
agreement now).

Cheers,
Miquèl

Changes in v6:
* Re-include the first patches because a few things have changed in the
  bindings. These are only style changes as Rob asked to group every
  property above or below the description field, which I applied to all
  the binding commits, but without any further update.
* Created a spi-mem capabilities structure. Put that one in the spi-mem
  ops strucure and ensured that all the controllers provided one.
* Created a default "no-caps" empty instance that controller drivers can
  point to by default.
* Dropped the spi_mem_generic_defaults_op() intermediate helper entirely
  (not needed anymore).

Changes in v5:
* Moved a helper in the core as it seems that it will be useful for
  other ECC engines as well (Xiangsheng Hou for Mediatek will need it).
* Changed the parameters of the spi_mem_generic_supports_op() function
  in order to take a structure as input instead of a list of arguments,
  which will be much easier to complement in the future if ever needed.

Changes in v4:
* The first half of the series has been left aside (all the binding
  changes + the external mode in the Macronix driver), now let's focus
  on the pipelined mode.
* Added the ecc_en spi_mem_op structure parameter in a dedicated commit.
* Introduced a new helper for supporting generically the supported ops.
* Used this new helper in the macronix driver.
* By default all the other drivers would refuse a spi_mem_op with ecc_en
  enabled.

Changes in v3:
* Added Mark's R-by.
* Added a commit changing the initialization order between the dirmaps
  and the ECC engine so that the core might now if we are using a
  pipelined engine or not.
* Stopped creating additional dirmaps with ECC if the engine is not a
  pipelined engine.
* Solved the kernel test robot reports. In particular, I added a
  dependency on MTD_NAND_ECC to Macronix SPI controller driver.
* Added a patch to clean the NAND controller yaml file before moving
  some bits to nand-chip.yaml. This addresses the comments made by Rob
  about the useless allOf's.
* Used platform_get_irq_byname_optional() in order to avoid useless
  warnings when there is no IRQ.

Changes in v2:
* Fixed the bindings and added Rob's acks when relevant.
* Added locking in the ECC engine driver.
* Brought more changes in the core in order to bring the ECC information
  into the spi_mem_op structure with the idea of avoiding any races
  between parallel calls on the same engine.
* Reorganized the ECC driver entirely in order to have a per-engine mxic
  structure plus a per-NAND context. This lead to a number of changes
  internally which cannot all be listed.

Changes since the RFC:
* Rebased on top of v5.15-rc1.
* Fixed the dirmap configuration.
* Added the various tags received.
* Fixed the bindings as reported by the robots.
* Fixed the return value of the helper counting bitflips.
* Included a fix from Jaime Liao in the external pattern logic.
* Added the yaml conversion of Macronix SPI controller description.
* Added the yaml conversion of the SPI-NAND description.
* Created a nand-chip.yaml file to share properties between SPI-NAND and
  raw NAND.

Mason Yang (1):
  mtd: spinand: macronix: Use random program load

Miquel Raynal (27):
  dt-bindings: mtd: nand-controller: Fix the reg property description
  dt-bindings: mtd: nand-controller: Fix a comment in the examples
  dt-bindings: mtd: nand-controller: Harmonize the property types
  dt-bindings: mtd: nand-chip: Create a NAND chip description
  dt-bindings: mtd: spi-nand: Convert spi-nand description file to yaml
  dt-bindings: vendor-prefixes: Clarify Macronix prefix
  dt-bindings: spi: mxic: The interrupt property is not mandatory
  dt-bindings: spi: mxic: Convert to yaml
  dt-bindings: spi: mxic: Document the nand-ecc-engine property
  dt-bindings: mtd: Describe Macronix NAND ECC engine
  mtd: nand: ecc: Add infrastructure to support hardware engines
  mtd: nand: Add a new helper to retrieve the ECC context
  mtd: nand: mxic-ecc: Add Macronix external ECC engine support
  mtd: nand: ecc: Provide a helper to retrieve a pilelined engine device
  mtd: nand: mxic-ecc: Support SPI pipelined mode
  mtd: spinand: Delay a little bit the dirmap creation
  spi: spi-mem: Fix a DTR related check in spi_mem_dtr_supports_op()
  spi: spi-mem: Introduce a capability structure
  spi: spi-mem: Fill the spi-mem controller capabilities of all the
    drivers
  spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper
  spi: spi-mem: Add an ecc_en parameter to the spi_mem_op structure
  mtd: spinand: Create direct mapping descriptors for ECC operations
  spi: mxic: Fix the transmit path
  spi: mxic: Create a helper to configure the controller before an
    operation
  spi: mxic: Create a helper to ease the start of an operation
  spi: mxic: Add support for direct mapping
  spi: mxic: Add support for pipelined ECC operations

 .../bindings/mtd/mxicy,nand-ecc-engine.yaml   |  77 ++
 .../devicetree/bindings/mtd/nand-chip.yaml    |  70 ++
 .../bindings/mtd/nand-controller.yaml         |  72 +-
 .../devicetree/bindings/mtd/spi-nand.txt      |   5 -
 .../devicetree/bindings/mtd/spi-nand.yaml     |  27 +
 .../bindings/spi/mxicy,mx25f0a-spi.yaml       |  65 ++
 .../devicetree/bindings/spi/spi-mxic.txt      |  34 -
 .../devicetree/bindings/vendor-prefixes.yaml  |   3 +
 drivers/mtd/nand/Kconfig                      |   6 +
 drivers/mtd/nand/Makefile                     |   1 +
 drivers/mtd/nand/core.c                       |  10 +-
 drivers/mtd/nand/ecc-mxic.c                   | 871 ++++++++++++++++++
 drivers/mtd/nand/ecc.c                        | 119 +++
 drivers/mtd/nand/spi/core.c                   |  51 +-
 drivers/mtd/nand/spi/macronix.c               |   2 +-
 drivers/spi/Kconfig                           |   2 +-
 drivers/spi/atmel-quadspi.c                   |   3 +-
 drivers/spi/spi-bcm-qspi.c                    |   1 +
 drivers/spi/spi-cadence-quadspi.c             |  10 +-
 drivers/spi/spi-dw-core.c                     |   1 +
 drivers/spi/spi-fsl-qspi.c                    |   1 +
 drivers/spi/spi-hisi-sfc-v3xx.c               |   1 +
 drivers/spi/spi-mem.c                         |  33 +-
 drivers/spi/spi-mtk-nor.c                     |   3 +-
 drivers/spi/spi-mxic.c                        | 340 +++++--
 drivers/spi/spi-npcm-fiu.c                    |   1 +
 drivers/spi/spi-nxp-fspi.c                    |   1 +
 drivers/spi/spi-rockchip-sfc.c                |   1 +
 drivers/spi/spi-rpc-if.c                      |   1 +
 drivers/spi/spi-stm32-qspi.c                  |   1 +
 drivers/spi/spi-ti-qspi.c                     |   1 +
 drivers/spi/spi-zynq-qspi.c                   |   1 +
 drivers/spi/spi-zynqmp-gqspi.c                |   1 +
 drivers/spi/spi.c                             |   3 +
 include/linux/mtd/nand-ecc-mxic.h             |  49 +
 include/linux/mtd/nand.h                      |  34 +
 include/linux/mtd/spinand.h                   |   2 +
 include/linux/spi/spi-mem.h                   |  27 +-
 38 files changed, 1727 insertions(+), 204 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/nand-chip.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
 create mode 100644 drivers/mtd/nand/ecc-mxic.c
 create mode 100644 include/linux/mtd/nand-ecc-mxic.h

-- 
2.27.0

