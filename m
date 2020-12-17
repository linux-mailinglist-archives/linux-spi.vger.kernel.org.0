Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333852DD5BE
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 18:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgLQRLF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 12:11:05 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:18828 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727414AbgLQRLD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 12:11:03 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHH5CiE006823;
        Thu, 17 Dec 2020 09:10:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=yMk51/eP8OFsWViCkJdTxGHWYRtp98tEFhXQovuj0GU=;
 b=YpI9WgvUmepj/o2TJf5GQMdVGuZl3JKKTbte8Ie9uQZojK+Oe63eK5nPT8ShwMsQtVyf
 VZFPsowDylQBdeunp7RQrkqGfGS6GlGOcCVV1O1P57Zu25SgKY0IDPQ7CJaOd2yRiDiW
 492J8tAfiN/aUcLVuOwDxBqnl22+IORrToby9O/1cb9in4JFvP7DrQMQo6WN33H2JMvy
 p2Gxo0h8B5B1nremBgJ0EQEuyxVXNRZhH2foDenyxi6H6uVtYUPZuZb1/hA3A3Xzh/MC
 ERZG0fVHHBEYRc+HbTZC4xSD4f/14eFcxIk5omLSasi2wXhQov/bJbKU00sSh1wMfsQl xg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8tgb3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 09:10:20 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 09:10:19 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 09:10:19 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id D98323F7040;
        Thu, 17 Dec 2020 09:10:16 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-spi@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <bpeled@marvell.com>, <stefanc@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v2 1/2] spi: orion: enable clocks before spi_setup
Date:   Thu, 17 Dec 2020 19:09:31 +0200
Message-ID: <20201217170933.10717-2-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217170933.10717-1-kostap@marvell.com>
References: <20201217170933.10717-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_11:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>

The spi-orion driver disables its clocks whenever it is not used.
In usual case during boot (i.e. using SPI flash) it is not a problem,
as the child device driver is present and probed along with
spi_register_master() execution.

However in case the child device driver is not ready
(e.g. when its type is module_spi_driver) the spi_setup() callback
can be called after the spi-orion probe. It may happen,
that as a result there will be an attempt to access controller's
registers with the clocks disabled.

Prevent such situations and make sure the clocks are on,
each time the spi_setup() is called.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 drivers/spi/spi-orion.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index b57b8b3cc26e..3bfda4225d45 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -507,6 +507,16 @@ static int orion_spi_transfer_one(struct spi_master *master,
 
 static int orion_spi_setup(struct spi_device *spi)
 {
+	struct orion_spi *orion_spi = spi_master_get_devdata(spi->master);
+
+	/*
+	 * Make sure the clocks are enabled before
+	 * configuring the SPI controller.
+	 */
+	clk_prepare_enable(orion_spi->clk);
+	if (!IS_ERR(orion_spi->axi_clk))
+		clk_prepare_enable(orion_spi->axi_clk);
+
 	return orion_spi_setup_transfer(spi, NULL);
 }
 
-- 
2.17.1

