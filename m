Return-Path: <linux-spi+bounces-6937-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C83AA46258
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 15:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35941189CE17
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288B12222D5;
	Wed, 26 Feb 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTGfSV0v"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08E3155322;
	Wed, 26 Feb 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579559; cv=none; b=qaJS1k6c+P3N0q/FbpsTdn9m8U4nO7E0qD5vymErRWEqoDSr7K/jZZCQUVgFnn3zvUMCfk3SqnqQQLMwZO6bRFQaPd57bFVWxRTiBt8zl8XL/LxdjySAtNcx7aL37qnu8C7s8Bq18xKbA8QQV/hr3JaN74brwyJZWQItRx583L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579559; c=relaxed/simple;
	bh=w48Gtlgi8iO22JGBkIhg/tszWTob5ViJlyp87dlVGys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xjl9ddalNDVfDTAAJsOelc8CFheF/KNbtdmfrM9IOwLlnxL6VVeD1I6Pkr2i8SJ8WQYJBqQil+oQDoAUqNWel5989nrjRJ+ZrvbCNmWz0+twKPFX91JRK9NTdiquAxcZwpA+VvLF+0XAn+K1aC4vlaCysDf09zjcNVLRVwGLD0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTGfSV0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C803C4CEE4;
	Wed, 26 Feb 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579558;
	bh=w48Gtlgi8iO22JGBkIhg/tszWTob5ViJlyp87dlVGys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RTGfSV0vs4M1Te2F/O08Wv/YqQGAFXPFSIbgYnGw/8Vf2v3R4VWg3DqQmnXYj8Rt3
	 RChA4exN/zziV9DzVi4fyt2fUC+WYgDZVLDTDXD52zTlsqTE8YYvpCPGbXzI1Uebkz
	 WMwTF/kqD346tx2pG0c2Z/pkfngbr+vrZvllM2mIa3Bkd4UaPzyAyKVEExQyIOSH11
	 OsyaOgKQgZsaZwZVFsu6j31K8SUsBt5vr6ONSD3xGg7kL4BVnJ/Qygd3a1LQCj8Gtd
	 LcXsQgAwBvthSPO701JFmpTbdH36TcBfOFIIkZ+ddIsk7cZkpjczpmV9rZQhnQHuwo
	 ko/J1RKUKvWxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFCDC18E7C;
	Wed, 26 Feb 2025 14:19:18 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Wed, 26 Feb 2025 15:19:13 +0100
Subject: [PATCH v2 02/12] dt-bindings: vendor-prefixes: add GOcontroll
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-initial_display-v2-2-23fafa130817@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740579556; l=1019;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=QrUKw+1GlBeS4gjTwGekEGjOZJwzhcXs7wKcC4kZ2dY=;
 b=Rn9xYMCCPZAaFDU37lBWjcHyXDsbSfUSWIegppwKcclLyui8/SxtoImAHTHbKS1g516Fkg9Fe
 pSjSTd2jSfoCoR+We3nCjQ4Pw1Axj3of6sWd8Me6cRf4vgMvff8mnHC
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

GOcontroll produces embedded linux systems and IO modules to use in
these systems, add its prefix.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index dac80c62b742fec14cd7652d9d690acc4b4b1ee6..5dc61a05de0ce907caeb60bb92018569df0d19e3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -597,6 +597,8 @@ patternProperties:
     description: GlobalTop Technology, Inc.
   "^gmt,.*":
     description: Global Mixed-mode Technology, Inc.
+  "^gocontroll,.*":
+    description: GOcontroll Modular Embedded Electronics B.V.
   "^goldelico,.*":
     description: Golden Delicious Computers GmbH & Co. KG
   "^goodix,.*":

-- 
2.48.1



