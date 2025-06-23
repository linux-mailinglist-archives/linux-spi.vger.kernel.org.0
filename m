Return-Path: <linux-spi+bounces-8712-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D63C6AE3915
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 10:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7140916BD23
	for <lists+linux-spi@lfdr.de>; Mon, 23 Jun 2025 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948CA233712;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLnaw9Cp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A309233155;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750668809; cv=none; b=EbTgXYxcqcSpVoLFlJGZDigDNUbUUkAgNk4qwH2B4A4beqw2vBEaKSQoQi803rODSLVrNI/QArx30N0AlTIo+UpV58/F+/fn8ai1+Yxx1rCrsRBOtDnXk0ZlLgH4UysQ3LsZH2yM5M8hZvYYjtCwgCbzXset+mrU1TB94c5o7oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750668809; c=relaxed/simple;
	bh=p18CvQGKMdeKcKL07AwNst72I3d+5bFuKEFexGALk3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iqNCzRup1njAm2C3tANUVFRW7fp8u703Oj5uB7uyYrRcYmu0lXhm8IIR9V4J0D+HDzxeQNTIHFZY8IXxAx/bghpCHCow+wSJ/vApQ1+7iArdHcowsq0PZmH2O1yAq/GyAB9fYE19R6vacJD249L73zLT9Syt8zmz06goR1gf3NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLnaw9Cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 406A5C4CEEA;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750668809;
	bh=p18CvQGKMdeKcKL07AwNst72I3d+5bFuKEFexGALk3U=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GLnaw9Cp2PbNhvZcLrEeYn5UtzJSMRL/9MfAYcR+1NEaKKmVd/55TozggvHyft3B7
	 ZaD3HbxSG4dLCI3Cd7t3abD/hexg+FBj427L+8Chnh8AJGATJib7NxRyecBoRXDJNF
	 2CoL3ZNr50J7ietyba4WUeyaHe2ZzoLeMs8X51GZCT+nMHmYL7VZCa5AT9ktjzfIWa
	 OJj+qE+7pvPzaSJK8njT2+BbbG4L2wDPZ2YkHfpwvjjJaBB3Qkt+idCToDXSbbavx1
	 JVp39X4q9TAhti6fvyoPOTH+JJSfOvQBBW8+RGnvqwWMhFuJpsgqTb1FzP//eShjzI
	 a88xe5k5bFgZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEBFC77B7F;
	Mon, 23 Jun 2025 08:53:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v3 0/3] support for amlogic the new SPI IP
Date: Mon, 23 Jun 2025 16:53:26 +0800
Message-Id: <20250623-spisg-v3-0-c731f57e289c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAYWWWgC/1WMywqDMBQFf0Xuuil5GI1d9T9KFzGJeqEaSUpoE
 f+9USq0yzmcmQWiC+giXIoFgksY0U8ZxKkAM+ipdwRtZuCUS1pRQeKMsSe16jirFHetNpC/c3A
 dvvbO7Z55wPj04b1nE9vWo1B+C4kRSqRqhG1dYxsprnp8+B7N2fgRtkbiPx6rD49vHtMVlVqVr
 ZX/3rquH0emp13UAAAA
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750668807; l=1629;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=p18CvQGKMdeKcKL07AwNst72I3d+5bFuKEFexGALk3U=;
 b=tUWAfZEfn6V1qOrLffkQ6+jtjMIJ8GSQGkSDtZa3pD8b3NE9PFhjslDCBCXSmbHrP1rPK1I5g
 y2vNtyOW+8hDK/2v8d+rgFyhL7vnYs3Qhllh1TjbVGWVBzO2Vm/7fhd
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Introduced support for the new SPI IP (SPISG). The SPISG is
a communication-oriented SPI controller from Amlogic,supporting
three operation modes: PIO, block DMA, and scatter-gather DMA.

Add the drivers and device tree bindings corresponding to the SPISG.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v3:
- Rename of bit definition and fix some issues.
- Enable runtime_suspend function.
- Link to v2: https://lore.kernel.org/r/20250617-spisg-v2-0-51a605a84bd5@amlogic.com

Changes in v2:
- Use regmap to operation register and drop bitfied define.
- Use "SPISG" prefix intead of "SPICC", and declare clock div table in the spisg_device. 
- Delete other power operation functions except for runtime_supspend and runtime_resume.
- Fix some format corrections.
- Link to v1: https://lore.kernel.org/r/20250604-spisg-v1-0-5893dbe9d953@amlogic.com

---
Sunny Luo (2):
      dt-bindings: spi: Add binding document of Amlogic SPISG controller
      spi: Add Amlogic SPISG driver

Xianwei Zhao (1):
      MAINTAINERS: Add an entry for Amlogic spi driver

 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  |  55 ++
 MAINTAINERS                                        |   9 +
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-amlogic-spisg.c                    | 876 +++++++++++++++++++++
 5 files changed, 950 insertions(+)
---
base-commit: bd30b995df8fd053e13d10f78dbc7b2fa5ed1aae
change-id: 20250603-spisg-78f21682ebac

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



