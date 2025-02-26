Return-Path: <linux-spi+bounces-6949-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDAAA46276
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 15:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2F917CBE1
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978DC22689D;
	Wed, 26 Feb 2025 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cy/ZKe+d"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB88225A36;
	Wed, 26 Feb 2025 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579560; cv=none; b=hyGF1Id6Sr9LmhijyAs2JPMp9X4qC0Cpa8SG7VhlYiBhYKH5bijTVHW2cY8LQxq1E56C/SOljo9vPWDaS1hK/K3NRHatL3/LLIm2RrPLwtIBPIUBYKr2FAM0yr4y5zhJtRanZPWfaxPkWUpv/4D3YtCOSGB+NSvQXU55tpAICG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579560; c=relaxed/simple;
	bh=5myc+unuv0mfBhimUhk1emfOfhdL+1INGKDKqdZalcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stucsdVcj5pn4o00TNCM+0KVYcPxXuFDUgE3ZZOLey+FfVp9FxVWqtaDWZPM/pT6L20UbH9T8uaFUs6sn9MDCGrU4YODo/CEPYDvc4OMhm667ewDn9S8s45hsk6fzTCh+WYf3RU5sNm/FMUjHGsG8lMYtuGZoyJDcMshWAI5rmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy/ZKe+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7BF0C4AF64;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579559;
	bh=5myc+unuv0mfBhimUhk1emfOfhdL+1INGKDKqdZalcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cy/ZKe+dXQfPLf0vUoeRR9WETiyy2RiQ7Xd+Xge4uigLKfm/GPsx7q5MsKJQrSo1n
	 QrbPE6HX4tu4EsOZur3tXBknn1qVBmHt+Sr8KogZWONRvaEdzkpnmKe9vKjZuVbsmC
	 ddywj9YmE1e5CRLmnN9D540ZMIEMBSRe9L0lNbL66Fj/sCk1ZKVHqd0W3Mrezif6ym
	 NYahznXq+lQ9hjyt6OYNjVOMiP8oLmCNgWs15sLLfrkZA4Te4+pAsSajz85of2lgT0
	 NlTjm6qsf9G0+Rr7150FjJLi9hfo2P+PPp0knFVIT4gBI3CFk6d+pnSIt8WB9ItbNK
	 PfEdymDN7/96g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ACAC021B8;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Wed, 26 Feb 2025 15:19:23 +0100
Subject: [PATCH v2 12/12] spi: spidev: Add an entry for the gocontroll
 moduline module slot
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-initial_display-v2-12-23fafa130817@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579556; l=1586;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=Tycawk+/5vgO1pNpkUXDG2S/Gx+HvpTkRpC88dFEYj4=;
 b=6lU9pAT+NW5qS57Ca9Rq3dfeMU83IRh/BZe/VuSTJYVbPvx7jK0+WtZGOd/B0b9I4sWLR6PIy
 tXF7iNFpYdOBRuzUcoSSXasaqTMdzZV4nzvxZDYI0xNl1lpeuuKb90+
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

The main point of the Moduline series of embedded controllers is its
ecosystem of IO modules, these are currently operated through the spidev
interface. Ideally there will be a full dedicated driver in the future.

Add the gocontroll moduline-module-slot device to enable the required
spidev interface.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 58ae4304fdab155748e66117f7ceb050da95afed..6108959c28d9c7505be63583e8206519275663ba 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -706,6 +706,7 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = /* cisco */ "spi-petra" },
 	{ .name = /* dh */ "dhcom-board" },
 	{ .name = /* elgin */ "jg10309-01" },
+	{ .name = /* gocontroll */ "moduline-module-slot"},
 	{ .name = /* lineartechnology */ "ltc2488" },
 	{ .name = /* lwn */ "bk4" },
 	{ .name = /* lwn */ "bk4-spi" },
@@ -737,6 +738,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
 	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
+	{ .compatible = "gocontroll,moduline-module-slot", .data = &spidev_of_check},
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4-spi", .data = &spidev_of_check },

-- 
2.48.1



