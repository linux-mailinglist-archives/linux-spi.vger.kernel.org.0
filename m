Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4F34AF17A
	for <lists+linux-spi@lfdr.de>; Wed,  9 Feb 2022 13:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiBIM1F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Feb 2022 07:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiBIM0z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Feb 2022 07:26:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91585C05CB97
        for <linux-spi@vger.kernel.org>; Wed,  9 Feb 2022 04:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644409618; x=1675945618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFpIUGw14AgMHkvnE4GJbUCRxPCab9r82lvUt1HTyGE=;
  b=a2EKEuVQ1jNE21luXzUCZgfV7Or8rzb3X3i/6ylfQKZD6CR9BjBaFoDj
   +hUoyOU27VWdvovMFDOJPNd6QwmYvIEJ8NOVTUNdQV1eN0M3TpUZ+An7r
   mGvxNUaKEzqV38uPRR1sQl3xUxc/xPhkAyG+gtUxeLe6uTot+LZ0OlbWC
   Y+3bHJI5KpFq/GXCT3WAt/Lb/+U7Y8RwRZ/NxtHQfj1Ip1a7JIbWmsXzn
   WXkesPzW3IfGSNt0+ANkjkK6vi3gjqXnbkhM4HQ3hCX5JjdqjWYXNHHWB
   jwx9H3FXO3uEx1F2y0Df2TkgrS6csLMyg4rBEQMbBCPV5bn3pO8HfIQC6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="232758869"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="232758869"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 04:26:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="585546840"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 09 Feb 2022 04:26:52 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 61BC556A; Wed,  9 Feb 2022 14:27:07 +0200 (EET)
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
Subject: [PATCH v6 3/3] Documentation / MTD: Rename the intel-spi driver
Date:   Wed,  9 Feb 2022 15:27:06 +0300
Message-Id: <20220209122706.42439-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209122706.42439-1-mika.westerberg@linux.intel.com>
References: <20220209122706.42439-1-mika.westerberg@linux.intel.com>
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

Since the driver is renamed (and moved) update the BIOS upgrade guide
accordingly from intel-spi to spi-intel. Keep the guide under MTD
documentation because this is pretty much still about MTD and SPI-NOR.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mauro Lima <mauro.lima@eclypsium.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
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
2.34.1

