Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE31721EA2C
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 09:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGNHgC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 03:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNHgC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jul 2020 03:36:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5171C061755
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2020 00:36:01 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s9so21275194ljm.11
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2020 00:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjMXS+XV363RNWgIwsQ194x8ZCtF3emK+GArEb3phhk=;
        b=qiNfZaPPvULm0iKmQhVLP7yAO+OXpFCRjW9NZFtZ6rx1HVsaCqh0T2KxYxyPIcV5wo
         4mi4Z+6tLECcWgKHFFuJ9aEMWFiGi+QLQyRiXLO9UzkWX+vzEBn5e0M6CHnkO/rnNqm5
         t7XwAY2kYYNYrBRcEEZ2CvFOAtYcbwgsFL3vH94pAIsx0Foqr16R+pJkb8DrlFCniJ3M
         zHvzn8h2BKojuhgRf05/ra1dBVBeeGxNXxnQdGdD4F0hSeiSDw9ogRN/xGr0f+co+JoX
         WR6NZddk17zGXScdpdPtASb5tr1T3/+suwTrHXyOSr717AnojheT+GuD7+U2EszKqH98
         lXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mjMXS+XV363RNWgIwsQ194x8ZCtF3emK+GArEb3phhk=;
        b=UKbR6mRFzj/aXgUCQozTekf6jxnCC6SW/lbVK9WNBhYJMdzDZKqkqBKknmS/jrRaB9
         lTkdTdtZ++XmHs5NkZis7E6v6jhsZF8GSbvGTN63RBylKhemMd3NvKpZz9UI+Fn4OEZu
         mogCt0956JUonhS5U5ZFzJQl6iGRGw2aDRyIp7IqmqbW8NDQnkyODSXYWme7gtEUKBKL
         yCp2Ol40g/ga0hXn1i1kD2XgjzJemUoz+FKv6+f0C4PTn28oQFC2CXV1AJiGjsvd0CZ2
         hJfM5jpy3RNsYD9H7VTF/i/KoCfsL0Fcx/83asKxvoXoHecWwkHbRMbotje2Tuka1hzd
         pJlw==
X-Gm-Message-State: AOAM530bz0Kyc6cWCxQkIggbIU7EipaOpfBWhc87oKIPHP3EOEX++WPt
        nj+DQ2gpmeHjIGBj+uoKT0iEYnX5hqY=
X-Google-Smtp-Source: ABdhPJyNd8HJGDlsZTqsfgHFNHs/Wx3E8CUMdnhQDiZT7blX32pbqNYIRqagHV/J9Xoj8/SoO/dTug==
X-Received: by 2002:a2e:9cc2:: with SMTP id g2mr1497931ljj.442.1594712160137;
        Tue, 14 Jul 2020 00:36:00 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id w19sm4478520ljm.120.2020.07.14.00.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 00:35:59 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] spi: omap-100k: Drop include
Date:   Tue, 14 Jul 2020 09:33:57 +0200
Message-Id: <20200714073357.34879-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The OMAP-100k driver includes <linux/gpio.h> but does not
use any symbols from it, so drop the include.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-omap-100k.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 5c704ba6d8ea..36a4922a134a 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -19,7 +19,6 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
 #include <linux/slab.h>
 
 #include <linux/spi/spi.h>
-- 
2.26.2

