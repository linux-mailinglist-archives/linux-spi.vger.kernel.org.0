Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCAF368BAC
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 05:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240257AbhDWDnd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 23:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhDWDnc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Apr 2021 23:43:32 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5A3C061574;
        Thu, 22 Apr 2021 20:42:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id s20so8744665plr.13;
        Thu, 22 Apr 2021 20:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fgzCopNHGoCj4O3S/7aTjWQg4EKw2Q7WuBQ98y/Dhzk=;
        b=asqmV/Ie4/YiUXsaMIXBsglbP+sd3m1BS0J6xISjim/mzxmroOGKGBIiFrzLiaC0/v
         RqPvY7oKTSwi1MD9lhkv9FDqHtbtXEV3iMonv315h8XBNuMau+FS9U0VPQiHmUkMUxWO
         6Y6sy8hFErBKzTR8auoIXJLbreupjKKHJcEKFMmzTCQcNKsozvXTAkZ2xELgoqNUkIX/
         DW4hBZ22PFqDzAk0Riu78fcotBOtZ0oH2HcpknhDaK4AJhyjEKeFI4XZ2WdUOAO9IPCv
         nwJXXmyl+ZhN76+Wya4WT7KroUuL6xu2YeIBliTsXLhRoMHl25j8TlQrJucrI2GkMgYA
         UG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fgzCopNHGoCj4O3S/7aTjWQg4EKw2Q7WuBQ98y/Dhzk=;
        b=bhFN+NF4Do/JKJNwMwtqBhCQ2fp87W/8DLUQWNv8LRC5OQHsPKrJCqj9z51IekAYp5
         HamhO/dcr4iQ7Vjx887de4l3C/B826QUZQ7iS+lc1VZh2ZBrzk/+UZLvzLGehkFVYCiy
         qWve5ExUwzlyLdVMQNBw0eR+mcimVl5p/9648jy9MWS2X3OsVwtpw5r++JCISOLt9aoD
         NU1bhYtuxCF6tP1qfD0a/llVm1doLgdG2nTOPL3IIwLyTW5XyEhTj4hiPN4zT2teXWhp
         ZO/XIS9Qv0dUq9bB17P3+Bm0C0dUsr96dQv5reGk1AAHaEVUNxhnByTXQIxVnMErZU3e
         XwRg==
X-Gm-Message-State: AOAM5302Xot4v0AT+WdeiUc1A/EhYJ6ZrML6yN3ZRRobqCbgQLp/nA+a
        XRb+UOKtsWVqxuVGuQo07zpxzwkFn19l6WGI
X-Google-Smtp-Source: ABdhPJwV3UCwfUsdE+Vjwv61FcGaA++89VvrXwdYocb2uJ71/siMK3uFbgucYqiVGf/PRk6pC1NIZQ==
X-Received: by 2002:a17:90a:150e:: with SMTP id l14mr3516106pja.208.1619149376869;
        Thu, 22 Apr 2021 20:42:56 -0700 (PDT)
Received: from localhost.localdomain (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id l22sm6002505pjc.13.2021.04.22.20.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 20:42:56 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com, art@khadas.com, nick@khadas.com,
        gouwa@khadas.com
Subject: [PATCH] SPI: meson-spifc add missed calls to remove function
Date:   Fri, 23 Apr 2021 11:42:47 +0800
Message-Id: <20210423034247.992052-1-art@khadas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Problem: rmmod meson_gx_mmc - not stable without spi_master_suspend call
and we can get stuck when try unload this module

rmmod meson_gx_mmc
...
[  421.108614] Deleting MTD partitions on "spi0.0":
[  424.219862] spi_master spi0: Failed to power device: -13
...
lsmod | grep spi
spi_meson_spifc        16384 -1

Solution: just add spi_master_suspend(master) call

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 drivers/spi/spi-meson-spifc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 8eca6f24c..8a97a6dbf 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -359,6 +359,7 @@ static int meson_spifc_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct meson_spifc *spifc = spi_master_get_devdata(master);
 
+	spi_master_suspend(master);
 	pm_runtime_get_sync(&pdev->dev);
 	clk_disable_unprepare(spifc->clk);
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.1

