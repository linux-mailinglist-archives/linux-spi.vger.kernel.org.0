Return-Path: <linux-spi+bounces-159-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C2F8072BA
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 15:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B47D1F21888
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910ADD2F3;
	Wed,  6 Dec 2023 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vuavcnaq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2GwYdPx0"
X-Original-To: linux-spi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8274A1BD;
	Wed,  6 Dec 2023 06:43:58 -0800 (PST)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701873837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mAF870uQ0onfTlbiDl5VP75x4lowIYu0iaaaG3AvEnM=;
	b=vuavcnaqGzr2N+M1K1Kdm4ls72k288AsQrkpqzvT0Mck1T8T9L2pLSlJNaVULg25ZWBUm6
	GX04rhJxiakvop13d9Ay8yxoF3bysocFzYnbh985VYacL46psHy5p9LSKXJNqhGX5ze5Qj
	gAwx9LMM7FuY09Dt/mneorhtU/iKr282GTkSn5IvYoMh4LNVv9Hyg09ffvKQIU83sBlFD5
	ETxuQ1pgj7RqdjNZXI9shQNiE/40tRHHlesdKsb0Mdh2/18R4CI2kRKFVkn3M9mOQVYtG+
	g3MkR7HiGR4j9pXw2Fyhgcpvki/S1YQasOATxhgPiQ7Ox5gg9sdZt1adO0nvAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701873837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mAF870uQ0onfTlbiDl5VP75x4lowIYu0iaaaG3AvEnM=;
	b=2GwYdPx0vHeTwED8sPssZImual1eE0YffQ1kmhcu6FbpNhwC5lIG8ULgXBmGYZPsa5CitT
	FXZ/9sT56G4DqQAQ==
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel@zonque.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2] spi: cadence: revert "Add SPI transfer delays"
Date: Wed,  6 Dec 2023 15:43:51 +0100
Message-Id: <20231206144351.74492-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The commit 855a40cd8ccc ("spi: cadence: Add SPI transfer delays") adds a
delay after each transfer into the driver's transfer_one(). However,
the delay is already done in SPI core. So this commit unnecessarily
doubles the delay amount. Revert this commit.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/spi/spi-cadence.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 12c940ba074a..bd96d8b546cd 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -451,7 +451,6 @@ static int cdns_transfer_one(struct spi_controller *ctl=
r,
 		udelay(10);
=20
 	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
-	spi_transfer_delay_exec(transfer);
=20
 	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
 	return transfer->len;
--=20
2.39.2


