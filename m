Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B5F65EAD6
	for <lists+linux-spi@lfdr.de>; Thu,  5 Jan 2023 13:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjAEMl3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Jan 2023 07:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjAEMlM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Jan 2023 07:41:12 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A2E16481
        for <linux-spi@vger.kernel.org>; Thu,  5 Jan 2023 04:41:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m3so19011097wmq.0
        for <linux-spi@vger.kernel.org>; Thu, 05 Jan 2023 04:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mYBOZhut1McL5t8U9bUpMD48gPtdONvdoyZEUsQo0o=;
        b=Dlp6rSddGlTIAmt3GjVdQUjqvXqHbbIQ0Z6RpA/KuOjU8qPQC7bM+7h/KMe5zPJUqJ
         9YM8XL/y6FGIAwWXjo+1x12QcywGZ2U4GotPozZ+GshXAFQjeWdGZmGFqRnLjaxgTKgL
         MxKtflXIebEXsjwadfP3APnkiJSyzJfZqfpMKXk+F4IiJ1wAWM17yrH/39EW3u5OJGMp
         UIGV2bJ7JrG+QgMkE+D5hS4FBxjagbznbfry/SG8c0cNLhMBy3JUC/TFHC+73g3SsVei
         m0R68KIaUbYhb+xTfIw/Y6rFGKYJ+WheQewYrxPEqhkli4qCMK0nq+hFy4lzXaHushal
         NisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mYBOZhut1McL5t8U9bUpMD48gPtdONvdoyZEUsQo0o=;
        b=xwasZ8BGg2jtxjF98cKDP0K0HLLSxQubtMN6QUAEeETR8mTl3E/4C7KYdceAMiC4IE
         HL/nwwPNmH3NUOyaWYvyZkfPE6ZKK6JCDs+yRqxDPLhu0/jb2dGihzDqJynVCycxInZV
         ncIOqrPQ7B/t+53jSCgHQuQsmHOdHXryhKc1UXDZ0bFa/AUo6tAhIskEabX7POaiwrRJ
         RjX+jC8W7iDxXp4XfpBkNvPjNQ5O9WLPkuWNmtAP25OthHWp+EzW5zPq1nVSti3kHbds
         BGD2scOWlqaqtwDShYJOp+xu+b0ipSo7TyjULxZULm/yCODjtvjRrBLB77z0C1VKfiOu
         6MtA==
X-Gm-Message-State: AFqh2kowtOTlG8JyCGSbY26J457BoFGWzilqBK3SaPKWAA7TL6iYaqUb
        xv5uiLItP2y1Y/r3V/fIH+FDng==
X-Google-Smtp-Source: AMrXdXuq1HF7/uhu/I0YpqGMQ8foibyaZRFMZfOLIr0fYPMW1O1rUDo7v6FWfImNpze9+pjju43llg==
X-Received: by 2002:a05:600c:a4d:b0:3cf:6e78:e2ca with SMTP id c13-20020a05600c0a4d00b003cf6e78e2camr39888024wmq.5.1672922467613;
        Thu, 05 Jan 2023 04:41:07 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:101:3196:3a40:6416])
        by smtp.gmail.com with ESMTPSA id m6-20020a1c2606000000b003b47e75b401sm2338153wmm.37.2023.01.05.04.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:41:07 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] spi: spidev: remove debug messages that access spidev->spi without locking
Date:   Thu,  5 Jan 2023 13:41:00 +0100
Message-Id: <20230105124100.185542-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230105124100.185542-1-brgl@bgdev.pl>
References: <20230105124100.185542-1-brgl@bgdev.pl>
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
taking the semaphore and without checking if it's not null. This can
lead to a crash. Drop the messages as they're not needed - the user-space
will get informed about ENOMEM with the syscall return value.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/spi/spidev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index b71620f64ec9..29c6344ee8e8 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -604,7 +604,6 @@ static int spidev_open(struct inode *inode, struct file *filp)
 	if (!spidev->tx_buffer) {
 		spidev->tx_buffer = kmalloc(bufsiz, GFP_KERNEL);
 		if (!spidev->tx_buffer) {
-			dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
 			status = -ENOMEM;
 			goto err_find_dev;
 		}
@@ -613,7 +612,6 @@ static int spidev_open(struct inode *inode, struct file *filp)
 	if (!spidev->rx_buffer) {
 		spidev->rx_buffer = kmalloc(bufsiz, GFP_KERNEL);
 		if (!spidev->rx_buffer) {
-			dev_dbg(&spidev->spi->dev, "open/ENOMEM\n");
 			status = -ENOMEM;
 			goto err_alloc_rx_buf;
 		}
-- 
2.37.2

