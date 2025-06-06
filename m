Return-Path: <linux-spi+bounces-8374-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5410AD0350
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 15:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396C4189671C
	for <lists+linux-spi@lfdr.de>; Fri,  6 Jun 2025 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDEF288C9D;
	Fri,  6 Jun 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qje3yDI1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7726A28466C;
	Fri,  6 Jun 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749217050; cv=none; b=dLMIdfx9KjErkHGlRulClvbeyrePktYMUH5BrYR7k+1jpZLdc8cb5+gGLw5pJKBpW32X5jklvxs4HbrWhjSwRIInTa4ZirscRHDNhv1jKdu7bcAM/HIGaJG3fq0MKCrqsY76SudaXmw0Ya/DZT0BzFwRoFafxfBB45XbOFKoiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749217050; c=relaxed/simple;
	bh=X7XpGECVvpMPfrkP+mW0VHeflAdnttqoI0luHFxrs/0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lrTaSLHNy/Q6IAGUOp5hLDJwBhau8wO5ARCLvilbUKN3X9LxxiTwt82mKN6OZXgayviKDNcfyGGtxj7C0VOfFNbjVGJ5XqVAi9zqfJnaie+kty2hq8w+XJq0FfJCEw4s6seuwcU6KH0r9fFJ1U77AC7sHkfNiqUAyuThClve3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qje3yDI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AAB9C4CEEB;
	Fri,  6 Jun 2025 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749217050;
	bh=X7XpGECVvpMPfrkP+mW0VHeflAdnttqoI0luHFxrs/0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Qje3yDI1idsepVzll2phkWgJ4pfDcJgTEF0GkiQN+0pRDoh6offPehcXsMQx1sGPT
	 zqdOrNpc+weDdgYADyPcXltXuEklOap0bBypRpwXww7U0ADMc2H2SBXM9tR3vHPD2+
	 OCjTq3ORSQVardg9Sq+TexaVcPcRtDF56E5N5SalvcHSfcxkMZLwJiBO1b5FLc+SPE
	 Xj6JXjVoDwo67uIqnjaiNMFfRL5aYEcbR4q1GZ+BVYsnOn/GHtmgY1thX8dDDHCroh
	 pQiD9PCJzBGxsVjJ1XF4bC/DZo3MSyTrjDXJFh6/8ZBXX3MXjpWVN5VCdpW3JHm6cJ
	 do+xE4R/41tbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93CAC5B555;
	Fri,  6 Jun 2025 13:37:29 +0000 (UTC)
From: =?utf-8?q?F=C3=A9lix_Pi=C3=A9dallu_via_B4_Relay?= <devnull+felix.piedallu.non.se.com@kernel.org>
Subject: [PATCH 0/2] SPI: omap2-mcspi: Fix SPI CS behaviour around
 cs_change in SPI transfers
Date: Fri, 06 Jun 2025 15:37:23 +0200
Message-Id: <20250606-cs_change_fix-v1-0-27191a98a2e5@non.se.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABPvQmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwMz3eTieIhEfFpmhW5SkqlhYrJBmlFScpISUE9BUSpQGGxedGxtLQA
 Snt9UXwAAAA==
To: Mark Brown <broonie@kernel.org>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?F=C3=A9lix_Pi=C3=A9dallu?= <felix.piedallu@non.se.com>, 
 pascal.eberhard@se.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749217048; l=1712;
 i=felix.piedallu@non.se.com; s=20250606; h=from:subject:message-id;
 bh=X7XpGECVvpMPfrkP+mW0VHeflAdnttqoI0luHFxrs/0=;
 b=9Gw88HDO4sOl5Z78eu6YPKIanAs+oYZtHOlWMd9EmPytklBEmMBgCvnt1fSFcAa6kJI1g5fCD
 Zdpio3XEFzRCInG9+sOcIfofNgoy2S5aZKyyLSLqJOf8U/dgj36Hsvv
X-Developer-Key: i=felix.piedallu@non.se.com; a=ed25519;
 pk=Xe1dw6DIV7hmFbzuJfvaioG+S30kGix0QpIi5qPg99w=
X-Endpoint-Received: by B4 Relay for felix.piedallu@non.se.com/20250606
 with auth_id=427
X-Original-From: =?utf-8?q?F=C3=A9lix_Pi=C3=A9dallu?= <felix.piedallu@non.se.com>
Reply-To: felix.piedallu@non.se.com

These patches fix the behaviour of the SPI Chip Select of the OMAP2 MCSPI
driver used on TI SoCs.

The omap2-mcspi driver supports the use of multi mode (multichannel in TI
documentation). In this mode, the CS is asserted and deasserted by the
hardware.

The multi mode is disabled for messages when cs_change=0 for all transfers
(e.g when CS is kept asserted between transfers of a same message).

The multi mode also needs to be disabled for messages when cs_change=1 on the
last transfer (e.g when CS is kept asserted after the WHOLE message), and the
message right after.

Currently, that is not the case and it CS is deasserted by hardware when it
shouldn't.
This breaks peripheral drivers that send multiple messages with the CS asserted
in between.

Patch 1 ensures that multi mode is disabled when cs_change=1 on the last
transfer of the message.

Patch 2 ensures that multi mode is disable on a message following one with
cs_change=1 on the last transfer.

This is the case for the TPM TIS SPI driver that uses this logic for flow
control purposes.

Tested on an AM6442 platform with a TPM ST33HTPH2X32AHE4.

Signed-off-by: Félix Piédallu <felix.piedallu@non.se.com>
---
Félix Piédallu (2):
      spi: omap2-mcspi: Disable multi mode when CS should be kept asserted after message
      spi: omap2-mcspi: Disable multi-mode when the previous message kept CS asserted

 drivers/spi/spi-omap2-mcspi.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)
---
base-commit: c46b66be7eb595e66e93eda13149e0d4f90924ea
change-id: 20250606-cs_change_fix-bb51ac0f2bcb

Best regards,
-- 
Félix Piédallu <felix.piedallu@non.se.com>



