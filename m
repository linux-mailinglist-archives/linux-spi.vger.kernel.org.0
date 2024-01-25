Return-Path: <linux-spi+bounces-776-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E93A83C5A8
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 15:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254701F2575B
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364861292D7;
	Thu, 25 Jan 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdnKvbuK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB886AF5
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194233; cv=none; b=oHHafmn2ZI6sLyAd4MUHHsQPx2zO+lT9Ncl5oXIcLV+RqBntyLgauXKO+52RWs+/5CIh2EkxjxzJfHhIx4qeSaE/cZa1QfId4ZIDQ7McskQqkH+MHLx+Je2fhqoPk3lom2firAwcOqyq1lr5s2HLTZ5m7ZyZK7JXUAg8xFDlaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194233; c=relaxed/simple;
	bh=U4kxxxoIs3/ayRfB8zDyK6XoFk+619l1Mat98X/4pcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT9IOP762VcziT5A1kxR/QcahOLun+Odj6iUn0GaOO/HL8pGdg/atXVzq6UItMAn4dkdXWyik3bzZ+ixl+ruiYLubEWGAN3MnXOPTJb/16VWqCtdotrXzQ2HSkcT1o92CsajXbXEdcL5Z1c7ni4U6vQzwnWOSxcIEu8Ns7SNWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vdnKvbuK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so73333305e9.3
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 06:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194228; x=1706799028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vB6EsopWvtU420AL/iiMUAA67gMzrjWCXd94V6Ahudo=;
        b=vdnKvbuK3saMsbm5vqdQdGJBo2nfkm7ftV5HyDZ2ATcnL5EfvhHdqn7TUAiPdG1mzU
         srkkovV2f74WX3thfGJ+Vy1vy3bM+IGaRQo5Bnz3AIiM/UaFLz+GhqdoFcXMK3lILNVR
         SR4EDp+ZRjIRzc7yw8FnT+NzPnihaBP1/Bi1Z+4IywD/a4JnGsEzVnAdks2MNQwjbH8m
         J580kk2g87p57QISih5Euumlr5hmJi9ElrT6pHvzzUF0PSF/KPfUvTFeQ35UIxxI+Hiq
         R8leFv1M/UnsjwsZkKsE3EdrD9RuA8obz5wsGXEL4DHhGPeUCy7TlhuS7/3GQ8OA3Srs
         PFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194228; x=1706799028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vB6EsopWvtU420AL/iiMUAA67gMzrjWCXd94V6Ahudo=;
        b=dMTPj7Y3r4uDy8+QFuPo1+Zg7OuP2RRGxvvkVFmjv/jPSn+SXnmZQ8RAcpGi8nGkRM
         HexWRzMWE1DHqfecq96hK/+QhDJXdX32HNm4dajZ4wG5SAaqWYTG+Yjr5HgoAFkxbxcw
         73uVaxW9fquzb03Kg04hoZMFNImw+vHqRXGCYTpbfHNh24bXUrQJL5qB1x6f50E3CF6Q
         aKZGum9Fgy1Qm37JxsA8Gz5R+wsHWr55kxmGrlcgznutghhhyjv+HXm7MFL2eSjDsLrU
         69H36NRjByJZeKdEAIhNnqLSagdIZ2nszyvG4G9Q4XNXvparVOppVIfctdc84ey0Vqup
         mxAw==
X-Gm-Message-State: AOJu0YwY7UoKub4ayUcCHqjz6qlGxLTIKFFtg7SvJsa4siWMZ1/oLKbL
	oWmGaOhuo3o+cS8UGKqB7tsDDJLOxIEibQGV7JyDrgNgsRI+g88LWyxc5fbBXj4=
X-Google-Smtp-Source: AGHT+IH50gAERtgiD46ap88LMn5K0NCn8Ty3RrpGCSOxNifjs/kTKouYIk3wNzU2y3BB26EWVSG7AQ==
X-Received: by 2002:a05:600c:9:b0:40e:59d2:354d with SMTP id g9-20020a05600c000900b0040e59d2354dmr592880wmc.151.1706194228286;
        Thu, 25 Jan 2024 06:50:28 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:27 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 20/28] spi: s3c64xx: add support for inferring fifosize from the compatible
Date: Thu, 25 Jan 2024 14:49:58 +0000
Message-ID: <20240125145007.748295-21-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IP supports FIFO sizes from 8 to 256 bytes. The SoC that uses the IP
dictates the FIFO depth configuration. Add support for inferring the
FIFO size from the compatible for those SoCs that use the same FIFO
depth across all the instances of the SPI IP. Parsing of a device tree
property to determine the FIFO size for the SoCs that use different FIFO
sizes for different instances of the SPI IP will be added in a further
patch.

The scope of this patch is to break the dependency chain between the
device tree SPI alias, the fifo_lvl_mask value and the FIFO size from
the driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index fc5fffc019e0..5a93ed4125b0 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -132,6 +132,7 @@ struct s3c64xx_spi_dma_data {
  * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
  * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
  * @clk_div: Internal clock divider
+ * @fifosize: size of the FIFO
  * @quirks: Bitmask of known quirks
  * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
  * @clk_from_cmu: True, if the controller does not include a clock mux and
@@ -150,6 +151,7 @@ struct s3c64xx_spi_port_config {
 	int	tx_st_done;
 	int	quirks;
 	int	clk_div;
+	unsigned int fifosize;
 	bool	high_speed;
 	bool	clk_from_cmu;
 	bool	clk_ioclk;
@@ -176,6 +178,7 @@ struct s3c64xx_spi_port_config {
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
  * @port_conf: Local SPI port configuration data
  * @port_id: Port identification number
+ * @fifosize: size of the FIFO
  */
 struct s3c64xx_spi_driver_data {
 	void __iomem                    *regs;
@@ -195,6 +198,7 @@ struct s3c64xx_spi_driver_data {
 	struct s3c64xx_spi_dma_data	tx_dma;
 	const struct s3c64xx_spi_port_config	*port_conf;
 	unsigned int			port_id;
+	unsigned int			fifosize;
 };
 
 static void s3c64xx_flush_fifo(struct s3c64xx_spi_driver_data *sdd)
@@ -404,7 +408,7 @@ static bool s3c64xx_spi_can_dma(struct spi_controller *host,
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
 
 	if (sdd->rx_dma.ch && sdd->tx_dma.ch)
-		return xfer->len > FIFO_DEPTH(sdd);
+		return xfer->len > sdd->fifosize;
 
 	return false;
 }
@@ -702,7 +706,7 @@ static int s3c64xx_spi_transfer_one(struct spi_controller *host,
 				    struct spi_transfer *xfer)
 {
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
-	const unsigned int fifo_len = FIFO_DEPTH(sdd);
+	const unsigned int fifo_len = sdd->fifosize;
 	const void *tx_buf = NULL;
 	void *rx_buf = NULL;
 	int target_len = 0, origin_len = 0;
@@ -1154,6 +1158,11 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		sdd->port_id = pdev->id;
 	}
 
+	if (sdd->port_conf->fifosize)
+		sdd->fifosize = sdd->port_conf->fifosize;
+	else
+		sdd->fifosize = FIFO_DEPTH(sdd);
+
 	sdd->cur_bpw = 8;
 
 	sdd->tx_dma.direction = DMA_MEM_TO_DEV;
@@ -1243,7 +1252,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Targets attached\n",
 					sdd->port_id, host->num_chipselect);
 	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\n",
-					mem_res, FIFO_DEPTH(sdd));
+		mem_res, sdd->fifosize);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
-- 
2.43.0.429.g432eaa2c6b-goog


