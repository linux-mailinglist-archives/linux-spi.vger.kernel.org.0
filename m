Return-Path: <linux-spi+bounces-9659-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21D9B33E74
	for <lists+linux-spi@lfdr.de>; Mon, 25 Aug 2025 13:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F3B3A5716
	for <lists+linux-spi@lfdr.de>; Mon, 25 Aug 2025 11:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044229E11D;
	Mon, 25 Aug 2025 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs1sI8/Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D744026B765;
	Mon, 25 Aug 2025 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122894; cv=none; b=kakH/gwbipn52cfquATx89XG9rwIeTFOe4hOJ/J+73UgiDTPoh6eeLpy7ldAyR4izuOk2jdq8gWZYNfVrNEHhVcQiY9TfjxJRUBHweRQ9h67WB32keSJfXGmYLBX5ekrmC/WPoZ2+idsinWw90VgKnq9Yx+tMWx838iYBDTgW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122894; c=relaxed/simple;
	bh=g2gmnboO9nZabnyuX7FiQjLhCojuISQi/XxxNX6cmec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZPKgh8tGkOlCr09eeAkhZiBKghtb1d3rLJyp/iOdzcaDM64Crfao5jcTivbPwzjv1Fd6Axzu2gahWqcH6tRCjPKnbooNZvqYmSpjEtRJMQ6ypMlSFfDm32hQiIkYGLQfIfiLkCR+XrdtPgq9Pulam5b3kkxAyRaF6mvcNPNpxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs1sI8/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802B1C4CEED;
	Mon, 25 Aug 2025 11:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756122893;
	bh=g2gmnboO9nZabnyuX7FiQjLhCojuISQi/XxxNX6cmec=;
	h=From:To:Cc:Subject:Date:From;
	b=Fs1sI8/QMZ5jZaiM1e0UooAx1FeOJOGd8aFTzqvWhmadpCA1Yy1sLY7LzZ6ZIc+aY
	 yX3XMLP+e4Y1eOM6wTw3Ig7GX5z2WNsK9fHaia3NfzMQTTNfpu36JG6VKLa3+1jAsL
	 oaFDlOf1kOhd76TXb+lmJcKJlS0PHKMuQqBMQG4Z6K9nUL4S+Fw7OmD30KiNokru3G
	 Eg+cInAAzjg8P3TmYRSjgHd/boSNI1xGwYeD34iJKgYEEcWZmftqHH3ASi7WbJEnfC
	 0iYnN7wkPT8IAddL15YOoRtutpntZE16ZqOGUFJyO/cppkRA8/IilZCK7i8ItN048z
	 XZmyyMbEbVc0Q==
From: Conor Dooley <conor@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] spi: microchip-core-qspi: stop checking viability of op->max_freq in supports_op callback
Date: Mon, 25 Aug 2025 12:53:28 +0100
Message-ID: <20250825-during-ploy-939bdd068593@spud>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2317; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=963aCcXAFShwXBQl4QTDgw6nzQulhYZfSH5xFVMsRJQ=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlr/Hasuzi779Rfm4260yd83bnlxZnFTeu3Py7dJTxRn tH29puVBR2lLAxiXAyyYoosibf7WqTW/3HZ4dzzFmYOKxPIEAYuTgGYiJMlI8N7myZL1sdLnwfb ZDscWXNjV3J+7R6HZFd2ponJBadVldMZ/meIJRu12p0J+7mKrf78/fC+a7WzNh7IzPVe8Z3hn80 CNUYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

In commit 13529647743d9 ("spi: microchip-core-qspi: Support per spi-mem
operation frequency switches") the logic for checking the viability of
op->max_freq in mchp_coreqspi_setup_clock() was copied into
mchp_coreqspi_supports_op(). Unfortunately, op->max_freq is not valid
when this function is called during probe but is instead zero.
Accordingly, baud_rate_val is calculated to be INT_MAX due to division
by zero, causing probe of the attached memory device to fail.

Seemingly spi-microchip-core-qspi was the only driver that had such a
modification made to its supports_op callback when the per_op_freq
capability was added, so just remove it to restore prior functionality.

CC: stable@vger.kernel.org
Reported-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Fixes: 13529647743d9 ("spi: microchip-core-qspi: Support per spi-mem operation frequency switches")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: Miquel Raynal <miquel.raynal@bootlin.com>
CC: linux-spi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-microchip-core-qspi.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index d13a9b755c7f8..8dc98b17f77b5 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -531,10 +531,6 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 
 static bool mchp_coreqspi_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct mchp_coreqspi *qspi = spi_controller_get_devdata(mem->spi->controller);
-	unsigned long clk_hz;
-	u32 baud_rate_val;
-
 	if (!spi_mem_default_supports_op(mem, op))
 		return false;
 
@@ -557,14 +553,6 @@ static bool mchp_coreqspi_supports_op(struct spi_mem *mem, const struct spi_mem_
 			return false;
 	}
 
-	clk_hz = clk_get_rate(qspi->clk);
-	if (!clk_hz)
-		return false;
-
-	baud_rate_val = DIV_ROUND_UP(clk_hz, 2 * op->max_freq);
-	if (baud_rate_val > MAX_DIVIDER || baud_rate_val < MIN_DIVIDER)
-		return false;
-
 	return true;
 }
 
-- 
2.47.2


