Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335D442BF24
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 13:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhJMLqe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 07:46:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:44623 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhJMLqd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 13 Oct 2021 07:46:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="214558013"
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="214558013"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 04:44:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,370,1624345200"; 
   d="scan'208";a="563070986"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Oct 2021 04:44:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1AF852E4; Wed, 13 Oct 2021 14:44:33 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH v3 0/3] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM
Date:   Wed, 13 Oct 2021 14:44:29 +0300
Message-Id: <20211013114432.31352-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi all,

Based on discussion on the patch I sent some time ago here:

  http://lists.infradead.org/pipermail/linux-mtd/2021-June/086867.html

it turns out that the preferred way to deal with the SPI flash controller
drivers is through SPI MEM which is part of Linux SPI subsystem.

This series does that for the intel-spi driver. This also renames the
driver to follow the convention used in the SPI subsystem. The first patch
improves the write protection handling to be slightly more safer. The
following two patches do the conversion itself. Note the Intel SPI flash
controller only allows commands such as read, write and so on and it
internally uses whatever addressing etc. it figured from the SFDP on the
flash device.

Previous versions of the patch series can be found here:

  v2: https://lore.kernel.org/linux-mtd/20211007112132.30934-1-mika.westerberg@linux.intel.com/
  v1: https://lore.kernel.org/linux-mtd/20210930100719.2176-1-mika.westerberg@linux.intel.com/

Changes from v2:

  * Added tag from Andy
  * Check buswidth in intel_spi_supports_mem_op() and return false if octal
    mode is asked. The Intel controllers support buswidths 1-4 but this is
    not exposed to software. It figures this itself through SFDP tables.
  * In case of software sequencer, support same opcodes than we support with
    the hardware sequencer if found in the opcodes table.

Changes from v1:

  * Arrange dependencies in Kconfig entries the same way in both glue
    drivers.
  * Added empty lines between different subsystem includes.
  * dev_err() to single line
  * Return intel_spi_sw_cycle() directly in intel_spi_erase().
  * Drop redundant elses.
  * Fixed typo in the commit message of the patch 3/3.

Mika Westerberg (3):
  mtd: spi-nor: intel-spi: Disable write protection only if asked
  mtd: spi-nor: intel-spi: Convert to SPI MEM
  Documentation / MTD: Rename the intel-spi driver

 Documentation/driver-api/mtd/index.rst        |   2 +-
 .../mtd/{intel-spi.rst => spi-intel.rst}      |   8 +-
 drivers/mfd/lpc_ich.c                         |  59 ++-
 drivers/mtd/spi-nor/controllers/Kconfig       |  36 --
 drivers/mtd/spi-nor/controllers/Makefile      |   3 -
 drivers/mtd/spi-nor/controllers/intel-spi.h   |  21 --
 drivers/spi/Kconfig                           |  39 ++
 drivers/spi/Makefile                          |   3 +
 .../intel-spi-pci.c => spi/spi-intel-pci.c}   |  49 ++-
 .../spi-intel-platform.c}                     |  21 +-
 .../intel-spi.c => spi/spi-intel.c}           | 357 +++++++++++-------
 drivers/spi/spi-intel.h                       |  19 +
 include/linux/mfd/lpc_ich.h                   |   2 +-
 .../x86/{intel-spi.h => spi-intel.h}          |  12 +-
 14 files changed, 367 insertions(+), 264 deletions(-)
 rename Documentation/driver-api/mtd/{intel-spi.rst => spi-intel.rst} (94%)
 delete mode 100644 drivers/mtd/spi-nor/controllers/intel-spi.h
 rename drivers/{mtd/spi-nor/controllers/intel-spi-pci.c => spi/spi-intel-pci.c} (84%)
 rename drivers/{mtd/spi-nor/controllers/intel-spi-platform.c => spi/spi-intel-platform.c} (65%)
 rename drivers/{mtd/spi-nor/controllers/intel-spi.c => spi/spi-intel.c} (77%)
 create mode 100644 drivers/spi/spi-intel.h
 rename include/linux/platform_data/x86/{intel-spi.h => spi-intel.h} (64%)

-- 
2.33.0

