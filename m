Return-Path: <linux-spi+bounces-6943-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C57AA46263
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 15:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1953A1896721
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A241222333D;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mwm8sfWD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15D222589;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579559; cv=none; b=auLvt17Whcwf4IWR9qfYKe0GTf+iiZQqLsjrBwNGUaO1XWQwkS8oB3W9v64gOIfKOoKk+BN6TV/2272JeAlOa2qsjTEztiWGEjKhr90nHYDJvqsA5Gqbib/dKUQRwlTu6iW+Sq4zxIx+hv4NvLKtkiuWV12WANhmRgqGN/ot48w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579559; c=relaxed/simple;
	bh=9qpPM7N9vuJGBAdiNYiFYqBpqZja21Y/Swf+Oy1Pdo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TPnHtGqSxCXKkvEn+tfgkyTcPEyg3kYFKeBMtZzJb/8U9w+5X4pRQH+inu9ObT2hQhnCp+wFinkr+k+JxHGGXGueBl2/S7iGthme+Z8l6mG93Bledn0S3TuOCIATKT7DNVIZJlIDCG1EWsU31JgDOm8/RxO7L6T+otNm4Nj7XwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mwm8sfWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 159D6C4CEF2;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579559;
	bh=9qpPM7N9vuJGBAdiNYiFYqBpqZja21Y/Swf+Oy1Pdo8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Mwm8sfWDAghhoVCU3JKF4khAIR9U2i0rRDUAvxsYHc+34H3KfrApcE9aqk4HIBA0i
	 pnbyi7NoyModZkjs9Zkgo4YnWElVRRzfqm4oqDdLOrvwJ3mFTMvQ04wlxCsbImHorQ
	 S9Gf3yoC/MmXpNedhEx06QYKLASykFRVvL3V01m4D27I/9UVZM6A3NdBy6kF8g55O4
	 QF8LFY8mGomZh57EVk2gBp4jIfzY8RjWHetv5CvSjON+6jVstxQCLzVK997pIL8nBx
	 bX3aszL35LqeLk01hvxSj2iJp7QR5vTaeV1zsZo+LCWNrcpEINBx3itGM0fY9EflvK
	 nJ77qr7fbCorQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B5DC021B8;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Wed, 26 Feb 2025 15:19:16 +0100
Subject: [PATCH v2 05/12] MAINTAINERS: add maintainer for the Ka-Ro
 tx8p-ml81 COM module
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-initial_display-v2-5-23fafa130817@gocontroll.com>
References: <20250226-initial_display-v2-0-23fafa130817@gocontroll.com>
In-Reply-To: <20250226-initial_display-v2-0-23fafa130817@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579556; l=938;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=7OO/jW02mlmITYurf1caNsK1hmpbzWDELvNR0DyCiU4=;
 b=JQF5eJLd8TKcCGD2C+Z9zMlLVrO2fpysnJnOF+AScUx86YmdKVjIT1WI0RHmfVs/wwWBOll1s
 tmLhs/5IralB0S4so8L4M795iuHqJdftuaxrDYcNgqM95obpIrELjwx
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add GOcontroll as unofficial maintainers of the Ka-Ro tx8p-ml81 COM
module bindings.

This support is not officially done by Ka-Ro electronics, if they at
some point will supporting mainline, this should be changed to them.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f076360ce3c60123e9afa61e6e5822326f72f244..b4c76d7ad890be0f618109918ad89328bc72e8cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12510,6 +12510,12 @@ S:	Maintained
 F:	Documentation/hwmon/k8temp.rst
 F:	drivers/hwmon/k8temp.c
 
+KA-RO TX8P COM MODULE
+M:	Maud Spierings <maudspierings@gocontroll.com>
+L:	devicetree@vger.kernel.org
+S:	Maintained
+F:	arch/arm64/boot/dts/freescale/imx8mp-tx8p-ml81.dtsi
+
 KASAN
 M:	Andrey Ryabinin <ryabinin.a.a@gmail.com>
 R:	Alexander Potapenko <glider@google.com>

-- 
2.48.1



