Return-Path: <linux-spi+bounces-2586-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708608B5699
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 13:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0392854DE
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 11:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A864EB22;
	Mon, 29 Apr 2024 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="CC8HVkPf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828C46453
	for <linux-spi@vger.kernel.org>; Mon, 29 Apr 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390137; cv=none; b=NmVYl2TapAsxX4h1CXd0RAp77qieHMJ0czwaVZdRfxDTk+HqQa61RV/Foxa4zPiCMif36tR8ZwwX9D7tEIS7kzd+AAnX8xRe8lP8rbix5bPvn0AJJ4czwPYIxpsu38kGWySaHDG4ZVB2LpWvsYH0VpY6rhVAnVbr/M4rnt+wptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390137; c=relaxed/simple;
	bh=Xsyv5SDNkoLgH9URuS3zIADXYIorPsuiL3ykMXINUvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wh87yUKX5/3safRaO2XQpgA/VoSfaV4WeGgVKzW5L0jBZFdqC7aRDhSy5ioXvaCSPe/M2hxGQgd22mkfk5AQg40PJPA6v40vIpPpIygyyPoX6QNYM+y6OPBFXqI36INZVk4okYisn6cyBQU8EF1JFziSwBlkCtztUDodS9JDtMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=CC8HVkPf; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=7uNA3296SSZr7aZkz7ZdUhN4Qf0isSkwCYvTIcIHIv8=; b=CC8HVk
	PfDiXBD6JGqzCl/GFyo9GTZfjDKVejx1LSIaI+5AsreC5+T+yH0CZ2wWt8j5eI3y
	8P81reUjJ00HeO/33tGlMJBGcriHmvyUxGqVPFIeh3JjngRZ4zMyateJQELR4mmH
	yiOM+RJhdsmdg6OBeQnRHqKxdhcCEfoJ8QBk5J8av+FZLBm6ZFxyAFtILyLsA9Mb
	l2Wyki0pHaRl7Y0apLZGS5a0rlwks0LoBkMCEVjjrjcDgX+BQtLzZCgkYqxC+VV1
	R4B4LpySmiMxpKH/RGP4QYaa4GsgEN2VX7604QsEt685XwuvHWlArROFXQkHNPSa
	qZOVNSrG47cXVNXQ==
Received: (qmail 2279577 invoked from network); 29 Apr 2024 13:28:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:28:47 +0200
X-UD-Smtp-Session: l3s3148p1@aCKGjjoXGlBtKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] spi: imx: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 13:28:36 +0200
Message-ID: <20240429112843.67628-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
References: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
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


