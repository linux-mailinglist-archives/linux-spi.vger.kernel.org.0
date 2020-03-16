Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2161862D2
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 03:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgCPCdd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 22:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729537AbgCPCdc (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 15 Mar 2020 22:33:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 650E220739;
        Mon, 16 Mar 2020 02:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326012;
        bh=AhLIt3Be5ynfJ9W7ht0BWEQsj+TQFznIuCiV6H4xBNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ThxuzZnh/JQtEGPCjLswbdZz25HhnVdIT76jkGYqiuZlsqj+AvCskchajewDwLbDo
         yQe5xPybkX/p4nSEFJWX35qF+XcAlU4hh/iHfKiojJADLwxiqfd82mkzRmEplvcVPO
         /p45WNQ7RcMW5NvybjvWynz+pUhdlmj5dgIuiRMs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yuji Sasaki <sasakiy@chromium.org>, Vinod Koul <vkoul@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 10/41] spi: qup: call spi_qup_pm_resume_runtime before suspending
Date:   Sun, 15 Mar 2020 22:32:48 -0400
Message-Id: <20200316023319.749-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023319.749-1-sashal@kernel.org>
References: <20200316023319.749-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Yuji Sasaki <sasakiy@chromium.org>

[ Upstream commit 136b5cd2e2f97581ae560cff0db2a3b5369112da ]

spi_qup_suspend() will cause synchronous external abort when
runtime suspend is enabled and applied, as it tries to
access SPI controller register while clock is already disabled
in spi_qup_pm_suspend_runtime().

Signed-off-by: Yuji sasaki <sasakiy@chromium.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20200214074340.2286170-1-vkoul@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-qup.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index dd3434a407ea6..a364b99497e26 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1217,6 +1217,11 @@ static int spi_qup_suspend(struct device *device)
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	int ret;
 
+	if (pm_runtime_suspended(device)) {
+		ret = spi_qup_pm_resume_runtime(device);
+		if (ret)
+			return ret;
+	}
 	ret = spi_master_suspend(master);
 	if (ret)
 		return ret;
@@ -1225,10 +1230,8 @@ static int spi_qup_suspend(struct device *device)
 	if (ret)
 		return ret;
 
-	if (!pm_runtime_suspended(device)) {
-		clk_disable_unprepare(controller->cclk);
-		clk_disable_unprepare(controller->iclk);
-	}
+	clk_disable_unprepare(controller->cclk);
+	clk_disable_unprepare(controller->iclk);
 	return 0;
 }
 
-- 
2.20.1

