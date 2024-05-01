Return-Path: <linux-spi+bounces-2677-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FCB8B8BA8
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 16:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA971F21406
	for <lists+linux-spi@lfdr.de>; Wed,  1 May 2024 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B4212EBEA;
	Wed,  1 May 2024 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7VIk2YQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAFA50248;
	Wed,  1 May 2024 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572414; cv=none; b=eIm9+NwuibbJ5MLENFVlKxDoWPl0tQ/1BthX9W9NVHjvwy1rmLLPp0Ic6frYGDvF22UdhHcyuLH10RIVpZhfnEJlWBVtFW4ZDGq5UzKTbESRb4U1r0nT4khYPUdHhPS6hBtIr47kmWlOkTY42XYjdxKktrsJPY+QLLF0ZSQUCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572414; c=relaxed/simple;
	bh=AcR136gtgNUZp2TMJl2fBlKkyVpp9/41WyUGPmas4wE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTnOxFjQVVGTuAgsPBUtZ9/4BdPiKclq3h5/4e3Zymg+fk/Ra/tKnDMv+13cx0hJFtu7zD00eMR3Tu49AyFy8aHPaTtARob5r5Fpng9bhDXBh42dU1xedW34FV20wvBioukeJkvGFhvpi0wLr1uVUxLkPxaY0yRejtrK+qmCenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7VIk2YQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064EDC072AA;
	Wed,  1 May 2024 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714572413;
	bh=AcR136gtgNUZp2TMJl2fBlKkyVpp9/41WyUGPmas4wE=;
	h=From:To:Cc:Subject:Date:From;
	b=b7VIk2YQmi+N58qtneuqPdrfCJNRsehkQ/LMxgFJGRQiaoxtu9Ux/gef49JVMGNvv
	 YwI0s0cCDhyYLF39ixZpVKa9o/j3Of4lJGmQ9cOzZlKTcTSK/ghpjbsZ6cWcV4do6a
	 QSF2FPuz5bll3/YfWIfjZtYpil8HPblYPSsBhKoHjWbGfHA+03oMLEG9/9S1C4D343
	 Kh6QmkdZjuuwlLhza3f9jPdiYMRu2fAHdpixEmA9VC54XVryOsJFpbmXcBmbBtszel
	 J1BSd+jlTQon3li6yXI/54B78gLdRJbn/6s/HaqyTEi51Wi0KeknavALwayAdMoDz3
	 +Kn7ufz6FaM9A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-spi@vger.kernel.org
Cc: broonie@kernel.org,
	conor@kernel.org,
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
Subject: [PATCH v6 0/3] Add add spi-nand flash controller driver for EN7581
Date: Wed,  1 May 2024 16:06:40 +0200
Message-ID: <cover.1714571980.git.lorenzo@kernel.org>
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

Changes since v5:
- modify patch commit logs
- cosmetic rework
Changes since v4:
- rely on devm_platform_ioremap_resource() routine
- rework airoha_snand_is_page_ops() routine
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
  spi: dt-bindings: Add binding doc for spi-airoha-snfi
  arm64: dts: airoha: en7581: Add spi-nand node
  spi: airoha: Add spi-nand flash controller driver

 .../bindings/spi/airoha,en7581-snand.yaml     |   65 +
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/airoha/en7581.dtsi        |   19 +
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-airoha-snfi.c                 | 1124 +++++++++++++++++
 6 files changed, 1228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
 create mode 100644 drivers/spi/spi-airoha-snfi.c

-- 
2.44.0


