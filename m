Return-Path: <linux-spi+bounces-203-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E8E80CA2F
	for <lists+linux-spi@lfdr.de>; Mon, 11 Dec 2023 13:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A701F217F2
	for <lists+linux-spi@lfdr.de>; Mon, 11 Dec 2023 12:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F4E3BB5D;
	Mon, 11 Dec 2023 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4JJ2Qk72";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0iOZd71m"
X-Original-To: linux-spi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96918BD;
	Mon, 11 Dec 2023 04:49:27 -0800 (PST)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702298966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3ovit8JRev9mIgnPEoYTIqblldYPcpSv7qLZTfPzw4=;
	b=4JJ2Qk72dcJdeAaIHuGjup/kSea+/yooYgkZFiT0qzQcBSSLz9+okWoWsNtpQ5p/XSqNF4
	EcIkOBZ5m+FV11RvcGy7ew1w0WCdwu1hN7f7r26WWRL/XzntVMOoWLTrkD6wkH9fSuNzcH
	MhriVyGNZ6LpKZwAIYRa3CqO9hui47wMIhWxMbcnLSR2MDFECU+x86OrgRfpvzsIRhwzhI
	CwYwzSV8k7a3PcYWb2NNPhdLLCkvRFghJ2frebp2yQp+hnWkIrehoovWF1Jie+DUvOXZkN
	3A0M2D64VpPWkroKDJbAohZ/S6NvBHWYmm7Rj3Ipap22V2cqMtHRQ2iMPiIF4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702298966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+3ovit8JRev9mIgnPEoYTIqblldYPcpSv7qLZTfPzw4=;
	b=0iOZd71mxsCF/WKwjF1oAFTITnAJpc2esvPgdpjOBoI3gYWbFnaTE8Sbu7j60dj1EtClZr
	iwdCa+vhjo9MS6Dw==
To: linus.walleij@linaro.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/2] spi: pl022: delete unused next_msg_cs_active in struct pl022
Date: Mon, 11 Dec 2023 13:49:15 +0100
Message-Id: <424fec01a75f6a881edcce189ac68b3408b62f29.1702298527.git.namcao@linutronix.de>
In-Reply-To: <cover.1702298527.git.namcao@linutronix.de>
References: <cover.1702298527.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The member next_msg_cs_active of struct pl022 is not used anywhere.
Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/spi/spi-pl022.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index fd21e83cc3a4..3baf45da01cd 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -341,10 +341,6 @@ struct vendor_data {
  * @cur_msg: Pointer to current spi_message being processed
  * @cur_transfer: Pointer to current spi_transfer
  * @cur_chip: pointer to current clients chip(assigned from controller_sta=
te)
- * @next_msg_cs_active: the next message in the queue has been examined
- *  and it was found that it uses the same chip select as the previous
- *  message, so we left it active after the previous transfer, and it's
- *  active already.
  * @tx: current position in TX buffer to be read
  * @tx_end: end position in TX buffer to be read
  * @rx: current position in RX buffer to be written
@@ -372,7 +368,6 @@ struct pl022 {
 	struct pl022_ssp_controller	*host_info;
 	struct spi_transfer		*cur_transfer;
 	struct chip_data		*cur_chip;
-	bool				next_msg_cs_active;
 	void				*tx;
 	void				*tx_end;
 	void				*rx;
--=20
2.39.2


