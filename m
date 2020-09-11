Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF15E266157
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 16:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgIKOjL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Sep 2020 10:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgIKNDt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Sep 2020 09:03:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580D2C061573
        for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2020 06:03:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v196so7420748pfc.1
        for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2020 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mDwzTS/fWq/EBduPCWZpBDX2IZJOQNxJ7z0ydAoEk7s=;
        b=T99Fk+snOAu5QL4u6yr2YBMRL+x5gCyG3pTUjXrT1RcICZx4gk3WX0r6g6axOsSDuZ
         qqlDs6Mz5hu401p4N0HktfoqnCr1FWssaQ+6qGSKAFb3Vpep/pvpyO4qPX6pNUjmXNgk
         tebmp0A6HyNhtTqLhoFV7sav+bfew1zzeWHGv+mJixCH6PHd455xYoH/X4UBfgl6Ncly
         Wie1iYiG4KIPkXdVOIZkcPW9vwn9IqOainm9i4XzG7MZh9vmPdqZmPuRH2myhyhrvJ/g
         f/g3Uqjur8Em4mM9trxzRj1tXx9tYpH4pUl+fsibKDEIyIy0ODWED/nj22L+uZiGVaYF
         DKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mDwzTS/fWq/EBduPCWZpBDX2IZJOQNxJ7z0ydAoEk7s=;
        b=hB4bZTgLBEXbNQzciix9RapocITPRl7Va1MENqAajesaraLj/QakJgoMc2Hfhpi/nJ
         j7rLYJVG8vnRoKekCYPXRQI5Oe/1jhAx8EQeV/x55kWmz8KA7i+zocD+jx1zoHNooDvd
         M3oAkLEQHRpqOuBhOKZWnaxRmsi96wydp+m+8p9Ok2qRiE27iu80GKj5uviyDshRe2yJ
         jTwaPCUIERr5i/P+dLgNI/DLLxnddnA5ZYkdq28+eP7sKgCnuo2IeFVCRdNl4FJo/eOj
         95g5PoBAP3KpYMUWlTUFK+/2DmvCC+D7weFPDOG/LxmCL/tywiP5bAYxej4ee9Fx8Iy8
         DPzQ==
X-Gm-Message-State: AOAM530yzDnav3UKqtkO8ZlpRwRCJeykuJEYdI8g2D3hcId5ZcSFVfhm
        ZxUiL2DeQ8/N0pVkDiD0lV4KHrRusdvZ9lC7
X-Google-Smtp-Source: ABdhPJzRwXHxInzgEsQl4caXjQLXqKJzdwNZFyGoa1VsnLuTinToe6hoz2k6bmdzCvXY75XyygTnfQ==
X-Received: by 2002:a63:d409:: with SMTP id a9mr1562715pgh.312.1599829427448;
        Fri, 11 Sep 2020 06:03:47 -0700 (PDT)
Received: from DESKTOP-C4AMQCQ.domain.name ([122.177.137.137])
        by smtp.gmail.com with ESMTPSA id m21sm2453135pfa.73.2020.09.11.06.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 06:03:46 -0700 (PDT)
From:   kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
To:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Varun Sethi <V.Sethi@nxp.com>, Arokia Samy <arokia.samy@nxp.com>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Subject: [PATCH v3] spi: spi-nxp-fspi: Add ACPI support
Date:   Fri, 11 Sep 2020 18:33:31 +0530
Message-Id: <20200911130331.6313-1-kuldip.dwivedi@puresoftware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently NXP fspi  driver has support of DT only. Adding ACPI
support to the driver so that it can be used by UEFI firmware
booting in ACPI mode. This driver will be probed if any firmware
will expose HID "NXP0009" in DSDT table.

Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
---

Notes:
    1. Add ACPI match table, NXP members are added to confirm HID for FSPI
    2. Change the DT specific APIs to device property APIs
       so that same API can be used in DT and ACPi mode.
    3. Add node specific checks to use indexed based lookup API in case of
       ACPI.
    	if (is_acpi_node(f->dev->fwnode))
    		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
    	else
    		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_base");
    4. Omit clock configuration part - in ACPI world, the firmware
       is responsible for clock maintenance.
    5. This patch is tested on LX2160A platform

 drivers/spi/spi-nxp-fspi.c | 69 +++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 1ccda82da206..0d41406c036d 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -3,7 +3,8 @@
 /*
  * NXP FlexSPI(FSPI) controller driver.
  *
- * Copyright 2019 NXP.
+ * Copyright 2019-2020 NXP
+ * Copyright 2020 Puresoftware Ltd.
  *
  * FlexSPI is a flexsible SPI host controller which supports two SPI
  * channels and up to 4 external devices. Each channel supports
@@ -30,6 +31,7 @@
  *     Frieder Schrempf <frieder.schrempf@kontron.de>
  */
 
+#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -563,6 +565,9 @@ static int nxp_fspi_clk_prep_enable(struct nxp_fspi *f)
 {
 	int ret;
 
+	if (is_acpi_node(f->dev->fwnode))
+		return 0;
+
 	ret = clk_prepare_enable(f->clk_en);
 	if (ret)
 		return ret;
@@ -576,10 +581,15 @@ static int nxp_fspi_clk_prep_enable(struct nxp_fspi *f)
 	return 0;
 }
 
-static void nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
+static int nxp_fspi_clk_disable_unprep(struct nxp_fspi *f)
 {
+	if (is_acpi_node(f->dev->fwnode))
+		return 0;
+
 	clk_disable_unprepare(f->clk);
 	clk_disable_unprepare(f->clk_en);
+
+	return 0;
 }
 
 /*
@@ -1001,7 +1011,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	f = spi_controller_get_devdata(ctlr);
 	f->dev = dev;
-	f->devtype_data = of_device_get_match_data(dev);
+	f->devtype_data = device_get_match_data(dev);
 	if (!f->devtype_data) {
 		ret = -ENODEV;
 		goto err_put_ctrl;
@@ -1010,7 +1020,12 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, f);
 
 	/* find the resources - configuration register address space */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_base");
+	if (is_acpi_node(f->dev->fwnode))
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	else
+		res = platform_get_resource_byname(pdev,
+				IORESOURCE_MEM, "fspi_base");
+
 	f->iobase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(f->iobase)) {
 		ret = PTR_ERR(f->iobase);
@@ -1018,7 +1033,12 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	}
 
 	/* find the resources - controller memory mapped space */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
+	if (is_acpi_node(f->dev->fwnode))
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	else
+		res = platform_get_resource_byname(pdev,
+				IORESOURCE_MEM, "fspi_mmap");
+
 	if (!res) {
 		ret = -ENODEV;
 		goto err_put_ctrl;
@@ -1029,22 +1049,24 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	f->memmap_phy_size = resource_size(res);
 
 	/* find the clocks */
-	f->clk_en = devm_clk_get(dev, "fspi_en");
-	if (IS_ERR(f->clk_en)) {
-		ret = PTR_ERR(f->clk_en);
-		goto err_put_ctrl;
-	}
+	if (dev_of_node(&pdev->dev)) {
+		f->clk_en = devm_clk_get(dev, "fspi_en");
+		if (IS_ERR(f->clk_en)) {
+			ret = PTR_ERR(f->clk_en);
+			goto err_put_ctrl;
+		}
 
-	f->clk = devm_clk_get(dev, "fspi");
-	if (IS_ERR(f->clk)) {
-		ret = PTR_ERR(f->clk);
-		goto err_put_ctrl;
-	}
+		f->clk = devm_clk_get(dev, "fspi");
+		if (IS_ERR(f->clk)) {
+			ret = PTR_ERR(f->clk);
+			goto err_put_ctrl;
+		}
 
-	ret = nxp_fspi_clk_prep_enable(f);
-	if (ret) {
-		dev_err(dev, "can not enable the clock\n");
-		goto err_put_ctrl;
+		ret = nxp_fspi_clk_prep_enable(f);
+		if (ret) {
+			dev_err(dev, "can not enable the clock\n");
+			goto err_put_ctrl;
+		}
 	}
 
 	/* find the irq */
@@ -1127,6 +1149,14 @@ static const struct of_device_id nxp_fspi_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id nxp_fspi_acpi_ids[] = {
+	{ "NXP0009", .driver_data = (kernel_ulong_t)&lx2160a_data, },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, nxp_fspi_acpi_ids);
+#endif
+
 static const struct dev_pm_ops nxp_fspi_pm_ops = {
 	.suspend	= nxp_fspi_suspend,
 	.resume		= nxp_fspi_resume,
@@ -1136,6 +1166,7 @@ static struct platform_driver nxp_fspi_driver = {
 	.driver = {
 		.name	= "nxp-fspi",
 		.of_match_table = nxp_fspi_dt_ids,
+		.acpi_match_table = ACPI_PTR(nxp_fspi_acpi_ids),
 		.pm =   &nxp_fspi_pm_ops,
 	},
 	.probe          = nxp_fspi_probe,
-- 
2.17.1

