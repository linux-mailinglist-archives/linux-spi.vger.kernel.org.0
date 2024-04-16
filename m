Return-Path: <linux-spi+bounces-2364-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B588A67D3
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 12:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0539E1C213D8
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 10:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5911786659;
	Tue, 16 Apr 2024 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="KuryvxYw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3FE8664D;
	Tue, 16 Apr 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262160; cv=none; b=M7JvnhgTOxYGQaZl2hdYM2BsDDSDWyTX6pvOWCZwUnPvoq4jXp3ARrkjDDanJgS+waaC80YQ3zJfJqCdk9AS+V1KcGkLqSc0HwCWjdxMyuUBkjIiW5UG0ikCI5rATqU6Te8/zjMDiqPHzBjfBriMU1Eu6GCv1esGrvVXZNV+5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262160; c=relaxed/simple;
	bh=7d8QTyQm0t8Rnfhnfjy0WU9F1cAQyPWJE+m3DEf+o90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmI8Riz1BoyDgX37LhE4s7nNi1yaNuSXgRL1vBd0Y9oO2Hon9HwBN3+9atceBUAz1Aeu/hU4rr3yow2AIsz+yC3vBF5zwDST71Lq79fWo/u6N59d5q1HC1mkWn5B7FoyUWvN6sobIy7IaTeB/GQmVb6jqKdQPXLXnehsh9Fy3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=KuryvxYw; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43G4X60H024041;
	Tue, 16 Apr 2024 05:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=B/CISAwwleZAwjFJS0XuO+w5MFROMqr1aiiP/a2r0aA=; b=
	KuryvxYwBANrPknEG18opg2uGjv3vBwIz8kmDIs6sVrHPux9rRpoeqFGUFi03AfZ
	4bh3V1qPLb9GBQTYaKSmBt7yQEBVldQR5UY4thQmiTsr5nUVI4Q9AsddeVbnXV1/
	4K/9cpcJ2kR1fwBkq/3f8KG812pumGAhzXMuDMj2RmB1RNJNmSd2FfC7p5aTK7f6
	WKTL8/TDFd/Av15ABbCKeWFcMmyvK9rQdQNCU9Nyi9nmaLxANJqZkaybjvyZ3l2H
	y9Z5PP0a7nbFiPNAPcOjh42QDxvxUPicVoOkDyXEGnmjLdE0w/1mtYwUG+/dpWUU
	a0h+6k5rXamqGvZRTLpv9Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhtdkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 05:09:06 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 16 Apr
 2024 11:09:05 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 16 Apr 2024 11:09:05 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E1C1D82024A;
	Tue, 16 Apr 2024 10:09:04 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <andy.shevchenko@gmail.com>, <bard.liao@intel.com>,
        <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v7 2/4] spi: Switch to using is_acpi_device_node() in spi_dev_set_name()
Date: Tue, 16 Apr 2024 11:09:02 +0100
Message-ID: <20240416100904.3738093-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240416100904.3738093-1-ckeepax@opensource.cirrus.com>
References: <20240416100904.3738093-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Yr1sgpNIfLZdyJODVcbIxWkF8Ry-AmVg
X-Proofpoint-GUID: Yr1sgpNIfLZdyJODVcbIxWkF8Ry-AmVg
X-Proofpoint-Spam-Reason: safe

Use is_acpi_device_node() rather than checking ACPI_COMPANION(), such
that when checking for other types of firmware node, the code can
consistently do checks against the fwnode.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v6.

Thanks,
Charles

 drivers/spi/spi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a2f01116ba09..d1f82a35f2d0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -597,10 +597,11 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
 
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


