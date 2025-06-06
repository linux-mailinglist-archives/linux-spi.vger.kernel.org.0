Return-Path: <linux-spi+bounces-8373-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E0AD034F
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 15:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1D7E3ADBA6
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC50288C9A;
	Fri,  6 Jun 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWH0n2xz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D7288525;
	Fri,  6 Jun 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749217050; cv=none; b=TaIIo04jA4Kztgp7DTdjwFAL9XSZgJrA4x116TvqNR1uEOWCQ1Kvv3z5i8T/277PADyWACHjDKiESQjSLoIZO9fqM8a/T23cTNjvwJF16ZMs1UD8lslxP1vS/1VEGtq+GAfcEFJ9iAqx5sofMIHZKaBCc7h9o9ieG/gcQhCjLNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749217050; c=relaxed/simple;
	bh=tEh4huufuzq1ic95WEsI0KqGy+7qRjXvIMpWGZsEQyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=seUArZtgcH2Ymz8trb1pQWX+pZQl1ORjlhkkau7KuhuBv2D7PPbhgBk6m0eGhDy4Cs0XGpa0XgGfEe+3sfx+Fhb8PFUO3mcwjYaY+/sJ/Tz46CQ2htUzVUBlscttOimrGJnWBPR0lHSkX3/u50eNE2j49zNRPka8ATyHk0YghPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWH0n2xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CAC3C4CEF0;
	Fri,  6 Jun 2025 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749217050;
	bh=tEh4huufuzq1ic95WEsI0KqGy+7qRjXvIMpWGZsEQyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PWH0n2xz5hiZvfDmGlk5sH0M/AJxmbIO2rgvts8/YauCLdHkR6JGLx7rau9pN79QR
	 aklejQSXoN6NOovylhhT+0tdUCdeqdCc5vMASWWSgi/2Sr6NNtT/lmXedmjlT7vuEM
	 3k/u4NPsZHr/2rz0Bx46lKIWk2t2ZCtIJpto9OOqMidAghE7huFxD/mIKARM5VPv0f
	 oxCLu6pipvLTEUQNCu+L2oB8Su1RhCBrFIT8XyCx4oW5CSIOO7z9q/fBIP7yLBJ41v
	 OQQQxs0r+DOIwX9ji7Ly/PVJf7/HOd+T9Byp9Uztgsv8pR1PtvHNEr104Bar8Z1m3e
	 wO1BsbemPKdpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2A5C5AD49;
	Fri,  6 Jun 2025 13:37:30 +0000 (UTC)
From: =?utf-8?q?F=C3=A9lix_Pi=C3=A9dallu_via_B4_Relay?= <devnull+felix.piedallu.non.se.com@kernel.org>
Date: Fri, 06 Jun 2025 15:37:24 +0200
Subject: [PATCH 1/2] spi: omap2-mcspi: Disable multi mode when CS should be
 kept asserted after message
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250606-cs_change_fix-v1-1-27191a98a2e5@non.se.com>
References: <20250606-cs_change_fix-v1-0-27191a98a2e5@non.se.com>
In-Reply-To: <20250606-cs_change_fix-v1-0-27191a98a2e5@non.se.com>
To: Mark Brown <broonie@kernel.org>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?F=C3=A9lix_Pi=C3=A9dallu?= <felix.piedallu@non.se.com>, 
 pascal.eberhard@se.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749217048; l=1438;
 i=felix.piedallu@non.se.com; s=20250606; h=from:subject:message-id;
 bh=JnAoqQPfwv0/3qSqrSpr+Emp+bDl4r2kMZHc5R7JQHQ=;
 b=8Ly+pvHTwUY2wFGqufeGI2YcF55VFo+rqbUDf1C5kiDONvrNB6+y6N6gl5YdAjDtCD3poym5O
 Ld5KT/ZUM/yDjrWLG8AjzZEGZcDAHgB3oXXN3oIGQ1wYZiSfUeASf8F
X-Developer-Key: i=felix.piedallu@non.se.com; a=ed25519;
 pk=Xe1dw6DIV7hmFbzuJfvaioG+S30kGix0QpIi5qPg99w=
X-Endpoint-Received: by B4 Relay for felix.piedallu@non.se.com/20250606
 with auth_id=427
X-Original-From: =?utf-8?q?F=C3=A9lix_Pi=C3=A9dallu?= <felix.piedallu@non.se.com>
Reply-To: felix.piedallu@non.se.com

From: Félix Piédallu <felix.piedallu@non.se.com>

When the last transfer of a SPI message has the cs_change flag, the CS is kept
asserted after the message.
Multi-mode can't respect this as CS is deasserted by the hardware at the end of
the message.

Disable multi-mode when not applicable to the current message.

Fixes: d153ff4056cb ("spi: omap2-mcspi: Add support for MULTI-mode")
Signed-off-by: Félix Piédallu <felix.piedallu@non.se.com>
---
 drivers/spi/spi-omap2-mcspi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 532b2e9c31d0d..05766b98de36f 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1287,9 +1287,15 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 			mcspi->use_multi_mode = false;
 		}
 
-		/* Check if transfer asks to change the CS status after the transfer */
-		if (!tr->cs_change)
-			mcspi->use_multi_mode = false;
+		if (list_is_last(&tr->transfer_list, &msg->transfers)) {
+			/* Check if transfer asks to keep the CS status after the whole message */
+			if (tr->cs_change)
+				mcspi->use_multi_mode = false;
+		} else {
+			/* Check if transfer asks to change the CS status after the transfer */
+			if (!tr->cs_change)
+				mcspi->use_multi_mode = false;
+		}
 
 		/*
 		 * If at least one message is not compatible, switch back to single mode

-- 
2.43.0



