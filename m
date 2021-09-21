Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D82A413858
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 19:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhIURfM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 13:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230503AbhIURfK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 21 Sep 2021 13:35:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D0B361166;
        Tue, 21 Sep 2021 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632245621;
        bh=5ycfdpCn7W0Iv71BRyuiZNapG7fAkq46f7/a2w1a9fk=;
        h=From:To:Cc:Subject:Date:From;
        b=kbcI3H9yaiXXl8+YvF8dxh9y5mAy+8+DkOzNv/bY7DQenN/1kths6l5UFwr+XiEqG
         siykxPEsoKP62ahnVx3TFtzFUEv0MNUyNz00yJlt0EH1NcgpTfO2Oogg2HbmHrLWwg
         Bz98XgEBfbQqTLB7tWb3tEju9px/qpj5WnlSCHiAkwRYM6OEy5LNN3b7saEwCOk3nL
         Dgl23URsQSVCBs53MRFsBo3ppd8h+hg+CvcCXk8dptmttbzET6U9s8E5TowZzbCBGS
         8ZyZlkN0f05bbiuYoXlgnWT75IBYYB4osSpz66TUZaybGR9P0nUa8X/EWfLxkzrNBS
         EaJK2RG4InDdg==
From:   Mark Brown <broonie@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH] spi: Revert modalias changes
Date:   Tue, 21 Sep 2021 18:32:22 +0100
Message-Id: <20210921173222.46514-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4108; h=from:subject; bh=5ycfdpCn7W0Iv71BRyuiZNapG7fAkq46f7/a2w1a9fk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhShUOgLle0Xw0YUdYtND0SVtf24yU3vOX7amlvkqL 6E7pupuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUoVDgAKCRAk1otyXVSH0J05B/ 9YeHnIr4FNTh/b0r7JJ33jRu3k4OEZ3jPf0E8s49BMW2skSlTxKFfTq4myZLgoNN57+4eM95moPcLz ZEh+nLiU4l4MIEgzJRSadEFGzRLxpaRr5dSsx7V38qaLLNS0Cu01ncU84kJ4jPp4cRTj4AqWdDG3p6 K7qgddo9kZY2ICjKLKhjLXhoppwxHaTEnbSxawUuHqPuO3I30C5YSBl5fxdVyccHkRBAag0+AheT+3 emw2RFDJ3DQqhBCqIANjuaITWe8gSeeXdtZNj0WVurfFrP2mDoOA/9c9AxDUaXCAQyLe18883UehP8 OUqzRs/d0kVxHuBUF64DJ4sKW292ya
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

During the v5.13 cycle we updated the SPI subsystem to generate OF style
modaliases for SPI devices, replacing the old Linux style modalises we
used to generate based on spi_device_id which are the DT style name with
the vendor removed.  Unfortunately this means that we start only
reporting OF style modalises and not the old ones and there is nothing
that ensures that drivers list every possible OF compatible string in
their OF ID table.  The result is that there are systems which have been
relying on loading modules based on the old style that are now broken,
as found by Russell King with spi-nor on Macchiatobin.

spi-nor is a particularly problematic case for this, it only lists a
single generic DT compatible jedec,spi-nor in the driver but supports a
huge raft of device specific compatibles, with a large set of part
numbers many of which are offered by multiple vendors.  Russell's
searches of upstream device trees has turned up examples with vendor
names written in non-standard ways too.  To make matters worse up until
8ff16cf77ce3 ("Documentation: devicetree: m25p80: add "nor-jedec"
binding") the generic compatible was not part of the binding so there
are device trees out there written to that binding version which don't
list it all.  The sheer number of parts supported together with our
previous approach of ignoring the vendor ID makes robustly fixing this
by adding compatibles to the spi-nor driver seem problematic, the
current DT binding document does not list all the parts supported by the
driver at the minute (further patches will fix this).

I've also investigated supporting both formats of modalias
simultaneously but that doesn't seem possible, especially without
breaking our userspace ABI which is obviously not viable.

Instead revert the relevant changes for now:

e09f2ab8eecc ("spi: update modalias_show after of_device_uevent_modalias support")
3ce6c9e2617e ("spi: add of_device_uevent_modalias support")

This will unfortunately mean that any system which had started having
modules autoload based on the OF compatibles for drivers that list
things there but not in the spi_device_ids will now not have those
modules load which is itself a regression.  Since it affects a narrower
time window and the particularly problematic spi-nor driver may be
critical to system boot on smaller systems this seems the best of a
series of bad options.  I will start an audit of SPI drivers to identify
and fix cases where things won't autoload using spi_device_id, this is
not great but seems to be the best way forward that anyone has been able
to identify.

Thanks to Russell for both his report and the additional diagnostic and
analysis work he has done here, the detailed research above was his
work.

Fixes: e09f2ab8eecc ("spi: update modalias_show after of_device_uevent_modalias support")
Fixes: 3ce6c9e2617e ("spi: add of_device_uevent_modalias support")
Reported-by: Russell King (Oracle) <linux@armlinux.org.uk>
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Andreas Schwab <schwab@suse.de>
Cc: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/spi/spi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 57e2499ec1ed..aea037c65985 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -58,10 +58,6 @@ modalias_show(struct device *dev, struct device_attribute *a, char *buf)
 	const struct spi_device	*spi = to_spi_device(dev);
 	int len;
 
-	len = of_device_modalias(dev, buf, PAGE_SIZE);
-	if (len != -ENODEV)
-		return len;
-
 	len = acpi_device_modalias(dev, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
@@ -367,10 +363,6 @@ static int spi_uevent(struct device *dev, struct kobj_uevent_env *env)
 	const struct spi_device		*spi = to_spi_device(dev);
 	int rc;
 
-	rc = of_device_uevent_modalias(dev, env);
-	if (rc != -ENODEV)
-		return rc;
-
 	rc = acpi_device_uevent_modalias(dev, env);
 	if (rc != -ENODEV)
 		return rc;
-- 
2.20.1

