Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF8E39336B
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237281AbhE0QP4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 May 2021 12:15:56 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29456 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237218AbhE0QPA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 May 2021 12:15:00 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14RGD6cs000887;
        Thu, 27 May 2021 18:13:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=LCxObs1JJa3ITzuaD/aVq/zLo/TMl80lt7ojHZ3IzB4=;
 b=xmZmy1rFGwT1ZdtLjqXrzY17MuN3xjjX0VY1FItCFhTxWQN+8bu0Fy4tPuJyQiHkeUJG
 Vv2i8sizcXh2T2wfSnvakFpYznm48Et6S87Z90r1SBTo0jo7xIdh0sVJNXEfN7Q0YLf3
 +2BC0fKrFVRBhbgLfXGMaAIYqxpEm9pKrD8WYu5Mq19G7xAAzHZE0KQt9OXALQKW4nhc
 MpQpEYy6eiv2JEUYwhje9e5p889SzjAtLCCgDky4j3/GHHMO9yqUmBkAWvTMyiIBLxXs
 xUxZUuMh/W8epTMcsHUzZzKEDVeLUJtBO4XUcQ43YPuNf+DXMgsVEF/4oZMfnZch8q6Z zQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38t7k3av0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 May 2021 18:13:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1A73B10002A;
        Thu, 27 May 2021 18:13:03 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F1C29236565;
        Thu, 27 May 2021 18:13:02 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May 2021 18:13:02
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
Subject: [PATCH v3 0/3] mtd: spinand: add SPI-NAND MTD resume handler
Date:   Thu, 27 May 2021 18:12:49 +0200
Message-ID: <20210527161252.16620-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-27_09:2021-05-27,2021-05-27 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Changes in v3:
  - Add spinand_read_cfg() helper 
  - Add spinand_read_cfg() call to repopulate cache during resume
  - Split v2 patch in 3 patches

Changes in v2:
  - Add helper spinand_block_unlock().
  - Add spinand_ecc_enable() call.
  - Remove some dev_err().
  - Fix commit's title and message.

Patrice Chotard (3):
  mtd: spinand: Add spinand_block_unlock() helper
  mtd: spinand: add spinand_read_cfg() helper
  mtd: spinand: add SPI-NAND MTD resume handler

 drivers/mtd/nand/spi/core.c | 90 +++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 19 deletions(-)

-- 
2.17.1

