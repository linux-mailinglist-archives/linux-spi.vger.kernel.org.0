Return-Path: <linux-spi+bounces-2573-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD48B52DA
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 10:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFACD1F20C79
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 08:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CDC1640B;
	Mon, 29 Apr 2024 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0f28w5b"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7915E8B;
	Mon, 29 Apr 2024 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378402; cv=none; b=KNhnnFGK4TjI919iEq6jtz5s/fBEKC019jcZ7jwsBJIvUK+WL/j9kz9OoThaQ7NNvVn6RYChb/Ni9wu2TC2oAC25GbMBuxxrtJxsTzIf/fb5FOhAuBy8vnEL1L5K1b5GDvc8wRhYmtHuca6U/AsuUogd+BvOx7901alhuKrCAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378402; c=relaxed/simple;
	bh=T7Eygal6aBMNI+EhMYkMgd2zHgQb/3RTGV+3ifg4ZDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HPZRpmtt9mSkkB8Nc2f4rufdOd+HqdEiHh5cbIbgDgGvD+vXMddttwo+Mcfi7xnfnzxYlxw0/m/ypP4wDsZ5HyP7eY7c3Rl0DGb+2daduO9f0NBvqLf13UetNahSsZPhevyKiJrBfOBSAoj6QTryeMc4fjIQbo+5U6euFBkXcgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0f28w5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A60C4AF18;
	Mon, 29 Apr 2024 08:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714378401;
	bh=T7Eygal6aBMNI+EhMYkMgd2zHgQb/3RTGV+3ifg4ZDc=;
	h=From:To:Cc:Subject:Date:From;
	b=G0f28w5bShORYkOpUc+NkUt7kHrFgMsEIHH05fkprA00X/UhwPdNQiWfh7bKFWmY7
	 Bqpj4IwWTRhIyykOink1+/KHHMdx1rskPwAes0axDBdQGVMs1cUqyU78+5kVtKhGp0
	 71BD4mg4gk2TYeV8ae6F15EIWWEqsWyOXYYggnxQPHlCuL4rZKbJhm5OmHM1og/NHO
	 TDGVIlKb71HUAGJlFT4W0rR3P19xbJntx/DK0AP6ND55nOZotzdU0IMTFKaxl8A0ii
	 6txg8K5Alr9oR/IKByXup+hg5heOvc7j3GDscITp5HK86fh877V2BpKS+2F+GP9CBZ
	 iEVnojpWUIvtQ==
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
Subject: [PATCH v5 0/3] Add add SPI-NAND Flash controller driver for EN7581
Date: Mon, 29 Apr 2024 10:13:07 +0200
Message-ID: <cover.1714377864.git.lorenzo@kernel.org>
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
  dt-bindings: spi: airoha: Add YAML schema for SNFI controller
  arm64: dts: airoha: add EN7581 spi-nand node
  spi: airoha: add SPI-NAND Flash controller driver

 .../bindings/spi/airoha,en7581-snand.yaml     |   65 +
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/airoha/en7581.dtsi        |   19 +
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-airoha-snfi.c                 | 1129 +++++++++++++++++
 6 files changed, 1233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
 create mode 100644 drivers/spi/spi-airoha-snfi.c

-- 
2.44.0


