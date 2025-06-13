Return-Path: <linux-spi+bounces-8510-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A872AD8C29
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 14:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2CC11E0835
	for <lists+linux-spi@lfdr.de>; Fri, 13 Jun 2025 12:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9763FE5;
	Fri, 13 Jun 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw5UD+My"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D681DDD1;
	Fri, 13 Jun 2025 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817842; cv=none; b=o5EEZpJveXQBexTY+a1xfH4W2doIDNDpH6nfTofbLPnKcI20w2p2xDiI/veaCY9xJeDS1EPtnGpO5UQ17tJx5dedhVf/IQ/blA83hcVHGaLjsfBOe8OukdSlNkGehuDEj055WMKVk+sBEMSNo5pD+HIchQupYY6h8RZ7cFow0Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817842; c=relaxed/simple;
	bh=dirYhv9VT2S9TTUD3pIN80CKZ7uxHA8Zrru+Tpjkb5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/K1oiw+aitEPIDawbzuFkqC3jeWbqcI3JqfiUaMB2zc2y8092BW5c8NK+1zksJK8iVD0GL6UBJW/M2a0KJpviaK88ET9b10hG4iZtxxqNJUQ2J5xkxevBhbennhAQNdj0qg1IffAllUTK7H3N4id6aMhW5ei7OKVIFDQEBQDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw5UD+My; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so2034185f8f.0;
        Fri, 13 Jun 2025 05:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749817839; x=1750422639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDahtSYkj+HkMH3zYP8DVq39ggZjJyBAZAxdjk4esRw=;
        b=Xw5UD+MyHzF9VAKtk9hFx+Vp8LSJKq/nxOPTFRW4Gm5ib4aIibQ3yc5N26JJmj8YPO
         8VWv58lXq/+1KSs2d1zOJnpJy3oF769PM4TuOEn6jZ0o5RMCGmhAOWHr+5ykD2+PU71b
         gxlhXyiP8H+xfCJ/FWfqNzRPX93aM74FCX6Z+HM2tdqzWI8OVhFdmpSsxZTqqg9RDrJ0
         xkzIUZP/SB1DrYu22LlLskHqBkmp1JbZryd+bsLXa+jUEtB7iZNlow7mWN5T+KYuL5GF
         rhSILzj2zSLP16razfY5wFW+AXxYHrD8dl2TEmuLjuHFOkPWOPqnuFa4bJCEB1gTZS5D
         +8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749817839; x=1750422639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDahtSYkj+HkMH3zYP8DVq39ggZjJyBAZAxdjk4esRw=;
        b=cLmSRX1VszaUmy5H7yGGjEGS4tmbujuOY7TiHinLKG+tkYOq2ibPUUTOBKz5AGOQ/q
         7fTBzQUS6b+M6TdNtxeSCrP8k8xVCHCBiA0CVj3j7eRsM/a62o4mygEJ3kgx2Cs5WblS
         UKMZF/2sLlh0AqRmNhqHEwR8VgKQ4lJz68kFawYBf/ELzSxGrrMsV+uLxWljewV9CIY7
         KNcZAMJqQwubz2L8o5BvV6goaXIoMMlGVRzED/MX0nMi3mWoUJQap4YZEn028i/j1WkV
         thBQF7TtNZyFeSu5TMZw/83wmK1qsR1sIAa6k1LPM0Fs0jn90u0S09C+53OaHttBSnTJ
         BtTA==
X-Forwarded-Encrypted: i=1; AJvYcCV7lQqXzzLd8UWXFDscwVT/Lf0GHZiKVil2wY/titkHx+T/dDPgZmn5H17QesxS2AVh8EttbCbUKZE=@vger.kernel.org, AJvYcCXPQEybSKDV3mR3RU6NDzawXNk/+AQEX7rIuNKjvVvUbigjGusSd6VNU6OG6bDg9xAOmESzy5cQ3e2X904=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDV/2EHLkb96gcG/+TIMivDaMPfxTjpL4kBdwBkdMc6ED2UfSn
	YP11tqZKI2HQHj50oeb/iSw4CzetTEgdB6hAZCRy2NKVgUAp+dXZ/sA29oOxyw==
X-Gm-Gg: ASbGncsONEm9afrHiKJU9Y38apNe1hnen1XJ1Av0DihitOWuLoTVwB10CaSIK3j3HHX
	G8Gqif1Qq0bdFXhszZ19/iULDMqCNVJugXDSazNQi77BBPtyitCA/dFtGvHW4gNeXWRfOEw/P9U
	/7xVzhFWSc7XNSBYdcICSYA0D3rt2bH9Nlr3bz0vC5nfZN7ZmWlRl7CYp/EX4B+kTkaMx/8Qlpx
	yByNPaZE2zR6EfJ0HU6Xwsuj/+w20T+CSEuFtqI53hyQMeWHJ8Y2gziMm9Un1kql64tlBQnQgQP
	OondyxqOT3aeyHD/qV2TjOG7wactj0SzlEpWUVzKDD5QkDDwxWlt+9lCNzEDCYJxw8dq/wL/SL1
	nu9Ndgs8t3hINhfFTSmYNExfq3tiAWVEcHzpaEwZZs1hvjagXYMUgnw==
X-Google-Smtp-Source: AGHT+IHuJ5xo7QniB5DnKQzH5ZflLS/T2ofG5VoQUjB/z36gjes12Eh7vW/JEPoz0V6HghfrPuZ+iA==
X-Received: by 2002:a5d:584c:0:b0:3a5:2f6a:ccd5 with SMTP id ffacd0b85a97d-3a56873dc7cmr2597097f8f.49.1749817839013;
        Fri, 13 Jun 2025 05:30:39 -0700 (PDT)
Received: from localhost (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a568b18f96sm2305444f8f.66.2025.06.13.05.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 05:30:38 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Vishwaroop A <va@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Brad Griffis <bgriffis@nvidia.com>
Subject: [PATCH] spi: tegra210-qspi: Remove cache operations
Date: Fri, 13 Jun 2025 14:30:37 +0200
Message-ID: <20250613123037.2082788-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

The DMA memory for this driver is allocated using dma_alloc_coherent(),
which ends up mapping the allocated memory as uncached. Performing the
various dma_sync_*() operations on this memory causes issues during SPI
flashing:

[    7.818017] pc : dcache_inval_poc+0x40/0x58
[    7.822128] lr : arch_sync_dma_for_cpu+0x2c/0x4c
[    7.826854] sp : ffff80008193bcf0
[    7.830267] x29: ffff80008193bcf0 x28: ffffa3fe5ff1e908 x27: ffffa3fe627bb130
[    7.837528] x26: ffff000086952180 x25: ffff00008015c8ac x24: ffff000086c9b480
[    7.844878] x23: ffff00008015c800 x22: 0000000000000002 x21: 0000000000010000
[    7.852229] x20: 0000000106dae000 x19: ffff000080112410 x18: 0000000000000001
[    7.859580] x17: ffff000080159400 x16: ffffa3fe607a9bd8 x15: ffff0000eac1b180
[    7.866753] x14: 000000000000000c x13: 0000000000000001 x12: 000000000000025a
[    7.874104] x11: 0000000000000000 x10: 7f73e96357f6a07f x9 : db1fc8072a7f5e3a
[    7.881365] x8 : ffff000086c9c588 x7 : ffffa3fe607a9bd8 x6 : ffff80008193bc28
[    7.888630] x5 : 000000000000ffff x4 : 0000000000000009 x3 : 000000000000003f
[    7.895892] x2 : 0000000000000040 x1 : ffff000086dbe000 x0 : ffff000086db0000
[    7.903155] Call trace:
[    7.905606]  dcache_inval_poc+0x40/0x58 (P)
[    7.909804]  iommu_dma_sync_single_for_cpu+0xb4/0xb8
[    7.914617]  __dma_sync_single_for_cpu+0x158/0x194
[    7.919428]  __this_module+0x5b020/0x5baf8 [spi_tegra210_quad]
[    7.925291]  irq_thread_fn+0x2c/0xc0
[    7.928966]  irq_thread+0x16c/0x318
[    7.932467]  kthread+0x12c/0x214

Fix this by removing all calls to the dma_sync_*() functions. This isn't
ideal because DMA is used only for relatively large (> 64 words or 256
bytes) and using uncached memory for this might be slow. Reworking this
to use cached memory for faster access and reintroducing the cache
maintenance calls is probably worth a follow-up patch.

Reported-by: Brad Griffis <bgriffis@nvidia.com>
Fixes: 017f1b0bae08 ("spi: tegra210-quad: Add support for internal DMA")
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 3581757a269b..3be7499db21e 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -407,9 +407,6 @@ tegra_qspi_read_rx_fifo_to_client_rxbuf(struct tegra_qspi *tqspi, struct spi_tra
 static void
 tegra_qspi_copy_client_txbuf_to_qspi_txbuf(struct tegra_qspi *tqspi, struct spi_transfer *t)
 {
-	dma_sync_single_for_cpu(tqspi->dev, tqspi->tx_dma_phys,
-				tqspi->dma_buf_size, DMA_TO_DEVICE);
-
 	/*
 	 * In packed mode, each word in FIFO may contain multiple packets
 	 * based on bits per word. So all bytes in each FIFO word are valid.
@@ -442,17 +439,11 @@ tegra_qspi_copy_client_txbuf_to_qspi_txbuf(struct tegra_qspi *tqspi, struct spi_
 
 		tqspi->cur_tx_pos += write_bytes;
 	}
-
-	dma_sync_single_for_device(tqspi->dev, tqspi->tx_dma_phys,
-				   tqspi->dma_buf_size, DMA_TO_DEVICE);
 }
 
 static void
 tegra_qspi_copy_qspi_rxbuf_to_client_rxbuf(struct tegra_qspi *tqspi, struct spi_transfer *t)
 {
-	dma_sync_single_for_cpu(tqspi->dev, tqspi->rx_dma_phys,
-				tqspi->dma_buf_size, DMA_FROM_DEVICE);
-
 	if (tqspi->is_packed) {
 		tqspi->cur_rx_pos += tqspi->curr_dma_words * tqspi->bytes_per_word;
 	} else {
@@ -478,9 +469,6 @@ tegra_qspi_copy_qspi_rxbuf_to_client_rxbuf(struct tegra_qspi *tqspi, struct spi_
 
 		tqspi->cur_rx_pos += read_bytes;
 	}
-
-	dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
-				   tqspi->dma_buf_size, DMA_FROM_DEVICE);
 }
 
 static void tegra_qspi_dma_complete(void *args)
@@ -701,8 +689,6 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
 				return ret;
 			}
 
-			dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
-						   tqspi->dma_buf_size, DMA_FROM_DEVICE);
 			ret = tegra_qspi_start_rx_dma(tqspi, t, len);
 			if (ret < 0) {
 				dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
-- 
2.49.0


