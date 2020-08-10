Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B1D240237
	for <lists+linux-spi@lfdr.de>; Mon, 10 Aug 2020 09:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgHJHNE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Aug 2020 03:13:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55338 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgHJHND (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Aug 2020 03:13:03 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07A7CHet019964;
        Mon, 10 Aug 2020 09:12:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=qm/UhnNoPRT6rrgGe5Cf7nTn4YU+1HJV6FfP2NxbMts=;
 b=031LNKZbZuOC7Rqtj+h9X4VhHt+2x0thwmZ1AhD3vP7liVxIkYsip6EfU6UTmmbzDqg4
 Nhi1Sgb78sohJbpjSyX4n9HLgqPv4VRzDM9vSqa3LxvAWMuuVIyd1Syypy9BQTThhRgq
 +ghlmRcEj7Ms9Sry1XvwkxuPhaBT+cJHZVi7rZWLvAqnwG05ZhdWRV1WaHA4g4CB2Rys
 /C19ydAsoET/Ok8tp+EsW0aibLIXsLVqxEUDLn/nqSvLJThWVilvAsnVTCyxummGL0QF
 Zbf4vptjO3bU2YsURKetmNANZqetltUZ5G3dEtAPWossKUx15T7Op/GanDi71UNdmMF+ Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32sma16n88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 09:12:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5BD0E100034;
        Mon, 10 Aug 2020 09:12:50 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C72C2AD9EA;
        Mon, 10 Aug 2020 09:12:50 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Aug 2020 09:12:49
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH v2 0/5] spi: stm32: various driver fixes
Date:   Mon, 10 Aug 2020 09:12:33 +0200
Message-ID: <1597043558-29668-1-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_03:2020-08-06,2020-08-10 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This serie is a reduced version of the serie
[spi: stm32: various driver enhancements] previously sent.

Alain Volmat (1):
  spi: stm32: always perform registers configuration prior to transfer

Amelie Delaunay (3):
  spi: stm32: fix fifo threshold level in case of short transfer
  spi: stm32: fix stm32_spi_prepare_mbr in case of odd clk_rate
  spi: stm32: fixes suspend/resume management

Antonio Borneo (1):
  spi: stm32h7: fix race condition at end of transfer

 drivers/spi/spi-stm32.c | 98 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 37 deletions(-)

-- 
v2: fix conditional statement within [spi: stm32: fix fifo threshold level in case of short transfer]

