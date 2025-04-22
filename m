Return-Path: <linux-spi+bounces-7699-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11967A95BD1
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D982162D3B
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606F426A0BA;
	Tue, 22 Apr 2025 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYjeP7gU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0E26A0B1;
	Tue, 22 Apr 2025 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288319; cv=none; b=OcNnhPz1sjtP2mvddIAen3tMxS36Nt8azMSrSL/ml8L4uMiqtRSG1d4WAhito+D96wYPmjKNYSyZYTrt9dqhLwVq+xfWVY1GIbyZ5nfxJ0B0/hE2EWV9Zy2HYjl67YeezReysbgfoh6SEEVw8ylXVkBYu/3bHSFnIqbmXcWW4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288319; c=relaxed/simple;
	bh=3SuNu8D0mD+U18QgEcJYNwSGbP2bAYLuvqR4EsC3Z3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uH6sk4HR9VMWp5u9lQ76I/tYR9D7dJRlZCMGtb4fw/qVou9jidyGMRNVSow4hOjeMXWp8pVpcZXoNVYImDYoxhHGm4Pg8O8twHIRoVjJrzlnWjWNlD6eKwDc9Z0fVeSitnRx/fw1/ZGitcGKUdlUFCWkHeBMhJYrALoCFa0zj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYjeP7gU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AD4C4CEEE;
	Tue, 22 Apr 2025 02:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288318;
	bh=3SuNu8D0mD+U18QgEcJYNwSGbP2bAYLuvqR4EsC3Z3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYjeP7gUUUNYbtPHi8wH0PAD+jRc2fWsWykY57b1pPXrmrauyzYkKlB6x9ohobL3F
	 2phWUtlrKFlRAcLTSSORuoDIj3XUzG14nQP9o1dWDjMH3IAOm2dhQHZxiWzc6YdnPd
	 SHUgXvYHTv99b72JC3A/rk8A8PsmyddGOoZJ7YypC5KKkcHcMNCGFGXDftnL1IQDKa
	 FCKc0Jc+Jh0QtzXyubBPH27YQshNq0j0X/LWnV2wH4SkSaeHXS3Y5a30iFUmUf6MZS
	 F56/usTfrKiUFKn8+SMhqVBwid4lbAurFLEzHb/8TksI2T1jChb6iZf58scEXtKeiX
	 90PS3k1sshkVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ldewangan@nvidia.com,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	skomatineni@nvidia.com,
	linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/12] spi: tegra210-quad: add rate limiting and simplify timeout error message
Date: Mon, 21 Apr 2025 22:18:21 -0400
Message-Id: <20250422021826.1941778-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021826.1941778-1-sashal@kernel.org>
References: <20250422021826.1941778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
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
index 97f3a4d3c31a9..442d42130ec87 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1111,8 +1111,8 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
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


