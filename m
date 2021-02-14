Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECC231B0E0
	for <lists+linux-spi@lfdr.de>; Sun, 14 Feb 2021 15:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhBNO6b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 14 Feb 2021 09:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhBNO6b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 14 Feb 2021 09:58:31 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08F4C061574;
        Sun, 14 Feb 2021 06:57:50 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c11so2641969pfp.10;
        Sun, 14 Feb 2021 06:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxr0augrGGnXBr5RFPz+IZxdj07rchQDWCx0NiIDOAo=;
        b=uwqSqqUVSaBxZHmG9XqLYQn7h/3e09N7J4+cvFLcEAYpIcx+U+ukfKCRxakK59Ksvx
         eUgXXP/FUezyZU/hhbVoje6Pgcdk+1jdZQJv6kF9DFBsUC6W0iyEZI7IS8PUG9vmcdpp
         AKleRVKLHmIWzqsx/uz77iOG10Rhu+mWxRpcVNZuYyVuqd+K7T5hQcr+JTAZmrp74Hiv
         yk+33jYsgYlxawZmZrx13mP4IjtUDIi2z1cqe2RKzCdYNEUpVccL2xJN7zpo1sHf2hXp
         wnEQ0dK79Eqg3HJi/fzCVNVGnVNYcGU0VxsN6ptZl/FGF1K2wZ5oFeZG8C+raxCOuPYE
         HL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wxr0augrGGnXBr5RFPz+IZxdj07rchQDWCx0NiIDOAo=;
        b=gCIUOGomwBq3M0LA5zB0REXa0vhWD3e+FQqUQPDCzZ9yb0ahEJYUIkgzQ+JysFv+5N
         DaVY0CNjnqJ4JL8Lm/Sz502MB+hk/kuzye6Pznl5Z2kFV7hES+WhktcAn/lXiftN/YS5
         xrPHWs/MSLj60+dA87yb+2K2auSPl0HGgOnLldYYzc5cmqqkUx1CpKiai8EuUKIP2J0G
         rNdIyuNnf0qF//wyARcutHpeHhQBFBxN5zUEk5VSXv3RiL/0ce+ioWXdJWaZ3i+il8aY
         WO3ALq+/R2g0z2fmsE1KzESHiVBxMLqyzoWpHuI5/+SUpZkOZmXCmz6dr0b4b8m5WpaF
         xEpw==
X-Gm-Message-State: AOAM533Odw+QKoNgxt8T3Fgpl2K4uXobp5BsT3lQl7dfroydBLOIGljG
        ZsPrd9irdEG6bulImD99SAg=
X-Google-Smtp-Source: ABdhPJzK5lSrnPZ14UCJ3pTyneZHqRTn1A8LFjZO2wEjGlqMDewpPyBby7CNgjGoyVqGiKVsB5tN8A==
X-Received: by 2002:a62:14cb:0:b029:1d1:f512:f686 with SMTP id 194-20020a6214cb0000b02901d1f512f686mr11325574pfu.11.1613314670595;
        Sun, 14 Feb 2021 06:57:50 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id o1sm14764105pgq.1.2021.02.14.06.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 06:57:50 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, broonie@kernel.org,
        andriy.shevchenko@linux.intel.com, jan.kiszka@siemens.com,
        jarkko.nikula@linux.intel.com, linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH] spi: pca2xx-pci: Fix an issue about missing call to 'pci_free_irq_vectors()'
Date:   Sun, 14 Feb 2021 22:57:46 +0800
Message-Id: <20210214145746.602770-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Call to 'pci_free_irq_vectors()' are missing both in the error handling
path of the probe function, and in the remove function. So add them.

Fixes: 64e02cb0bdfc7c ("spi: pca2xx-pci: Allow MSI")
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

