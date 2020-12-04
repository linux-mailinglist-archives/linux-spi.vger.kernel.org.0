Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5072CE983
	for <lists+linux-spi@lfdr.de>; Fri,  4 Dec 2020 09:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgLDIZ7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Dec 2020 03:25:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:52020 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbgLDIZ7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 4 Dec 2020 03:25:59 -0500
IronPort-SDR: /0vloMD60+sdxn5fWhVeGRrRtn/x36jwnCZKfkLSqLAZb05uuGKe8L9W33h934/4SI/j6xHO0d
 kTO/zb9QHcAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="237462400"
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="237462400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 00:24:14 -0800
IronPort-SDR: i4oetIINs0it0kXWhhTQLovqG5yrM3NZ3b922WQ72jnYmMkaHxkzz+pIwy90omBi1Q4rAVaehe
 GeE06AgTwFrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="540609875"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.52])
  by fmsmga005.fm.intel.com with ESMTP; 04 Dec 2020 00:24:11 -0800
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Alder Lake PCH-S
Date:   Fri,  4 Dec 2020 10:24:09 +0200
Message-Id: <20201204082409.183700-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for LPSS SPI on Intel Alder Lake. It has four LPSS SPI
controllers each having two chip selects.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 814268405ab0..62a0f0f86553 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1496,6 +1496,11 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac6), LPSS_BXT_SSP },
+	/* ADL-S */
+	{ PCI_VDEVICE(INTEL, 0x7aaa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x7aab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x7af9), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x7afb), LPSS_CNL_SSP },
 	/* CNL-LP */
 	{ PCI_VDEVICE(INTEL, 0x9daa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x9dab), LPSS_CNL_SSP },
-- 
2.29.2

