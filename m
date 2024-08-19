Return-Path: <linux-spi+bounces-4210-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAFA956245
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 06:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26831F2242F
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 04:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E9413D8B5;
	Mon, 19 Aug 2024 03:58:10 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44A41C6E;
	Mon, 19 Aug 2024 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039890; cv=none; b=YT3MxiIO9fxQBeavVGvNSDfmwOnzTOoYrIKmKtRvLUsmpTWkzwyDS7ENjtrgFIY++LNFLMmd1rsBtJ0mGipgGwMtrK9C6jagxaV7RabrA16q0eNetgYinDaTS/GPEAHzQtZSeXSguouf/fLV5gnwhdZzF+9Lwk1XDBOQDeORJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039890; c=relaxed/simple;
	bh=8zPxIc0+P9MZogb5XCa0Arr7lOKJaaLa0Bh28cH++tw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dn2EhNG1u7pM4W17B5Eiuxw6pwxZRhY2jL0iOfcXGKzIfQBbHDCglFfRHaB5TYSroZe0x8CKrgc/DtcgLA0o0sZ6ejkyhX1ymv5IkkdOd4Kvwdvs9XES9rjAMK/HFj7n5A/4PyNmJddqWFvRdcMBqcrI1sVnPmIlehlVGodjB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WnJgT58BCzpSt9;
	Mon, 19 Aug 2024 11:56:37 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 999D6140361;
	Mon, 19 Aug 2024 11:58:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 11:58:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <andi.shyti@kernel.org>, <broonie@kernel.org>, <krzk@kernel.org>,
	<alim.akhtar@samsung.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] spi: s3c64xx: Fix module autoloading
Date: Mon, 19 Aug 2024 12:05:23 +0800
Message-ID: <20240819040523.2801461-1-ruanjinjie@huawei.com>
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

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-s3c64xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 833c58c88e40..51a002b3f518 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1637,6 +1637,7 @@ static const struct platform_device_id s3c64xx_spi_driver_ids[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(platform, s3c64xx_spi_driver_ids);
 
 static const struct of_device_id s3c64xx_spi_dt_match[] = {
 	{ .compatible = "google,gs101-spi",
-- 
2.34.1


