Return-Path: <linux-spi+bounces-4073-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE79405C0
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 05:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E78C1F221DB
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 03:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81DF14883F;
	Tue, 30 Jul 2024 03:20:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4516C1854;
	Tue, 30 Jul 2024 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309648; cv=none; b=f1IrY5ATn6W97NRFHXqkFnp+leNylNT+q5GfpffwIGP21aNboWLOAKxtghF/Lz17/KjSCSbWqT8hnxFtCuBbRaknbZD1GJVrjkMmTQNETjkgedsTnzGw4d76bSRKZFwZqQKVO7y8CycRJLMYU+HYfHeyrT/sNCvYJw2ZAUCzJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309648; c=relaxed/simple;
	bh=cjDA0KnD101v++Ruc7eXXGvZTpiP6zzAaMz/mM9Um4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYlVcQZkvpuc5AoN6ikybMudUdmYgM1IJT++QZeaGyykLiCvUSF3u0adhLxgRIuvYaQQO/C77A9fHqZEDcKE7wTkGgIU19H+FSUVUIAoQS1BWZ5Wo17jybucIKqT6XuanIao3yoL0dYSwR5ze2chuX0uPcYqfL9NROulZBoDcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WY0q45kjCzxVr7;
	Tue, 30 Jul 2024 11:20:32 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (unknown [7.193.23.29])
	by mail.maildlp.com (Postfix) with ESMTPS id A5D0618009F;
	Tue, 30 Jul 2024 11:20:42 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 11:20:41 +0800
From: Devyn Liu <liudingyuan@huawei.com>
To: <f.fangjian@huawei.com>, <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <shiju.jose@huawei.com>,
	<liuyonglong@huawei.com>, <yangyicong@huawei.com>, <yisen.zhuang@huawei.com>,
	<kong.kongxinwei@hisilicon.com>, <liudingyuan@huawei.com>
Subject: [PATCH 1/2] spi: hisi-kunpeng: Add validation for the minimum value of speed_hz
Date: Tue, 30 Jul 2024 11:20:39 +0800
Message-ID: <20240730032040.3156393-2-liudingyuan@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240730032040.3156393-1-liudingyuan@huawei.com>
References: <20240730032040.3156393-1-liudingyuan@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600002.china.huawei.com (7.193.23.29)

The speed specified by the user is used to calculate the clk_div based
on the max_speed_hz in hisi_calc_effective_speed.  A very low speed
value can lead to a clk_div larger than the variable range. Avoid this
by setting the min_speed_hz so that such a small speed value is
rejected.  __spi_validate() in spi.c will return -EINVAL for the
specified speed_hz lower than min_speed_hz.

Signed-off-by: Devyn Liu <liudingyuan@huawei.com>
Reviewed-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-hisi-kunpeng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 77e9738e42f6..6910b4d4c427 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -495,6 +495,7 @@ static int hisi_spi_probe(struct platform_device *pdev)
 	host->transfer_one = hisi_spi_transfer_one;
 	host->handle_err = hisi_spi_handle_err;
 	host->dev.fwnode = dev->fwnode;
+	host->min_speed_hz = DIV_ROUND_UP(host->max_speed_hz, CLK_DIV_MAX);
 
 	hisi_spi_hw_init(hs);
 
-- 
2.33.0


