Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A839244EE2C
	for <lists+linux-spi@lfdr.de>; Fri, 12 Nov 2021 21:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbhKLU6M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Nov 2021 15:58:12 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:58664 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbhKLU6L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 12 Nov 2021 15:58:11 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Nov 2021 15:58:11 EST
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
Authentication-Results: mail.baikalelectronics.ru; dkim=permerror (bad message/signature format)
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] spi: dw: Cleanup macros/funcs naming and add IP-core version support
Date:   Fri, 12 Nov 2021 23:49:23 +0300
Message-ID: <20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patchset consists of the changes which I was going to introduce for a
long time, but due to lack of free time couldn't make it so far.
Nandhini's series [1] made me to proceed with this task so mate would
finally have his patchset accepted and merged into the mainline kernel.

There are three cleanup patches here and one feature patch. In framework
of the former patches we suggest to better organize the code. In
particular they concern the methods and macros naming unification (using a
unified prefixes of the code object names) and CSR fields macro
implementation using the bitfield helpers available in the kernel. The
later patch introduces the Synopsys Component Version register parsing
procedure so the corresponding data could be used for a version-specific
features implementation.  Nandhini will be mostly interested in the later
patch in the framework of his series [1].

Nandhini, could you please test the patchset out on your DWC SSI hardware?
After it's merged into the spi/for-next branch of the Mark' repository you
will be able to rebase your series on top of it and use the last patch
functionality for your benefit.

[1] https://lore.kernel.org/linux-spi/20211111065201.10249-4-nandhini.srikandan@intel.com/

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (4):
  spi: dw: Discard redundant DW SSI Frame Formats enumeration
  spi: dw: Put the driver entities naming in order
  spi: dw: Convert to using the Bitfield access macros
  spi: dw: Add Synopsys Component version reading and parsing

 drivers/spi/spi-dw-bt1.c  |   8 +-
 drivers/spi/spi-dw-core.c | 165 ++++++++++++++++++++++----------------
 drivers/spi/spi-dw-dma.c  |  50 ++++++------
 drivers/spi/spi-dw-mmio.c |  20 ++---
 drivers/spi/spi-dw-pci.c  |  59 +++++++-------
 drivers/spi/spi-dw.h      | 150 +++++++++++++++++-----------------
 6 files changed, 236 insertions(+), 216 deletions(-)

-- 
2.33.0

