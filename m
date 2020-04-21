Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D31B1F86
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 09:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgDUHJH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 03:09:07 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:50584 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgDUHJH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Apr 2020 03:09:07 -0400
X-Greylist: delayed 1705 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Apr 2020 03:09:06 EDT
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 03L6eeAQ046610
        for <linux-spi@vger.kernel.org>; Tue, 21 Apr 2020 14:40:40 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 03L6dnMW045498;
        Tue, 21 Apr 2020 14:39:49 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v2 0/5] mtd: spi-nor: Add support for Octal 8D-8D-8D mode
Date:   Tue, 21 Apr 2020 14:39:42 +0800
Message-Id: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com 03L6dnMW045498
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

This is repost of patchset from Boris Brezillon's
[RFC,00/18] mtd: spi-nor: Proposal for 8-8-8 mode support [1].

Background from cover letter for RFC[1].

The trend has been around Octal NOR Flash lately and the latest mainline
already supports 1-1-8 and 1-8-8 modes.

Boris opened a discussion on how we should support stateful modes (X-X-X
and XD-XD-XD, where X is the bus width and D means Double Transfer Rate).

JESD216C has defined specification for Octal 8S-8S-8S and 8D-8D-8D.
Based on JEDEC216C Basic Flash Parameter Table (BFPT) driver extract:
DWORD-18: command and command extension type.
DWORD-19: enable 8S-8S-8S/8D-8D-8D mode sequences by two instructions or
	  write CFG Reg 2.
DWORD-20: Maximum operation speed of device in Octal mode.

and xSPI profile 1.0 table:
DWORD-1: Read Fast command, the number of dummy cycles and address nbytes
	 for Read Status Register command.
DWORD-2: Read/Write volatile Register command for CFG Reg2.
DWORD-4 and DWORD-5: dummy cycles used for various frequencies.

The first set of patches is according to JESD216C adding Double Transfer
Rate(DTR) fields, extension command and command bytes number to the
spi_mem_op struct. This is from Boris patchset.

The second set of patches parse the xSPI profile 1.0 table for parameters
needed in Octal 8D-8D-8D mode. 

The third set of patches extract BFPT DWORD018,19,20 and define the 
relevant macros and enum in spi-nor layer for Octal 8S-8S-8S and 
8D-8D-8D mode operation. Parts of these are refer to Boris patchset but
we enable Octal 8D-8D-8D mode in spi_nor_late_init_params() rather than
Boris's adding a change_mode() call-back function.

The last set of patches in the series support Macronix mx25uw51245g
to tweak flash parameters a correct dummy cycles set for various frequency.

Also patched spi-mxic driver for testing on Macronix's Zynq PicoZed board
with Macronix's SPI controller (spi-mxic.c) and mx25uw51245g Octal flash.

[1] https://patchwork.ozlabs.org/cover/982926/


Summary of change log
---------------------
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

Mason Yang (5):
  mtd: spi-nor: Add support for Octal 8D-8D-8D mode
  mtd: spi-nor: sfdp: Add support for xSPI profile 1.0 table
  mtd: spi-nor: Parse BFPT DWORD-18,19 and 20 for Octal 8D-8D-8D mode
  mtd: spi-nor: macronix: Add Octal 8D-8D-8D supports for Macronix
    mx25uw51245g
  spi: mxic: Patch for Octal 8D-8D-8D mode support

 drivers/mtd/spi-nor/core.c     | 220 ++++++++++++++++++++++++++++++++++++++--
 drivers/mtd/spi-nor/core.h     |  31 ++++++
 drivers/mtd/spi-nor/macronix.c |  41 ++++++++
 drivers/mtd/spi-nor/sfdp.c     | 222 ++++++++++++++++++++++++++++++++++++++++-
 drivers/mtd/spi-nor/sfdp.h     |  16 ++-
 drivers/spi/spi-mem.c          |   8 +-
 drivers/spi/spi-mxic.c         | 101 +++++++++++++------
 include/linux/mtd/spi-nor.h    |  51 +++++++++-
 include/linux/spi/spi-mem.h    |  13 +++
 9 files changed, 654 insertions(+), 49 deletions(-)

-- 
1.9.1

