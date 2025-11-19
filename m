Return-Path: <linux-spi+bounces-11339-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 469C0C7036D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5075350136D
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D841833A719;
	Wed, 19 Nov 2025 16:15:51 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE780341054;
	Wed, 19 Nov 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568951; cv=none; b=pInl6uDG4oGIzSs3gP/cIRIA7NAzz242SpD/batKlNlfrOW2aToXb6yGTqnOAd44FUfIqEvdXV4JUTXFXMOhl8bVdj0UQcyfFD1cVmgk0m931GTEKL+OXOOR+oepXhI4kFX5MXBCtDq2NLNSNUCbusTLOzq7CIKYTzaie9HTH4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568951; c=relaxed/simple;
	bh=WMBCVlp7oS1U/kuB2jQVoKmXebZj15VCQbxJ6Um5UqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpjepoVSzY04/zPFX17RiEGNnR9cva6rYl2RzbQkNCpSkIkaRLfCNrM5iZg/tQmzToOoWjjhN8UEMCnV0er5TCcKNolv+nq/avqXFaE5V9wo4H4L+B5FrRFpCKFFbSZaof0StdCJZhNrWL8j9qNdvVxlmQr9891mzATHkKQnWXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 0JqcCdKoRXaWNnxOpw1k5Q==
X-CSE-MsgGUID: GCQd4I64TOuu8rTG9Pis6Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Nov 2025 01:15:47 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.87])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9BFB3406C471;
	Thu, 20 Nov 2025 01:15:43 +0900 (JST)
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
Subject: [PATCH v4 05/13] spi: rzv2h-rspi: avoid recomputing transfer frequency
Date: Wed, 19 Nov 2025 18:14:26 +0200
Message-ID: <20251119161434.595677-6-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a more
complicated algorithm for calculating the optimal SPI transfer frequency
compared to RZ/V2H, as the clock from which the SPI frequency is
generated supports multiple dividers.

Cache the requested transfer frequency and skip calling
rzv2h_rspi_setup_clock() if it matches the last used one to prepare for
adding support for variable clock frequency handling.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V4:
 * no changes

V3:
 * no changes

V2:
 * no changes

 drivers/spi/spi-rzv2h-rspi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index f02f25b98ec6..d7719f3c7b13 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -81,6 +81,7 @@ struct rzv2h_rspi_priv {
 	struct clk *tclk;
 	wait_queue_head_t wait;
 	unsigned int bytes_per_word;
+	u32 last_speed_hz;
 	u32 freq;
 	u16 status;
 	u8 spr;
@@ -298,9 +299,13 @@ static int rzv2h_rspi_prepare_message(struct spi_controller *ctlr,
 
 	rspi->bytes_per_word = roundup_pow_of_two(BITS_TO_BYTES(bits_per_word));
 
-	rspi->freq = rzv2h_rspi_setup_clock(rspi, speed_hz);
-	if (!rspi->freq)
-		return -EINVAL;
+	if (speed_hz != rspi->last_speed_hz) {
+		rspi->freq = rzv2h_rspi_setup_clock(rspi, speed_hz);
+		if (!rspi->freq)
+			return -EINVAL;
+
+		rspi->last_speed_hz = speed_hz;
+	}
 
 	writeb(rspi->spr, rspi->base + RSPI_SPBR);
 
-- 
2.52.0

