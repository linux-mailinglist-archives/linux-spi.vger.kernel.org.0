Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF920A072
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jun 2020 16:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405244AbgFYOBU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Jun 2020 10:01:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:42371 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405145AbgFYOBP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 25 Jun 2020 10:01:15 -0400
IronPort-SDR: 6u4LpMly9+xBQj8+XwgrCNyWLu2yumYx8OUmwkuvkK5Ix8rqqEB3f40DfLgb9fk2fUMZLhtAiG
 WXY5du407dew==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="143121416"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="143121416"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 07:01:14 -0700
IronPort-SDR: yut4vl0ndKznT2GPubHArtVEHVo0r0uRhsuizhN48xN2zGbDprx/aimTfTfOa6a8Rpu3mEOsP9
 xYqPdQTQLfdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="311105544"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.69])
  by orsmga008.jf.intel.com with ESMTP; 25 Jun 2020 07:01:11 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Tiger Lake PCH-H
Date:   Thu, 25 Jun 2020 17:00:41 +0300
Message-Id: <20200625140041.745804-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add Intel Tiger Lake PCH-H PCI IDs.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6721910e5f2a..0040362b7162 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1485,6 +1485,11 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x4daa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x4dab), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x4dfb), LPSS_CNL_SSP },
+	/* TGL-H */
+	{ PCI_VDEVICE(INTEL, 0x43aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x43ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x43fb), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x43fd), LPSS_CNL_SSP },
 	/* APL */
 	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
-- 
2.27.0

