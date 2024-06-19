Return-Path: <linux-spi+bounces-3478-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0F690F00E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 16:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4141C2253B
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DCF1C694;
	Wed, 19 Jun 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fg1Vop6w"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F4C14F98;
	Wed, 19 Jun 2024 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806650; cv=none; b=NTWkbcVjzj209vNr6P2b+bSjClksvV0OSHMq8/PYghFukA7kSDXpLf+Izx+GMMbfa9lwIpitS19Uv8+BzsOXB/Iw6SNN3YqMQ+FpasCADLmzwEkYlwsOFocOrcrhBSzW/GQ3WTtOcXKxw+18l11Sra42ZvFpkTG0WdCA2tv+IzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806650; c=relaxed/simple;
	bh=c9QfpIGk2iby37sZ2hQHLAVsjmveHtPjCNGtew6AsIE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vp7RWiYJ+bc74bEAkdih4Ik2kCaEigVrdImIDQHf1LXmimxlvWEchlXtcn3UOO9EcYtO20+slPxepsiZvg/XQljbiPWwOKVWUOzZDhHJLCI4uknC163BoFdC6+AxJbW3JW88B8/yoIBI19iZHqIRtL9eujpe89BrrJYw5yDfglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fg1Vop6w; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9l8ig011743;
	Wed, 19 Jun 2024 07:17:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=S
	zN3CdOiRnpNIyBon3VQpyH0vp2Wso5nEm+dyID7KFM=; b=fg1Vop6wO38o0Se3L
	sNcVvLAfgYy7ZWcxYF1MUoLpPzFSgmQHQle/TelmDj9FiEqy6bpQdvwAVTKUPMNn
	oYXz6TTl/JNch06de7f8KtrEfVx1vgsy6PwCLSvhq+V5VmhB0a91zmlV6Tv7JGrB
	cWWIOmTHTX0SENmxX64wJMAEIk3ccT1QiL/iMRZQS0lHaKb8HgnXWd49gUGKDuRs
	T3l864okh/nHuNfI45PHKJkW4tczriqpb9biI74yfAJUz7f46eRXiXbLDuH1MJuX
	yccNECR44B068biXFJcMnO6ZEr406vPgMfxwQBleSreYqCLz+5E7WN5n4zpTNSm2
	Snpdg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yuw0jrudr-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 07:17:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 07:17:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 07:17:21 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 689593F7081;
	Wed, 19 Jun 2024 07:17:21 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <pthombar@cadence.com>, Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH v9 5/9] spi: cadence: Add Marvell xSPI interrupt changes
Date: Wed, 19 Jun 2024 07:17:11 -0700
Message-ID: <20240619141716.1785467-6-wsadowski@marvell.com>
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
X-Proofpoint-GUID: O4_DWM9xN_LIXtO4aLNZFidL9-ori_cy
X-Proofpoint-ORIG-GUID: O4_DWM9xN_LIXtO4aLNZFidL9-ori_cy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

It is possible that before enabling interrupt, interrupt bit will be
set. It might cause improper IRQ handler behaviour. To fix it, clear
interrupt bit before enabling interrupts. That behaviour is specific to
Marvell xSPI implementation.
In addition in Marvell xSPI interrupt must be cleared in two places -
xSPI itself, and Marvell overlay.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/spi/spi-cadence-xspi.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index c79f2a2931a8..eb9293e8d708 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -311,6 +311,7 @@ struct cdns_xspi_dev {
 
 	const struct cdns_xspi_driver_data *driver_data;
 	void (*sdma_handler)(struct cdns_xspi_dev *cdns_xspi);
+	void (*set_interrupts_handler)(struct cdns_xspi_dev *cdns_xspi, bool enabled);
 };
 
 static void cdns_xspi_reset_dll(struct cdns_xspi_dev *cdns_xspi)
@@ -472,6 +473,23 @@ static void cdns_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
 	writel(intr_enable, cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
 }
 
+static void marvell_xspi_set_interrupts(struct cdns_xspi_dev *cdns_xspi,
+				     bool enabled)
+{
+	u32 intr_enable;
+	u32 irq_status;
+
+	irq_status = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
+
+	intr_enable = readl(cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
+	if (enabled)
+		intr_enable |= CDNS_XSPI_INTR_MASK;
+	else
+		intr_enable &= ~CDNS_XSPI_INTR_MASK;
+	writel(intr_enable, cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
+}
+
 static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 {
 	u32 ctrl_ver;
@@ -489,7 +507,7 @@ static int cdns_xspi_controller_init(struct cdns_xspi_dev *cdns_xspi)
 
 	ctrl_features = readl(cdns_xspi->iobase + CDNS_XSPI_CTRL_FEATURES_REG);
 	cdns_xspi->hw_num_banks = FIELD_GET(CDNS_XSPI_NUM_BANKS, ctrl_features);
-	cdns_xspi_set_interrupts(cdns_xspi, false);
+	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 
 	return 0;
 }
@@ -578,7 +596,7 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE, CDNS_XSPI_WORK_MODE_STIG),
 	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
 
-	cdns_xspi_set_interrupts(cdns_xspi, true);
+	cdns_xspi->set_interrupts_handler(cdns_xspi, true);
 	cdns_xspi->sdma_error = false;
 
 	memset(cmd_regs, 0, sizeof(cmd_regs));
@@ -610,14 +628,14 @@ static int cdns_xspi_send_stig_command(struct cdns_xspi_dev *cdns_xspi,
 
 		wait_for_completion(&cdns_xspi->sdma_complete);
 		if (cdns_xspi->sdma_error) {
-			cdns_xspi_set_interrupts(cdns_xspi, false);
+			cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 			return -EIO;
 		}
 		cdns_xspi->sdma_handler(cdns_xspi);
 	}
 
 	wait_for_completion(&cdns_xspi->cmd_complete);
-	cdns_xspi_set_interrupts(cdns_xspi, false);
+	cdns_xspi->set_interrupts_handler(cdns_xspi, false);
 
 	cmd_status = cdns_xspi_check_command_status(cdns_xspi);
 	if (cmd_status)
@@ -786,9 +804,11 @@ static int cdns_xspi_probe(struct platform_device *pdev)
 	if (cdns_xspi->driver_data->mrvl_hw_overlay) {
 		host->mem_ops = &marvell_xspi_mem_ops;
 		cdns_xspi->sdma_handler = &marvell_xspi_sdma_handle;
+		cdns_xspi->set_interrupts_handler = &marvell_xspi_set_interrupts;
 	} else {
 		host->mem_ops = &cadence_xspi_mem_ops;
 		cdns_xspi->sdma_handler = &cdns_xspi_sdma_handle;
+		cdns_xspi->set_interrupts_handler = &cdns_xspi_set_interrupts;
 	}
 	host->dev.of_node = pdev->dev.of_node;
 	host->bus_num = -1;
-- 
2.43.0


