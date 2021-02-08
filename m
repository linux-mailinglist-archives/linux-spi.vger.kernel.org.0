Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07A63139BA
	for <lists+linux-spi@lfdr.de>; Mon,  8 Feb 2021 17:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhBHQkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 8 Feb 2021 11:40:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:4729 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233948AbhBHQkJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 8 Feb 2021 11:40:09 -0500
IronPort-SDR: aZyegPLrLsyVJGlLKBmOTvsW0UGaw4+mgE9KpuMtPygmxJDLRR3qaIvWAtw8uphoB5h6DvVaDT
 L5lSi1lPJGMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180963087"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180963087"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 08:38:19 -0800
IronPort-SDR: STixT51LwPwIXVFadGVFG9oRMkqHYGlPOA87ZEUbTsic+Hr9uMKC4J/mXoAr+TKUGEYkVY+0Iu
 WHNFfGFVgrSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="584862083"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 08 Feb 2021 08:38:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 49C8F8D; Mon,  8 Feb 2021 18:38:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>
Subject: [PATCH v1 2/2] spi: pxa2xx: Add IDs for the controllers found on Intel Lynxpoint
Date:   Mon,  8 Feb 2021 18:38:16 +0200
Message-Id: <20210208163816.22147-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208163816.22147-1-andriy.shevchenko@linux.intel.com>
References: <20210208163816.22147-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add IDs for the controllers found on Intel Lynxpoint.
In particular it's Macbook Air 6,2 devices.

Cc: Leif Liddy <leif.liddy@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index aafac128bb5f..14fc41ed2361 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -295,6 +295,8 @@ static const struct pci_device_id pxa2xx_spi_pci_devices[] = {
 	{ PCI_VDEVICE(INTEL, 0x2290), PORT_BSW1 },
 	{ PCI_VDEVICE(INTEL, 0x22ac), PORT_BSW2 },
 	{ PCI_VDEVICE(INTEL, 0x2e6a), PORT_CE4100 },
+	{ PCI_VDEVICE(INTEL, 0x9c65), PORT_LPT0 },
+	{ PCI_VDEVICE(INTEL, 0x9c66), PORT_LPT1 },
 	{ PCI_VDEVICE(INTEL, 0x9ce5), PORT_LPT0 },
 	{ PCI_VDEVICE(INTEL, 0x9ce6), PORT_LPT1 },
 	{ }
-- 
2.30.0

