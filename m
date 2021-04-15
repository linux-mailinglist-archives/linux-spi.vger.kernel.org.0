Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D229360B35
	for <lists+linux-spi@lfdr.de>; Thu, 15 Apr 2021 15:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbhDON7u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 09:59:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:32220 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDON7u (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 09:59:50 -0400
IronPort-SDR: 3AtB78e5g45bKyQz+KuFYVkrEvObTsbanfVcLNk4/MRTLnRHh5/jYxqcdgAej1lfKFUMecglH0
 wzO/pNrN+gIA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="181979213"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="181979213"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 06:59:23 -0700
IronPort-SDR: xBrRbeTaLrMe4/UF31UA2LQcmywTwl8Rv1jBU5FgM+h8/jBkhA1+S9SIgP1Q40wa4O3FeZQhDx
 9qGSS7YlS57A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="399576657"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.84])
  by orsmga002.jf.intel.com with ESMTP; 15 Apr 2021 06:59:21 -0700
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] spi: pxa2xx: Add support for Intel Alder Lake PCH-M
Date:   Thu, 15 Apr 2021 16:59:17 +0300
Message-Id: <20210415135917.54144-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for LPSS SPI on Intel Alder Lake PCH-M.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 2632aae3f744..bed16bc78047 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1500,6 +1500,10 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x51aa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x51ab), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x51fb), LPSS_CNL_SSP },
+	/* ADL-M */
+	{ PCI_VDEVICE(INTEL, 0x54aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x54ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0x54fb), LPSS_CNL_SSP },
 	/* APL */
 	{ PCI_VDEVICE(INTEL, 0x5ac2), LPSS_BXT_SSP },
 	{ PCI_VDEVICE(INTEL, 0x5ac4), LPSS_BXT_SSP },
-- 
2.30.2

