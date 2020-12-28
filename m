Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B02D2E6C71
	for <lists+linux-spi@lfdr.de>; Tue, 29 Dec 2020 00:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgL1Wzk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 28 Dec 2020 17:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbgL1Tds (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 28 Dec 2020 14:33:48 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C0AC0613D6
        for <linux-spi@vger.kernel.org>; Mon, 28 Dec 2020 11:33:08 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n142so9703482qkn.2
        for <linux-spi@vger.kernel.org>; Mon, 28 Dec 2020 11:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/sVIiJrjVZwei7rJor7Y8B3sBzKdI3zaJNU/upFS3/A=;
        b=hzOkSzDTsLrN9wQlr0DYSZamqrRMc1T5k84iI9CLx4EX4rFFzAgxC0rWIhHWYMSPBf
         8Cilhjtec9Fe7JvFB0kiu+Gk0ZvYuZXYeEVbNpk9WP+E7+0v4JHgn04YJ3pnK/9Qgh7Q
         uNc7xEvCwRlx/3LKL131RPaKAhKJhN1fyKsywqZhptXC9SQl1LmYuMQwjU3+XegENJ4p
         hp3Wfgj8xYkQAd4Uy5soMS1SG5m0LlWjck+M1/jWk828opFlQ2ZFDCayI6HqQaRiySzJ
         H56vwEleWL4ePPPRKaWND0AzcLzMphASK+jSAjv/yJddI+AvgOqMZeiZkg3QBdaoKtWK
         02ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/sVIiJrjVZwei7rJor7Y8B3sBzKdI3zaJNU/upFS3/A=;
        b=pML9rK/XVfMmPJB2/yD7FlyYxjzkM1a9K1cTXH8OdFQrThGSsXOnhPh/aueDYUvNAe
         XSdHqcLIQeKKjYvij1CfXwFxN6MOE7/JISM8BAC8bSNzz4V490+YgR1njBScZAoL73na
         wwizHux9ep+0i2vnmWbCSh40t9yXn3VUXpujxRNV2P1fPg7VGNNqj5RjCj2dgI2w5zCj
         lmmTTRWssQgBmgakfP4sFCWYysnKrrF0MCAcPQrB0Etv8n4I+Q3NWpg6uaK5WINgPkrb
         gJqnX8qaoVPZJYNymKYjH4B6iFnxyC6LVdcprW++UK+npeyclNV/7rLlSX7sqmu4WqYX
         tVAQ==
X-Gm-Message-State: AOAM531EQQOQIzymBL0rr69AnQuybL/f/iTvCKzoyArNh++hJvDMdX/v
        /JQsg4gdEdnqwCYSEQzWpsU=
X-Google-Smtp-Source: ABdhPJzW9u/7C5Z8PXuPzsP0g8rjhRfSewTccM4yfbJYlMTA7t3vRAvuoRTRgj6oem+w3CkxFarEKw==
X-Received: by 2002:a05:620a:12b9:: with SMTP id x25mr46798883qki.421.1609183987565;
        Mon, 28 Dec 2020 11:33:07 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:482:a80::1001])
        by smtp.gmail.com with ESMTPSA id u20sm24303015qtb.9.2020.12.28.11.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:33:06 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     tudor.ambarus@microchip.com, linux-spi@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] spi: Fix regression when the SPI controller does not pass max_speed_hz
Date:   Mon, 28 Dec 2020 16:32:50 -0300
Message-Id: <20201228193250.26808-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since commit 9326e4f1e5dd ("spi: Limit the spi device max speed to
controller's max speed") the following regression is observed on an
imx6q-sabresd:

[    3.918284] spi_imx 2008000.spi: cannot set clock freq: 0 (base freq: 60000000)
[    3.925953] Division by zero in kernel.
[    3.929831] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.10.0-next-20201223 #276
[    3.938565] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    3.945124] [<c0111a68>] (unwind_backtrace) from [<c010c068>] (show_stack+0x10/0x14)
[    3.952925] [<c010c068>] (show_stack) from [<c0e11540>] (dump_stack+0xe0/0x10c)
[    3.960279] [<c0e11540>] (dump_stack) from [<c05d471c>] (Ldiv0+0x8/0x10)
[    3.967026] [<c05d471c>] (Ldiv0) from [<c089b044>] (mx51_ecspi_prepare_transfer+0xfc/0x17c)

The spi-imx driver does not fill the max_speed_hz field, so we get:

spi->max_speed_hz = 20MHz
spi->controller->max_speed_hz = 0MHz

which will result in spi->max_speed_hz being 0, causing the division by
zero in the spi-imx driver.

Fix this problem, by checking if spi->controller->max_speed_hz is not
zero prior to assign it to spi->max_speed_hz.

Fixes: 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/spi/spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51d7c004fbab..daa3d89484df 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3379,8 +3379,9 @@ int spi_setup(struct spi_device *spi)
 		return status;
 
 	if (!spi->max_speed_hz ||
-	    spi->max_speed_hz > spi->controller->max_speed_hz)
-		spi->max_speed_hz = spi->controller->max_speed_hz;
+	    (spi->max_speed_hz > spi->controller->max_speed_hz))
+		if (spi->controller->max_speed_hz)
+			spi->max_speed_hz = spi->controller->max_speed_hz;
 
 	mutex_lock(&spi->controller->io_mutex);
 
-- 
2.17.1

