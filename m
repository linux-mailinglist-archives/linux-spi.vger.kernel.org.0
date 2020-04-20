Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BDC1B1576
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 21:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgDTTJd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 15:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTTJc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 15:09:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF49C061A10;
        Mon, 20 Apr 2020 12:09:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so818807wml.2;
        Mon, 20 Apr 2020 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jF5s6mIDV3imWHwN3gxECUXiGCch+faubGbjA6qiFuo=;
        b=MA9Hc7It1IJZS+3VUl8IaZyr9hEDq/mPbwd2Pq14bW3UdHhu3Dabnrqnz0uKE2ACn0
         RI4VbmAncJlw5s7+wqp6aqxucd/Lzwu70Zs2RxmHCrMmOhE10y3nfl4lnHk+3AFT3Rlh
         T6QC/lqivqxOPHLl4kyK0K89R/iPqKz6M0aiphsxPEfi+zYGa55qPoZh8qlHhgmWecuh
         JhEDEjaFvZgMcT+X8wbdysuG4376TwlrcbdWs9ZT26LfI/m6LwW9YjMojxgbzi/K+dn/
         PbisGkgdwDoMXsWyOTQK7I1mgMwHwHcIZ74Wh+vpBtGStJ1r5EydNlwvHBGVuxq1CuYz
         584w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jF5s6mIDV3imWHwN3gxECUXiGCch+faubGbjA6qiFuo=;
        b=jbnpT6awTHD4knoQunGFIWdLhslGiSIaogFQrnjoRSY3XGIj3xAX9rlvYX2BbkRoAY
         zLqJ+LyKQbL3U6zHeOLdndS3f1UNZpuFcj00++E5FvQX+p6o3FRGglZOyF1rHvraT6sW
         updKlaaokOAfyx+w4VOJEjHck2kTuvf2okrNBJQl6IwcN1KiLmjvPblRUbVuuaUE0+HN
         meFtvlF+kB7sOlAwyK00gVt+H754gCdXM9lKjr92STR9ys5dE6bgPi7eWkp725kn6jGH
         VSbERCWwHbr9abig8PeCUBx8ypnmzkslRSocdg2qIk33FUjSMHEamgtxzOJR1zC/ZePJ
         qSNw==
X-Gm-Message-State: AGi0PuZMxzyXlFz253M5lIyE+q4WesEr0XXPViG307C9tnpDhWN756LD
        5ZfXmSS4aOgscw99LUBNHd8=
X-Google-Smtp-Source: APiQypLRVea+hlqZbX7g3aJ3ofjkpxEYOpCmtuezTVESJGLwrvrSTxpYQYGNwxv6uiXrQpOstFAbiw==
X-Received: by 2002:a05:600c:2941:: with SMTP id n1mr872602wmd.25.1587409770565;
        Mon, 20 Apr 2020 12:09:30 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y5sm621251wru.15.2020.04.20.12.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:09:30 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch v3 6/9] spi: bcm-qspi: Make PM suspend/resume work with SCMI clock management
Date:   Mon, 20 Apr 2020 15:08:50 -0400
Message-Id: <20200420190853.45614-7-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420190853.45614-1-kdasu.kdev@gmail.com>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SCMI only passes clk_prepare_enable() and clk_disable_unprepare(), made
changes to suspend/resume ops to use the appropriate calls so that PM
works for ARM and ARM64 platforms.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index e00208801c8b..a3936ae5a860 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1455,7 +1455,7 @@ static int __maybe_unused bcm_qspi_suspend(struct device *dev)
 			bcm_qspi_read(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL);
 
 	spi_master_suspend(qspi->master);
-	clk_disable(qspi->clk);
+	clk_disable_unprepare(qspi->clk);
 	bcm_qspi_hw_uninit(qspi);
 
 	return 0;
@@ -1473,7 +1473,7 @@ static int __maybe_unused bcm_qspi_resume(struct device *dev)
 		qspi->soc_intc->bcm_qspi_int_set(qspi->soc_intc, MSPI_DONE,
 						 true);
 
-	ret = clk_enable(qspi->clk);
+	ret = clk_prepare_enable(qspi->clk);
 	if (!ret)
 		spi_master_resume(qspi->master);
 
-- 
2.17.1

