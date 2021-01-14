Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBC52F6359
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 15:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbhANOmL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Jan 2021 09:42:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:3055 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbhANOmL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 14 Jan 2021 09:42:11 -0500
IronPort-SDR: WygPCGccs/RoZWL5AtHSA8/J9J0OMPTEYqnrk/yuEi3/uxQKw/aIGEIdZhpXkNCjzb3coyocPZ
 MmWZyRbaSZnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="177595516"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="177595516"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 06:40:25 -0800
IronPort-SDR: zlYt+5gxQ3Od7yN315COt5y6zMLubOMJBsGPKh4vzKFyaXRUcUPLXDlNy13y1ZdtlwJwFTERx/
 jcNM46gbXgpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="499613342"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.56])
  by orsmga004.jf.intel.com with ESMTP; 14 Jan 2021 06:40:23 -0800
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Alder Lake PCH-P
Date:   Thu, 14 Jan 2021 16:40:21 +0200
Message-Id: <20210114144021.1820262-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for LPSS SPI on Intel Alder Lake PCH-P variant.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 34f1d321f30a..2632aae3f744 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1496,6 +1496,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x43ab), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x43fb), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x43fd), LPSS_CNL_SSP },
+	/* ADL-P */
+	{ PCI_VDEVICE(INTEL, 0x51aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x51ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x51fb), LPSS_CNL_SSP },
 	/* APL */
 	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
-- 
2.29.2

