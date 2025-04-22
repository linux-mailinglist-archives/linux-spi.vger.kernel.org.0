Return-Path: <linux-spi+bounces-7693-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D459A95B7D
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC8416A6CB
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E925DCE4;
	Tue, 22 Apr 2025 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPVQKKTy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030AC25DB1B;
	Tue, 22 Apr 2025 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288249; cv=none; b=BnnIPsCO0ANAeoRonbvsA3OU5mssvJ3/d4pt4ix5Kfi9dKKZBGWu20CTSSz60avqyJK3f5guIVgxoSmH4HApX3nKjEkTYTWYNDDDGPH4vUibVI3UZk+YAiqegSHJ++0fscC3MZkM+8NQ8oHn3k+iupF3t9c9Yqb1yb2SCGyEDck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288249; c=relaxed/simple;
	bh=prF9UikR1ykvBz0y9dGG737hWrGLtlaL2oAyTPGNKso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1ZPuXJAB46kZd9r/3PkOw0rb6j8n//MqZbkf9PEwCCGqKFRCGZiorz8TlmbHjoB7S/26m+IeL3wjz6CwYCKK4VvT7QllR9LvKHmJC06tZ5qL/Ty1ViKQsRLoSsytsMHMqudlTIrgJLLXAVyYJWZ0m2Kta63610115q2blSpn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPVQKKTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D7FC4CEF0;
	Tue, 22 Apr 2025 02:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288248;
	bh=prF9UikR1ykvBz0y9dGG737hWrGLtlaL2oAyTPGNKso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPVQKKTyLJ6keAruS65Z3wDXt/PWBWZBc7eNTq35q2KkepF17BX2X4QFHyjxJ0Dh2
	 IBuEMNbLCj+PGIHRGkPS6ZkxH04vnxj+iB6QIV088r/VzUTih5GPdCsk8Iu39YYNaZ
	 Ge95BJKiVAijFYMIrSATnjF9qy9wJJrlIvm6ErN0UwyGb4NOrN1Z7Oy1MwexFWxRw/
	 d5p2BK26V+JOtz1Taaa7v/f9FqqQSNVdN9rg9Easmo32t8ltQRrCu8SL9xE0hkFEt5
	 A11IEbSGm24WK7u6KN0lBP4FYgpT34CuIkHCeAa5JKZz5QNq9SoJ5YmGdp5k0fGWk6
	 dDlCq7SP3coKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	skomatineni@nvidia.com,
	ldewangan@nvidia.com,
	linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 15/23] spi: tegra210-quad: add rate limiting and simplify timeout error message
Date: Mon, 21 Apr 2025 22:16:55 -0400
Message-Id: <20250422021703.1941244-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021703.1941244-1-sashal@kernel.org>
References: <20250422021703.1941244-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.24
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 21f4314e66ed8d40b2ee24185d1a06a07a512eb1 ]

On malfunctioning hardware, timeout error messages can appear thousands
of times, creating unnecessary system pressure and log bloat. This patch
makes two improvements:

1. Replace dev_err() with dev_err_ratelimited() to prevent log flooding
   when hardware errors persist
2. Remove the redundant timeout value parameter from the error message,
   as 'ret' is always zero in this error path

These changes reduce logging overhead while maintaining necessary error
reporting for debugging purposes.

Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20250401-tegra-v2-2-126c293ec047@debian.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra210-quad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 94dc4cbc40e15..2d48ad844fb80 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1118,8 +1118,8 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					QSPI_DMA_TIMEOUT);
 
 			if (WARN_ON_ONCE(ret == 0)) {
-				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
-					ret);
+				dev_err_ratelimited(tqspi->dev,
+						    "QSPI Transfer failed with timeout\n");
 				if (tqspi->is_curr_dma_xfer &&
 				    (tqspi->cur_direction & DATA_DIR_TX))
 					dmaengine_terminate_all
-- 
2.39.5


