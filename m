Return-Path: <linux-spi+bounces-7696-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2787DA95BB0
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7086A189880B
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6E4266576;
	Tue, 22 Apr 2025 02:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBJCaD2j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E02266560;
	Tue, 22 Apr 2025 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288298; cv=none; b=b1di9eUYQrntxFPhPKlOx6EQv+ektdfL5UEdxH/DmuStscUnFx6K74ZxL7pYepQgxis/G3YsXiQPGHP/Hftv/hxGOoRTbDon/TIMMjAJPpvuOElTIIWOiodko4bukmFp5+h4LCVbbQUlHfSmOSGKw/7+5QVR3M9pJAaSifX/vTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288298; c=relaxed/simple;
	bh=9uazoyFqsM6WIRaJ7Rumjk3pKpSteA8qtxCrmQAKA28=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDzb2NiqLvs63FguCxjtzeXAN5QveZtNdz3uKQmZua+hJFFPGvvn9AHZkXVTvGSIgwGvxX1ubXi+7LPIYBfcPNrdiu5Tq4Y1eSDhDZQVr9sUSERBateceziPcPl5MS0jBe7eiFnprRy318+tIS+B5iODqTB0Ej1xyt5MvGIfSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBJCaD2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C4EC4CEEF;
	Tue, 22 Apr 2025 02:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288295;
	bh=9uazoyFqsM6WIRaJ7Rumjk3pKpSteA8qtxCrmQAKA28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBJCaD2jlCBYvxGagtZoN3rhAD0H1Z5Aihgl03+DesQkFQ/Til/kuV/79GH7moC24
	 hMF+02t+SHUr4L2/3zri9hqoF81htgcbt37T7M5RLd7zQIX2HI/LtPCRw59OAleayp
	 g115kf23voOSu+DJ85uCqq4ARP1QVwFjIy9PtSK6fDhmO4qKWyOsM2AbkJZsyRdvGO
	 PnXnJhHDGcN7LpTWW12JXmTQC4fofu6FLWU14Yb6JxbI4FYXCal/DWRTWLuFCU5maO
	 tOpygZTmKl+ak6MR3toxXPKkgwu6Zu2COC6veDtJXcoHI6tocJ4cd3fLObUzD/y32V
	 6gsZh66HrBdHQ==
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
Subject: [PATCH AUTOSEL 6.6 09/15] spi: tegra210-quad: add rate limiting and simplify timeout error message
Date: Mon, 21 Apr 2025 22:17:53 -0400
Message-Id: <20250422021759.1941570-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021759.1941570-1-sashal@kernel.org>
References: <20250422021759.1941570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
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
index 2abb54f9a9ba4..e3c236025a7b3 100644
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


