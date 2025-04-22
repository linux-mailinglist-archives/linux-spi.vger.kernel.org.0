Return-Path: <linux-spi+bounces-7695-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343B2A95BA6
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 04:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFA6C7A2FD6
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 02:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064ED26561B;
	Tue, 22 Apr 2025 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGmG2dPs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E819F127;
	Tue, 22 Apr 2025 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288296; cv=none; b=T87AK2uCMhB9QeDtOiMTf0UNw8mFkL1SXLFs3HRXkLPnzDp2+kyphh30Y6L1EJciZ6w3mt2CSmdSKf+E1ERQzrqZ5JEA9gpCdGypmzJQ2CCv7OL6AItpqAowxQdUSNQao60cuej/WF/2+itJc+KrLWjzEyRS91Y06jv0Ops6RLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288296; c=relaxed/simple;
	bh=5K95LW8mhqTp8nfAUwGhOA144++w+oMsLcVdAirNAac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I4Iq//4QhpCLiQ+oOqD/9G97TByAkDKkvxoOyDEd21DOtX7odC6QMwxaAfAa8TU777+Q4WueH2LE9BdjbrLZZXO35hu3TDBsFhYEMX1sND63w3JJBUmIn9tElDO7cRxeRu+zLw1pGsiLB1zLhnJSa2EvvUzfegxqf3qh9G6Yzws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGmG2dPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF72C4CEEC;
	Tue, 22 Apr 2025 02:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288294;
	bh=5K95LW8mhqTp8nfAUwGhOA144++w+oMsLcVdAirNAac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGmG2dPsfaz1S0iVhxrQHqOGoRlPAC1mIhsDG1XsEj47w7bjTx3wFhfSOXdz3DWU2
	 TwsBLmCXbezLMzebjy9vh0Lk3ZMHV+EpmKY+TzJfg1NPsOCDjyle7uAyIAnBnY80ge
	 vBZRebDfww6SeZ9bKHCUb/hia516eGXhXkPUX89wVLVqYQbMsYDL5QwGI9ZUL5ws31
	 h7uDBDm3uD/ynXwbIjRJJuaCfCboBg9f8spaIb0pFnEiAq8MMmausVfxEv2zMZUL6s
	 JAs2ScaebEisjRx/MITKZ5FCXmv5F1h5nLpIbewS5lbX/Tz75QJVBtUle7E7hWA7Ol
	 UCzRdWB5lFgAw==
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
Subject: [PATCH AUTOSEL 6.6 08/15] spi: tegra210-quad: use WARN_ON_ONCE instead of WARN_ON for timeouts
Date: Mon, 21 Apr 2025 22:17:52 -0400
Message-Id: <20250422021759.1941570-8-sashal@kernel.org>
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
index d1afa4140e8a2..2abb54f9a9ba4 100644
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


