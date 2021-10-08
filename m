Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AA1426E95
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhJHQYc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 12:24:32 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:50037 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhJHQYb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 12:24:31 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 6B314240003;
        Fri,  8 Oct 2021 16:22:29 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaimeliao@mxic.com.tw,
        juliensu@mxic.com.tw,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [RFC PATCH 00/10] Macronix ECC engine
Date:   Fri,  8 Oct 2021 18:22:18 +0200
Message-Id: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello all,

This series is not 100% stable yet but I believe it should be
sent out in order to help other people trying to use the ECC framework
with a SPI controller. Basically, Macronix ECC engine can be used as an
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

I will resubmit this later when I will be done validating the hardware
and the driver.

Cheers,
Miquèl

Mason Yang (1):
  mtd: spinand: macronix: Use random program load

Miquel Raynal (9):
  mtd: spinand: Fix comment
  dt-bindings: vendor-prefixes: Update Macronix prefix
  dt-bindings: mtd: Describe Macronix NAND ECC engine
  mtd: nand: ecc: Add infrastructure to support hardware engines
  mtd: nand: mxic-ecc: Add Macronix external ECC engine support
  mtd: nand: mxic-ecc: Support SPI pipelined mode
  spi: mxic: Fix the transmit path
  spi: mxic: Add support for direct mapping
  spi: mxic: Add support for pipelined ECC operations

 .../bindings/mtd/mxic,nand-ecc-engine.yaml    |  78 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   3 +
 drivers/mtd/nand/Kconfig                      |   6 +
 drivers/mtd/nand/Makefile                     |   1 +
 drivers/mtd/nand/core.c                       |  10 +-
 drivers/mtd/nand/ecc-mxic.c                   | 797 ++++++++++++++++++
 drivers/mtd/nand/ecc.c                        |  89 ++
 drivers/mtd/nand/spi/core.c                   |   2 +-
 drivers/mtd/nand/spi/macronix.c               |   2 +-
 drivers/spi/spi-mxic.c                        | 309 ++++++-
 include/linux/mtd/nand-ecc-mxic.h             |  36 +
 include/linux/mtd/nand.h                      |  11 +
 12 files changed, 1296 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mxic,nand-ecc-engine.yaml
 create mode 100644 drivers/mtd/nand/ecc-mxic.c
 create mode 100644 include/linux/mtd/nand-ecc-mxic.h

-- 
2.27.0

