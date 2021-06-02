Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559333985A9
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jun 2021 11:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhFBJwB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Jun 2021 05:52:01 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:41183 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231140AbhFBJv7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Jun 2021 05:51:59 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1529nCrT004370;
        Wed, 2 Jun 2021 11:49:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=EWRidho0dnsJM1LKzQGAhZ8GVYTIGNPTjg8OhRES9Og=;
 b=aQULshdvaG7MYq/d5lr5El5lk8iXogePW9WADjwm5glQgx90j8NTufRnreS+EK2hZOXW
 ZxKGiBEdZnSx9bOQtT1IBPDzs5IWxboF3GyAR0oNqU+uHPoW7bVPL9QAPZvARpVBoZqG
 FJjeRCS86ha/b5h+2XaYhEXEz48uRwyqax8x8TMJen3WcyOE3e3Izt1Sf08yQTNoGNq/
 TbQpk/0buLkvMmOb/uoygw2Y2lMUjivtge30Bblgpo9OJEVLuq+FFazPBgwHPyH5lJMf
 nneYoj7cAZj89bgmBYJqGDUyuwmeVWFjImyu6WPmWh3PTZFZHcIxAh+djlmCgSyvy3Ub CQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38x3gxmkpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 11:49:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE8B810002A;
        Wed,  2 Jun 2021 11:49:54 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 92491216ED7;
        Wed,  2 Jun 2021 11:49:54 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Jun 2021 11:49:53
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
Subject: [PATCH v5 0/3]  mtd: spinand: add SPI-NAND MTD resume handler
Date:   Wed, 2 Jun 2021 11:49:10 +0200
Message-ID: <20210602094913.26472-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_05:2021-06-02,2021-06-02 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Changes in v5:
  - spinand_init_cfg_cache() only allocates spinand->cfg_cache array,
    spinand_read_cfg() is called directly in spinand_init().

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
  mtd: spinand: add spinand_read_cfg() helper
  mtd: spinand: Add spinand_init_flash() helper
  mtd: spinand: add SPI-NAND MTD resume handler

 drivers/mtd/nand/spi/core.c | 112 +++++++++++++++++++++++++-----------
 1 file changed, 78 insertions(+), 34 deletions(-)

-- 
2.17.1

