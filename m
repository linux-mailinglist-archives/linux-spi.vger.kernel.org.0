Return-Path: <linux-spi+bounces-8365-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EA6ACD8B9
	for <lists+linux-spi@lfdr.de>; Wed,  4 Jun 2025 09:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51ED518969DE
	for <lists+linux-spi@lfdr.de>; Wed,  4 Jun 2025 07:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78F2238166;
	Wed,  4 Jun 2025 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhLDvS/J"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF922B8C2;
	Wed,  4 Jun 2025 07:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749022853; cv=none; b=dfbXrfuGhQ9lKNKAJNPRBl4oc/bE21yKh7r3ao0jZbj7RSRDl9gKwoFoWXrhaJxbEnXlLsv0LPpMw9QCWWmTEaWYihKJMMOUPKVPWOqB0egP/IulpyBXk/xnWVt6RUwfj+WyhKwlLKtvonVevjH3xmq29ULTjUpKMDFkgeSeqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749022853; c=relaxed/simple;
	bh=pHr+iNzLv9GxJXJt/p1c4oLkaW7OLQQwQD2ifOprTdk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gryMWx+jyh/nmeojXdMaR+N3sC+of8cx2yWWdt4hgdX4MV9vpff2PNZnty4QJge08m2lVJIKrzF4bPPG7MbZrdy3PNUDwKCMAL4xFb2pNRd2jueQOZRj6t4WlL71VGNe7DIwDEnCX+Gk1CGVnbDXuIRJt1nYkfgY9WXQ52YHPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhLDvS/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 374DEC4CEED;
	Wed,  4 Jun 2025 07:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749022853;
	bh=pHr+iNzLv9GxJXJt/p1c4oLkaW7OLQQwQD2ifOprTdk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YhLDvS/JK1MQjqJOCtFmwY4ee7MnE1rf5k+7mIya90zdFIJZ0WTetG5/26ePTXhiG
	 /1svIGiL6GaK1QRuwQPdTMST0ZZADHh7rblpDdYAcPkAQ/9bbMcvreT4hsTc+/zk/m
	 BlRGWM/WvmCFDRJ7aq6lku1l6OOkio/Ch5mSjVRz0r2J63C0MWxchQrOKD4zvCEteC
	 eqsPlR2aX7ZXv8x7wCLHHc/FsfwezehO5/tIY4+HGbLfWJ/Mu0YGRYwDzWybrY2YiB
	 4EnsOoyCtwy4ipeHNfIs8N/IBPp2wvs6cy51zQlygEb4O3FaJbbAz2jKHUmdheTPVI
	 tZE2CrSZpaqZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE15C5B552;
	Wed,  4 Jun 2025 07:40:53 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] support for amlogic the new SPI IP
Date: Wed, 04 Jun 2025 15:40:50 +0800
Message-Id: <20250604-spisg-v1-0-5893dbe9d953@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIL4P2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwNj3eKCzOJ0XXOLNCNDMwuj1KTEZCWg2oKi1LTMCrA50bG1tQCIsWq
 JVwAAAA==
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749022851; l=1058;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=pHr+iNzLv9GxJXJt/p1c4oLkaW7OLQQwQD2ifOprTdk=;
 b=zYbYWKMNv3d0lQCjOkN7LVwChi6psdws+UWgSlWO/xtLIY8JcHtqxIaHqmCGEcRkP5u6l4uxN
 mPd/KhjEPTcBNK2OHN9ffH7JR2kD8r/8Mo2jJr8HnFlCej2L0E4QD0C
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Introduced support for the new SPI IP (SPISG). The SPISG is
a communication-oriented SPI controller from Amlogic,supporting
three operation modes: PIO, block DMA, and scatter-gather DMA.

Add the drivers and device tree bindings corresponding to the SPISG.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Sunny Luo (2):
      dt-bindings: spi: Add binding document of Amlogic SPISG controller
      spi: Add Amlogic SPISG driver

Xianwei Zhao (1):
      MAINTAINERS: Add an entry for Amlogic spi driver

 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  |  55 ++
 MAINTAINERS                                        |   9 +
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-amlogic-spisg.c                    | 944 +++++++++++++++++++++
 5 files changed, 1018 insertions(+)
---
base-commit: 57cf46cd1fe351846e1b065ca9546eef66675ecd
change-id: 20250603-spisg-78f21682ebac

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



