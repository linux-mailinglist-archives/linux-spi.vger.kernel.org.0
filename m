Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDEA3CF75F
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jul 2021 12:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbhGTJX1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Jul 2021 05:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbhGTJWf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Jul 2021 05:22:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8834C0613DE;
        Tue, 20 Jul 2021 03:01:30 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 70so18636172pgh.2;
        Tue, 20 Jul 2021 03:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7JqjKw4ZgeUqcixNCroP1lhIkrtsuMs/VQXEPM5hRg=;
        b=DxxZ4ytQrUZq6pfA1s91pu+YVSJ39hxGEzwCu8ieEunT2j2D7GzlvzW8hJ26bF88tU
         WBk9Pke5xIabideKp4XQQvgj7sIZwCOegsD1M4YWT5Md/G44QIq4XvoUyCMBRpQAs3zf
         XKqODqfk0COx+NivVfLyYnqD3nxi2WpCiqQTDA/I+znq5GNVfb3bDtEFTagFaS+n6pgm
         X7+nymqJ1CCyc/O3rSuG9b4cF7AJw+qYs1VOuq8ekBfeGuctFc7WIU740Cha27HOEKf9
         kMGAXHu1XA0ciHlPpGfLKWTshrGFp3Zt2js/9KLNAy3KFP0OUl2W8cXjPGUAFZGY0g4t
         vkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7JqjKw4ZgeUqcixNCroP1lhIkrtsuMs/VQXEPM5hRg=;
        b=p3Sbi+8U/uRpVZkkTg2VOBF0kfWzZdY+onwy8WUm750x+Y5jFdgTqscd76/BMy26e1
         8NUZueg6xEEJPhb2acuPaV8vNB8h+/UXGZS2JXaPucVX2H0q2yDjdshpixHegR/JgOPa
         oEGZTewolsHc75ogupLItP5brJO/HbUC0isilB57iSSc4hgBFhKNTOvaJaT5d8HsXEPM
         C5wu8Z9d1aaU1oCnBRdDDKsHg5KGDrxxxKu6MLGS4gIgNwfHFEmmdb7cqVLw3GNvvCgH
         VS8juCYweAHAIpZxDhPtdlgnoQtQsz13VGdlVdr/KeUne+/mMAoivhiW8+zNoHL10nuI
         YhmA==
X-Gm-Message-State: AOAM5339IGfnKnpFZ66SqTt8F6KKl11PZdEID2IpHb2LEiFpx02bzpv3
        VaUuysmuU7J6uiSKUAu5hno=
X-Google-Smtp-Source: ABdhPJz0HRN2ARW3HNVlTQ/wea9NHB4NFkITtFecEKWrKWkwa/yPrJiCNeBNjbzYYRhz7+YHU+QzEw==
X-Received: by 2002:a63:514c:: with SMTP id r12mr30438063pgl.70.1626775290352;
        Tue, 20 Jul 2021 03:01:30 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.191])
        by smtp.gmail.com with ESMTPSA id y9sm2073966pgr.10.2021.07.20.03.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:01:29 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: meson-spicc: fix memory leak in meson_spicc_remove
Date:   Tue, 20 Jul 2021 18:01:16 +0800
Message-Id: <20210720100116.1438974-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In meson_spicc_probe, the error handling code needs to clean up master
by calling spi_master_put, but the remove function does not have this
function call. This will lead to memory leak of spicc->master.

Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
Fixes: 454fa271bc4e("spi: Add Meson SPICC driver")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/spi/spi-meson-spicc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index b2c4621db34d..c208efeadd18 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -785,6 +785,8 @@ static int meson_spicc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(spicc->core);
 	clk_disable_unprepare(spicc->pclk);
 
+	spi_master_put(spicc->master);
+
 	return 0;
 }
 
-- 
2.25.1

