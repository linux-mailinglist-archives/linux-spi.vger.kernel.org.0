Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E9B4524FF
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 02:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357975AbhKPBqY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 20:46:24 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:45062 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbhKOSYN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 13:24:13 -0500
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
Subject: [PATCH v3 0/7] spi: dw: Cleanup macros/funcs naming and add IP-core version support
Date:   Mon, 15 Nov 2021 21:19:10 +0300
Message-ID: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
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

There are four cleanup patches here and three feature patches. In the
framework of the former patches we convert the DW SPI driver to using
module namespaces and provide a better code organization. In particular
the second part concerns the methods and macros naming unification (using
a unified prefixes of the code object names) and the CSR fields macro
implementation using the bitfield helpers available in the kernel. The
later patches introduce the DW SSI IP-core versions interface so it
could be used for a version-specific features implementation. Nandhini
will be mostly interested in the later patches in the framework of his
series [1].

Nandhini, could you please test the patchset out on your DWC SSI hardware?
After it's merged into the spi/for-next branch of the Mark' repository you
will be able to rebase your series on top of it and use the last IP-core
version interface for your benefit.

Andy, I have added your tag to all the patches except the last one since
it's new (though suggested by you).

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

Link: https://lore.kernel.org/linux-spi/20211114223026.13359-1-Sergey.Semin@baikalelectronics.ru
Changelog v3:
- Discard the symbols importing from the spi-dw-dma object since it's
  linked into the spi-dw-core module anyway thus having the same symbols
  namespace.
- Move the DW_SPI_CAP_DFS32 capability flag position fix to a separate
  patch.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Serge Semin (7):
  spi: dw: Add a symbols namespace for the core module
  spi: dw: Discard redundant DW SSI Frame Formats enumeration
  spi: dw: Put the driver entities naming in order
  spi: dw: Convert to using the Bitfield access macros
  spi: dw: Introduce Synopsys IP-core versions interface
  spi: dw: Replace DWC_HSSI capability with IP-core version checker
  spi: dw: Define the capabilities in a continuous bit-flags set

 drivers/spi/spi-dw-bt1.c  |   9 +-
 drivers/spi/spi-dw-core.c | 175 ++++++++++++++++++++----------------
 drivers/spi/spi-dw-dma.c  |  55 ++++++------
 drivers/spi/spi-dw-mmio.c |  22 ++---
 drivers/spi/spi-dw-pci.c  |  60 ++++++-------
 drivers/spi/spi-dw.h      | 182 ++++++++++++++++++++------------------
 6 files changed, 271 insertions(+), 232 deletions(-)

-- 
2.33.0

