Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8461E76C6
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 09:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgE2HhM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 03:37:12 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:24789 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgE2HhM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 03:37:12 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id 04T7aHpu067318;
        Fri, 29 May 2020 15:36:17 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com
Cc:     p.yadav@ti.com, juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v4 0/7] mtd: spi-nor: add xSPI Octal DTR support
Date:   Fri, 29 May 2020 15:36:08 +0800
Message-Id: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG4.macronix.com 04T7aHpu067318
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

JESD216C has defined specification for Octal 8S-8S-8S and 8D-8D-8D.
Based on JEDEC216C Basic Flash Parameter Table (BFPT) driver extract
DWORD-18: command and command extension type.
DWORD-20: Maximum operation speed of device in Octal mode.

xSPI profile 1.0 table:
DWORD-1: Read Fast command, the number of dummy cycles and address nbytes
	 for Read Status Register command.
DWORD-2: Read/Write volatile Register command for CFG Reg2.
DWORD-4 and DWORD-5: dummy cycles used for various frequencies based on
maximum speed of device from BFPT 20th DWORD.

Ccommand sequences to change to octal DTR mode:
The length of each command sequence is 8 per byte for single SPI mode and
patching driver to parse and execute these sequences for octal DTR mode.

By Vignesh's comments, this patches set is dependency on Pratyush's
[1][2][5][7][8] and [10][12].

Tested on Macronix's Zynq PicoZed board with Macronix's SPI controller
(spi-mxic.c) driver patched on mx25uw51245g Octal flash.

[1] https://patchwork.ozlabs.org/project/linux-mtd/patch/20200525091544.17270-2-p.yadav@ti.com/
[2] https://patchwork.ozlabs.org/project/linux-mtd/patch/20200525091544.17270-3-p.yadav@ti.com/
[5] https://patchwork.ozlabs.org/project/linux-mtd/patch/20200525091544.17270-6-p.yadav@ti.com/
[7] https://patchwork.ozlabs.org/project/linux-mtd/patch/20200525091544.17270-8-p.yadav@ti.com/
[8] https://patchwork.ozlabs.org/project/linux-mtd/patch/20200525091544.17270-9-p.yadav@ti.com/
[10] https://patchwork.ozlabs.org/project/linux-mtd/patch/20200525091544.17270-11-p.yadav@ti.com/
[12] https://patchwork.ozlabs.org/project/linux-mtd/patch/20200525091544.17270-13-p.yadav@ti.com/

Summary of change log
v4:
Removed Pratyush's patches set part.

v3:
Add support command sequences to change octal DTR mode and based on
part of Pratyush's patches set.

v2: 
Parse BFPT & xSPI table for Octal 8D-8D-8D mode parameters and enable Octal
mode in spi_nor_late_init_params().
Using Macros in spi_nor_spimem_read_data, spi_nor_spimem_write_data and
so on by Vignesh comments.

v1:
Without parsing BFPT & xSPI profile 1.0 table and enter Octal 8D-8D-8D
mode directly in spi_nor_fixups hooks.


thnaks for your time and review.
best regards,
Mason

Mason Yang (7):
  mtd: spi-nor: sfdp: get octal mode maximum speed from BFPT
  mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
  mtd: spi-nor: sfdp: parse command sequences to change octal DTR mode
  mtd: spi-nor: core: add configuration register 2 read & write support
  mtd: spi-nor: core: execute command sequences to change octal DTR mode
  spi: mxic: patch for octal DTR mode support
  mtd: spi-nor: macronix: Add Octal 8D-8D-8D supports for Macronix
    mx25uw51245g

 drivers/mtd/spi-nor/core.c     | 151 ++++++++++++++++++++++++-
 drivers/mtd/spi-nor/core.h     |  41 +++++++
 drivers/mtd/spi-nor/macronix.c |  55 +++++++++
 drivers/mtd/spi-nor/sfdp.c     | 246 +++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.h     |   4 +
 drivers/spi/spi-mxic.c         |  98 ++++++++++------
 6 files changed, 562 insertions(+), 33 deletions(-)

-- 
1.9.1

