Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC01DAFBC
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2019 16:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394863AbfJQOUX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Oct 2019 10:20:23 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:46183 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389074AbfJQOUX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Oct 2019 10:20:23 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 533E220005;
        Thu, 17 Oct 2019 14:20:20 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 0/7] atmel-spi: Allow using more than 4 GPIOs as CS
Date:   Thu, 17 Oct 2019 16:18:39 +0200
Message-Id: <20191017141846.7523-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

the main purpose of this series is allowing to use more than 4 GPIOs
as CS. But while doing it, I also clean-up the code and the comments
to match the actual support of the hardware.

Thanks to this series, it is now more clear to see what can be done
with CS GPIO and native CS. It is also possible to mix native and GPIO
CS as expected by the SPI binding.

In the end even managment of the specific use case for CS0 on
AT91RM9200 has been simplified.

Gregory

Gregory CLEMENT (7):
  spi: atmel: Remove and fix erroneous comments
  spi: atmel: Fix CS high support
  spi: atmel: Configure GPIO per CS instead of by controller
  spi: atmel: Remove useless private field
  spi: atmel: Remove platform data support
  spi: atmel: Improve and fix GPIO CS usage
  spi: atmel: Improve CS0 case support on AT91RM9200

 drivers/spi/Kconfig     |   1 +
 drivers/spi/spi-atmel.c | 154 ++++++++++++++++++++++++----------------
 2 files changed, 92 insertions(+), 63 deletions(-)

-- 
2.23.0

