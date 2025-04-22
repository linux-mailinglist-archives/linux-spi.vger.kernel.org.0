Return-Path: <linux-spi+bounces-7698-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2780DA95BD4
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AA1188A728
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC678269D17;
	Tue, 22 Apr 2025 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K50tQ4MD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A181F8670;
	Tue, 22 Apr 2025 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288317; cv=none; b=M3qjZymtM3BXXA3yDqIBrKyZuVLH/Zc37jRWUmf8VLmukR53t4hjutgMfjTw9BceQ/sPkcZY5Y6egU1XSJEsScuLOI/VkTJQoudpAiRC1srfHMKd/MWZTZrPeA5XZYZaJTN9yHhJklRQfsBHa0ULIfaohyHjOe7ml7+y2jf8LeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288317; c=relaxed/simple;
	bh=fEyElH5CWz/jaPQ+DohMsrcJKtFVzmbpvJpcce5oHps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UO7ewZpRyyCP/gIvFCDha2NGRWh7/6Rkz7nQ5jXzrSewPWASb2AntKGLA3uzzjCf6Vu0kRUsISW+thhRm0m9MfCq8DBbkJeGcIvV59LxlGbD9pvrvdTzvG2iTOG0IGIaHxe5dJyrzXCpLq8wlUFLR1XNnzb64dj7z6A8gomTyFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K50tQ4MD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF51C4CEEC;
	Tue, 22 Apr 2025 02:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288317;
	bh=fEyElH5CWz/jaPQ+DohMsrcJKtFVzmbpvJpcce5oHps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K50tQ4MDiuVZCakZxN4cpqZgBtKqbn5/pnmTAIxrlahEDgGVLSyucnyysP1z6DY4x
	 1QbUlVuceG002zD4wKvNa+po590ylk66jGD7VibQCTNdV7yizkAfrfqzoemwe2W78S
	 48sR7nlXcvJdPJ3n6Mfm3uv/Ilm5i7DCZgZ5RFtHi4EJ2bxHItyLE/M5zc2p0lQ/3i
	 frbD7tLFrunaGc1w2FCkQoZIf/xCJSgm7vjKaF+Pr2AATN0iPpFAwicFXos4ZhZdDt
	 tNg6nHeWnUwKDoAgVeCZVGWm+yEULk2lyg2Zvf/blUNMNkAXQLIZQzcBpW/tb2XOZc
	 c0VsA13Ln9vRg==
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
Subject: [PATCH AUTOSEL 6.1 06/12] spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
Date: Mon, 21 Apr 2025 22:18:20 -0400
Message-Id: <20250422021826.1941778-6-sashal@kernel.org>
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
index 5ac5cb885552b..97f3a4d3c31a9 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1110,7 +1110,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					(&tqspi->xfer_completion,
 					QSPI_DMA_TIMEOUT);
 
-			if (WARN_ON(ret == 0)) {
+			if (WARN_ON_ONCE(ret == 0)) {
 				dev_err(tqspi->dev, "QSPI Transfer failed with timeout: %d\n",
 					ret);
 				if (tqspi->is_curr_dma_xfer &&
-- 
2.39.5


