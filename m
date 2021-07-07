Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99E33BE460
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhGGIag (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 04:30:36 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:56195 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230479AbhGGIac (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jul 2021 04:30:32 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1678ReoL008805;
        Wed, 7 Jul 2021 10:27:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=h75kdrJyj3Q+MXZ70gouwB0/7r0m1PC67Lh++iq5zx4=;
 b=rlUKD8veoC2+bbMU+4SG/IKePI409Bn66vOgYcgzkKfMlogLqUjrVvd336cfYJI8Wp3d
 foIyuqiMRwk9tcl+w3f5qS3L6/r5WSyupDnhIp64AdA30qne7VXxQdUD8OsxVKfG3d4u
 YpWS/UvZ/mc6QRnv+nhZYiAwSg7MJ1ugfPfE+xL+HAHat/bRNFbHsWGUTSV4uJn0JWhp
 gWvPfsUzp4EM6+63U3zCabU8k6+k3SPJfooqzXzeIQufjG9tAwP/sy1t46EC3GTKPEx2
 63nttbiVgAf2NZv3CudrrxJDtRCz+o5NjShA5ejrFPeIMDIEpw1VWaQmNY8WTCbjsytD ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39muqtu2xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 10:27:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7F5D5100034;
        Wed,  7 Jul 2021 10:27:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 70F56215125;
        Wed,  7 Jul 2021 10:27:40 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Jul 2021 10:27:40
 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH v2 0/7] spi: stm32: various fixes & cleanup
Date:   Wed, 7 Jul 2021 10:26:59 +0200
Message-ID: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_05:2021-07-06,2021-07-07 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series contains fixes & cleanup mainly regarding fifo
and the way end of transfer triggered, when used with or
without DMA.
An additional patch cleans up the pm_runtime calls and another
one enables the autosuspend.

v2: - split pm_runtime fix patch into two
    - correct revert commit subject line

Alain Volmat (6):
  spi: stm32: fixes pm_runtime calls in probe/remove
  spi: stm32: enable pm_runtime autosuspend
  spi: stm32h7: fix full duplex irq handler handling
  spi: stm32: Revert "properly handle 0 byte transfer"
  spi: stm32h7: don't wait for EOT and flush fifo on disable
  spi: stm32: finalize message either on dma callback or EOT

Amelie Delaunay (1):
  spi: stm32h7: rework rx fifo read function

 drivers/spi/spi-stm32.c | 146 +++++++++++++++++-----------------------
 1 file changed, 61 insertions(+), 85 deletions(-)

-- 
2.25.1

