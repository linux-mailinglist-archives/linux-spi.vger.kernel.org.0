Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BF0455C43
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 14:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhKRNJW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Nov 2021 08:09:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:49544 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233335AbhKRNIq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Nov 2021 08:08:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="257961291"
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="257961291"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 05:05:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="473141954"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2021 05:05:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 169CD5B2; Thu, 18 Nov 2021 15:05:44 +0200 (EET)
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
Subject: [PATCH v4 3/3] Documentation / MTD: Rename the intel-spi driver
Date:   Thu, 18 Nov 2021 16:05:43 +0300
Message-Id: <20211118130543.11179-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211118130543.11179-1-mika.westerberg@linux.intel.com>
References: <20211118130543.11179-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since the driver is renamed (and moved) update the BIOS upgrade guide
accordingly from intel-spi to spi-intel. Keep the guide under MTD
documentation because this is pretty much still about MTD and SPI-NOR.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mauro Lima <mauro.lima@eclypsium.com>
---
 Documentation/driver-api/mtd/index.rst                    | 2 +-
 .../driver-api/mtd/{intel-spi.rst => spi-intel.rst}       | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)
 rename Documentation/driver-api/mtd/{intel-spi.rst => spi-intel.rst} (94%)

diff --git a/Documentation/driver-api/mtd/index.rst b/Documentation/driver-api/mtd/index.rst
index 436ba5a851d7..6a4278f409d7 100644
--- a/Documentation/driver-api/mtd/index.rst
+++ b/Documentation/driver-api/mtd/index.rst
@@ -7,6 +7,6 @@ Memory Technology Device (MTD)
 .. toctree::
    :maxdepth: 1
 
-   intel-spi
+   spi-intel
    nand_ecc
    spi-nor
diff --git a/Documentation/driver-api/mtd/intel-spi.rst b/Documentation/driver-api/mtd/spi-intel.rst
similarity index 94%
rename from Documentation/driver-api/mtd/intel-spi.rst
rename to Documentation/driver-api/mtd/spi-intel.rst
index 0465f6879262..df854f20ead1 100644
--- a/Documentation/driver-api/mtd/intel-spi.rst
+++ b/Documentation/driver-api/mtd/spi-intel.rst
@@ -1,5 +1,5 @@
 ==============================
-Upgrading BIOS using intel-spi
+Upgrading BIOS using spi-intel
 ==============================
 
 Many Intel CPUs like Baytrail and Braswell include SPI serial flash host
@@ -11,12 +11,12 @@ avoid accidental (or on purpose) overwrite of the content.
 Not all manufacturers protect the SPI serial flash, mainly because it
 allows upgrading the BIOS image directly from an OS.
 
-The intel-spi driver makes it possible to read and write the SPI serial
+The spi-intel driver makes it possible to read and write the SPI serial
 flash, if certain protection bits are not set and locked. If it finds
 any of them set, the whole MTD device is made read-only to prevent
 partial overwrites. By default the driver exposes SPI serial flash
 contents as read-only but it can be changed from kernel command line,
-passing "intel-spi.writeable=1".
+passing "spi_intel.writeable=1".
 
 Please keep in mind that overwriting the BIOS image on SPI serial flash
 might render the machine unbootable and requires special equipment like
@@ -32,7 +32,7 @@ Linux.
     serial flash. Distros like Debian and Fedora have this prepackaged with
     name "mtd-utils".
 
- 3) Add "intel-spi.writeable=1" to the kernel command line and reboot
+ 3) Add "spi_intel.writeable=1" to the kernel command line and reboot
     the board (you can also reload the driver passing "writeable=1" as
     module parameter to modprobe).
 
-- 
2.33.0

