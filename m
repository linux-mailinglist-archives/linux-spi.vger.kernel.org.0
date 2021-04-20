Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010B03653EF
	for <lists+linux-spi@lfdr.de>; Tue, 20 Apr 2021 10:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhDTIVw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Apr 2021 04:21:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53232 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230395AbhDTIVt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Apr 2021 04:21:49 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13K8GZBI003437;
        Tue, 20 Apr 2021 10:21:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=YIJWK1DioMqVNMN2mgvx7hJC/xORUjRf1dKW+3jmUkE=;
 b=Z88n7214ixOvq27HT8AqBaLYm4ezyi/TWZ1Aull1esAzb4SkdF7pe+0E19l9VD6380uy
 X7bO9ToqQIsEqVi6LaysOOR5dP+RSa5Q4h/8UiWO3f0KACL+IcUWdr48sX7ZDpJAoCfC
 /MtN18g4IHgZREDIIl6nhxbcL2muWgYImn3vTZmD39E4Eu7ng8fk23pqDFnVFnqCQzez
 PyZs+9x1q0r1Oc6QlgAcDkkZeEXHRper4k+vIefK4vWjVljKBPbIvzrfu+CBSUFKHjzX
 4XN+GrkDhTs1BF/1Pn8DOKwlpGXggVOIZ+4FzEfcRaFbl4/JQItzhtb2xzuIdA5Z1/Do lQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 381jn8tdjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 10:21:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3FD1710002A;
        Tue, 20 Apr 2021 10:21:07 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2ADFC22F7B2;
        Tue, 20 Apr 2021 10:21:07 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Apr 2021 10:21:06
 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: spi: stm32-qspi: Fix compilation warning in ARM64
Date:   Tue, 20 Apr 2021 10:21:03 +0200
Message-ID: <20210420082103.1693-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_02:2021-04-19,2021-04-20 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

This fixes warnings detected when compiling in ARM64.
Introduced by 'commit 18674dee3cd6 ("spi: stm32-qspi: Add dirmap support")'

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index e2a99f054551..02691c1603d9 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -478,7 +478,7 @@ static ssize_t stm32_qspi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 * all needed transfer information into struct spi_mem_op
 	 */
 	memcpy(&op, &desc->info.op_tmpl, sizeof(struct spi_mem_op));
-	dev_dbg(qspi->dev, "%s len = 0x%x offs = 0x%llx buf = 0x%p\n", __func__, len, offs, buf);
+	dev_dbg(qspi->dev, "%s len = 0x%lx offs = 0x%llx buf = 0x%p\n", __func__, len, offs, buf);
 
 	op.data.nbytes = len;
 	op.addr.val = desc->info.offset + offs;
-- 
2.17.1

