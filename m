Return-Path: <linux-spi+bounces-12432-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7B8D2FC44
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 11:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2DF630517ED
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 10:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9E435C181;
	Fri, 16 Jan 2026 10:42:07 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E133612E7
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768560127; cv=none; b=P4nJXWXfrvp64135awq7jgy7Yb87i6i4rpo3b0FTanHD5ea2NW7SGpiKOTokNJlPM+HJ/TRuu/B6Q2/0nPFclYk6tzUsBfT/YtyWIHM96vzOHC4DTpA2ZO95ac0cTqq/bd+aNBMvQskXLHaMZON99OPtyTFfvAJSJBY0CYvoRZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768560127; c=relaxed/simple;
	bh=khagCyvCtlkZkLZ6tMgMbBbh4jk4K8LYJ0uHpPx08zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSkQixqPfu8FIKigHLIi98/yXGVVCaCIt5seAswkocP9LDpWM12QITZfXVA7Mxo+vd4vIpvHVHOz8rFUfgfSpfg6TIx+u31+gVY2ELsITILg1/LrHHhBdpzSCsjq3XyHc06XxwZvs3Yieoq0NWUK4aRwwJUTwi36GP+em15av2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4041500d9c3so1182153fac.2
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 02:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768560117; x=1769164917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kWP/17hgPXs1aPCeyH6zzzFq2BcuhKEIrKVBaeDul+c=;
        b=K72ot7EcLNzq6yB4bHkk65ilDUSvtFZVXkNXrIbNSNB4+XYigQqNI2UptJAxA/+1AM
         zxnl/90CNCqE1grONRv50Tm672kWfHFxnVOrldMaqzOr2AgwMctEJaKI/vITPX21NlyT
         TNYIxgWjCNXmgaBAqqUu2UB87yzrcfy2c6OUHhiMOyr43bnk6JeV/LKpcM8MWKXOEwV0
         EnNwa3Tj5SUx8xqdvRCfDbhKACzxmqyfjGD4WgjMzIgY+QgkIg1tD5hz2lKp/jH1BES6
         MHo9+VbEP2M7O388igCuXMWm8B2sB2jAnVkdAZK4yfA82LJty04EY33wKqM6rR5eKnBV
         cOrg==
X-Forwarded-Encrypted: i=1; AJvYcCWXLk8MFUgY0IC6ypXpIWR5FgzSzRXNdPgw/B2p63jEDLPFTxczfKhRJC8D8yt9Btqzx1DdgD7YNOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUDmMYJ5i0RCekHzkHOtGCemX5pMl7hee1IOwI4dIsoJq4Qv6
	CBd/r6aioEn3VsuhOdSPCy/a/mphVSDXRj7gz14RQKVg6ix5HOIVb4Rx0NXLwQ==
X-Gm-Gg: AY/fxX6v9aZD8BWWnkyGzmtJF67Kj0hnuEmsI1townFlnmAw1gwCCCEV5VsMN5Duq6V
	q4Hm7x80rXLj2RKWJp8MQaRmTHtq6/kQsMDbO2DTuDs99IQShSjg0XZBOtbFKZX4eH0LfWKELe7
	fqXHppVjcvidna7S99rDh4MC2OvC76sws3YT3LtBgJV41Xn+9TpJTYJcgFNLPjfgDFKQrUGV5Rp
	pnGbYwCCSzLz+kMx9u9k12+fP04FJh8klylCRlFQPTIHQnvzk8LZYW1oPrbwslP69ynphs8E9FL
	zbN+wNxeh5mLW6RsGY+Si6DjW6WnGJ3LbQUo1zZ6irG8v8YBxOpdZN4lRwDQrxnvJmdl+I05ut8
	hht2OZeZum6X30gwxw3vK6Zy5YrtGSTWkYRQVwlSQMvxdY9iB3bSMs3b2OPo9Rb8Ho/G41sAWO1
	77Yg==
X-Received: by 2002:a05:6871:7813:b0:3ec:495a:74f2 with SMTP id 586e51a60fabf-4044c1646d7mr1294805fac.3.1768560117088;
        Fri, 16 Jan 2026 02:41:57 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044baf5402sm1498837fac.4.2026.01.16.02.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 02:41:56 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 16 Jan 2026 02:41:41 -0800
Subject: [PATCH 1/6] spi: tegra210-quad: Return IRQ_HANDLED when timeout
 already processed transfer
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-tegra_xfer-v1-1-02d96c790619@debian.org>
References: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
In-Reply-To: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, puranjay@kernel.org, 
 usamaarif642@gmail.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295; i=leitao@debian.org;
 h=from:subject:message-id; bh=khagCyvCtlkZkLZ6tMgMbBbh4jk4K8LYJ0uHpPx08zA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpahXyAb/i58UaGRiL76BUEpdcuRkwVBGWYlv+W
 lA7tLbrr6uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWoV8gAKCRA1o5Of/Hh3
 bQofEACn9qUAZwrQbBKzcIOJAksw0DvoG4SxaSBDlerjG0lmRbJQSoQPYp2dMSizxEBY2shLfxm
 pNp4M6LxXS4zcdnty36YkkL8Jh14lwjAQ2xgi7TtQQ/SjpnSaiR8cllpfIYstfsXQwXfJYy15sQ
 ueGr+Roc8VzOCXPpfZT35HmBzzbmJTvAqcXcN25p/l/NkxTFTFtkVryEkX16w2ga2CRZwzgduhW
 Zbunji5OdwIprunh/dtmgFa0iGhgUGhR0/5+m96RuzNmwPAyzOOAaN608h4mqRYRht/IUl2gBJZ
 75nX6BecBJ+JACOnkptjhcr4pa3qdMXeQhAuXJu7VAAJG2hZY8d0w8I9lvlE64gAjVMkevYG/DH
 wPa8XmYchMxGkeeI/3aAMm/AYbwxsxf1YJrP0Gc2EeuAF7Lxq4xsL6UnYqbgkGJ/xyrekc/TjW2
 DDP1g2PWWtiBS02Ub4KjGvYX1AdT5FMFlkNwvT4bRT8L3oHDuaMsin9bPXkK17z0Q+FIUT02e5B
 SgFzNsW9+CQUNkLDpt5MEbwAwK9xqBDkf/pmgjl9Tc6eQyk/xqPoY8ZGFZypvzMHij+iH2TGWGq
 OqDj+MJGbpKFrXkNsGHjxl04qhIY/EG7pNEPnT7igiFygbbQY1gziazmd0PMtZkvuBatarJUGu1
 5LxcHUZpR+D0VEg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

When the ISR thread wakes up late and finds that the timeout handler
has already processed the transfer (curr_xfer is NULL), return
IRQ_HANDLED instead of IRQ_NONE.

Use a similar approach to tegra_qspi_handle_timeout() by reading
QSPI_TRANS_STATUS and checking the QSPI_RDY bit to determine if the
hardware actually completed the transfer. If QSPI_RDY is set, the
interrupt was legitimate and triggered by real hardware activity.
The fact that the timeout path handled it first doesn't make it
spurious. Returning IRQ_NONE incorrectly suggests the interrupt
wasn't for this device, which can cause issues with shared interrupt
lines and interrupt accounting.

Fixes: b4e002d8a7ce ("spi: tegra210-quad: Fix timeout handling")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/spi/spi-tegra210-quad.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index cdc3cb7c01f9..f0408c0b4b98 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1552,15 +1552,30 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
+	u32 status;
+
+	/*
+	 * Read transfer status to check if interrupt was triggered by transfer
+	 * completion
+	 */
+	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
 
 	/*
 	 * Occasionally the IRQ thread takes a long time to wake up (usually
 	 * when the CPU that it's running on is excessively busy) and we have
 	 * already reached the timeout before and cleaned up the timed out
 	 * transfer. Avoid any processing in that case and bail out early.
+	 *
+	 * If no transfer is in progress, check if this was a real interrupt
+	 * that the timeout handler already processed, or a spurious one.
 	 */
-	if (!tqspi->curr_xfer)
-		return IRQ_NONE;
+	if (!tqspi->curr_xfer) {
+		/* Spurious interrupt - transfer not ready */
+		if (!(status & QSPI_RDY))
+			return IRQ_NONE;
+		/* Real interrupt, already handled by timeout path */
+		return IRQ_HANDLED;
+	}
 
 	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
 

-- 
2.47.3


