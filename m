Return-Path: <linux-spi+bounces-3886-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D10933A86
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jul 2024 11:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DC9282FEB
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jul 2024 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8015417E8FA;
	Wed, 17 Jul 2024 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5FDNrGJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1519A;
	Wed, 17 Jul 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210397; cv=none; b=QyIZrG5IQkZmW6V9e02Su7F8/Z9xogPyxW8K8bWSQeEO5wSG1XjWrU6ceTzJ8TzLUrl86odBSf8IQsWls28P8K09A5yelGuJ5F6kakXBRqtn6YnUYuDx4/W/P4jllb5BpEu/7RUjF1PmCXv0tKj6Q4dtuvozAPEVE6YAXoH+1qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210397; c=relaxed/simple;
	bh=he8VWgNCU7bzrhPOnD5ILCidOl9wz74EGBi7h5aUUVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e3k+7aq9dMJluiIDEoIPLYdwMXxvJhOyMSGkqhcP2OI4HGghUuuOSXQy7EbYZ3eUs2SXSWXOTkV6t+oJWbpkW4AenhQyAoZDQFPkIHRiHqf1awvkVRD4cxR1ysEbDVpa4xoOkt0x7cs+cCv2I2DLV9csH3vp7GtmGR8VWKRSxpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5FDNrGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE52BC32782;
	Wed, 17 Jul 2024 09:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721210396;
	bh=he8VWgNCU7bzrhPOnD5ILCidOl9wz74EGBi7h5aUUVI=;
	h=From:To:Cc:Subject:Date:From;
	b=j5FDNrGJFkKFbMFZzndQ7w/ViOHm42OKGAGKool9+monXimfoeWgrN3er6T8Glbzj
	 l1rQlIzYd8GJR5yk+16H71qR4YJQQnyCsJjGofH65XyOLop8zwEUKBQElA9HafpXU8
	 8xDwWpQDDVoGdNGT2mj6AEFIvU6Ot1EF5WKd2+fmJ9EfYNR3MQPCHQtPa5o6fxVI0g
	 2xRgEx6oqukNNYe16Sh4zQK3T/dN/MWjDltqExW5jqphfZlHP60C+jWJLxFt+dIvjZ
	 MiFbYSPoeGSyn2kzWXtdYe3Ya1FwJFe3N3BtT7YVrrZZjIAoTXKrPj1yoC0q9Is+FH
	 q9+2qOWCZK21A==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v1 0/3] Fix incorrect bh2228fv compatible
Date: Wed, 17 Jul 2024 10:59:47 +0100
Message-ID: <20240717-impotence-zippy-254b86593069@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=fLnuQZh3UkLE29exKILxLN0rP8lhx9J0NWCTV9wmm0c=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnTpwnnzXIS7z3tlKa0j69Ne/Um6fBbYaxigXlnZV5v+ R0XZxTbUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIksSmVk+GLqtmGBbOX1Fb3l D2xDKy12fdJb1GftGKI4qWDKpQme/YwMO7ee5PA5/njHXH3f9rV5SUs+fp307new7Hr/HUyHO1j O8QIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Maxime made a typo when adding this device to the kernel all the way
back in 2012, fix the spelling mistake.

Really this device should not be in trivial-devices.yaml, but I'm
leaving the creation of a dedicated binding for when I get my hands on a
device :smiling_imp:

Cheers,
Conor.

CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: Mark Brown <broonie@kernel.org>
CC: Maxime Ripard <mripard@kernel.org> (blamed_fixes:1/1=100%)
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: imx@lists.linux.dev
CC: linux-arm-kernel@lists.infradead.org
CC: linux-spi@vger.kernel.org

Conor Dooley (3):
  dt-bindings: trivial-devices: fix Rohm BH2228FV compatible string
  spi: spidev: add correct compatible for Rohm BH2228FV
  ARM: dts: nxp: correct DAC compatible on Crystalfontz's CFA10049

 Documentation/devicetree/bindings/trivial-devices.yaml | 4 +++-
 arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts           | 2 +-
 drivers/spi/spidev.c                                   | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.43.0


