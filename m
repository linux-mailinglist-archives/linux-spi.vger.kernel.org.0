Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ECA31B98E
	for <lists+linux-spi@lfdr.de>; Mon, 15 Feb 2021 13:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhBOMpY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Feb 2021 07:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhBOMpO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Feb 2021 07:45:14 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C8BC061756;
        Mon, 15 Feb 2021 04:44:33 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id w18so4107768pfu.9;
        Mon, 15 Feb 2021 04:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uk9s83oW4a4qGGgdDjO8U/U1hFyvdhXypf5NhOymDvk=;
        b=ZuJo9xvMhGyU4Ag/XfsHZtRvKbDYv6ADJJDacPtP3bt5sGuofjOeejrNvHEeg+YDzb
         E9ez8Qq6Kef7TDEc8Xlj537Ct0rYrWOcu3Wv6oevMJg1im7bNk47HbgU+/GTDS2p7TJI
         yZL6EiMZ1Iepzyg0dEJEwMajX+8tWjSAObxI0Fxq8fotygO3f8UIexfOtagnkOmnepJS
         YgBBbhh+coKjwiAI4B4ZzaI3uEdqdWpITKSJmmtGgwg/wBEdATwD0HggyVoYuqnpGYa0
         V2m51fMN+8dWyC0O9hUOfMeGlIkNBTCeQJiVITndIHJQVQhPp2HQGT7gfgDT/2m0s+9x
         46bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uk9s83oW4a4qGGgdDjO8U/U1hFyvdhXypf5NhOymDvk=;
        b=jAp83LMdxMPrY6370jG/2sgjHzu6egjLDAwG7/la3RSC69ENGJJOi87aLa9GshI3In
         W2BmmZWsBaKx74q8P6r0LgiaEQXbUun9hqGj2+n93dVnA8UhFLpnwQ6AT7kvZj6vh2sI
         z54G270PjxwAS5Fcy8e05OJ424HSWJQR8hZmeskb2sBDboA5o0xpewm96dukVwNR2c1O
         VlRZgbhmRLXGXJLR17YlL5I0C+arVut8ETaoCdUo1VdH0UMeIw09zis7AklX0wDu/WGw
         /ltBkO4PSY1Jvb/SokGUaOTQnpGkU2pkR/hcP13khmasO/AvAa3qit2l/x1Z5NFyumig
         YCBQ==
X-Gm-Message-State: AOAM5304kVD9QGZoPAjAlIqy6vlJjPnSO0mootiVJSaus8jJTfUI3TkP
        F/loOqoiF1AsvLkaCxY7jgs=
X-Google-Smtp-Source: ABdhPJzRpQxB1vVwTb11hOjbhADz9CxFF6T7F9CiyheBY/BGnPehO+Q8hFj2WjgaRZWKtx/4aA9lkw==
X-Received: by 2002:a63:1c08:: with SMTP id c8mr14670453pgc.228.1613393073487;
        Mon, 15 Feb 2021 04:44:33 -0800 (PST)
Received: from localhost (89.208.244.53.16clouds.com. [89.208.244.53])
        by smtp.gmail.com with ESMTPSA id x24sm1685194pjk.7.2021.02.15.04.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 04:44:33 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, broonie@kernel.org, jan.kiszka@siemens.com,
        andriy.shevchenko@linux.intel.com, jarkko.nikula@linux.intel.com,
        linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2] spi: pxa2xx-pci: Fix an issue about missing call to 'pci_free_irq_vectors()'
Date:   Mon, 15 Feb 2021 20:44:29 +0800
Message-Id: <20210215124429.618582-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Call to 'pci_free_irq_vectors()' are missing both in the error handling
path of the probe function, and in the remove function. So add them.

Fixes: 64e02cb0bdfc7c ("spi: pca2xx-pci: Allow MSI")
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/spi/spi-pxa2xx-pci.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 14fc41ed2361..1ec840e78ff4 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -254,8 +254,10 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	snprintf(buf, sizeof(buf), "pxa2xx-spi.%d", ssp->port_id);
 	ssp->clk = clk_register_fixed_rate(&dev->dev, buf , NULL, 0,
 					   c->max_clk_rate);
-	 if (IS_ERR(ssp->clk))
-		return PTR_ERR(ssp->clk);
+	if (IS_ERR(ssp->clk)) {
+		ret = PTR_ERR(ssp->clk);
+		goto err_irq;
+	}
 
 	memset(&pi, 0, sizeof(pi));
 	pi.fwnode = dev->dev.fwnode;
@@ -268,12 +270,16 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	pdev = platform_device_register_full(&pi);
 	if (IS_ERR(pdev)) {
 		clk_unregister(ssp->clk);
-		return PTR_ERR(pdev);
+		ret = PTR_ERR(pdev);
+		goto err_irq;
 	}
 
 	pci_set_drvdata(dev, pdev);
 
 	return 0;
+err_irq:
+	pci_free_irq_vectors(dev);
+	return ret;
 }
 
 static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
@@ -283,6 +289,7 @@ static void pxa2xx_spi_pci_remove(struct pci_dev *dev)
 
 	spi_pdata = dev_get_platdata(&pdev->dev);
 
+	pci_free_irq_vectors(dev);
 	platform_device_unregister(pdev);
 	clk_unregister(spi_pdata->ssp.clk);
 }
-- 
2.25.0

