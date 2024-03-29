Return-Path: <linux-spi+bounces-2108-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CD9891826
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 12:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6D31C21B66
	for <lists+linux-spi@lfdr.de>; Fri, 29 Mar 2024 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB98E6A8D2;
	Fri, 29 Mar 2024 11:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="M67BFP6P"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B36A026;
	Fri, 29 Mar 2024 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712860; cv=none; b=Q46Z1nlSP4HEd0zA5MD5Bez9yDD18BEEPYACFKSnnd+gLp5KbcvHBVN/a1BZz5NKBsU9vehC2W7Xx4rxk7X1Hdu/VEkP7bxQvxswStD8byMmgHj0u+JpeQUgRAkzrnBsGQ6psaUt/EE4HI7+ylFZ3ZRHWhXsqf5mF+EP+wFI8qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712860; c=relaxed/simple;
	bh=v1LxQ5YjmxS092pnx1Mx33QXtxtUl7MuKIwFnJmJrHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWgdaAHUE9naPTsQcv2+tucKuFEi2BhSO58uObwRmookfWihtwFNCWPP6J7fZVnYl6tFlO2Pnflk1h1kqQQKAn0FsrsCJ1Roly1GNmrKm9sabZN4U8Y5lFzcYa/oJZIC7oMqvndG7jSikIzt25an8hwu7dlsQ1JYKxHRt++pxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=M67BFP6P; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T6uj1C024362;
	Fri, 29 Mar 2024 06:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=BDyUt3oHAWEQV0CrT1w+UvB+a7MzJpCpZIMhThA78mw=; b=
	M67BFP6PWEjwih7d4CrtUOf7XRhSoq+anp6N+zxXpaNUwp4hCVbwldTaZoyr12Dd
	zwkKO1KH+8djqf83M8HyjevQfpHzqTSnFNpcH9uUNGS7iySdtczsaC9pPMta9NDB
	GVW3QyEDaSA4+jwONS8YM0V/2j5lTlgkZyPGQN9yraex1yrFDCBoKvcNHm/MIXsc
	pvQeIQApZ3vKMuadGb2xO6mDtDQFCpZJ/K+8QFT5aQo6UVa3X9PQsorgItKZFoJf
	pDrV1tO2RdK928oCOhVEWKkaN/tMu+j9Jn6noJYFo4KJ+OH+ScfZaOppOdTxl4tp
	rfhN0MsIWD6k3CcBt+GuYg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x4k7k4748-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 06:47:32 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 29 Mar
 2024 11:47:30 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Fri, 29 Mar 2024 11:47:30 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 48CA982024B;
	Fri, 29 Mar 2024 11:47:30 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>
CC: <linux-gpio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v3 2/3] spi: Add a mechanism to use the fwnode name for the SPI device
Date: Fri, 29 Mar 2024 11:47:29 +0000
Message-ID: <20240329114730.360313-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
References: <20240329114730.360313-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ztLN6ysgwOR2UPbWezUCIOiKiE3E9Omi
X-Proofpoint-ORIG-GUID: ztLN6ysgwOR2UPbWezUCIOiKiE3E9Omi
X-Proofpoint-Spam-Reason: safe

Add a mechanism to force the use of the fwnode name for the name of the
SPI device itself. This is useful when devices need to be manually added
within the kernel.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v2.

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


