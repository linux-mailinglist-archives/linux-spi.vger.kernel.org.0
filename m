Return-Path: <linux-spi+bounces-3856-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D53B29312D4
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 13:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91071284B1C
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE7C1891B4;
	Mon, 15 Jul 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="D42NYQ07"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C881F187321;
	Mon, 15 Jul 2024 11:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042089; cv=none; b=ULkFgI46DfTtkdDHtVHMvDLbj22AapN+H8CWQEzg86BzyI7oOzPeAtufn9UAO0IyApXWMBtG0BsC0wKZnmQe7ccgv6YQMTSStZu1pgcmt5dzb7DVoy9WKC3n2hUbWCItsPt+8frwX8eActZ2Nqre6KcV3UZFDzw/2j9t0o0CPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042089; c=relaxed/simple;
	bh=hfWxoaB+weAyABy/NreTW04qFF4pRdyc50itF63tchA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anxx5VHTHAOoCRJ4fPw9j/+Epqbuz7sRaT4vSRVY89Vb4c8rIQFUhrbTZB2hq9oIVK12U2nXYq2Z/LHG+tGkW92RLkhhu6Y+KHwZVL9NGqNRxU/SiNNMXQycA7hDjIQTTWCR4FPy66KMAk3y2N4mmGNTidXOFR1gbsBN5rIICWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=D42NYQ07; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721042087; x=1752578087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hfWxoaB+weAyABy/NreTW04qFF4pRdyc50itF63tchA=;
  b=D42NYQ07NnjGd0Jll4trW9276Ty1WkZYkdA4tBT5FzUmN0sqXOWG2a5W
   ypAW6QQ8uX84bJAhWTxW4AcCFoyPK5jzJbCpTAtOXhg0vd8ODdZdB+9UH
   taW5M0UilJ7fGZWR3iC0iCqp0oKFmUPueAl+zxojHY2Wvu/yHbrhmn0le
   /4leLf8FddBjEuYv2mMRYVU2jsYHDa1hcNAauC07wVFb2b0J+L5SPMt59
   9+iGajR/U+dQqwtnN2KhC27c5O/Edv4WSayIwyNwkSNvHfRIzp3mgjlMa
   Fb0uA6ZOBepdqLVczCxD6r3bFfRFeCTYtLpY1tFJ8E3eVnhQBcl8wRLQ8
   A==;
X-CSE-ConnectionGUID: M47IHorFQcORQBAq4muecw==
X-CSE-MsgGUID: J6RSvqlERxOuuH0qqpMWfw==
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="196643517"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2024 04:14:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jul 2024 04:14:30 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 15 Jul 2024 04:14:29 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-spi@vger.kernel.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Steve Wilkins
	<steve.wilkins@raymarine.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>, "Naga
 Sureshkumar Relli" <nagasuresh.relli@microchip.com>
Subject: [PATCH v1 1/6] spi: microchip-core: fix the issues in the isr
Date: Mon, 15 Jul 2024 12:13:52 +0100
Message-ID: <20240715-candied-deforest-585685ef3c8a@wendy>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715-retail-magnolia-bbd49a657a89@wendy>
References: <20240715-retail-magnolia-bbd49a657a89@wendy>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2511; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=4LbD+8Tth44xucP5TVeQVyNTwlcW5fbCgX6OBQwB0Yk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlTWQpnax38EcTAGmv4ZcJ3k9XWCQpb1a7nRUqaCpQuMP7v d9qlo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABO51MjwP4It8E/hV4eDW6/9LPb+x6 fPJMIbsHQNU0h7ViO3GYvzYUaGi63MKgfE9GPCLQN2XImp+3aYYdmhhbdOdbS9PiFZPHcaJwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>

It is possible for the TXDONE interrupt be raised if the tx FIFO becomes
temporarily empty while transmitting, resulting in recursive calls to
mchp_corespi_write_fifo() and therefore a garbage message might be
transmitted depending on when the interrupt is triggered. Moving all of
the tx FIFO writes out of the TXDONE portion of the interrupt handler
avoids this problem.

Most of rest of the TXDONE portion of the handler is problematic too.
Only reading the rx FIFO (and finalising the transfer) when the TXDONE
interrupt is raised can cause the transfer to stall, if the final bytes
of rx data are not available in the rx FIFO when the final TXDONE
interrupt is raised. The transfer should be finalised regardless of
which interrupt is raised, provided that all tx data has been set and
all rx data received.

The first issue was encountered "in the wild", the second is
theoretical.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 634364c7cfe61..a81e1317d52e6 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -380,21 +380,18 @@ static irqreturn_t mchp_corespi_interrupt(int irq, void *dev_id)
 	if (intfield == 0)
 		return IRQ_NONE;
 
-	if (intfield & INT_TXDONE) {
+	if (intfield & INT_TXDONE)
 		mchp_corespi_write(spi, REG_INT_CLEAR, INT_TXDONE);
 
+	if (intfield & INT_RXRDY) {
+		mchp_corespi_write(spi, REG_INT_CLEAR, INT_RXRDY);
+
 		if (spi->rx_len)
 			mchp_corespi_read_fifo(spi);
-
-		if (spi->tx_len)
-			mchp_corespi_write_fifo(spi);
-
-		if (!spi->rx_len)
-			finalise = true;
 	}
 
-	if (intfield & INT_RXRDY)
-		mchp_corespi_write(spi, REG_INT_CLEAR, INT_RXRDY);
+	if (!spi->rx_len && !spi->tx_len)
+		finalise = true;
 
 	if (intfield & INT_RX_CHANNEL_OVERFLOW) {
 		mchp_corespi_write(spi, REG_INT_CLEAR, INT_RX_CHANNEL_OVERFLOW);
@@ -479,8 +476,9 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
 	mchp_corespi_set_xfer_size(spi, (spi->tx_len > FIFO_DEPTH)
 				   ? FIFO_DEPTH : spi->tx_len);
 
-	if (spi->tx_len)
+	while (spi->tx_len)
 		mchp_corespi_write_fifo(spi);
+
 	return 1;
 }
 
-- 
2.43.2


