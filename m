Return-Path: <linux-spi+bounces-7692-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C21A95B78
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C48A17A7416
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F325DB06;
	Tue, 22 Apr 2025 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZpIhkhC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7E1E1E1E;
	Tue, 22 Apr 2025 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288248; cv=none; b=WNKZOSysW9DPTYqRUKW/2ZYKQMtQDwsoksdgA11RX+8At+tpdlrbH2pR4JvDlSSmhL+TF9gxkX/m8jljVMTGEgJak3hmDblZMpxpiwUmvZCFPUX8/W5LYVgb8v9kKtYAqfrKwQXUX5u4pqglF+JuQY8fVKd3tcFR7N8mfgMjWgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288248; c=relaxed/simple;
	bh=KCl57RBMDK9igtHkN33OfUjFQNpf4Lm/CRk5m1O8niE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=miz8q7W9qPNL5aWLgIpjlINaD3eV2Mn7+AQ4m+b7T87x0v1+1Ujjbb5TxFAs7NpflNQs1dGAl/rn8DMZm+3WhZyZ182I8Ms3hE+63AWKkXtnj/CTLUneHZuF3C9+BQ0cRvjSheHLrs/hEUWzVMCcBipfZDaLEX+4PTAVYIBGWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZpIhkhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A913C4CEEE;
	Tue, 22 Apr 2025 02:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288247;
	bh=KCl57RBMDK9igtHkN33OfUjFQNpf4Lm/CRk5m1O8niE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KZpIhkhC6cO7PoaY2RrhqJR7sa8FrphgNlPo+wtVN2ZBNPvN+tVA5TPMwhzwaUG4K
	 0w4a1GE1VRmN5b1lMxdDkXVqvKia+BOaKj6SBKb5IKQw5HNHqF7NepULjbtYKt+tz7
	 8SSGg5gc7s1gE84kwhH4XDupCq1bBPCMCTsvd/o4l68vxMLPuNCDU7PssCLkH126M4
	 f2551BYWosejZo/h358PTGrOd4Lr/KePLuoee0RfprvRQYY1zvc5sMTmGtPmt5HR6b
	 SnRzi5ZqDhSJV3Buck/6hsHrrpllbPaPz1RhIWBcJVjlHr6Yhw1vn7jttuc+ROQ7Mk
	 CndIP6ML5/iCw==
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
Subject: [PATCH AUTOSEL 6.12 14/23] spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
Date: Mon, 21 Apr 2025 22:16:54 -0400
Message-Id: <20250422021703.1941244-14-sashal@kernel.org>
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
index 43f11b0e9e765..94dc4cbc40e15 100644
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


