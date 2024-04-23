Return-Path: <linux-spi+bounces-2456-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13CA8AE1E8
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 12:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB21BB210F7
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD045FDB5;
	Tue, 23 Apr 2024 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEkuNDYC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077C56772;
	Tue, 23 Apr 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867409; cv=none; b=Sc7ad9HjD8KJoUw17hZmeI1Qb7Is/Foe/NA7GSbuOJ9wzkUoOe/+DUIIcDLBa8iBvF3gTOhdyg9VAN/rw/iLWXcnotzKxsIHsjuTQKbRKorsYY8qXr+QYva9SWZ2U5+aw9OrEgoWO6fZPaBQNrNbBMLCJ63EcXOdF38YRouGjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867409; c=relaxed/simple;
	bh=cJ9NFOj8StSpZEKvOXt32n6ET6DgemWU8IcJOP3Em24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OnGxIDOGUpPXkKJTZtLFO/y2ht8WHDb54cV4p/l9Erzd2qUcULzyuTr4JtOsO8Q6mES5FhNV9D/sj7ucLWvKuc4woTILUi8c2kGtM1xby62oxQsLi07qCg6bnNRirD7mkDduEP1bleflChS1k3e10FCz7ERp5+avrwqMBmYnVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEkuNDYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BBCC116B1;
	Tue, 23 Apr 2024 10:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713867408;
	bh=cJ9NFOj8StSpZEKvOXt32n6ET6DgemWU8IcJOP3Em24=;
	h=From:To:Cc:Subject:Date:From;
	b=vEkuNDYCkJ340IQGEr/CDs2toOaQfjYIt7Mqvsq5drs5yUj4nLDokJlMrDyvhfyo7
	 hvGlwctEJqu9apJHHvie4rD3LD8fQzuZtUleH5b2Du5TnBQ8ttT96XuCQhflpwvzjl
	 Q4GI3CaZqM/MYd0FYpzc6C4OriM0LZTCKm40NnF3BxSFJ+HgJQ8B2x8ilan5ekEZvr
	 ykd8JfVylx2rdNsH3wFKBvJxpiKijHu/3i0IYA3czL5zh+ZsFY73U/yY9jPjXrEmPT
	 F/L1oFA50A8qCgDC5SOuRis7L/g78dwbFLlAC/+MNd6ka0NS7LdHOaXahW4W6Taqbo
	 9ksVpe+gC0DcQ==
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
	angelogioacchino.delregno@collabora.com
Subject: [PATCH v3 0/3] Add add SPI-NAND Flash controller driver for EN7581
Date: Tue, 23 Apr 2024 12:16:34 +0200
Message-ID: <cover.1713866770.git.lorenzo@kernel.org>
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
 drivers/spi/spi-airoha-snfi.c                 | 1156 +++++++++++++++++
 6 files changed, 1260 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
 create mode 100644 drivers/spi/spi-airoha-snfi.c

-- 
2.44.0


