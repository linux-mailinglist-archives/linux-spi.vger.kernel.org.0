Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5776F4DC0
	for <lists+linux-spi@lfdr.de>; Fri,  8 Nov 2019 15:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfKHOHt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Nov 2019 09:07:49 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54787 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfKHOHt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Nov 2019 09:07:49 -0500
X-Originating-IP: 86.206.246.123
Received: from localhost.localdomain (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 746E820005;
        Fri,  8 Nov 2019 14:07:46 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/7] spi: zynq-qspi: Clarify and fix the chip selection
Date:   Fri,  8 Nov 2019 15:07:37 +0100
Message-Id: <20191108140744.1734-1-miquel.raynal@bootlin.com>
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

Changes since v1:
* Rebased on top of v5.4-rc6 and fixed all the conflicts
  (minors). Compile tested only (actual testing done on a v5.1).

Miquel Raynal (7):
  spi: zynq-qspi: Anything else than CS0 is not supported yet
  spi: zynq-qspi: Keep the naming consistent across the driver
  spi: zynq-qspi: Keep the bitfields naming consistent
  spi: zynq-qspi: Enhance the Linear CFG bit definitions
  spi: zynq-qspi: Clarify the select chip function
  spi: zynq-qspi: Do the actual hardware initialization later in the
    probe
  spi: zynq-qspi: Support two chip selects

 drivers/spi/spi-zynq-qspi.c | 83 ++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 33 deletions(-)

-- 
2.20.1

