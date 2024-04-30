Return-Path: <linux-spi+bounces-2663-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9888B74AD
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 13:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971B2281FFD
	for <lists+linux-spi@lfdr.de>; Tue, 30 Apr 2024 11:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F44013D29F;
	Tue, 30 Apr 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="DPhBWnSw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B578134412
	for <linux-spi@vger.kernel.org>; Tue, 30 Apr 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477315; cv=none; b=lfRjmH2pMg20KuUwT+qg+6WXdUXMSaKMozYEDmKPOl0+Lvq03SEXwTlzbm7wKDU7LnN6U8DksVt/SOo8bsX3KxR2IGWFqF2afazcbYkaX1rWqzistx9QES3GDF9YtN7qLk/csf/Fd50gbXrOwFi5Y+QVLn+zwzBQap3z16bIyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477315; c=relaxed/simple;
	bh=7N8oVXnRrJHaRlB87ucIG3bZfFi1TLwuECAHCFutGqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhF0RpGhtxS195EG/a11ezSvml7M0oxwCthZa2Q4PwQo278TzMrUoe/7D6O9EjS29dF8rWF1XwvaP6xrhgdWcumxqK8GR9l5vVx4MV6c94fN5DxrmW8mk5CRJ8WKaNKktCMNKDVFGfT7+UsErL+RNcFuLJw/iDJvsl3MOp9hW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=DPhBWnSw; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=MhMUebPiMw4sibwlDImjI5Sk4b/9gqMN+xcox9R2PTQ=; b=DPhBWn
	SwP4ElT8aAcfmD8i/O46HdFj/1oqxGLvQA3vghpf17kG0g3VCZiduJC5Et31yzW2
	CwKUMTxgj/+Ul1QIrBqfxqP+VuHFpMp1Y73Tl0/mcmqtFt86yuoDXF4/YsnrjdPw
	tUbYJkeEQQmeQSFScO9t3hue/B+1Qplo0jB+mms8xKGcdXxM3qIO+j9mFs4Hkmbg
	uzhaYSFy8BfDPXvdyKaGZT4KSaS+g/IggfimF8jeF3GSR4u1CHpOu/fArghxCv5Y
	3kqNxOhoCIVZxJ/G7YhFY4AfAnsFB73S6iBdEKzMmf97LCW1vF88kCE2uMxgYQaF
	Jn+xuU6cqozEok9A==
Received: (qmail 2617838 invoked from network); 30 Apr 2024 13:41:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:41:46 +0200
X-UD-Smtp-Session: l3s3148p1@gR7O2k4XwOhehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peng Fan <peng.fan@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] spi: imx: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue, 30 Apr 2024 13:41:35 +0200
Message-ID: <20240430114142.28551-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
References: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/spi/spi-imx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index c3e5cee18bea..f4006c82f867 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1405,7 +1405,7 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 {
 	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
 	unsigned long transfer_timeout;
-	unsigned long timeout;
+	unsigned long time_left;
 	struct spi_controller *controller = spi_imx->controller;
 	struct sg_table *tx = &transfer->tx_sg, *rx = &transfer->rx_sg;
 	struct scatterlist *last_sg = sg_last(rx->sgl, rx->nents);
@@ -1471,18 +1471,18 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
 
 	/* Wait SDMA to finish the data transfer.*/
-	timeout = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
+	time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
 						transfer_timeout);
-	if (!timeout) {
+	if (!time_left) {
 		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
 		dmaengine_terminate_all(controller->dma_tx);
 		dmaengine_terminate_all(controller->dma_rx);
 		return -ETIMEDOUT;
 	}
 
-	timeout = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
-					      transfer_timeout);
-	if (!timeout) {
+	time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
+						transfer_timeout);
+	if (!time_left) {
 		dev_err(&controller->dev, "I/O Error in DMA RX\n");
 		spi_imx->devtype_data->reset(spi_imx);
 		dmaengine_terminate_all(controller->dma_rx);
@@ -1501,7 +1501,7 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
 	unsigned long transfer_timeout;
-	unsigned long timeout;
+	unsigned long time_left;
 
 	spi_imx->tx_buf = transfer->tx_buf;
 	spi_imx->rx_buf = transfer->rx_buf;
@@ -1517,9 +1517,9 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
 
-	timeout = wait_for_completion_timeout(&spi_imx->xfer_done,
-					      transfer_timeout);
-	if (!timeout) {
+	time_left = wait_for_completion_timeout(&spi_imx->xfer_done,
+						transfer_timeout);
+	if (!time_left) {
 		dev_err(&spi->dev, "I/O Error in PIO\n");
 		spi_imx->devtype_data->reset(spi_imx);
 		return -ETIMEDOUT;
-- 
2.43.0


