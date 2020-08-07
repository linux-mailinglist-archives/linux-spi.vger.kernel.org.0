Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A385D23EE23
	for <lists+linux-spi@lfdr.de>; Fri,  7 Aug 2020 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgHGNXp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Aug 2020 09:23:45 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60208 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725936AbgHGNXo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Aug 2020 09:23:44 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077DMvQ9021119;
        Fri, 7 Aug 2020 15:23:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=b6BXTsl2mjCqg+/gyeLA7aW/o4J+gxG3ahn6UuubIzY=;
 b=p3E5YYlzIOFmZmLNQMzd5Nj1xWH3haLk4gwkJJkYrMlxtr/AISWQfW/fslX4+Bfh4A0G
 ZlGX0YkizMgpPd8WiLxqTxceIdJJxObjlqEIRPvSW2tEDcYuyiqO9Omyvty/1GmTgd3I
 W59hdTeEPNXqBPuf8smgKXqLoQGgwzlYKQ8IaUgYYXsDYTyx4b5zWCjS3JfJ+XVOdJUX
 RZ78a4ljDql3uMwHOD/n8CyD0qnN6i8TV6KxCaHl7G4pIt5ZfOZiaW3rRikdfYdMH0mA
 lXuYO8Ld5PxueBosoOafYO2rwk+ek08657F0wf9+gncNN/BNTH7yE1uAEDhnmiI8I1KO SA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6sbhy7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 15:23:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4EA210002A;
        Fri,  7 Aug 2020 15:23:29 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 967D92B8A02;
        Fri,  7 Aug 2020 15:23:29 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Aug 2020 15:23:29
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 0/5] spi: stm32: various driver fixes
Date:   Fri, 7 Aug 2020 15:21:20 +0200
Message-ID: <1596806485-3810-1-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_09:2020-08-06,2020-08-07 signatures=0
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

 drivers/spi/spi-stm32.c | 95 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 37 deletions(-)

