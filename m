Return-Path: <linux-spi+bounces-7810-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21169AA5C90
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 11:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2851BA7D72
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A5D22C35C;
	Thu,  1 May 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfBoIe2j"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81CB221F32;
	Thu,  1 May 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746091265; cv=none; b=kLCyxPQnh7q7yvx7spLSR44JEsuVPjFJnbgCzY/qWQaFPn9ifM4jnSxxy+zHGrlOUjUS2Lmr+sGM0e8TTvaChub0lpSxq9AqMg9OzEHhEaCM8Kn1Ae2TkuW6fu2geF/whSybB81SsHN1KE8zmDqQq8opqv5oZrUw4K3ogWJfaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746091265; c=relaxed/simple;
	bh=sSsvDIDiTu5nOi19ywpZdxlp3ipgkMJ6o2Ryy/qOOTo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r/KfMymt9FsDz5NvbBEtoeCBBBpQKT9QCYvyoOakd1RpVUq5mzyv3GGfOqkT/NLe05bLiNWXne/gwNhoxNyE4+p6P1SZ+lNoybGs92vT1XyRWYXAT3HfCcqiuNy1tJnEOWl2oTLAiuDbh2o88DK+qSQBdjA2W7eNJaG21c4Taug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfBoIe2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FACBC4CEE3;
	Thu,  1 May 2025 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746091265;
	bh=sSsvDIDiTu5nOi19ywpZdxlp3ipgkMJ6o2Ryy/qOOTo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rfBoIe2jCFv2tApHIoGsF1cE9EgUjrm+656Ez2HSi1gUqQRlkYA3gHEp9myCYfejC
	 MltobLrwSqrPllJCTnP7iJ/VJFAqxdpa0QOxsH8FYcJWP4A7HPi5yR4zhgw7d9K9od
	 HlykZCSBin+uBIfcKh6eqMGUrrSkyM3I8gKevccM+xOmktVzT4EAEOwUM6w0WP74fh
	 QZlrB19+UK3Pi31OtuFaSvdpOWseh4lyyv+u4qZUP4eAWXXT2Y5TwXdIwL69RFPwlk
	 fYFD+IYUZ5YJ1cWQo4gG5DJ0416DGrbtDlkqB2m58/fIlpu3bPro1jcIBjH1m07h2f
	 42oTavR30DwrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E89AC369DC;
	Thu,  1 May 2025 09:21:05 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Subject: [PATCH 0/2] Add QPIC SPI NAND support for IPQ5018
Date: Thu, 01 May 2025 13:20:50 +0400
Message-Id: <20250501-ipq5018-spi-qpic-snand-v1-0-31e01fbb606f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPI8E2gC/x2MQQqAIBAAvxJ7bkEtQ/tKdAjdai9mLkQQ/T3pN
 Mxh5gGhwiQwNg8Uulj4SFV020DYl7QRcqwORhmrrNLI+axwKJnxzBxQ0pIi+t4Plpz3puugxrn
 Qyvc/nub3/QClA3oLaAAAAA==
X-Change-ID: 20250501-ipq5018-spi-qpic-snand-94965e899233
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, sadre Alam <quic_mdalam@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746091263; l=712;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=sSsvDIDiTu5nOi19ywpZdxlp3ipgkMJ6o2Ryy/qOOTo=;
 b=dPiMz7NRt1koz/E3E/avUsHajxPy09iBfUN43fwRdISRwABYDTJr4dqvb1UlWfJAWwqysI8fx
 hK+kUXl/TWWAyNs74JEmoWmcAILR3YMmZKqKBEFJJ6ySjpizF5uXSbS
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

Add support for the QPIC SPI NAND controller found in IPQ5018 which is 
the same as the one found in IPQ5018.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
George Moussalem (2):
      dt-bindings: spi: spi-qpic-snand: Add IPQ5018 compatible
      arm64: dts: qcom: ipq5018: Add SPI nand support

 .../bindings/spi/qcom,spi-qpic-snand.yaml          |  8 +++--
 arch/arm64/boot/dts/qcom/ipq5018.dtsi              | 38 ++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)
---
base-commit: 8a2d53ce3c5f82683ad3df9a9a55822816fe64e7
change-id: 20250501-ipq5018-spi-qpic-snand-94965e899233

Best regards,
-- 
George Moussalem <george.moussalem@outlook.com>



