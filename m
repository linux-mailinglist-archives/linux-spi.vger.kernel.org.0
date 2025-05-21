Return-Path: <linux-spi+bounces-8225-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BAAABEE57
	for <lists+linux-spi@lfdr.de>; Wed, 21 May 2025 10:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306AC4E3124
	for <lists+linux-spi@lfdr.de>; Wed, 21 May 2025 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D748E22B8B6;
	Wed, 21 May 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GCwY3wbF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1422B59D
	for <linux-spi@vger.kernel.org>; Wed, 21 May 2025 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747817203; cv=none; b=Yh0EPNgNkfIwc5a7l0h/mSKc5ddre5uhH+Mn7B3ucLVaU7ZlLYHjzu2m7Hxpg7Xg3n8+668pt6Upfi+Rj7IgNDGxf4x61+1z4yzBd6n98egy5CdLqqNkXvgqahWElmDVAnNDhWEfJPWA0ciH02vUxPwG39R0HDpK7CvHvzoOwmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747817203; c=relaxed/simple;
	bh=WnhL7uoBNqMZ3Cbebs3yyWF/yxiYNx9JjYSDc3RKJZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=E+yyj0XhqqtZ5SwJqyQQf4FOzTZgz92ohvhDN6KvBUfi0WbsGu7BtGA7i+QDep0Wg84zAQVbF0f37hFNSFBn9fJFFPMzcliQSiNaVfJqdubrbO/BTyjUwfcJuSTLN21hjhIHpxDrsHS0CD/EncBK7gT6C2Ev5w+a9AihlWzk074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GCwY3wbF; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250521084639epoutp03ba0919f6ad86fa7469e2febf188344cb~BfnuJlHzY0752707527epoutp03G
	for <linux-spi@vger.kernel.org>; Wed, 21 May 2025 08:46:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250521084639epoutp03ba0919f6ad86fa7469e2febf188344cb~BfnuJlHzY0752707527epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747817199;
	bh=shbECNWSz86NpuLRg7p7TU1AfWaNOBZLxT9Qlix0Iyw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GCwY3wbFiUvS5MlwKmYAu0tp1ZNdGfc87EuGYRJHtZlkST5CnseL2oNkdSq4+QN97
	 oKeMm+4LNou75HPrEmdOAixUL7t+tBXZLLDQY6IMksv4yHwyO7PpIZszpOdFK+N9+U
	 XTVW+Ym4mUPFt0oVkHEg2Y2R8iGkC2V3+OsDVq6g=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250521084638epcas5p3c250d169b4a59ed73f9af721159bd62c~BfntdVWms0169101691epcas5p3Q;
	Wed, 21 May 2025 08:46:38 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.183]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b2Q572nhDz6B9mH; Wed, 21 May
	2025 08:46:35 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250521083341epcas5p243dac11e4c5f2221473b8df8c3d7f060~BfcZpYq3P0049100491epcas5p2Q;
	Wed, 21 May 2025 08:33:41 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250521083341epsmtrp15d2cf9fc5d29a621b7b9c91d2dda336e~BfcZffJTZ0709607096epsmtrp1L;
	Wed, 21 May 2025 08:33:41 +0000 (GMT)
X-AuditID: b6c32a52-f0cb424000004c16-ba-682d8fe55e25
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	5C.15.19478.5EF8D286; Wed, 21 May 2025 17:33:41 +0900 (KST)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250521083339epsmtip19122db928827b44efd1a728582b64fef~BfcXjjrho0917109171epsmtip1M;
	Wed, 21 May 2025 08:33:39 +0000 (GMT)
From: Faraz Ata <faraz.ata@samsung.com>
To: andi.shyti@kernel.org, tudor.ambarus@linaro.org, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, rosa.pila@samsung.com, dev.tailor@samsung.com,
	faraz.ata@samsung.com
Subject: [PATCH v1] dt-bindings: spi: samsung: add exynosautov920-spi
 compatible
Date: Wed, 21 May 2025 14:13:24 +0530
Message-Id: <20250521084324.2759530-1-faraz.ata@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBLMWRmVeSWpSXmKPExsWy7bCSnO7Tft0Mg5nbBS0ezNvGZnH/awej
	xdSHT9gs1uw9x2Rxb8cydov5R86xWly7sZDd4uWse2wWl3fNYbOYcX4fk0Xjx5vsFv/37GC3
	+PLzAbPFp1txDnwem1Z1snncubaHzaNvyypGj8+b5AJYorhsUlJzMstSi/TtErgy5q7cz1iw
	nq2icc5elgbGPtYuRk4OCQETiW+nHrF0MXJxCAlsZ5Q4tXonC0RCUuLw07tQRcISK/89Zwex
	hQTeMko0HY8GsdkE1CVm3jgC1iwi0M0o0T/jEDOIwyzwnFHi+KY/TCBVwgIBErubfgNVcXCw
	CKhKnJ8dChLmFbCRuLSthR1igbzE/oNnmSHighInZz4BO4IZKN68dTbzBEa+WUhSs5CkFjAy
	rWIUTS0ozk3PTS4w1CtOzC0uzUvXS87P3cQIDmytoB2My9b/1TvEyMTBeIhRgoNZSYQ3doVO
	hhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILUIpgsEwenVANTp5GChMFE
	PRsu8f3Nkzh1L946LZd4Pz/8zJtMxSI/8zihlN9K7V+/5J76Oi942s+ShU5iqSqhws/ZzDaX
	pXl4ekTGeNlU2cpEd0+NS/xj9LvFYdKmPyuf+h3lOpthuzTszPEfx3tLU8wC8u6vvW7L+6mZ
	x5Kj3DrzQUNgybPFRwV5LQVluWKMWTgPhbMyhRy4+iPxto2wQYn6I283kSAlBY77T26wX7m6
	hs3L7sJ3GQuO140FJ/8fi9+5yvuYRsLBt2U84fqLtWbPPT3XfmVtbfLyg/9MjAvWfGb2F5+3
	0KI0OZaFyb9auDxPbXkx8/H2TEaz7b6N30+5v7HujS5ptVutvr/hs3fb3h+nlViKMxINtZiL
	ihMBSxZgnNsCAAA=
X-CMS-MailID: 20250521083341epcas5p243dac11e4c5f2221473b8df8c3d7f060
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250521083341epcas5p243dac11e4c5f2221473b8df8c3d7f060
References: <CGME20250521083341epcas5p243dac11e4c5f2221473b8df8c3d7f060@epcas5p2.samsung.com>

Add "samsung,exynosautov920-spi" dedicated compatible for
SPI found in ExynosAutov920 SoC.

Signed-off-by: Faraz Ata <faraz.ata@samsung.com>
---
 Documentation/devicetree/bindings/spi/samsung,spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/samsung,spi.yaml b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
index 3c206a64d60a..fe298d47b1a9 100644
--- a/Documentation/devicetree/bindings/spi/samsung,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/samsung,spi.yaml
@@ -29,6 +29,7 @@ properties:
       - items:
           - enum:
               - samsung,exynos8895-spi
+              - samsung,exynosautov920-spi
           - const: samsung,exynos850-spi
       - const: samsung,exynos7-spi
         deprecated: true
-- 
2.34.1


