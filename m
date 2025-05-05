Return-Path: <linux-spi+bounces-7907-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A17AAA8B8
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 03:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D9A988134
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 00:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95A134FB14;
	Mon,  5 May 2025 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWt3Au6O"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4BB34FB11;
	Mon,  5 May 2025 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484822; cv=none; b=OJ4l517wqoopQ4mgUw2HXiYBxNRtSnFGWMc3wShQAbiiEMK82kW9Z5YRhxFxBpmZYabgM6T/9oEP3EXrE0qeBsMfTQTSr1CmYsHOwwibk8FomqPU5LoxaGke56izPOTDHhtGYkbYoujF59H0nM8cxUpp27ZiPmgMbUVYPT81bZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484822; c=relaxed/simple;
	bh=DtvHFykVSDQuaO9lkQBRldoHX++x89ZUDYXZWFSdAIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tppnNgLvO3Yl/XAts/BYPrHMrbW7VwMFlWx9Ht5VVIIx8MzYTRBjh6xv972XlhNhy+Jj0JCUjXdu1ImbVx4dG7Ja+QwT053wkNogMKRSecOlhR6ttVuZaNdHAfBi2GvCcrcbOMfIuuTHfGBy8Pq5kw/yMT5YxEz0fA9PY6KeTAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWt3Au6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A0AC4CEEE;
	Mon,  5 May 2025 22:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484822;
	bh=DtvHFykVSDQuaO9lkQBRldoHX++x89ZUDYXZWFSdAIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWt3Au6Oga2Hd+B8hhpeiuFy/MNmC8NbuMn5tzL80rxdeVnRlfi3WDM27EBFtSSHz
	 Y1aHzp0M28CiXGVa+GJcUsTX9OlqB9vB7dtpGG5J+WanrHqWVNdV8WYYFRWgfwINCZ
	 Guhf++53j0b7QqcRM5nC+J0saQsWcIgs58/qQuXpWFAD+W8qkHSSVBK/E4OjUTOpiD
	 ZfElBXIwCBCKq6Bw7N3KvnCmh37hQtjjRiRBkARB5b5SS+VobppRRIfbHzvVXCPHyE
	 cf78TU+UckenYEVsyuGtL6PMmaGzgCjzitrVOdfCvkEFLy/FIsq7vhI2e1HcDQbFS9
	 WIckcXpxaUE4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis de Arquer <luis.dearquer@inertim.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	heiko@sntech.de,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 031/486] spi-rockchip: Fix register out of bounds access
Date: Mon,  5 May 2025 18:31:47 -0400
Message-Id: <20250505223922.2682012-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Luis de Arquer <luis.dearquer@inertim.com>

[ Upstream commit 7a874e8b54ea21094f7fd2d428b164394c6cb316 ]

Do not write native chip select stuff for GPIO chip selects.
GPIOs can be numbered much higher than native CS.
Also, it makes no sense.

Signed-off-by: Luis de Arquer <luis.dearquer@inertim.com>
Link: https://patch.msgid.link/365ccddfba110549202b3520f4401a6a936e82a8.camel@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 40a64a598a749..5008489d6fac8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -547,7 +547,7 @@ static int rockchip_spi_config(struct rockchip_spi *rs,
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 	if (spi->mode & SPI_LSB_FIRST)
 		cr0 |= CR0_FBM_LSB << CR0_FBM_OFFSET;
-	if (spi->mode & SPI_CS_HIGH)
+	if ((spi->mode & SPI_CS_HIGH) && !(spi_get_csgpiod(spi, 0)))
 		cr0 |= BIT(spi_get_chipselect(spi, 0)) << CR0_SOI_OFFSET;
 
 	if (xfer->rx_buf && xfer->tx_buf)
-- 
2.39.5


