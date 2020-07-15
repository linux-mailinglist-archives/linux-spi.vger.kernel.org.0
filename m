Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AA8221052
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jul 2020 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgGOPHa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jul 2020 11:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgGOPGn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jul 2020 11:06:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77242C061755
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so6164889wml.3
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2020 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Neuk7hlxyMHOEJZl+c3Ce+fuWuJ+zLYxzzvecm8U2ZQ=;
        b=ic4mFINwL49QSVPf3k9/rgWYim5/9jEoZkN3gqetr4K9fAHlJVyJ3XypL6SuWfRqDz
         +S7WszcHEof6BWrZKfFj9g/YLF71Qcm1yt4zHcQPPYgdqTAQxCrOZh51+TZvW0YQ8Ck0
         aLn5KjCQKZ3Gd/aFzV5L2DQfyiqU8ujb9Iv4xSapyMw6tqW4tt5JwZPpcrPnOA8PiwaE
         0yOlSql13qvWzpkdNz/tyd6HeetzNbv+eay/5/xjytCtAkIYMyDbb9Uefd2mAG3NGm2+
         EaVE9UW+LkFfgx1Zg5Rp6RueZCf8/5881/TkICwUazyXDTk14I4cs6dLDvr0xHFNjtcl
         EisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Neuk7hlxyMHOEJZl+c3Ce+fuWuJ+zLYxzzvecm8U2ZQ=;
        b=IHcMfRLZxX220lK7y9zLD+RHzkGSYdVNcaPPZbecFHYDOek74z66ticUpnsPSAFGOV
         JhNndawedBqA5JBB1ULfM8KmC7yXVOX3G+SV+K5fssHIv2BrrfPzDqyNnpfHuufF4ELE
         aY9d0jT8b0Wl6yx2LlhCt/M8kqfQLXG+tkHHsO1P+xYllyl5uDN4baHl31Ld9IM7F7zq
         2w8UF73ha30cj7AgKur5FbdkBJUASPJrJAPC7TcMtUYEdNGqPstpBh3GC+Q4YkuHyymS
         C6cSp093CrZnRzMk7drx/DxVA6ykLXuzOVCJNS8MvZ8J5EtcWwok3WROSBUGD7z15pBz
         /x3w==
X-Gm-Message-State: AOAM530/0cFtuCaSXjraNutWjmWJsxVq+jTwoUgm5jz18WoOEClwQAQe
        AQPnPVJliJUsjEdiV2QdjIiTpQ==
X-Google-Smtp-Source: ABdhPJyhQwehdC5E5vWdp2tq0inGEyTI0AsEuhIDReVDRKACyOC/THNq1DETNswb/m5QQ3kSVY3afQ==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr8770056wmb.108.1594825602210;
        Wed, 15 Jul 2020 08:06:42 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 06/14] spi: spi-meson-spicc: Remove set but never used variable 'data' from meson_spicc_reset_fifo()
Date:   Wed, 15 Jul 2020 16:06:24 +0100
Message-Id: <20200715150632.409077-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
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

