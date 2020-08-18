Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459C32490FA
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 00:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgHRWff (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Aug 2020 18:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgHRWfc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Aug 2020 18:35:32 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26C2C061342
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2020 15:35:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dd12so10408097qvb.0
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2020 15:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oLuu4CbE9W3CLN17FQ58IjamALm9fwXvUmKYkx3ooJY=;
        b=aytCj721WKwh0ucOa7sxh9kODRFjtwKITtdYEmeMPZulm32FaQSTIOKh+6cJCkw0Ko
         0bSygyvPGWXFrNUS7qsBMYuqpXPfAQPWd00EVzvn5lB63dDkbju4o/RJG4LkQRMIaGMN
         G30aGtAPvN8GRE+u3+1J1KF55+IPMmps2RkSZKGm019dca/dwFkvTuiyFlkg5qYxY78z
         +UQeaV8NhJ2F6SKXhQMK3ayKTeP6m5ZyU94kLqaxpBPj4BCULHmnwlnYY6g+qfrlu1sJ
         dZ77IId1LOv16zFm4MKf430wTh9XbH3skjv3oc1rHy8tXDLaUNIexL+0/+m3Dne8K8Cy
         KN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oLuu4CbE9W3CLN17FQ58IjamALm9fwXvUmKYkx3ooJY=;
        b=kAIZd927NvY9eC3jvufb5kTbQ/RyIQzzDv/B2b1HUwNyPx0F89dtHIGbS2ZGQmhsFa
         N0jAA9qVmf+sWT16Hodgfp0smI/nkT4J1MQZpdrpui+kG+33ak2nSa57L+xP1YZ7BQ3r
         vvL1G91PB3HirpK77WxTRzopTm/u6ZqKqVkSEGn1TmTe3gwJpe9knC4LiViaSP/yzIdQ
         IZJOKp/RBjdySwsZhyvhh2JddATK2sRcFlM2HP3gW3YnYMYU47dzGGAcrCtlLTEdQHBR
         WBxacWGxHhGg0pQE1OKg1iYbCOqMbqYNnP3jTcZ0UGLkQhOfep6yv1cu7jbPnsyFjbfR
         Kskg==
X-Gm-Message-State: AOAM532NeTIdqCxcN8cs/FMys2fcffKrGo+whAA6v9xrIZEA0IXC3aKy
        3nHmpJaR4x18rMce9s7eaNo=
X-Google-Smtp-Source: ABdhPJyyythsPJHNwo7+KCmtfEQYkxX0wqXh5vH1MunRRrvptJ3bCA/OpfxRHTf5GscXthxcNKxlhw==
X-Received: by 2002:a05:6214:612:: with SMTP id z18mr21700465qvw.25.1597790131110;
        Tue, 18 Aug 2020 15:35:31 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:4fb::1000])
        by smtp.gmail.com with ESMTPSA id t25sm24459478qtp.22.2020.08.18.15.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 15:35:30 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] spi: imx: Remove unneeded probe message
Date:   Tue, 18 Aug 2020 19:35:19 -0300
Message-Id: <20200818223519.8737-2-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818223519.8737-1-festevam@gmail.com>
References: <20200818223519.8737-1-festevam@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no point in printing a plain "probed" message on successful probe.

Just remove it and make the kernel log a bit less noisier.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/spi/spi-imx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index a06679ab64f9..5f5c114ab935 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1708,8 +1708,6 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_clk_put;
 	}
 
-	dev_info(&pdev->dev, "probed\n");
-
 	clk_disable(spi_imx->clk_ipg);
 	clk_disable(spi_imx->clk_per);
 	return ret;
-- 
2.17.1

