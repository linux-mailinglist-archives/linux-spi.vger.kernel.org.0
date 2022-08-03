Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F4588E5F
	for <lists+linux-spi@lfdr.de>; Wed,  3 Aug 2022 16:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbiHCORc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Aug 2022 10:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiHCORb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Aug 2022 10:17:31 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A23B1EC;
        Wed,  3 Aug 2022 07:17:30 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27395eJD006755;
        Wed, 3 Aug 2022 16:17:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=iEqeu4ncIH4Z+wdF+tOhNk6W8VNeBleVvrQOltKk08k=;
 b=nrLcWJDQZEGzhrgy60+HpUFDYZlW5345Aa74+HMTQs/SNa/DGtFL6A9u/XI3kJDf9Gn5
 XuMzZNwaZzQe7JZ54rUlEC3VwQaFd7QhNpjUQMWrITtT7vgAOiAqlStBIllnUiDQLoRb
 PsrUcHapcrHFUla2bAgRNQ18vV3smS7jRpnNsOPEsmCJzhMmitSVh+kUmsnQ/W8SeKjk
 NaGXFQmm4OjGNhsW/V+k/A5hMuPdJhJWlXl0cfGi4YaMPZA/mqWfQhIFgQAhQwMIcMsu
 tui9jX3a2XzYRmYz+9LcrhFIwHxzUGNIhnaUONFdG9IenGHxAnZZOVUj7C67hbZ7EEZW IA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hmt2kmupf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 16:17:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7A17B100034;
        Wed,  3 Aug 2022 16:17:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E97992248C9;
        Wed,  3 Aug 2022 16:17:00 +0200 (CEST)
Received: from localhost (10.75.127.45) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 3 Aug
 2022 16:17:00 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH 0/3] spi: stm32-qspi: some cleanup
Date:   Wed, 3 Aug 2022 16:16:54 +0200
Message-ID: <20220803141657.301793-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

This series removes unused parameter on some functions, no functional changes.

Patrice Chotard (3):
  spi: stm32-qspi: Remove stm32_qspi_wait_poll_status() unused parameter
  spi: stm32-qspi: Remove stm32_qspi_get_mode() unused parameter
  spi: stm32-qspi: Remove unused stm32_qspi_wait_cmd() parameter

 drivers/spi/spi-stm32-qspi.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.25.1

