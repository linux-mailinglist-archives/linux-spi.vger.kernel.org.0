Return-Path: <linux-spi+bounces-4931-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8375097EAF3
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 13:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E211C214D3
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 11:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134DE82866;
	Mon, 23 Sep 2024 11:45:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C71195F28;
	Mon, 23 Sep 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727091922; cv=none; b=MiG1o8GIsT7bGkCpqnPumTsCAjTkNpH3lTiuhHQEGsKxjx2qWC7uykr3bfskMqkpmpf3qNgPfoVkjxsH2oMjvKj2n56tGVitusaHr2YTjotoXLhIKLVnMsF289U7WVPhhnuax1F4G5St0y46dd7AbMfgcIjWaLqijUFJzozhrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727091922; c=relaxed/simple;
	bh=1Y+7jApXWBFrVy3tA4wPb4Sl0TL5mUwX30PQEOhbAEk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TRtebRtEHaxptPniRYH75kmH7n8KDgwOc1vdX/w0tXvBZyodJeCPH7iDWMFeC+cnOMn031CueaUb9KPBwmV/RljsfYJv38X8dtZHXDB4+FaFKQPIk3Xo4+La71xNoGJj7x/2XrKf4mV4wivXNhkzOnp2X0vJ1tx64USnV/O5hAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XC1NV0ncDzySF5;
	Mon, 23 Sep 2024 19:43:54 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id C4C421800A7;
	Mon, 23 Sep 2024 19:45:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Sep
 2024 19:45:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <broonie@kernel.org>, <heiko@sntech.de>, <kernel@esmil.dk>,
	<jon.lin@rock-chips.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] spi: rockchip: Fix excessive check for get_fifo_len()
Date: Mon, 23 Sep 2024 19:55:16 +0800
Message-ID: <20240923115516.3563029-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Since commit 13a96935e6f6 ("spi: rockchip: Support 64-location deep
FIFOs"), get_fifo_len() return 64 or 32, never return 0, so remove
the excessive check in rockchip_spi_probe().

Fixes: 13a96935e6f6 ("spi: rockchip: Support 64-location deep FIFOs")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-rockchip.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 0bb33c43b1b4..680fe6ef6acc 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -819,11 +819,6 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	}
 
 	rs->fifo_len = get_fifo_len(rs);
-	if (!rs->fifo_len) {
-		dev_err(&pdev->dev, "Failed to get fifo length\n");
-		ret = -EINVAL;
-		goto err_put_ctlr;
-	}
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, ROCKCHIP_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
-- 
2.34.1


