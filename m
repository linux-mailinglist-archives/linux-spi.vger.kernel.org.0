Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4803364155
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 14:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbhDSMQa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 08:16:30 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:1354 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239028AbhDSMQ3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Apr 2021 08:16:29 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JCFEHJ009811;
        Mon, 19 Apr 2021 14:15:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=zKHnDC/t1gVZr01XZJKPAzPKhFgNwrDSSFbSp/Msn3c=;
 b=gODYIx5bRMwti3ZpTHRBbyWwr1OpnzJgr6iCiwwpX+L9r/NPOqOceNA3CObWoZQUiY/e
 eaz/j6Isvt2xBkwU7ycLBKHde7tK/0XeTuQNwMOsSBT8kMtBnqPU8URwRstpwT6Dec4b
 /QkUzLK9wPCfgptkQbqpSgD9Kldayba4GMUcJfTezI/5yZh8EMACtcpwGfba4znji707
 +oUqyZy2+EGur7jcL47p6acbebKSO8Ugcq2H+tjUymW7etrelRyS9BkZi2fmEXiELXXt
 Urus13k+Klt4DpT7kkblaW77MsnD9IK2yIbRdOuLL84MteBpSul+vdfi2znCqAZZAD3m Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 380rdgc933-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 14:15:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1900E10002A;
        Mon, 19 Apr 2021 14:15:43 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 054F82139BC;
        Mon, 19 Apr 2021 14:15:43 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr 2021 14:15:42
 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH 0/3]  spi: stm32-qspi: Fix and update
Date:   Mon, 19 Apr 2021 14:15:38 +0200
Message-ID: <20210419121541.11617-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_10:2021-04-16,2021-04-19 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Christophe Kerello (1):
  spi: stm32-qspi: fix pm_runtime usage_count counter

Patrice Chotard (2):
  spi: stm32-qspi: Trigger DMA only if more than 4 bytes to transfer
  spi: stm32-qspi: Add dirmap support

 drivers/spi/spi-stm32-qspi.c | 106 +++++++++++++++++++++++++++--------
 1 file changed, 84 insertions(+), 22 deletions(-)

-- 
2.17.1

