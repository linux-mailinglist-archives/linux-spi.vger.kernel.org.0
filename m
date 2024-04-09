Return-Path: <linux-spi+bounces-2250-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D4189DA09
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 15:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1571C22617
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 13:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D412FB00;
	Tue,  9 Apr 2024 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dWVTXNZN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84A112F59B;
	Tue,  9 Apr 2024 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668910; cv=none; b=fQuvGZQcWg/QXWZ+g6GkReIpdBUbQePoIhNZ+/dUNTkqT/0dBgrc/+YUr/rPJ2XYKa9MCvrErP6gH/LKbIkGddpxOeDDqu8LNX5xjd0wQvQ7Jttqg5wq2z+hMPHmxJv1ctpmn1y9uzHEEY1wsOHjVt2MszJ4nw4ZtcshpESJq4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668910; c=relaxed/simple;
	bh=f9ChvmPDzoBtuQ64Au0XUKLPDdY9lsac/LbOP7uErN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzgb5zINncBubgi5BJqj+0LH2i0np+B0r7HzPzhaCYVHK/96ERIMU3vg2yUB9Ce6uS4tWCpFGg8M/KlhfiieVqCcLYkmlYvdd9dC4O1VviMJp1NRIvFzQ+R90K//sWBwqblV7UKJN3wHMYYm18WBoT7MtX3k7NlH36nXodTrvQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=dWVTXNZN; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4396p0c5026996;
	Tue, 9 Apr 2024 08:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=B8bRjhtydFRwNUB09aFhwsBwoc6QVAE4crkE+E4Q+JE=; b=
	dWVTXNZNRzkHaWkxVKS6XPMRAzexA44zJeMoFGn/gY4vTVFWYfVg8tzrIkD/hW59
	7vxX1GRMsxZJUItF7zySNiV40INabOWSSJ1qiP9tNSs6rZy7ZcKEo+n67znM4DUE
	u+np4phpg4ExGj1ctLYGjzxfqvBaKf8TVAmaVRrn2qhktAD4Th5zaPAJD7NVGMZM
	iHiY8W2CkwP6J5PRkEMZyS1CYn2CBsxuPB+ymUMue38lR0ea1aeKEgntB/902nG/
	2rFjy9FkjLyEMUFFiWr06q9TdbAGxOVbyhtTKtOD/PpcrjTSazKg6L9wi/8DnRO0
	p7xsTy4CPU6M26/uLmBe9w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxjh3x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 08:21:32 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Apr 2024
 14:21:26 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Tue, 9 Apr 2024 14:21:26 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 2CDD4820271;
	Tue,  9 Apr 2024 13:21:26 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v4 2/3] spi: Add a mechanism to use the fwnode name for the SPI device
Date: Tue, 9 Apr 2024 14:21:25 +0100
Message-ID: <20240409132126.1117916-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com>
References: <20240409132126.1117916-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DHisJcjvvwpRV8mqK5fXRZ5Wz06EdpRF
X-Proofpoint-GUID: DHisJcjvvwpRV8mqK5fXRZ5Wz06EdpRF
X-Proofpoint-Spam-Reason: safe

Add a mechanism to force the use of the fwnode name for the name of the
SPI device itself. This is useful when devices need to be manually added
within the kernel.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v3:
 - Always name swnode SPI devices after the node name

Thanks,
Charles

 drivers/spi/spi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a2f01116ba09..52c70705d179 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -598,12 +598,18 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
 static void spi_dev_set_name(struct spi_device *spi)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&spi->dev);
+	struct fwnode_handle *fwnode = dev_fwnode(&spi->dev);
 
 	if (adev) {
 		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
 		return;
 	}
 
+	if (is_software_node(fwnode)) {
+		dev_set_name(&spi->dev, "spi-%s", fwnode_get_name(fwnode));
+		return;
+	}
+
 	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
 		     spi_get_chipselect(spi, 0));
 }
-- 
2.39.2


