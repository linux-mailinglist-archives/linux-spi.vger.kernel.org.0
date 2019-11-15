Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A20FFD7FD
	for <lists+linux-spi@lfdr.de>; Fri, 15 Nov 2019 09:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKOIbg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Nov 2019 03:31:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34428 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOIbf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Nov 2019 03:31:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so6166728pff.1;
        Fri, 15 Nov 2019 00:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q5lwtXD313rHZSqTsFu5Vpidw5xPFvZNMsGZjM8+wlc=;
        b=NHudv3nyHz7Q+fs6X0XQGBlaj4WXkIqjOkTM26W0q/mer5tjJsjBBWBz8q6w4e03io
         dVZzYUbjq+9f4RJBsqIJpkajljnPjdhC1z37Czg5pZ2+SRs4AR/y1PyUiTjoExtnPv7S
         Dg26Ueye525NDpnN4B5XDoaTioYQ1YlCzy2AOUZ44bC8XPqgQZyYRRKFA3vmcDDAhuaE
         BRrcomHoWkxuSNqWa9GivaMI0UR8KwwwHDM5R7lw3KKByt67b9meuxIfxJv+tgcAJUQJ
         hR8QX9kTh2vR/sjCE6W21OF0Q6E6bfKMR3FFUEy/HsmFzJ/3ytQH+y+WYer1iT+4qAt8
         OMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q5lwtXD313rHZSqTsFu5Vpidw5xPFvZNMsGZjM8+wlc=;
        b=dBI9y+gP8zbGjoIXtGrVHR3OXLf7q3WcgrbumKCUGtV99lkKr2u7/WPRcKC5/NoOnN
         kKjqjaj8gTdd21zpm/UYw+2+eAzGvgE18UeGY4y1ZDQJm3gfYWMIbJmXnoBo+fu8QaYm
         n5aHYTwDZcnFHWU2+jdLN44qF57oMO6yhGP4SuPQMhZN6YNNz5vKNXHW7LN+1OYegUuu
         mHlGrJsufE5Iq3jn6hywvj507L48dcmI8OAOVr67aH9ll7x8Phbz1VT2DcQ9PJbAdmov
         KdU9NSwDGk2aKX4x4RCPCfU7RwpRvJDW09BNVc7AlK9wGUUJGQqDFO8SqMMKSLFwVn9T
         wAag==
X-Gm-Message-State: APjAAAW7Ebg++6cYxZoJjmSc/JpLZADMKoKBVjlR5bOXk8MO75o7V7yS
        G9468lGwbpqfvsoLjgOZj80=
X-Google-Smtp-Source: APXvYqxAkW2zAZmUz5kbEPeJkH3e1VcfN0GhpH8Dfh00dkZ0NgzY1AywWDmZHQR5RrXlG5Me3Pb+Lw==
X-Received: by 2002:a63:e26:: with SMTP id d38mr14905201pgl.44.1573806694390;
        Fri, 15 Nov 2019 00:31:34 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id f13sm10739924pfa.57.2019.11.15.00.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 00:31:33 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] spi: tegra20-slink: add missed clk_unprepare
Date:   Fri, 15 Nov 2019 16:31:22 +0800
Message-Id: <20191115083122.12278-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The driver misses calling clk_unprepare in probe failure and remove.
Add the calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/spi/spi-tegra20-slink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 111fffc91435..374a2a32edcd 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1073,7 +1073,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	ret = clk_enable(tspi->clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Clock enable failed %d\n", ret);
-		goto exit_free_master;
+		goto exit_clk_unprepare;
 	}
 
 	spi_irq = platform_get_irq(pdev, 0);
@@ -1146,6 +1146,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	free_irq(spi_irq, tspi);
 exit_clk_disable:
 	clk_disable(tspi->clk);
+exit_clk_unprepare:
+	clk_unprepare(tspi->clk);
 exit_free_master:
 	spi_master_put(master);
 	return ret;
@@ -1159,6 +1161,7 @@ static int tegra_slink_remove(struct platform_device *pdev)
 	free_irq(tspi->irq, tspi);
 
 	clk_disable(tspi->clk);
+	clk_unprepare(tspi->clk);
 
 	if (tspi->tx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, false);
-- 
2.24.0

