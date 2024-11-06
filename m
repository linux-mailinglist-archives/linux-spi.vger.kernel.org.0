Return-Path: <linux-spi+bounces-5633-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362D39BDFC2
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 08:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9B1B23BA8
	for <lists+linux-spi@lfdr.de>; Wed,  6 Nov 2024 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7630B1D2B0E;
	Wed,  6 Nov 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNrOPW/L"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D21D0488;
	Wed,  6 Nov 2024 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879665; cv=none; b=AtoFeF9V+Q7f6c/LJnIfk2TkvljygucVeGLwXTAPgVe9WDw04n4uCvFib70E+GjsIdlCokuIMRst4fBH7bmVk2ce4ph2K70VYc/F87xLKuKYj0glI8vS1PK9ExTQ3LKVaxCbRHNuw732ENW/VLPp3QRBB1YyQdyF8QH/Wy3Uk8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879665; c=relaxed/simple;
	bh=eMru1U320VfLOEr90ChBn78/932lYaJiS4lfyxZ+a6E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o80+I/apMF4iD8PMZDiNs/K3XB9nXnvLuCnohJgmNFT2JLh/iheX8GcUGLaZBk9VVulzt2FfF4pnMx6zu7dNGU2wH2B3R78ST+Kk4lcjqn8rNgr23QSV2TkdPxoIvMIFxmBUtb4IzCDdtFKFGwPlG3E97yYwf2pW5GDsi9/YMhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNrOPW/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE4A9C4CECD;
	Wed,  6 Nov 2024 07:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730879664;
	bh=eMru1U320VfLOEr90ChBn78/932lYaJiS4lfyxZ+a6E=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=BNrOPW/L2fUtsOcrZkYwIgKaRivTA/DTqkC7Y6NIExV9fvgYj1C5WtUZsTnaOgG8y
	 5hL4FlseMM1lNATolCdE8fZC3zcw7upmdILR/7Mr+uQ1fCy3Kb5Ak8DQuc0StTb27V
	 TNvgRs32vAgrnhEjg4j0x2cpYyhD1f8ZIncF6uhKYHg+GDRk/sQdZ2ifmaME4WmqGQ
	 l1JSYY8XJ5e1I/Xj6gbOk2IA8BytxgkjTgh/jk7KVQiSto7htMA7+UZ+AUlMf/ZeIw
	 84OOjZpFQLcDv4yGpeTusTkg2c/FB/FFqPiC13koZH1dMicapg+cVPdpwq8z2Avxq5
	 Vr8vwRLuOSe5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1359D29FB6;
	Wed,  6 Nov 2024 07:54:24 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH v5 0/3] Apple SPI controller driver
Date: Wed, 06 Nov 2024 08:53:59 +0100
Message-Id: <20241106-asahi-spi-v5-0-e81a4f3a8e19@jannau.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcgK2cC/3XMTQ7CIBCG4as0rMXwK+DKexgX0wIWF7SBSjRN7
 y7tqsa4/CbzvDPKLgWX0bmZUXIl5DDEOuShQV0P8e5wsHUjRpggmlIMGfqA8xiw10qQFpRRVqH
 6Pybnw2trXW919yFPQ3pv6cLW61ahlOwrhWGC1YmDBi2s5uLygBjheYxuQmum8L+UV8rbeu6kb
 7WTP1TsqdxTUak1igtPtPGd+aLLsnwAY7dM+hkBAAA=
X-Change-ID: 20240811-asahi-spi-f8740ba797d7
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 Nick Chan <towinchenmi@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=eMru1U320VfLOEr90ChBn78/932lYaJiS4lfyxZ+a6E=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnRthfVb+H/8fi5RsvCV/NTtJStm/uJeLea+SVGV/XrSt
 hsTzCfN6ChlYRDjYpAVU2RJ0n7ZwbC6RjGm9kEYzBxWJpAhDFycAjCRe2EMv1l25t6db/GY/aOn
 gVm/QavywfUlex72HuddsULbsrWKM4fhr7Sz7YPsQ+s+bMhadjzsapdv1InuFaLGajy8hX1Mhht
 /8wEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

Hi all,

This updated series address the review comments from the original
submission in 2021 [1]. It adds a new SPI controller driver for Apple
SoCs and is based on spi-sifive. It has been tested with the generic
jedec,spi-nor support and with a downstream driver for an Apple specific
HID over SPI transport.

As usual, I'm splitting off the MAINTAINERS and DT binding changes.
We would rather merge the MAINTAINERS change through the Asahi-SoC
tree to avoid merge conflicts as things trickle upstream, since
we have other submissions touching that section of the file.

The DT binding change can go via the SPI tree or via ours, but it's
easier if we merge it, as then we can make the DT changes to
instantiate it without worrying about DT validation failures depending
on merge order.

This is mostly Hector's work with a few minor changes to address review
comments from me.

[1] https://lore.kernel.org/linux-spi/20211212034726.26306-1-marcan@marcan.st/

v2:
- removed '#address-cells' and '#size-cells' from the bindings and added
  Rob's Rb:
- fixed (new) checkpatch warnings
- added t8112 (M2) SoC
- shorted long and complex source code lines
- switch to devm_clk_prepare_enable() and devm_pm_runtime_enable()
- switch to dev_err_probe() in probe function
- removed "pdev->dev.dma_mask = NULL;"
- got rid of apple_spi_remove()

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v5:
- use devm_spi_alloc_host()
- switch bindings commit msg prefix to "spi: dt-bindings:"
- Link to v4: https://lore.kernel.org/r/20241105-asahi-spi-v4-0-d9734f089fc9@jannau.net

Changes in v4:
- removed the label from example in the bindings
- really added Rob's Rb: for the bindings added Reviewed/Acked-by: for v3
- alphabetically sorted #includes
- removed leftover platform_set_drvdata
- Link to v3: https://lore.kernel.org/r/20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net

Changes in v3:
- fixed bindings_check warning
- converted top file comment to C++ style comments
- dropped verbose dev_err_probe after failed devm_* function
- stopped setting field in zero initialized struct to 0
- added error handling for devm_pm_runtime_enable()
- Link to v2: https://lore.kernel.org/r/20241101-asahi-spi-v2-0-763a8a84d834@jannau.net

Changes in v2:
- removed '#address-cells' and '#size-cells' from the bindings and added
  Rob's Rb:
- fixed (new) checkpatch warnings
- added t8112 (M2) SoC
- shorted long and complex source code lines
- switch to devm_clk_prepare_enable() and devm_pm_runtime_enable()
- switch to dev_err_probe() in probe function
- removed "pdev->dev.dma_mask = NULL;"
- got rid of apple_spi_remove()
- Link to v1: https://lore.kernel.org/linux-spi/20211212034726.26306-1-marcan@marcan.st/

---
Hector Martin (3):
      spi: dt-bindings: apple,spi: Add binding for Apple SPI controllers
      spi: apple: Add driver for Apple SPI controller
      MAINTAINERS: Add apple-spi driver & binding files

 .../devicetree/bindings/spi/apple,spi.yaml         |  62 +++
 MAINTAINERS                                        |   2 +
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-apple.c                            | 530 +++++++++++++++++++++
 5 files changed, 606 insertions(+)
---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240811-asahi-spi-f8740ba797d7

Best regards,
-- 
Janne Grunau <j@jannau.net>



