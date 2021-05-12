Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E942537B56E
	for <lists+linux-spi@lfdr.de>; Wed, 12 May 2021 07:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhELFWK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 May 2021 01:22:10 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:33980 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229952AbhELFWK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 May 2021 01:22:10 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14C5KkTK026681;
        Wed, 12 May 2021 07:20:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=hGYOG/xhcibzUoGBQ1ZJJS1rCb/Qy1K1fuUyBHsk+us=;
 b=n13KkgbD0MhRQAk1nQhEvRggprg+QCn+pJhX1cdoBn2SYZ51Jibq0188U6WxgwT7gz5b
 4G1DKPvnBdfpkeG7BpjqKedETm5bXv5lITynhZih4olzWUZNK1tWCrHELxtGxlXZVkP+
 gYmtWqziPJ61R/vKP1xHfY1ZQVZWio1qlrEW4S/iCTXaDZP8CGnJaLvZBw0NY9PvxFix
 r/eNXQnoJMO3tC+GPzDheWPdwp0LaNzrBzeuhwl9Zm91AK8Sn/0hHND53b8WCmnbR+jf
 zFQQHm/HXXFh6kq+CyCOdqMvurghD3mo2GxkQ4QBc9VbpeqVztetivnv7i+5dhuUgqSd gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38fggpfpcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 May 2021 07:20:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E45BE10002A;
        Wed, 12 May 2021 07:20:42 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D562520A077;
        Wed, 12 May 2021 07:20:42 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 12 May 2021 07:20:42
 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH] MAINTAINERS: Add Alain Volmat as STM32 SPI maintainer
Date:   Wed, 12 May 2021 07:20:42 +0200
Message-ID: <1620796842-23546-1-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_01:2021-05-11,2021-05-12 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add Alain Volmat as STM32 SPI maintainer.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index de412b9813eb..3d98375ea6f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16981,6 +16981,12 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-stm32*
 
+ST STM32 SPI DRIVER
+M:	Alain Volmat <alain.volmat@foss.st.com>
+L:	linux-spi@vger.kernel.org
+S:	Maintained
+F:	drivers/spi/spi-stm32.c
+
 ST VL53L0X ToF RANGER(I2C) IIO DRIVER
 M:	Song Qiang <songqiang1304521@gmail.com>
 L:	linux-iio@vger.kernel.org
-- 
2.7.4

