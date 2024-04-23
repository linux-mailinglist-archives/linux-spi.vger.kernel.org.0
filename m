Return-Path: <linux-spi+bounces-2467-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883D28AE425
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 13:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F061C225A4
	for <lists+linux-spi@lfdr.de>; Tue, 23 Apr 2024 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E629480020;
	Tue, 23 Apr 2024 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b="ihznQ1EJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10677E792
	for <linux-spi@vger.kernel.org>; Tue, 23 Apr 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872151; cv=none; b=rKtOlUA17VHpVH1MxiZ+K3xn/FaAqeOInudOVsxo73TpIFAfLfKH0qX3i4x+c16/D3llWeRFVRE2DswHgn/F6ajyFHylR4wd+BWbEH7vSvoWXzoGsljqRrvsybtP5VouXxBKwCSf3nxdjMEAovjwuUR9u+igt95svpQYofRmnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872151; c=relaxed/simple;
	bh=9vP4mBM6tkos6CoZHwx0vDDQJ//HL3Wf+tFRftdDnPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrO+WQfbQJNSC8sa+/xJPBY+XwF7tQApY6cry5q6aQNeamVUYcElmC9JbOjNJoCJ+4+B/19ukmg/mj6Ld8fzrrN+domzqg26Odb55Z030FhhkOE0e59p/NguB/+qn87OCzZr1P0y/eaDK/Qlz71oGPgL0HQ7dX+Mxg7RgkcnFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk; spf=pass smtp.mailfrom=pqrs.dk; dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b=ihznQ1EJ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pqrs.dk
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
	t=1713872148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScAzNfep4eEm1vY7gR4iZr889YiTgmobWqSLElHBrnQ=;
	b=ihznQ1EJpwJlGH9l73N+J6VA9xAPP4Qdh1bBkiIpzQvBa52c9oC3HNrG7ivZiL5+BSR51V
	bR0d6C8k/xuXQs3OW/JENlG1ZthT18iccUP7oUlx8dKQtdYLLazsd3nVTOuGihF38H/4/h
	CyrNzOgPuKwGY5yDd3yCGoAc37Ji+Lf8JhbRWFy2gywtVq6VgEIHoE+mPdjLG4P2ciTIyc
	AdhtJY0jPunrinNQrtAZeVjB+gHNMJ3M18pdT6rwbm3atT2Y6h1BPmMzqjXIEeTprfmQ8H
	tCyoLyV+ypYx2cH2xrGslHONHgl/wSOcJth93kuAqw8HjGSfpfld4homQqSc4Q==
From: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date: Tue, 23 Apr 2024 13:35:31 +0200
Subject: [PATCH 2/3] spi: dt-bindings: nxp,sc18is602: add compatible for
 SC18IS606
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-sc18is606-v1-2-094ef37d5a59@bang-olufsen.dk>
References: <20240423-sc18is606-v1-0-094ef37d5a59@bang-olufsen.dk>
In-Reply-To: <20240423-sc18is606-v1-0-094ef37d5a59@bang-olufsen.dk>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Migadu-Flow: FLOW_OUT

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The compatible string is nxp,sc18is606. It is a functional replacement
for the SC18IS602B with a larger data buffer, three (rather than four)
chip selects, and lacks support for quasi-directional GPIO.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 Documentation/devicetree/bindings/spi/nxp,sc18is602.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/nxp,sc18is602.yaml b/Documentation/devicetree/bindings/spi/nxp,sc18is602.yaml
index 5b34fdf6148a..8fbf74b95708 100644
--- a/Documentation/devicetree/bindings/spi/nxp,sc18is602.yaml
+++ b/Documentation/devicetree/bindings/spi/nxp,sc18is602.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/spi/nxp,sc18is602.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: NXP SC18IS602/602B/603 I2C to SPI bridge
+title: NXP SC18IS602/602B/603/606 I2C to SPI bridge
 
 maintainers:
   - Alvin Šipraga <alsi@bang-olufsen.dk>
@@ -15,6 +15,7 @@ properties:
       - nxp,sc18is602
       - nxp,sc18is602b
       - nxp,sc18is603
+      - nxp,sc18is606
 
   reg:
     maxItems: 1

-- 
2.44.0


