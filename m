Return-Path: <linux-spi+bounces-3432-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 034CE90D2DB
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 15:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F021C22DD9
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 13:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724F715B12F;
	Tue, 18 Jun 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="s+0qJ32l"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D6215B118;
	Tue, 18 Jun 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717444; cv=none; b=ZpyQMF/KHOMStaFYKLREfeTKQKqkmENMiI9UtP1FZmKW9haBrfVV42qttyaB+mL8oBZEqbBhFiYOE8CQFwF3ro3S7mGfbLYByoaZoKdgJQgFc+gxDewrQg2k/7ta1TVUas5DjdWkhvBgQ6R9HmWqDQ7yAjC84uf6ni/z9j9YRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717444; c=relaxed/simple;
	bh=5QjYLMT+uxnnMaR4y4r1pk2F/qUzGLWhr9DcbV9oLQc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqEdMJh9g39fkJnTGMa4TXOPnTq6pMWdymYABbfBHI3Nm9xOVZlkyGLCcsK6383PCrxlsbAs1Q2KLYZz1jYpM5a0gNxhLhYtLr4l2qxaapyFX+OEadGjoZ6gi8OQF9MCMWORn2ywPVniZP05c1FXRZhDo8pdqWhoze6iPDKA2fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=s+0qJ32l; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IAWtTa014183;
	Tue, 18 Jun 2024 15:30:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ciCfElUMcOpp1w1OhQ/bb7mu8bN6hikfM6sV85h4FHY=; b=s+0qJ32lLaejpGCQ
	OMgimN0FYisM0/qRKamDZv1HU2RaotZuHvHF92iyclCrpWv6SRTdagD5hkihqCDs
	m6c6t2OPynWUiYLDjE9ToGXcnVs8d72EM8VE50FXPoGdt5pQxcDukaupVtayO609
	10bCVjODgAp6bwz9iiiQTQLme8OAQSmgYXvHyIVRBLVrRCx6zmqVLX0x+iaz65uE
	En/UP/QGJQcIJHYUT2DThUc3dAaQcVigtRjNJ3mXiI8cipGPcz1T1dbnmZJgGbj+
	j27oBeAp/0gxcVzQqaoF+uPuQQhgoXx8DWKT/05TTxeCzponcbxCo6UdKAlHgq89
	skN3Mg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ys035knhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:30:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3F81A40045;
	Tue, 18 Jun 2024 15:30:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1C38421862A;
	Tue, 18 Jun 2024 15:29:56 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 18 Jun
 2024 15:29:55 +0200
From: <patrice.chotard@foss.st.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <christophe.kerello@foss.st.com>, <patrice.chotard@foss.st.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 1/3] spi: stm32: qspi: Fix dual flash mode sanity test in stm32_qspi_setup()
Date: Tue, 18 Jun 2024 15:29:49 +0200
Message-ID: <20240618132951.2743935-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618132951.2743935-1-patrice.chotard@foss.st.com>
References: <20240618132951.2743935-1-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01

From: Patrice Chotard <patrice.chotard@foss.st.com>

Misplaced parenthesis make test of mode wrong in case mode is equal to
SPI_TX_OCTAL or SPI_RX_OCTAL.

Simplify this sanity test, if one of this bit is set, property
cs-gpio must be present in DT.

Fixes: a557fca630cc ("spi: stm32_qspi: Add transfer_one_message() spi callback")
Cc: stable@vger.kernel.org
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index f1e922fd362a..6944e85d8367 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -653,9 +653,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
 		return -EINVAL;
 
 	mode = spi->mode & (SPI_TX_OCTAL | SPI_RX_OCTAL);
-	if ((mode == SPI_TX_OCTAL || mode == SPI_RX_OCTAL) ||
-	    ((mode == (SPI_TX_OCTAL | SPI_RX_OCTAL)) &&
-	    gpiod_count(qspi->dev, "cs") == -ENOENT)) {
+	if (mode && gpiod_count(qspi->dev, "cs") == -ENOENT) {
 		dev_err(qspi->dev, "spi-rx-bus-width\\/spi-tx-bus-width\\/cs-gpios\n");
 		dev_err(qspi->dev, "configuration not supported\n");
 
@@ -676,10 +674,10 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	qspi->cr_reg = CR_APMS | 3 << CR_FTHRES_SHIFT | CR_SSHIFT | CR_EN;
 
 	/*
-	 * Dual flash mode is only enable in case SPI_TX_OCTAL and SPI_TX_OCTAL
-	 * are both set in spi->mode and "cs-gpios" properties is found in DT
+	 * Dual flash mode is only enable in case SPI_TX_OCTAL or SPI_RX_OCTAL
+	 * is set in spi->mode and "cs-gpios" properties is found in DT
 	 */
-	if (mode == (SPI_TX_OCTAL | SPI_RX_OCTAL)) {
+	if (mode) {
 		qspi->cr_reg |= CR_DFM;
 		dev_dbg(qspi->dev, "Dual flash mode enable");
 	}
-- 
2.25.1


