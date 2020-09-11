Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C035D265B9B
	for <lists+linux-spi@lfdr.de>; Fri, 11 Sep 2020 10:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgIKI2c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Sep 2020 04:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgIKI20 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Sep 2020 04:28:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47018C061756
        for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2020 01:28:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 5so6131868pgl.4
        for <linux-spi@vger.kernel.org>; Fri, 11 Sep 2020 01:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=h57aIxbVHgfEhRKG56U/dqmlM2O+oHnwpIQoHtwS6co=;
        b=jTA2AwrOvEMFZXME9c3f6CT8RxwMboFumo0K/4BTKOiKIbsCpgNXqtnSvs8GJr7YEQ
         zO3iwX4Il7NoBa7jjaD3LPINkVleQ99tmkHk35DkP+4CCgGq/ML+rdn+SGS64I7wb8pZ
         K2WmdcfAD70T+oBeit+FPpQHdjQCmHAA9xeoOvHi0X7uIOE0fndk4cNTl8m58xoZXLdZ
         3z+fm3mdtsLW/YL63yAQ59WVf+0GyB8Y7fRqACACcdRYOUYM0dUD3Mket9sZAwD1d7F1
         HKapcp0jY08sQ7wlISMT6ENr4qnPrpmVUC4glGM54TiIpbQGWO/9xyPVzdjtfJF7AViU
         WB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h57aIxbVHgfEhRKG56U/dqmlM2O+oHnwpIQoHtwS6co=;
        b=cVdjcU5DQSn9haU7U8smozplJwardmP4eaz0hHQfK5fkYFL+1I6m+3PKKfoAU1Ya2N
         bEBMh7YIaY9Q0vJkxdA50cXDXzCWZwtCgjKdgi54QQ/QscsOJT2VJo6tddSuogoF/xW6
         pnWw8MU2rzlDaBtHzirWMCdZ0Nt46ePySqryQsbrGmTM7/z+uOIYLU5RwVz2B9Ly7rvW
         dhyoU+4BKvRof+RExKKBI5FZwGAjMKL5DNF1A3q9Mb9uJA1/LhSJfJlkQG9Ru873stG/
         jQMwkdcuJMEC8636jql4Hzybnw9DaDGiRyHajnEhr0kBVv+h7qHnxdRPSOme/lsmOLen
         bXLQ==
X-Gm-Message-State: AOAM530DMFX+SyMak+O5UwVnq88q1GjWxOJvZP6a0N0HqoJ+VGJ5xLSH
        7JebmNQCqoIB37OtlgdqxImHqQ==
X-Google-Smtp-Source: ABdhPJzU5TGFKGUiAC88FNr9JLSQg0WsfSY7pHIGJ05wwACQ9nDKHvgRkBZT+33LO6EkJPCYjAxMpw==
X-Received: by 2002:a17:902:ab92:: with SMTP id f18mr1010186plr.12.1599812904486;
        Fri, 11 Sep 2020 01:28:24 -0700 (PDT)
Received: from DESKTOP-C4AMQCQ.domain.name ([223.235.80.111])
        by smtp.gmail.com with ESMTPSA id l14sm1223646pjy.1.2020.09.11.01.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 01:28:23 -0700 (PDT)
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
Subject: [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
Date:   Fri, 11 Sep 2020 13:58:06 +0530
Message-Id: <20200911082806.115-1-kuldip.dwivedi@puresoftware.com>
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
    3. Omit clock configuration part - in ACPI world, the firmware
           is responsible for clock maintenance.
    4. This patch is tested on LX2160A platform

 drivers/spi/spi-nxp-fspi.c | 61 +++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 1ccda82da206..9e3991ec0dd2 100644
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
@@ -1011,6 +1021,9 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the resources - configuration register address space */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_base");
+#ifdef CONFIG_ACPI
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+#endif
 	f->iobase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(f->iobase)) {
 		ret = PTR_ERR(f->iobase);
@@ -1019,6 +1032,9 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the resources - controller memory mapped space */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
+#ifdef CONFIG_ACPI
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+#endif
 	if (!res) {
 		ret = -ENODEV;
 		goto err_put_ctrl;
@@ -1029,22 +1045,24 @@ static int nxp_fspi_probe(struct platform_device *pdev)
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
@@ -1127,6 +1145,14 @@ static const struct of_device_id nxp_fspi_dt_ids[] = {
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
@@ -1136,6 +1162,7 @@ static struct platform_driver nxp_fspi_driver = {
 	.driver = {
 		.name	= "nxp-fspi",
 		.of_match_table = nxp_fspi_dt_ids,
+		.acpi_match_table = ACPI_PTR(nxp_fspi_acpi_ids),
 		.pm =   &nxp_fspi_pm_ops,
 	},
 	.probe          = nxp_fspi_probe,
-- 
2.17.1

