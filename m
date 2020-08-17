Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81071247B51
	for <lists+linux-spi@lfdr.de>; Tue, 18 Aug 2020 01:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgHQX6Z (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Aug 2020 19:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgHQX6Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Aug 2020 19:58:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AD7C061389
        for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2020 16:58:24 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so13899579qtp.1
        for <linux-spi@vger.kernel.org>; Mon, 17 Aug 2020 16:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nzxB+Ih/RPvK3FETeEWoQXqsuPP6HR5jhpqM6t1pj4w=;
        b=YA16A9KO3RpYF3JlGlVToElQAWgKNxz4Z9+7vtUj89gboslPoZgNcb24Bek3/6RRoN
         FGOLCC+cavC20TvR6z1f1W6kKm2BmRIJjM6NJiBT8Dhs17mNRE+8mWJCRktwx1QUyv6M
         lQQblh/AnAOwhPYOMbyTsYqM35DK79Y55bTscI2gyfN5fA8zlJBe4E9T/wKMCGLu+Gk8
         Evv5dh48GfUqpPjeYrFRWrlA962MNreaM5qOX5kLGuhtHNogiAFMj8y0dVLjibHA6T6r
         z13/llvWW4Nkyp5nUt3Vyfze64YiNqFEn391f2ypJL13SrnBINjul/pj9t1csc7E9V8W
         QyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nzxB+Ih/RPvK3FETeEWoQXqsuPP6HR5jhpqM6t1pj4w=;
        b=pHtt+tBYwd7ZUHZzX9lFyKW38KfSC9g2EnbJw1/L1CGz5VzdweoM8gGyMOUgOn32hh
         GHXtz75M5MsGRVt1J7VBMZIrvxlXgDZ6eFZ43nN2GaVhJOC8mU/UDBxXRsUEYoE4Mhcf
         8ku7Hf/cQHfedqD57AY4wJCHFRXYijfMVbVVrBqcnLa+9t1T3XtR5IWlOZnYiobKYASD
         rEpv+h4QG2ZX0MrVEt78pY13j7hxtNPz7raleY/a5kYv3UCNfWK3XkfttDS2RcXLPHM7
         L3mmzuG1p1pguVYWUJ1BS6OwR1BeMisqLxG+YxrqXsvnN1YEnJiYjtb+NeGFF8Ue43l2
         I+Kw==
X-Gm-Message-State: AOAM530sjlyWbfx6kIH/whIgklTSfnpBPSWOS8nKU23MkzYXRAdKc5xp
        nEVJC3uGkWDOaBWU9oiZMLA=
X-Google-Smtp-Source: ABdhPJwu8SECyIwW+ZomheY5yfYuKBSWdgisMoQ+X8x8u4JYDIC2uWICWw0S3DQ5tvmGvErw+8UiEw==
X-Received: by 2002:ac8:65c2:: with SMTP id t2mr15455105qto.370.1597708703420;
        Mon, 17 Aug 2020 16:58:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:4fb::1000])
        by smtp.gmail.com with ESMTPSA id w1sm19201345qkj.90.2020.08.17.16.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 16:58:22 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, xiaoning.wang@nxp.com,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] spi: lpspi: Remove CONFIG_PM_SLEEP ifdefery
Date:   Mon, 17 Aug 2020 20:58:12 -0300
Message-Id: <20200817235812.19518-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use __maybe_unused for the suspend()/resume() hooks and get rid of
the CONFIG_PM_SLEEP ifdefery to improve the code.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/spi/spi-fsl-lpspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 85a5c952389a..986b9793fd3c 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -944,8 +944,7 @@ static int fsl_lpspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int fsl_lpspi_suspend(struct device *dev)
+static int __maybe_unused fsl_lpspi_suspend(struct device *dev)
 {
 	int ret;
 
@@ -954,7 +953,7 @@ static int fsl_lpspi_suspend(struct device *dev)
 	return ret;
 }
 
-static int fsl_lpspi_resume(struct device *dev)
+static int __maybe_unused fsl_lpspi_resume(struct device *dev)
 {
 	int ret;
 
@@ -968,7 +967,6 @@ static int fsl_lpspi_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops fsl_lpspi_pm_ops = {
 	SET_RUNTIME_PM_OPS(fsl_lpspi_runtime_suspend,
-- 
2.17.1

