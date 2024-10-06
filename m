Return-Path: <linux-spi+bounces-5111-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D48F991DC9
	for <lists+linux-spi@lfdr.de>; Sun,  6 Oct 2024 12:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BC12827FE
	for <lists+linux-spi@lfdr.de>; Sun,  6 Oct 2024 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65B5172BD5;
	Sun,  6 Oct 2024 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="RJalEN65"
X-Original-To: linux-spi@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02765172BA8;
	Sun,  6 Oct 2024 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728210468; cv=none; b=hfbpj46+SBk11Q7mqtLUwmTEGR7VPfn/PxC0BX24HPUjXVIkDvSwBEljrMreSxkO5u2/qGHPm6wyPkxahL/J48ka8CCpcg4pwIINuJEHfQT7p3FazHLWLjp3wPRsPCNV8qSZ/v/0cxEMrLeQqXSW78jvJRc9Rzezc4Ehdu+XYro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728210468; c=relaxed/simple;
	bh=eQFpN46gknokSvXJCeeAKjHyK2HGsUQ4DriLMaIawxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxDVhtM5y8TBpgsSXqk/Id41IaycuxduDLsBVpllA/JEJ0Je+EK/BeAMcOBO9zc+mhCi8H7zOzqd8HPAdi50ovpH2mRq7Dfjxys638kBbu5bjY4fmEE08L4KdzEz04Hna3CFEGOqGOc1ZnmhkOBrCaOt0Rw8w+NG7yT1+0hP6mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=RJalEN65; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout2.routing.net (Postfix) with ESMTP id 0C2F65FAA5;
	Sun,  6 Oct 2024 10:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1728210465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0ZFTz9Uswka8q9Gcum+i2AIGps8wlGwvgIKYo93JZBg=;
	b=RJalEN65+aEx8kvgpCDLrjaQWtGIQz4xyAlqf2XJ2JO0J3tBZWF2HQMIovPJKyG7gEQ+Yc
	R2aaqnCKCv+10VpXUgfrF5nA9kSNLNUL0ECHe9cwfjvmKJdr9MyGH2wELA+3uKiYp8iqIL
	TIdxc7yaHCXe6TrCGjnLf029t/Fdbgw=
Received: from frank-u24.. (fttx-pool-217.61.153.101.bambit.de [217.61.153.101])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 084E5804DD;
	Sun,  6 Oct 2024 10:27:43 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Leilk Liu <leilk.liu@mediatek.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	daniel@makrotopia.org,
	john@phrozen.org,
	eladwf@gmail.com,
	ansuelsmth@gmail.com
Subject: [PATCH v1] dt-bindings: spi: add compatibles for mt7988
Date: Sun,  6 Oct 2024 12:27:39 +0200
Message-ID: <20241006102740.17948-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: facdb081-b535-49ee-8242-ea660d354237

From: Frank Wunderlich <frank-w@public-files.de>

MT7988 has 2 different spi controllers. Add mediatek,ipm-spi-single
and mediatek,ipm-spi-quad compatibles.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index e1f5bfa4433c..3c707e5de5fb 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -33,6 +33,8 @@ properties:
           - const: mediatek,mt6765-spi
       - items:
           - enum:
+              - mediatek,ipm-spi-quad
+              - mediatek,ipm-spi-single
               - mediatek,mt7981-spi-ipm
               - mediatek,mt7986-spi-ipm
               - mediatek,mt8188-spi-ipm
-- 
2.43.0


