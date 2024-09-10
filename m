Return-Path: <linux-spi+bounces-4773-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E64974004
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 19:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8A71F27E13
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3D1C1747;
	Tue, 10 Sep 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvgY7orj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F91C1744;
	Tue, 10 Sep 2024 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989042; cv=none; b=p5OnGcDvHw/46schJ+NfWHv92F5XNd75AQBCsTqyyy6sM1RvHW0dt9RqMtvLaWHtsfx3697OvzbWLPutlV7kSpcSJTKRvynQ22ZxVVw1NBuddVCGByeV7qJBBABI0XjjFJLLHWE5Ue/n5429c2VHsdkxQtRH0msVyG9DDZ2E9eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989042; c=relaxed/simple;
	bh=tU1M033tNkDT+rpWbGZcuYO3T9rn39ffkWJ+dnnZuPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCAzkZzp6DHBU0qUGz8RHcUj6wlCNGDKZavKx3/us1QTTFn3fwNAezcTm8hvMJhtTrlYZ4NY+PSnRyHBeD2dfwPc2ZbGO/ftTmaIe40p0/ucj5WPx43wtiYFlhrS3sTjfPJJcQ2FicJP7yHBM8My7+2Ou/JB4OUFLmXEOgj/QL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvgY7orj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91EAC4CEC3;
	Tue, 10 Sep 2024 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989042;
	bh=tU1M033tNkDT+rpWbGZcuYO3T9rn39ffkWJ+dnnZuPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YvgY7orjOfrcXhXTzFbL3gNbhF4tjFNa3M2WL+AiEQhjYdM97lSPfkay5t2Y+ywZT
	 DcQoihq3DjdF6MLAd9mwwRUN66gVhGvxfxPpalRPZdOGTsVpB/3cgqQxs/XJDk2pSg
	 FkdSMDTTEpBP5qeagL9ucTBsZBPQd6ecFzjbPUV4o1HwTaU49g7tIuS0h44BTAQuS/
	 B+2SRf9KezyGM7pxwKLAK1S0TIvpfykZEsCiOqgMc6r9FATh2RsLYK4atYrwMFJr0T
	 bFOuN/d8r9UIEBU4qieCuhCT5rWYKf00BMNFNpIe5LnGXt//sZbMFJTiyw0XzN9t8+
	 lBOGddqP36kDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jonas.gorski@gmail.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 5/5] spi: bcm63xx: Enable module autoloading
Date: Tue, 10 Sep 2024 13:23:49 -0400
Message-ID: <20240910172352.2416462-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172352.2416462-1-sashal@kernel.org>
References: <20240910172352.2416462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.166
Content-Transfer-Encoding: 8bit

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit 709df70a20e990d262c473ad9899314039e8ec82 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Link: https://patch.msgid.link/20240831094231.795024-1-liaochen4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 147199002df1..a9921dcd6b79 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -482,6 +482,7 @@ static const struct of_device_id bcm63xx_spi_of_match[] = {
 	{ .compatible = "brcm,bcm6358-spi", .data = &bcm6358_spi_reg_offsets },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, bcm63xx_spi_of_match);
 
 static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
-- 
2.43.0


