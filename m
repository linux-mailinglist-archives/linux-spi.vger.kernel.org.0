Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3594E223D76
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 15:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGQNzQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgGQNye (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jul 2020 09:54:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566CEC0619DA
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:34 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z2so11258230wrp.2
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2020 06:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Neuk7hlxyMHOEJZl+c3Ce+fuWuJ+zLYxzzvecm8U2ZQ=;
        b=JqcHwGwYT8ZTvOUrpYD9UCG8OknPKe8KLct5xkbhm9XKF4P4uYR3ON03DVJiunjCn9
         QalPNLZvjQnz3T1ZZ9giCZ7GjjqGSi2w13uo8hMx3L+J4wM+SCKHoJ7knI9Kd9M/nlGt
         o2wI1kB21f9JI/xRneRKdJMNoMlJAyRmqfVA58DfnQrFib3EINkomufdHtBctOOj2LIW
         QTMr9rlzAWo6+J4efQMbIqi8bDow/ngNWRzB8LMci5NiRtYIKlNTofQTrypuLrgTkW7c
         HVDsTyXjFUajMUuSHCJRL7I3fU2YEwA78dG7meEnNEPs3ruKpDUG/HVmR6gs+ydyy2Hu
         f9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Neuk7hlxyMHOEJZl+c3Ce+fuWuJ+zLYxzzvecm8U2ZQ=;
        b=Dge+51hToMoKRl2YoIUUnutyeYoL9Evf8U7F9P5yoiow+banZIRmOcqMf9NzuOD0x4
         OYGKQpOmotiVzqBuei01RZPqRQjQjou0Oq3KtCy/+hyjx60HyRgvcVYJEvMwWrUvk+EP
         yfgckXZp7QqNCXDAe+xuUvrL/4DUAMl+/h3SA85sYbM/rq8mnq+5U3wCX41ABU04dnP6
         meIwyanWU766ozUqGJJt9TrzVW0U+xap/JBWoDchjFYG1acZimhQ1o5G1XdRg8XOkrDx
         oYEWxr99lUboYsecUZAE+jqSiOsBzsNhcyN0BK3Hik09nUyyhm8B6CctL6Je/9ECrY+l
         1d3Q==
X-Gm-Message-State: AOAM533uTgXBdmlvPcO5PgIVHMXEcHe6xAX2kGfgGNM85KgVabQ1mVcN
        TATTYxBK494C14KJ/hwPlo+7WGkXluENfg==
X-Google-Smtp-Source: ABdhPJz3szDLxEUogVXdh3Zg2yz5Kc9c/NDxZApAW0Y6M9e5ChL8WhgjNGUtkoELCEPuIq+gwAJAiA==
X-Received: by 2002:adf:ebd0:: with SMTP id v16mr10685903wrn.241.1594994073095;
        Fri, 17 Jul 2020 06:54:33 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w128sm16118356wmb.19.2020.07.17.06.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:54:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 06/14] spi: spi-meson-spicc: Remove set but never used variable 'data' from meson_spicc_reset_fifo()
Date:   Fri, 17 Jul 2020 14:54:16 +0100
Message-Id: <20200717135424.2442271-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717135424.2442271-1-lee.jones@linaro.org>
References: <20200717135424.2442271-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Looks like it hasn't ever been checked.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-meson-spicc.c: In function ‘meson_spicc_reset_fifo’:
 drivers/spi/spi-meson-spicc.c:365:6: warning: variable ‘data’ set but not used [-Wunused-but-set-variable]
 365 | u32 data;
 | ^~~~

Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-meson-spicc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 77f7d0e0e46ad..ecba6b4a5d85d 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -362,8 +362,6 @@ static void meson_spicc_setup_xfer(struct meson_spicc_device *spicc,
 
 static void meson_spicc_reset_fifo(struct meson_spicc_device *spicc)
 {
-	u32 data;
-
 	if (spicc->data->has_oen)
 		writel_bits_relaxed(SPICC_ENH_MAIN_CLK_AO,
 				    SPICC_ENH_MAIN_CLK_AO,
@@ -373,7 +371,7 @@ static void meson_spicc_reset_fifo(struct meson_spicc_device *spicc)
 			    spicc->base + SPICC_TESTREG);
 
 	while (meson_spicc_rxready(spicc))
-		data = readl_relaxed(spicc->base + SPICC_RXDATA);
+		readl_relaxed(spicc->base + SPICC_RXDATA);
 
 	if (spicc->data->has_oen)
 		writel_bits_relaxed(SPICC_ENH_MAIN_CLK_AO, 0,
-- 
2.25.1

