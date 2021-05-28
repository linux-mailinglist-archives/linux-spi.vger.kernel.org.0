Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED33943F9
	for <lists+linux-spi@lfdr.de>; Fri, 28 May 2021 16:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhE1OSi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 May 2021 10:18:38 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48866 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234663AbhE1OSh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 May 2021 10:18:37 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SE8Ko8015760;
        Fri, 28 May 2021 16:16:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=J9cCHQmx5QoploGmp8jbPHbbyQ+pCZrTHANTM4SDrNw=;
 b=pv7XMiYoyDzolZZj0g1hCwotTA61B90w94YQnffKdh8FbNyrVJTkt8AfIvw59Dw9xbsm
 6j9jIUSpAgs9s/hP9Rfnn9oGArAR5TAuNIOxkZ8N3v9wMvKCD8qF0RHNnTwfjBhPjBtx
 q2mgthZ3ABvf2vvw/LeECabJmwPp0inuhyjzudNObvTNiXQrzvP6b1EaYgYqOV8/VJNB
 vXF18sa9Tngv8OOYzP/YhcewGht7rpwlcd8Dp3Q519BVeAkcM6zk/Ri9qhPSACUcYm30
 d2ujbD/+Kbp7b5C1K7iynIN2e+zNafbDxgzuIX/t5ix2eDdqJYG7F1wRWC+G1+5VilLp KA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38ttn02ptx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 16:16:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 856EC10002A;
        Fri, 28 May 2021 16:16:51 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 717E6231DC0;
        Fri, 28 May 2021 16:16:51 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 28 May 2021 16:16:51
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
        <linux-kernel@vger.kernel.org>, Pratyush Yadav <p.yadav@ti.com>
CC:     <patrice.chotard@foss.st.com>, <christophe.kerello@foss.st.com>
Subject: [PATCH v4 0/3] mtd: spinand: add SPI-NAND MTD resume handler
Date:   Fri, 28 May 2021 16:16:36 +0200
Message-ID: <20210528141639.3194-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_05:2021-05-27,2021-05-28 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Changes in v4:
  - Add spinand_init_flash helper()
  - Remove no more needed spinand_block_unlock() helper introduced in v2	

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
  mtd: spinand: Add spinand_init_flash() helper
  mtd: spinand: add spinand_read_cfg() helper
  mtd: spinand: add SPI-NAND MTD resume handler

 drivers/mtd/nand/spi/core.c | 113 +++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 34 deletions(-)

-- 
2.17.1

