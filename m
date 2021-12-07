Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF67B46B73F
	for <lists+linux-spi@lfdr.de>; Tue,  7 Dec 2021 10:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhLGJiE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 7 Dec 2021 04:38:04 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46185 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbhLGJh5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 7 Dec 2021 04:37:57 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D1F1860007;
        Tue,  7 Dec 2021 09:34:22 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v3 00/22] External ECC engines & Macronix support
Date:   Tue,  7 Dec 2021 10:34:00 +0100
Message-Id: <20211207093422.166934-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello all,

~~~
Mark, I've added your Reviewed-by on all the SPI related patches, please
check and tell me if I made a mistake. In particular, I've added
something since v2: the spi-mxic.c driver now also depends on
MTD_NAND_ECC in order to avoid faulty situations where MTD/NAND=m and
SPI=y. Let me know if this does not work for you.
~~~

This series is now stable and brings support for external/modular ECC
engines, and let SPI controller using the ECC framework.

As a first example, Macronix ECC engine can be used as an
external engine (takes the data, proceeds to the calculations, writes
back the ECC bytes) or as a pipelined engine doing on-the-fly
calculations (which is very common in the raw NAND world).

In the device tree, the ECC engine should be described as a separated DT
node. Then:
* external case: the flash node should provide a nand-ecc-engine
  property pointing to the ECC engine node.
* pipelined case: the flash node should provide a nand-ecc-engine
  property pointing to the SPI controller, itself with another
  nand-ecc-engine property pointing at the ECC engine node.

This series comes with a bunch of improvements on the binding side as
well.

Cheers,
Miquèl

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

Miquel Raynal (21):
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
  mtd: nand: mxic-ecc: Support SPI pipelined mode
  mtd: spinand: Delay a little bit dirmap creation
  mtd: spinand: Create direct mapping descriptors for ECC operations
  spi: mxic: Fix the transmit path
  spi: mxic: Create a helper to configure the controller before an
    operation
  spi: mxic: Create a helper to ease the start of an operation
  spi: mxic: Add support for direct mapping
  spi: mxic: Add support for pipelined ECC operations

 .../bindings/mtd/mxicy,nand-ecc-engine.yaml   |  77 ++
 .../devicetree/bindings/mtd/nand-chip.yaml    |  70 ++
 .../bindings/mtd/nand-controller.yaml         |  62 +-
 .../devicetree/bindings/mtd/spi-nand.txt      |   5 -
 .../devicetree/bindings/mtd/spi-nand.yaml     |  27 +
 .../bindings/spi/mxicy,mx25f0a-spi.yaml       |  66 ++
 .../devicetree/bindings/spi/spi-mxic.txt      |  34 -
 .../devicetree/bindings/vendor-prefixes.yaml  |   3 +
 drivers/mtd/nand/Kconfig                      |   6 +
 drivers/mtd/nand/Makefile                     |   1 +
 drivers/mtd/nand/core.c                       |  10 +-
 drivers/mtd/nand/ecc-mxic.c                   | 900 ++++++++++++++++++
 drivers/mtd/nand/ecc.c                        |  88 ++
 drivers/mtd/nand/spi/core.c                   |  51 +-
 drivers/mtd/nand/spi/macronix.c               |   2 +-
 drivers/spi/Kconfig                           |   2 +-
 drivers/spi/spi-mxic.c                        | 326 ++++++-
 include/linux/mtd/nand-ecc-mxic.h             |  49 +
 include/linux/mtd/nand.h                      |  33 +
 include/linux/mtd/spinand.h                   |   2 +
 include/linux/spi/spi-mem.h                   |   3 +
 21 files changed, 1656 insertions(+), 161 deletions(-)
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

