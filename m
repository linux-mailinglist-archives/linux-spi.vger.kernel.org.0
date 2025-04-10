Return-Path: <linux-spi+bounces-7521-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA23A8430F
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 14:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A9557B1E0C
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5642853EE;
	Thu, 10 Apr 2025 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="d+sQH8F0"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A137C284B3C;
	Thu, 10 Apr 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287918; cv=none; b=Su+DoC+xPKdc6b6XWapC1Exfzz62STbu4FsSB0WSKLoz8o8WGatiYzHViYbEaQGrtAydRQsolWoIz8jbh7Kye3krIiXy7U8jzC55KJHI6TLb8ksl2uQVc8ufSUwN95qDvGHQ8KQTYZJlk6D59Fd/YHg2CIP8S7jUeBcrX1QCFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287918; c=relaxed/simple;
	bh=BgP0tElT88hdMC4mwqLc2Q8dh1BYlbJiYOIL4Bzy8Gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cXdIa+C/2NVM7ycmWNl1IofOykmI2M7cSPGdIZRTqrMo7xONmbMb+x74NHTjK1zs+Mf6pNzzxXgFp9G7ages65MC9myRrxUz8IBJ8sFncsjyVjXldJNSwxboiYuiI6yDldtxdlW07Dgry85/T4+rOtoqn47HHtwdD/rD812GWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=d+sQH8F0; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A9W2Lj019490;
	Thu, 10 Apr 2025 14:25:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	xdOJrtk7Bjg1N0a/4B/OcJwqMOvdgRg20C9nexae3nM=; b=d+sQH8F0pTPSdeS6
	SE9YkM+v1RteMI9+ShFlQlLP614yiwgMoI/TYGoA7a+kCqsCdsTUeGaWPksC1/ik
	H83TYbP7KEEoSoeK/CXgPqbt9uISnx6qzxR0nT49nVW4EdRA1pb93is80wd2HKb0
	0oxowXQHcdPyP82n5J2hC1ew7qiNMjBvgn3v7RxDXu0YHVe+flz/Kb7i2SGuPv6H
	qD4vAFITdkg3gVGAE60dwVhKy1bGUrt4uBOupSFscu1WmyR+L3+jRRp/r07ajQLc
	CBY1GouHp/ScNuHiUaYD9tlSbr5i2cLTqwnLPr+pLvDR4T38w0VMSdOPyuV6f4Xw
	WEdc8w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45tw6eqma9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 14:25:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AC52240046;
	Thu, 10 Apr 2025 14:23:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5DE319FC736;
	Thu, 10 Apr 2025 14:23:46 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 14:23:46 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 10 Apr 2025 14:23:44 +0200
Subject: [PATCH 1/2] reset: Add
 devm_reset_control_array_get_exclusive_released()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250410-b4-upstream_ospi_reset_update-v1-1-74126a8ceb9c@foss.st.com>
References: <20250410-b4-upstream_ospi_reset_update-v1-0-74126a8ceb9c@foss.st.com>
In-Reply-To: <20250410-b4-upstream_ospi_reset_update-v1-0-74126a8ceb9c@foss.st.com>
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
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-08_04,2024-11-22_01

Add the released variant of devm_reset_control_array_get_exclusive().
Needed by spi-smt32-ospi driver as same reset line is ulso used by
stm32-omm driver.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
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


