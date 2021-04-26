Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDFF36B511
	for <lists+linux-spi@lfdr.de>; Mon, 26 Apr 2021 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhDZOkg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Apr 2021 10:40:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:24086 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233834AbhDZOke (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Apr 2021 10:40:34 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QEcHYb015831;
        Mon, 26 Apr 2021 16:39:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=Mrzdfe9ktCTQYQLDD8T2tbI9uH3nTpSKWd9+g32O7fc=;
 b=BDKfB89jXqMpRpbWK2/JaaFGTiohOwRluwHq3rBnl2EXWRxw2tYZxT3xP1k0b0gakxmO
 iRR/RLsBmoWcm+o3kMPLwHtcuhts00vDoSXt4+pzFkty+VcQ/wPo/xZpK1+oOchEmOCI
 yi3V5hFTS3j8F15a9Iup6Bw+pp9elJjLyOUGVOvJWoGPPrWdiz8/j+VUaCdLQ9NvqXhA
 du3NtTfg6l3dbhsYrA5Y2KfZE5nKdc8SiWgZBn/sKU35KJqGOZFDWSIFeYdGbyuarc5i
 LaPLcuiJHsnZGuPg6w8zWLFypj6czyXBmfl1P6yEs5TENHKXZM7VA8D5KSodAWjK7mVv 1A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 385b0xx7cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 16:39:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 698C310002A;
        Mon, 26 Apr 2021 16:39:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C4AD2178E6;
        Mon, 26 Apr 2021 16:39:38 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Apr 2021 16:39:37
 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <patrice.chotard@foss.st.com>, <christophe.kerello@foss.st.com>
Subject: [PATCH 0/3] MTD: spinand: Add spi_mem_poll_status() support
Date:   Mon, 26 Apr 2021 16:39:31 +0200
Message-ID: <20210426143934.25275-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_07:2021-04-26,2021-04-26 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

This series adds support for the spi_mem_poll_status() spinand
interface.
Some QSPI controllers allows to poll automatically memory 
status during operations (erase or write). This allows to 
offload the CPU for this task.
STM32 QSPI is supporting this feature, driver update are also
part of this series.

Christophe Kerello (3):
  spi: spi-mem: add automatic poll status functions
  mtd: spinand: use the spi-mem poll status APIs
  spi: stm32-qspi: add automatic poll status feature

 drivers/mtd/nand/spi/core.c  | 22 ++++++++--
 drivers/spi/spi-mem.c        | 34 +++++++++++++++
 drivers/spi/spi-stm32-qspi.c | 80 ++++++++++++++++++++++++++++++++----
 include/linux/mtd/spinand.h  |  1 +
 include/linux/spi/spi-mem.h  |  8 ++++
 5 files changed, 133 insertions(+), 12 deletions(-)

-- 
2.17.1

