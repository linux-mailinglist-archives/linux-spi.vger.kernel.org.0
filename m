Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95DE364B46
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 22:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237914AbhDSUkx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 16:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhDSUkv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Apr 2021 16:40:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72083C06174A;
        Mon, 19 Apr 2021 13:40:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r12so54996420ejr.5;
        Mon, 19 Apr 2021 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bw5IhZj9aI8jPgCDzrQQ4QwlvPSxNH5FozaD2GGrtoc=;
        b=EQWjTrDQWErqauELNSlzFJqDxUggWownGF1Zl0SbYFLRZNg18oQDmQgBMaSgK3Znyh
         N6CU2dZ3okbBgirspmicEVs1v5dZvkFsSgV+RL789MI0nrXz+Qui2sZY3+YbCpiGZJuZ
         52RmWeitwmK1hPGuYvf/Rjw3vMnvqmoPrUrBuBw2ECcLhhFqZkvgvuRuD34hG9yYP9tg
         /RYEx2gfvpbukpYSg11CxN6gdJcOHs4pqvW+1HxdjVS/Blapd3IlaDf3MuiDP+2QoFSS
         uqpk6kA4tA/sx3P9T+4mA9M7Oe9S6Yv4NBroHUkGDiz2HMr56XTxWCTCt/43xLbcxbmN
         d+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bw5IhZj9aI8jPgCDzrQQ4QwlvPSxNH5FozaD2GGrtoc=;
        b=jFUhp6kdnI8eoC0tigjZXRo+gYDZvl8vloycJqEENuWWCEz1Y6l85aF0Okxv+p9T3U
         8ufNc0JeqarurlejRbSkbMjDRiX6nyQk2t0sE6gOFyY0RwBqROpJDlloFKL2taFNOEes
         QBWS+W2oc2VeqATRI48UTcDJAwKZymt2roWZoy6xwkGkPdoWjYxAgSSx9/kIz0WNiEgI
         vEndL77pHz9HOnFd2aY9m3wKo8BxXFzUUibMvv/q/t2r0UsbrH/8dcc5LtqFCkX0iR9C
         adZZ5HG7AAc1Lgmpemrxmk4XCRVkz/m07W5p2DlMRbdbTIoOPG1aJu6cSvGRmQ+l+V4V
         gTAw==
X-Gm-Message-State: AOAM530EFvFvZ9EzVFxufn7oprX7gbGuffLgH893TcHhK61wWbL+yrDC
        jGAYdOHfeJU/BHdQFUyQq1QeyGT7Q82Dt7+r
X-Google-Smtp-Source: ABdhPJzDdIhOuuVIdayRFbBhxGTyoEn2sTN+kHETsPJbSv0KGWp6thFGiMfRAlfnQS9P47NL+BlxRA==
X-Received: by 2002:a17:906:7795:: with SMTP id s21mr23593421ejm.309.1618864820097;
        Mon, 19 Apr 2021 13:40:20 -0700 (PDT)
Received: from microndev.lxd (ipbcc00c74.dynamic.kabel-deutschland.de. [188.192.12.116])
        by smtp.gmail.com with ESMTPSA id u4sm11056706ejf.11.2021.04.19.13.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 13:40:19 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     broonie@kernel.org, linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH] spidev: Add Micron SPI NOR Authenta device compatible
Date:   Mon, 19 Apr 2021 20:40:15 +0000
Message-Id: <20210419204015.1769-1-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add compatible string for Micron SPI NOR Authenta device.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 8cb4d923aeaa..f56e0e975a46 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -683,6 +683,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "dh,dhcom-board" },
 	{ .compatible = "menlo,m53cpld" },
 	{ .compatible = "cisco,spi-petra" },
+	{ .compatible = "micron,spi-authenta" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.25.1

