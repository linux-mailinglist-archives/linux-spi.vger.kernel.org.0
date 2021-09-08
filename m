Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139A24038D4
	for <lists+linux-spi@lfdr.de>; Wed,  8 Sep 2021 13:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349268AbhIHLgL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Sep 2021 07:36:11 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:28200 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348491AbhIHLgG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Sep 2021 07:36:06 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18858Mnt005982;
        Wed, 8 Sep 2021 06:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=hAPStDx+PJM+iDHQ4tV70Q4L3FaC3LMzBL7dtf4/SIs=;
 b=ovLUmX4R7VT0yFHCglYU3YAbNr176DnQ/s2fPmvxkaWpvuwGS3SLLmm66+1LOR34wc0Y
 CI035HVgAkHQBcKJQ20u0dUFaYFpAQQ/twBaISQxUWDM5W+Zt6KYQJOWnI2V11Yz4MpM
 9EjJZiuqhyMpHUYRYbRhFS5bc0arVAtzzP7sispbOJGMj6O2683YmcWnh9NknheVCxrl
 mm/xx1Iiq3NbFc93HydugT/ajxRq1/z486hlgqFlnnMvmR9gqev/aGZomc+nu9KuvgIP
 YPG+hWZRqm3RUvQ5MpRuPjVqvrYfJ9mKAkW7LQ8PBvN4BRLPdlnYXMshgjzvGHMOJg5v JQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3axcp997pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 06:34:55 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 8 Sep
 2021 12:34:53 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Wed, 8 Sep 2021 12:34:53 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.231])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8C81DB13;
        Wed,  8 Sep 2021 11:34:53 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 00/10] Improve support for AMD SPI controllers
Date:   Wed, 8 Sep 2021 12:34:41 +0100
Message-ID: <20210908113450.788452-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EumUw9N0FWY6HpJ4y3LuNI7JT_dVk7EN
X-Proofpoint-ORIG-GUID: EumUw9N0FWY6HpJ4y3LuNI7JT_dVk7EN
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for AMDI0062 and correctly fill the FIFO buffer with
the whole message.

With a message of AMD_SPI_FIFO_SIZE bytes or less, copying all
transfers to the FIFO guarantees that the message is sent over
one CS. Because the controller has an automatic CS that is only
activated during the transmission of the FIFO.

And the controller is half-duplex in that it cannot read data
while it is sending data. But the FIFO is full-duplex, the writes
and reads must be queued and executed together, where it can only
have one write and one read per FIFO, and the writing part is
executed first. Therefore transfers can be put together in the
FIFO unless there is a write after read, which will need to be
executed in another CS.

v2 changes:
Replace flag SPI_CONTROLLER_CS_PER_TRANSFER by checking
spi_max_message_size
Add flag for controllers that can't TX after RX in the same
message
SPI controller now expects a message that always can fit in
FIFO
Add a new patch for configuring the SPI speed


Lucas Tanure (9):
  regmap: spi: Set regmap max raw r/w from max_transfer_size
  regmap: spi: Check raw_[read|write] against max message size
  spi: Add flag for no TX after a RX in the same Chip Select
  spi: amd: Refactor code to use less spi_master_get_devdata
  spi: amd: Refactor amd_spi_busy_wait
  spi: amd: Remove unneeded variable
  spi: amd: Check for idle bus before execute opcode
  spi: amd: Fill FIFO buffer with the whole message
  spi: amd: Configure the SPI speed

Nehal Bakulchandra Shah (1):
  spi: amd: Add support for latest platform

 drivers/base/regmap/regmap-spi.c |  40 ++-
 drivers/base/regmap/regmap.c     |  15 +
 drivers/spi/spi-amd.c            | 498 ++++++++++++++++++++++---------
 drivers/spi/spi.c                |  11 +
 include/linux/regmap.h           |   3 +
 include/linux/spi/spi.h          |   1 +
 6 files changed, 421 insertions(+), 147 deletions(-)

--
2.33.0

