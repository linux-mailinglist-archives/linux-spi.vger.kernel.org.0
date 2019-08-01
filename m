Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 602297DCCB
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 15:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfHANtI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 09:49:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:44322 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfHANtI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Aug 2019 09:49:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 06:49:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,334,1559545200"; 
   d="scan'208";a="174633693"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.159])
  by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2019 06:49:06 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Tiger Lake
Date:   Thu,  1 Aug 2019 16:49:01 +0300
Message-Id: <20190801134901.12635-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Intel Tiger Lake -LP LPSS SPI controller is otherwise similar than
Cannon Lake but has more controllers and up to two chip selects per
controller.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 22513caf2000..bb6a14d1ab0f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1457,6 +1457,14 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x02aa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x02ab), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x02fb), LPSS_CNL_SSP },
+	/* TGL-LP */
+	{ PCI_VDEVICE(INTEL, 0xa0aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0de), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0df), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0fb), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0fd), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0fe), LPSS_CNL_SSP },
 	{ },
 };
 
-- 
2.20.1

