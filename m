Return-Path: <linux-spi+bounces-3986-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E509B93B43D
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 17:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20B72835FA
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F91C15F3EA;
	Wed, 24 Jul 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FZTDNshI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA515ECE6;
	Wed, 24 Jul 2024 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836098; cv=none; b=P9erHVdPhZE5uWJCjl1IZrxU7mQLhEbSGIXaRWH/eHEZL2ZQBJX/KOaRXoRG4YXH/Re7BdVlIw9wVfJy91c6IqPctkeBOYjNvLPEka8juJNIHd9tuKBbU+39PS9MiJ6jMXBgjYVWDHECUpigSMBldYFuPnNVfWqnGZtmeEwUqfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836098; c=relaxed/simple;
	bh=TH/zr7wQzWUy5hsX51vjqwemsh3dyZfyEycxJmPBEos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qixZ+fcIGVDLsGd0VIpnJwqY3D40MHDUGe7DItmzAh+zDEkSc0Jk1VvXjGMFB0yq8nPqOTggvd+aORKW36sPBut42l7OvEedIjxEvMOKHDN6UNJSDNPfyqaKzFOmVMINylfNlbwn+tjkmlPV7Qjtc652n5qBUCnt+Okfu/lHn5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=FZTDNshI; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OEGNFT001424;
	Wed, 24 Jul 2024 08:48:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=V
	rVipCon7nFElqg0nHVHfHaK6r5IoBBiXib3NKlgyKo=; b=FZTDNshI9Eoph3iwA
	feCZQfn+WxzeVEBcLJgy7Mt374EA0hu73b1x3pJPeRPWp4KdCyzdwlBoOJ1oWrsQ
	pDu+NYsXW8yZdJN2XAgN7ZJb4/qFbGHNyReQIji1pO7wUMul6EBaxCAYoZWooSAb
	4o+83TGbM+U1Co3FGSTsQllmHKuC0afn8YYI7nccWdw1q3/EqIILYzRmzVobKioc
	J8ODQgOtFRcElcOPh7TDWbEUbM//K2GTQOMkeCpVWd6HYir41msmuc2BNM6LblGd
	4+5lTG5YP+Ic/aoQxKa78opfvT1S21365oBfzeq7ZJdsV9nFFPXv4V0YiLWwTqMN
	bnQ1w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40k0yh1d6c-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 08:48:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 24 Jul 2024 08:47:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 24 Jul 2024 08:47:57 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 30F913F706F;
	Wed, 24 Jul 2024 08:47:57 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>,
        "Piyush
 Malgujar" <pmalgujar@marvell.com>
Subject: [PATCH v11 9/9] spi: cadence: Try to read spi-tx/rx-bus width property using ACPI
Date: Wed, 24 Jul 2024 08:47:39 -0700
Message-ID: <20240724154739.582367-10-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724154739.582367-1-wsadowski@marvell.com>
References: <20240724154739.582367-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: bk9rfijhqsK6fYDF4oZroml9VCyjQfqY
X-Proofpoint-ORIG-GUID: bk9rfijhqsK6fYDF4oZroml9VCyjQfqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01

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
index 28c1aea01743..695a9bc1969a 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -2,6 +2,7 @@
 // Cadence XSPI flash controller driver
 // Copyright (C) 2020-21 Cadence
 
+#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -773,6 +774,66 @@ static int marvell_xspi_mem_op_execute(struct spi_mem *mem,
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
@@ -785,11 +846,17 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
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
@@ -1091,8 +1158,11 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 
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


