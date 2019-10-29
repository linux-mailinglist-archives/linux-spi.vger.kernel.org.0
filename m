Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCD5E879C
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2019 12:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfJ2L6Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Oct 2019 07:58:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:29948 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJ2L6Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Oct 2019 07:58:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 04:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="scan'208";a="374524444"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.164])
  by orsmga005.jf.intel.com with ESMTP; 29 Oct 2019 04:58:08 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Comet Lake-H
Date:   Tue, 29 Oct 2019 13:58:02 +0200
Message-Id: <20191029115802.6779-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add Intel Comet Lake-H LPSS SPI PCI IDs.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3a440ab9a841..4db43ba826b8 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1459,6 +1459,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x02aa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x02ab), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x02fb), LPSS_CNL_SSP },
+	/* CML-H */
+	{ PCI_VDEVICE(INTEL, 0x06aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x06ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x06fb), LPSS_CNL_SSP },
 	/* TGL-LP */
 	{ PCI_VDEVICE(INTEL, 0xa0aa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa0ab), LPSS_CNL_SSP },
-- 
2.23.0

