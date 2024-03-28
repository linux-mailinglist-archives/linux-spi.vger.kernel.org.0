Return-Path: <linux-spi+bounces-2076-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3F9890102
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 15:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEB42976CE
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8011DDF6;
	Thu, 28 Mar 2024 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gnyu0O+y"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7E57895;
	Thu, 28 Mar 2024 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634493; cv=none; b=cipqDPXweZIyxNsOycp/3CUUzNmaY1WVFRoTZu1kgAorS+vkVbgiEx4xBbly4i5tKlXw6LaFlkcIzrLOVOaIhhxGFeL/MHK7jh4Q59s5ebMYvLoQaCbSNpK6LZl3s8wLqMaoolkD7UbvKESWAv9O/E19VcIoepEQ3scAUrwKyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634493; c=relaxed/simple;
	bh=bW9oeNxOUCK8arG9GOfJG98kVBiZAFEHPeFGnEThLS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=En+xD45NQTrpr1ai0c2SoeUkG1t1vb5MwFJLOzDeHKMQB8+SJedf/rvP97SiLC3064bqt5avNHxAG/RGhefkUKU1oD4Pv6D/ZlEVACn0CiWFYH0uE9zhOZU9OZWqqdraQwjwIWGjxDhnTAWAQNEv5FHRpY9lRyKDVZGPWQ/bieY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gnyu0O+y; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SCxqrf012070;
	Thu, 28 Mar 2024 09:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=bkfRGhVtbDns6zx6tQ3A0VuWqG9lQAXJjHbcRzzlzzk=; b=
	gnyu0O+yC5kSDqmkUNmblo11N91muRqvuHO7ZDl6AQhm9/xwLo1CQRKskaJU7Xdp
	IMEf8CTvTmXUq5YzE/9fERrnWjWv8rnPzfjLTzowkjUM+S1S/OJrhQaktyZDKe+C
	YaQWlU1bMVL6BJKL+0uhVyRYAb5XRpUz139EIGTR5SbaOHPXAQ8nQ34/lQBNeAi1
	YOxSt2zfV2Q098KUhFaApBRr3ah0e7D2SDFszUHZaWBUYlvx0UPF+ftCl90iBG/b
	PXsIfC80aY/bDurH+lp9ej6xQAasiCbzlXoR9BIsgGFIwexZVkQstJFFy5KMEPwU
	RdasB/2lI/prhQTyCPDuog==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3x4et832uk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 09:01:23 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 28 Mar
 2024 14:01:19 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Thu, 28 Mar 2024 14:01:19 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 60AB082024B;
	Thu, 28 Mar 2024 14:01:19 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 2/3] spi: Add a mechanism to use the fwnode name for the SPI device
Date: Thu, 28 Mar 2024 14:01:18 +0000
Message-ID: <20240328140119.1784350-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140119.1784350-1-ckeepax@opensource.cirrus.com>
References: <20240328140119.1784350-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EMYdVaGgINgGmOVV5Z3vdgrTp_1gyilt
X-Proofpoint-ORIG-GUID: EMYdVaGgINgGmOVV5Z3vdgrTp_1gyilt
X-Proofpoint-Spam-Reason: safe

Add a mechanism to force the use of the fwnode name for the name of the
SPI device itself. This is useful when devices need to be manually added
within the kernel.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

Thanks,
Charles

 drivers/spi/spi.c       | 7 +++++++
 include/linux/spi/spi.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a2f01116ba092..a38a4960032b8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -598,6 +598,12 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
 static void spi_dev_set_name(struct spi_device *spi)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&spi->dev);
+	struct fwnode_handle *fwnode = dev_fwnode(&spi->dev);
+
+	if (spi->use_fwnode_name && fwnode) {
+		dev_set_name(&spi->dev, "spi-%s", fwnode_get_name(fwnode));
+		return;
+	}
 
 	if (adev) {
 		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
@@ -830,6 +836,7 @@ struct spi_device *spi_new_device(struct spi_controller *ctlr,
 	 * spi->cs_index_mask as 0x01.
 	 */
 	proxy->cs_index_mask = 0x01;
+	proxy->use_fwnode_name = chip->use_fwnode_name;
 
 	if (chip->swnode) {
 		status = device_add_software_node(&proxy->dev, chip->swnode);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index b589e25474393..265f5d0c15304 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -222,6 +222,7 @@ struct spi_device {
 	struct spi_delay	cs_setup;
 	struct spi_delay	cs_hold;
 	struct spi_delay	cs_inactive;
+	bool			use_fwnode_name;
 
 	/* The statistics */
 	struct spi_statistics __percpu	*pcpu_statistics;
@@ -1603,6 +1604,7 @@ struct spi_board_info {
 	char		modalias[SPI_NAME_SIZE];
 	const void	*platform_data;
 	const struct software_node *swnode;
+	bool		use_fwnode_name;
 	void		*controller_data;
 	int		irq;
 
-- 
2.39.2


