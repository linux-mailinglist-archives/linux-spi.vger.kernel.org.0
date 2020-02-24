Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5160316AA64
	for <lists+linux-spi@lfdr.de>; Mon, 24 Feb 2020 16:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgBXPqD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Feb 2020 10:46:03 -0500
Received: from mga18.intel.com ([134.134.136.126]:53061 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727803AbgBXPqD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 Feb 2020 10:46:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 07:45:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="409911176"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 24 Feb 2020 07:45:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 156EEFE; Mon, 24 Feb 2020 17:45:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] spi: pxa2xx: Return error codes from pxa2xx_spi_init_pdata()
Date:   Mon, 24 Feb 2020 17:45:55 +0200
Message-Id: <20200224154556.11627-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

For better understanding what's going on on error path,
return distinguished error codes instead of NULL pointer.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b0d36dd583f5..e33ef1169491 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1553,18 +1553,18 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	else if (pcidev_id)
 		type = (enum pxa_ssp_type)pcidev_id->driver_data;
 	else
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	ssp = &pdata->ssp;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ssp->mmio_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(ssp->mmio_base))
-		return NULL;
+		return ERR_CAST(ssp->mmio_base);
 
 	ssp->phys_base = res->start;
 
@@ -1578,11 +1578,11 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk))
-		return NULL;
+		return ERR_CAST(ssp->clk);
 
 	ssp->irq = platform_get_irq(pdev, 0);
 	if (ssp->irq < 0)
-		return NULL;
+		return ERR_PTR(ssp->irq);
 
 	ssp->type = type;
 	ssp->dev = &pdev->dev;
@@ -1639,9 +1639,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	platform_info = dev_get_platdata(dev);
 	if (!platform_info) {
 		platform_info = pxa2xx_spi_init_pdata(pdev);
-		if (!platform_info) {
+		if (IS_ERR(platform_info)) {
 			dev_err(&pdev->dev, "missing platform data\n");
-			return -ENODEV;
+			return PTR_ERR(platform_info);
 		}
 	}
 
-- 
2.25.0

