Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13D439B449
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 09:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFDHwU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 03:52:20 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60217 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229930AbhFDHwU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 03:52:20 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1547lKte015913;
        Fri, 4 Jun 2021 09:50:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=aOKc3+bOmiN2HPGgLoviW5WOayT0hOfjwgnF4Bhbjfw=;
 b=aL2TcYO8sO7alwCAyt8AF+Gc1smyw5DBGZrQyTC5LqoHG7RaFsINOArGL+T8UcNdWHAh
 W5DwamsTCeBdvTPDEZ5efN0NspuEK4dvg0GSqK9oIOqOyUDvfD3s+MTSklu3Hh+NPe5N
 qssG7aqsLwUZ71KJyVIwPoz+6NygZQ3x+Xl1rpETM9k9aL/1iXowviOYOuhssZnBjUNj
 dWfEmGeAnWjMlDr7NjAlCSpISauZcZJM2b4wnaUMSK81jkdbr2yoE571GwQC6oLXoMS1
 qEiZpeyZ+SPybc5TgqCM4HWvJXr1sL17BqRvRq6aFE6OMP9ZEuFZcAk9kmsolt5Ltyrs 9A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38yea1gq1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Jun 2021 09:50:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D3CB10002A;
        Fri,  4 Jun 2021 09:50:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0660B214D1B;
        Fri,  4 Jun 2021 09:50:19 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 4 Jun 2021 09:50:18
 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH] spi: stm32-qspi: Fix W=1 build warning
Date:   Fri, 4 Jun 2021 09:50:09 +0200
Message-ID: <20210604075009.25914-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_04:2021-06-04,2021-06-04 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Fix the following compilation warning using W=1 build:
arm-linux-gnueabi-ld: drivers/spi/spi-stm32-qspi.o: in function `stm32_qspi_poll_status':

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f4481fe48bf0..e71a4c514f7b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -806,6 +806,7 @@ config SPI_STM32_QSPI
 	tristate "STMicroelectronics STM32 QUAD SPI controller"
 	depends on ARCH_STM32 || COMPILE_TEST
 	depends on OF
+	depends on SPI_MEM
 	help
 	  This enables support for the Quad SPI controller in master mode.
 	  This driver does not support generic SPI. The implementation only
-- 
2.17.1

