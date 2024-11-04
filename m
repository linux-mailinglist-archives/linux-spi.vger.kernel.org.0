Return-Path: <linux-spi+bounces-5603-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F42A9BB19A
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 11:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3FDBB2428F
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 10:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47A21B6CFD;
	Mon,  4 Nov 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaYMsEHd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6F1B6CF9;
	Mon,  4 Nov 2024 10:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717460; cv=none; b=WRBiRNXuZjMvxLsA1plXHuCPfxRmpFEq5XWv6++Aa8ZcX15WFTlVqnch5RLQqObYUG5mc9IVkZgsA/MW8dfM2g4elGhUE4QBtsXHBIPl7b88VZm6l5CzitJUjtylE45ISds52LbVpvd9dOV3+Wdcq0ka3a+hyFcu/l5jsKBKf1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717460; c=relaxed/simple;
	bh=zFX/x8ihpVgKkLrPR/NOpvs8U5Bnl1iPYEi4kaxTzUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgfsFTDP9pFoM7duw1A2F3Lt8yjfvdSYUJa0mVSEYr9drbIHn9j/5gcRPnDvaCK7n9d/TF4pEMXTwa8vxECc1cuDbh0kAt77iVUX3l0xdfYK52teCQLQk/lKMNfnt4FP4Sq4eW5xjiLBsF8PdZXIcgoLiu8o57kJ3d8N/dXYSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaYMsEHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8C1C4CED2;
	Mon,  4 Nov 2024 10:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717460;
	bh=zFX/x8ihpVgKkLrPR/NOpvs8U5Bnl1iPYEi4kaxTzUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AaYMsEHdUhfP+ru8PlIg+MjKg/1rkmzIPbJ91lyd43WXj+qAgtYsBZdnsKEqRq/qu
	 csEQXH1vqPfv2HS0CDUiioJbpbzLTlrxXzQyKOq++Axi3VNwPVF6aZ3QFFoU//J2Ce
	 2FFrhEZG5UMEqm9BQaxT1ouAsCIPtE/NTes0kZvRERg5eewBBMZEvSvAt8tHYXG4FM
	 yz47eAh3iSYbc+sTErvn2/350w4ZP/SIV1oI9bHXYz+qW/HKoECkaTGFsnE6Tu44cn
	 etBn/vNGm4jmu06uBCCexvt4oADJQSCC6053JXJYHKNslvbpK3ZZqxnJYYUzvAKEED
	 LTIvHE/j8TT3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 05/21] spi: stm32: fix missing device mode capability in stm32mp25
Date: Mon,  4 Nov 2024 05:49:41 -0500
Message-ID: <20241104105048.96444-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105048.96444-1-sashal@kernel.org>
References: <20241104105048.96444-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.6
Content-Transfer-Encoding: 8bit

From: Alain Volmat <alain.volmat@foss.st.com>

[ Upstream commit b5a468199b995bd8ee3c26f169a416a181210c9e ]

The STM32MP25 SOC has capability to behave in device mode however
missing .has_device_mode within its stm32mp25_spi_cfg structure leads
to not being able to enable the device mode.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Link: https://patch.msgid.link/20241009-spi-mp25-device-fix-v1-1-8e5ca7db7838@foss.st.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-stm32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4c4ff074e3f6f..fc72a89fb3a7b 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2044,6 +2044,7 @@ static const struct stm32_spi_cfg stm32mp25_spi_cfg = {
 	.baud_rate_div_max = STM32H7_SPI_MBR_DIV_MAX,
 	.has_fifo = true,
 	.prevent_dma_burst = true,
+	.has_device_mode = true,
 };
 
 static const struct of_device_id stm32_spi_of_match[] = {
-- 
2.43.0


