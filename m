Return-Path: <linux-spi+bounces-9106-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CED8B069D0
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jul 2025 01:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37F7177392
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jul 2025 23:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA62D3A98;
	Tue, 15 Jul 2025 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="PKQLyvfo";
	dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b="+w1ImdG0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.adomerle.pw (mail.adomerle.pw [185.125.100.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A98D25D546;
	Tue, 15 Jul 2025 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.100.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752621636; cv=none; b=HDGtjeSPxrbhSe17kTm+E2m9ud0jfsBf2WMvlcxfLRmCkOfeqtVyjXE0QL3/d/E4W3fvScftCLE2sPErJQ4Clola2gwN9yJ+rlGK7HKK70uAZZf4K4/Loqq05W2C8cCpAf34nEDbmyi7b1hpY+fi7UkfX1fpaxKdzxNvf6cR7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752621636; c=relaxed/simple;
	bh=CusmGv7uy2f/mkxH806Eyj7gw9q6O1Ngb1sYu8ZjHas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvBKHYL8CROSFHnPZYOCXmwBt35pHOeQS474QAfjjqSZs9+o6UspHfYTWrMdaAXbnYg5HMzJY5eGcXSxacPyt5RcphPbPJgmO62lfqnQGZjaI7kmy5ul7qBfEkFx8MDAfTby35RiccqoeEzvXKKQvsSyyxe+NFkNhDhtbkAY2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw; spf=pass smtp.mailfrom=adomerle.pw; dkim=pass (2048-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=PKQLyvfo; dkim=permerror (0-bit key) header.d=adomerle.pw header.i=@adomerle.pw header.b=+w1ImdG0; arc=none smtp.client-ip=185.125.100.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=adomerle.pw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=adomerle.pw
DKIM-Signature: v=1; a=rsa-sha256; s=202506r; d=adomerle.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1752621609; bh=lAgqzrLQFgULC/NyYg790w7
	pnHGpDDP+rKXydLeBdro=; b=PKQLyvfoHzhI/2nBfmwhUQkKSq5uRNhnHw0uA3sAdxMHJCOqBE
	MKeaDpccaY0X1fCL5mKTVmgBNicSX5aNXHTv2vLUhdQwoU9UAGgrX+0nWAMe3hT/Nl7Z/G54Zju
	NvqwGAYSbGdwTV1rb7AYLGY2SOmva3Jub2aUv5F6Q6Eb7+kFfq36et+R15Bk6jkZt1Ws1YG4Ea3
	SPaJcXKAj8IJL57YUhPtEEGUHH9yjEeXWnjKDa9ee791fXcm+LHGWiXS82nq9P7nVa7fLu1ntXS
	sLK7DFEnIT1IU0cqFzEi6PGeu4DLThSxdt9SUPVkOGnG8w02K2OpvYFzvY3Wd9NBS2Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202506e; d=adomerle.pw; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1752621609; bh=lAgqzrLQFgULC/NyYg790w7
	pnHGpDDP+rKXydLeBdro=; b=+w1ImdG0wGwWNIhr3PfI/9CU7GW5NQT75nkl4OSm2eJcLap64D
	9eG/29pnL0Y2pi1kZ8hloCXIh5K5JSJGofAg==;
From: Arseniy Velikanov <me@adomerle.pw>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Leilk Liu <leilk.liu@mediatek.com>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Arseniy Velikanov <me@adomerle.pw>
Subject: [PATCH v1] dt-bindings: spi: mt65xx: Add compatible for MT6789
Date: Wed, 16 Jul 2025 03:19:21 +0400
Message-ID: <20250715231921.4527-1-me@adomerle.pw>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a SPI controller binding for the MT6789 SoC. As a note,
MT6893 SPI is fully compatible with this SoC.

Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
---
 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index 3bf3eb1f8728..0635aec29aae 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -49,6 +49,7 @@ properties:
               - mediatek,mt2712-spi
               - mediatek,mt6589-spi
               - mediatek,mt6765-spi
+              - mediatek,mt6789-spi
               - mediatek,mt6893-spi
               - mediatek,mt6991-spi
               - mediatek,mt7622-spi
-- 
2.50.0


