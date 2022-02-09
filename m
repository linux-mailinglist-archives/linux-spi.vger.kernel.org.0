Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF78E4AF17B
	for <lists+linux-spi@lfdr.de>; Wed,  9 Feb 2022 13:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiBIM1E (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Feb 2022 07:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiBIM0y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Feb 2022 07:26:54 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBBCC05CB96
        for <linux-spi@vger.kernel.org>; Wed,  9 Feb 2022 04:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644409617; x=1675945617;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f5YRrzdrcrmQub6o/I68LvZKeDeM+mn9ZaD3mStbYdY=;
  b=RqrvDS8AfqXrew+E4WQSNwkaEYbvGE2z5TCoQQ186Rzz2odnEkw8O5Bm
   gBhYL8GREWWZrX5jVGA836AKzzf6fZbt4hKrWltoZwTqVV7RTRNvUVI9K
   YVH1TZw2p9uJCT9u7UplB9sydwtKQlkVLXGnQjWlytw44Mix6f8oJPoJu
   RYKrjzShGAo/NtAlBvf8DpGwFOBY5fNXwbySKRndgNEvlqr8zBz7di7Zt
   jld5ylvZv+phfM7ACR8KtkSuShqhrCEzBPWQV19Ws6NRrhjP5CwDWOUct
   A7era7MdOPxxWV9AfXK7TKu2cI4QQKWXOsEctF1ahbl3C7+ue7HQtHIIk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="232758866"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="232758866"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:26:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="585546838"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2022 04:26:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 37728509; Wed,  9 Feb 2022 14:27:06 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH v6 0/3] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM
Date:   Wed,  9 Feb 2022 15:27:03 +0300
Message-Id: <20220209122706.42439-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

  v5: https://lore.kernel.org/linux-mtd/20211220164625.9400-1-mika.westerberg@linux.intel.com/
  v4: https://lore.kernel.org/linux-mtd/20211118130543.11179-1-mika.westerberg@linux.intel.com/
  v3: https://lore.kernel.org/linux-mtd/20211013114432.31352-1-mika.westerberg@linux.intel.com/
  v2: https://lore.kernel.org/linux-mtd/20211007112132.30934-1-mika.westerberg@linux.intel.com/
  v1: https://lore.kernel.org/linux-mtd/20210930100719.2176-1-mika.westerberg@linux.intel.com/

Changes from v5:

  * Added tags from Pratyush Yadav and Tudor Ambarus
  * Added replacement_op field to intel_spi_mem_op to be used with
    erase operations
  * Return -EOPNOTSUPP if no match is found in intel_spi_exec_mem_op()

Changes from v4:

  * Correct check in intel_spi_cmp_mem_op()
  * Added tag from Boris

Changes from v3:

  * Create an array of supported opcodes and reject everything else.
  * Fix checkpatch warnings reported by Mauro
  * Added tags from Lee and Mauro

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
 drivers/mfd/lpc_ich.c                         |  59 +-
 drivers/mtd/spi-nor/controllers/Kconfig       |  36 -
 drivers/mtd/spi-nor/controllers/Makefile      |   3 -
 drivers/mtd/spi-nor/controllers/intel-spi.h   |  21 -
 drivers/spi/Kconfig                           |  39 +
 drivers/spi/Makefile                          |   3 +
 .../intel-spi-pci.c => spi/spi-intel-pci.c}   |  49 +-
 .../spi-intel-platform.c}                     |  21 +-
 .../intel-spi.c => spi/spi-intel.c}           | 850 ++++++++++++------
 drivers/spi/spi-intel.h                       |  19 +
 include/linux/mfd/lpc_ich.h                   |   2 +-
 .../x86/{intel-spi.h => spi-intel.h}          |  12 +-
 14 files changed, 719 insertions(+), 405 deletions(-)
 rename Documentation/driver-api/mtd/{intel-spi.rst => spi-intel.rst} (94%)
 delete mode 100644 drivers/mtd/spi-nor/controllers/intel-spi.h
 rename drivers/{mtd/spi-nor/controllers/intel-spi-pci.c => spi/spi-intel-pci.c} (84%)
 rename drivers/{mtd/spi-nor/controllers/intel-spi-platform.c => spi/spi-intel-platform.c} (65%)
 rename drivers/{mtd/spi-nor/controllers/intel-spi.c => spi/spi-intel.c} (55%)
 create mode 100644 drivers/spi/spi-intel.h
 rename include/linux/platform_data/x86/{intel-spi.h => spi-intel.h} (64%)

-- 
2.34.1

