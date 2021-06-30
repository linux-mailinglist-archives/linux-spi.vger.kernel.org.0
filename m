Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D7D3B7F52
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 10:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhF3IuQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 04:50:16 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:52508 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233340AbhF3IuQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Jun 2021 04:50:16 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U8gUoB025184;
        Wed, 30 Jun 2021 10:47:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=bL8xKnLTQr4Dm3mlBr9VNEz3wY9YCWdGlOgjJUGqZ4U=;
 b=W6aU4Q8eiczWLr7aNgE8s7mfttpcHXCVzln0aw57jsA4mX4+bW2BdjnInbp3kF57rEgn
 feyspFSPcI9v3ZM8F1lpFVZ4XL12GqQ9SjaLFXujRg3sfGAn6paRUaAMwVFEJx/ukraM
 qj64DL3J/Wil+idzW9+kuq/2IUDkkXJ+7zMO/dktIWZhbWIxmK7o16LpZzrQMTSqVRAu
 xLcEH+zmClOEr9Gz3P/gLJ17BMVighJENYAIDxpZqss8nDAITvHaAAjS+WFqXX7HQpJN
 WWhjbfSRXeIusa0VhIX/ZFNfZ7C78N5tOvWuir+4JvVHQPSNPI46D+/JP9gXsSQNa26h Lw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39g4kpw8dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 10:47:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0ABCA10002A;
        Wed, 30 Jun 2021 10:47:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EFBAA21BF5F;
        Wed, 30 Jun 2021 10:47:33 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Jun 2021 10:47:33
 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH 0/6] spi: stm32: various fixes & cleanup
Date:   Wed, 30 Jun 2021 10:45:17 +0200
Message-ID: <1625042723-661-1-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_02:2021-06-29,2021-06-30 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series contains fixes & cleanup mainly regarding fifo
and the way end of transfer triggered, when used with or
without DMA.
An additional patch cleans up the pm_runtime calls.

Alain Volmat (5):
  spi: stm32: fixes pm_runtime calls in probe/remove
  spi: stm32h7: fix full duplex irq handler handling
  Revert "spi: stm32: properly handle 0 byte transfer"
  spi: stm32h7: don't wait for EOT and flush fifo on disable
  spi: stm32: finalize message either on dma callback or EOT

Amelie Delaunay (1):
  spi: stm32h7: rework rx fifo read function

 drivers/spi/spi-stm32.c | 146 +++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 85 deletions(-)

-- 
2.25.1

