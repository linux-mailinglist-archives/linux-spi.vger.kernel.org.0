Return-Path: <linux-spi+bounces-12441-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B30D30AEE
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 12:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B524F3062B03
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 11:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B637A493;
	Fri, 16 Jan 2026 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdTssUFA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC504379996
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768564129; cv=none; b=p6PMfB9MYN8Ecsk64P2A9GsMHORDMeU/R4T9wDozwJAHWmyiiEvDNSTDko8efbNI9tPq5geVlo/2HBtBDLoNwTqe5eagGePWEbQdYTs2wPPAKvoTlr3YN2xd/xUA/VOTSK3RvnehH8KxLwlcGh7HZTimChZGp/flFSBE0IDd19c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768564129; c=relaxed/simple;
	bh=OuWN+wqxGvxNziBtRJ3DW5VIbPaZx5rNaXhjc5dpci4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l86VchhzyFJjS9qXgCk1FI5XOiQpqoRPMZy51a9gJM8zy6SxYjzuDVx6XygcI5tCP1Q3EF1qxPvZ0dUnHfk4uatNzRAup2wjcSSaUPYaLh8VfJWxFPa8TmbWAtOV0eevDR8IF0r63A938az7DXZ+ZrFlXCpda2DHLf9nZ1tqwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdTssUFA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so2980347a12.0
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 03:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768564126; x=1769168926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1hLLqHuwe2jKm8Ng/vqG4F68JdkbgogVrKKS62d83M=;
        b=jdTssUFAqyMC2/47OX/TJfEdvm5AtTVS1a8asp2IjnUfMOkoCWewAC95u/uxXfV3hU
         poZ9vDpssqAd9h02oylEl0f71OvcsOjOL+8WGFA7+Xk9Bk9cq/ewmMCX2+upUycJxpom
         XCwl7rBAhVyN0MOsV5lbAsSGJ5z4NTsoF9/bInQ6tps/0AWeUdln7TNZkQNujKN1bHZJ
         6oNX7ZdHDb+jfnP/sKLdvlOyGozqd2B08XoJTVc27Lb4WE2G3GdQeLIE1JGLvZXY2oK9
         IIOJtcNT0s82dnwl9VBjUiaRiCzETPL7Il/JE6OHlSyLgR2rsnshg2oFzbrhDREJrcBL
         ZYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768564126; x=1769168926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1hLLqHuwe2jKm8Ng/vqG4F68JdkbgogVrKKS62d83M=;
        b=cyPhdKUFiUZGeYGcCD55ommBBadFlKqrpuW66pbzywmqAe92/DJF3QsVAUq4AdlNbm
         rImgZ9wiTihnFrVw7D7Fdf2vWaY1LCjEp7t4zW5BIyAtopelMcyMpvIW0fyaRkEnHx6a
         x1EkqAsoOKGMo5FEOsMitCm/Cm8pI4w8OrW3/5y6mCdOSrgz3VDTPxpocRKnZ2xZSqeJ
         P9nrPvhTtGPKZqb8C3DTrUAeVkuU/8348wlPopvUjYaiq+LZC+QdMe/fNnhKlY6chQ8e
         1nKC3+36lg10hl3UIXYk/msfWLnc7kM2JgWGPotFASHZX0FiTFLFTgk8rfE1cFaT4fqt
         DAOg==
X-Forwarded-Encrypted: i=1; AJvYcCWxTT6Us3wDW2Y/rEhmUy8nonQCvIyyBwOnUY2iahiJPh8Pijki9gLqGoLKQPrKuSJ1fTRNzh/J78I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGguefFcXJF5utxoeMjlFnn9Am7jSo67KQVYahRNSOVX//amxu
	7bmA/DTJEigbzueTKQTns64n8ehTL/Lx5CQ5ms0gc85UWoJ7J2qwfIkO
X-Gm-Gg: AY/fxX5FeJSaAzEIbl4GAlUfZGUnZuL7zRiis3E4XNG+M4/zV6IAO+Wr1X4MIf9SXPf
	LBqqENQUCz9F059zc/l3eDLyZ56obO+zdCBpEzeQzSeLUArNZqNT8tKvaUhGa8ZPsX+1F+014MV
	0vjYIU3n0kyPfbADDZYrKfTG5eiTw8cvWPU+ps5UVxhKxZHXSf0s2p/H0BqDANPWWxBCiAzeGbQ
	VQNRihxRVT4/wb0a+XjEgTq0wtGYH/NDuxE4nKFLeaqZW2Y1qADdScC7SrymQ4ZYAAPWsDnciFm
	n5z6ijEQ2ncIS8mA4qEEH87X9Rj4AFaalfDdAIa9vEuSEWj22H5EbyJaVxLW4goar/kNEFaYPHU
	0RbXmZzJUYdDeg8vnFLoxF+VZEcejCTcVSh/97vAwg4nX3LymNdO6V4WsjlPgRSENSm7Y8CL0Ol
	C3zSKLaVm54N0iclNrPTaKfzyQ4dtIcTNUgm30v/njYvLh5lukliIi04KpSXBG+pmQwgiwyxmo4
	corDvq7mpyJJYUtpb0BDUs=
X-Received: by 2002:a17:906:ee88:b0:b87:19af:3e4d with SMTP id a640c23a62f3a-b8792e0f4c7mr248831766b.22.1768564125751;
        Fri, 16 Jan 2026 03:48:45 -0800 (PST)
Received: from ?IPV6:2a02:6b6f:e758:1200:495:ace9:5ad5:c54a? ([2a02:6b6f:e758:1200:495:ace9:5ad5:c54a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879bd278fdsm153182266b.28.2026.01.16.03.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 03:48:45 -0800 (PST)
Message-ID: <9d845244-bad0-4e7c-8f7c-bd3224cabac4@gmail.com>
Date: Fri, 16 Jan 2026 11:48:44 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] spi: tegra210-quad: Return IRQ_HANDLED when timeout
 already processed transfer
To: Breno Leitao <leitao@debian.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Vishwaroop A <va@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, puranjay@kernel.org
References: <20260116-tegra_xfer-v1-0-02d96c790619@debian.org>
 <20260116-tegra_xfer-v1-1-02d96c790619@debian.org>
Content-Language: en-GB
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20260116-tegra_xfer-v1-1-02d96c790619@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/01/2026 10:41, Breno Leitao wrote:
> When the ISR thread wakes up late and finds that the timeout handler
> has already processed the transfer (curr_xfer is NULL), return
> IRQ_HANDLED instead of IRQ_NONE.
> 
> Use a similar approach to tegra_qspi_handle_timeout() by reading
> QSPI_TRANS_STATUS and checking the QSPI_RDY bit to determine if the
> hardware actually completed the transfer. If QSPI_RDY is set, the
> interrupt was legitimate and triggered by real hardware activity.
> The fact that the timeout path handled it first doesn't make it
> spurious. Returning IRQ_NONE incorrectly suggests the interrupt
> wasn't for this device, which can cause issues with shared interrupt
> lines and interrupt accounting.
> 
> Fixes: b4e002d8a7ce ("spi: tegra210-quad: Fix timeout handling")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/spi/spi-tegra210-quad.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

Hi,

I am not familiar with tegra SPI specifically, so I might be missing something, but
I was wondering if its actually better to not handle the transfer in timeout at all. 

We have 1000ms before timeout and I feel like that should have been enough.
Looking at other spi drivers: imx, fsl,.. these dont handle transfers in timeout
and are therefore lockless. tegra_qspi_handle_timeout also at the end checks
if for some reason the transfer fails (although it looks like handle_cpu/dma_based_xfer
cant really fail?), and would just return failure.

Removing the attempt to transfer in timeout will get rid of the spinlock, all the bugs,
make isr handling quicker as you dont need to acquire a spinlock (which might lead to lesser
timeouts?) and makes the whole driver much more simpler. Or maybe I am missing something?

I have a potential untested patch below for how it would look like. We can work on testing this
if it makes sense to the maintainers?



commit 09af307fbb33717e8de9489cef2abd743e3f6a93
Author: Usama Arif <usamaarif642@gmail.com>
Date:   Wed Jan 14 16:47:06 2026 +0000

    spi: tegra210-quad: remove tqspi->lock and xfer handling in timeout
    
    The tqspi->lock spinlock existed to protect against races between the
    IRQ handler and the timeout recovery path, which could both call
    handle_cpu_based_xfer() or handle_dma_based_xfer(). However, this
    locking is not implemented correctly and is causing a race condition.
    Looking at other spi drivers that have a irq (for e.g. spi-fsl-dspi.c),
    it is simpler to not just handle trasfers in timeout.
    
    Remove xfer handling when there is timeout, eliminating the need for
    the lock completely, simplifying the code and eliminating the race
    condition. The existing code already handles xfer failure by returning
    -EIO. This brings tegra210-quad inline with other drivers like
    spi-fsl-dspi, spi-imx and spi-fs-lpspi. Making the irq handling lockless
    might also make it faster, which could lead to lesser timeouts.
    
    Signed-off-by: Usama Arif <usamaarif642@gmail.com>

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index cdc3cb7c01f9b..ba67e628bd9ef 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -184,8 +184,6 @@ struct tegra_qspi_client_data {
 struct tegra_qspi {
 	struct device				*dev;
 	struct spi_controller			*host;
-	/* lock to protect data accessed by irq */
-	spinlock_t				lock;
 
 	struct clk				*clk;
 	void __iomem				*base;
@@ -968,7 +966,6 @@ static int tegra_qspi_setup(struct spi_device *spi)
 {
 	struct tegra_qspi *tqspi = spi_controller_get_devdata(spi->controller);
 	struct tegra_qspi_client_data *cdata = spi->controller_data;
-	unsigned long flags;
 	u32 val;
 	int ret;
 
@@ -982,8 +979,6 @@ static int tegra_qspi_setup(struct spi_device *spi)
 		cdata = tegra_qspi_parse_cdata_dt(spi);
 		spi->controller_data = cdata;
 	}
-	spin_lock_irqsave(&tqspi->lock, flags);
-
 	/* keep default cs state to inactive */
 	val = tqspi->def_command1_reg;
 	val |= QSPI_CS_SEL(spi_get_chipselect(spi, 0));
@@ -995,8 +990,6 @@ static int tegra_qspi_setup(struct spi_device *spi)
 	tqspi->def_command1_reg = val;
 	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
 
-	spin_unlock_irqrestore(&tqspi->lock, flags);
-
 	pm_runtime_put(tqspi->dev);
 
 	return 0;
@@ -1048,48 +1041,6 @@ static void tegra_qspi_transfer_end(struct spi_device *spi)
 	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
 }
 
-static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi);
-static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi);
-
-/**
- * tegra_qspi_handle_timeout - Handle transfer timeout with hardware check
- * @tqspi: QSPI controller instance
- *
- * When a timeout occurs but hardware has completed the transfer (interrupt
- * was lost or delayed), manually trigger transfer completion processing.
- * This avoids failing transfers that actually succeeded.
- *
- * Returns: 0 if transfer was completed, -ETIMEDOUT if real timeout
- */
-static int tegra_qspi_handle_timeout(struct tegra_qspi *tqspi)
-{
-	irqreturn_t ret;
-	u32 status;
-
-	/* Check if hardware actually completed the transfer */
-	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
-	if (!(status & QSPI_RDY))
-		return -ETIMEDOUT;
-
-	/*
-	 * Hardware completed but interrupt was lost/delayed. Manually
-	 * process the completion by calling the appropriate handler.
-	 */
-	dev_warn_ratelimited(tqspi->dev,
-			     "QSPI interrupt timeout, but transfer complete\n");
-
-	/* Clear the transfer status */
-	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
-	tegra_qspi_writel(tqspi, status, QSPI_TRANS_STATUS);
-
-	/* Manually trigger completion handler */
-	if (!tqspi->is_curr_dma_xfer)
-		ret = handle_cpu_based_xfer(tqspi);
-	else
-		ret = handle_dma_based_xfer(tqspi);
-
-	return (ret == IRQ_HANDLED) ? 0 : -EIO;
-}
 
 static u32 tegra_qspi_cmd_config(bool is_ddr, u8 bus_width, u8 len)
 {
@@ -1220,28 +1171,19 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					QSPI_DMA_TIMEOUT);
 
 			if (WARN_ON_ONCE(ret == 0)) {
-				/*
-				 * Check if hardware completed the transfer
-				 * even though interrupt was lost or delayed.
-				 * If so, process the completion and continue.
-				 */
-				ret = tegra_qspi_handle_timeout(tqspi);
-				if (ret < 0) {
-					/* Real timeout - clean up and fail */
-					dev_err(tqspi->dev, "transfer timeout\n");
-
-					/* Abort transfer by resetting pio/dma bit */
-					if (tqspi->is_curr_dma_xfer)
-						tegra_qspi_dma_stop(tqspi);
-					else
-						tegra_qspi_pio_stop(tqspi);
-
-					/* Reset controller if timeout happens */
-					tegra_qspi_reset(tqspi);
-
-					ret = -EIO;
-					goto exit;
-				}
+				dev_err(tqspi->dev, "transfer timeout\n");
+
+				/* Abort transfer by resetting pio/dma bit */
+				if (tqspi->is_curr_dma_xfer)
+					tegra_qspi_dma_stop(tqspi);
+				else
+					tegra_qspi_pio_stop(tqspi);
+
+				/* Reset controller if timeout happens */
+				tegra_qspi_reset(tqspi);
+
+				ret = -EIO;
+				goto exit;
 			}
 
 			if (tqspi->tx_status ||  tqspi->rx_status) {
@@ -1332,23 +1274,14 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 		ret = wait_for_completion_timeout(&tqspi->xfer_completion,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
-			/*
-			 * Check if hardware completed the transfer even though
-			 * interrupt was lost or delayed. If so, process the
-			 * completion and continue.
-			 */
-			ret = tegra_qspi_handle_timeout(tqspi);
-			if (ret < 0) {
-				/* Real timeout - clean up and fail */
-				dev_err(tqspi->dev, "transfer timeout\n");
+			dev_err(tqspi->dev, "transfer timeout\n");
 
-				if (tqspi->is_curr_dma_xfer)
-					tegra_qspi_dma_stop(tqspi);
+			if (tqspi->is_curr_dma_xfer)
+				tegra_qspi_dma_stop(tqspi);
 
-				tegra_qspi_handle_error(tqspi);
-				ret = -EIO;
-				goto complete_xfer;
-			}
+			tegra_qspi_handle_error(tqspi);
+			ret = -EIO;
+			goto complete_xfer;
 		}
 
 		if (tqspi->tx_status ||  tqspi->rx_status) {
@@ -1441,9 +1374,6 @@ static int tegra_qspi_transfer_one_message(struct spi_controller *host,
 static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi)
 {
 	struct spi_transfer *t = tqspi->curr_xfer;
-	unsigned long flags;
-
-	spin_lock_irqsave(&tqspi->lock, flags);
 
 	if (tqspi->tx_status ||  tqspi->rx_status) {
 		tegra_qspi_handle_error(tqspi);
@@ -1468,7 +1398,6 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi)
 	tegra_qspi_start_cpu_based_transfer(tqspi, t);
 exit:
 	tqspi->curr_xfer = NULL;
-	spin_unlock_irqrestore(&tqspi->lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -1476,7 +1405,6 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 {
 	struct spi_transfer *t = tqspi->curr_xfer;
 	unsigned int total_fifo_words;
-	unsigned long flags;
 	long wait_status;
 	int num_errors = 0;
 
@@ -1512,13 +1440,11 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 		}
 	}
 
-	spin_lock_irqsave(&tqspi->lock, flags);
-
 	if (num_errors) {
 		tegra_qspi_dma_unmap_xfer(tqspi, t);
 		tegra_qspi_handle_error(tqspi);
 		complete(&tqspi->xfer_completion);
-		goto exit;
+		return IRQ_HANDLED;
 	}
 
 	if (tqspi->cur_direction & DATA_DIR_RX)
@@ -1532,7 +1458,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	if (tqspi->cur_pos == t->len) {
 		tegra_qspi_dma_unmap_xfer(tqspi, t);
 		complete(&tqspi->xfer_completion);
-		goto exit;
+		return IRQ_HANDLED;
 	}
 
 	tegra_qspi_dma_unmap_xfer(tqspi, t);
@@ -1544,8 +1470,6 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	else
 		num_errors = tegra_qspi_start_cpu_based_transfer(tqspi, t);
 
-exit:
-	spin_unlock_irqrestore(&tqspi->lock, flags);
 	return IRQ_HANDLED;
 }
 
@@ -1679,7 +1603,6 @@ static int tegra_qspi_probe(struct platform_device *pdev)
 
 	tqspi->host = host;
 	tqspi->dev = &pdev->dev;
-	spin_lock_init(&tqspi->lock);
 
 	tqspi->soc_data = device_get_match_data(&pdev->dev);
 	host->num_chipselect = tqspi->soc_data->cs_count;


