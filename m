Return-Path: <linux-spi+bounces-8689-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F7AE1C3A
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 15:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926D91632FC
	for <lists+linux-spi@lfdr.de>; Fri, 20 Jun 2025 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBABE28DF21;
	Fri, 20 Jun 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU8Lfl0H"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424E28DF13;
	Fri, 20 Jun 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426194; cv=none; b=OleiF17FcOrfZy0fbfVY6N2jsG9Pu36JMGsNQDq3CqZ3ukWc0tZJ8rvpVgRScO0jtW3sRCbj20r6xmUlUrMfpMZUcuq8QzKpd60BZlV3KDLLDXfAZ5TOnCMm9zM4RZeJqx8jLzmdaDVuj4spxJVRmyDxMUNPIPW1dl0AIysKRNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426194; c=relaxed/simple;
	bh=lT0wgIbA3b77ZdRhZSsA5m4vTiNAehbZpJBs1x1u0Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c66LRa8Lml3d6PKvXjoltasnOiAdz3SRZ0ACEFqeOJOKdUbPZrV7vz2P3tIS8aKmWo2pIsQq5weEv4lG1dtTv47nCtKaCWeiqKSIIJnacMv9SVUxKPUw8LHwyo/VoSNmnmKFEAPKZTi/ek6m4vzz5VNoRE7I+VHJ+iGjUY/stco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU8Lfl0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86E5C4CEE3;
	Fri, 20 Jun 2025 13:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750426194;
	bh=lT0wgIbA3b77ZdRhZSsA5m4vTiNAehbZpJBs1x1u0Nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GU8Lfl0HaC2B1QPDrOEWh6S8bQUBMkXehTHnP3rRaxkQoZV62tmRRLnp2/ECv2dmS
	 T2OOFz507YiqgsH9rPdUChkcEv/zLbhwz9QGlKHi+UETI2HJAXifUO0OAeDc6DQgqR
	 VnsZA0JUds4mDL1PpZo4Ktl81Qf45Dm3qsB3nAFyq/DDPbtCnBRWnTTQ2j0AKBBatB
	 zlMQlAy1DPKorOSbnU/xpF5G9gzuJNNMPmXY38ZnmupwSaXnGQssde04dyyax9SwuL
	 tFgnB0ImKJZl21VzhKQduMy3qCyphvgY3V6Z7pmdq2NNND1RRztRg60gdJUYvJCwqf
	 O4FPB6dD45GLQ==
From: Conor Dooley <conor@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] spi: microchip-core-qspi: remove unused param from mchp_coreqspi_write_op()
Date: Fri, 20 Jun 2025 14:28:25 +0100
Message-ID: <20250620-starry-excusably-25e6be957d9d@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250620-finer-yoyo-0bcae988a299@spud>
References: <20250620-finer-yoyo-0bcae988a299@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=WCMOD6G4q2tu4R6buWvkebNETPu2QyAxdrWPdw4+wbA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDBmhid+XnCxsPtUhW232NMQ1d03R6mtie41yvjK8u2BQF bB94utdHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIyR8M/+xmdt8u1mwOtG96 r21SLPv4o0jpydh/7P+TBG2lsx5xWzIyTLVScLdbd8+Pf7uOU9dG8abT7ItWSy87316m+WbR59Q zjAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

"word" is unused in mchp_coreqspi_write_op(), so delete it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index 111ae6519ff41..67ff5f8aa84d0 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -194,7 +194,7 @@ static inline void mchp_coreqspi_read_op(struct mchp_coreqspi *qspi)
 	}
 }
 
-static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi, bool word)
+static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi)
 {
 	u32 control, data;
 
@@ -415,7 +415,7 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 		qspi->rxbuf = NULL;
 		qspi->tx_len = op->cmd.nbytes;
 		qspi->rx_len = 0;
-		mchp_coreqspi_write_op(qspi, false);
+		mchp_coreqspi_write_op(qspi);
 	}
 
 	qspi->txbuf = &opaddr[0];
@@ -426,7 +426,7 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 		qspi->rxbuf = NULL;
 		qspi->tx_len = op->addr.nbytes;
 		qspi->rx_len = 0;
-		mchp_coreqspi_write_op(qspi, false);
+		mchp_coreqspi_write_op(qspi);
 	}
 
 	if (op->data.nbytes) {
@@ -435,7 +435,7 @@ static int mchp_coreqspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *o
 			qspi->rxbuf = NULL;
 			qspi->rx_len = 0;
 			qspi->tx_len = op->data.nbytes;
-			mchp_coreqspi_write_op(qspi, true);
+			mchp_coreqspi_write_op(qspi);
 		} else {
 			qspi->txbuf = NULL;
 			qspi->rxbuf = (u8 *)op->data.buf.in;
-- 
2.45.2


