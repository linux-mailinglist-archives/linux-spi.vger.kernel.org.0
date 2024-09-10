Return-Path: <linux-spi+bounces-4769-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B761973FAC
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 19:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CFF288814
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC99B1BD511;
	Tue, 10 Sep 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6U2lUh2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CC1BD509;
	Tue, 10 Sep 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989006; cv=none; b=d5dXWRgh+iU1LluZnvOG7Y8g0olPvjZWxa0PrXMFOoECGgGkLHaJKQeKDHn7KagNP8BlGAbRt3173v4iRzMHzf9VAgy0l4i6X7x0kFrgh5jdl+VAGVujryA1ZnV4rMXOfQHiYLV7JexrE9mM9dEHx5uReiqsTaDZLFbp5nuRgaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989006; c=relaxed/simple;
	bh=e2tc6dMsibvZBEjNYuaCibjzo2V5qPZvSbfwtJr5LfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjfsZ5up1tqug0JULcWjO7TY5ZW58yTeoofgQ17kw8yLM22lSn5CMfzGpI7y+6xIzgIy2Hl7m6PBeHR+yXelej657tb1VaB5i3Bk6xVt317bqjSmS6d9uHDMS+t14ekRGPnHwlydHTLUK7gL/XGpf0fq1coguHcA/DPdXcc4yGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6U2lUh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAC1C4CEC3;
	Tue, 10 Sep 2024 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989006;
	bh=e2tc6dMsibvZBEjNYuaCibjzo2V5qPZvSbfwtJr5LfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I6U2lUh2MB9yKyKe4Tg2URQrn9WWCvdxF0eQ6+P7zSNk4fyqRWWaDozcBpsWVGPda
	 oyNowHloHsyndPzXHt2IrIfHu/k1gH2RQXSDapKvatGnNirsbCZspcvklfQDJEAnYH
	 jacMLiWNOD8q9zAN73/elgEoHltLA6z1dCD0b313bg8Jufk2YfVAzQU1lakIlPwq+l
	 XumqXZcE/xxcPD07aTRyz2yTBtZ1+K7KnyqxnZ6QUC1Eu6A6NBPeZljbLsAxMy1L2k
	 8hYO9byzRLVSrY3kdj7wdE6iHj+MLjKibOFBsic6HY9l0K7xOA5+WQIEeJD50EUqx9
	 qF+x3MfePh2UA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jonas.gorski@gmail.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/12] spi: bcm63xx: Enable module autoloading
Date: Tue, 10 Sep 2024 13:22:53 -0400
Message-ID: <20240910172301.2415973-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172301.2415973-1-sashal@kernel.org>
References: <20240910172301.2415973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.50
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
2.43.0


