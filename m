Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4991ACEF3
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 19:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733292AbgDPRnr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 13:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732896AbgDPRnn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 13:43:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C321C061A0C;
        Thu, 16 Apr 2020 10:43:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so5534671wmj.1;
        Thu, 16 Apr 2020 10:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jF5s6mIDV3imWHwN3gxECUXiGCch+faubGbjA6qiFuo=;
        b=ZJja63VqjxQSor/OTOHUgcBFFUlAlwS2Sz6byrUNrboZexWwV0EQ+QV3R+z0m5Olrf
         g+c2KjEO6xdMrFrxwe1kYvdTfCGDdsqa2198ujvDJPBZuEIWn0d5nkXTvd61DgbAWHal
         p/yoD6XV7ZdWxoRAkLNYPtQ+gApo3U9rYgY72FB33U5O2JLPVYpnXygbwzwR5e/4OTY9
         WzkB1jh8/GByzE5mVRiq5h+zGY2SR2x9BAlzwvMggjrwHmVMGQs5yiovVa9bpflUIds9
         /2cFr/LMxGqk8/FSoZQYLYOK2Lvq5/OCH0v24WA2oKTDF0YKW9byQKlpvaEk417MjzBZ
         Asaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jF5s6mIDV3imWHwN3gxECUXiGCch+faubGbjA6qiFuo=;
        b=ZIl2upFO0YeDWnBhP920Iv1U2V53JdW7mGlDg5+OEh5QLKl9ZIYjJLgfefK8M0MXd1
         f3esux4oTeWcRMhLrb/hQj4sVKYPG9M2RjKF69FEpVYsFgjM+w9kn5M0ihhDp2dy8or1
         vgpxaDYGcJ8ULc3s5MU4IXnVdxp8XN6bfig8TRjshANFEx2FE3Bwmlum2XLI+KnUD+KF
         OAnXK0PPlaZiIJ57+IXfpMv86DNfyq38KLaANLxunxP5f5giJJxtsxwKct2bZZ+kxi5U
         NPkOWbQtqVMbnj1i2BZnJH8TUfmBaIk38iaPyEPET2uyhELVoq9jr3N+lJTUETVSkrTM
         veGA==
X-Gm-Message-State: AGi0PuaqJvMLR6K8b7yktfqwKSQmz4Y3DOEHFwZfdSL/JLfF8T6V0GGl
        Up5bb4rJ6m5gmxDpifScglY=
X-Google-Smtp-Source: APiQypKABfDL3aBsjY878f0gyJuW4CTyhdV1K0/71xLp4SDNdTH/MRJGPB/DmsdCVy0QtbA9U9e4kw==
X-Received: by 2002:a05:600c:2941:: with SMTP id n1mr6082191wmd.25.1587059021446;
        Thu, 16 Apr 2020 10:43:41 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p7sm28736296wrf.31.2020.04.16.10.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:43:41 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Patch 6/9] spi: bcm-qspi: Make PM suspend/resume work with SCMI clock management
Date:   Thu, 16 Apr 2020 13:43:06 -0400
Message-Id: <20200416174309.34044-6-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416174309.34044-1-kdasu.kdev@gmail.com>
References: <20200416174309.34044-1-kdasu.kdev@gmail.com>
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

