Return-Path: <linux-spi+bounces-11022-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C215C3529E
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 11:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB9C56422C
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E816306D21;
	Wed,  5 Nov 2025 10:43:06 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2272A305E0D;
	Wed,  5 Nov 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339386; cv=none; b=efeIAecrZBhYhBvTQWfrIDFoXPUOB1yBsDB+OPUhinUO/RoaRBIreFNDvV8c3UKZQl6D7QcIFq5njMKXWQHxZGQuuaLt7oliYNBw2RrQsVvH2fjCLhQ4TF+HG5FOATkUK0e7zHrQY5h90nOQ5uND1u8RWH7Bia+QcUeqOof5SIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339386; c=relaxed/simple;
	bh=L0aDk4Plu85yVCH3iqalIuJYWkQd1A2xQR65lNfVS8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VybcF7v1qV6BNKa28w7unaWLVdglkxNqEZmUq8+JJxGECn3iEMVW4RyzmilJGBttnfJU27nMOGkOhrLxmWQTcRkP9eo8g7B12gi0E/bzGsoYUxyvCssHMTkDCecT5LvodQi23G42rqSEZ5HtdIC3VQQr1S7Kgv/7fxXJpx12QR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: +cR7fCREQ9O3JkLXbN43PQ==
X-CSE-MsgGUID: EdVxQ95lQ3eQFicDEeDcyw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Nov 2025 19:43:03 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5127F4001DCB;
	Wed,  5 Nov 2025 19:42:58 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v3 02/14] spi: rzv2h-rspi: make resets optional
Date: Wed,  5 Nov 2025 12:41:39 +0200
Message-ID: <20251105104151.1489281-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251105104151.1489281-1-cosmin-gabriel.tanislav.xa@renesas.com>
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


