Return-Path: <linux-spi+bounces-7914-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BA6AAB69E
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 07:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E924A74B7
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 05:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1C73386C6;
	Tue,  6 May 2025 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeYmz8uW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8E36E091;
	Mon,  5 May 2025 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485846; cv=none; b=BxubRxdyTFQFoO6gD+dUTaliNjUQlHSyUtqPCMg6uVPqoxCmGYilItj9s1HfW18HZaOBAwP7RyS02zBL+q3kCSWzCbJH65HRaIwZc+oPmBqYQrI3n86ZrKbHLzgcekQvpomBtPrbl1X/88pFUICNEvF4SyH/oYdtgWJCILBMfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485846; c=relaxed/simple;
	bh=PE7Vp2EO7oix1ywNeZXCp3CTiaz6XzQCRZFHSUhhTFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qv/JSYMcYvwoa5idA7v11PyHtzExyBVKdt/cnjlS0vXveubPQAIzl1bXMgI3cOcq4kJ4iUvFWsxd1MmZlpTdAmLq726F1lPuTh6zQkaaxVHe2gQbI03VdsmHJDY7u2TnSHsq5m+xIDu+Y4q2fYnZjiL4WOOgJwRP+CDha/kt4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeYmz8uW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E17C4CEEF;
	Mon,  5 May 2025 22:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485845;
	bh=PE7Vp2EO7oix1ywNeZXCp3CTiaz6XzQCRZFHSUhhTFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qeYmz8uW3u4Imdnh0ZF8V9d6QToUHLbMY/Mw9K8zukZLJ4hI9LnYTsuRU5OpHy8/9
	 E72vNwPseaBTK4ZmQL65w4D8UivpMDwULNMHaZ86pGYItgCbeBdfYybhX76yUG3Aw4
	 bNYLnzCQf2Wn6a4tHuKZ/LYUIIcrbwZDip89Kak4p4hMqoYAClB51zZuktZMC4WrRQ
	 YnFZdiP+7c5Hn4JC6VzcXxcJ2Tn4VshuAPqTsx1NQ5s2LU3IME+hLfb4PuOl8+r5PW
	 msmeTyK3RcRNuEO6mfMqXkTHlx1rtFAGRTdl1V75+hQB4UKnxV5Xx/nNGCpd+qnxWD
	 Z+Mt+eYBXXvOw==
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
Subject: [PATCH AUTOSEL 6.6 025/294] spi-rockchip: Fix register out of bounds access
Date: Mon,  5 May 2025 18:52:05 -0400
Message-Id: <20250505225634.2688578-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 1f374cf4d6f65..1615f935c8f03 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -542,7 +542,7 @@ static int rockchip_spi_config(struct rockchip_spi *rs,
 	cr0 |= (spi->mode & 0x3U) << CR0_SCPH_OFFSET;
 	if (spi->mode & SPI_LSB_FIRST)
 		cr0 |= CR0_FBM_LSB << CR0_FBM_OFFSET;
-	if (spi->mode & SPI_CS_HIGH)
+	if ((spi->mode & SPI_CS_HIGH) && !(spi_get_csgpiod(spi, 0)))
 		cr0 |= BIT(spi_get_chipselect(spi, 0)) << CR0_SOI_OFFSET;
 
 	if (xfer->rx_buf && xfer->tx_buf)
-- 
2.39.5


