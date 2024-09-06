Return-Path: <linux-spi+bounces-4700-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0435096E7BD
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 04:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28961F223F4
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 02:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED22ECF;
	Fri,  6 Sep 2024 02:31:24 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81785335BA
	for <linux-spi@vger.kernel.org>; Fri,  6 Sep 2024 02:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725589883; cv=none; b=WzyGoYvyvPRXt0ggBtErvKyVmjVMOQJmQf0JXgPyYI56s/06TX9Ay5GC/QS0GW53GhYp6dESPLazfZ8nmuPyeuy7LRaTwJd5oIP8UPLTJQacU53FVdOMwid/AJcQxkRAXPzleuw3MIxpFEOWHYLoNhzjtFfB1uM5rpyJgh9Ej7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725589883; c=relaxed/simple;
	bh=h75+jUSeT67VyeCMmwK7vPwcXh3YvpEwlC6ESVXXzgc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aDSpep1XoytoH5Dxn54YiA0No9JVJieIrdhqkg3exQFvT6EyNKCl3oCPLI/WSM486A4ZXjpkMM7Dj+NYa7C0AiZjxbcNDiAZmcf5FxQSHUtaCos4iQRH7DQlIz6Q5ENG8K3/WYzf7+bhgxuuLTpcyQqUBwn/wbO4dTu7EFNzICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X0Kvy66v6zyRY4;
	Fri,  6 Sep 2024 10:30:38 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id B1FC6180064;
	Fri,  6 Sep 2024 10:31:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Sep
 2024 10:31:18 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] spi: atmel-quadspi: Undo runtime PM changes at driver exit time
Date: Fri, 6 Sep 2024 10:39:56 +0800
Message-ID: <20240906023956.1004440-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)

It's important to undo pm_runtime_use_autosuspend() with
pm_runtime_dont_use_autosuspend() at driver exit time unless driver
initially enabled pm_runtime with devm_pm_runtime_enable()
(which handles it for you).

Hence, call pm_runtime_dont_use_autosuspend() at driver exit time
to fix it.

Fixes: 4a2f83b7f780 ("spi: atmel-quadspi: add runtime pm support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/atmel-quadspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 5aaff3bee1b7..466c01b31123 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -726,6 +726,7 @@ static void atmel_qspi_remove(struct platform_device *pdev)
 	clk_unprepare(aq->pclk);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 }
 
-- 
2.34.1


