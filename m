Return-Path: <linux-spi+bounces-4918-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC2897E51A
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 05:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED1F1F216A3
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 03:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03568D528;
	Mon, 23 Sep 2024 03:50:23 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082BB8BE5;
	Mon, 23 Sep 2024 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727063422; cv=none; b=do23wjcnQoVTjCdkPIHgh0fhIyjHa1Qi8/U4auF9679TxzeZf6IPfD+eS/S4Jzavi918awLhJOeOAtgA8XlgIxvkQA09VRbVblIbeLN/y8aZV7i6CEroX8Ngd+LdE2+ivnTffr69Bsq4nAlLAbt6ppa+XJghwnQyN3A3mxbk79M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727063422; c=relaxed/simple;
	bh=2FiUPBy8ZBjGzygKY1qls1DjBQ4IOYwbIG9jNAYhxWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqKL7YZxefmAiRmgiH0cB8/HkEmO57SFa515y5kLGnHOHSln9KMR/owSDh3K0c3DVJKWgzdXcdsZaxLkWJ4jNgES2V6USVw5G0tnGuVByYQgE1t+lIkRVkT7WspXKwWeN3CkoeT3GKoi1+jpauasz7P2SCdk8s1ZPs9VAUfhArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XBpqg49lLzpVp4;
	Mon, 23 Sep 2024 11:48:15 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id A5B4E180087;
	Mon, 23 Sep 2024 11:50:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Sep
 2024 11:50:18 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
	<kernel@pengutronix.de>, <festevam@gmail.com>,
	<shubhrajyoti.datta@xilinx.com>, <srinivas.goud@amd.com>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 1/3] spi: spi-imx: Fix pm_runtime_set_suspended() with runtime pm enabled
Date: Mon, 23 Sep 2024 12:00:13 +0800
Message-ID: <20240923040015.3009329-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923040015.3009329-1-ruanjinjie@huawei.com>
References: <20240923040015.3009329-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

It is not valid to call pm_runtime_set_suspended() for devices
with runtime PM enabled because it returns -EAGAIN if it is enabled
already and working. So, call pm_runtime_disable() before to fix it.

Fixes: 43b6bf406cd0 ("spi: imx: fix runtime pm support for !CONFIG_PM")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 85bd1a82a34e..4c31d36f3130 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1865,8 +1865,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 		spi_imx_sdma_exit(spi_imx);
 out_runtime_pm_put:
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
-	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(spi_imx->dev);
+	pm_runtime_set_suspended(&pdev->dev);
 
 	clk_disable_unprepare(spi_imx->clk_ipg);
 out_put_per:
-- 
2.34.1


