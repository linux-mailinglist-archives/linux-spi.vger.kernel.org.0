Return-Path: <linux-spi+bounces-3860-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5321F9312DB
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 13:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757A81C213CB
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9038A18A920;
	Mon, 15 Jul 2024 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NWZ6bMT2"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD61891C8;
	Mon, 15 Jul 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042091; cv=none; b=W3OMOgP6+HTISgzGV7s+ti32u8yLN2wZ7iQDP7QiFVRBRhV3oh6soXYhaE+cYi7T0iwyjQJC2TbHCymchSLb+0NkmlwtrjNYVMmAUWNm5w2UjP0UfS7i3icRNNcVX9LIc6xV+ajRqLkLjYuglET0CXUhlJkDHpbOygEwudnQOs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042091; c=relaxed/simple;
	bh=ROe7UsPR7ss9GT5aY20AtdiNpjKexaj0LhZP4rRTvN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyKSPjgUqxbfpaCD8m5yqAoWai8hYS8L6VlotTNt3+QkSyKZ8W2QlYgiIfyRCVuqFQoJU9v6Li+Nby6Oi6F/aTFoNAgq8/bJFInwUpLALLdjktQuqhPOHO7QScN/ssEP27F1tiadxava4Ica6hGNzchncMxAxwweFBvnbidDKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NWZ6bMT2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721042089; x=1752578089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ROe7UsPR7ss9GT5aY20AtdiNpjKexaj0LhZP4rRTvN0=;
  b=NWZ6bMT21ThCDG0r/QHp9dZ/dyQ3g/SNg9Eg1clJ2Y6TybxQrVYduaY0
   gwlFjGwoTeeg69XfeYYqbatZq79lL7DV8tMHsTY2Z2F9Xhi04vNzhlmm5
   wKPWkO/VvpZCKDPtmw83frvV930SbuozYgWdn20hBK85Y3pCfbVXmN7v9
   QnYYypZ8hPagC29iqTpVOH2rlkUTlXHpcG9zzHd1Gwx3vIvBJm7cLlRR3
   6Ijq00eNdnNgzWf/c/dF3CzQM+hTwM5XJpj43F3rTXtu7lNN1pQqnsEOl
   9lsOEt/Cu2c6gsXYmRwlkwSXJm91wogqRSjKFqiaYbCnHPH3a4AhTmyft
   A==;
X-CSE-ConnectionGUID: M47IHorFQcORQBAq4muecw==
X-CSE-MsgGUID: giQIJkGQQa6c2BcWusBZEA==
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="196643522"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2024 04:14:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jul 2024 04:14:41 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 15 Jul 2024 04:14:39 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-spi@vger.kernel.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Steve Wilkins
	<steve.wilkins@raymarine.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 5/6] spi: microchip-core: ensure TX and RX FIFOs are empty at start of a transfer
Date: Mon, 15 Jul 2024 12:13:56 +0100
Message-ID: <20240715-flammable-provoke-459226d08e70@wendy>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715-retail-magnolia-bbd49a657a89@wendy>
References: <20240715-retail-magnolia-bbd49a657a89@wendy>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1477; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=IwY037I1Buk3RhgVWIRP3eVXxpayGZIyfUibzug5kyQ=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlTWYqDDr1eeHGLlIVGplSyx963Zn3nn72eI8zT/zOY+XXL p1n2HaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiI4EmG/zVZZyoM7zTxNp5wCdjQah 2XGajzRY9nf71zQQrT5sP3ohn+u39W2RNX1u2jZMJhFskrWfewL1T8aIjwDouMo98rP0nyAQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Steve Wilkins <steve.wilkins@raymarine.com>

While transmitting with rx_len == 0, the RX FIFO is not going to be
emptied in the interrupt handler. A subsequent transfer could then
read crap from the previous transfer out of the RX FIFO into the
start RX buffer. The core provides a register that will empty the RX and
TX FIFOs, so do that before each transfer.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Steve Wilkins <steve.wilkins@raymarine.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 3d17018cedb08..9f37603ccf10a 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -91,6 +91,8 @@
 #define REG_CONTROL2		(0x28)
 #define REG_COMMAND		(0x2c)
 #define  COMMAND_CLRFRAMECNT	BIT(4)
+#define  COMMAND_TXFIFORST		BIT(3)
+#define  COMMAND_RXFIFORST		BIT(2)
 #define REG_PKTSIZE		(0x30)
 #define REG_CMD_SIZE		(0x34)
 #define REG_HWSTATUS		(0x38)
@@ -493,6 +495,8 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
 	mchp_corespi_set_xfer_size(spi, (spi->tx_len > FIFO_DEPTH)
 				   ? FIFO_DEPTH : spi->tx_len);
 
+	mchp_corespi_write(spi, REG_COMMAND, COMMAND_RXFIFORST | COMMAND_TXFIFORST);
+
 	mchp_corespi_write(spi, REG_SLAVE_SELECT, spi->pending_slave_select);
 
 	while (spi->tx_len)
-- 
2.43.2


