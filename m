Return-Path: <linux-spi+bounces-5621-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 782AB9BC7AE
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 09:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C0B1F227BC
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 08:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EC61FF025;
	Tue,  5 Nov 2024 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeR9jp0D"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0DB1C57B2;
	Tue,  5 Nov 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794124; cv=none; b=OaSF2cQPNRhwXYA5IoCtu/D0mgY/roxv56GYkmIVZr4kqcBOi6cfv6uxVrEVRpqSn5P+tnZrpFOHcj00t0x+pDgbw45NUG+DZbfpWUiGLlQOvloGdLQaCwoIUyUrRA9CA6EnLKAojzeQ4kNJiojuFxIDyX4Q425i3Bp3oX5ZFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794124; c=relaxed/simple;
	bh=dVybQkWmSxoyj1MofMAfodogbPNIcs6eTPaaE0ShWnY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hI9ug16a8Ds+gkzN+sewIQhOaNU0SCdlf75DYFUJJu2HIIvDAWIl1hNmMULGXHcJaWYtaTXmABe93GeANfpYYowxcQAHOmwYS/5WCgxR5Q1U3e/nXfi2GYEjc7NZp+HnobIB3FxFywtiLwru5u/E7egMmTMFk1g924zdmnfi4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeR9jp0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5994FC4CED3;
	Tue,  5 Nov 2024 08:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730794124;
	bh=dVybQkWmSxoyj1MofMAfodogbPNIcs6eTPaaE0ShWnY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GeR9jp0DvXAik3U57DiJEkoWf6UurPcas8la40H39wzxvMSwrstClx0I4YIO7Aew2
	 nx8ZYnWInFFnHhQELxRB8vQ4SqM2NBJ8RGocQEhrqVJDlVF1yqSJm/BCDB8fQb5YHk
	 /A3Om1fQLCM08HTh3jMH9F36tA87+S/H4zfQKLmVJQ5TLZiKHKYxAxThf1CmHClu4M
	 HSsYmABU4w7rCPtSrcEfj/UgJwAuoQYqjVJ9R1G8c8dJURr9cflHNV+Lp2aMv8QcR+
	 8fyt7i3UYYm3JBaJnxAPArkaUf+OkO/oWOxRfxs3n6VN4K4loVVzX4w7eePQqO1LtC
	 rdgwjH0UrtuRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FA9D12664;
	Tue,  5 Nov 2024 08:08:44 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH v4 0/3] Apple SPI controller driver
Date: Tue, 05 Nov 2024 09:08:28 +0100
Message-Id: <20241105-asahi-spi-v4-0-d9734f089fc9@jannau.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHzSKWcC/3WMOw7CMBAFrxJtjZF/wYaKeyCKTbIhS2EiO1igK
 HfHSQUF5Ty9mRkSRaYEp2qGSJkTP0IBu6ugHTDcSHBXGLTUVnqlBCYcWKSRRe+dlQ26o+sclP8
 YqefX1rpcCw+cpkd8b+ms13WrKCW/K1kLKdzBoEdvO2/s+Y4h4HMfaII1k81f1RTVNGVu677xV
 P+oy7J8AP4MY8XeAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3311; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=dVybQkWmSxoyj1MofMAfodogbPNIcs6eTPaaE0ShWnY=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnTNS10XevU7NxYuDXF4oD1r3aXWQzJfnvfrV3A4PHJg+
 Wt5kmNHRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgIm838nIsGpS31nzvbOvrSxo
 z+2fcMReKujW881Py+wbF82XuvBP4THDH56D2bWr5joo7ps+8dDuBI7i7wxO8y0Xnnqz9Kjbbga
 fLE4A
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
      dt-bindings: spi: apple,spi: Add binding for Apple SPI controllers
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



