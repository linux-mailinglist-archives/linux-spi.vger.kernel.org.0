Return-Path: <linux-spi+bounces-1946-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32165881CD0
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 08:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF91B1F21C23
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 07:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794251C44;
	Thu, 21 Mar 2024 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="auebVsGK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B974F8BC
	for <linux-spi@vger.kernel.org>; Thu, 21 Mar 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711005382; cv=none; b=lNW2TLmYpY06FcnK6JuwmQWm+zxwIDWbTexXS91PBE85KvTH9d7qBJxyiNYcVQPE2cHSkw13ZOzCUMU9kHqhST87eKWce9q84mgEb1Mf3wrn+edJUeFTz9Cce45oembmAs25ufZdz/8868965NRUC2JzmMrLp1CUmpgER0fTN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711005382; c=relaxed/simple;
	bh=uNiHv/0x28H2TbSD8m20i2P9eIK+XRcz2b97ymNsEbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nd+Pi3Ku8yeVulJ4ShZftXXAEMl+MOekjZaV0U9JBNCvpSpO8Az44sZw/SGjFzmSWiz1eDeM/svBTOnANjyoHHh6JBad2FCM8GPv1mU4BrkJbJKDz77lr3VRYNEHHwCHfRgKeL8z2QyAR3suqtaGA/eBcsjlBTxm6BfxWULVdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=auebVsGK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-789e2bf854dso43904185a.3
        for <linux-spi@vger.kernel.org>; Thu, 21 Mar 2024 00:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711005379; x=1711610179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci7BHkTK1iOIEG1KH5AhFPZm3PHh1Xr8+22AEHjA27s=;
        b=auebVsGKlhADNNBog6kvU5IqHNguvIHtu3ZL46WY5ooQz9Vhvto43vbDirWmvrQOdm
         tqXz49mqOHTqybWcyAMEsKQrm9JCPOFYwrfsTDf1BELr89FvIWo80bIRXLjGs9eNc57G
         gElyWAm4vnNG7QAcPll7iSKayTzARDlavbsNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711005379; x=1711610179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ci7BHkTK1iOIEG1KH5AhFPZm3PHh1Xr8+22AEHjA27s=;
        b=UMKGQXzBp1PUwCeCE2JWHzxRxmkCRp2V5LORlclYWYBfpDYzw/B+7+H+CJAr0rkwxy
         dYxJ5UAzRqHHOPJWG05Uog0Zxdmnp9itPPVkoFYWaI0YTLWMdtN526NEhkc0NfmK3LMZ
         sWlmvWCCo2Y6lKEzciJSRm1UAkVRIAmWAvBr4bvE1EvzkacwaEn23S8KbtzlJvr7dn++
         B39FyuV+6Yz/fFXKU7xXWzPmnYaKmWOGz4EZWLEs5Q0+wmkRyRTb7bdLMIunXuWm19sK
         kr2M59OVDZED1m04+VGsyR1BIekRro11yPha4x0iqsXu55pTmH/ufSiXMc+dhIAiE7aB
         nSJA==
X-Forwarded-Encrypted: i=1; AJvYcCUrivgZ9p6GIT6eEBSZXFrxwIdpqgJhzOfygUlRNK1YcuKW/ms8ohCcDvXwcJWTCF6vM6IA64By3AYLOGmn+yQLJ9aC6m1T80Rg
X-Gm-Message-State: AOJu0Yy0Iaa7Z7mWrFa5m/KwnpxpQ7sSk0etbqLggHKlPGM3ocBCpyFz
	UwjXk1DuIsNA3jBeIj/nbGUOoZeSJJCHPCSdlHiJH738hJZwziY2VQCb3uI6yE5y8BCG2uHwoNI
	H8w==
X-Google-Smtp-Source: AGHT+IEjYPnHZWGzrzuctWTDZl3/WbtAl14yb32XRq028RUvicCO/g54v3a+VeurCXvyrMfQTJ0ZCw==
X-Received: by 2002:a05:6a20:6716:b0:1a3:6378:1e8f with SMTP id q22-20020a056a20671600b001a363781e8fmr7149948pzh.32.1711004990595;
        Thu, 21 Mar 2024 00:09:50 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:c1ff:a4cf:ac35:8df6])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902d4c100b001dbcfb4766csm8705582plg.226.2024.03.21.00.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:09:50 -0700 (PDT)
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
Subject: [PATCH v2 1/2] spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
Date: Thu, 21 Mar 2024 15:08:57 +0800
Message-ID: <20240321070942.1587146-2-fshao@chromium.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240321070942.1587146-1-fshao@chromium.org>
References: <20240321070942.1587146-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TX buffer in spi_transfer can be a NULL pointer, so the interrupt
handler may end up writing to the invalid memory and cause crashes.

Add a check to trans->tx_buf before using it.

Fixes: 1ce24864bff4 ("spi: mediatek: Only do dma for 4-byte aligned buffers")
Signed-off-by: Fei Shao <fshao@chromium.org>
---

Changes in v2:
- Restore a missing curly brace being dropped during rebase
- Fix a typo in commit message (trans, not xfer)

 drivers/spi/spi-mt65xx.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 8d4633b353ee..e4cb22fe0075 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -788,17 +788,19 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
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
+			}
 		}
 
 		mtk_spi_enable_transfer(host);
-- 
2.44.0.396.g6e790dbe36-goog


