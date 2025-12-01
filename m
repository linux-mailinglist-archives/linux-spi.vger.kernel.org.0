Return-Path: <linux-spi+bounces-11688-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E52C97B07
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF716345ED7
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E49317701;
	Mon,  1 Dec 2025 13:44:02 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0F431A077;
	Mon,  1 Dec 2025 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596642; cv=none; b=VbsaEZuJYXwiawqiPUDLQzgfat5QTAqy3QtarJ6vlyGonrNKTKg7ke4bxi9YbaECJelp7dev2wmXePGc24jdTlTU2ZLGXASU009Ogs9VI1uT5IWnrBUiv/mIAYUBRow3PLI6KP/881UfBgalAeuZkorTvmxWJ0V6hO3ju3LT9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596642; c=relaxed/simple;
	bh=Sj0hWpswDywnL3Az5mRQyDqd9ixhPFWzW4b3OJTHQJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNqI3xRLGGnlBsnJ7+EZQye4iIVcCa/23krYqARFhXTQenYu+ctM3+iS8tCxzUJFLX0zS83Ica53YKQisHFvuKsfyFobzURDvFvlWRIj6uTVU+MRs4EC0w+jhOWGCXiTc1/zwFwcx8+h0RbjNUZT5ekOg77Ejkbm9wqLmQoDReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: uE+g0GGWQBm01kstQpZWVQ==
X-CSE-MsgGUID: sVr1CqDfT8um6MqpkAzqgQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2025 22:44:00 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 191194215A52;
	Mon,  1 Dec 2025 22:43:55 +0900 (JST)
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
Subject: [PATCH 08/13] spi: rzv2h-rspi: enable TX buffer empty interrupt
Date: Mon,  1 Dec 2025 15:42:24 +0200
Message-ID: <20251201134229.600817-9-cosmin-gabriel.tanislav.xa@renesas.com>
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

In preparation for implementing DMA support, enable the transmit buffer
empty interrupt, which is necessary for DMA to write more data to the
FIFO.

This does not affect the PIO mode as we do not even request the TX
interrupt line.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 83bb0b7400b2..b31ef2f31f1b 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -37,6 +37,7 @@
 /* Register SPCR */
 #define RSPI_SPCR_BPEN		BIT(31)
 #define RSPI_SPCR_MSTR		BIT(30)
+#define RSPI_SPCR_SPTIE		BIT(20)
 #define RSPI_SPCR_SPRIE		BIT(17)
 #define RSPI_SPCR_SCKASE	BIT(12)
 #define RSPI_SPCR_SPE		BIT(0)
@@ -474,6 +475,9 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 	/* SPI receive buffer full interrupt enable */
 	conf32 |= RSPI_SPCR_SPRIE;
 
+	/* SPI transmit buffer empty interrupt enable */
+	conf32 |= RSPI_SPCR_SPTIE;
+
 	/* Bypass synchronization circuit */
 	conf32 |= FIELD_PREP(RSPI_SPCR_BPEN, rspi->use_pclk);
 
-- 
2.52.0


