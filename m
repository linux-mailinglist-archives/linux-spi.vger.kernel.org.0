Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD3C11CEDF
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 14:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfLLN4F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Dec 2019 08:56:05 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56928 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729429AbfLLN4F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Dec 2019 08:56:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBCDti1m130359;
        Thu, 12 Dec 2019 07:55:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1576158944;
        bh=0iLDWJMQzCj3Znd8rcYL8KQNQ37u7msZ1UlTKw8z0pc=;
        h=From:To:CC:Subject:Date;
        b=AdH+nTjOUFattoYbz5vKh2MjG+4yqS1zif/iNhB21H+DZbRiO20JjhhW8xOvy3Y04
         wn+MTpkS88eSIfWD0CaxGGtvldkKfB3oAJL2hhXZdyf1cRvxBy1Nkywn/ozs+9epDi
         AkZ22nws08ke9QXgRFRV//PMXcYwY/441UCJJz9I=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBCDtiJX044250
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Dec 2019 07:55:44 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Dec 2019 07:55:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Dec 2019 07:55:43 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBCDtdqQ048444;
        Thu, 12 Dec 2019 07:55:40 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <nsaenzjulienne@suse.de>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <baohua@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <vkoul@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH 0/9] spi: Use dma_request_chan() instead dma_request_slave_channel()
Date:   Thu, 12 Dec 2019 15:55:41 +0200
Message-ID: <20191212135550.4634-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

With dma_request_chan() drivers can receive the real error code and can support
deferred probing against DMA.

The series has been compile tested only (allyesconfig).

Regards,
Peter
---
Peter Ujfalusi (9):
  spi: atmel: Use dma_request_chan() instead dma_request_slave_channel()
  spi: bcm2835: Release the DMA channel if probe fails after dma_init
  spi: bcm2835: Use dma_request_chan() instead
    dma_request_slave_channel()
  spi: img-spfi: Use dma_request_chan() instead
    dma_request_slave_channel()
  spi: mxs: Use dma_request_chan() instead dma_request_slave_channel()
  spi: sirf: Use dma_request_chan() instead dma_request_slave_channel()
  spi: spi-fsl-dspi: Use dma_request_chan() instead
    dma_request_slave_channel()
  spi: stm32-qspi: Use dma_request_chan() instead
    dma_request_slave_channel()
  spi: stm32: Use dma_request_chan() instead dma_request_slave_channel()

 drivers/spi/spi-atmel.c      | 29 ++++++++++----------------
 drivers/spi/spi-bcm2835.c    | 40 +++++++++++++++++++++++++-----------
 drivers/spi/spi-fsl-dspi.c   | 12 +++++------
 drivers/spi/spi-img-spfi.c   | 18 ++++++++++++++--
 drivers/spi/spi-mxs.c        |  6 +++---
 drivers/spi/spi-sirf.c       | 12 +++++------
 drivers/spi/spi-stm32-qspi.c | 30 +++++++++++++++++++++------
 drivers/spi/spi-stm32.c      | 32 ++++++++++++++++++++---------
 8 files changed, 116 insertions(+), 63 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

