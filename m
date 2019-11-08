Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26939F4528
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 11:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfKHK70 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 05:59:26 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60159 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfKHK70 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 05:59:26 -0500
X-Originating-IP: 86.206.246.123
Received: from localhost.localdomain (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B4E54E000F;
        Fri,  8 Nov 2019 10:59:23 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/7] spi: zynq-qspi: Clarify and fix the chip selection
Date:   Fri,  8 Nov 2019 11:59:13 +0100
Message-Id: <20191108105920.19014-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

While working on SPI-NOR support I figured the chip select handling of
the Zynq 7000 QSPI driver was not behaving as I would have
expected. While cheking out what was wrong I decided to clarify things
around so I did a bit of cleaning. The step-by-step changes are the
reason for patches [1-6]. This way, the last patch actually adding
support for both CS is much more understandable.

Thanks,
Miquèl

Miquel Raynal (7):
  spi: zynq-qspi: Anything else than CS0 is not supported yet
  spi: zynq-qspi: Keep the naming consistent across the driver
  spi: zynq-qspi: Keep the bitfields naming consistent
  spi: zynq-qspi: Enhance the Linear CFG bit definitions
  spi: zynq-qspi: Clarify the select chip function
  spi: zynq-qspi: Do the actual hardware initialization later in the
    probe
  spi: zynq-qspi: Support two chip selects

 drivers/spi/spi-zynq-qspi.c | 84 ++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 33 deletions(-)

-- 
2.20.1

