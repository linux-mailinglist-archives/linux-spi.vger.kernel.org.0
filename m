Return-Path: <linux-spi+bounces-2299-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B9D8A1297
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 13:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2771C21676
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 11:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256A71487DA;
	Thu, 11 Apr 2024 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqKFIQ3T"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF573145345;
	Thu, 11 Apr 2024 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833753; cv=none; b=JatITU3G/I5T0nGVnixRquF1PALMXjwvpmYX4n7lG980EPuMnP9YGFxp8alwqE1QQeqzVFV75r+S94ITPKhJINbl5ZB//M4eN2yLb8/szEtTwD87/5XomcuVrviCevKIGfL6zvlVzgbenB9DTmaRvUJ74y9jFMrfnXYlCqYGrQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833753; c=relaxed/simple;
	bh=H0hYUoUHZjDxgOQ3vvSzT903/ikqhBk88RpVDT940FI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkVMVx+nlsdjbVmEd69nBy1Auy41yXg4eqUfRlcRvpwrnVP8mI76XHfc4OSh5TL2AAoH89I96vjmmm3XxLHYezLnF7QW52hWzt6M1ZxBKIVHvjxjt9cH9ILmAIrmdjnxcECUfg57ZBEtSDfdaW3E2617Az7yOs74qYQkPuI6jm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqKFIQ3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196D3C43394;
	Thu, 11 Apr 2024 11:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712833752;
	bh=H0hYUoUHZjDxgOQ3vvSzT903/ikqhBk88RpVDT940FI=;
	h=From:To:Cc:Subject:Date:From;
	b=HqKFIQ3T+ucvxZZ74QIdPaNEVpme4ANxYONv55JATRaK7mEt32JfHpJT4v5Pl3LJW
	 l4C1OBpsHXAao9hwOP51ylmRxD4gYN/T7xLQek1Dkzvh4yo7u7vucJOTJfJmn50RFk
	 9B30oNfDXganEGGRtys5ybBlHtP3Vf228+4eMalS7e1bn3soQ7+1brtYWW/pDXN0qD
	 07BKg+HdgPLfeJOAhZjh2bvHDqXkWzBbr96IlVKm/ut/xl0sh+CcNVZtxp6X2vgKHh
	 7BhuvVhYi2vD2rBe58d+ZMYYsuFvHtpQVT2CK1u7F6NWnvX/l4cJXCcOU7fP14T8IA
	 vdsB4CwKMhbLw==
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
Subject: [PATCH 0/3] Add add SPI-NAND Flash controller driver for EN7581
Date: Thu, 11 Apr 2024 13:08:35 +0200
Message-ID: <cover.1712833493.git.lorenzo@kernel.org>
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

Lorenzo Bianconi (3):
  dt-bindings: spi: airoha: Add YAML schema for SNFI controller
  arm64: dts: airoha: add EN7581 spi-nand node
  spi: airoha: add SPI-NAND Flash controller driver

 .../bindings/spi/airoha,spi-airoha-snfi.yaml  |   56 +
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/airoha/en7581.dtsi        |   17 +
 drivers/spi/Kconfig                           |   10 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-airoha-snfi.c                 | 1146 +++++++++++++++++
 6 files changed, 1239 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,spi-airoha-snfi.yaml
 create mode 100644 drivers/spi/spi-airoha-snfi.c

-- 
2.44.0


