Return-Path: <linux-spi+bounces-2537-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D48B32B3
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 10:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3821F239A6
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 08:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1B913E3EE;
	Fri, 26 Apr 2024 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5qPrCvr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B323F13D299;
	Fri, 26 Apr 2024 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120264; cv=none; b=mGk6XjyrXCcsshrCpAhlwRn1nUTFfqJuExpLWnEPPOy8yVFhU3qwMS/bkK76l8gjXXSGesS1zqyjzMoEl9z5gSi3T2EXzkrhm/DGtdkYQ8ZhLIAlabjzj1kAIWsi8dsWhj3rb3AkHqh0nO0zrHJ/4LfpkK5PRaO9nBh+zCo0+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120264; c=relaxed/simple;
	bh=xEJxo/IFZ1VAdQlbjcXpjYoT0TT7S1CbrsmFgJ9ucSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=df7/TPhGvjJrQsd8byUC8TJMxxr9lDhn5UTU/IX5fpN35J8OOlIfhzUS+31LYSn50l6PkUuoZ52f1bmQ8swvs+LtMyOexUmb1ctXwqJHWsLxzz3UV7e2dstC0ThepBDMbZVnwPJfZyswxwUfsidFudc4NaLTgQ0Xui4sZXTL13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5qPrCvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77B8C2BD10;
	Fri, 26 Apr 2024 08:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714120264;
	bh=xEJxo/IFZ1VAdQlbjcXpjYoT0TT7S1CbrsmFgJ9ucSU=;
	h=From:To:Cc:Subject:Date:From;
	b=J5qPrCvrcdOOnmUzXoTGMaLhG4gywToNkM3hPZMGL9EETjhoukxuRLiLmtNwUdOVp
	 hXcrNyjPhJh+M527exCzJN8zPQew3UE2P/JIWq8Kv5bsoQBmHTBr4Hd5w4bdrGomZG
	 RYjfjYTl3DtfV6dk/8wDtYHWWV2PX2W6xsQGfDyICxQNsdkX0oNLqh6sKxQTKkP8Ga
	 QLg6i98voVJwl3Nb9yi6F/A7O8sJsusQQ7kdNPwhfyZDQd4IbwW7ITqJLKJZ4MFSNV
	 4QH0/Y/58aDuMgCtzDbxfwr8Qq3njhc39i+YI+pG12ozU0g7NFnId4KtCRpM9nEU8f
	 2nw3OPNXl3neA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	broonie@kernel.org,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	nbd@nbd.name,
	john@phrozen.org,
	dd@embedd.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	andy.shevchenko@gmail.com
Subject: [PATCH v4 0/3] Add add SPI-NAND Flash controller driver for EN7581
Date: Fri, 26 Apr 2024 10:30:50 +0200
Message-ID: <cover.1714119615.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for SPI-NAND driver of the Airoha NAND Flash Interface
found on Airoha ARM EN7581 SoCs.

Changes since v3:
- rely on devm_kzalloc() to allocate airoha_snand_dev buffers
- rely on dev_err_probe()
- cosmetic rework
Changes since v2:
- Fix compilation warnings
- Remove interrupt entry in dts since it is not connected so far
Changes since v1:
- Introduce spi clock dependency

Lorenzo Bianconi (3):
  dt-bindings: spi: airoha: Add YAML schema for SNFI controller
  arm64: dts: airoha: add EN7581 spi-nand node
  spi: airoha: add SPI-NAND Flash controller driver

 .../bindings/spi/airoha,en7581-snand.yaml     |   65 +
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/airoha/en7581.dtsi        |   19 +
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-airoha-snfi.c                 | 1140 +++++++++++++++++
 6 files changed, 1244 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
 create mode 100644 drivers/spi/spi-airoha-snfi.c

-- 
2.44.0


