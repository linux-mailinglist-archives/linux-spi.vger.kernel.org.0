Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB846F244
	for <lists+linux-spi@lfdr.de>; Thu,  9 Dec 2021 18:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhLIRo0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Dec 2021 12:44:26 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:51299 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhLIRoZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Dec 2021 12:44:25 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 1BE66240002;
        Thu,  9 Dec 2021 17:40:46 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v4 00/12] External ECC engines & Macronix support
Date:   Thu,  9 Dec 2021 18:40:34 +0100
Message-Id: <20211209174046.535229-1-miquel.raynal@bootlin.com>
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

Miquel Raynal (12):
  mtd: nand: mxic-ecc: Support SPI pipelined mode
  mtd: spinand: Delay a little bit the dirmap creation
  spi: spi-mem: Create a helper to gather all the supports_op checks
  spi: spi-mem: Add an ecc_en parameter to the spi_mem_op structure
  spi: spi-mem: Export the spi_mem_generic_supports_op() helper
  mtd: spinand: Create direct mapping descriptors for ECC operations
  spi: mxic: Fix the transmit path
  spi: mxic: Create a helper to configure the controller before an
    operation
  spi: mxic: Create a helper to ease the start of an operation
  spi: mxic: Add support for direct mapping
  spi: mxic: Use spi_mem_generic_supports_op()
  spi: mxic: Add support for pipelined ECC operations

 drivers/mtd/nand/ecc-mxic.c       | 210 ++++++++++++++++++-
 drivers/mtd/nand/spi/core.c       |  51 ++++-
 drivers/spi/Kconfig               |   2 +-
 drivers/spi/spi-mem.c             |  38 +++-
 drivers/spi/spi-mxic.c            | 337 ++++++++++++++++++++++++------
 include/linux/mtd/nand-ecc-mxic.h |  49 +++++
 include/linux/mtd/spinand.h       |   2 +
 include/linux/spi/spi-mem.h       |  16 ++
 8 files changed, 623 insertions(+), 82 deletions(-)
 create mode 100644 include/linux/mtd/nand-ecc-mxic.h

-- 
2.27.0

