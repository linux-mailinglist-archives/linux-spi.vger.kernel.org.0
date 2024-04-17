Return-Path: <linux-spi+bounces-2389-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F028A7C7B
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 08:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8311F23E88
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 06:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9366A347;
	Wed, 17 Apr 2024 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfQnUk7q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5376A346;
	Wed, 17 Apr 2024 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336409; cv=none; b=ZCp5nTQkpyD+QRb76gKfVGWpSVKyXT1BfV5XopiW8IyCGhVSC3ihqRXrGNTBwxu4lpxjF3XjJ+s7I9VroC3r75BKApB+g1Z/mCyBrqmLV4eeg5eqTgV8pamK9Qxq8ARiDSfVnM4ZHTCpiM4c298d6J/NuLFldQhzh9yWdG/7aAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336409; c=relaxed/simple;
	bh=E4q+YSo1YOEMJ7zA55hWRmGVOUH6Obv/UCTB2oZfBqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5gq9dSfyD3MUwJl3utNeP/WX//YwE0ZlaWhHFd9jl7M4sO0KP1uxJZZO+KA+wqhSISKiQeAcVd3bSnkD1F7XV35ckLdU/HBHHfdPozTTwFym2ULbsf8+RjLDCjq1ib++NDIQ3GxAXQHB7BfysBcZQQ6um7WAJoW+BhWeHXa2M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfQnUk7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A342EC072AA;
	Wed, 17 Apr 2024 06:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713336408;
	bh=E4q+YSo1YOEMJ7zA55hWRmGVOUH6Obv/UCTB2oZfBqw=;
	h=From:To:Cc:Subject:Date:From;
	b=tfQnUk7qWz2GdAqxuRNBPdZI4JKeDjq9tCJSrVgW1PceBUmMixF1+PZbVuAjbaJwQ
	 B8rPepPMCT6B7s1jikubJE86n5hHzjLD5YRojCLfCEgdePRpSR4uF1zAIpQQ6ThITn
	 7lJW2OJe2iTq5Fvne8ADvVroOXAxTv8Qgkn8QQBdY5FQdOvOnjZlU8AAaB/YW6fWUi
	 ujuwvt5u1RtkXZSrAPgtvONP0IBzRrzgWk4xpnPcYyd3wn9UVqni6+DEJZQuF9DSyx
	 k445y1M8TtJnuj9ACqbvnx+4j6pqCUePwNE+JkVMziPtBQkVSwXwMD11JY7gHl/6HP
	 9qvfOgnu3eqEw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-spi@vger.kernel.org
Cc: broonie@kernel.org,
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
	angelogioacchino.delregno@collabora.com
Subject: [PATCH v2 0/3] Add add SPI-NAND Flash controller driver for EN7581
Date: Wed, 17 Apr 2024 08:45:49 +0200
Message-ID: <cover.1713335916.git.lorenzo@kernel.org>
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

Changes since v1:
- Introduce spi clock dependency

Lorenzo Bianconi (3):
  dt-bindings: spi: airoha: Add YAML schema for SNFI controller
  arm64: dts: airoha: add EN7581 spi-nand node
  spi: airoha: add SPI-NAND Flash controller driver

 .../bindings/spi/airoha,en7581-snand.yaml     |   72 +
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/airoha/en7581.dtsi        |   21 +
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-airoha-snfi.c                 | 1155 +++++++++++++++++
 6 files changed, 1268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
 create mode 100644 drivers/spi/spi-airoha-snfi.c

-- 
2.44.0


