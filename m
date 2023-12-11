Return-Path: <linux-spi+bounces-202-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EC980CA2E
	for <lists+linux-spi@lfdr.de>; Mon, 11 Dec 2023 13:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25FA281EFA
	for <lists+linux-spi@lfdr.de>; Mon, 11 Dec 2023 12:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCFC3C06C;
	Mon, 11 Dec 2023 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1XFw6mvY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TC0ReHNd"
X-Original-To: linux-spi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59792B0;
	Mon, 11 Dec 2023 04:49:26 -0800 (PST)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702298965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZzKwjWTDOK+X7Q3TY/aJqPSWaSZ1XBXSEY0XUeQD/0=;
	b=1XFw6mvYpdeNplzdWtSzeZwOA3ynoBpM7WEEQXZOxHeokczKH5c6iWlNF1Up6TbIN7FlQS
	TdTo8Lqk8H2im4WQURr5PW1mVg10ATrC3DO5ZrGJwDOrR5JPBxKIO7LwDzL4o3N1+2FEzO
	qaH9Qxks5Abxpyp+ck2ICtCRQVUMCE2s7d5FM7RMNeh5uVXQA+zjA1RBIybA95o1QudDqH
	ngsMSszpQsq8l1J9JleLSI5612kau9EBLhi+cbRhr+L8MFe/4yyfJU0HpKpp7u2lZt6Pzk
	mrCY+Qr5TdMaBRuKYuY0qYyQE+g/j/eaJmwimjiQb+uoy5Lc6IYAuqepD44wdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702298965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZzKwjWTDOK+X7Q3TY/aJqPSWaSZ1XBXSEY0XUeQD/0=;
	b=TC0ReHNdWwpUHHTLM6SA8IlCg8XtXt/ob1vCrK2zV1HUGyN5JpVRH664ZO3riyPDpU/5P+
	CpTHfkqGtftM6dAA==
To: linus.walleij@linaro.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/2] spi: pl022: delete unused cur_gpiod in struct pl022
Date: Mon, 11 Dec 2023 13:49:14 +0100
Message-Id: <7618c9d714aa1c16c7cb06f9d1fb1c074d1d9c65.1702298527.git.namcao@linutronix.de>
In-Reply-To: <cover.1702298527.git.namcao@linutronix.de>
References: <cover.1702298527.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The member cur_gpiod of struct pl022 is not used anywhere. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/spi/spi-pl022.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 1e3bd6f3303a..fd21e83cc3a4 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -361,7 +361,6 @@ struct vendor_data {
  * @dummypage: a dummy page used for driving data on the bus with DMA
  * @dma_running: indicates whether DMA is in operation
  * @cur_cs: current chip select index
- * @cur_gpiod: current chip select GPIO descriptor
  */
 struct pl022 {
 	struct amba_device		*adev;
@@ -393,7 +392,6 @@ struct pl022 {
 	bool				dma_running;
 #endif
 	int cur_cs;
-	struct gpio_desc *cur_gpiod;
 };
=20
 /**
@@ -1344,8 +1342,6 @@ static int pl022_transfer_one(struct spi_controller *=
host, struct spi_device *sp
 	/* Setup the SPI using the per chip configuration */
 	pl022->cur_chip =3D spi_get_ctldata(spi);
 	pl022->cur_cs =3D spi_get_chipselect(spi, 0);
-	/* This is always available but may be set to -ENOENT */
-	pl022->cur_gpiod =3D spi_get_csgpiod(spi, 0);
=20
 	restore_state(pl022);
 	flush(pl022);
--=20
2.39.2


