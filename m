Return-Path: <linux-spi+bounces-11008-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2364FC34C30
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 10:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF22188837F
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 09:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E5A30B509;
	Wed,  5 Nov 2025 09:15:21 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB633308F34;
	Wed,  5 Nov 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334121; cv=none; b=m8vlVO0vRj/HwvaJBZsX5S+I1xIFySqs2pVkWYig5WgSn/nBmz5Y96nUB8XxWYWkFuvKZnmlTiJBdDo43mW7kW/hfoyndPOTkJq0Ma8rKkGravmcRQOySN6fTPYoXIMjpcP2TffKyfTzvZzXTDnHQHfQWrE7VY+JQGzINhG2asQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334121; c=relaxed/simple;
	bh=K8n+2283Ka0qajuKOt0v+NTUy7TqbZ8VB4fu6UnhKFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPh2rYKR7mDRh45bCon3RRtQp9PtY0lfac5ODFQQu6zZZSFgh+c6QT2ucVt5tk6Yv9KtOt7PfTIHigvF/Jy/ccQWaXa2eGR4XB+I1M0YHNDqImGsiH8NfXSadgPizNB3pcwWWlaVZZFP133CxJgnCWE9BUvRTfkDLdAMTHMr9BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 3DnIL6DUTgWv9EX7HSZIvQ==
X-CSE-MsgGUID: 94edD2dVTcSbouxjVzXqYA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2025 18:15:19 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.38])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8EAE741763F1;
	Wed,  5 Nov 2025 18:15:14 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 06/14] spi: rzv2h-rspi: avoid recomputing transfer frequency
Date: Wed,  5 Nov 2025 11:13:50 +0200
Message-ID: <20251105091401.1462985-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251105091401.1462985-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251105091401.1462985-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
2.51.2


