Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7945DA39
	for <lists+linux-spi@lfdr.de>; Thu, 25 Nov 2021 13:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347542AbhKYMqb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Nov 2021 07:46:31 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47101 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349278AbhKYMoa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Nov 2021 07:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637844081; x=1669380081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nFoPg7O8bbCxeMi02b+LQvt1+6dJRIKjW7sCyInfeRg=;
  b=jAvuPIi0zH0nWhYyoRgE7EEGDcCTtaJ1TkFrbxO8LFJzgwlkRvxPLzVI
   3yZmt1Cq7/Kut3ObOe4jrvDOaLYC/JBRe0e9kD6uZittsKxaFS1EjohS2
   Qi420fXM64QbEv8CS9fpeaV2EoX07H7bkECJT1AkWgfazWWSApNkh4atp
   qvPXZjJ8DGCJXtO/DcMfZN+UkiVeyMhKcmwAH0M3UXjRLy3+9Rrh53aeg
   EAdqVc4MBS+nmAS6KJRpX7yCgLEadARW5OYopa9zBG+RUGw7gPgWYCwVj
   0EtTfKYQjh/hItaNpOifS80XzItU7ErHJcQvwViYHQAjW9iTZhsEvQeJp
   Q==;
IronPort-SDR: 2xkMaFsI3QFfWsNkspDY2Q289pYpyy5DG1ggMoqi4XgXMm2WUNLYjaJeJWD5wdk/j+XEcs67V9
 iHZSJsuX/yCT0d8MddiKlULo3eOtKwSpxL+kqzHYHcTNGzwoM8FwWG1eIIg81cGKs5w0zymGJt
 Lcmm/jTOQMbsS+GbKiQF99MZonsdhCj9yPeSRUHdRtzvy4uGfTScmzdjUSdS+DgOZMtwq2yU8g
 nZOX9TfcDzzqSSTcPbr2IjseXpeLELWRonI0f4ybNKNf2yDDQyhgzyMmR7Be9KuxSKHUcWWeU8
 bbIBP533iQBR3hWvlhlJn4AS
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="144550438"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2021 05:41:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 25 Nov 2021 05:41:18 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 25 Nov 2021 05:41:16 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 0/2] spi: atmel: Clean usage of DMA
Date:   Thu, 25 Nov 2021 14:41:08 +0200
Message-ID: <20211125124110.838037-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Cleaning patches done when reading DMA code. No functional change
expected. Tested on sama5d2_xplained with at25df321a.

Tudor Ambarus (2):
  spi: atmel: Drop slave_config argument in atmel_spi_dma_slave_config()
  spi: atmel: Remove setting of deprecated member of struct
    dma_slave_config

 drivers/spi/spi-atmel.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

-- 
2.25.1

