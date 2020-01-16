Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D22D13D670
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2020 10:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgAPJKk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jan 2020 04:10:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:24451 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729139AbgAPJKk (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jan 2020 04:10:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 01:10:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,325,1574150400"; 
   d="scan'208";a="273918840"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.168])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2020 01:10:38 -0800
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Comet Lake PCH-V
Date:   Thu, 16 Jan 2020 11:10:35 +0200
Message-Id: <20200116091035.575175-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for Intel Comet Lake PCH-V which has the same LPSS than on
Intel Kaby lake unlike other Intel Comet Lake PCH variants that are based
on Intel Cannon Lake PCH LPSS.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 9071333ebdd8..7289fb3302d5 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1423,6 +1423,9 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	/* KBL-H */
 	{ PCI_VDEVICE(INTEL, 0xa2a9), LPSS_SPT_SSP },
 	{ PCI_VDEVICE(INTEL, 0xa2aa), LPSS_SPT_SSP },
+	/* CML-V */
+	{ PCI_VDEVICE(INTEL, 0xa3a9), LPSS_SPT_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa3aa), LPSS_SPT_SSP },
 	/* BXT A-Step */
 	{ PCI_VDEVICE(INTEL, 0x0ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x0ac4), LPSS_BXT_SSP },
-- 
2.24.1

