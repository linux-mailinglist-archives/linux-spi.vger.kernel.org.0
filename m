Return-Path: <linux-spi+bounces-11004-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5394FC34C6F
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 10:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8E514FE61A
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 09:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D593002B0;
	Wed,  5 Nov 2025 09:15:00 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF7A2FFDD7;
	Wed,  5 Nov 2025 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334100; cv=none; b=oOG3b1pjuf1xIYqV4MUAATe18YszgYSQPfYf8pe6mTVxQoxJCT0ryZEiqqhw+RC+oyEs91bNezlZJqd4MIGFrRav9UWk/I5E3EpDuZCLV9mEENGGNuxTaF9IMP5uOXPq4lEtPLrsVqzYncG0QdyY/k9j9ji7FXtwBUyyx6iJdbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334100; c=relaxed/simple;
	bh=L0aDk4Plu85yVCH3iqalIuJYWkQd1A2xQR65lNfVS8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu9mW3K0kluXYVUgFdzAtPlgS8VRTW0dVdThIuKmuJ18QImenV/OTRh0TyINhG/7XYjy/C2K6aydKBk0kAx7dTCPggazHR5TRRWsfip3e1SAo4c+me2ik9AOkbKulHfSTazY+bzDQDZRsjU5xwej7+WMzpcKq21FNfXyeC60iBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: vlRoiHW+R8+7vEsTshjeCg==
X-CSE-MsgGUID: N2AG0fyhRVexwOkfFDo0JQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Nov 2025 18:14:54 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.38])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8F5EF4175ED8;
	Wed,  5 Nov 2025 18:14:49 +0900 (JST)
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
Subject: [PATCH 02/14] spi: rzv2h-rspi: make resets optional
Date: Wed,  5 Nov 2025 11:13:46 +0200
Message-ID: <20251105091401.1462985-3-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs don't have
reset lines for the SPI peripheral, make them optional to prepare for
adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index dcc431ba60a9..09b9362e9b1f 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -384,8 +384,8 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 
 	rspi->resets[0].id = "presetn";
 	rspi->resets[1].id = "tresetn";
-	ret = devm_reset_control_bulk_get_exclusive(dev, RSPI_RESET_NUM,
-						    rspi->resets);
+	ret = devm_reset_control_bulk_get_optional_exclusive(dev, RSPI_RESET_NUM,
+							     rspi->resets);
 	if (ret)
 		return dev_err_probe(dev, ret, "cannot get resets\n");
 
-- 
2.51.2


