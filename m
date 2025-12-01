Return-Path: <linux-spi+bounces-11683-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C93AC97AC8
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59DCB343D4E
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682B1316191;
	Mon,  1 Dec 2025 13:43:36 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008FF2ECD28;
	Mon,  1 Dec 2025 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596616; cv=none; b=nk2phOLxP0xBEt6f3Ov3Z3AT0iqcvJ5/7Gu9lGmFreJr0CuqewkOzjx1CIrL7IyNqr/DgXFNAeZRerGqo7FVT4VGQHD01CU6uKB7x/Re4GbJ+BtF5OnpH2QRxnENPQvdMhC9IQG/Rb2yb+NsJndsw32xno4VT8tYUvPT27t0QS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596616; c=relaxed/simple;
	bh=U1O5hkd2zV2cbV4QTachtVEfCAhSsumnJrjriXdmGtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iB09vNb+KKLhLFskGN+2EARs0bvc6XUSiB3Sqgx6F9ORTlqxH3kh9Q+VLS1cYGbaHwAG5GM27nZAomBrABDi1HiXGBrXCn2+h0FACKVRP0UKSW+ibXSC+K7X6I28rWBox3K0sH1S1Y6oSaY5QUzEClEUAb8iXI4o3JVdRy50iXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 2j4og05HRkW8PcMsrBPFEw==
X-CSE-MsgGUID: /3qBSxqTQ5OlOEWtvZIgJw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2025 22:43:33 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8432D4215A4E;
	Mon,  1 Dec 2025 22:43:29 +0900 (JST)
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
Subject: [PATCH 03/13] spi: rzv2h-rspi: do not set SPI_TRANS_FAIL_IO
Date: Mon,  1 Dec 2025 15:42:19 +0200
Message-ID: <20251201134229.600817-4-cosmin-gabriel.tanislav.xa@renesas.com>
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

Setting SPI_TRANS_FAIL_IO has no effect if the transfer completes in the
current context, as it is only handled when .transfer_one() returns > 0,
when the SPI core must wait for the SPI transfer to complete.

Do not set SPI_TRANS_FAIL_IO as we either return an error or 0, since we
do our own waiting.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index beea4fb83d10..02424d4e722a 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -247,9 +247,6 @@ static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
 
 	rzv2h_rspi_clear_all_irqs(rspi);
 
-	if (ret)
-		transfer->error = SPI_TRANS_FAIL_IO;
-
 	return ret;
 }
 
-- 
2.52.0


