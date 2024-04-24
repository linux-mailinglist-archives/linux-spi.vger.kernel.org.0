Return-Path: <linux-spi+bounces-2490-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5658B0BB6
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 15:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA2D1F26525
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 13:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF09C15D5C8;
	Wed, 24 Apr 2024 13:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="F/lPedlV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F715AABA
	for <linux-spi@vger.kernel.org>; Wed, 24 Apr 2024 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967114; cv=none; b=I3HrCT8KoyEn99zaX3CGspjK1Tgv6RbjXe+Sl/L5XouEa16uU1d8hLk+gKHqc9L4g6oT7h60oTehX+k3HQ59dO6bb32tMCpmHWIaMv8TlvbqQZzUXtHc//z9aiVjrZOFptgQeNUmaWdnxHtmvx3WDt7nQj1FMjZ6I8glvnUTpTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967114; c=relaxed/simple;
	bh=N5dTRLaXW8FTLrwcnypCM94wLqBaxf+sdJp2R+6Hk/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwghjQgZzFbP6pcwuhf+KDQ7QFBeBMxLTkp0+NJ/GdSWE1JsaptroCqlNWVdHkNCdlFG576fW5Aawsg7Q5dtscsd2AfqOyZfNzHwmWesK+L6usKM5GfAblVxnwJ0cskbqdMHuOSkXGryR0ZHzjYaSCmVMemqpstuwXzVetcjY/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com; spf=none smtp.mailfrom=hefring.com; dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b=F/lPedlV; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hefring.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa17c29ba0so4070619eaf.3
        for <linux-spi@vger.kernel.org>; Wed, 24 Apr 2024 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1713967110; x=1714571910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=47bZdX0wm5QrsJ8T2X7IRvwqReXemUOe2I5iAISiMQM=;
        b=F/lPedlVWC+sLnZJTd8tBA9x/dKah5ufib2jzYtYXrus1KFq5pgayCScoBdf1EKkW8
         mXcFoknUqj50TAJo29YtYY4+ZxmK0ygluHwmTE9GNM2AuZ12qMT9Gnt4ZLl+x1G2hu7h
         1Rjb+bsaHTO/2Jz97LFMEqXOJMCbNT3ELeCzN8Qng4KlvbxzRPsg7Xm4Ym2vKLXkhYFx
         AOf7Mp7JvETQgXJmc81lrLGpTbhtkN+OgmMgYJTagrvArO6uKg38ouke2PE9DgxUVmpw
         3lHrx7PdDmLnMgiOdLy7GVMXmPSGeGtsDsvZI0K/ZkVH54Qm0GjoUukace58B5pn9ZjR
         78gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967110; x=1714571910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47bZdX0wm5QrsJ8T2X7IRvwqReXemUOe2I5iAISiMQM=;
        b=WAMc2GwmCWJdLurQAQYdA6HybsAr9iuNsMxAxTcTdqaIrJop9tuntDLGVp/MwYxUfB
         dSRlDWfCVWEulqpfOn88lwBZHNGU0VTbcjwvSim3LhD2DtWJ+OlxoYjK/V6Q1WrJ3S6p
         TNuMOfptHlERstVkIN+EPy20uWZkreZWN4WjyB28MRz2YpsciixU2+BA9c5sCm2zwV5A
         7FUdcNH9aI+DzZPUQ4bNK+zqRcU7f9kNKfL3CSOhgIlHTOHs8WL3NTr5sLsAG3F4gLtu
         TkcNlprxYX3MuBFhX8g5Fgof0r7OOek6FXmBlloCeKK24oruMomiF5qFvuUlOwR83TRt
         Pmqw==
X-Forwarded-Encrypted: i=1; AJvYcCVtwZPX7WvG/X8NuVEBdcm76gfC+HFBz/fQ3tnYUOSwgoBGlpW/jjrd/RaF0zLqTI5yUvoKLxBjxA8dd0Hchyh3ZokMZEeYu4w5
X-Gm-Message-State: AOJu0YydwGf9d+WTuviFec+nkO8igI9mezp6/KAtlUAN264nsFql0D75
	YueECiUNhX3myDrz7mtPwOToTIPyQTF4FPUDNheuPSrLML+Z6PjjUECmpEeQvsc=
X-Google-Smtp-Source: AGHT+IFyaaQ1OHVKcO48XtLcq1OfECVxsFjh6fMY/zT6Sx7rwkI0+KafbZXkwOwQXI0UPi0u+CFVAQ==
X-Received: by 2002:a05:6358:5d8d:b0:17e:b867:cb99 with SMTP id s13-20020a0563585d8d00b0017eb867cb99mr3311133rwm.1.1713967110512;
        Wed, 24 Apr 2024 06:58:30 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.90])
        by smtp.gmail.com with ESMTPSA id h2-20020ac85682000000b004365ab2894asm6120931qta.51.2024.04.24.06.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 06:58:29 -0700 (PDT)
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-spi@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH v2] spi: stm32: enable controller before asserting CS
Date: Wed, 24 Apr 2024 09:52:38 -0400
Message-ID: <20240424135237.1329001-2-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the STM32F4/7, the MOSI and CLK pins float while the controller is
disabled. CS is a regular GPIO, and therefore always driven. Currently,
the controller is enabled in the transfer_one() callback, which runs
after CS is asserted.  Therefore, there is a period where the SPI pins
are floating while CS is asserted, making it possible for stray signals
to disrupt communications. An analogous problem occurs at the end of the
transfer when the controller is disabled before CS is released.

This problem can be reliably observed by enabling the pull-up (if
CPOL=0) or pull-down (if CPOL=1) on the clock pin. This will cause two
extra unintended clock edges per transfer, when the controller is
enabled and disabled.

Note that this bug is likely not present on the STM32H7, because this
driver sets the AFCNTR bit (not supported on F4/F7), which keeps the SPI
pins driven even while the controller is disabled.

Enabling/disabling the controller as part of runtime PM was suggested as
an alternative approach, but this breaks the driver on the STM32MP1 (see
[1]). The following quote from the manual may explain this:

> To restart the internal state machine properly, SPI is strongly
> suggested to be disabled and re-enabled before next transaction starts
> despite its setting is not changed.

This patch has been tested on an STM32F746 with a MAX14830 UART
expander.

[1] https://lore.kernel.org/lkml/ZXzRi_h2AMqEhMVw@dell-precision-5540/T/

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
v2:
 * Improve explanation of problem
 * Discuss why not to use runtime PM instead

 drivers/spi/spi-stm32.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index e4e7ddb7524a..4a68abcdcc35 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1016,10 +1016,8 @@ static irqreturn_t stm32fx_spi_irq_event(int irq, void *dev_id)
 static irqreturn_t stm32fx_spi_irq_thread(int irq, void *dev_id)
 {
 	struct spi_controller *ctrl = dev_id;
-	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 
 	spi_finalize_current_transfer(ctrl);
-	stm32fx_spi_disable(spi);
 
 	return IRQ_HANDLED;
 }
@@ -1187,6 +1185,8 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 			 ~clrb) | setb,
 			spi->base + spi->cfg->regs->cpol.reg);
 
+	stm32_spi_enable(spi);
+
 	spin_unlock_irqrestore(&spi->lock, flags);
 
 	return 0;
@@ -1204,7 +1204,6 @@ static void stm32fx_spi_dma_tx_cb(void *data)
 
 	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
 		spi_finalize_current_transfer(spi->ctrl);
-		stm32fx_spi_disable(spi);
 	}
 }
 
@@ -1219,7 +1218,6 @@ static void stm32_spi_dma_rx_cb(void *data)
 	struct stm32_spi *spi = data;
 
 	spi_finalize_current_transfer(spi->ctrl);
-	spi->cfg->disable(spi);
 }
 
 /**
@@ -1307,8 +1305,6 @@ static int stm32fx_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	stm32_spi_set_bits(spi, STM32FX_SPI_CR2, cr2);
 
-	stm32_spi_enable(spi);
-
 	/* starting data transfer when buffer is loaded */
 	if (spi->tx_buf)
 		spi->cfg->write_tx(spi);
@@ -1345,8 +1341,6 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	spin_lock_irqsave(&spi->lock, flags);
 
-	stm32_spi_enable(spi);
-
 	/* Be sure to have data in fifo before starting data transfer */
 	if (spi->tx_buf)
 		stm32h7_spi_write_txfifo(spi);
@@ -1378,8 +1372,6 @@ static void stm32fx_spi_transfer_one_dma_start(struct stm32_spi *spi)
 		 */
 		stm32_spi_set_bits(spi, STM32FX_SPI_CR2, STM32FX_SPI_CR2_ERRIE);
 	}
-
-	stm32_spi_enable(spi);
 }
 
 /**
@@ -1413,8 +1405,6 @@ static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
 
 	stm32_spi_set_bits(spi, STM32H7_SPI_IER, ier);
 
-	stm32_spi_enable(spi);
-
 	if (STM32_SPI_HOST_MODE(spi))
 		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
 }
-- 
2.44.0


