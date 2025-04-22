Return-Path: <linux-spi+bounces-7690-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A9BA95B28
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 318D67A7A35
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD058238C35;
	Tue, 22 Apr 2025 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDJ96sgs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99675238C23;
	Tue, 22 Apr 2025 02:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288184; cv=none; b=bISENubuEZR8VcdiMvChFXCNdSI4AI3ulIJMMWUqVq6QtXqa32bODMfS/OAJDDEX2Et7eid8KWuRW2HG/C9HL3d8NuYwzQqBHjBBqxiWxYYYmP6fm3KEPGYzCLmcm/kEEnr9W/9vc2ONK6S+s9KJTOFrCaMNzIbVgJyN6IdhGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288184; c=relaxed/simple;
	bh=UPrDyQID6F8h+onlGwPnL3LgJjG8VeeZEGJEesqZs9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0nNpDZEX/hXiEDayhbicQya7zUa/nutSh1SoRz4Ytjo+j79M51PMHYW+5yYfx3i0Iomecm6Cy2/Z0aAeKj78OYeIYjCGMpetoGbKRH1VNWuOuyrwLbnjYXXisVXhJTRu5qh088GdLHVGFSzCWsWT3MDbAbNwNZW2hcWiWwkYIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDJ96sgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3BCC4CEED;
	Tue, 22 Apr 2025 02:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288184;
	bh=UPrDyQID6F8h+onlGwPnL3LgJjG8VeeZEGJEesqZs9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BDJ96sgs91vV4bBQhWwhJ3dA2vekNuVEexh9k8bgPxYr/isWiffiVLV0OCJ6PSpTf
	 hlQ67afN5XK4PwDaK9PWDWs6kHRRRMuEaoSwBiOEyEHv405mMhDRm7eNxu74MMH178
	 8a4bsLiPGfBe1dlc6c9ys6ba5r+vTghM4wZi+Q5NI4dGschNHU1gcbIX/kThBx7oc3
	 E4KwuFGmxxQ816MtqSURaVHX6TCmDPePYxVp9WBCCrp530PE9It9VARclNpg3eELK0
	 wqg+mFtQe4GYDoXxJzZJKvsMU3a7ZfbigZl54EImppa0jCYY+BgWHnoSHeDwRK+aXN
	 zfl9bJGj0PO0g==
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
Subject: [PATCH AUTOSEL 6.14 18/30] spi: tegra210-quad: add rate limiting and simplify timeout error message
Date: Mon, 21 Apr 2025 22:15:38 -0400
Message-Id: <20250422021550.1940809-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
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
index 2d320fbb8875f..64e1b2f8a0001 100644
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


