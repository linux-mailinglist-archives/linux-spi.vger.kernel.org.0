Return-Path: <linux-spi+bounces-6938-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0F6A4625B
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 15:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174A1189D66D
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 14:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287BB2222CA;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL+z4glL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089980BEC;
	Wed, 26 Feb 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579559; cv=none; b=aOddYSqyFlg7QC6Nq0ydLjRA4u8s9q/RCP7z8H5E2YGnkyXNpa2akKWnoiPDE9w7IyGvcXGzPW9QJex9tNdA8/ds8S59IV7D+aJNGLIw9i0Bd9TGuxDBaZq6cuUyweSq4NUU2H3BXLrwLPekN28qIWXxs3f0jA5OaIB2TExIhkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579559; c=relaxed/simple;
	bh=qPNp8kJ1SPfm9hzzYuFUJ6PYED9G/nfRjZrkm1H8psw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d0VuYOeUMYMHwbr9xNeihd2jklBXBpfQ6YBkLlXjLQSzdlzpa1g3CkYSUqokpGFIFsRmB5ZSIbgkVqYXe2FvM78ts5GRwUCsrZc2p9GVjeFloXgJMvNjwqvrm/UFTwIm2Ky2hkq//FuuxhrCYS/gn1EvJcKuTQZEWX+3kGMFMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL+z4glL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 725D1C4CED6;
	Wed, 26 Feb 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579558;
	bh=qPNp8kJ1SPfm9hzzYuFUJ6PYED9G/nfRjZrkm1H8psw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=bL+z4glLMLjtif7nD9V/K+zaxSZc5JKr1f6vzndjetO9s6CLSiE3EieO271ZapLua
	 w4DbabGONJtBQ1cSvWyZdKcxYMYuri+cVoFNBGE9GL1l1neZnpGDVJvmQtX9cbgpPE
	 lOeGOExJzZRd4A1YOpI4/eq7TyJG7GOzboFnZCM1G/dPHWZaCUpgLMlrgeo2yMFdxw
	 qAfj7yCnENDpX1iu52Jf2jWpMSjN4jENNcJdsPHbZWxG5v9Tt9l3KjlifPE+GzecVZ
	 h1zoPYVbK32Yj86q11vI5Wr3oKSXojO2e2y6cAFgLNR11Sm7bsA2W6tVdTGNa7fjDd
	 slxQu3SaHJwFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F8CC021B8;
	Wed, 26 Feb 2025 14:19:18 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Subject: [PATCH v2 00/12] arm64: dts: freescale: Add support for the
 GOcontroll Moduline Display
Date: Wed, 26 Feb 2025 15:19:11 +0100
Message-Id: <20250226-initial_display-v2-0-23fafa130817@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8iv2cC/3WNQQqDMBBFryKzbkoyGpGueg+REuOoA2kiiUhFv
 HtT912+B//9AxJFpgSP4oBIGycOPgPeCrCz8RMJHjIDStQSsRLseWXjXgOnxZldjKZBVA3JmjT
 k1RJp5M9VbLvMM6c1xP062NTP/m9tSkihre37sValrsrnFGzwawzO3W14Q3ee5xejftpzswAAA
 A==
X-Change-ID: 20250224-initial_display-fa82218e06e5
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579556; l=2470;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=qPNp8kJ1SPfm9hzzYuFUJ6PYED9G/nfRjZrkm1H8psw=;
 b=RO2wdKrxZIYN3bZWZRvWLLnJ4q4OJ3zzHkzPM4aFfF+XjDIXbjVCFjRpeOidaQRPXZt2qJz7l
 zFN4KACCPHFDLlu/B1Tc95xI78GkFMvm5PPtjNbTX4mec1Lj8g+V8Sc
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

Add inital support for 2 variants of the Moduline Display controller.
This system is powered by the Ka-Ro Electronics tx8p-ml81 COM, which
features an imx8mp SoC.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
Changes in v2:
- Dropped the trivial-devices patch
- Added a patch with bindings for the gocontroll,moduline-module-slot
- Added a patch to spidev.c to enable the spidev driver for the module
  slot
- Added a missing usb-c connector in the av101hdt-a10 variant dts
- Switched to the new bindings for the module slots in the base dts
- Fixed some commit typos
- Link to v1: https://lore.kernel.org/r/20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com

---
Maud Spierings (12):
      dt-bindings: arm: fsl: Add GOcontroll Moduline Display
      dt-bindings: vendor-prefixes: add GOcontroll
      dt-bindings: connector: Add the GOcontroll Moduline module slot bindings
      arm64: dts: imx8mp: Add pinctrl config definitions
      MAINTAINERS: add maintainer for the Ka-Ro tx8p-ml81 COM module
      MAINTAINERS: add maintainer for the GOcontroll Moduline module slot
      MAINTAINERS: add maintainer for the GOcontroll Moduline controllers
      arm64: dts: freescale: add Ka-Ro Electronics tx8p-ml81 COM
      arm64: dts: freescale: Add the GOcontroll Moduline Display baseboard
      arm64: dts: freescale: Add the BOE av101hdt-a10 variant of the Moduline Display
      arm64: dts: freescale: Add the BOE av123z7m-n17 variant of the Moduline Display
      spi: spidev: Add an entry for the gocontroll moduline module slot

 Documentation/devicetree/bindings/arm/fsl.yaml     |   1 +
 .../connector/gocontroll,moduline-module-slot.yaml |  88 ++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  17 +
 arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h     |  27 +
 ...tx8p-ml81-moduline-display-106-av101hdt-a10.dts | 100 ++++
 ...tx8p-ml81-moduline-display-106-av123z7m-n17.dts | 133 +++++
 .../imx8mp-tx8p-ml81-moduline-display-106.dtsi     | 535 ++++++++++++++++++++
 .../arm64/boot/dts/freescale/imx8mp-tx8p-ml81.dtsi | 547 +++++++++++++++++++++
 drivers/spi/spidev.c                               |   2 +
 10 files changed, 1452 insertions(+)
---
base-commit: 2bc63dbeabecce860eb8b261bf67b97552fe7747
change-id: 20250224-initial_display-fa82218e06e5

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>



