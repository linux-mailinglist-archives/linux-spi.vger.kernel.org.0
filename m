Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3AE119B52
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 23:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfLJWGt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 17:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbfLJWFV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Dec 2019 17:05:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5D321556;
        Tue, 10 Dec 2019 22:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015521;
        bh=CFeG6hHCIUTpfpt8mweoDzuL837g4k5/WJx5IMGwZiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbG1uf0Az2LlEc6JxV2IioXF9AJXXgZxifHS2sXk/1wiAo9Euod37LwocM5/4nu/s
         XLjFLi9bGtJMta9maJs4MmRmB04JhWzw8hvKmizjoLy5sH+gy0wl01uCrutTftIW7P
         EWtmD/lq+EnuZKvXk1ef0bmUYl4OfvV5T9xV2eRM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 117/130] spi: st-ssc4: add missed pm_runtime_disable
Date:   Tue, 10 Dec 2019 17:02:48 -0500
Message-Id: <20191210220301.13262-117-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit cd050abeba2a95fe5374eec28ad2244617bcbab6 ]

The driver forgets to call pm_runtime_disable in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20191118024848.21645-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-st-ssc4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index a4e43fc19ece5..5df01ffdef468 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -385,6 +385,7 @@ static int spi_st_probe(struct platform_device *pdev)
 	return 0;
 
 clk_disable:
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(spi_st->clk);
 put_master:
 	spi_master_put(master);
@@ -396,6 +397,8 @@ static int spi_st_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct spi_st *spi_st = spi_master_get_devdata(master);
 
+	pm_runtime_disable(&pdev->dev);
+
 	clk_disable_unprepare(spi_st->clk);
 
 	pinctrl_pm_select_sleep_state(&pdev->dev);
-- 
2.20.1

