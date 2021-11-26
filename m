Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D145ED04
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 12:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348903AbhKZL46 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 06:56:58 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:56663 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347651AbhKZLy6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 06:54:58 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 3DC36C155F;
        Fri, 26 Nov 2021 11:39:50 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 01197FF812;
        Fri, 26 Nov 2021 11:39:24 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/20] External ECC engines & Macronix support
Date:   Fri, 26 Nov 2021 12:39:04 +0100
Message-Id: <20211126113924.310459-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


Hello all,

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

Miquel Raynal (19):
  dt-bindings: mtd: nand-controller: Fix the reg property description
  dt-bindings: mtd: nand-controller: Fix a comment in the examples
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
  mtd: spinand: Create direct mapping descriptors for ECC operations
  spi: mxic: Fix the transmit path
  spi: mxic: Create a helper to configure the controller before an
    operation
  spi: mxic: Create a helper to ease the start of an operation
  spi: mxic: Add support for direct mapping
  spi: mxic: Add support for pipelined ECC operations

 .../bindings/mtd/mxicy,nand-ecc-engine.yaml   |  77 ++
 .../devicetree/bindings/mtd/nand-chip.yaml    |  71 ++
 .../bindings/mtd/nand-controller.yaml         |  57 +-
 .../devicetree/bindings/mtd/spi-nand.txt      |   5 -
 .../devicetree/bindings/mtd/spi-nand.yaml     |  27 +
 .../bindings/spi/mxicy,mx25f0a-spi.yaml       |  66 ++
 .../devicetree/bindings/spi/spi-mxic.txt      |  34 -
 .../devicetree/bindings/vendor-prefixes.yaml  |   3 +
 drivers/mtd/nand/Kconfig                      |   6 +
 drivers/mtd/nand/Makefile                     |   1 +
 drivers/mtd/nand/core.c                       |  10 +-
 drivers/mtd/nand/ecc-mxic.c                   | 901 ++++++++++++++++++
 drivers/mtd/nand/ecc.c                        |  88 ++
 drivers/mtd/nand/spi/core.c                   |  28 +-
 drivers/mtd/nand/spi/macronix.c               |   2 +-
 drivers/spi/spi-mxic.c                        | 326 ++++++-
 include/linux/mtd/nand-ecc-mxic.h             |  50 +
 include/linux/mtd/nand.h                      |  33 +
 include/linux/mtd/spinand.h                   |   2 +
 include/linux/spi/spi-mem.h                   |   3 +
 20 files changed, 1642 insertions(+), 148 deletions(-)
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

