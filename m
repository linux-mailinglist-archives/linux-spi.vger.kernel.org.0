Return-Path: <linux-spi+bounces-3745-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94817927764
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 15:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176871F235C8
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECE21822E2;
	Thu,  4 Jul 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MnVHotRr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569791AE0B9
	for <linux-spi@vger.kernel.org>; Thu,  4 Jul 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720100741; cv=none; b=IL8w7DaPN5GQLzI/0ZkHM4sJFZvW98Jm92JBxEuVSA4zEWkJEr2jXgjsneWv2HGXv1yvbU/gM5DoPPnbxPUm0EU0DMd00PFXz6bRZRb3a0Q0ehYRQS9nPlLPVRvZ+CjCczqiPYtg5OFsmkP/dGesvi8dJMX5+W39STV9az47iwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720100741; c=relaxed/simple;
	bh=ZXi1XBghFTCRJBmNlnEz0KpOTovl8UOXAZFaQB9NdyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fl2FVJXx2E40uVPInyiaMwdW21LkQ+E0YVyfbR+rYHgNQ+ZvG7ORYnTGbcurvmbWs2EnVlxt8EpgtGT3Hgdvj2SBbsshWYdpP5nQcbyZfnQT8W88t7EXCD/XJxn8mMYrcjT2zPTtBHJDZdqLkI+livVXtueaEcFL1RH6aYeA7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MnVHotRr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464B0MjU007099;
	Thu, 4 Jul 2024 09:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Yo8Uj
	pNjs6NcB0j4+DVHNcYtkWKgjlvri391ntuAG/A=; b=MnVHotRrIqLY5WOA9ncC5
	2TH0XHxnd/q+2ck3qjbyzrDbvLAS9FvLBIbYPC7c8/ogpK+gxRmhkmaeML4N8BZu
	4Jy/2CbBfVZyvwZv7Y9vwZiRntFg/Rs3JGcJyjlfx4WmTiX2MAmeWoL7/X5QGNAn
	HFtKXXNfVYsuTMKO09XUZw+yNFsopAksRNksu909qPwxMZ0HJHj9Bxcv/827P62j
	xrHwOcV9HWQhgl491UTNIOA53/3lcrWiWyRXgw1o/V8kDQyIH0ZjCCXOfZU16xlf
	NF70znRNgO/ozOWEIoLCR3u0I+TUmdZkmUfELNQ2514PVH/7wr79fA8YTsNxsjwM
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 405n2p1jyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 09:45:37 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 464Dja5V000916
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 09:45:36 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 09:45:35 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 09:45:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Jul 2024 09:45:35 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 464DjPu3032622;
	Thu, 4 Jul 2024 09:45:32 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Jul 2024 15:49:15 +0200
Subject: [PATCH 4/4] spi: xcomm: fix coding style
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240704-dev-spi-xcomm-gpiochip-v1-4-653db6fbef36@analog.com>
References: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
In-Reply-To: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
To: <linux-spi@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720100959; l=3486;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ZXi1XBghFTCRJBmNlnEz0KpOTovl8UOXAZFaQB9NdyQ=;
 b=RIU2nUSOHwVpQuFcja1H3l8dgcymLcrB8yLTT4jpNL5lHI9jDXZ5V+R/illb9FPq+05Y8yKMn
 iAvlIfAGSikBv/7v5DO+XVr5fBpgNVx5VysW8g4WQ2qzSyq9+i1APun
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ypXkZGGLM67e_NtSg8MBDHrPXzkBmWut
X-Proofpoint-GUID: ypXkZGGLM67e_NtSg8MBDHrPXzkBmWut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_10,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=826 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040098

Just cosmetics. No functional change intended.

While at it, removed a couple of redundant else if() statements.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/spi/spi-xcomm.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 136d81fb5f56..9052bddedd10 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -37,12 +37,12 @@ struct spi_xcomm {
 	struct gpio_chip gc;
 	int gpio_val;
 
-	uint16_t settings;
-	uint16_t chipselect;
+	u16 settings;
+	u16 chipselect;
 
 	unsigned int current_speed;
 
-	uint8_t buf[63];
+	u8 buf[63];
 };
 
 static void spi_xcomm_gpio_set_value(struct gpio_chip *chip,
@@ -95,8 +95,8 @@ static int spi_xcomm_gpio_add(struct spi_xcomm *spi_xcomm)
 
 static int spi_xcomm_sync_config(struct spi_xcomm *spi_xcomm, unsigned int len)
 {
-	uint16_t settings;
-	uint8_t *buf = spi_xcomm->buf;
+	u16 settings;
+	u8 *buf = spi_xcomm->buf;
 
 	settings = spi_xcomm->settings;
 	settings |= len << SPI_XCOMM_SETTINGS_LEN_OFFSET;
@@ -109,10 +109,10 @@ static int spi_xcomm_sync_config(struct spi_xcomm *spi_xcomm, unsigned int len)
 }
 
 static void spi_xcomm_chipselect(struct spi_xcomm *spi_xcomm,
-	struct spi_device *spi, int is_active)
+				 struct spi_device *spi, int is_active)
 {
 	unsigned long cs = spi_get_chipselect(spi, 0);
-	uint16_t chipselect = spi_xcomm->chipselect;
+	u16 chipselect = spi_xcomm->chipselect;
 
 	if (is_active)
 		chipselect |= BIT(cs);
@@ -123,7 +123,8 @@ static void spi_xcomm_chipselect(struct spi_xcomm *spi_xcomm,
 }
 
 static int spi_xcomm_setup_transfer(struct spi_xcomm *spi_xcomm,
-	struct spi_device *spi, struct spi_transfer *t, unsigned int *settings)
+				    struct spi_device *spi, struct spi_transfer *t,
+				    unsigned int *settings)
 {
 	if (t->len > 62)
 		return -EINVAL;
@@ -161,7 +162,7 @@ static int spi_xcomm_setup_transfer(struct spi_xcomm *spi_xcomm,
 }
 
 static int spi_xcomm_txrx_bufs(struct spi_xcomm *spi_xcomm,
-	struct spi_device *spi, struct spi_transfer *t)
+			       struct spi_device *spi, struct spi_transfer *t)
 {
 	int ret;
 
@@ -172,13 +173,13 @@ static int spi_xcomm_txrx_bufs(struct spi_xcomm *spi_xcomm,
 		ret = i2c_master_send(spi_xcomm->i2c, spi_xcomm->buf, t->len + 1);
 		if (ret < 0)
 			return ret;
-		else if (ret != t->len + 1)
+		if (ret != t->len + 1)
 			return -EIO;
 	} else if (t->rx_buf) {
 		ret = i2c_master_recv(spi_xcomm->i2c, t->rx_buf, t->len);
 		if (ret < 0)
 			return ret;
-		else if (ret != t->len)
+		if (ret != t->len)
 			return -EIO;
 	}
 
@@ -186,12 +187,12 @@ static int spi_xcomm_txrx_bufs(struct spi_xcomm *spi_xcomm,
 }
 
 static int spi_xcomm_transfer_one(struct spi_controller *host,
-	struct spi_message *msg)
+				  struct spi_message *msg)
 {
 	struct spi_xcomm *spi_xcomm = spi_controller_get_devdata(host);
 	unsigned int settings = spi_xcomm->settings;
 	struct spi_device *spi = msg->spi;
-	unsigned cs_change = 0;
+	unsigned int cs_change = 0;
 	struct spi_transfer *t;
 	bool is_first = true;
 	int status = 0;
@@ -200,7 +201,6 @@ static int spi_xcomm_transfer_one(struct spi_controller *host,
 	spi_xcomm_chipselect(spi_xcomm, spi, true);
 
 	list_for_each_entry(t, &msg->transfers, transfer_list) {
-
 		if (!t->tx_buf && !t->rx_buf && t->len) {
 			status = -EINVAL;
 			break;

-- 
2.45.2


