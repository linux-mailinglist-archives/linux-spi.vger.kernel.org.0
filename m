Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A78E483E3A
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jan 2022 09:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiADIgh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jan 2022 03:36:37 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45449 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiADIgg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jan 2022 03:36:36 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A8DD01C0006;
        Tue,  4 Jan 2022 08:36:31 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v9 00/13] External ECC engines & Macronix support
Date:   Tue,  4 Jan 2022 09:36:18 +0100
Message-Id: <20220104083631.40776-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello all,

I've applied the beginning of the series (bindings + ECC part) in a
branch named spi-mem-ecc on the MTD korg repository. After discussing a
bit more some details, I decided not to rush and did not apply the
second halve of the series for v5.17. Here is now the second halve again
in a hopefully better shape. I am expecting a few acks on this one and
I'll then rebase spi-mem-ecc on top of v5.18-rc1, apply these patches
and share them with the spi tree.

Cheers,
Miquèl

Changes in v9:
* Dropped the patch from Pratyush, keeping the DTR check in
  spi_mem_dtr_supports_op() as it was before the series. Pratyush will
  later reroll its entire series on top of this.
* Changed the location of the spi_controller_mem_caps capabilities to be
  in the spi-controller structure, as initially advised by Mark, then
  repeated by Boris and Pratyush.

Changes in v8:
* Applied this patch from Pratyush at the beginning of my series:
  https://lore.kernel.org/all/20210531181757.19458-5-p.yadav@ti.com/
  Made the necessary changes in the following commits.
* Changed the spi-mem-op ecc_en parameter to become ecc and match the
  dtr parameter. Changed its type to "u8 : 1" as well for the same
  reason. Moved it to the data sub-structure as advised by Pratyush.
* Added the received Acks/R-by.

Changes in v7:
* Added a macro to check if the caps are present or not before accessing
  them. This allows for optional caps.
* Dropped the 'no-caps' instance created in v6.
* Reworked a bit all the patches using these caps to have a nice and
  bisectable series, like adding missing static keywords.

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

Miquel Raynal (13):
  spi: spi-mem: Introduce a capability structure
  spi: spi-mem: Check the controller extra capabilities
  spi: cadence-quadspi: Provide a capability structure
  spi: mxic: Provide a capability structure
  spi: spi-mem: Kill the spi_mem_dtr_supports_op() helper
  spi: spi-mem: Add an ecc parameter to the spi_mem_op structure
  mtd: spinand: Delay a little bit the dirmap creation
  mtd: spinand: Create direct mapping descriptors for ECC operations
  spi: mxic: Fix the transmit path
  spi: mxic: Create a helper to configure the controller before an
    operation
  spi: mxic: Create a helper to ease the start of an operation
  spi: mxic: Add support for direct mapping
  spi: mxic: Add support for pipelined ECC operations

 drivers/mtd/nand/spi/core.c       |  51 ++++-
 drivers/spi/Kconfig               |   2 +-
 drivers/spi/spi-cadence-quadspi.c |  10 +-
 drivers/spi/spi-mem.c             |  32 +--
 drivers/spi/spi-mxic.c            | 340 ++++++++++++++++++++++++------
 include/linux/mtd/spinand.h       |   2 +
 include/linux/spi/spi-mem.h       |  27 ++-
 include/linux/spi/spi.h           |   3 +
 8 files changed, 367 insertions(+), 100 deletions(-)

-- 
2.27.0

