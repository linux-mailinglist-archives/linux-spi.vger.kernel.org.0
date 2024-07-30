Return-Path: <linux-spi+bounces-4072-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0F9405BE
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 05:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6B81F2213C
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 03:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB55F13B780;
	Tue, 30 Jul 2024 03:20:47 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F6BE68;
	Tue, 30 Jul 2024 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722309647; cv=none; b=k6MeqZgQrpPcQRJs8QA6h1pNDC3t9/3q6YqhYXGRhtXQ6AQuwC1j+GBS331zmtE0mVzpdeDAyCig9X1cMQ2I0UbURxH5HIUhPdotTwNLzbJ+ZCzzadCQ6tr+l/G37523LgF/mwO7FeHIng5F8QW4XzS9sQqUyF0oMUTnI1OqvkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722309647; c=relaxed/simple;
	bh=USw3Bh1u/g2HU3a3khvOndJI8RhM9vphQe4vxeds9mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ca3kJZAAU0BSTkotuXMu0XcRzDElKbnerhWvv6qTLOuen29BDBY0O8JH/wblMdhQ5HL9uJwAElxG3Lv1mdPe/RVIOaiL74kIIHRwXVz++U5gpryX3UosX6sGyFJLmjC6isL8vAAPVom21nOYiaDDJhepq3pvS/jL3qzuVEeUTHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WY0kK511vzQn9T;
	Tue, 30 Jul 2024 11:16:25 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (unknown [7.193.23.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 377311800A0;
	Tue, 30 Jul 2024 11:20:43 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemm600002.china.huawei.com (7.193.23.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 11:20:42 +0800
From: Devyn Liu <liudingyuan@huawei.com>
To: <f.fangjian@huawei.com>, <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <shiju.jose@huawei.com>,
	<liuyonglong@huawei.com>, <yangyicong@huawei.com>, <yisen.zhuang@huawei.com>,
	<kong.kongxinwei@hisilicon.com>, <liudingyuan@huawei.com>
Subject: [PATCH 2/2] spi: hisi-kunpeng: Add verification for the max_frequency provided by the firmware
Date: Tue, 30 Jul 2024 11:20:40 +0800
Message-ID: <20240730032040.3156393-3-liudingyuan@huawei.com>
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

If the value of max_speed_hz is 0, it may cause a division by zero
error in hisi_calc_effective_speed().
The value of max_speed_hz is provided by firmware.
Firmware is generally considered as a trusted domain. However, as
division by zero errors can cause system failure, for defense measure,
the value of max_speed is validated here. So 0 is regarded as invalid
and an error code is returned.

Signed-off-by: Devyn Liu <liudingyuan@huawei.com>
Reviewed-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-hisi-kunpeng.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 6910b4d4c427..16054695bdb0 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -481,6 +481,9 @@ static int hisi_spi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (host->max_speed_hz == 0)
+		return dev_err_probe(dev, -EINVAL, "spi-max-frequency can't be 0\n");
+
 	ret = device_property_read_u16(dev, "num-cs",
 					&host->num_chipselect);
 	if (ret)
-- 
2.33.0


