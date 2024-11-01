Return-Path: <linux-spi+bounces-5581-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DEC9B9318
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 15:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457BF1C21682
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101FD1A2C06;
	Fri,  1 Nov 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epfmS1nf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2975175D2D;
	Fri,  1 Nov 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471118; cv=none; b=q7ZVEmWdUUUMPiLjc1V1qwcVQ6voThZZNqS1yZqWzoyDvrNAPQ4ZtZGBx2CUqBUppftLMSY/GD0cM7U1BsLwc8AgphFAWL9cTjV+8V+lRl1Nx5yoYsYkkMgYr4mdng6jaakxHhFR746ZeCj5/wPBy+Hb3AQ0fozIyrBfxVjav98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471118; c=relaxed/simple;
	bh=G0qwyxNvo32PglzTqhei8HtXuP6KaKJ/ZPAyTNEr4ow=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j+/2f7h7qQoFGmBevSM5fK/9miOLE3qQNhfJPy8p5auCXW6JEW1eUoOFcxgotq0wZFuOOFgDpQNXvPDh4n21X5EKPNOWRO7VTfM9tbY3L5XCa3NIVWZwxFugA5ZUCmxSFzNFzZF+JVSjH4bH46OSvc5AXbaMIX/sHTpZzw7hDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epfmS1nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61BC2C4CECD;
	Fri,  1 Nov 2024 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730471118;
	bh=G0qwyxNvo32PglzTqhei8HtXuP6KaKJ/ZPAyTNEr4ow=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=epfmS1nfY7m4X21UkU8Yhve0XFPrQq/PTKISo4zjRSojhjHMmw+dcvjN+o41fxJYO
	 gOfgx+9Rp7kHFA/axgcrhqhGAsS2QfeQWmCvIGDn5L5hg7OMoqTnwOuTiWHnt491Kp
	 CgCkwOiSfXA+DRPY1ro/zhMBLTk7XNm87nx4/HDmC3Kot6GscvRHjUB3cRJdpo+XZx
	 u6udxCJuceQYC7uavzZwgkkqTZLU+v1IK+BN8k93L8KPlcNF1kpq+oJ6DFcZN5uNl4
	 bFeHCx4ICRxuTlDznX+mzYZlwaBlXrbtM2TiZuGlG3THHWeME8eTYKEXCXtTzRzsFA
	 hXcqRe59P2rYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9B4E6F064;
	Fri,  1 Nov 2024 14:25:18 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH v2 0/3] Apple SPI controller driver
Date: Fri, 01 Nov 2024 15:25:02 +0100
Message-Id: <20241101-asahi-spi-v2-0-763a8a84d834@jannau.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL7kJGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDC0ND3cTixIxM3eKCTN00C3MTg6REc0vzFHMloPqCotS0zAqwWdGxtbU
 A+JADClsAAAA=
X-Change-ID: 20240811-asahi-spi-f8740ba797d7
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2147; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=G0qwyxNvo32PglzTqhei8HtXuP6KaKJ/ZPAyTNEr4ow=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnSVJ2eUV0+uaQqSM1ZfYn3i6Wpx430vJhQ6CJ6Ib3M8r
 tycUizTUcrCIMbFICumyJKk/bKDYXWNYkztgzCYOaxMIEMYuDgFYCIzVjEybP/stWZzsvCBxuBI
 600bTrw5Hrz7gNT0oJbvy4Icn2zXnMDIcMSaed6iqutK05cW+BQ8UeFVP6jSErb22QtXm5y/hn8
 msQMA
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
Hector Martin (3):
      dt-bindings: spi: apple,spi: Add binding for Apple SPI controllers
      spi: apple: Add driver for Apple SPI controller
      MAINTAINERS: Add apple-spi driver & binding files

 .../devicetree/bindings/spi/apple,spi.yaml         |  62 +++
 MAINTAINERS                                        |   2 +
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-apple.c                            | 531 +++++++++++++++++++++
 5 files changed, 607 insertions(+)
---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240811-asahi-spi-f8740ba797d7

Best regards,
-- 
Janne Grunau <j@jannau.net>



