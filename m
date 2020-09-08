Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F8260A82
	for <lists+linux-spi@lfdr.de>; Tue,  8 Sep 2020 08:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgIHGCq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Sep 2020 02:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbgIHGCp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Sep 2020 02:02:45 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD27C061755
        for <linux-spi@vger.kernel.org>; Mon,  7 Sep 2020 23:02:45 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so2113941pff.6
        for <linux-spi@vger.kernel.org>; Mon, 07 Sep 2020 23:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zNBvRrZjPxbBT7JprMip1sL4fZ/48zd8a70ne9wPaO8=;
        b=YobLdZBkZBrxmP5Y/Or5o5a0RApbkDOGe6tuhAhpFVgGoN355yiEHHInm9yFndi61f
         qqsm896vCbbg6IEHjXnoxMAw2YPTkBFXNLalU6yKh1cW/sSy6V69PFBENKyZLWQs6HkX
         PDw4oVQAiWJ2v7MGM8NZgBNHihkNEmRtLZM8j0LxuV/AKhiMsG2Atn2e3tvzuH3Y3aAR
         xUUzcXhBOMYFHF0Gg78AoJjosuquqNl+QIBZdDYPO4ef/93e1668iYWlt6qyEjHs6TpP
         l9BTs792GaB7nTmk7tHuqKB35G3uEVMGduslQGlK9uuY2RVDbzkoR61tw/cyeMz/tLSV
         bNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zNBvRrZjPxbBT7JprMip1sL4fZ/48zd8a70ne9wPaO8=;
        b=G0KG8onN1Lm0MAvvQhAaaQHctUHeoo2bj5laPG1298PgcVvlR66y/2tbsoWCerAUY+
         Bb2bIYsWmfygzUCcAutC4GstAYUduXtm/RjWwfVqVLNN5YAoSb/r46LQ8AeOg88nXHJ6
         zLoTZ22mLqGkGlZyAv0IIhCDFEXX+hzkjNnNpcamZnBkIBZGouHhfyKkJiBMkp7KD/aq
         AGnLzygbg1WHrJF73qYgTU4GOTlP6uP5wIRL+6M+46tVgpGuvmfqRkoGPYp5gE08CPca
         tK1IQ2qHUpkaEcvD4RjhC8bMxHtrgwxQOkZwxz2Ng3HqqQQpFu1WtJ6MlBhIMgI991bG
         IkFA==
X-Gm-Message-State: AOAM530/ze7EnwDVTNjiz76YivV2nJDZ/nWBK/eJ9xUe3xhnuQrCxxl3
        7SvjNbw4vN9072MuNiRzC6tWhA==
X-Google-Smtp-Source: ABdhPJystQja5K8KbUNhK+XcdevCmgEwRl2n4AZI7pZg4devWCJcQgGCdfAwN02nAXGcGGPD7r0t9w==
X-Received: by 2002:a62:5212:: with SMTP id g18mr23637060pfb.8.1599544964538;
        Mon, 07 Sep 2020 23:02:44 -0700 (PDT)
Received: from DESKTOP-C4AMQCQ.domain.name ([182.69.226.142])
        by smtp.gmail.com with ESMTPSA id u21sm14645454pjn.27.2020.09.07.23.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 23:02:43 -0700 (PDT)
From:   kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
To:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Varun Sethi <V.Sethi@nxp.com>, Arokia Samy <arokia.samy@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
Subject: [PATCH v1] spi: spi-nxp-fspi: Add ACPI support
Date:   Tue,  8 Sep 2020 11:32:27 +0530
Message-Id: <20200908060227.299-1-kuldip.dwivedi@puresoftware.com>
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
    1. Add ACPI match table
    2. Change the DT specific APIs to device property APIs
       so that same API can be used in DT and ACPi mode.
    3. Omit clock configuration part - in ACPI world, the firmware
       is responsible for clock maintenance.
    4. This patch is tested on LX2160A platform

 drivers/spi/spi-nxp-fspi.c | 66 +++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 1ccda82da206..acdb186ddfb2 100644
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
@@ -900,6 +910,8 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 		return ret;
 
 	/* Reset the module */
+	fspi_writel(f, FSPI_MCR0_SWRST, (base + FSPI_MCR0));
+
 	/* w1c register, wait unit clear */
 	ret = fspi_readl_poll_tout(f, f->iobase + FSPI_MCR0,
 				   FSPI_MCR0_SWRST, 0, POLL_TOUT, false);
@@ -1001,7 +1013,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	f = spi_controller_get_devdata(ctlr);
 	f->dev = dev;
-	f->devtype_data = of_device_get_match_data(dev);
+	f->devtype_data = device_get_match_data(dev);
 	if (!f->devtype_data) {
 		ret = -ENODEV;
 		goto err_put_ctrl;
@@ -1011,6 +1023,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the resources - configuration register address space */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_base");
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	f->iobase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(f->iobase)) {
 		ret = PTR_ERR(f->iobase);
@@ -1020,8 +1034,11 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	/* find the resources - controller memory mapped space */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fspi_mmap");
 	if (!res) {
-		ret = -ENODEV;
-		goto err_put_ctrl;
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res) {
+			ret = -ENODEV;
+			goto err_put_ctrl;
+		}
 	}
 
 	/* assign memory mapped starting address and mapped size. */
@@ -1029,22 +1046,24 @@ static int nxp_fspi_probe(struct platform_device *pdev)
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
@@ -1127,6 +1146,14 @@ static const struct of_device_id nxp_fspi_dt_ids[] = {
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
@@ -1136,6 +1163,7 @@ static struct platform_driver nxp_fspi_driver = {
 	.driver = {
 		.name	= "nxp-fspi",
 		.of_match_table = nxp_fspi_dt_ids,
+		.acpi_match_table = ACPI_PTR(nxp_fspi_acpi_ids),
 		.pm =   &nxp_fspi_pm_ops,
 	},
 	.probe          = nxp_fspi_probe,
-- 
2.17.1

