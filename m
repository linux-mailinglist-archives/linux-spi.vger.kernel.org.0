Return-Path: <linux-spi+bounces-6942-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C5EA46262
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 15:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198503B315B
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D47B22332A;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spwp8u9F"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48C14D283;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579559; cv=none; b=UwvbKnCe71HUF35Zmd/nULnHV0bDO4r8TGMQD+ru4rLRS9SHkSZfL5rMyspZsdVa5Bx8vxL+y09p2Vm0JeM73YHaevin2ZXA/dQ/uyZH+8caNCfGMlDSGSmDAHHewLWEcKybtx0eQjrK1beE0B94zfwSYa4tB9hfGz3mvE7UtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579559; c=relaxed/simple;
	bh=PxgLGq6+qrxKe3Hxsa6qgMFp45GE/6elawfTgJ3Xenw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u6Ai2hBi0EnfUseqPoqp2ltvJKI7KB5fSFn+hiDwzmvIALEtAlvpcpDoH4RAOYN64G/LLZDBHQbJKbYA3MmOtJZlhgvJxBjLXj3Dt1ySJmp9wJ5GqVk8+mQw5Yp3pTTSqr90q7Qswy0nAwZwCXMOPlf0/tbc6wUMODMbSqTezGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spwp8u9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3843DC4CEF6;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579559;
	bh=PxgLGq6+qrxKe3Hxsa6qgMFp45GE/6elawfTgJ3Xenw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Spwp8u9FWTDkamXymTccOY/VJczw3W4EolYJxoaflzpLvrdyjDJwQWvkOsBD6qs0g
	 KG5prWWLZ9ArPRC1Z0QUXMNkv8QNNLL0N64AwT2llROUoGPvth+ABfIByTL7WkYdcB
	 gmbNVdZm3uL/4p+fMqB3OMo8tblq/hcaJUY7c+QSYbcZS6Jjcn/JoWDa5NxtiyM/HD
	 HOuD0qlBQv1nxFwSGFqsL0i0jrw/vjXnALMTDDhC3X9Fbz3VQMSwMIDHYjCYAxG68I
	 Vs+y8RFeXOMJK8njAGBvJd4zY8nvYvzcrYBw7vY4m50OsXnxNc1K8Y3SUw7Qce3jXx
	 KuIgLvK5M4PcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7B7C021B8;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Wed, 26 Feb 2025 15:19:18 +0100
Subject: [PATCH v2 07/12] MAINTAINERS: add maintainer for the GOcontroll
 Moduline controllers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-initial_display-v2-7-23fafa130817@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579556; l=782;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=nusWR5q5TNk92/50ob68LPNw76A3tW54RO2mF3ZYb0Y=;
 b=2CgGNin8Ebwh3dwvAYR2RELJiEsDuzfLytOtPMjDQUyT9S4KJgYogOrsUyQRb3lAL4OlDa0cM
 Ilcbio1GW0/AE0PKNGMKXGCOzztNLF+WAmj2VkhhJ6eGXVBLYODscXl
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add a maintainer for the GOcontroll Moduline series of controllers.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d75c66942ca2059e7a054072502b726d1dec04c..47fc659957d94e6dfbe3d8dc4aef80b2349a1104 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9843,6 +9843,12 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/usb/go7007/
 
+GOCONTROLL MODULINE CONTROLLERS
+M:	Maud Spierings <maudspierings@gocontroll.com>
+L:	devicetree@vger.kernel.org
+S:	Maintained
+F:	arch/arm64/boot/dts/freescale/*moduline*.dts*
+
 GOCONTROLL MODULINE MODULE SLOT
 M:	Maud Spierings <maudspierings@gocontroll.com>
 S:	Maintained

-- 
2.48.1



