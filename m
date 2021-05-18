Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BA9387D6F
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 18:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350648AbhERQ3h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 12:29:37 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53908 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1350635AbhERQ33 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 May 2021 12:29:29 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IGMtps002613;
        Tue, 18 May 2021 18:27:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=sgPrn+dv5C3RW2L9vxdmCmRAQwJu/ZKqZnIIu2yaFGY=;
 b=jJy45taJD4xgZZXDH2k84gu+xiRVFCgJrO7XynPCeGiOvbMu7tnMHRTlBfTIXAog0CLb
 EeIt3t49dwtu7HOOQ9jKUYjT4WXmgCiZm/fs3CigKyPaemdhJJ1IF4UQgVt9gB+1kQbt
 ib5gaGOxl3/MM7jaHwPmZym+ZveXhklglLZGimJLBvSLWoJAGvAgaXid81xznP1Cw6rd
 boT+YikaocEkrcAd4kh3Flqyg0TKcWNwUiIJwFX2j2Z1NEcodVP79KGhyiGZJgOkvovd
 Z4laKO8ao27ZUeLgsUrR9qC7AJe0izLY8n2t2/ujs8h1o6Pj14yZlGfgZafsG8G6whMt 3g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38mda9hctx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 18:27:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 81FED10002A;
        Tue, 18 May 2021 18:27:56 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 69E7623FE73;
        Tue, 18 May 2021 18:27:56 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 May 2021 18:27:56
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
Subject: [PATCH v5 0/3] MTD: spinand: Add spi_mem_poll_status() support 
Date:   Tue, 18 May 2021 18:27:51 +0200
Message-ID: <20210518162754.15940-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_08:2021-05-18,2021-05-18 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

This series adds support for the spi_mem_poll_status() spinand
interface.
Some QSPI controllers allows to poll automatically memory 
status during operations (erase, read or write). This allows to 
offload the CPU for this task.
STM32 QSPI is supporting this feature, driver update are also
part of this series.

Changes in v5:
  - Update spi_mem_read_status() description.
  - Update poll_status() description API by indicating that data buffer is
    filled with last status value.
  - Update timeout parameter by timeout_ms in spi_mem_poll_status() prototype.
  - Remove parenthesys arount -EINVAL in spi_mem_poll_status().
  - Add missing spi_mem_supports_op() call in stm32_qspi_poll_status().
  - Add Boris Reviewed-by for patch 1 and 2.

Changes in v4:
  - Remove init_completion() from spi_mem_probe() added in v2.
  - Add missing static for spi_mem_read_status().
  - Check if operation in spi_mem_poll_status() is a READ.
  - Update patch 2 commit message.
  - Add comment which explains how delays has been calculated.
  - Rename SPINAND_STATUS_TIMEOUT_MS to SPINAND_WAITRDY_TIMEOUT_MS.

Chnages in v3:
  - Add spi_mem_read_status() which allows to read 8 or 16 bits status.
  - Add initial_delay_us and polling_delay_us parameters to spi_mem_poll_status().
    and also to poll_status() callback.
  - Move spi_mem_supports_op() in SW-based polling case.
  - Add delay before invoquing read_poll_timeout().
  - Remove the reinit/wait_for_completion() added in v2.
  - Add initial_delay_us and polling_delay_us parameters to spinand_wait().
  - Add SPINAND_READ/WRITE/ERASE/RESET_INITIAL_DELAY_US and
    SPINAND_READ/WRITE/ERASE/RESET_POLL_DELAY_US defines.
  - Remove spi_mem_finalize_op() API added in v2.

Changes in v2:
  - Indicates the spi_mem_poll_status() timeout unit
  - Use 2-byte wide status register
  - Add spi_mem_supports_op() call in spi_mem_poll_status()
  - Add completion management in spi_mem_poll_status()
  - Add offload/non-offload case management in spi_mem_poll_status()
  - Optimize the non-offload case by using read_poll_timeout()
  - mask and match stm32_qspi_poll_status()'s parameters are 2-byte wide
  - Make usage of new spi_mem_finalize_op() API in
    stm32_qspi_wait_poll_status()

Patrice Chotard (3):
  spi: spi-mem: add automatic poll status functions
  mtd: spinand: use the spi-mem poll status APIs
  spi: stm32-qspi: add automatic poll status feature

 drivers/mtd/nand/spi/core.c  | 45 +++++++++++++------
 drivers/spi/spi-mem.c        | 86 ++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-stm32-qspi.c | 86 ++++++++++++++++++++++++++++++++----
 include/linux/mtd/spinand.h  | 22 +++++++++
 include/linux/spi/spi-mem.h  | 16 +++++++
 5 files changed, 234 insertions(+), 21 deletions(-)

-- 
2.17.1

