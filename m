Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6766844FC39
	for <lists+linux-spi@lfdr.de>; Sun, 14 Nov 2021 23:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhKNWdf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Nov 2021 17:33:35 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:35856 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhKNWdf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Nov 2021 17:33:35 -0500
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
Authentication-Results: mail.baikalelectronics.ru; dkim=permerror (bad message/signature format)
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] spi: dw: Cleanup macros/funcs naming and add IP-core version support
Date:   Mon, 15 Nov 2021 01:30:20 +0300
Message-ID: <20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I was going to submit a cleanup patchset for the DW SSI driver for a
long time, but due to lack of free time couldn't make it so far.
Nandhini's series [1] made me to proceed with this task so mate would
finally have his patchset accepted and merged into the mainline kernel.

There are four cleanup patches here and two feature patches. In the
framework of the former patches we convert the DW SPI driver to using
module namespaces and provide a better code organization. In particular
the second part concerns the methods and macros naming unification (using
a unified prefixes of the code object names) and the CSR fields macro
implementation using the bitfield helpers available in the kernel. The
later patches introduces the DW SSI IP-core versions interface so it
could be used for a version-specific features implementation.  Nandhini
will be mostly interested in the later patches in the framework of his
series [1].

Nandhini, could you please test the patchset out on your DWC SSI hardware?
After it's merged into the spi/for-next branch of the Mark' repository you
will be able to rebase your series on top of it and use the last IP-core
version interface for your benefit.

Andy, I haven't added your tag to the new patches and to the patch
with the IP-core version interface.

[1] https://lore.kernel.org/linux-spi/20211111065201.10249-4-nandhini.srikandan@intel.com

Link: https://lore.kernel.org/linux-spi/20211112204927.8830-1-Sergey.Semin@baikalelectronics.ru
Changelog v2:
- Replace "assi" suffixes with "pssi" in the spi-dw-mmio.c methods.
  (Thanks Andy for noticing this pity mistake)
- Add new patches:
  [PATCH v2 6/6] spi: dw: Replace DWC_HSSI capability with IP-core version checker
  [PATCH v2 1/6] spi: dw: Add symbol namespaces for the core and DMA modules
- Replace the ASCII-to-integer conversion with a unified IP-core versioning
  interface (Suggested by Andy).

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (6):
  spi: dw: Add a symbols namespace for the core module
  spi: dw: Discard redundant DW SSI Frame Formats enumeration
  spi: dw: Put the driver entities naming in order
  spi: dw: Convert to using the Bitfield access macros
  spi: dw: Introduce Synopsys IP-core versions interface
  spi: dw: Replace DWC_HSSI capability with IP-core version checker

 drivers/spi/spi-dw-bt1.c  |   9 +-
 drivers/spi/spi-dw-core.c | 175 ++++++++++++++++++++----------------
 drivers/spi/spi-dw-dma.c  |  57 ++++++------
 drivers/spi/spi-dw-mmio.c |  22 ++---
 drivers/spi/spi-dw-pci.c  |  60 ++++++-------
 drivers/spi/spi-dw.h      | 182 ++++++++++++++++++++------------------
 6 files changed, 273 insertions(+), 232 deletions(-)

-- 
2.33.0

