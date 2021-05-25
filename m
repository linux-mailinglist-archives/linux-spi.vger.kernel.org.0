Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E0E38FD78
	for <lists+linux-spi@lfdr.de>; Tue, 25 May 2021 11:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhEYJLg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 May 2021 05:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhEYJLg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 May 2021 05:11:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A1DC061574
        for <linux-spi@vger.kernel.org>; Tue, 25 May 2021 02:10:07 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1llT4f-0000wP-DW; Tue, 25 May 2021 11:10:05 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1llT4f-0007GV-2F; Tue, 25 May 2021 11:10:05 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v1] spi: add of_device_uevent_modalias support
Date:   Tue, 25 May 2021 11:10:03 +0200
Message-Id: <20210525091003.18228-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add OF support as already done for ACPI to take driver
MODULE_DEVICE_TABLE(of, ..) into account.

For example with this change a spi nor device MODALIAS changes from:

MODALIAS=spi:spi-nor

to

MODALIAS=of:Nspi-flashT(null)Cjedec,spi-nor

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/spi/spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0cab239d8e7f..82078226c460 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -367,6 +367,10 @@ static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
 	const struct spi_device		*spi = to_spi_device(dev);
 	int rc;
 
+	rc = of_device_uevent_modalias(dev, env);
+	if (rc != -ENODEV)
+		return rc;
+
 	rc = acpi_device_uevent_modalias(dev, env);
 	if (rc != -ENODEV)
 		return rc;
-- 
2.29.2

