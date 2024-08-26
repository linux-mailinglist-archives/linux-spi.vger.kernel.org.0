Return-Path: <linux-spi+bounces-4311-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF61A95F0D3
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 14:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10BA1C236F0
	for <lists+linux-spi@lfdr.de>; Mon, 26 Aug 2024 12:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC32C17A938;
	Mon, 26 Aug 2024 12:06:38 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287F716F0EC;
	Mon, 26 Aug 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673998; cv=none; b=TuxNPXK+PZ1T2T79Fm/RTh0QOZSzm9vWjqcRJcByXI2D4+DTzhfgpOWVPgVKrMxf763zJafCJxmhG8IU8qmzPu+GJZw6mIldGYkRx413ewZpO42LhCvzYJ8odoQFJwsFcrPGiGxgT+veiDceSYaavHIOw/u3N5rM7ebQkbnv0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673998; c=relaxed/simple;
	bh=a5B8gmsj6XGfdPgdGo2E89uxSaAe8V3aCCMXyKUSPpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGRyNesC9CVGxtebmVxnpp7QuuYbGODXguVe+E5S+pi+P2Z8XimYKGhYE6BHqlDG2BsHrTvOttoi/BccY2IoJy/NWGF6iQHIYEMFEKTCsyz8RQCqaz26sJR3GuzksN6/wbeQNBP0mykw/hBN0P/7Uvz+jjRf68zmdj/fDebFzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wsq9L0Q3Bz1xw1n;
	Mon, 26 Aug 2024 20:04:38 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id CBFE7140120;
	Mon, 26 Aug 2024 20:06:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Aug
 2024 20:06:34 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 2/2] spi: zynqmp-gqspi: Simplify with dev_err_probe()
Date: Mon, 26 Aug 2024 20:14:21 +0800
Message-ID: <20240826121421.3384792-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826121421.3384792-1-ruanjinjie@huawei.com>
References: <20240826121421.3384792-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when EDEFER is returned and useless error
is printed.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 597fcc7fce82..fcd0ca996684 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1260,22 +1260,18 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		return PTR_ERR(xqspi->regs);
 
 	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
-	if (IS_ERR(xqspi->pclk)) {
-		dev_err(dev, "pclk clock not found.\n");
-		return PTR_ERR(xqspi->pclk);
-	}
+	if (IS_ERR(xqspi->pclk))
+		return dev_err_probe(dev, PTR_ERR(xqspi->pclk),
+				     "pclk clock not found.\n");
 
 	xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
-	if (IS_ERR(xqspi->refclk)) {
-		dev_err(dev, "ref_clk clock not found.\n");
-		return PTR_ERR(xqspi->refclk);
-	}
+	if (IS_ERR(xqspi->refclk))
+		return dev_err_probe(dev, PTR_ERR(xqspi->refclk),
+				     "ref_clk clock not found.\n");
 
 	ret = clk_prepare_enable(xqspi->pclk);
-	if (ret) {
-		dev_err(dev, "Unable to enable APB clock.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to enable APB clock.\n");
 
 	ret = clk_prepare_enable(xqspi->refclk);
 	if (ret) {
-- 
2.34.1


