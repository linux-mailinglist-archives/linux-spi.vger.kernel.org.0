Return-Path: <linux-spi+bounces-7520-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DDAA8430D
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 14:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCDF37B18F7
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B36284B4A;
	Thu, 10 Apr 2025 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Z2+VX8KW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08767267F64;
	Thu, 10 Apr 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287916; cv=none; b=XpjQTuWlaNMAhM57YbRf8Sk+s4tWmlZuo5n7CYHx7KXMiHRMh8XQ2iNDBlnmxf77mcX1g3YpIvTKkMQZN+Kanq4ITWugKo9ZS0XMpMlJl38BJXetP6NLL1KZs09VN2Zh15H+iLtDisqSebhnDq7Oe6uOq01C47O8Jvl2W3/SYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287916; c=relaxed/simple;
	bh=iYJFt+1IPlHzGtNX9AuRhPmwmrpFd5TRE57E6j7Db+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y0m89kkWAoQHTHoiONcK1ULinHU9RQqLNWI0SrX8LTeB5KqRK0GRg8wFgcVdSu7DPFV5EbP4+sUMjlaCh4SbKPtcbzxJfnUrw0hX9eoSUPRxz1zwz1MNijpMKUwnPBXnO9nksSs84swlGJdV5/T0FPpRy0AEGCYUny+bjxc3VYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Z2+VX8KW; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A9Vcd9005154;
	Thu, 10 Apr 2025 14:24:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	j3whygk/RlYZ76wCT9iuIKZGh9irSBykOVLGvkqBG2k=; b=Z2+VX8KWhkYoLhJ3
	+WwT+RVMajJsw5ZympDzFiFPGYtx8inCj5BMPy8602sEWNSlY4wMtehVtCEa/ov3
	nLj/tji8xO1U5/gPn4eKFu33+LX3xmfNofUthW2OmYS8zBqzmjEyF+CLuxo8jret
	eFVZPcviTQcfEIuqIMeuC74N+Lv0mZQWS4l4NOV33hesNbmw3hFX1qJ2pGFwVZsp
	2Ix/oEOjaB00GQh4oX7nzMAG1YvaNXaYop48YhYXRxrYx3R2aEI/9Eb/DsaWbLQ0
	NpTqmGNYbqrnrCDeSFHfhdbhW+r05flFhI0cXoj20097/TI7Z1gqL2mbd9ubnzFF
	hfwmGA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45uffmwdtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 14:24:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A568240047;
	Thu, 10 Apr 2025 14:24:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D5AB958201;
	Thu, 10 Apr 2025 14:23:47 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 14:23:46 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 10 Apr 2025 14:23:45 +0200
Subject: [PATCH 2/2] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250410-b4-upstream_ospi_reset_update-v1-2-74126a8ceb9c@foss.st.com>
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

As ospi reset is consumed by both OMM and OSPI drivers, use the reset
acquire/release mechanism which ensure exclusive reset usage.

This avoid to call reset_control_get/put() in OMM driver each time
we need to reset OSPI children and guarantee the reset line stays
deasserted.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-ospi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-ospi.c b/drivers/spi/spi-stm32-ospi.c
index 668022098b1eac3628f0677e6d786e5a267346be..96fa362432f13c19e4dde63d964a0db64c8ade95 100644
--- a/drivers/spi/spi-stm32-ospi.c
+++ b/drivers/spi/spi-stm32-ospi.c
@@ -804,7 +804,7 @@ static int stm32_ospi_get_resources(struct platform_device *pdev)
 		return ret;
 	}
 
-	ospi->rstc = devm_reset_control_array_get_optional_exclusive(dev);
+	ospi->rstc = devm_reset_control_array_get_exclusive_released(dev);
 	if (IS_ERR(ospi->rstc))
 		return dev_err_probe(dev, PTR_ERR(ospi->rstc),
 				     "Can't get reset\n");
@@ -937,9 +937,11 @@ static int stm32_ospi_probe(struct platform_device *pdev)
 		goto err_pm_enable;
 
 	if (ospi->rstc) {
+		reset_control_acquire(ospi->rstc);
 		reset_control_assert(ospi->rstc);
 		udelay(2);
 		reset_control_deassert(ospi->rstc);
+		reset_control_release(ospi->rstc);
 	}
 
 	ret = spi_register_controller(ctrl);

-- 
2.25.1


