Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B938623EE16
	for <lists+linux-spi@lfdr.de>; Fri,  7 Aug 2020 15:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgHGNXx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Aug 2020 09:23:53 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:51547 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbgHGNXq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Aug 2020 09:23:46 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077DNYS8017470;
        Fri, 7 Aug 2020 15:23:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=8KY3DUWhOx3j5psTHwxct4R3LIN5BrLRCFHnkI+96So=;
 b=Id8fuN7oOhRfvfrLc0nnjckuI+n++DmOsg3s+p5GwEvy4qnYafEgo5G20K+Hve/q4AT8
 C2t14JjxbvdY/QC2FK9EswsiPnmlJOLmLPpuEjJAtggYgxW+jpu49oU21wyT22Inzxi6
 YjZ7zVix378jjpUIa5uAGc+9tAqbPAwc3T6VIgmY4YHB8U0M0Cevqe/EGyIpHtKwrcOK
 b/MsY9vhOKMQFfyx/tNZoh86qU1MDyLgB9fh3dnnPuAyLoavD5ZDw3I93SYzl+Yf932G
 3GZ5QJuU3aCOl4izRAr8FtXwFwvDYTZI8KMLTUj+xh9RkFVExPUE8UxKGA4FQ8P3TB10 Lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6thsxsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 15:23:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E90FE10002A;
        Fri,  7 Aug 2020 15:23:30 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF8C12B8A02;
        Fri,  7 Aug 2020 15:23:30 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Aug 2020 15:23:30
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 3/5] spi: stm32: fix stm32_spi_prepare_mbr in case of odd clk_rate
Date:   Fri, 7 Aug 2020 15:21:23 +0200
Message-ID: <1596806485-3810-4-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596806485-3810-1-git-send-email-alain.volmat@st.com>
References: <1596806485-3810-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_09:2020-08-06,2020-08-07 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

Fix spi->clk_rate when it is odd to the nearest lowest even value because
minimum SPI divider is 2.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 005bc16bdf2a..bdd4e70c3f10 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -441,7 +441,8 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz,
 {
 	u32 div, mbrdiv;
 
-	div = DIV_ROUND_UP(spi->clk_rate, speed_hz);
+	/* Ensure spi->clk_rate is even */
+	div = DIV_ROUND_UP(spi->clk_rate & ~0x1, speed_hz);
 
 	/*
 	 * SPI framework set xfer->speed_hz to master->max_speed_hz if
-- 
2.7.4

