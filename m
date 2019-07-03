Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B9D5E310
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2019 13:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfGCLqJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jul 2019 07:46:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:6914 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfGCLqI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Jul 2019 07:46:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 04:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="169112350"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.195])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2019 04:46:06 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Elkhart Lake
Date:   Wed,  3 Jul 2019 14:46:03 +0300
Message-Id: <20190703114603.22301-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Intel Elkhart Lake has the same LPSS than Intel Broxton. Add support for
it.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 259c20f7a542..fc7ab4b26880 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1437,6 +1437,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x34aa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x34ab), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x34fb), LPSS_CNL_SSP },
+	/* EHL */
+	{ PCI_VDEVICE(INTEL, 0x4b2a), LPSS_BXT_SSP },
+	{ PCI_VDEVICE(INTEL, 0x4b2b), LPSS_BXT_SSP },
+	{ PCI_VDEVICE(INTEL, 0x4b37), LPSS_BXT_SSP },
 	/* APL */
 	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
-- 
2.20.1

