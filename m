Return-Path: <linux-spi+bounces-3819-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFFF92C603
	for <lists+linux-spi@lfdr.de>; Wed, 10 Jul 2024 00:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9B41C21F20
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jul 2024 22:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B500189F4B;
	Tue,  9 Jul 2024 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gv5gGon+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F6418563B;
	Tue,  9 Jul 2024 22:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563144; cv=none; b=VRg64ePItVqzSRU8V5iVrnyxmhp1fP8zTCltmgfIxOMOT3IxQnCnKhJS5FeW2w/ZYBFASwW/gtx/9qpb9+k2NmZ3D8tjykfPMJFDMf1ACyLqGq786vCFJfEEZ50Z2IPuywv6MOnCCeFUZUBbemMhIhmPAfGD3QdtL10m83KKTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563144; c=relaxed/simple;
	bh=jEMAsYr6lRJT4aG3aU3El0a4sF220zEr8nfFAlH4l2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QE6q7D9fVyrV7V0lr63oUZGaiSFqDtGYy+nbid/Zz2GxqW2dEwsPK1k3oLXAJYwcaI2NttsW814EJlvxQ5DbX0S0h0s5ol2cckHofz5QAGvLJVWa10k4Ukw0P+BIm5pr8OHY9Gxf9kCgwBvtZ8I1zZB3AmqnLsi0f7uXHDZhCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gv5gGon+; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469KHNfb020699;
	Tue, 9 Jul 2024 15:12:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
	EsEUq5Dw2rAUYuwlaB4GHddWL51G3luUFKzTl9SbtY=; b=gv5gGon+Z3F2+xqWf
	brzrmQ2MSy+TNbzF0wwRXkg38z0LDZNFvc4b06fFVDjyNipxpkqG4TMzgIvKroB7
	XUuW1aWRoLZpVn4TgkPXqguGcYcWPqtA/JHr3R50nWPODE1URcjymPTuPlyNC2f0
	qOmnCyVnNmGV2ztNutjR1gpVk1TDGM6U7TCrwRltDCjRYDWtPfG4a9zaaA3S7X4r
	n3OqhBcHEdxyACTlHOXN9UitlGckfoJ3i04d9ahCba/4BpI9k9QopDsmT/iR1Zcu
	QY9zvkf8M5moavYhlN8jDg3ZG+MFXJ1gBQEovaJbhqPQaK8/vtiA8/7WJzux3leS
	Kfj1g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 408ntymyxj-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 15:12:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Jul 2024 15:12:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 9 Jul 2024 15:12:16 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 921833F707E;
	Tue,  9 Jul 2024 15:12:16 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>,
        "Piyush
 Malgujar" <pmalgujar@marvell.com>
Subject: [PATCH v10 9/9] spi: cadence: Try to read spi-tx/rx-bus width property using ACPI
Date: Tue, 9 Jul 2024 15:12:11 -0700
Message-ID: <20240709221211.2130456-10-wsadowski@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709221211.2130456-1-wsadowski@marvell.com>
References: <20240709221211.2130456-1-wsadowski@marvell.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: upWoHRkCugPWYNp7iEBgNeVSgfqk_JT4
X-Proofpoint-GUID: upWoHRkCugPWYNp7iEBgNeVSgfqk_JT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_10,2024-07-09_01,2024-05-17_01

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
index db267a2ded5d..ddcda153b56d 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -2,6 +2,7 @@
 // Cadence XSPI flash controller driver
 // Copyright (C) 2020-21 Cadence
 
+#include <linux/acpi.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -763,6 +764,66 @@ static int marvell_xspi_mem_op_execute(struct spi_mem *mem,
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
@@ -775,11 +836,17 @@ static int cdns_xspi_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *
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
@@ -1081,8 +1148,11 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 
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


