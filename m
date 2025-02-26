Return-Path: <linux-spi+bounces-6944-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61773A46265
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 15:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011BF3B364A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DD92236E4;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqoBdnWc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20922258C;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579559; cv=none; b=cvaMLu4kMqyU0LijbxOjHHRDi+hliJrFhd7QOvjUvn5XqWO+VFYcnJL7MD2qdSUNMyL2IkjwChiKUzPEpBMZXO/E/JP+5sYKVXuvf21bJ/9RmAsHv/1tEHCyOLEWMVFOuy7ohmOnOkyaHFyAcfj3/fLmCMxZQ5ctMA7LlD2qHsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579559; c=relaxed/simple;
	bh=O8czsGG093l0aOz2OJ6zq1QGMsL9fRqZXndIovDqI2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgA7r9FC4xTFzQdQSSsMqMgujR26Ju/X0x9SDhI0Y1elzFIxBDzEIkQ0AKU8kcBsVCE6lTDVFFVtqBp3d0je1xiv+wkUgRIaa5Wd6BHQSx1jOddFYNP+SB+2CGHPWHKFuusl1AxQaZ0v5IbB5H0ica7AuGhIW43fwLde0KyEZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqoBdnWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2642DC4CED6;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579559;
	bh=O8czsGG093l0aOz2OJ6zq1QGMsL9fRqZXndIovDqI2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RqoBdnWcwZLptLXm481zE8+MYdrTUZDYePojyZZDiFwaQ73nX7ZYPwEa6pk2HKFwg
	 34i390lbCOitpvCmkirSFXCMdikoV4yg4zVQSsTKPsmF0kI0PTEwkycVvtB77eq3nC
	 GEMVZkbL8Z5+C7UZYKbXsNKPUSFi9tkFK6wnTZ6ITObrCbmsT3BmtVGciqDB8y7u3X
	 dgYOWsQvcg5iBhMdz1zC+NFvjg2DHrxSKew6jJVZmRkFJ9C2KKZQODMyqofxSJhWQ/
	 Mi6VLMyoF1trOS7o7mMfRTV3vfp0llVjuuStQ6iNiKhrDPqUotlvAtcXkH+xiYNyVf
	 7319U0nmqoGAw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C33AC19F2E;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Wed, 26 Feb 2025 15:19:17 +0100
Subject: [PATCH v2 06/12] MAINTAINERS: add maintainer for the GOcontroll
 Moduline module slot
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-initial_display-v2-6-23fafa130817@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579556; l=783;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=mdt5JwC9bMt5XKdossnzN3k8EjfciPnd06zO7qteiiY=;
 b=swcJF9ByfdpVHmCmammooQCjX5IvAKt8c17sTXTdoEyj5DX6o80SUU3RCp7CWPn4G54Ymlrk+
 Fj9IkqRG4yRD6J9m7fM0Rih25iWwXewk3AaED6WkG5cZZ0yYEJGg8Lw
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add a maintainer for the GOcontroll Moduline module slot bindings and
future driver.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4c76d7ad890be0f618109918ad89328bc72e8cd..3d75c66942ca2059e7a054072502b726d1dec04c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9843,6 +9843,11 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/usb/go7007/
 
+GOCONTROLL MODULINE MODULE SLOT
+M:	Maud Spierings <maudspierings@gocontroll.com>
+S:	Maintained
+F:	Documentation/connector/gocontroll,moduline-module-slot.yaml
+
 GOODIX TOUCHSCREEN
 M:	Bastien Nocera <hadess@hadess.net>
 M:	Hans de Goede <hdegoede@redhat.com>

-- 
2.48.1



