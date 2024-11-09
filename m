Return-Path: <linux-spi+bounces-5658-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6D49C2C00
	for <lists+linux-spi@lfdr.de>; Sat,  9 Nov 2024 11:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400DB282BC7
	for <lists+linux-spi@lfdr.de>; Sat,  9 Nov 2024 10:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51A81482F3;
	Sat,  9 Nov 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="RHjuOMjT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mxout3.routing.net (mxout3.routing.net [134.0.28.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDD38836;
	Sat,  9 Nov 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731149439; cv=none; b=k8UtGyHudXja2j7iHdW3zrqTZ7tC3EYvHGm1nEqMuF1D1h5xMGmBp6IU1/gXa2c3j3xaCSaehM1Mg6CFlFoz5haW59fCsqWx3qdgbuMJxieciT5n9Zx6dhHL/TDZrFp+A1Mcqym7hfByBbs3Zj7Fp9Otf/1awNgHdC6trhAv1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731149439; c=relaxed/simple;
	bh=n5ooLQHAfTbergGilGayCuAA7kySEFqqopTAcBczz/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipoNbTCqgfWAs5c5QfaUgV/+Z1l0AumVbmGv7jBhPe22xp4nnML2ZSVm4UOD82UvPlebTRXmx17q2/XvDHOsf4nY1m6uzteYdXi1J+2ZIHWTfnT7hvTd1ZQNHxFb6ULleFdPQyecqA9AoEvUA95zfmPkyS7UwQBUZfG3bXZg094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=RHjuOMjT; arc=none smtp.client-ip=134.0.28.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
	by mxout3.routing.net (Postfix) with ESMTP id 2B28E605E7;
	Sat,  9 Nov 2024 10:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1731149435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QA/fsK76PyIEeVBw1iU8XeWN7Jlcu8DwwjHRdqh/NK4=;
	b=RHjuOMjTBwBSf3KkilIRokQ1u2F78XwqQOBlSeJdqCIuecdTa1n4qEjUUPc6r6HcRInWzV
	r6TkfPCxLVWdtJI5nnIsGx2JBFFcMRrgbw3E7aRIk8HRrU9b2Kq4DAciwipzMO+8CDWDY3
	+DOz3sOpsvUcMijpCUjiwJCzJpHSuMY=
Received: from frank-u24.. (fttx-pool-157.180.226.68.bambit.de [157.180.226.68])
	by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 3AA1D8032D;
	Sat,  9 Nov 2024 10:50:34 +0000 (UTC)
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
	linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: spi: add compatibles for mt7988
Date: Sat,  9 Nov 2024 11:50:28 +0100
Message-ID: <20241109105029.52748-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 378da3c5-528d-4834-9528-4df358e72a11

From: Frank Wunderlich <frank-w@public-files.de>

MT7988 has 2 different spi controllers. Add their compatibles.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index e1f5bfa4433c..ed17815263a8 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -35,6 +35,8 @@ properties:
           - enum:
               - mediatek,mt7981-spi-ipm
               - mediatek,mt7986-spi-ipm
+              - mediatek,mt7988-spi-quad
+              - mediatek,mt7988-spi-single
               - mediatek,mt8188-spi-ipm
           - const: mediatek,spi-ipm
       - items:
-- 
2.43.0


