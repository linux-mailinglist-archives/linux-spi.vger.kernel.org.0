Return-Path: <linux-spi+bounces-7285-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2AA6D7C8
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 10:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D583B3214
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 09:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E7025DCE5;
	Mon, 24 Mar 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RjZcSVc6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04225DAEE;
	Mon, 24 Mar 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809410; cv=none; b=ggFVeAwkNnQMf0xBo7qyhmrBkph/6FMwgFodDce6obv0apAdbBSi52jUiH3t57mBFrbNrDF1AiL3ApuPCP3h0KIkG119lTI6ecfhw/ZUkpxEqZX3rLFcBLYyfrhW7TyIGARlHzyxVNixVw44qTpTHQQmCtQzoAZMlNpayMh7iqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809410; c=relaxed/simple;
	bh=lxXDM6IwsJB8cs+wlaDqcJWHjbK0q3C2slLZ72Fn0J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nkf9vt3YgOkDj7HwuHbynj+2AGlzZkIklFuuN/lwCUSf5A7REHh1LKGG50FeYuNdNd51BCsnEgpyY6cXQH45ZgHgYEQi2epxNrZQcH6UFKv39KXGOmpoQVgbI49QXC/kcIMwi8jJsKnHmDKemqNADgQZJVvgXgFGDU0hTR/0Zko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RjZcSVc6; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9bkhv012912;
	Mon, 24 Mar 2025 10:42:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NzLmfHxTjgjzxH2MLhlvyo1SC7eJ5Hj+e6zOGJcJg9E=; b=RjZcSVc6/aR2sEEY
	p3+BtYB+Ow7xIIr5Zlmif8LHp0BXyL7U/CXvQCDlo3ElPwrs6FqMnlWzmcXm1DPK
	rH0kQ3KIL+8NjPBh+buHONUDAD1JKonPfsTnn2Xv+RlWegZzs4TGw4zdWTOJ1qe8
	t2VkWPdFcgkBHkI+9s41y6qim0O39+VTOlbLMZ6U7Kxcp+Zyn5EToWLu6Hoo7cHj
	Mkipvnv1f4yVJUmwaGp9h0OVk+pTJqI7d8fpXiJM1zkejYnwv8yBcfgqd4qLy0uT
	MjO2zzu1L/5TGYKx3FnEDJAcfUG2pfccNb82WW8acU/FxPA7qGYGGDT6x51S+tHl
	VwAJMw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45hne56t0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 10:42:59 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E3C6C400DB;
	Mon, 24 Mar 2025 10:41:40 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CA1817DCB33;
	Mon, 24 Mar 2025 10:40:16 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 10:40:16 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 24 Mar 2025 10:40:13 +0100
Subject: [PATCH v2 1/2] spi: dt-bindings: st,stm32mp25-ospi: Make "resets"
 a required property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250324-upstream_ospi_required_resets-v2-1-85a48afcedec@foss.st.com>
References: <20250324-upstream_ospi_required_resets-v2-0-85a48afcedec@foss.st.com>
In-Reply-To: <20250324-upstream_ospi_required_resets-v2-0-85a48afcedec@foss.st.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <christophe.kerello@foss.st.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01

On STM32MP2x SoC's family, OSPI is child of Octo Memory Manager which
must have asccess to OSPI's reset to ensure its initialization.
Make "resets" a required property.

Fixes: bed97e35786a ("dt-bindings: spi: Add STM32 OSPI controller")
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
index 5f276f27dc4c1fd2056f129cafc1005eaee8008f..272bc308726b2dfdf3ec80740d70e0fd1bfc4fea 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml
@@ -68,6 +68,7 @@ required:
   - compatible
   - reg
   - clocks
+  - resets
   - interrupts
   - st,syscfg-dlyb
 

-- 
2.25.1


