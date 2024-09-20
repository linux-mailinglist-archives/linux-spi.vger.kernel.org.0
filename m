Return-Path: <linux-spi+bounces-4897-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511997D33C
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AB72819D7
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 09:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4280126ADD;
	Fri, 20 Sep 2024 09:02:01 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC73813A271;
	Fri, 20 Sep 2024 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822921; cv=none; b=g+oeln4Pc4SFLTkdCd+j05nLkmhd7EQ/fmyemhPyGawVsqXPsPt3leUYat82rZoo8sruNoOTjt4J6NUAg+bx8jv7v6XgyN1XD7RFgIBhfejFwL08J/KZ97YiDbqTHE0qUTgy72eHmwvJCpLGq19nys3rgHD4jq7ER1APWToea+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822921; c=relaxed/simple;
	bh=+lEB/u9deBbDtkbi6H0U4vhLH9wn/oMD0/ZgHrtiYFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sDR14ItGezj8k9+9CS3fLowEA+ZDYrEucczlro1AVh9T3JLtEnwlypZjZ8QKsz/YJ2XZYCbyxUqky3Rw55M1DwgKFuasDS+5rSYNs9whM63Tqg9gscJVxcyWeYc1x+5RenIn6g2pWwTutWRRNFAvNrsOlk9KnY82V9pxSaZjr6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4X95wt1j4czjM9B;
	Fri, 20 Sep 2024 17:01:50 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EF2C14010C;
	Fri, 20 Sep 2024 17:01:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Sep
 2024 17:01:49 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <michal.simek@amd.com>,
	<naga.sureshkumar.relli@xilinx.com>, <shubhrajyoti.datta@xilinx.com>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] =?UTF-8?q?spi:=20zynqmp-gqspi:=20Undo=20runtime=20PM=20ch?= =?UTF-8?q?anges=20at=20driver=20exit=20time=E2=80=8B?=
Date: Fri, 20 Sep 2024 17:11:35 +0800
Message-ID: <20240920091135.2741574-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

It's important to undo pm_runtime_use_autosuspend() with
pm_runtime_dont_use_autosuspend() at driver exit time.

So, call pm_runtime_dont_use_autosuspend() at driver exit time
to fix it.

Fixes: 9e3a000362ae ("spi: zynqmp: Add pm runtime support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index fcd0ca996684..b9df39e06e7c 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1351,6 +1351,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 
 clk_dis_all:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
@@ -1379,6 +1380,7 @@ static void zynqmp_qspi_remove(struct platform_device *pdev)
 	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
-- 
2.34.1


