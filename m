Return-Path: <linux-spi+bounces-3116-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692158D2E93
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 09:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C1E81C2279F
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 07:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8040E16A36B;
	Wed, 29 May 2024 07:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Powr24X3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3883169AD7;
	Wed, 29 May 2024 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968450; cv=none; b=uGAZd7T87EieSRhiVWTE5H+NvZZqlZcfyxDwksGtdE5zvGCZNdmzI01L/UlC9Ut49A3OQKuUHQUSgoja01BEaPAg8ZxxDjNHjPtOTLOSXvPyJHzWMY9rHgTqw9IHUS15kWw1GZTx57wSgltMZYfeai7bTtvXLW4eN8a9Wv25o/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968450; c=relaxed/simple;
	bh=PHJigxpV+zdQT6oSY17JxD0LsV5i8XOQw4gsOOMSFCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaQ0raKeB2uXWJ6M1ZXyszc8cSxV9O6YTPBibvELC6pOmNvuOGZNwiVgQQHPz5BqgWCeFxivmiz69hkYMQOJiwZfUnsfoaElJqryW7uchCgS1w1awWF9CzBMmmk09BSjIJALJZydi5gQmf/7m0A0B7ClWSP48AA9Z4iRnbJltzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Powr24X3; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T3mGtS007681;
	Wed, 29 May 2024 00:40:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=U
	tOI3pKChoknJFYIiDIhTy3uBc1YXnfRLV/g6M+gMcM=; b=Powr24X3aRTjg6UvE
	NG/OIfcsE6CFvw63aJOk6ZFVC9YVf/5NQdipC1RUC6N8o4jlRQ40yY4J24KhW1ps
	OO4P7mNJVf67fQ95tHAaHR4waSWxgGUu1GUaKo1ATisAAyOSFbyKx5aLFedbu6Ig
	+JcBQBNBbBOZSki+x+zateqMLl+3XgM+jqZrTAG1MLHzZ8DbaAq7HsBmEUUHjjsq
	aBsNr79Bf09sLYdr4ZA/+hi55xagOP4EZGFEtqOkabrWlqi0iPCWnOVzNSdW9LSV
	12jbFji+P+JIeHQglyrtTDLqRWCtsHjCy20MGj6xXDt/o0u1rdFX/PPTaj9XmVus
	HcNgA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3yddnvc79e-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 00:40:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 29 May 2024 00:40:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 29 May 2024 00:40:41 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 685DA5B694A;
	Wed, 29 May 2024 00:40:41 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Piyush Malgujar <pmalgujar@marvell.com>,
        "Witold
 Sadowski" <wsadowski@marvell.com>
Subject: [PATCH v6 4/5] spi: cadence: Allow to read basic xSPI configuration from ACPI
Date: Wed, 29 May 2024 00:40:35 -0700
Message-ID: <20240529074037.1345882-5-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529074037.1345882-1-wsadowski@marvell.com>
References: <20240529074037.1345882-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZjMc309sWp7h0vs4U_if3GseymTNa7PQ
X-Proofpoint-ORIG-GUID: ZjMc309sWp7h0vs4U_if3GseymTNa7PQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01

From: Piyush Malgujar <pmalgujar@marvell.com>

These changes enable reading the configurations from ACPI tables as
required for successful probing in an ACPI UEFI environment. In the
case of an ACPI-disabled or DTS-based environment, it will continue
to read configurations from DTS as before.

Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 90 ++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index 3ba0269f1cc3..490bba7a0fc8 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -2,6 +2,7 @@
 // Cadence XSPI flash controller driver
 // Copyright (C) 2020-21 Cadence
 
+#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -14,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <linux/bitfield.h>
@@ -647,6 +649,67 @@ static int cdns_xspi_mem_op(struct cdns_xspi_dev *cdns_xspi,
 					   (dir != SPI_MEM_NO_DATA));
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
+
 static int cdns_xspi_mem_op_execute(struct spi_mem *mem,
 				    const struct spi_mem_op *op)
 {
@@ -670,6 +733,9 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
 }
 
 static const struct spi_controller_mem_ops cadence_xspi_mem_ops = {
+#ifdef CONFIG_ACPI
+	.supports_op = cdns_xspi_supports_op,
+#endif
 	.exec_op = cdns_xspi_mem_op_execute,
 	.adjust_op_size = cdns_xspi_adjust_mem_op_size,
 };
@@ -721,21 +787,20 @@ static irqreturn_t cdns_xspi_irq_handler(int this_irq, void *dev)
 
 static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
 {
-	struct device_node *node_prop = pdev->dev.of_node;
-	struct device_node *node_child;
+	struct fwnode_handle *fwnode_child;
 	unsigned int cs;
 
-	for_each_child_of_node(node_prop, node_child) {
-		if (!of_device_is_available(node_child))
+	device_for_each_child_node(&pdev->dev, fwnode_child) {
+		if (!fwnode_device_is_available(fwnode_child))
 			continue;
 
-		if (of_property_read_u32(node_child, "reg", &cs)) {
+		if (fwnode_property_read_u32(fwnode_child, "reg", &cs)) {
 			dev_err(&pdev->dev, "Couldn't get memory chip select\n");
-			of_node_put(node_child);
+			fwnode_handle_put(fwnode_child);
 			return -ENXIO;
 		} else if (cs >= CDNS_XSPI_MAX_BANKS) {
 			dev_err(&pdev->dev, "reg (cs) parameter value too large\n");
-			of_node_put(node_child);
+			fwnode_handle_put(fwnode_child);
 			return -ENXIO;
 		}
 	}
@@ -789,6 +854,11 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 		SPI_MODE_0  | SPI_MODE_3;
 
 	drv_data = of_device_get_match_data(dev);
+	if (!drv_data) {
+		drv_data = acpi_device_get_match_data(dev);
+		if (!drv_data)
+			return -ENODEV;
+	}
 
 	host->mem_ops = &cadence_xspi_mem_ops;
 	host->dev.of_node = pdev->dev.of_node;
@@ -815,19 +885,19 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	if (ret)
 		return -ENODEV;
 
-	cdns_xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "io");
+	cdns_xspi->iobase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cdns_xspi->iobase)) {
 		dev_err(dev, "Failed to remap controller base address\n");
 		return PTR_ERR(cdns_xspi->iobase);
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sdma");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	cdns_xspi->sdmabase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(cdns_xspi->sdmabase))
 		return PTR_ERR(cdns_xspi->sdmabase);
 	cdns_xspi->sdmasize = resource_size(res);
 
-	cdns_xspi->auxbase = devm_platform_ioremap_resource_byname(pdev, "aux");
+	cdns_xspi->auxbase = devm_platform_ioremap_resource(pdev, 2);
 	if (IS_ERR(cdns_xspi->auxbase)) {
 		dev_err(dev, "Failed to remap AUX address\n");
 		return PTR_ERR(cdns_xspi->auxbase);
-- 
2.43.0


