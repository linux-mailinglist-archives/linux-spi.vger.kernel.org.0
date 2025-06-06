Return-Path: <linux-spi+bounces-8375-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D234AD0351
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 15:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A222718966E2
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCDC288CA1;
	Fri,  6 Jun 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATqrxo2S"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84092288531;
	Fri,  6 Jun 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749217050; cv=none; b=XyFKWnV3McynBvCZLRy/xVdu7GK8NZ00WeZSmK+YUWP298UEOZXzxyFzcNp5ltv23+9K7ZsLGmXTsbcNcWcjerrB7G5bCWcphMHoGSlbeNlTY3YvCQ1DVXXtjnaPSQWPjEyA6pjCW39kpQHKfG5I/UUtC9feg2uTI5UXqdJ9NOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749217050; c=relaxed/simple;
	bh=j1ZG+UVR+5As58K0nOWtz3Gvux3o3cl7YptKLb923LI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qmKknSxwcHPrm8f3dviazesnTAsno5Ik15QGp8ye4oOB891bKryHK753AsOpI8KlEVqZa5CZLu9GGCZ93mBfv5KL4Vpg0q6z+LtaCGxEigAv3T3imAnmxhjTxetYKM5XezX6ncFbTFiNsi/jIY0S0gUhC0wysC8U/C43NyRTvd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATqrxo2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29AE1C4CEF2;
	Fri,  6 Jun 2025 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749217050;
	bh=j1ZG+UVR+5As58K0nOWtz3Gvux3o3cl7YptKLb923LI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ATqrxo2SXxWoHPJer9feNq4yP+txY6GY78Ue+4DmtPi+BM158n6kJOpNA8sbDMD28
	 k0Z4F+f6+n5+BqmR2b03ONdht8F7kovbP3yGlLebrfT2kHeb/uOX/6avJENZ1CUGUa
	 zpydLpYdl31qrNvvgL9jMie7T0f/UTx0aapUzelukchP+KMcWLTh1KNx2dABip88J2
	 eEDpOBYRNg9Xldog4GDEh3HjcqVU+SujNCNTh/NV40xbrg4EM4/ARqjpGMMCHmDVIP
	 XclNR/bMk9Q1qP/hvbfcB4ztR7SIqvaJCCp6s5l3XHAd/EEMVjL5AF1clcRE3PxmpL
	 3trmifwV5RyUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C032C61DB8;
	Fri,  6 Jun 2025 13:37:30 +0000 (UTC)
From: =?utf-8?q?F=C3=A9lix_Pi=C3=A9dallu_via_B4_Relay?= <devnull+felix.piedallu.non.se.com@kernel.org>
Date: Fri, 06 Jun 2025 15:37:25 +0200
Subject: [PATCH 2/2] spi: omap2-mcspi: Disable multi-mode when the previous
 message kept CS asserted
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250606-cs_change_fix-v1-2-27191a98a2e5@non.se.com>
References: <20250606-cs_change_fix-v1-0-27191a98a2e5@non.se.com>
In-Reply-To: <20250606-cs_change_fix-v1-0-27191a98a2e5@non.se.com>
To: Mark Brown <broonie@kernel.org>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?F=C3=A9lix_Pi=C3=A9dallu?= <felix.piedallu@non.se.com>, 
 pascal.eberhard@se.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749217048; l=2225;
 i=felix.piedallu@non.se.com; s=20250606; h=from:subject:message-id;
 bh=ZfK7KhDeQVloCseH0ix7UHPadZvoLWxPnDeBOqVmuHc=;
 b=zAg37+l7LEpXbrIyD57QaE5LxdWhhzikt5JuQVFnSfTgdNHtR2dlVVo/MIXi+fh9L2k8bNtf+
 Csixkf4Oi5rAxvN/O43I2fBIZ7umaEKjlpquA+0lFQttGho9C/QsuWx
X-Developer-Key: i=felix.piedallu@non.se.com; a=ed25519;
 pk=Xe1dw6DIV7hmFbzuJfvaioG+S30kGix0QpIi5qPg99w=
X-Endpoint-Received: by B4 Relay for felix.piedallu@non.se.com/20250606
 with auth_id=427
X-Original-From: =?utf-8?q?F=C3=A9lix_Pi=C3=A9dallu?= <felix.piedallu@non.se.com>
Reply-To: felix.piedallu@non.se.com

From: Félix Piédallu <felix.piedallu@non.se.com>

When the last transfer of a SPI message has the cs_change flag, the CS is kept
asserted after the message.
The next message can't use multi-mode because the CS will be briefly deasserted
before the first transfer.

Remove the early exit of the list_for_each_entry because the last transfer
actually needs to be always checked.

Fixes: d153ff4056cb ("spi: omap2-mcspi: Add support for MULTI-mode")
Signed-off-by: Félix Piédallu <felix.piedallu@non.se.com>
---
 drivers/spi/spi-omap2-mcspi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 05766b98de36f..4c5f12b76de6a 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -134,6 +134,7 @@ struct omap2_mcspi {
 	size_t			max_xfer_len;
 	u32			ref_clk_hz;
 	bool			use_multi_mode;
+	bool			last_msg_kept_cs;
 };
 
 struct omap2_mcspi_cs {
@@ -1269,6 +1270,10 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 	 * multi-mode is applicable.
 	 */
 	mcspi->use_multi_mode = true;
+
+	if (mcspi->last_msg_kept_cs)
+		mcspi->use_multi_mode = false;
+
 	list_for_each_entry(tr, &msg->transfers, transfer_list) {
 		if (!tr->bits_per_word)
 			bits_per_word = msg->spi->bits_per_word;
@@ -1289,22 +1294,17 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 
 		if (list_is_last(&tr->transfer_list, &msg->transfers)) {
 			/* Check if transfer asks to keep the CS status after the whole message */
-			if (tr->cs_change)
+			if (tr->cs_change) {
 				mcspi->use_multi_mode = false;
+				mcspi->last_msg_kept_cs = true;
+			} else {
+				mcspi->last_msg_kept_cs = false;
+			}
 		} else {
 			/* Check if transfer asks to change the CS status after the transfer */
 			if (!tr->cs_change)
 				mcspi->use_multi_mode = false;
 		}
-
-		/*
-		 * If at least one message is not compatible, switch back to single mode
-		 *
-		 * The bits_per_word of certain transfer can be different, but it will have no
-		 * impact on the signal itself.
-		 */
-		if (!mcspi->use_multi_mode)
-			break;
 	}
 
 	omap2_mcspi_set_mode(ctlr);

-- 
2.43.0



