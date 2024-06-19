Return-Path: <linux-spi+bounces-3485-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17AB90F024
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 16:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCB1283CAB
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BBC14F13E;
	Wed, 19 Jun 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="HpTs5672"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3033F8F1;
	Wed, 19 Jun 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806657; cv=none; b=ciBOXOH5Trf5xFhE5R3ARPIdxvzm/vqWxAI4JoNctwD5zz96PNqUZPZpt1Uf7HZdMtOs84Ja1iyrB6+G/tZ0XyRp57Qh2sHXW3gqrbcCFRYSQzJ90EK1RSsKiXhCeVgSSuuruiR6srmxT5eW/0vph56worw8LLTW/3O+SMYOLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806657; c=relaxed/simple;
	bh=kYpb6m9pSrFELFtpJkHb28PtRl3KnrQsLcM94wBdQ/g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odU1VEpMCENqdMippaBQ7jYfDBYG/qhzPjMGipDK0QYuPZtzkykQjkycawVgnZob76IoCEjoBqjSZJB1wJVxkkJKg1sdcKz/7GV0XuIDbs7ubd2tbDFd/GpdyDBWqCK0iitIoBrIJNStfIjhqf5hxyNTvFpbkCAmam4i7EM0ksY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=HpTs5672; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J7Rs9C022901;
	Wed, 19 Jun 2024 07:17:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=f
	UassYPD1D4RUjbLk+QuJxVbok3eQi6qAtdSargE0BA=; b=HpTs5672O6Ws4XOmC
	mesXt/Lw7P3FB1x6DtaluqDJxOnIriEwr1pAwLfofYRrN8n+0OQpD+BRZHRPtCLw
	bKY7Xslqo/3N+gSVYefgjaXrtnvgND4t0dG3GWF1XOly5TXIKSiD/nS/AgXmgzdH
	FN1+sStAidry6l/BUkvApo/LAghh82mvERSNT9ccRoaRA2Gsr0HnMYXsLfHO5yzN
	j3NjNDxhFzaBJ6nNj1IJmJKptr+49+uVKqaUmer2cxLkWrwYONvlmLkF7WQCY0mZ
	xD72hR1s6pilA7cGQduhH6HwiPQRlB7bPHZ5BLKdkKyga2IkZmkqPKj0NnndAJTy
	CVolw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yutyc1602-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:17:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 07:17:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:22 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 429473F7088;
	Wed, 19 Jun 2024 07:17:22 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>,
        "Piyush
 Malgujar" <pmalgujar@marvell.com>
Subject: [PATCH v9 9/9] spi: cadence: Try to read spi-tx/rx-bus width property using ACPI
Date: Wed, 19 Jun 2024 07:17:15 -0700
Message-ID: <20240619141716.1785467-10-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240619141716.1785467-1-wsadowski@marvell.com>
References: <20240619141716.1785467-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VqYPChkskGb4EyDkcurtJ-p3OAatVVEp
X-Proofpoint-GUID: VqYPChkskGb4EyDkcurtJ-p3OAatVVEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

Try to read bus width property using acpi_dev_get_property function, do
not rely on spi_mem_default_supports_op function only.
If of_device_get_match_data() will fail, retry with
acpi_device_get_match_data() to handle ACPI properly.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 74 +++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 4edac7c8d73c..f2d6e8a85e19 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -2,6 +2,7 @@
 // Cadence XSPI flash controller driver
 // Copyright (C) 2020-21 Cadence
 
+#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -747,6 +748,66 @@ static int marvell_xspi_mem_op_execute(struct spi_mem *mem,
 	return ret;
 }
 
+#ifdef CONFIG_ACPI
+static bool cdns_xspi_supports_op(struct spi_mem *mem,
+				  const struct spi_mem_op *op)
+{
+	struct spi_device *spi = mem->spi;
+	const union acpi_object *obj;
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(&spi->dev);
+
+	if (!acpi_dev_get_property(adev, "spi-tx-bus-width", ACPI_TYPE_INTEGER,
+				   &obj)) {
+		switch (obj->integer.value) {
+		case 1:
+			break;
+		case 2:
+			spi->mode |= SPI_TX_DUAL;
+			break;
+		case 4:
+			spi->mode |= SPI_TX_QUAD;
+			break;
+		case 8:
+			spi->mode |= SPI_TX_OCTAL;
+			break;
+		default:
+			dev_warn(&spi->dev,
+				 "spi-tx-bus-width %lld not supported\n",
+				 obj->integer.value);
+			break;
+		}
+	}
+
+	if (!acpi_dev_get_property(adev, "spi-rx-bus-width", ACPI_TYPE_INTEGER,
+				   &obj)) {
+		switch (obj->integer.value) {
+		case 1:
+			break;
+		case 2:
+			spi->mode |= SPI_RX_DUAL;
+			break;
+		case 4:
+			spi->mode |= SPI_RX_QUAD;
+			break;
+		case 8:
+			spi->mode |= SPI_RX_OCTAL;
+			break;
+		default:
+			dev_warn(&spi->dev,
+				 "spi-rx-bus-width %lld not supported\n",
+				 obj->integer.value);
+			break;
+		}
+	}
+
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	return true;
+}
+#endif
 
 static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
@@ -759,11 +820,17 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
 }
 
 static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
+#ifdef CONFIG_ACPI
+	.supports_op = cdns_xspi_supports_op,
+#endif
 	.exec_op = cdns_xspi_mem_op_execute,
 	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
 };
 
 static const struct spi_controller_mem_ops marvell_xspi_mem_ops = {
+#ifdef CONFIG_ACPI
+	.supports_op = cdns_xspi_supports_op,
+#endif
 	.exec_op = marvell_xspi_mem_op_execute,
 	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
 };
@@ -1064,8 +1131,11 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 
 	cdns_xspi = spi_controller_get_devdata(host);
 	cdns_xspi->driver_data = of_device_get_match_data(dev);
-	if (!cdns_xspi->driver_data)
-		return -ENODEV;
+	if (!cdns_xspi->driver_data) {
+		cdns_xspi->driver_data = acpi_device_get_match_data(dev);
+		if (!cdns_xspi->driver_data)
+			return -ENODEV;
+	}
 
 	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
 		host->mem_ops = &marvell_xspi_mem_ops;
-- 
2.43.0


