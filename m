Return-Path: <linux-spi+bounces-4211-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2500195624D
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 06:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592EC1C2148B
	for <lists+linux-spi@lfdr.de>; Mon, 19 Aug 2024 04:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A839313D62B;
	Mon, 19 Aug 2024 03:59:57 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9CC6A33F;
	Mon, 19 Aug 2024 03:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039997; cv=none; b=uu3HqMAqYVF2R/C0hv7gs8cMrKUdrOgfExg+tXkLYV57Tkrj0Gge0xdK4mofl4D+znGckFIxMoY9dTMVP/tLfQplbgv5ynhwoVZmqkw8hEfaqxBEjgVZar/s0Z7sJJb6ZkLM5CEsPuSDVwf+WfrNGnR6syk/FSGGuapDVxiMQmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039997; c=relaxed/simple;
	bh=TrEPM9BM7C8YStb34PmtX4sEyYK/SzXjBRA282cCAs4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iXD8tWH1E5BiX3DkqipHWWtuexyIapGaf+9w5NxwfvcwawTA2LFvBFzT2SQ2dMswAzZbo+f3pc6dhSz17FJLjWQxnDrnWM3x3MtG8XvPk2y7d1DXe0TJEIPyTnoGUcNx2QfcqS+/6rP1GQ39yA6O6BT0pd4FnAJS9cNSPvXxD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WnJdT67w0z1S7hp;
	Mon, 19 Aug 2024 11:54:53 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 432DC14022E;
	Mon, 19 Aug 2024 11:59:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 11:59:51 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <jonas.gorski@gmail.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] spi: bcm63xx: Fix module autoloading
Date: Mon, 19 Aug 2024 12:07:09 +0800
Message-ID: <20240819040709.2801490-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/spi/spi-bcm63xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index aac41bd05f98..289f8a94980b 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -466,6 +466,7 @@ static const struct platform_device_id bcm63xx_spi_dev_match[] = {
 	{
 	},
 };
+MODULE_DEVICE_TABLE(platform, bcm63xx_spi_dev_match);
 
 static const struct of_device_id bcm63xx_spi_of_match[] = {
 	{ .compatible = "brcm,bcm6348-spi", .data = &bcm6348_spi_reg_offsets },
-- 
2.34.1


