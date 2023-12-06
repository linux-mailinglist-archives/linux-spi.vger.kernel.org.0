Return-Path: <linux-spi+bounces-161-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2100807311
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 15:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE489281E63
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 14:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BA3381DD;
	Wed,  6 Dec 2023 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ssjWMX8b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QkNV5dZa"
X-Original-To: linux-spi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3124D10C6;
	Wed,  6 Dec 2023 06:52:57 -0800 (PST)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701874375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vaRGVoXrIlt2HgjUs7mRGGr9BwnSNs+Kf5T79EG7bZI=;
	b=ssjWMX8beirkCUmin8cMKUd1xR2AD3wvF5r7TUdBYjgngccpjHlwUnPKV+wDNBmarLTikY
	tva7GLWX+nz9bZUrnlDaaE4Zg3cZG366Qfe+nThMm/dPEjxEfBpLSa/Lv5FAwzcd0GlLsE
	uC8DPKs9JtyE1Q19XeGHL5E/2S5eNuquqg285KUWdnosM5j6kp1/xuf03fahXuXcwLTigz
	AoMqwFDKrX0A2549kmF9FebdKTKXlHudLUxqQ2uSoN9BOQvKOxJenR/PWICTfjbwlZpN3s
	wwLUM+mHC8JMC6EI9PY3E1hkp/kB3cuCiXMZefx5PHG+NMVHJ9LXdkiwpM+oeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701874375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vaRGVoXrIlt2HgjUs7mRGGr9BwnSNs+Kf5T79EG7bZI=;
	b=QkNV5dZamHFmsLAGwjCx11EsaKISJ6lQbxSSSaBlHV1BGs2yFV4cIYQqpkSzJA7uQcAHft
	hCTiVAUceO/7XHDQ==
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel@zonque.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3] spi: cadence: revert "Add SPI transfer delays"
Date: Wed,  6 Dec 2023 15:52:33 +0100
Message-Id: <20231206145233.74982-1-namcao@linutronix.de>
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
v3: add missing change log

v2:
   - update subject format
   - rewrite commit message to be more descriptive

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


