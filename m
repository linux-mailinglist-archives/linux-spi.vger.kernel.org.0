Return-Path: <linux-spi+bounces-2294-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E7A8A0BDC
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 11:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994221F2780A
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 09:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B4514264F;
	Thu, 11 Apr 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FENghwAE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B3B1428EA;
	Thu, 11 Apr 2024 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826402; cv=none; b=bXl6tfdi4OdygVLPtTzSf4DYXAj2eMfYVo8CXeR07HEoK+Ls9QSE6BRqWr5z/vTuFsDcDF8AnEgOfsHIJ34WL1MyMI/36roOxLN41XLgsNz0KjKQtK97KHuqXLfTKrnWhvTP+cvVnxcjbtNJOJH94jVBHqjYkaaspocSWphoIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826402; c=relaxed/simple;
	bh=HVgSEgxRrmYJOtgTv5WEMuIN0wzjkpN9PfeStzIoO9I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsSZY69sZ/DmuwaH0RRkRFQv5X/cdRGSElWr7/iR+IO10p3bq9zVTadYtxLjxAtb2k3QxwbFQjSm+RcOkgFfLLJNrAeKXba5xOS0m5xyQf/jH5cswGmulkKE1Jj1D6XIp4JzeXKbuh8CgE8m3s5AZtPylBy8Y0/T1iUwAnC9Nik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=FENghwAE; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B5naFL004518;
	Thu, 11 Apr 2024 04:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=btm9edeyD9TqxIKMi++P0AN2c6THTr+8VoUcx16JCnU=; b=
	FENghwAESIRF9Lo8ymfnnThNtqRVIeeghc5XPFoHJLLtMgXDIGmb0gLi03jtUikm
	knNt7cXchYGWJWs9aa+Ms/APkh8erHqNIoydFyhz4MOBKssNnceUj1kbK9S3lj/i
	zx8WW+iV6zLKsql6tN/r9xiZXNY4/SciJCr+z0VesxAQhifsin7HSf5zO5GJY6ou
	0gPq4w7v5SbMZDw8tzENwfRXwHoWq7tkXURiy5perpRVPZazMDW6spVmUyGNfcpu
	P9TCKDEfn6I4UQbWkJVHXcm3HiiQ4qh+RSRrvymN510WMLrtHujyp6zpuX0FfPyc
	e6R8CCxaxEYCnAkeXLecEw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjq0gx-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 04:06:32 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 10:06:28 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 11 Apr 2024 10:06:28 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7FBDC82024B;
	Thu, 11 Apr 2024 09:06:28 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v5 3/4] spi: Update swnode based SPI devices to use the fwnode name
Date: Thu, 11 Apr 2024 10:06:27 +0100
Message-ID: <20240411090628.2436389-4-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
References: <20240411090628.2436389-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EWIKdDJn32_ySafsUtcaSiS17Us45_xE
X-Proofpoint-GUID: EWIKdDJn32_ySafsUtcaSiS17Us45_xE
X-Proofpoint-Spam-Reason: safe

Update the name for software node based SPI devices to use the fwnode
name as the device name. This is helpful since swnode devices are
usually added within the kernel, and the kernel often then requires a
predictable name such that it can refer back to the device.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v4.

Thanks,
Charles

 drivers/spi/spi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 05b33901eaa9..bcc9d3ab7cd9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -606,6 +606,11 @@ static void spi_dev_set_name(struct spi_device *spi)
 		return;
 	}
 
+	if (is_software_node(fwnode)) {
+		dev_set_name(dev, "spi-%s", fwnode_get_name(fwnode));
+		return;
+	}
+
 	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
 		     spi_get_chipselect(spi, 0));
 }
-- 
2.39.2


