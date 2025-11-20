Return-Path: <linux-spi+bounces-11438-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3177C76566
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 22:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABBE44E1B65
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 21:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944D430103C;
	Thu, 20 Nov 2025 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="ASndyTtE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16632E7166
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673228; cv=none; b=dZe26n7m0n5RQdv6II5No1C5NaZOneD60KjF08Ah5TJZrwlESuOoxzzPg1ckGU07aJESA26oppwNkzSiennVf0SpxhiCpwDDCSJHun6meJAWQIxwpGDj6Kgag+LkRsu1qV060quSDkTQWukb17+ITClpvNlQ6oPBmQkIk3GOBHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673228; c=relaxed/simple;
	bh=dRlzQ96rs+fNp5hXlkR0Gg5tjYDSB7ZnBitlBvL59r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruJsEBgrayGPJDaHS5/jyzvOlC6kIUrt/jKj6wkRHXX0zhRlJlIPjtbkDRMmc/TQr4hg5NKigHkAZJeP29yWcnZ23bOG12wb2dnVn+4MUaZcLOBqFhhdnvSCooj2cGa4uwILlO4Z7kCyh5Z+MqAZnEtckTFpyxqwBNLRCqIgBlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=ASndyTtE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2f2c5ec36so141320785a.1
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 13:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1763673225; x=1764278025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVzBwgc6QlD0nHecglFjZBXTLZjTboxTdYJUJxSXeUs=;
        b=ASndyTtEzZqvLP/UT0DsWcdiFGDQQhRWuCtoHkN3KQ21KApAZpMLIj8g0tOKttFjYl
         vHeKGPTarrQITEfeKMvNKxWGfFiJ0RcSezGz7x1a4WzbxRMSgihPKIIhzLpBEMASNszr
         RnH1MZ2qwKCLwvDB0ielwXMX0eAREEpJ8wh00+lrWhi42RcpaO0aaSFSFDA/uTMjM//6
         lNfoW1ZunzAqRn4jlanXRmNWOoqmGyAeNtVC+JTByP9pU6q6y1wCf+C7Vc4vwslVNB3c
         DPL9c5p+RhZ8MOja/n6q7Vq0Z3eUO43xzDVeEQD8xtUjAvelcWkfy4G8bXo1VruCcqPk
         MoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763673225; x=1764278025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVzBwgc6QlD0nHecglFjZBXTLZjTboxTdYJUJxSXeUs=;
        b=jfbyzVzQ0exU28K0VXJMhHswLVhIis/C7RuZoORdkyJZkg5sYNUkeUdG8okOvo0ijh
         NizQM10r7LstswlbvY/cs88cKE/6q48bwNyWwDt3Ho08yCrMttbGnMfZUTMkRt/sfqRd
         bT6g9/uym93ENR+56cBaoP5Pxtu4XRbvQuJokcsrZ4yRrsSeU1e0A1Ao6NrKtLQ1qKrT
         k0FGvHIMW+GSOZ05p0+EYOnmmCoKC940U5MmJLQ1T37kpPrZzm9tW5fAxiIh9dPtzJQN
         ZrY1LP4IsQ68gFO1yF1de+UrOxDNSEJsThNu42uQVVFW46YgA2ZkhhyhL6uUKpd3tqXR
         TWxA==
X-Forwarded-Encrypted: i=1; AJvYcCUMh4eIj+HAW9YQ00c3vvDz+mG1BCBK0aOvT/Jt46NFmyvcOTWeGt1IyTyn93BnzjbZizTTNMS3jEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxciKwPQvKT+QoBbmnmWqd3MdW8OCzCk7ZMOMQ21r6Hr3SULnjh
	hxp5znIZVnnd8bQgcGX/zs5UQdBDZN59LLp0mXotzCAjaK8rfDaqHCXWtgKsRcxUrC0=
X-Gm-Gg: ASbGncsOiSvwWffczcUlCCTSwZLmwNDwv70tBqTcLHYPHvm4gRd2RlARom3VVx7EHfr
	AITSwliQpHdVTvo6laI8LTRd3YuyIc7N8Lb27/TYmhUGNzGXGHIwibQi7pw6pxHrVOYWylilhkx
	fp6NrVpWgP2GUhultxP/firXlZ1jSoNyaU2OlVzMo73cLFImE5brSLZdJqwzSVivWlXDNLmIaQt
	SO2EEzlXi1YyBsCS+PhICBH7Zwks4e/pU3xd2Wd4Fwp+h04wC+MVM12TQfi3azuWRv3odbv06k0
	eKOYiorcyEWy/4gRD/M9hlko92E5h2CXburTbRZVm/MdQLwABGau6Th4wtcQlU/KE0TXHCnWaDO
	b8pQ+sGD8CSYC7QLBgsqir5SJBxr4CoxBiE3HLNb2w7BaHVOUdOstj5ceuQN+DelFLr2aVBHeHM
	07ZCXRorw9MWTbi+JwQGmIr9LTtlkE9HyGDb9dPbw+6Igsxia+dVGeAO0itntPCd15MqVfA7jDc
	DXQ
X-Google-Smtp-Source: AGHT+IF2FhtIxbW6vGk9595WzYvRTUOYy9+2T706C0hjoNLIyR3ssddAWV2ieLYHkCpQ0NPfnRLbVA==
X-Received: by 2002:a05:620a:370f:b0:8b2:5df1:9341 with SMTP id af79cd13be357-8b32749fffbmr631702785a.75.1763673224616;
        Thu, 20 Nov 2025 13:13:44 -0800 (PST)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32953735dsm225958685a.24.2025.11.20.13.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:13:43 -0800 (PST)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/5] spi-geni-qcom: remove manual CS control
Date: Thu, 20 Nov 2025 16:11:58 -0500
Message-ID: <20251120211204.24078-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPI_DMA mode already uses automatic CS control, to use automatic CS
control for non-GPI case all that's needed is to set the FRAGMENTATION flag
using the same logic as setup_gsi_xfer(). (note clearing SPI_TRANS_CFG's
CS_TOGGLE bit enables automatic CS control, the comment was wrong)

spi_geni_set_cs() is slow, so this is a big performance improvement.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/spi/spi-geni-qcom.c | 67 +++++--------------------------------
 1 file changed, 8 insertions(+), 59 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index a0d8d3425c6c6..ed80f49c7b2f3 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -284,55 +284,6 @@ static bool spi_geni_is_abort_still_pending(struct spi_geni_master *mas)
 	return false;
 }
 
-static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
-{
-	struct spi_geni_master *mas = spi_controller_get_devdata(slv->controller);
-	struct spi_controller *spi = dev_get_drvdata(mas->dev);
-	struct geni_se *se = &mas->se;
-	unsigned long time_left;
-
-	if (!(slv->mode & SPI_CS_HIGH))
-		set_flag = !set_flag;
-
-	if (set_flag == mas->cs_flag)
-		return;
-
-	pm_runtime_get_sync(mas->dev);
-
-	if (spi_geni_is_abort_still_pending(mas)) {
-		dev_err(mas->dev, "Can't set chip select\n");
-		goto exit;
-	}
-
-	spin_lock_irq(&mas->lock);
-	if (mas->cur_xfer) {
-		dev_err(mas->dev, "Can't set CS when prev xfer running\n");
-		spin_unlock_irq(&mas->lock);
-		goto exit;
-	}
-
-	mas->cs_flag = set_flag;
-	/* set xfer_mode to FIFO to complete cs_done in isr */
-	mas->cur_xfer_mode = GENI_SE_FIFO;
-	geni_se_select_mode(se, mas->cur_xfer_mode);
-
-	reinit_completion(&mas->cs_done);
-	if (set_flag)
-		geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
-	else
-		geni_se_setup_m_cmd(se, SPI_CS_DEASSERT, 0);
-	spin_unlock_irq(&mas->lock);
-
-	time_left = wait_for_completion_timeout(&mas->cs_done, HZ);
-	if (!time_left) {
-		dev_warn(mas->dev, "Timeout setting chip select\n");
-		handle_se_timeout(spi, NULL);
-	}
-
-exit:
-	pm_runtime_put(mas->dev);
-}
-
 static void spi_setup_word_len(struct spi_geni_master *mas, u16 mode,
 					unsigned int bits_per_word)
 {
@@ -728,7 +679,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
 		break;
 	}
 
-	/* We always control CS manually */
+	/* We never control CS manually */
 	if (!spi->target) {
 		spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
 		spi_tx_cfg &= ~CS_TOGGLE;
@@ -841,6 +792,7 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 				u16 mode, struct spi_controller *spi)
 {
 	u32 m_cmd = 0;
+	u32 m_params = 0;
 	u32 len;
 	struct geni_se *se = &mas->se;
 	int ret;
@@ -904,12 +856,17 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 		mas->cur_xfer_mode = GENI_SE_DMA;
 	geni_se_select_mode(se, mas->cur_xfer_mode);
 
+	if (!xfer->cs_change) {
+		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
+			m_params = FRAGMENTATION;
+	}
+
 	/*
 	 * Lock around right before we start the transfer since our
 	 * interrupt could come in at any time now.
 	 */
 	spin_lock_irq(&mas->lock);
-	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
+	geni_se_setup_m_cmd(se, m_cmd, m_params);
 
 	if (mas->cur_xfer_mode == GENI_SE_DMA) {
 		if (m_cmd & SPI_RX_ONLY)
@@ -1148,14 +1105,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * check the mode supported and set_cs for fifo mode only
-	 * for dma (gsi) mode, the gsi will set cs based on params passed in
-	 * TRE
-	 */
-	if (!spi->target && mas->cur_xfer_mode == GENI_SE_FIFO)
-		spi->set_cs = spi_geni_set_cs;
-
 	/*
 	 * TX is required per GSI spec, see setup_gsi_xfer().
 	 */
-- 
2.51.0


