Return-Path: <linux-spi+bounces-657-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC459839338
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 16:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A593286930
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jan 2024 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5CB63513;
	Tue, 23 Jan 2024 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6JKfEtJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA463400
	for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024088; cv=none; b=S3tFznlhPmEqImv6+ffxdTsuV6Kg6r/7cvVVmic0O6yqaH2j2vDCxjsxapIuvLKsOdSbAZp1SD0oDTHOCBp1PkX9x86b+b2g7COuwV1HYAAuvGsGseN1n3C5KIA4bgzD7ARMhpUyd3MzYBu013vW3xb68aNTj/IVRfQumTcOAxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024088; c=relaxed/simple;
	bh=pWwRAykQpRRalzIT0R72wBc6eY+RszfUb0T3iGAzvIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHaWt8cqIOtVQIoLH1h2tkLfQTnxyf1lbMQcuFCnPGoyWqnbwxIavAs2hTunOqotMV6d2cwFhp57miFpij9Nmv0XZTGepHZqF2ao6/HFi31zRPK97NL6d/DGik6WxANo1uHag396U51B48yE/K0fux0nu9fwqslKvQH5ZiKHRwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f6JKfEtJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ec34160baso1840045e9.1
        for <linux-spi@vger.kernel.org>; Tue, 23 Jan 2024 07:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706024085; x=1706628885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MwC7JrWaaByRi9Bmg46WpEIcb48Uk9F6chaPlqeYW4=;
        b=f6JKfEtJ8xx+VaZdy/LOdmv+GXvBeZKgdL1ezd+2hDuTYcBBrwdNsqUbHrnFznCjPn
         v83fWcbsO0rxP9AiPS93YaU14SpaE9lPQxL/dDtp8RWkOIRdpovz8Mme5DeLO7AQTG2I
         NJRG2Tk4Pm5bmqd/R62dcDIG0N6GKDJtL5F432PIPtR5f22KHNOc2hjqfLHlWoZWl585
         t8hxqW6cNswuMoQaCCRRYDPN1X6+Nf8wN1EeR7EZdfw5aquT8meMdgyH0cL+8nxT7zNT
         6VgFsI6BJJDFwPPE3KPpfP+G0tsJ8nAPjEE3Qgr1tKmmjDbgUa3PDWpWs0Poe77iNJzA
         10BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024085; x=1706628885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MwC7JrWaaByRi9Bmg46WpEIcb48Uk9F6chaPlqeYW4=;
        b=LNyVPtHh4C9h4zt3CCMWqlSJU/H0naRx5gpiSAe3hglHIHlVyi9A21P5cyqZ8dZtcH
         JSZuZbTxXgxKIWs+z0zIg70J6DYA6Z9TAS1hPrn197MLrkut6QM4JxjzocRn0ZzG2Dp2
         qAuphUmrKSfu9cy355RyR3PQ+oYl6FN8ptebS/DPrt5hW9ZIo+QsR7PzX98Yq7zNqSoR
         MHBwDqphj4kMze4fUDwJBy/MrDDSIvz3aM9arclI0KmTudXYVMnarEeagotmO/0t4Mj+
         Qux3CN3DMGR2NogoAkuQVM8ft+YDYgLER2+3fKpfsPoNAF46vnK8LZFeYtHe7FiPAFCu
         kF1g==
X-Gm-Message-State: AOJu0YwdBMnCCXFveJi4v/r5jDFKVZPlZG4FiPbtBfiQMy807IzhF6wY
	jAoE6y+XmDP7bFaqw4NcmgHjh4v5REstXW1VHGrG2s02beltRP21d3fn+qpahB8=
X-Google-Smtp-Source: AGHT+IH5mkP1CJQ0rWDrIEEhD7IVzjwMWQ7d2wNt7PJY7Y6iegwnmTYm0CFXzpgTor0e3wG3s2U6YA==
X-Received: by 2002:a05:600c:35ca:b0:40e:6163:55f2 with SMTP id r10-20020a05600c35ca00b0040e616355f2mr643207wmq.84.1706024085095;
        Tue, 23 Jan 2024 07:34:45 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0040e3488f16dsm42457536wmq.12.2024.01.23.07.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:34:44 -0800 (PST)
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
Subject: [PATCH 20/21] spi: s3c64xx: make the SPI alias optional for newer SoCs
Date: Tue, 23 Jan 2024 15:34:19 +0000
Message-ID: <20240123153421.715951-21-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240123153421.715951-1-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alias was used to initialize the port_id, which unfortunately is
used for older SoCs to determine the FIFO size from
``s3c64xx_spi_port_config.fifo_lvl_mask``. This is wrong all the way as
we shouldn't make a driver dependable of an alias, or the order of
probe. If multiple FIFO sizes are supported across the SPI IPs, one
shall instead introduce a fifosize device tree property. Make the SPI
alias optional for the newer SoCs and mark the ``port_id`` and
``fifo_lvl_mask`` as deprecated.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index c4ddd2859ba4..9cd64fd3058a 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -128,7 +128,8 @@ struct s3c64xx_spi_dma_data {
 
 /**
  * struct s3c64xx_spi_port_config - SPI Controller hardware info
- * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
+ * @fifo_lvl_mask: [DEPRECATED] Bit-mask for {TX|RX}_FIFO_LVL bits in
+ *                 SPI_STATUS register.
  * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
  * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
  * @clk_div: Internal clock divider
@@ -177,7 +178,7 @@ struct s3c64xx_spi_port_config {
  * @rx_dma: Local receive DMA data (e.g. chan and direction)
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
  * @port_conf: Local SPI port configuartion data
- * @port_id: Port identification number
+ * @port_id: [DEPRECATED] Port identification number
  * @fifosize: size of the FIFO for this port
  */
 struct s3c64xx_spi_driver_data {
@@ -1152,7 +1153,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->pdev = pdev;
 	if (pdev->dev.of_node) {
 		ret = of_alias_get_id(pdev->dev.of_node, "spi");
-		if (ret < 0)
+		if (ret < 0 && !sdd->port_conf->fifosize)
 			return dev_err_probe(&pdev->dev, ret,
 					     "Failed to get alias id\n");
 		sdd->port_id = ret;
@@ -1171,7 +1172,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	sdd->rx_dma.direction = DMA_DEV_TO_MEM;
 
 	host->dev.of_node = pdev->dev.of_node;
-	host->bus_num = sdd->port_id;
+	host->bus_num = -1;
 	host->setup = s3c64xx_spi_setup;
 	host->cleanup = s3c64xx_spi_cleanup;
 	host->prepare_transfer_hardware = s3c64xx_spi_prepare_transfer;
@@ -1252,7 +1253,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	}
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Targets attached\n",
-					sdd->port_id, host->num_chipselect);
+		host->bus_num, host->num_chipselect);
 	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\n",
 					mem_res, sdd->fifosize);
 
-- 
2.43.0.429.g432eaa2c6b-goog


