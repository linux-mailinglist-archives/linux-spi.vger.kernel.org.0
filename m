Return-Path: <linux-spi+bounces-154-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC513807116
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 14:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD3E1C209D0
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 13:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA913A278;
	Wed,  6 Dec 2023 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VmtRfWqV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VCYvcMfl"
X-Original-To: linux-spi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC2122;
	Wed,  6 Dec 2023 05:44:58 -0800 (PST)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701870296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hdgp/KXnKqI/YU7obBU7rXwS3m3tuver7rmEtNCRuvs=;
	b=VmtRfWqV3hQHWw9VM0X/u40G3JBc+TnoL06+8asysJtoMjehNdcAyCYdDP51wOaAb56uYb
	0m998H7iqXzrk57rQrmntYM1KufCXzDaEm18Ixj2nnLThkLIuCCh4s2wKUX1GjDHlK2omr
	+lFUOHFf6qGrpdGvZYbxAM4tRsEIHQ9e0zwYreDKbBTgvQ9w41LA15NKHlpe+5z3pdf+tM
	3TnQdxUk8VxUqR8RKY70iIpQvLkkq3rMsPcUvguZ+v+AFBTP0CsrdxaXaqC9Suh/SruWb6
	I9zWmvTPWLKAH3Lg/o0rjDnOZ+evJKaLMPCjwPC2+HxAKz1xnZLnv09+zsss4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701870296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Hdgp/KXnKqI/YU7obBU7rXwS3m3tuver7rmEtNCRuvs=;
	b=VCYvcMflnN1n0brWx4OSl6nN71wZwkggRM0NknHhe57yunSjqHavDTLKwRqHbmQ9w8gS35
	AOqdkU359WyNczAA==
To: broonie@kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel@zonque.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH] Revert "spi: cadence: Add SPI transfer delays"
Date: Wed,  6 Dec 2023 14:44:46 +0100
Message-Id: <20231206134446.69048-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This reverts commit 855a40cd8cccfbf5597adfa77f55cdc8c44b6e42.

SPI transfer delay is already handled in SPI core. There is no need to
do it again.

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


