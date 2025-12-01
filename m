Return-Path: <linux-spi+bounces-11687-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01319C97AF0
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2CDA93448BC
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CAE319608;
	Mon,  1 Dec 2025 13:43:57 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A71314A90;
	Mon,  1 Dec 2025 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596637; cv=none; b=XQ75SenBH/04ngAt+LfGi4xGzbKTzJcvtJ7bEhmc62cPGqMI7TcQzXUpourSD+32vl7CY+iXDrMjt8pbCK9WeqPKNidN265c02FRAd2TQdEg4NpW4GqIlErmKI0AuTMqldESkzbtpkNIXaD6YflXOAEf6Rx3aWCf9Dq5eWBWwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596637; c=relaxed/simple;
	bh=BPL2TwvTpcjQX7A4CSXa87cu0XO0kjfn8C+hfo327q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lv1xnCXdxVjTbuoh0D+x0IPtXHLin+xIc17QeeLefuC/x+WBfVj+zbb61bwLjaK5DUaUpGafgQZvyQ/ufdHWzgNkNPlnQ7M1644vLxXfyHFzYz0I+9lJO3LoH49uWlTbLzSK33BWfHhexhzH/TxRpvggH1PRccNwovsyiBXY6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: lCt8/OgPQW67O0ya4J74rw==
X-CSE-MsgGUID: ZHYEJHJtQ4edFFgQke9A4g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2025 22:43:55 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 087574215A52;
	Mon,  1 Dec 2025 22:43:50 +0900 (JST)
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
Subject: [PATCH 07/13] spi: rzv2h-rspi: set TX FIFO threshold to 0
Date: Mon,  1 Dec 2025 15:42:23 +0200
Message-ID: <20251201134229.600817-8-cosmin-gabriel.tanislav.xa@renesas.com>
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

In PIO mode we send data word-by-word, and wait for the received data
to be available after each sent word, making no use of the TX interrupt.

In DMA mode, we need to set the RX and TX FIFO thresholds to 0, as
described in the User Manual.

In preparation for implementing DMA support, set TX FIFO threshold to 0,
as RX FIFO threshold is already 0.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index f0bbbd21c763..83bb0b7400b2 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -501,7 +501,7 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 		writeb(0, rspi->base + RSPI_SSLP);
 
 	/* Setup FIFO thresholds */
-	conf16 = FIELD_PREP(RSPI_SPDCR2_TTRG, rspi->info->fifo_size - 1);
+	conf16 = FIELD_PREP(RSPI_SPDCR2_TTRG, 0);
 	conf16 |= FIELD_PREP(RSPI_SPDCR2_RTRG, 0);
 	writew(conf16, rspi->base + RSPI_SPDCR2);
 
-- 
2.52.0


