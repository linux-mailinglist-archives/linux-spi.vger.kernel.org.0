Return-Path: <linux-spi+bounces-7263-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751FEA6B7F6
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 10:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6082D3BBB12
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 09:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51311F0E32;
	Fri, 21 Mar 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bUZXZZdc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6A51EFFBB;
	Fri, 21 Mar 2025 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550374; cv=none; b=NlKsfZFL+IQI0wvlXzG3K1eXbjkZvHcTX922wXT5uHLmmf5LZbZuUBefUQwhoG7uo/th4Cx8s/BdpRe7kLlZzsggHm7onZeXfXa4waPhNz+lEE8KkrHgXQ6kgwNI2s6RBnpSdOgY7+hs+/efY5Wsk0lMHW7DJbLuaa7Qa+bEZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550374; c=relaxed/simple;
	bh=UMcOZ3mOEiDBLSrOpnvd8PQmTlCM0RxaChTSzDtls0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KW6a41XO+J8822BW/iJb7tCuiDfJLTUcjjGL+6iQpCVloOxcqoXAVMB6PfLoE5yliMJJ4OOvuvzAa5kb6pk/t2xeMj/ORw0fa6wqg2gNn0R8iSZqOyYKsZsPbpzHQxMgJmpBOLpTVZN4D5jHaWwK+VVivuGz0t26rS7f9k9sEuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bUZXZZdc; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L7Y3xq019542;
	Fri, 21 Mar 2025 10:46:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	zfEGs4dkfxFOD5KJYRTWHjD7ebrAHHsZi90qqkv9y+Y=; b=bUZXZZdc2/obN/TT
	RSXOrVPogUeFQNidrAYzuATt0Fh0Rpq7AKd6dcCIahfmC4gjyf1SNxh7d19LMMb8
	SK9JeHAbhVcVf/lDVy4xz5J+q3LIVNxVm0dKzImeihFkjMmTp+cSqG4d531Fl1pU
	EWvzghp9FNHLzv0br9KypmYeqVqDj4XSEwM4dueg04xHQqVwnNFKsJ3EORvwuI/t
	gzZQtqS8JirEFQItmtZRTg+n3cuTMYsPWc9mmllDtK/GciFesr9KzK20F2+FGw2X
	ur9xClHw3h8J9bAHJzjZxE8UZFQNDvArIl5XdG/hu/F5tYmzg+rtREUet5mj8BML
	epVUIQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45h3ua0p4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 10:46:01 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 78CBC40055;
	Fri, 21 Mar 2025 10:44:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B4DCE7C17CA;
	Fri, 21 Mar 2025 10:44:07 +0100 (CET)
Received: from localhost (10.252.27.50) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 10:44:07 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 21 Mar 2025 10:44:06 +0100
Subject: [PATCH 1/2] spi: dt-bindings: st,stm32mp25-ospi: Make "resets" a
 required property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250321-upstream_ospi_required_resets-v1-1-9aa4702e3ae2@foss.st.com>
References: <20250321-upstream_ospi_required_resets-v1-0-9aa4702e3ae2@foss.st.com>
In-Reply-To: <20250321-upstream_ospi_required_resets-v1-0-9aa4702e3ae2@foss.st.com>
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
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01

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


