Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C403A56AE
	for <lists+linux-spi@lfdr.de>; Sun, 13 Jun 2021 07:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFMFbo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 13 Jun 2021 01:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFMFbn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 13 Jun 2021 01:31:43 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8B4C061574;
        Sat, 12 Jun 2021 22:29:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t9so5981153pgn.4;
        Sat, 12 Jun 2021 22:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6AdJa+7WrAfZXyHfw2qNyNJLE7yY0Qr/CD/Tk8b4dL4=;
        b=aja0+fMUKycQTU0t/8Wj2w4U4OqO3dy13LeMaGgx+O5RrfQri1eEWXHsQIsQbOQhKx
         osu/Czw415aFn1JzF218SG//xcAaa+LgL2Nyg3QGG0oCyZcZW4Ver/F8cYlYdaMJ6U8r
         zBWt4sX3CwnfozqTEiQhIguXf66D9iWlsI/Klu6CnS9zmdON18V/abhfUT5eciBNJDfI
         mL8vpOHRd2ic595qzIp/v52wRHbqV43dvRxuVh0PEBWJ/qC+QnEgQZpZfT+qNxUbmPog
         g8e7+7ZqzQwgIQGZsj+p8lkof4qamrv+aFcdQOf4iRJRAkzaxNiWNZ+Y41eO/TUif9wi
         4rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6AdJa+7WrAfZXyHfw2qNyNJLE7yY0Qr/CD/Tk8b4dL4=;
        b=PHdTUTrJwg8EM+32/ERQARry6kQkgyWGfJ5j080zK8UVw7pNiRH+sXSwPbFJI0L8jC
         uJrCdp1v75gLagWjQhDogozg+vkzJ3xhqsS+ZCgmlE5CXWthTjyT44rxwvFG8qctKthv
         mR2CFp6VmNME9GU1tQB+t2YL90AtKhqiW80pCkYNfGKfwAkyv7FJxHjBYh8YhqE0TLz0
         s/h6WZFfgLC+dHTOsTGeDUHurS8HPDJhgJa4fj6yURWf4e1qBQtUYWVBlqih13GLdPVw
         ehP/75xjKpWWizjUXY9c2d9v5LMEE+1O3ASr7Cb2sZDrgRSXDlmiYb/Il/M188O30ATD
         CU1g==
X-Gm-Message-State: AOAM532Bsrnl2UuWpR/5UU0CkYh3sZqpIr389fXyU8mZZaN1/dFO2A+4
        xX/tPB9yJxccUgZwuYgurCU=
X-Google-Smtp-Source: ABdhPJzFeeQ2tdgUq7C9JKQ526BuE+bqLJ3Wdnj7gEMC6ZOwuUu/Mnc9icDaR2Ze5gpYzv82O8t1bw==
X-Received: by 2002:aa7:808b:0:b029:2ef:cdd4:8297 with SMTP id v11-20020aa7808b0000b02902efcdd48297mr16032881pff.27.1623562162497;
        Sat, 12 Jun 2021 22:29:22 -0700 (PDT)
Received: from localhost.members.linode.com ([2400:8902::f03c:92ff:fe55:8c1e])
        by smtp.gmail.com with ESMTPSA id q68sm14397203pjq.45.2021.06.12.22.29.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jun 2021 22:29:22 -0700 (PDT)
From:   zpershuai <zpershuai@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     zpershuai <zpershuai@gmail.com>
Subject: [PATCH v2 1/2] spi: meson-spicc: fix memory leak in meson_spicc_probe
Date:   Sun, 13 Jun 2021 13:29:16 +0800
Message-Id: <1623562156-21995-1-git-send-email-zpershuai@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

when meson_spicc_clk_init returns failed, it should goto the
out_clk label.

Signed-off-by: zpershuai <zpershuai@gmail.com>
---
 drivers/spi/spi-meson-spicc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index ecba6b4..d675334 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -752,7 +752,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	ret = meson_spicc_clk_init(spicc);
 	if (ret) {
 		dev_err(&pdev->dev, "clock registration failed\n");
-		goto out_master;
+		goto out_clk;
 	}
 
 	ret = devm_spi_register_master(&pdev->dev, master);
-- 
2.7.4

