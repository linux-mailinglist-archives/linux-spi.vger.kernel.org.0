Return-Path: <linux-spi+bounces-2010-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890F388C4CA
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 15:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212CD3082BC
	for <lists+linux-spi@lfdr.de>; Tue, 26 Mar 2024 14:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DA08062F;
	Tue, 26 Mar 2024 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="o/E3eiY/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9671768EA;
	Tue, 26 Mar 2024 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462290; cv=none; b=jCzFVnw6iCwvPgxdv5JLYxy9XgJSNA2mdUOdSXZ2LMzztdcB8rBMX/MMpars+i+WDh1jgEKKHge9fq8HEEHxWcJAsKBDGh6sg2k7njVXh9VGV0VX06Bt4rFkaF0d1PzKAk6fV59tZpZzYYG7OTvuRR1FsTOtB44BiuyAFb9uOwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462290; c=relaxed/simple;
	bh=Z2rTTZSU9LF30gsK5PsSoDU8bpdOfCujB4gwoQUtkKo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LRh4okjLNLS3FoqT5BWqo0NB7ewYkvEri786KYr1RG3BhKmoQbmWRnsjeAyXoGn9F2RGgq54UQZQDzh0efopMduCqRK2GcDbh0xHLDxWJ+oVvBamE8aCw6ULCrLAycVFNbGqmlPG9Ws5lAb0XPe24cIWmy+DziHeuxap0PNljuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=o/E3eiY/; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q79uU9026416;
	Tue, 26 Mar 2024 09:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=D/7PiV5SdaQE/yscgv0AI1rUYlFumD75i2QJehq/i8s=; b=
	o/E3eiY/11gds3BMurXmeF/OM9lGbA2O1uxhUNacMh78P/StVRC5XnQ87fRLqBg8
	CT099F8KTjKjBTjgSrRxJsiCJOzwwPGOOvlKSNs7IPd7LtP3+tjvGOx8BUlfdF2+
	hk2+u9wD8PUnpxGOwKj6KCiJFXkPHKpditLl9pmr/lWtzQ3yrxxA1hZzGsD0EgoI
	KRlgO34105islrkrQgZbMvgFyHeTUJi3Cqdjb0otSxngqXE+0ev51cgNfA6kyEui
	l0Zik6R7moBPr3tnEgZLV35TtStNu3fEgZzuypC9+pKxzBr36cMPOQQlsfytQd3T
	wlxVARdO4j4QfXWeXdTnVw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3x1ugm5b9y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 09:11:10 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 26 Mar
 2024 14:11:08 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Tue, 26 Mar 2024 14:11:08 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 951C0820257;
	Tue, 26 Mar 2024 14:11:08 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 2/3] spi: Add a mechanism to use the fwnode name for the SPI device
Date: Tue, 26 Mar 2024 14:11:07 +0000
Message-ID: <20240326141108.1079993-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326141108.1079993-1-ckeepax@opensource.cirrus.com>
References: <20240326141108.1079993-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: WEhIFwz6ndQjn0qNPtjkc2KhZzZB8Kch
X-Proofpoint-GUID: WEhIFwz6ndQjn0qNPtjkc2KhZzZB8Kch
X-Proofpoint-Spam-Reason: safe

Add a mechanism to force the use of the fwnode name for the name of the
SPI device itself. This is useful when devices need to be manually added
within the kernel.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi.c       | 7 +++++++
 include/linux/spi/spi.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ff75838c1b5d..fae0787beece 100644
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
index c459809efee4..25461775718d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -222,6 +222,7 @@ struct spi_device {
 	struct spi_delay	cs_setup;
 	struct spi_delay	cs_hold;
 	struct spi_delay	cs_inactive;
+	bool			use_fwnode_name;
 
 	/* The statistics */
 	struct spi_statistics __percpu	*pcpu_statistics;
@@ -1608,6 +1609,7 @@ struct spi_board_info {
 	char		modalias[SPI_NAME_SIZE];
 	const void	*platform_data;
 	const struct software_node *swnode;
+	bool		use_fwnode_name;
 	void		*controller_data;
 	int		irq;
 
-- 
2.39.2


