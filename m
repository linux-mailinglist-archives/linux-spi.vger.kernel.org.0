Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC9929A890
	for <lists+linux-spi@lfdr.de>; Tue, 27 Oct 2020 11:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896570AbgJ0J63 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Oct 2020 05:58:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46763 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896556AbgJ0J5c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Oct 2020 05:57:32 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kXLjK-0004UK-D8; Tue, 27 Oct 2020 10:57:26 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kXLjJ-0004rp-Ow; Tue, 27 Oct 2020 10:57:25 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: [PATCH v2 0/2] SPI/ Input: ads7846: properly handle spi->mode flags
Date:   Tue, 27 Oct 2020 10:57:22 +0100
Message-Id: <20201027095724.18654-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

changes v2:
- add SPI_MODE_X_MASK macro
- ads7846: clear SPI_MODE_X_MASK bits to set driver specific mode.

Oleksij Rempel (2):
  spi: introduce SPI_MODE_X_MASK macro
  Input: ads7846: do not overwrite spi->mode flags set by spi framework

 drivers/input/touchscreen/ads7846.c | 3 ++-
 include/linux/spi/spi.h             | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.28.0

