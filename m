Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44B653B5F8
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jun 2022 11:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiFBJ0H (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jun 2022 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiFBJ0G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jun 2022 05:26:06 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F89629FE65;
        Thu,  2 Jun 2022 02:26:05 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2528Q8w4013105;
        Thu, 2 Jun 2022 11:25:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=SHt88M2ggL5jZjwoPYSJOzNExBvaXWICvOEXZ6jH6ng=;
 b=CcDnqQHZBqTyQ/6VlCym2ipLOCiQc9QM8Vzdt3XeHeeVeJNL7YGzTU6mXqPmw29Mljbj
 pp2jn3JXc3XQBtNLI16qoegGM9sb3STpMWwsY+Cpq899Rsx7pHij6kfrZQmZLQpLxkNq
 KvFQpnxQY6t/617uiZ67ZsGfjixDhLRzeTNSUcG8pImO8Ja6HLWcSXrPPc0jh7lSU32P
 xVeyzpKyOeeFoMF5CvLciFIKyAVeIMQbTLuHd7lkzuqFDLyw2WuWiAiszTxEvZRqf/Bk
 v1PW8Rf67jXJ6CBiWELDUgVw6k72WstGTvJP4tNTDi/68MaQ38CPl1uA6gdVxGvAxBYj Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gespq0dp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 11:25:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E05DF10002A;
        Thu,  2 Jun 2022 11:25:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D71D6217B6C;
        Thu,  2 Jun 2022 11:25:54 +0200 (CEST)
Received: from localhost (10.75.127.44) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Thu, 2 Jun
 2022 11:25:54 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH v2 0/3]  spi: stm32-qspi: Remove unused parameters
Date:   Thu, 2 Jun 2022 11:25:37 +0200
Message-ID: <20220602092540.369604-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_01,2022-06-01_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

This series cleans up spi-stm32-qspi driver by removing unused parameters

Changes since v1: 
  _ add missing patch which removes unused param for stm32_qspi_wait_poll_status()

Patrice Chotard (3):
  spi: stm32-qspi: Remove stm32_qspi_get_mode() unused parameter
  spi: stm32-qspi: Remove stm32_qspi_wait_cmd() unused parameter
  spi: stm32-qspi: Remove stm32_qspi_wait_poll_status() unused parameter

 drivers/spi/spi-stm32-qspi.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.25.1

