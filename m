Return-Path: <linux-spi+bounces-1940-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3415D881C93
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 07:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E091C20D89
	for <lists+linux-spi@lfdr.de>; Thu, 21 Mar 2024 06:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198954AED6;
	Thu, 21 Mar 2024 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OGJKOYuB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC247A76
	for <linux-spi@vger.kernel.org>; Thu, 21 Mar 2024 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003414; cv=none; b=UuxpkrKqkTCV+I43g74QV2v1nGM4u9WeToptwyTanC46jzXwJr9J4AUeHD7Dlcp9kgSN12dpaiQdNeZ4+upVi6vbQJgY9mIEVX7LWNy4Or55ymzoIteo0b1deuiRDF5zViCy22hsUuNqL7Jlt+e8gbSEPynnsHyyYBudfFuEY8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003414; c=relaxed/simple;
	bh=2r9XByB3vYDZKrvWS7vNR+6OZXVhNEmiyzpGd2OOabA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROFrT5Vlxrrmqk4bREVGO3pvchtg5CFc7/WutqbGX+ijP7GIKvxImQ6nve31Dq7kz80qPTd2AQjS21hPGKry8BOydCJLETlP1c/f77GISgDWhrCJaxih+rr2imTCgCcwVDf/HiqXDwBveA87No5OThUqnUpBKPaCOjeKhL5uXTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OGJKOYuB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e8f76f18d3so558177b3a.0
        for <linux-spi@vger.kernel.org>; Wed, 20 Mar 2024 23:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711003412; x=1711608212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZAfwv86coCz5ya7gMWl0Ox3qdQ9eNNNMvWYUUmsfUA=;
        b=OGJKOYuBz2Xa7XxplTPF4Xwaa1B1RqoKy4sXK0W/dQa6WEBp2+JTMpXk2x/QElkDqb
         ljYje0K5u8O3NL+/I/ebqXr9tzYiDgNTa3rPErQTGbLDLQWGHOFh2irm0zrLZiOBmuNq
         dICHxMXu6IFMGP25DDF7+yyr/WCOklVTp+xQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711003412; x=1711608212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZAfwv86coCz5ya7gMWl0Ox3qdQ9eNNNMvWYUUmsfUA=;
        b=WFJ2QnrrhPzrzU1kQ0hdQaWI6ToafjYb8vCA6w3511rXswbIM8luH19lwusDqLHdjA
         E9/W+mELGGW6UyPNiAjNNscpJbuPhpV06boX3+lKzZfTD4Lexf0CRcIRDYm2zEV7/QOz
         75CDRbelhs5KQSkAkSJKg7EgorRqq5ME0nnBT7KHTcvQLOUKfpASrpIOeLnNuIE93uI/
         hb83fJV+VH6NHgr9dnyuVYgD0AL1yde4ERfiTKAOe1yS9uMz3UgoJOWDuBJjh77t1Oyv
         DsbbFPC4UnzdbYl49JNdvFxbxkV83C9KKyVQ1BkJRBaUW7njTjrna7hvn13AC9/NcCWW
         AA8A==
X-Forwarded-Encrypted: i=1; AJvYcCXMOPFozgxQ5q+oAiKru9S5mKh0iYWAePqrix5I99fhNLKwGP2ubOJmGVPohEsExt7Wg/MrqkCOTdXj2V6mSnWbbpeSNnbFttM9
X-Gm-Message-State: AOJu0Yw8zFZ0wf3cEqpDslTrqnF69I+UvzB3jSn/XpvP8FysA8mgVtXV
	tSa71idcoTz0tgzt2Sj2KqHqWT+JtY3O1Cm0pdWjvolcTP6uBYrqkZNfC2L5SJafWIaoTE7fvyQ
	=
X-Google-Smtp-Source: AGHT+IHJ7XBfPwZHrNtWiP2YqVZanIquFTWV/V+ARNJsur65k8HYfqQbCwDBftzvaRVLDOior2pzIg==
X-Received: by 2002:a05:6a00:2d1e:b0:6e6:c73b:bec2 with SMTP id fa30-20020a056a002d1e00b006e6c73bbec2mr2482638pfb.14.1711003411802;
        Wed, 20 Mar 2024 23:43:31 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:c1ff:a4cf:ac35:8df6])
        by smtp.gmail.com with ESMTPSA id lb3-20020a056a004f0300b006e664031f10sm12874938pfb.51.2024.03.20.23.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 23:43:31 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Fei Shao <fshao@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH 2/2] spi: spi-mt65xx: Rename a variable in interrupt handler
Date: Thu, 21 Mar 2024 14:41:02 +0800
Message-ID: <20240321064313.1385316-3-fshao@chromium.org>
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

All the spi_transfer variables in this file use the name "xfer" except
the one in mtk_spi_interrupt(). Align the naming for consistency and
easier searching.

While at it, reformat one memcpy() usage since the coding style allows
100 column lines today.

This commit has no functional change.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/spi/spi-mt65xx.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 86ea822c942b..aaa0006a02a3 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -748,7 +748,7 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	u32 cmd, reg_val, cnt, remainder, len;
 	struct spi_controller *host = dev_id;
 	struct mtk_spi *mdata = spi_controller_get_devdata(host);
-	struct spi_transfer *trans = mdata->cur_transfer;
+	struct spi_transfer *xfer = mdata->cur_transfer;
 
 	reg_val = readl(mdata->base + SPI_STATUS0_REG);
 	if (reg_val & MTK_SPI_PAUSE_INT_STATUS)
@@ -762,42 +762,40 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	if (!host->can_dma(host, NULL, trans)) {
-		if (trans->rx_buf) {
+	if (!host->can_dma(host, NULL, xfer)) {
+		if (xfer->rx_buf) {
 			cnt = mdata->xfer_len / 4;
 			ioread32_rep(mdata->base + SPI_RX_DATA_REG,
-				     trans->rx_buf + mdata->num_xfered, cnt);
+				     xfer->rx_buf + mdata->num_xfered, cnt);
 			remainder = mdata->xfer_len % 4;
 			if (remainder > 0) {
 				reg_val = readl(mdata->base + SPI_RX_DATA_REG);
-				memcpy(trans->rx_buf +
-					mdata->num_xfered +
-					(cnt * 4),
+				memcpy(xfer->rx_buf + (cnt * 4) + mdata->num_xfered,
 					&reg_val,
 					remainder);
 			}
 		}
 
 		mdata->num_xfered += mdata->xfer_len;
-		if (mdata->num_xfered == trans->len) {
+		if (mdata->num_xfered == xfer->len) {
 			spi_finalize_current_transfer(host);
 			return IRQ_HANDLED;
 		}
 
-		len = trans->len - mdata->num_xfered;
+		len = xfer->len - mdata->num_xfered;
 		mdata->xfer_len = min(MTK_SPI_MAX_FIFO_SIZE, len);
 		mtk_spi_setup_packet(host);
 
-		if (trans->tx_buf) {
+		if (xfer->tx_buf) {
 			cnt = mdata->xfer_len / 4;
 			iowrite32_rep(mdata->base + SPI_TX_DATA_REG,
-					trans->tx_buf + mdata->num_xfered, cnt);
+					xfer->tx_buf + mdata->num_xfered, cnt);
 
 			remainder = mdata->xfer_len % 4;
 			if (remainder > 0) {
 				reg_val = 0;
 				memcpy(&reg_val,
-					trans->tx_buf + (cnt * 4) + mdata->num_xfered,
+					xfer->tx_buf + (cnt * 4) + mdata->num_xfered,
 					remainder);
 				writel(reg_val, mdata->base + SPI_TX_DATA_REG);
 		}
@@ -808,21 +806,21 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 	}
 
 	if (mdata->tx_sgl)
-		trans->tx_dma += mdata->xfer_len;
+		xfer->tx_dma += mdata->xfer_len;
 	if (mdata->rx_sgl)
-		trans->rx_dma += mdata->xfer_len;
+		xfer->rx_dma += mdata->xfer_len;
 
 	if (mdata->tx_sgl && (mdata->tx_sgl_len == 0)) {
 		mdata->tx_sgl = sg_next(mdata->tx_sgl);
 		if (mdata->tx_sgl) {
-			trans->tx_dma = sg_dma_address(mdata->tx_sgl);
+			xfer->tx_dma = sg_dma_address(mdata->tx_sgl);
 			mdata->tx_sgl_len = sg_dma_len(mdata->tx_sgl);
 		}
 	}
 	if (mdata->rx_sgl && (mdata->rx_sgl_len == 0)) {
 		mdata->rx_sgl = sg_next(mdata->rx_sgl);
 		if (mdata->rx_sgl) {
-			trans->rx_dma = sg_dma_address(mdata->rx_sgl);
+			xfer->rx_dma = sg_dma_address(mdata->rx_sgl);
 			mdata->rx_sgl_len = sg_dma_len(mdata->rx_sgl);
 		}
 	}
@@ -840,7 +838,7 @@ static irqreturn_t mtk_spi_interrupt(int irq, void *dev_id)
 
 	mtk_spi_update_mdata_len(host);
 	mtk_spi_setup_packet(host);
-	mtk_spi_setup_dma_addr(host, trans);
+	mtk_spi_setup_dma_addr(host, xfer);
 	mtk_spi_enable_transfer(host);
 
 	return IRQ_HANDLED;
-- 
2.44.0.396.g6e790dbe36-goog


