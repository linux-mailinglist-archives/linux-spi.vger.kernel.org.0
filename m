Return-Path: <linux-spi+bounces-11689-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7979DC97B19
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1050A343E5B
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B0E316191;
	Mon,  1 Dec 2025 13:44:11 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7274A315772;
	Mon,  1 Dec 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596651; cv=none; b=VGCjeCQA48GsaeEDS+W3VQzd7HekIqhVUBorvQPK/NQcalokr7l1S1pUjaA7ZzQlwtBdwyXq35IF9SqVnsv44Ciw2henZfvV/SLnGROZz3Z3iQK/XFdC+IEDOiA6l0zdp6u1eMFr9ImnCuD1zGKBVEcMA5J/P2KYZdA0wwmIpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596651; c=relaxed/simple;
	bh=u27xUl0kkOLy0u6f2Vq6bB/XgClSoN0MGg3XY8/l5kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnmtAwWCn778u++zHie7nnFxS4yEvt6J0mIFYs2wm7srT7WVhk3uiYnOhpkuuIC23to9xXQWDoifRUn6bJqs9yjQXkaYoCCLfmEaxtd+WSOTO8Lqjvp1yDmWSso+XnHoHDQpn9hUmDduHM7o1AGhu9iWGaOtJ5DePm/w+Im5NI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: gKuZGwdUTpy7cQ1SKd0kqw==
X-CSE-MsgGUID: mVBLJdHOSoSQDgDnPr5N8w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Dec 2025 22:44:05 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6BAE84215A4E;
	Mon,  1 Dec 2025 22:44:01 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 09/13] spi: rzv2h-rspi: split out PIO transfer
Date: Mon,  1 Dec 2025 15:42:25 +0200
Message-ID: <20251201134229.600817-10-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for implementing DMA support, split out the PIO transfer
code into its own function.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index b31ef2f31f1b..9f5bc047b485 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -219,17 +219,14 @@ static int rzv2h_rspi_receive(struct rzv2h_rspi_priv *rspi, void *rxbuf,
 	return 0;
 }
 
-static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
+static int rzv2h_rspi_transfer_pio(struct rzv2h_rspi_priv *rspi,
 				   struct spi_device *spi,
-				   struct spi_transfer *transfer)
+				   struct spi_transfer *transfer,
+				   unsigned int words_to_transfer)
 {
-	struct rzv2h_rspi_priv *rspi = spi_controller_get_devdata(controller);
-	unsigned int words_to_transfer, i;
+	unsigned int i;
 	int ret = 0;
 
-	transfer->effective_speed_hz = rspi->freq;
-	words_to_transfer = transfer->len / rspi->bytes_per_word;
-
 	for (i = 0; i < words_to_transfer; i++) {
 		rzv2h_rspi_clear_all_irqs(rspi);
 
@@ -240,6 +237,22 @@ static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
 			break;
 	}
 
+	return ret;
+}
+
+static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
+				   struct spi_device *spi,
+				   struct spi_transfer *transfer)
+{
+	struct rzv2h_rspi_priv *rspi = spi_controller_get_devdata(controller);
+	unsigned int words_to_transfer;
+	int ret;
+
+	transfer->effective_speed_hz = rspi->freq;
+	words_to_transfer = transfer->len / rspi->bytes_per_word;
+
+	ret = rzv2h_rspi_transfer_pio(rspi, spi, transfer, words_to_transfer);
+
 	rzv2h_rspi_clear_all_irqs(rspi);
 
 	return ret;
-- 
2.52.0


