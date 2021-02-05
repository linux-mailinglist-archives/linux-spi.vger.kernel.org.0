Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37EF310A0B
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 12:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhBELP5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 06:15:57 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40841 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232021AbhBELKh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 06:10:37 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115ApxOY025610;
        Fri, 5 Feb 2021 12:09:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=YeuxeCKivkO4bocM+bAAWh+MLssKuYcIKxZRPYP51Pc=;
 b=D1ABM/7ZaDtBB5YphD51ZytOi+x98oEaMOSsu/TVw3A6dnunWyNxzRbXelAZ9CSx6e2/
 As+hwLf3r5JFUGmt1MYOoPPy9A65JGTQMILveQENnFe7IueqWtnZl5GZmsaSceuTKqxM
 WdDaXY7URtboPnuW3bckr+1Et6csdhee7cx2JR7Q8x7Vvj7RmE8OkgscTyQb3NIXxsws
 Z1Pq6XQZ9+n2GcYpVH92q0lF0myvU7R3HUrhg/tCzJxjc8xprcoPIhRpTWn+LzcoVJHh
 kAO8jriuOskn8pKV1NXdHDUOpEfnEHmPhPRE/VJrCSlmPmg3uOyS23hltlqPcvXBQbCc LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36d0fse9j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 12:09:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1618D10002A;
        Fri,  5 Feb 2021 12:09:44 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 04CA8229F3C;
        Fri,  5 Feb 2021 12:09:44 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb 2021 12:09:43
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH 0/8] spi: stm32: fix and enhancements for spi-stm32
Date:   Fri, 5 Feb 2021 12:08:54 +0100
Message-ID: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_06:2021-02-05,2021-02-05 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The serie provides a fix for the spi-stm32 driver, allowing to properly
handle 0 byte transfer (and thus being able to run spi-loopback-test).

In addition to that, important enhancements are implemented, among them,
supporting transfer larger that what the IP can setup in one go or
allowing to use the SPI bus without cs_gpio.

Alain Volmat (5):
  spi: stm32: properly handle 0 byte transfer
  spi: stm32: do not mandate cs_gpio
  spi: stm32h7: ensure message are smaller than max size
  spi: stm32: defer probe for reset
  spi: stm32: make spurious and overrun interrupts visible

Amelie Delaunay (2):
  spi: stm32: use bitfield macros
  spi: stm32h7: replace private SPI_1HZ_NS with NSEC_PER_SEC

Etienne Carriere (1):
  spi: stm32: driver uses reset controller only at init

 drivers/spi/spi-stm32.c | 116 +++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 62 deletions(-)

-- 
2.17.1

