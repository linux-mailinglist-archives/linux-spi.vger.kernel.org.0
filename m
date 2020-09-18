Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFF226FAD2
	for <lists+linux-spi@lfdr.de>; Fri, 18 Sep 2020 12:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRKou (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Sep 2020 06:44:50 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:61561 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRKot (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Sep 2020 06:44:49 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 06:44:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600425889; x=1631961889;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lv1Uf+KewW1EdMQULyYswh+4Oy+tZ2EfBVG012SKQpQ=;
  b=hkp9lj9s+7+jzQ+qshTyuKe5Jdaw6L7qysN+FbIEEBY5xM/Nkv6GrNG3
   DHhL09eggGYp+PKOO2Hk2Mu8mzmVcSL2jR+o+xaxkoW99FBOd7ICL06kM
   NmcPq+EJLew/gewHAng6MDrC9g0VFp6RZiav3rA1loymNJ/GmAEGgtfTO
   nXNbkwdorg3e6soNUHLvmYZCaVrMMqN16pCZmg4r3IXdl78EN5SPCaYiu
   S1imK6PHR/3c2HNjb1N3n6gJB4Gv3xa8DWr2uEDXqhxdMK6C7zf/MGCcC
   v2cuVsZFIVm9nTgy52zQ2IaI3aoi1+qf6Pi6k/BpTqrcVOG6M9oM6DHdp
   w==;
IronPort-SDR: i+rA8XBSgSzjokFEmi7mEACBYvBvySklv9PyHh4t+z8DaY38tH55yKtpu61niYIGfDUxV9ZMES
 iySzgprP7qMw8D/AcAybC+zk9IUQ8L0w+CHLIWxw9vO1sLkk6QnUNMPYQQrGcDQXXkguWIT/mi
 Qpv/ANUryoXe2nyMOZWsoVdcDW5AlcwJFFsigxYaE5ProYtd2XewEwQ9ILSkzTnpyFmK45TSbg
 UXbCHX9mM4aGIT38avPmGKPmsOeHgLJEJ9JCLUHHqTIp/pAtqrfYtVyihITDVhba3fUY7KSAda
 fCw=
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="26881706"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Sep 2020 03:37:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 18 Sep 2020 03:37:38 -0700
Received: from HNO-LT-M43677A.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 18 Sep 2020 03:37:38 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <linux-spi@vger.kernel.org>
CC:     <thomas.kopp@microchip.com>, <tudor.ambarus@microchip.com>
Subject: [PATCH] spi: atmel: Exposing effective spi speed
Date:   Fri, 18 Sep 2020 12:37:37 +0200
Message-ID: <20200918103737.400-1-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch implements the reporting of the effectively used speed_hz for the
transfer by setting xfer->effective_speed_hz.

See the following patch, which adds this feature to the SPI core for more
information:

    5d7e2b5ed585 spi: core: allow reporting the effectivly used speed_hz for a transfer

Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
---
 drivers/spi/spi-atmel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 2cfe6253a784..86857c8408b1 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -859,6 +859,7 @@ static int atmel_spi_set_xfer_speed(struct atmel_spi *as,
 	csr = spi_readl(as, CSR0 + 4 * chip_select);
 	csr = SPI_BFINS(SCBR, scbr, csr);
 	spi_writel(as, CSR0 + 4 * chip_select, csr);
+	xfer->effective_speed_hz = bus_hz/scbr;
 
 	return 0;
 }
-- 
2.25.1

