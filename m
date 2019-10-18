Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AB8DC318
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 12:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407716AbfJRKye (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 06:54:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:16096 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407703AbfJRKye (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 18 Oct 2019 06:54:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 03:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,311,1566889200"; 
   d="scan'208";a="371431249"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 18 Oct 2019 03:54:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E00BC27E; Fri, 18 Oct 2019 13:54:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] spi: pxa2xx: Convert pxa2xx_spi_get_port_id() to take struct device
Date:   Fri, 18 Oct 2019 13:54:27 +0300
Message-Id: <20191018105429.82782-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018105429.82782-1-andriy.shevchenko@linux.intel.com>
References: <20191018105429.82782-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is preparatory patch before converting to use device_get_match_data() API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 670734b3d56a..04ca80770e35 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1476,11 +1476,13 @@ MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
 
 #ifdef CONFIG_ACPI
 
-static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
+static int pxa2xx_spi_get_port_id(struct device *dev)
 {
+	struct acpi_device *adev;
 	unsigned int devid;
 	int port_id = -1;
 
+	adev = ACPI_COMPANION(dev);
 	if (adev && adev->pnp.unique_id &&
 	    !kstrtouint(adev->pnp.unique_id, 0, &devid))
 		port_id = devid;
@@ -1489,7 +1491,7 @@ static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
 
 #else /* !CONFIG_ACPI */
 
-static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
+static int pxa2xx_spi_get_port_id(struct device *dev)
 {
 	return -1;
 }
@@ -1568,7 +1570,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	ssp->irq = platform_get_irq(pdev, 0);
 	ssp->type = type;
 	ssp->dev = &pdev->dev;
-	ssp->port_id = pxa2xx_spi_get_port_id(adev);
+	ssp->port_id = pxa2xx_spi_get_port_id(&pdev->dev);
 
 	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
 	pdata->num_chipselect = 1;
-- 
2.23.0

