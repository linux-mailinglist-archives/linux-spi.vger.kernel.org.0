Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D5E65FE86
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jan 2023 11:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjAFKH2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Jan 2023 05:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjAFKH0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Jan 2023 05:07:26 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78131BEBC
        for <linux-spi@vger.kernel.org>; Fri,  6 Jan 2023 02:07:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d4so826949wrw.6
        for <linux-spi@vger.kernel.org>; Fri, 06 Jan 2023 02:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZWY1/S6RdMZhtZh79E6ztwnlZlP7yNb5btDBzqm71k=;
        b=MkRwuDvaRgv64sZzuV19hROgiMZ0beknf9LKQN28c33XcAq8LLf1AOHHlQ/+b91out
         MQweAOg/onmevNjJt+6u6iC+5vcQRrRlNshahgxThNZkTp7zOKML6/582B2ngE3Rvq8i
         krbH8NzNZRUjuyUqeS8hKtnKU4K777nc9d8tbgaXCYs2Iqr6PgYUC1VkD0Pe9YCR4z/D
         l56RgqjaeOQncpFkOW8/4k/5DXZsHswQgTW0IhUoaI/fAEzSBwwm4hzB+FqjKqxaNp4Z
         u7C23PFTO823LQX3VQkFWg2pDnzntiX3v3k8z3G/2C3v+g4u88cHXkET+k7FlCQ0ap4q
         9Caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZWY1/S6RdMZhtZh79E6ztwnlZlP7yNb5btDBzqm71k=;
        b=Ofknbjk/OY5qtMDExVhclGcLeEqs/QEtCtPLmOzqvVqYn0Zzx1Uj+i6mOqCReoz2lr
         JheOu8mOccUMSemk9QeYEaFNktiIYdhx7fnuQiJDQdf3MPpx8JAG1h9rF6WO1Dys1NBv
         //GdGEffGS/gMLeP/baV5s7yyIEc59zTy4K+PJ/pAGbkZo81DZco5AwqFxl2fVba5ZPd
         G8hBvvyGDOc9SUZPCYG6pfIY/VHecOtbcm/Gp3HvSAcsLqJxK2f15k/hiAOXbVUyM+fC
         gyIB8+N/FdrOTV9qjViW9Xm20Lh6ko+qU7EzaPEAnQvqV6JIVTwgaatvHi+Qr1N0yI9m
         ulOA==
X-Gm-Message-State: AFqh2kog2fKi/1Qdvsq0CZIF4Ulk14j8KNrulcdBY9t+YfWK86cHGvzz
        TrHDNDvMyHfGA7uWEymFl/6lKA==
X-Google-Smtp-Source: AMrXdXsRc9lzn15C6YvcOfZWKzNzEW4zdhbLXxx1y3G0GwYgCMNoBjQcGWaslhzQXSVMMIfr35mP6Q==
X-Received: by 2002:adf:f7d1:0:b0:273:a0d8:c9f5 with SMTP id a17-20020adff7d1000000b00273a0d8c9f5mr27666658wrq.61.1672999642540;
        Fri, 06 Jan 2023 02:07:22 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:86fd:399:3851:d474])
        by smtp.gmail.com with ESMTPSA id f2-20020adfdb42000000b0024274a5db0asm780594wrj.2.2023.01.06.02.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 02:07:22 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 2/2] spi: spidev: remove debug messages that access spidev->spi without locking
Date:   Fri,  6 Jan 2023 11:07:19 +0100
Message-Id: <20230106100719.196243-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230106100719.196243-1-brgl@bgdev.pl>
References: <20230106100719.196243-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The two debug messages in spidev_open() dereference spidev->spi without
taking the lock and without checking if it's not null. This can lead to
a crash. Drop the messages as they're not needed - the user-space will
get informed about ENOMEM with the syscall return value.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
v1 -> v2:
- no changes

 drivers/spi/spidev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 42aaaca67265..1935ca613447 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -603,7 +603,6 @@ static int spidev_open(struct inode *inode, struct file *filp)
 	if (!spidev->tx_buffer) {
 		spidev->tx_buffer = kmalloc(bufsiz, GFP_KERNEL);
 		if (!spidev->tx_buffer) {
-			dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
 			status = -ENOMEM;
 			goto err_find_dev;
 		}
@@ -612,7 +611,6 @@ static int spidev_open(struct inode *inode, struct file *filp)
 	if (!spidev->rx_buffer) {
 		spidev->rx_buffer = kmalloc(bufsiz, GFP_KERNEL);
 		if (!spidev->rx_buffer) {
-			dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
 			status = -ENOMEM;
 			goto err_alloc_rx_buf;
 		}
-- 
2.37.2

