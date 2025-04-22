Return-Path: <linux-spi+bounces-7689-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA605A95B27
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD9016FB1A
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344C92367C6;
	Tue, 22 Apr 2025 02:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNx5+pFR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D472367B8;
	Tue, 22 Apr 2025 02:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288183; cv=none; b=ErBwObDg7mdzFcfThGNC7fJHgCRLeNgBJ5maH42nWl6aaCaz04uEDUSYn5EUKjhh2r7KB2ZGL6E5fYzdYtabdFMFu0rP/EgvXNpWROU9U2I5IQPiTpsipWpwbiYgNWmxV4JbjLRa7kwZd/Gf0xCyKcKZh8XnnrRx46xjGrJ8ohQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288183; c=relaxed/simple;
	bh=Dt0yFF5R3hBKBjCcKd/RCEn3N9BrfwIh7OIkUIo0ZcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OSoCRsdMvbTSVc5dnFIKSbL02kfemuV1oQZdc5lIP9oiqzaPeYDT1aCfZ5p8vtvwdzOCJ0MrzYo66RIvCAIbkqKVAPOvTe0fLfJepsM+oVxH0MhhUffc79+9Tcw/Co8Hsovs417H5MZvK4t38SM3LuTPiDuaQnK0+l0o9lGzBiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNx5+pFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3330BC4CEE4;
	Tue, 22 Apr 2025 02:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288182;
	bh=Dt0yFF5R3hBKBjCcKd/RCEn3N9BrfwIh7OIkUIo0ZcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rNx5+pFRgKnAe9i+aHqdsDrkmjy6Pjbka57wCT9Bg05wrLXjGgJoWD0rz6CPNoxYC
	 oeREHhn6K5LgsaObOU733ntfvWcbPAu24+lRWXlUUQ9BGL3wt3+qLThyvpWE+SH7rD
	 8XABlvJoZTMj1N6p0+B9joOfpf1JDk5cOZTbxVijwyPIi7zKKtf64jaw/v2FRzJ4HO
	 vmKtymufKzQQg9vBwB60vStkX1x6rs/Bt9q6VVqglIQj+R7LrwHe3mSScohE6mrger
	 N3x7uOh+MEBArWnqIh9VSS0s38BS9pfEUzfR9HTv+YuIVAJFIFiJljN2Xx86c6H0TP
	 lCq2av2vEca1w==
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
Subject: [PATCH AUTOSEL 6.14 17/30] spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
Date: Mon, 21 Apr 2025 22:15:37 -0400
Message-Id: <20250422021550.1940809-17-sashal@kernel.org>
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

[ Upstream commit 41c721fc093938745d116c3a21326a0ee03bb491 ]

Some machines with tegra_qspi_combined_seq_xfer hardware issues generate
excessive kernel warnings, severely polluting the logs:

    dmesg | grep -i "WARNING:.*tegra_qspi_transfer_one_message" | wc -l
    94451

This patch replaces WARN_ON with WARN_ON_ONCE for timeout conditions to
reduce log spam. The subsequent error message still prints on each
occurrence, providing sufficient information about the failure, while
the stack trace is only needed once for debugging purposes.

Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20250401-tegra-v2-1-126c293ec047@debian.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra210-quad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 08e49a8768943..2d320fbb8875f 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1117,7 +1117,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					(&tqspi->xfer_completion,
 					QSPI_DMA_TIMEOUT);
 
-			if (WARN_ON(ret == 0)) {
+			if (WARN_ON_ONCE(ret == 0)) {
 				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
 					ret);
 				if (tqspi->is_curr_dma_xfer &&
-- 
2.39.5


