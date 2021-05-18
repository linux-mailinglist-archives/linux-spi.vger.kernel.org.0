Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E4D38755D
	for <lists+linux-spi@lfdr.de>; Tue, 18 May 2021 11:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242931AbhERJns (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 May 2021 05:43:48 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:8064 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242571AbhERJnr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 May 2021 05:43:47 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14I9MvPl010142;
        Tue, 18 May 2021 11:42:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=NYkCFyg/J9YK0KU90WHGnXm9+RztNvxNW7BXV5KdyXw=;
 b=pjiD3jJOvymNxQYw/Edc/CTtVfMDjIcZz4m1827GZIN8N+4UEXar3/yFLhN/CKtVor8T
 +qjVpMcgaqfFvPMgLtP3lUwuRcOI+m9klihgOXZ6hD3WiUHGEd8zI7HF0wBFrl5lbwNy
 hEGYbrA3gIQ1AgMu6+r7C8TXSuY/YH9VGL8k2vifSZmcDD8wLdveGcdLnA//+sNmmMgT
 uX7bQ1GR9qDTRHCx7/IfmLd9LldYPAXZbz2DvpozKW3JvxJm/q3HsgihuZrAxsLSddmb
 569x5b9sjitsvxieJ1LVc5jRyLk6thZVOid6UUtBXrjJ+bSE0YH12xzBvtBCECC0/mft 4A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38maunr4mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 May 2021 11:42:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2228510002A;
        Tue, 18 May 2021 11:42:12 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 09E1921CA62;
        Tue, 18 May 2021 11:42:12 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 May 2021 11:42:11
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
Subject: [PATCH v3 0/3] MTD: spinand: Add spi_mem_poll_status() support 
Date:   Tue, 18 May 2021 11:39:48 +0200
Message-ID: <20210518093951.23136-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_04:2021-05-17,2021-05-18 signatures=0
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
 drivers/spi/spi-mem.c        | 85 ++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-stm32-qspi.c | 83 +++++++++++++++++++++++++++++++----
 include/linux/mtd/spinand.h  | 11 ++++-
 include/linux/spi/spi-mem.h  | 14 ++++++
 5 files changed, 216 insertions(+), 22 deletions(-)

-- 
2.17.1

