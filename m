Return-Path: <linux-spi+bounces-10881-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD994C14E52
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 14:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555FB62370F
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13E93328EA;
	Tue, 28 Oct 2025 13:33:09 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B8E3314CC;
	Tue, 28 Oct 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761658389; cv=none; b=iBRw2FfL8uQziqg0141kQbbbvtXt6m1dyJzlsMtXeAB2WrUjS5WdHKWedhoIv/cQNBS33vTFzaIrpc2zhls8J8yojOmZdASc4iUfL91puxilBoUzLYS+VQ3Yjz0CeyJDCFv8LReD6RCtzCPdoRZqXicHs0DwN/WQRJFtb+D4Cvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761658389; c=relaxed/simple;
	bh=m22yQ3WQooA+vpLQVH+ph3s0RAn5cUk0wEP6/IF+1oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LU2rIgm0Yj0mUjV7y+9Ld5KgaNAvoDUjr8634Q0pVjrIpIK5/Vy/DEEXKIPiiKQMWH1D+a4U5hkZ2sGRVVv68N+71DGPeU5sqlTiRDi48OW17f9/mWYTbkchxlajdpc5rNX0weKoqrybs6hGn/V0RI/4lqBFWPVw8WOyAP9i9so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: cDSM0R/mQQajfTDO1kDU6Q==
X-CSE-MsgGUID: Iwaspnd+TsCZFgBabCdh6Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 28 Oct 2025 22:33:03 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.5])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7F8A941B5F49;
	Tue, 28 Oct 2025 22:32:58 +0900 (JST)
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
Date: Tue, 28 Oct 2025 15:31:37 +0200
Message-ID: <20251028133151.1487327-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028133151.1487327-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251028133151.1487327-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
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
2.51.1


