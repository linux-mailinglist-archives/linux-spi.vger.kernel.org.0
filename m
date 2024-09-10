Return-Path: <linux-spi+bounces-4775-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1230D974014
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 19:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6E728A220
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 17:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140851C2428;
	Tue, 10 Sep 2024 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiRea6NK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0451C2423;
	Tue, 10 Sep 2024 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989064; cv=none; b=NuuesKEQeRBXpWCSIJzw9Us61CpPlzVWnwAppsX7HMYZYcbuk7oMEt2bjV+jccoi8hjCEW/dFPBFmQOPfJqHfnahpb/+un4M9o/r39F4uwJoIKT7uazmKS80r8ZeNK9REpr1VUnx8Uy7G2UEgWBtt0RNIC9vlmOU8xILbnPm6g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989064; c=relaxed/simple;
	bh=n47O2M+obFZrdPzfkwQ/HsyLPt+UdieB+kg0v9pOMso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQhAVFqxx7f73Yd2QXlWA3/Z2KcExhzMlBiHaO2ZotHimDWppOcvQfYuk/0rh1w05jX28UW05i6cAWTH5L5J3xBf+eMmQ03OFbXneud4aaTuU6wnt7f2+k+hRcsugqYgk9wJuQKo1y6Ixb1OEsiDX9pk0hxMYkwOPXRtLcsAKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiRea6NK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F9AC4CECE;
	Tue, 10 Sep 2024 17:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989063;
	bh=n47O2M+obFZrdPzfkwQ/HsyLPt+UdieB+kg0v9pOMso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiRea6NK1gZzi47VX5KDOHdkUmiFl035mMGBnSBhIvt6lFCAgUExr6NM2LTXJE9CI
	 Utnp5r5R7Ztxm6TdwFSc+5JuAdlTb8DEyPDykv/lmUlTUuwbVVKCtiMqeYNUWMDsUh
	 tYheRSx5c7sAG62vxvnloK3GFZMr23REDtO7Sif8mp2f4bm88hjuYn1ClK0JVnOwUZ
	 jJwNbuBtVeU3FjSMww35TZnM2zqy8Czkuuyhw7r3nkGPgmwtM36xScVP1ExvwQ+HdQ
	 AMxJk//REbFKU3+0NNlc3R57SMWKY0PWkS+JEdmJmAQSd+B4kw0UagU08GyjXli/2h
	 dnSxqmrVVJfkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jonas.gorski@gmail.com,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 3/3] spi: bcm63xx: Enable module autoloading
Date: Tue, 10 Sep 2024 13:24:15 -0400
Message-ID: <20240910172418.2416688-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172418.2416688-1-sashal@kernel.org>
References: <20240910172418.2416688-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.283
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
index ff2759616873..104e3e6e056d 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -481,6 +481,7 @@ static const struct of_device_id bcm63xx_spi_of_match[] = {
 	{ .compatible = "brcm,bcm6358-spi", .data = &bcm6358_spi_reg_offsets },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, bcm63xx_spi_of_match);
 
 static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
-- 
2.43.0


