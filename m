Return-Path: <linux-spi+bounces-1945-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2FF881CC3
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 08:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF0A1C209AF
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 07:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75491381AA;
	Thu, 21 Mar 2024 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W6khe3Gc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC854D9F2
	for <linux-spi@vger.kernel.org>; Thu, 21 Mar 2024 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005196; cv=none; b=Kr12r4plyZpEE2E168hGynlKnyJK2SVZXUEnjM7oiFdvICeTPmm2WZU5j9H9ZgNhLH4TuZab2RbKZWeMmQlly/UtotYLJhBBQeXk7nUoi5PJPo9c/4hwqyuQYPk73xY9ayJJg+KckBUX3K/ah212PkmUaB+AuEmTl+BoCgNNe7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005196; c=relaxed/simple;
	bh=oRcLB9dQPwGzVPKTKr0KY9BPsfc919ssadAASAAgBzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBrAXsdc8B+H/MpSsq2VPRMP1PBOcETLdYSGyk1Ag/EiLCJS2XwHw9pj0QaZd60Dv0GDv1eQhXI1WlMm7LE6hEOmcA1T/gEwQb2J5EDeOxGNClA7IqSeUggbwbuS4j6Z9juLJ1BwhQaYUoDnYN9yGPmdHXGPKssMweahdQWHFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W6khe3Gc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6082eab17so574256b3a.1
        for <linux-spi@vger.kernel.org>; Thu, 21 Mar 2024 00:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711005194; x=1711609994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBiGSHa0oimyE1MM5zUN6LTK3eAVLs8v7Z76nGxN0a8=;
        b=W6khe3GcEEpAKtF+7aL9WtZvUgCdujfbpjF9CqdfPrmwhNDNXCNFO2abunfQeorSug
         vqepET/Wi/YVKHxHFZcz+3HRNH5f5V0X0lxJ2aqPyzYhe689J5iPYWnx/Ehg8vKulUuK
         CvwclaLtZ42oQ0vvOEXDyKEVKuUlnq27rqdFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711005194; x=1711609994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBiGSHa0oimyE1MM5zUN6LTK3eAVLs8v7Z76nGxN0a8=;
        b=JbvTZu+NDy5L6eHP1HSGo6lECIKOk4TrCfwD9JCsjhibROnjNXYYT4zOsLHXNyS1t+
         2NiENjZnMvdutaSbUZWI4D8xvxjFWo2SWrVC36hg9SIqI70cz8H6KnNMUNob5cygdMpL
         0TejYKuRTiexq933I805C/Rvt2wdlV4qQMXyvjdEsRbplTIPHJtCCo6v7P4jtuofPlI+
         RU8J3mmMcOOo7AP6tNKRoWIQas6ZK/7UocqqANPWmLUgvFtECnJ0L8WZ7eMQoD+AWlUG
         okhPGafbe5pu3G0zzqSAT0pCCjsk91e3ooy4QX61ki+1IWxApEPZ1piWNQTxW0qAqV8F
         tx0g==
X-Forwarded-Encrypted: i=1; AJvYcCXLlFjcladRYROlFAHXZm+BfMpRxeIb8NjygjIlqunixVCzEztJcEy1WnffgOPEpLwxqwnebT20fJkygqExN6r473FBgQZvfxgS
X-Gm-Message-State: AOJu0Yw88PM83ItidXgxwxmrWeA7FtQM7wRBbm+AO2zQFSY3+GtiHf6n
	/3KgLcjrZtE1zhm7X3m8hBLZ5XF4XAidRMGjzuDNer2Mwt0/LoyU3VxtKvqdq/NZzpR0TKIUfNl
	V9g==
X-Google-Smtp-Source: AGHT+IEEEIHKCYtjOYJVfRhVwN68KX9lfipwtZ2TMyYDdaLt1ht07nRcowYnTodrhLwxJsrplM2RyQ==
X-Received: by 2002:a05:6a21:a586:b0:1a3:6a4c:80a9 with SMTP id gd6-20020a056a21a58600b001a36a4c80a9mr11624698pzc.1.1711003409539;
        Wed, 20 Mar 2024 23:43:29 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:c1ff:a4cf:ac35:8df6])
        by smtp.gmail.com with ESMTPSA id lb3-20020a056a004f0300b006e664031f10sm12874938pfb.51.2024.03.20.23.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 23:43:29 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Daniel Kurtz <djkurtz@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH 1/2] spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
Date: Thu, 21 Mar 2024 14:41:01 +0800
Message-ID: <20240321064313.1385316-2-fshao@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240321064313.1385316-1-fshao@chromium.org>
References: <20240321064313.1385316-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TX buffer in spi_transfer can be a NULL pointer, so the interrupt
handler may end up writing to the invalid memory and cause crashes.

Add a check to xfer->tx_buf before using it.

Fixes: 1ce24864bff4 ("spi: mediatek: Only do dma for 4-byte aligned buffers")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/spi/spi-mt65xx.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 8d4633b353ee..86ea822c942b 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -788,17 +788,18 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
 		mtk_spi_setup_packet(host);
 
-		cnt = mdata->xfer_len / 4;
-		iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
-				trans->tx_buf + mdata->num_xfered, cnt);
+		if (trans->tx_buf) {
+			cnt = mdata->xfer_len / 4;
+			iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
+					trans->tx_buf + mdata->num_xfered, cnt);
 
-		remainder = mdata->xfer_len % 4;
-		if (remainder > 0) {
-			reg_val = 0;
-			memcpy(&reg_val,
-				trans->tx_buf + (cnt * 4) + mdata->num_xfered,
-				remainder);
-			writel(reg_val, mdata->base + SPI_TX_DATA_REG);
+			remainder = mdata->xfer_len % 4;
+			if (remainder > 0) {
+				reg_val = 0;
+				memcpy(&reg_val,
+					trans->tx_buf + (cnt * 4) + mdata->num_xfered,
+					remainder);
+				writel(reg_val, mdata->base + SPI_TX_DATA_REG);
 		}
 
 		mtk_spi_enable_transfer(host);
-- 
2.44.0.396.g6e790dbe36-goog


