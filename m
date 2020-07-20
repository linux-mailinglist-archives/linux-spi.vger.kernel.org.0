Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8B82269C0
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jul 2020 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgGTQ3V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jul 2020 12:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732192AbgGTP7T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Jul 2020 11:59:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804EEC061794;
        Mon, 20 Jul 2020 08:59:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so27412pjt.0;
        Mon, 20 Jul 2020 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWWiPDDkLSZWJniasWbkxAHeh1UEHqV+0VQVWXHKxgs=;
        b=Qo6EmHJ6FLUfuIlTjBgcG21BsVpmr0VH7Yb9ut6xUm5kKcC7tNm1SRbu1hUp2is0oE
         K59szg3P18X3twG5h+fit41FGJiiWGW3Rde8SzsMeKAMAKtvniR4JSaUWZJLEcXHoyny
         qh4ictM9zpYPRp038Wc2f3nxc1L+bCMf7h4p3Ze2esZ0W3Uok+6FtRf4S/y4Tgb6Lp4Z
         62mmy+MRGeU4GC86mlAlzST/Mce2MWY2PYfR/52gqXpgs0vn+Uc4DzgydPuSYJ5OoxIk
         mzDIe/EQ9IWaoQXXeJQolHf5vta+KCvwGVtUKjfcOneFuvsWKlci35yLWAC5P0D2wN5u
         pXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kWWiPDDkLSZWJniasWbkxAHeh1UEHqV+0VQVWXHKxgs=;
        b=DSZAc0k0HZz6IOnwtsJb9Zdiadpa3g8pC3QSyJD4HS1CFgLhcBr5AMtYSVB5IpwOMW
         Knk4UcbpIq/zIio/5fbUgIaXFuQwD94MBQ38bORmXr+DJJa0y0dr/l/U70OaF0KXEels
         eF4v4+Um0pBVY3kTN2tax7i4ra32SvKT9OysL88CqXFdsRtgPckVthp2gUNfRa1K/Jy/
         thjMFBZ/JfoAsPEF0vRzy9/8xZqe+ARt3Gh6u1AC4wHSSJPm2yZrnAniChmio2XmM1Eh
         Sz/e7FyXARxQ7zvQv3aZ+AdTWTRAqsBdRYPr2f20/T34dfJndI+MnwoMH2l06MPuKBKA
         ZlNw==
X-Gm-Message-State: AOAM531JdKRRQjMMsQRhxQEy0NelMYnpUpI+5Rn1azhxBAOc8PjW4K4K
        USyAv5A/0yEV/ZztKQiMkbCVkRFkoyvuoQ==
X-Google-Smtp-Source: ABdhPJz3fHLBx5cpEHrrDHL4MX3LASDS4caNtL6Cv+gi9ULwVLHjXytlSxHbCIeKpNkAi0+toz0k+A==
X-Received: by 2002:a17:90b:234f:: with SMTP id ms15mr55698pjb.7.1595260758978;
        Mon, 20 Jul 2020 08:59:18 -0700 (PDT)
Received: from varodek.localdomain ([110.225.71.189])
        by smtp.gmail.com with ESMTPSA id s6sm17368157pfd.20.2020.07.20.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 08:59:18 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v1] spi: spi-topcliff-pch: use generic power management
Date:   Mon, 20 Jul 2020 21:27:15 +0530
Message-Id: <20200720155714.714114-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Drivers using legacy PM have to manage PCI states and device's PM states
themselves. They also need to take care of configuration registers.

With improved and powerful support of generic PM, PCI Core takes care of
above mentioned, device-independent, jobs.

This driver makes use of PCI helper functions like
pci_save/restore_state(), pci_enable/disable_device(), pci_enable_wake()
and pci_set_power_state() to do required operations. In generic mode, they
are no longer needed.

Change function parameter in both .suspend() and .resume() to
"struct device*" type. Use dev_get_drvdata() to get drv data.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/spi/spi-topcliff-pch.c | 51 +++++++++-------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index d7ea6af74743..281a90f1b5d8 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1631,64 +1631,39 @@ static void pch_spi_remove(struct pci_dev *pdev)
 	kfree(pd_dev_save);
 }
 
-#ifdef CONFIG_PM
-static int pch_spi_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused pch_spi_suspend(struct device *dev)
 {
-	int retval;
-	struct pch_pd_dev_save *pd_dev_save = pci_get_drvdata(pdev);
+	struct pch_pd_dev_save *pd_dev_save = dev_get_drvdata(dev);
 
-	dev_dbg(&pdev->dev, "%s ENTRY\n", __func__);
+	dev_dbg(dev, "%s ENTRY\n", __func__);
 
 	pd_dev_save->board_dat->suspend_sts = true;
 
-	/* save config space */
-	retval = pci_save_state(pdev);
-	if (retval == 0) {
-		pci_enable_wake(pdev, PCI_D3hot, 0);
-		pci_disable_device(pdev);
-		pci_set_power_state(pdev, PCI_D3hot);
-	} else {
-		dev_err(&pdev->dev, "%s pci_save_state failed\n", __func__);
-	}
-
-	return retval;
+	return 0;
 }
 
-static int pch_spi_resume(struct pci_dev *pdev)
+static int __maybe_unused pch_spi_resume(struct device *dev)
 {
-	int retval;
-	struct pch_pd_dev_save *pd_dev_save = pci_get_drvdata(pdev);
-	dev_dbg(&pdev->dev, "%s ENTRY\n", __func__);
+	struct pch_pd_dev_save *pd_dev_save = dev_get_drvdata(dev);
 
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
+	dev_dbg(dev, "%s ENTRY\n", __func__);
 
-	retval = pci_enable_device(pdev);
-	if (retval < 0) {
-		dev_err(&pdev->dev,
-			"%s pci_enable_device failed\n", __func__);
-	} else {
-		pci_enable_wake(pdev, PCI_D3hot, 0);
+	device_wakeup_disable(dev);
 
-		/* set suspend status to false */
-		pd_dev_save->board_dat->suspend_sts = false;
-	}
+	/* set suspend status to false */
+	pd_dev_save->board_dat->suspend_sts = false;
 
-	return retval;
+	return 0;
 }
-#else
-#define pch_spi_suspend NULL
-#define pch_spi_resume NULL
 
-#endif
+static SIMPLE_DEV_PM_OPS(pch_spi_pm_ops, pch_spi_suspend, pch_spi_resume);
 
 static struct pci_driver pch_spi_pcidev_driver = {
 	.name = "pch_spi",
 	.id_table = pch_spi_pcidev_id,
 	.probe = pch_spi_probe,
 	.remove = pch_spi_remove,
-	.suspend = pch_spi_suspend,
-	.resume = pch_spi_resume,
+	.driver.pm = &pch_spi_pm_ops,
 };
 
 static int __init pch_spi_init(void)
-- 
2.27.0

