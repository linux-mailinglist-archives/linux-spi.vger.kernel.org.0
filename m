Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CA73F5C3D
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 12:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhHXKlj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 06:41:39 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:63968 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235905AbhHXKlj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 06:41:39 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17O9oMhR012561;
        Tue, 24 Aug 2021 05:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=BfS160OI38z4jswnyylLQykHq99+mYt7GfNcU6u9SNc=;
 b=GVNcNH4YWI9nXgYD3oWfym+bvVxEyRgTGreb8IUz6En7wZmBzla2488n29Xbp5vP1KuC
 f/nw6twoUz7oWulds+vP6clWGUjxrQET6m0iRIvCvG24kPPnaETlqPiIrZ+LFPp2kyfw
 L3v9TUQ+4LhToScbpaoKVgRPqH2eFVXJAtj8tyoQKmHfTp4bU4BS6lI9kggCpqVKEta3
 rcKlSaQfIG+O6VhkvupILXojyZ77z9Twen5DwyHurdUvxgsnaJrMAICAgb4f1ShR6Fpq
 /SXzsqR5FfdMDmY/R700PGKwzuPZIwge/2zZE28CZcsinJsj1/2moLhSVUeC5DUZSMBO Nw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3amxg601jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Aug 2021 05:40:50 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 11:40:49 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 24 Aug 2021 11:40:49 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.58])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D5F1D2A9;
        Tue, 24 Aug 2021 10:40:42 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 0/9] Improve support for AMD SPI controllers
Date:   Tue, 24 Aug 2021 11:40:32 +0100
Message-ID: <20210824104041.708945-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Jm3Wm_Pl_qTV3Mbor8FfJxdVlwzGRpJD
X-Proofpoint-ORIG-GUID: Jm3Wm_Pl_qTV3Mbor8FfJxdVlwzGRpJD
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for AMDI0062 and overcome the fact that the
controller can't hold the chip select activated between
transfers.

AMD SPI controller starts the SPI transfer by copying a
special byte called opcode into the bus, followed by the
TX register bytes from the FIFO into the bus.
If the RX register is not zero, it will copy RX bytes
from the bus to the FIFO.

Rules:
 - It must have an opcode set, which can be the first
byte from the writing part
 - The writing part of the FIFO always goes first
 - It's not full duplex, it writes TX bytes and then
reads RX bytes into the FIFO
 - Write and Read share the same FIFO. If the transfer
needs to write N bytes, it will only be able to read
(70 - N) bytes.
 - The chip select can only be activated during that
transaction. If a second transfer rely on the address
written during a previous transfer, it needs to write
an updated address, or it will fail, as the device in
the SPI bus will not understand a read without an
address as the chip select was not held between transfers.

So, when the regmap splits a write to an address or read from
an address into 2 separated transfers inside one message the
AMD SPI driver needs to merge them back into a single one.
Also it needs to be sure that the of bytes to read|write is
a little less so the address can fit into the FIFO.

Lucas Tanure (9):
  regmap: spi: Set regmap max raw r/w from max_transfer_size
  spi: core: Add flag for controllers that can't hold cs between
    transfers
  regmap: spi: SPI_CONTROLLER_CS_PER_TRANSFER affects max read/write
  spi: amd: Refactor code to use less spi_master_get_devdata
  spi: amd: Refactor amd_spi_busy_wait to use readl_poll_timeout
  spi: amd: Remove uneeded variable
  spi: amd: Check for idle bus before execute opcode
  spi: amd: Refactor to overcome 70 bytes per CS limitation
  spi: amd: Add support for latest platform

 drivers/base/regmap/regmap-spi.c |  44 +++-
 drivers/base/regmap/regmap.c     |   9 +
 drivers/spi/spi-amd.c            | 415 ++++++++++++++++++++-----------
 include/linux/regmap.h           |   2 +
 include/linux/spi/spi.h          |   1 +
 5 files changed, 315 insertions(+), 156 deletions(-)

-- 
2.33.0

