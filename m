Return-Path: <linux-spi+bounces-7287-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FF8A6D7C6
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 10:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26287A6FB2
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A4025DD12;
	Mon, 24 Mar 2025 09:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DNAUbfq6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C75725DB0D;
	Mon, 24 Mar 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809411; cv=none; b=Nk+YhzNU/Ak07I8Lw7/r74ZvPZ8fNuji35yGmwrI7G7S63l3DS2SAxM1xQWE1jWiopd3cweEpY01tUTptCOr33PACfY/NidGbNSRIC0OLCswEC760AYDGKOIbnuLPdviu8E+w4LNzfUOaBTBxS4P04IYSLPd3O/t+76l87KmP90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809411; c=relaxed/simple;
	bh=xwAXpf2r+v5WIM5PWE9zJkDFTC8uCLULd81muUqM9Ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XVpNTX3HUB/yUF5H40pYbtO5AyHJ9g6GHvxTACtfW04+MQ8JGuqWX8SEp8L1X/R5HMF1MrPY650iFgARVy1szdSu+P37y8FUVKgxq2/YI/JtGnhglDUSdENdbuUwdDWc7TSPoLFK9YQud18BFRe8Yq2UwjuwMQdIXUBsZ7c/Y08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DNAUbfq6; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9BbeC031035;
	Mon, 24 Mar 2025 10:42:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	yT8oLnhtXkXINGnaV4SHYt3aHucazcGEQTHZoc9QZSc=; b=DNAUbfq6/Jhr49dY
	UZilZG/nPpJwxSNbjdOvw8cWhtKG/mHo2Y0ypVErwGGlkSe1cK97HchCEhDqF6BE
	+1ZkOxPxph/8n7q9NqR0zNKhYFVOpa8pXZZm2W9ITA4na6iyPIzV5A3mt28oojBs
	VQ73wEQoDPj6GoKshGNVxWD1Fevf6NytbNHGaWCYh3pkRX4PepyD5FYcgXZv7YV3
	jh8XbguA0IC31l3kDeM8aJCTx4/Qkxozorv4HEL88YKnJCjbvPLqvbCVfI5uLAnT
	m2YQ72WpAGy6wR3zolGKfe7YdaPQloUzGcYRc0QnJHJrypJ+enO+93ZvO781orGb
	E9dGgw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45hkgr71x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 10:42:59 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DFB6A40063;
	Mon, 24 Mar 2025 10:41:40 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 87D8D7EE783;
	Mon, 24 Mar 2025 10:40:17 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 10:40:17 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Mon, 24 Mar 2025 10:40:14 +0100
Subject: [PATCH v2 2/2] spi: spi-stm32-ospi: Make "resets" a required
 property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250324-upstream_ospi_required_resets-v2-2-85a48afcedec@foss.st.com>
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

On some STM32MP2 SoCs, an Octo Memory Manager is embedded and
need to retrieve OSPI's reset to perform its own initialization.
Make "resets" property mandatory.

Fixes: 79b8a705e26c ("spi: stm32: Add OSPI driver")
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-ospi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index d4f413c8c3ce1a51d2302602d46c7605a8bbc605..d3839a4dacf9f2eb95bafad9f7a8538ce2bb3598 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -804,7 +804,7 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 		return ret;
 	}
 
-	ospi->rstc = devm_reset_control_array_get_optional_exclusive(dev);
+	ospi->rstc = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(ospi->rstc))
 		return dev_err_probe(dev, PTR_ERR(ospi->rstc),
 				     "Can't get reset\n");

-- 
2.25.1


