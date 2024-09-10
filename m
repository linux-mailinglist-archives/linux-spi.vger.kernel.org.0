Return-Path: <linux-spi+bounces-4771-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D2973FDD
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 19:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103391C25587
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BF81BF7E6;
	Tue, 10 Sep 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLc6A2Lg"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05081BF33F;
	Tue, 10 Sep 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989027; cv=none; b=EeSPvQU3W+mRD2Ueh83bLmUIYLpWm816j3Sq8pAorCi/miEQJ+N3EGxD8Ba83wm5P0Qd0Tz4C1KX9uSg8IOxG8TcLl1HyZP4VeQ+yRcW6K6BjA2CxCZIqCldlUZC2dHNqo/jsut5UUzETz2Ce7U52bRzzT/tJk69WPjsbeDgaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989027; c=relaxed/simple;
	bh=tU1M033tNkDT+rpWbGZcuYO3T9rn39ffkWJ+dnnZuPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHmyI2aawXQsK5WbdiIHg02StLOX11oQUS7jNdZjIasNBg/xLO4GyHX1GOdt6CLOmbwuPL5WvdFbC/W7q2b8TlNE3EjzPgw8gB64Mw2u7GaS4Z0ivzkj+niFP70nTeLHq4QnQmOpWqmtT4fEqY+9XxwF2HtqzJZ7jMShvmzXsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLc6A2Lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71266C4CEC4;
	Tue, 10 Sep 2024 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989027;
	bh=tU1M033tNkDT+rpWbGZcuYO3T9rn39ffkWJ+dnnZuPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLc6A2LgkJCaHARUAAr3LYdifnzHJk+7ZhE2QqmU5f1RpK1XNrZQf5eVOiAa3scIf
	 dOZFzgibWAd3AuY0w2I/92l1QzsDcxueaB4x8V0k0mgVNWsxssyyW9SmDB2fiLG6Xx
	 HV2QLzktqDJQcNMvf/QBkktLKjRyL37Peuz0Rnds/l/iq6t93S4wAJl8qzjMH5qICE
	 WFDV6PcmzZ7MFTxzVsPnDPNt3yp41DWNaak6FymHv2AFLOfW7e4aiEugzroZNPHjv7
	 I1haQSHvtNNfEsD913lfGxNvkwC51caxh1pR/kxBXRet3Mn/eiBw5G68jpVcUWBljj
	 thq8w0AgE7iNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jonas.gorski@gmail.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 7/8] spi: bcm63xx: Enable module autoloading
Date: Tue, 10 Sep 2024 13:23:27 -0400
Message-ID: <20240910172332.2416254-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172332.2416254-1-sashal@kernel.org>
References: <20240910172332.2416254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.109
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


