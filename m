Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDC1697DF7
	for <lists+linux-spi@lfdr.de>; Wed, 15 Feb 2023 15:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBOOFm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Feb 2023 09:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBOOF2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Feb 2023 09:05:28 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1563A2940C;
        Wed, 15 Feb 2023 06:05:27 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m14so19245052wrg.13;
        Wed, 15 Feb 2023 06:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FilJ1efIbrJg3yQgnQxJN6IMXqy2KV7z2bNrXe1iM9g=;
        b=j/FNoMoK03s4QhBnXPNcLY7f97k9eL+HNHyt7Sh0xwNHYjcGv+v/TlIPZYLydd45CR
         afqeK/UUwaz93X9uv+wuZeYiiTQmm8uk+lo51zvtQr8aWx8vUDi1m2Zk7wocPdGyjLZO
         SmVglt4vuw1aR0Ufg0fohnEQ+gTw+NI9HQAXjiCtUf/Pu5QBnvJPpBED3O3g4SOfKoRW
         HIp+wf0yGoPxqriTYk2AHqBrHRxpsA0Z1TrqyeGpZWZZqq5PzUVO31bYJf+3lllYVvor
         bGTaiCDCGG8xl5fnLNn+HkEfxG56D/U1nmaz80RcNJXVF+GDGnmqAHVWCJQygq80/gZo
         23RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FilJ1efIbrJg3yQgnQxJN6IMXqy2KV7z2bNrXe1iM9g=;
        b=7k92o8C270JuHunuI9wiczJo+Ql7MCwAQ6SMZjZoObUc78BDerd4/vAFw3EJmNyKt4
         MPW5ApmeA7ngwE90ibercZvlQhIprEmJ9CNWT/fRnDiKIfM/3HAff++j8xekPIgPZ3ki
         FMFhdKwIcuNEDsdBhKxUNczxwO1vVtGEu2TqingCyTm6OyL+nM/C1SBaWnz0VoOxQrsp
         kDuI9ZkqE9XOuv7OOHZGJkx3L55DyRCXuMvrq3d8AUfWTxxkSroEVS6Bl1JLOzSzW9Yy
         2iv/sAIV67TiUpV1jvl2AM0ii9MKZ1gNz9uVmuKeR5QmhxvadvPhHDrTAK8ZyqFRV0mI
         Eecw==
X-Gm-Message-State: AO0yUKWv8tR4dcA7SrL4gGuvUrcuhv2dbFG8W6jAlRW7huv22ezoui2F
        ak1vPKmHXQccueFQSZPL9ZY=
X-Google-Smtp-Source: AK7set+UOUM0jbVTxihMN/lkMXtrhGLEVjd2xn0YtDFvOVVM+cciMmEcP5/kOu+e7q/281srZGZiNA==
X-Received: by 2002:adf:e38f:0:b0:2c3:ff47:47ff with SMTP id e15-20020adfe38f000000b002c3ff4747ffmr2228051wrm.14.1676469925664;
        Wed, 15 Feb 2023 06:05:25 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b002c5493a17efsm13512408wrq.25.2023.02.15.06.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 06:05:25 -0800 (PST)
Date:   Wed, 15 Feb 2023 17:05:20 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Kursad Oney <kursad.oney@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: bcm63xx-hsspi: fix error code in probe
Message-ID: <Y+zmoGH6LubPhiI0@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This code accidentally returns success instead of a negative error code.

Fixes: 50a6620dd1fb ("spi: bcm63xx-hsspi: Add polling mode support")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 1e9e906d297c..e481c8d5e5d6 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -847,7 +847,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	if (sysfs_create_group(&pdev->dev.kobj, &bcm63xx_hsspi_group)) {
+	ret = sysfs_create_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
+	if (ret) {
 		dev_err(&pdev->dev, "couldn't register sysfs group\n");
 		goto out_pm_disable;
 	}
-- 
2.35.1

