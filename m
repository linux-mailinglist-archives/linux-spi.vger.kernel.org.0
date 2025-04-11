Return-Path: <linux-spi+bounces-7554-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4DA85DC8
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054144E13D5
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 12:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747EB221FA7;
	Fri, 11 Apr 2025 12:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="FhLWvgGx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9A2367D3;
	Fri, 11 Apr 2025 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375477; cv=none; b=S+l309LkqEXgxJQgU5uW+UGdEBQoH0/cz5D6PJkOxsvkdDaQRtduTGpzSXdfyZMIYgdAZu2DjP1/fnvL8sDIqpG2iKVTuwckvqzeVK7BHtHPIMu1wYZ9EuvnBeARar0SZbgwPqUftyZ4xYxEncLYtR5UQvqVT20RNmTtWWQfVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375477; c=relaxed/simple;
	bh=9YGgRq5N+tv3LipVNAnl7tDhDxYmhRz7T+UMZ9hFQuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c4Hiof1h7JBzCjIH/YAtYzRrfWpp+XXFX4CK3U/2ZhYxDh239JNW3y2xFnMxv12vK24MTET09mSkbxcV8IseVvptgzsCw3U+D4WM209ySTEXkPz7uQ6ma1+JwAxkWmXr509Xu5XeSASvjjNhSpMw4cnj9zVm99rjGsZmeJc6MUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=FhLWvgGx; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9MoLV017592;
	Fri, 11 Apr 2025 14:43:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	n/qj+1FHk4j+w1iPbMRgLM3/B5q9ZRu15dJ+f+b8Lbk=; b=FhLWvgGxIe3Ysmp5
	s27Tyc0xggGXBVlmhGOeiLyv2afBNUdObUCeYRKzss3ACkt3lHHABc5jSnNczeid
	NuELhGDqJgh+DZ5XejXorlyTyvVzbXgnIxnJyqQhpvt51em3/FwHkCUCFNjeBveF
	GzLjwQ7VC0ru+cy8sFsMtkY1fPsLoGpeCNXNTeDFR+afcoetQJcSCXvFnYT/lA5R
	1SeTO9C0VvnErSClZqh+9WK91krnZ8H31n0zHANVnOmQTshc6m4rli6qX81A3O/w
	o8KfUyCd6LlP+sYioyap3wfsLWjGIXjprG6jLqPGcXp6ZA43hAl9EWEtK8NvVjOQ
	LTeqng==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45tw5gp2s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 14:43:53 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 56E184005C;
	Fri, 11 Apr 2025 14:42:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 01CF69EC283;
	Fri, 11 Apr 2025 14:41:13 +0200 (CEST)
Received: from localhost (10.252.25.37) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 14:41:12 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Fri, 11 Apr 2025 14:41:10 +0200
Subject: [PATCH v2 1/2] reset: Add
 devm_reset_control_array_get_exclusive_released()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250411-b4-upstream_ospi_reset_update-v2-1-4de7f5dd2a91@foss.st.com>
References: <20250411-b4-upstream_ospi_reset_update-v2-0-4de7f5dd2a91@foss.st.com>
In-Reply-To: <20250411-b4-upstream_ospi_reset_update-v2-0-4de7f5dd2a91@foss.st.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard
	<patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01

Add the released variant of devm_reset_control_array_get_exclusive().
Needed by spi-smt32-ospi driver as same reset line is ulso used by
stm32-omm driver.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 include/linux/reset.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index 2986ced69a026947c8aafa89cdddf1e4088caef7..840d75d172f6239540bd12ab701103b7f02a624b 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -1004,6 +1004,12 @@ devm_reset_control_array_get_exclusive(struct device *dev)
 	return devm_reset_control_array_get(dev, RESET_CONTROL_EXCLUSIVE);
 }
 
+static inline struct reset_control *
+devm_reset_control_array_get_exclusive_released(struct device *dev)
+{
+	return devm_reset_control_array_get(dev, RESET_CONTROL_EXCLUSIVE_RELEASED);
+}
+
 static inline struct reset_control *
 devm_reset_control_array_get_shared(struct device *dev)
 {

-- 
2.25.1


