Return-Path: <linux-spi+bounces-6939-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4E9A4625A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 15:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A323B32A6
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 14:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D780222566;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhrVIPGK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092A191F6A;
	Wed, 26 Feb 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579559; cv=none; b=SSAvUo1xXoimenthA30wn5LJOjBM9VQV8+ZvRAvTIo0YX2cp4F8UZjpeO0k/Vt/cDmmAJ37k3mNXaQ2FbP4nKY8WjXLzuQWS3XutldZaqXP/RfQMARE0npvFjo9qe6YNusGiC+gJHUFbC2dW+5kXOaZgMDunJrG4WICru4i7IeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579559; c=relaxed/simple;
	bh=yzlu7C1Ilu9dacgUhIz/BCN7V18c7nAEEfTiqq67Dk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QW70iyRVkuFF0N00egIcXWOj/rhR74yaEyFPMVoAbDw01JbyB1cKdh3ubjpjztAwD12QCP6loBYjKzhmhXbYUBpTOiOwBj/Y+250HlHPk9sU4xmPQtdIi5BSKjJtuBqxKJt4FPjWRf656X24W0sZ7hJ5bqkWFPY3TjTNtnQBWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhrVIPGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BEBDC4CEE8;
	Wed, 26 Feb 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579558;
	bh=yzlu7C1Ilu9dacgUhIz/BCN7V18c7nAEEfTiqq67Dk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fhrVIPGKnahShK0SdUq7Sbdkh7HdubhTJpTxC48yA6u/GfLI5Zc0jhlEDAlF3VT2C
	 qPJuCY7yI5Uc02VEXsRa1Mkg736cyW4fb9BJjM+uDxD8CZhyP0eW++0Fy8oXsPBZuR
	 ulIZ1B6fzC3mTYvWqrGeSCx819G7LZkuIXJ0AN6Mpjg2+rEaz0zRNEuG7B6X3Lz3in
	 UXcf0PVwNi6CV7/EroUmlXVpn36Jmo8gxBCrlMAsKEzzIY2HTatvOKJNolZT3ev1jP
	 mS1EVlPWSscvYKC9srdWTjrqfjdKzDZFe3l4oOLZN3p2r+jGGV7X0IfNsRiiRafE9y
	 us2/mIruN3w2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791D5C19778;
	Wed, 26 Feb 2025 14:19:18 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Wed, 26 Feb 2025 15:19:12 +0100
Subject: [PATCH v2 01/12] dt-bindings: arm: fsl: Add GOcontroll Moduline
 Display
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-initial_display-v2-1-23fafa130817@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579556; l=1224;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=XzzwrOc9xVSfmdKG+ke4olEHtzQu7fTQaSQ8cG5/qtY=;
 b=ABwoQ4wLxyHJ5tU87/yspLvaG11vwwnIv6B4L53Ie07g0oyNP6tydHs5rrMs/AN0paPKTnCna
 GOr63LBqd3TBdjdv91NmDAMexIUVEN3zcB5E57gBkdJZorPAJGVUhua
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Document the compatible strings for the Moduline Display controller.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index db781d31569811ca241b5bd9a32a0896f7d9c3b9..40b2734f0caf3c431f05d33637a6bed8312c9d10 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1099,6 +1099,7 @@ properties:
               - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw75xx-2x # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw82xx-2x # i.MX8MP Gateworks Board
+              - gocontroll,moduline-display # GOcontroll Moduline Display controller
               - skov,imx8mp-skov-revb-hdmi # SKOV i.MX8MP climate control without panel
               - skov,imx8mp-skov-revb-lt6 # SKOV i.MX8MP climate control with 7” panel
               - skov,imx8mp-skov-revb-mi1010ait-1cp1 # SKOV i.MX8MP climate control with 10.1" panel

-- 
2.48.1



