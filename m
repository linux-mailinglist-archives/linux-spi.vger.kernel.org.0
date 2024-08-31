Return-Path: <linux-spi+bounces-4492-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C928696709F
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 11:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CE71F23F18
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 09:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E481C17B427;
	Sat, 31 Aug 2024 09:50:54 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FBB14D449;
	Sat, 31 Aug 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097854; cv=none; b=tf+I2iCY3WvFHHnEaA/fu7e6lGLaXC1U2wLXpbkt8t5WZTlbtkISV2BFFlt0GWWxtkrylz5EfqUi/1IfgI881HtmqbcEk18rJbdoFADmfgsxo3/8uD5T9Sp7jyrcdFw9gljsc6igWP0OXFFZy+IZRVxlUth5KvC5lzgrwaus7nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097854; c=relaxed/simple;
	bh=BGYh7/QRfZ64GQXg69JR3h08AbkzhK0DBQzu/Uw/pe4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C8qAxlmJtB0eofeieNqH9fa07276RSFrk9qVUtzVUq/R2AmIofQECsLaj9F3WSvoh21L3eT7QZminOhIdBQL/uOFYLA9dZoBDVrhtEWGRfNVGLLtdNh+v2p5bBoKDj9NlyD2Iyun1EvxyTWhehSiK6eVYEFLgxYHVPMwy7MRJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WwqyM6v3Tz2CpKh;
	Sat, 31 Aug 2024 17:50:35 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E22A180043;
	Sat, 31 Aug 2024 17:50:51 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 17:50:50 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jonas.gorski@gmail.com>, <broonie@kernel.org>, <liaochen4@huawei.com>
Subject: [PATCH -next] spi: bcm63xx: Enable module autoloading
Date: Sat, 31 Aug 2024 09:42:31 +0000
Message-ID: <20240831094231.795024-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/spi/spi-bcm63xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index aac41bd05f98..2fb8d4e55c77 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -472,6 +472,7 @@ static const struct of_device_id bcm63xx_spi_of_match[] = {
 	{ .compatible = "brcm,bcm6358-spi", .data = &bcm6358_spi_reg_offsets },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, bcm63xx_spi_of_match);
 
 static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
-- 
2.34.1


