Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA56108E39
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2019 13:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfKYMwF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Nov 2019 07:52:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:30029 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbfKYMwF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 25 Nov 2019 07:52:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 04:52:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,241,1571727600"; 
   d="scan'208";a="211015119"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.63])
  by orsmga003.jf.intel.com with ESMTP; 25 Nov 2019 04:52:03 -0800
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Jasper Lake
Date:   Mon, 25 Nov 2019 14:51:59 +0200
Message-Id: <20191125125159.15404-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

LPSS SPI on Intel Jasper Lake is compatible with Intel Ice Lake which
follows Intel Cannon Lake. Add PCI IDs of Jasper Lake.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 16b6b2ad4e7c..9071333ebdd8 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1443,6 +1443,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x4b2a), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x4b2b), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x4b37), LPSS_BXT_SSP },
+	/* JSL */
+	{ PCI_VDEVICE(INTEL, 0x4daa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x4dab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x4dfb), LPSS_CNL_SSP },
 	/* APL */
 	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
-- 
2.24.0

