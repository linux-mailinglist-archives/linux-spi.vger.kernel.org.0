Return-Path: <linux-spi+bounces-11335-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 416DEC70145
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2041F3A8902
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEF634105B;
	Wed, 19 Nov 2025 16:15:28 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1D334104B;
	Wed, 19 Nov 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568928; cv=none; b=GHPGY7OaOs3FDdIUltB5UynDBTUUTtocqHqkzuQ5tNbq3jE/NRSccjxE7xJ+ddB7LHp9LeOG9XV3CkaZ78tn051MNjh4TL7xTRCwGboeFPP16S+sLSP8srxDBVj5sRlCVfkZmSwxzU2Mm7Veg+2VZJem7J12Qhz/f/tB1pDzOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568928; c=relaxed/simple;
	bh=uncqpIya2APXQ0kbchnR/WkYAHzlwEoOEhPzkJcf7f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uib7wdxjw9/DHwtVAB+vBN6HYOg1jdZwUL3o0dV5taISkSqD4p4IvnWzThLhYclrwB6xSe/2kNcfbIvWekz6SDPRJB75tJi4JDjFZhPS9LIJKgx4ti9jyCJ5NgIYK304Szpt62lGC93AIkAZfUS2IzUL6Wed/FfNBHj5iylZFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: xJ+hEUCMTMqQTIYODITZIw==
X-CSE-MsgGUID: gsbP4jENRoy1IAX3O2VTSw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Nov 2025 01:15:25 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.87])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 15FC4406C476;
	Thu, 20 Nov 2025 01:15:20 +0900 (JST)
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
Subject: [PATCH v4 01/13] spi: rzv2h-rspi: make resets optional
Date: Wed, 19 Nov 2025 18:14:22 +0200
Message-ID: <20251119161434.595677-2-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs don't have
reset lines for the SPI peripheral, make them optional to prepare for
adding support for them.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V4:
 * no changes

V3:
 * no changes

V2:
 * no changes

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
2.52.0

