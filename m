Return-Path: <linux-spi+bounces-5592-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5876F9B9882
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 20:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6CE1C20CF7
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E220B1D1E62;
	Fri,  1 Nov 2024 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjWMp/O9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE051D14EA;
	Fri,  1 Nov 2024 19:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489208; cv=none; b=j4CiphonQuYRt41oEUqiAZkwXCEzv4km8kPyHziO6hHwVPZKkUMOX1JwtsyGgpgpypVcKhJctnSEa58ygq0XMyUvfH+LX2piJLEKa/HxbHDmHZ5Eywi+0L+Vg9C/0rzvmfGaE7/4Xwv5qbmaRAKLOaawztEMWtNRLnEAREab5Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489208; c=relaxed/simple;
	bh=bNz1oB7QECkZuE3P038Od4nszwKOfKz7QoIkKxCF1j0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VXGKUoECK5dhA3gaWL2b/HZKX4Y0OaIusDTXQm8LJm9QQ+yUYqUPRUkv5x6wabTGLlzhYNbttEa1Ua+RHj6iHUmMxZQjWeJAmMUgMtx+Cd/D+6lu58IXMrBwBvdQE/7F9Vd9+/VKQFVeCym9nfPTUUrw2ToVc8fdHsziGqv/UPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjWMp/O9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3351EC4CED9;
	Fri,  1 Nov 2024 19:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730489208;
	bh=bNz1oB7QECkZuE3P038Od4nszwKOfKz7QoIkKxCF1j0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=EjWMp/O978Wxf8uoB/+4FFLHVIsS0Q2BkZ7oE4NNABpEEr1dX094GH6XixQ97TbJ7
	 ImczDXNBhJa6WXNQGu+PonBxvci8ov6YNQIr1bsZz8radQLypCwwazGr2g9gjJ7Gc+
	 mFJ5SXfTsg4HKTNJ/2yLvTD4LSdrQvXHCwUmatjn/HNPo728Rp8InDr59husPigVq+
	 hskxFSljgqxbcGv8iYAURCLPCd94qM4qghl7vwgqbtX2U2G1wuwb2afZb0QAnSGbgO
	 4NuEoyLN9UAJkg8CkLvrU/Esk4BXeuhAAlVyT0qNRg6pS/nEyjEBaXr82H7okGpr1K
	 G04itdfSJHFXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BE7E6F07F;
	Fri,  1 Nov 2024 19:26:48 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Subject: [PATCH v3 0/3] Apple SPI controller driver
Date: Fri, 01 Nov 2024 20:26:11 +0100
Message-Id: <20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMrJWcC/03MSw7CIBSF4a00dyyGVwQddR+mg6tQuQ5oA5VoG
 vYuMnL4n5x8O2SfyGe4DDskXyjTEluowwD3gPHhGbnWILnU3ArBMGMglldiszWa39CcjTPQ/mv
 yM727dZ1aB8rbkj6dLvK3dkUI/q8UyTgzJ4UWrXZW6fGJMeLrGP0GU631CwOaUVajAAAA
X-Change-ID: 20240811-asahi-spi-f8740ba797d7
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3003; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=bNz1oB7QECkZuE3P038Od4nszwKOfKz7QoIkKxCF1j0=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhnRV7TK207MXz2E6r9ZtqfBvlmvcjEXOFb84t0Xrqa6ZW
 7LeNCyro5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwERCLzAynObT2NL/SyPOZkXS
 PUWrG+/bQ2cd+v9yToa21WPWFZ8Z8xj+Z8RWCZuG/uK8/1fJnWNiVca3Eyu5WwtLL5clLDq3QuE
 uDwA=
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
 drivers/spi/spi-apple.c                            | 531 +++++++++++++++++++++
 5 files changed, 607 insertions(+)
---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240811-asahi-spi-f8740ba797d7

Best regards,
-- 
Janne Grunau <j@jannau.net>



