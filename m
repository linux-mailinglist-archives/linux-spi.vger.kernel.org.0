Return-Path: <linux-spi+bounces-4314-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F395F1AD
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 14:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEFF6B235BC
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F4189503;
	Mon, 26 Aug 2024 12:41:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D908187868;
	Mon, 26 Aug 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676082; cv=none; b=D/hyZq/5dTF0kRGmxu84g2e0FkfkR4g+5QcrbjyiTBEdfndKL1M/A6fm3cv0maTlobH/NTq+9zmEAOvbbgvTWcoxefHMAEQ7Q322hF8iTJN37GlywHL46YfOvdky4xtHTxn4cjuD+wfM99miSUdn4b7bHUp3hLzRzHrUywRbnM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676082; c=relaxed/simple;
	bh=r7W7RPCkkhmu6JjU/8/v9ZaYy6i/nSPkqXpIxfq42QU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pq0BLjjOBwu1cw471gVLpQ6wTi0jgoy5qFggYMpp+KCbQCq53nXF2jJvw6K6p0NMCyKJAuhY4ja5oPRB9iYJpDts/F06ka8X1G2QJpE4HJG/rXm4SMgNrkbIxqf0nD/WTmiwwDd4EvXzB+cQPvZFSJEHnxRfsNiuFpCLd//+YJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WsqzR6cV6z2Cncd;
	Mon, 26 Aug 2024 20:41:07 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id BB6C61A0188;
	Mon, 26 Aug 2024 20:41:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:41:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <william.zhang@broadcom.com>, <kursad.oney@broadcom.com>,
	<jonas.gorski@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<broonie@kernel.org>, <anand.gore@broadcom.com>,
	<florian.fainelli@broadcom.com>, <rafal@milecki.pl>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 1/2] spi: bcmbca-hsspi: Fix missing pm_runtime_disable()
Date: Mon, 26 Aug 2024 20:49:02 +0800
Message-ID: <20240826124903.3429235-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826124903.3429235-1-ruanjinjie@huawei.com>
References: <20240826124903.3429235-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The pm_runtime_disable() is missing in remove function, use
devm_pm_runtime_enable() to fix it. So the pm_runtime_disable() in
the probe error path can also be removed.

Fixes: a38a2233f23b ("spi: bcmbca-hsspi: Add driver for newer HSSPI controller")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-bcmbca-hsspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index e48a56c68ce7..f465daa473d0 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -539,12 +539,14 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 			goto out_put_host;
 	}
 
-	pm_runtime_enable(&pdev->dev);
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		goto out_put_host;
 
 	ret = sysfs_create_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
 	if (ret) {
 		dev_err(&pdev->dev, "couldn't register sysfs group\n");
-		goto out_pm_disable;
+		goto out_put_host;
 	}
 
 	/* register and we are done */
@@ -558,8 +560,6 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 
 out_sysgroup_disable:
 	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
-out_pm_disable:
-	pm_runtime_disable(&pdev->dev);
 out_put_host:
 	spi_controller_put(host);
 out_disable_pll_clk:
-- 
2.34.1


