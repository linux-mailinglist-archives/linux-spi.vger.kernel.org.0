Return-Path: <linux-spi+bounces-7904-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EB0AA9F73
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 00:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8ED1891CBD
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 22:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16B3283C83;
	Mon,  5 May 2025 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiQ0ATgx"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7B283C81;
	Mon,  5 May 2025 22:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483327; cv=none; b=Df5H/F/FQWn19WDQcLiZ2LPKd9US6Vx/xIJKpiCLp5IkVoEfl0bTpisyJOvKcTwDN8qfWVYho8MsvqEXPPO8uXcQ6MrsLIf1Cz7oF47jPEQrSR3RbZVqJmqI7qW14ENWzMVAVO3oOkjhhSDr6WdtSi0XWDIs60VWH7kcov/wjc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483327; c=relaxed/simple;
	bh=lnta+hZMPY5VaUkaDF8fXZF2WkKJfxgBtucIMgpK6Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dw/dm4hRcuBzoH1aOWAiE4qlC1D2NHrxkc++ncg1q81mxo7fJCPxMEYviE693Qsqi5J3bQQS8KMXm220fMwcxdCVE3R5rb334EVsny+Wf5h9PNezVt6fyPYipifJ1q0I1VjtUUzIjJw1ZTWsY2huXQB9lexDv8ndO7nKBbACb7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiQ0ATgx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F82DC4CEED;
	Mon,  5 May 2025 22:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483327;
	bh=lnta+hZMPY5VaUkaDF8fXZF2WkKJfxgBtucIMgpK6Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kiQ0ATgxjroPDOnvO9zV771Z0Dw6rlgLXCGaZt7DbeGPHL4tDDjcJhOmYdl6pBRds
	 m68vJGJi1C4AJleqG0Q9albUmimGK4VXKUsTVgh6IddLztdY+btV7znaSySOsZ1OOj
	 32WVqhhi3wTiEyazzq71cpZfJ9pAjuWE0/dXRuqHv6mvpdD26vekLamaIrShjAzHtl
	 oxpTAtgI7tkqd+/Xm8L3m13BAEVTOu3E9+jYgbutOx7tLUw8WmecF2r2aZ+YnA8Qnp
	 C/qz2N1UARtrlZmskA4DuotM0cFASw5aoqVWnMCjdyixXMgqF/WGC6ZKU8WULbyYY8
	 KQWgstagRsSpA==
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
Subject: [PATCH AUTOSEL 6.14 035/642] spi-rockchip: Fix register out of bounds access
Date: Mon,  5 May 2025 18:04:11 -0400
Message-Id: <20250505221419.2672473-35-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 1bc012fce7cb8..1a6381de6f33d 100644
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


