Return-Path: <linux-spi+bounces-2291-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0C18A0BD9
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 11:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55202B21EDD
	for <lists+linux-spi@lfdr.de>; Thu, 11 Apr 2024 09:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49514140E3D;
	Thu, 11 Apr 2024 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="lwxwIUEg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01113CF91;
	Thu, 11 Apr 2024 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826399; cv=none; b=bf4SfkC3ju8/byfXM92SbFVw2IAQ4pGPcl9zTQlZPMIGgY9okm8PM0WOwOrSFrjHWKW/EiwbHAhG5F9bfNqbnU0Xaf30Oe3vLdhgzsIK2FJaJaHpf+TCKHo87lCldT3DihWM1KEm6g0FQQ27e5tdVBL/sJTzw42MnI+fs+brmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826399; c=relaxed/simple;
	bh=g9Z/t8dYQdb1h+aQuS3sfiFZ0+gR5gKxTF6GAduXUfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0++DXOGe6uulA/RcTuqfyHS8/VS9yTRogin58IH4vZKrR71A/jvOihlRKByHh0ifehoLfZWBT/HI66YzGc7Bo6ibEp0r11UlfzLJSdU0vySDX6/0VzX2xcQPXiJhhb3EB4cwVmSKzoXbzgVtD3B2xox57V67/rCbiL3G6h/vgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=lwxwIUEg; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43B5naFI004518;
	Thu, 11 Apr 2024 04:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=QipT1LO8OVfinJXkxYJET0u0cQqkXzki4p4BFttvsKo=; b=
	lwxwIUEgLk1PV10KHOYpa0hTExYqLQ+2SUf3+yRGDF7RTPwkowZqjZZx0C2KNdMz
	HfEL3qwdfLdBbJmiXDxP2R5dSaXgnktGLYoBGciLaNbIL3dGArNXJkOYTab4PyzU
	W/AHJcY0ktmHsymC6WIUjbxommw76M0kLkrFl3NrD9ZDkOsmINfgIqsJgJfAn4CT
	09az5rYDX1XaUGtNHfhcYLOLU6pT+SW0K/36KPJdt3YTF3vbJOUd09hX362qu1Xo
	sbVEytpeVa4JD3y/WKZIHdL43i3NlIx9SKZk39o+LGMy/UsdHygqJqF8lVlNyUxk
	tFWx5/gL+n0gyx4EAM/MEg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xb2tjq0gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 04:06:30 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 10:06:28 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 11 Apr 2024 10:06:28 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 7302582024A;
	Thu, 11 Apr 2024 09:06:28 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v5 2/4] spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
Date: Thu, 11 Apr 2024 10:06:26 +0100
Message-ID: <20240411090628.2436389-3-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: bqrTTMQeB6VtG5rBBR32TDmTiw_OSygV
X-Proofpoint-GUID: bqrTTMQeB6VtG5rBBR32TDmTiw_OSygV
X-Proofpoint-Spam-Reason: safe

Use the more modern is_acpi_device_node() rather than checking
ACPI_COMPANION().

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

New since v4 of the series.

Thanks,
Charles

 drivers/spi/spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a2f01116ba09..05b33901eaa9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -12,6 +12,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
+#include <linux/fwnode.h>
 #include <linux/gpio/consumer.h>
 #include <linux/highmem.h>
 #include <linux/idr.h>
@@ -597,10 +598,11 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
 
 static void spi_dev_set_name(struct spi_device *spi)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&spi->dev);
+	struct device *dev = &spi->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 
-	if (adev) {
-		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
+	if (is_acpi_device_node(fwnode)) {
+		dev_set_name(dev, "spi-%s", acpi_dev_name(to_acpi_device_node(fwnode)));
 		return;
 	}
 
-- 
2.39.2


