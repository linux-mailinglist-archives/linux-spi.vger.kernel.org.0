Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D963A1711
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237878AbhFIOYy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 10:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbhFIOYp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Jun 2021 10:24:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF17C06175F;
        Wed,  9 Jun 2021 07:22:36 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id h12so15661350pfe.2;
        Wed, 09 Jun 2021 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDoBgeXGas8ONL+4xxWqdRXTO15tMUsAgoTQmxOnpK0=;
        b=C0YmE5h9l9ASPpHuN75UQGqMrb/OkBhyKVSkSt9iH+5kg3uUX5e1Cw7X9VLWwEz4Tw
         usB7I6HJCFWW5ZjNXbaUbFnpEdx4MKnGeGmOCWp0C2w+FLqJaQ4xN/JZFvfGBeT/1XzL
         GWXXbwzkMJ6SrokwfkCGxR0XlvmXi2EX6h5d7IVJ2ZZZxmUHWl2tpY8cfHZomWhJNswm
         DiEILbXiDyOLl3xH6zJDsongoirPnn3mlPbL6UfqDJDal5BRwubys/xzQkkF5lSnZw2X
         XD9fDeLRaEAJdnRjkaX+8cGHl8wo4+BeqWO4wnVDaFP2v9sKHdh5td4WxWRwpz4BqM4T
         fk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDoBgeXGas8ONL+4xxWqdRXTO15tMUsAgoTQmxOnpK0=;
        b=CVgWkZFKNdniXcnJpvB5xX4XlHfmTvOmCoegTq2FRnwePuan8r1YedabHndAfrsvIu
         bB42hbCYriin6xsPWuSEdMfIjDVul1DSpcZZn5me9t13XgE0Jd3HmhuC0yhwfXFrEJks
         Shd5vMHSsh14cuU0dsB22KVKD+PfpvgV7zR1kLYRoEV9fEZd/0lBS4lZzPjYNxnjyRag
         pGRU4P1KBRdboL9hUHmD964P+Fv2FygQ4ZCARJWZOtKs8mDN67cqxB0EKoUAAdVjmw2r
         EFavKgNQ+17eeSkbI4N7tUjLlw66JLvpX4LwT22hQODkjO9yJwNIlP7fkYJt9KfKWeO8
         tpaw==
X-Gm-Message-State: AOAM5306tsKkGyLH5ihX8s5NhYu4UcHPRRhMks3pJyX9ZdDocfR0Y0X+
        yxot/JsLDjJPPHysQ4D2YCbt37z0Yo9dkCOCK6uk1Q==
X-Google-Smtp-Source: ABdhPJwNfGVfozXjFPOmgigW9OaAlLh16hECyaYSxbmVCUR8PMj+EhBdPpirjL3Ntb0QGiy9Tbu6UQ==
X-Received: by 2002:a65:4608:: with SMTP id v8mr4088470pgq.435.1623248556065;
        Wed, 09 Jun 2021 07:22:36 -0700 (PDT)
Received: from localhost.members.linode.com ([2400:8902::f03c:92ff:fe55:8c1e])
        by smtp.gmail.com with ESMTPSA id k21sm42920pgb.56.2021.06.09.07.22.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:22:35 -0700 (PDT)
From:   zpershuai <zpershuai@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     zpershuai <zpershuai@gmail.com>
Subject: [PATCH] =?UTF-8?q?Fix=20some=20wrong=20goto=20jumps=C2=A0for=20av?= =?UTF-8?q?oiding=20memory=20leak.?=
Date:   Wed,  9 Jun 2021 22:22:18 +0800
Message-Id: <1623248538-4352-1-git-send-email-zpershuai@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In meson_spifc_probe function, when  enable the device pclk clock is
error, it should use clk_disable_unprepare to release the core clock.

And when meson_spicc_clk_init returns failed,  it should goto the
out_clk label.

Signed-off-by: zpershuai <zpershuai@gmail.com>
---
 drivers/spi/spi-meson-spicc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index ecba6b4..b2c4621 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -725,7 +725,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(spicc->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "pclk clock enable failed\n");
-		goto out_master;
+		goto out_core_clk;
 	}
 
 	device_reset_optional(&pdev->dev);
@@ -752,7 +752,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	ret = meson_spicc_clk_init(spicc);
 	if (ret) {
 		dev_err(&pdev->dev, "clock registration failed\n");
-		goto out_master;
+		goto out_clk;
 	}
 
 	ret = devm_spi_register_master(&pdev->dev, master);
@@ -764,9 +764,11 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	return 0;
 
 out_clk:
-	clk_disable_unprepare(spicc->core);
 	clk_disable_unprepare(spicc->pclk);
 
+out_core_clk:
+	clk_disable_unprepare(spicc->core);
+
 out_master:
 	spi_master_put(master);
 
-- 
2.7.4

