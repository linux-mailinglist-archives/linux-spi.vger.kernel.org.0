Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C377130E078
	for <lists+linux-spi@lfdr.de>; Wed,  3 Feb 2021 18:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBCREE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Feb 2021 12:04:04 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44503 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbhBCRDg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Feb 2021 12:03:36 -0500
X-Originating-IP: 86.210.203.150
Received: from localhost.localdomain (lfbn-tou-1-972-150.w86-210.abo.wanadoo.fr [86.210.203.150])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5D19560004;
        Wed,  3 Feb 2021 17:02:46 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     <linux-spi@vger.kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-kernel@vger.kernel.org, zhengxunli@mxic.com.tw,
        juliensu@mxic.com.tw, ycllin@mxic.com.tw,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] spi: Fix the logic around the maximum speed
Date:   Wed,  3 Feb 2021 18:02:45 +0100
Message-Id: <20210203170245.31236-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")
rationaly introduced a new condition on which the device's maximum
speed would be set to the controller's one: if the device advertizes a
higher speed than the one supported by the controller.

However, it seems that the SPI core does not enforce controllers to
always advertize a maximum speed value. Other similar conditions in
the SPI core always check that the controller->max_speed_hz was set
before doing anything else.

Not doing this check here breaks SPI controller drivers which do not
advertize a maximum speed:
- the controller maximum speed is 0
- the child device max speed is set to an apparently coeherent value
- in this case the child device maximum speed is set to 0

Either (1) all controller drivers should set max_speed_hz or (2) the
child device maximum speed should not be updated in this particular
situation. Perhaps there is a rationale for not enforcing (1), but in
any case as a fix it is safer to use solution (2).

Fixes: 9326e4f1e5dd ("spi: Limit the spi device max speed to controller's max speed")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51d7c004fbab..f59bf5094adb 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3378,8 +3378,9 @@ int spi_setup(struct spi_device *spi)
 	if (status)
 		return status;
 
-	if (!spi->max_speed_hz ||
-	    spi->max_speed_hz > spi->controller->max_speed_hz)
+	if (spi->controller->max_speed_hz &&
+	    (!spi->max_speed_hz ||
+	     spi->max_speed_hz > spi->controller->max_speed_hz))
 		spi->max_speed_hz = spi->controller->max_speed_hz;
 
 	mutex_lock(&spi->controller->io_mutex);
-- 
2.20.1

