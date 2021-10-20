Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5A7434D94
	for <lists+linux-spi@lfdr.de>; Wed, 20 Oct 2021 16:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhJTOa3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Oct 2021 10:30:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49967 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhJTOa2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Oct 2021 10:30:28 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AE17A20003;
        Wed, 20 Oct 2021 14:28:09 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 00/18] External ECC engines & Macronix support
Date:   Wed, 20 Oct 2021 16:27:51 +0200
Message-Id: <20211020142809.349347-1-miquel.raynal@bootlin.com>
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

Miquel Raynal (17):
  dt-bindings: mtd: nand-controller: Fix the reg property description
  dt-bindings: mtd: nand-controller: Fix a comment in the examples
  dt-bindings: mtd: nand-chip: Create a NAND chip description
  dt-bindings: mtd: spi-nand: Convert spi-nand description file to yaml
  dt-bindings: vendor-prefixes: Clarify Macronix prefix
  dt-bindings: spi: mxic: The interrupt property is not mandatory
  dt-bindings: spi: mxic: Convert to yaml
  dt-bindings: mtd: Describe Macronix NAND ECC engine
  dt-bindings: spi: mxic: Document the nand-ecc-engine property
  mtd: nand: ecc: Add infrastructure to support hardware engines
  mtd: nand: mxic-ecc: Add Macronix external ECC engine support
  mtd: nand: mxic-ecc: Support SPI pipelined mode
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
 .../bindings/spi/mxicy,mx25f0a-spi.yaml       |  73 ++
 .../devicetree/bindings/spi/spi-mxic.txt      |  34 -
 .../devicetree/bindings/vendor-prefixes.yaml  |   3 +
 drivers/mtd/nand/Kconfig                      |   6 +
 drivers/mtd/nand/Makefile                     |   1 +
 drivers/mtd/nand/core.c                       |  10 +-
 drivers/mtd/nand/ecc-mxic.c                   | 799 ++++++++++++++++++
 drivers/mtd/nand/ecc.c                        |  89 ++
 drivers/mtd/nand/spi/macronix.c               |   2 +-
 drivers/spi/spi-mxic.c                        | 328 +++++--
 include/linux/mtd/nand-ecc-mxic.h             |  36 +
 include/linux/mtd/nand.h                      |  11 +
 17 files changed, 1483 insertions(+), 146 deletions(-)
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

