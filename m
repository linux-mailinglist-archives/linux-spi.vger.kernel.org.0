Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BCC42A891
	for <lists+linux-spi@lfdr.de>; Tue, 12 Oct 2021 17:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbhJLPmX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Oct 2021 11:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbhJLPmO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Oct 2021 11:42:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE176C06174E
        for <linux-spi@vger.kernel.org>; Tue, 12 Oct 2021 08:40:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsk-0000In-VL; Tue, 12 Oct 2021 17:39:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsk-0004lT-Am; Tue, 12 Oct 2021 17:39:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1maJsd-0004Yd-5J; Tue, 12 Oct 2021 17:39:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Eric Piel <eric.piel@tremplin-utc.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v2 12/20] misc: lis3lv02d: Make lis3lv02d_remove_fs() return void
Date:   Tue, 12 Oct 2021 17:39:37 +0200
Message-Id: <20211012153945.2651412-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=WWMONXS4nQyU8LWJfp5LQwiwkNadPD19C12YOs6BjVY=; m=EvLChWJEMdkgjbEsXVN6Tz2xXArpU22O6tu5BfLNtt4=; p=byHwshnJ1HXVTYPhlZe1MP3r9RDx0xvXW0YzUKY8y4U=; g=fb6c05d76d7186cee9555ca62f10f13d9cb21e0b
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFlrB0ACgkQwfwUeK3K7AntmwgAizc 4ZLndCQSQvNPnnd6VQaNAowrpYfjodoF6V9t42rOpFjQzX5hHXo9dbydNWaqFqlhstEyKY0l01G6h K5CNfCO5OMobY0irptnCsmttTjvylRCxebMLjGqDYm+jlA48WYiWhoCdIkTL4wpHj0hAenynVuAUa FcQvPSEiC1y14RMpgP7zycmcCBa8al4NO2zRsCjnIMjRfPvGHEaFFkNwSpHCioDbZsAw5s/Q+hnC+ q+LTJTHEQc9bNHi2MOQByDI1v3HGkLhTGt/uLjPfms7Qj5EKibZ0+uy7YvVxzXaUkg+gBnCAAmDTO +q4cVFlG+wOSBnV4RDJlX15UkQ3hMuw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Up to now lis3lv02d_remove_fs() returns zero unconditionally. Make it return
void instead which makes it easier to see in the callers that there is
no error to handle.

Also the return value of i2c and spi remove callbacks is ignored anyway.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/misc/lis3lv02d/lis3lv02d.c     | 3 +--
 drivers/misc/lis3lv02d/lis3lv02d.h     | 2 +-
 drivers/misc/lis3lv02d/lis3lv02d_spi.c | 4 +++-
 drivers/platform/x86/hp_accel.c        | 3 ++-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 70c5bb1e6f49..3a7808b796b1 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -878,7 +878,7 @@ static int lis3lv02d_add_fs(struct lis3lv02d *lis3)
 	return sysfs_create_group(&lis3->pdev->dev.kobj, &lis3lv02d_attribute_group);
 }
 
-int lis3lv02d_remove_fs(struct lis3lv02d *lis3)
+void lis3lv02d_remove_fs(struct lis3lv02d *lis3)
 {
 	sysfs_remove_group(&lis3->pdev->dev.kobj, &lis3lv02d_attribute_group);
 	platform_device_unregister(lis3->pdev);
@@ -894,7 +894,6 @@ int lis3lv02d_remove_fs(struct lis3lv02d *lis3)
 		pm_runtime_set_suspended(lis3->pm_dev);
 	}
 	kfree(lis3->reg_cache);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(lis3lv02d_remove_fs);
 
diff --git a/drivers/misc/lis3lv02d/lis3lv02d.h b/drivers/misc/lis3lv02d/lis3lv02d.h
index c394c0b08519..195bd2fd2eb5 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.h
+++ b/drivers/misc/lis3lv02d/lis3lv02d.h
@@ -312,7 +312,7 @@ int lis3lv02d_joystick_enable(struct lis3lv02d *lis3);
 void lis3lv02d_joystick_disable(struct lis3lv02d *lis3);
 void lis3lv02d_poweroff(struct lis3lv02d *lis3);
 int lis3lv02d_poweron(struct lis3lv02d *lis3);
-int lis3lv02d_remove_fs(struct lis3lv02d *lis3);
+void lis3lv02d_remove_fs(struct lis3lv02d *lis3);
 int lis3lv02d_init_dt(struct lis3lv02d *lis3);
 
 extern struct lis3lv02d lis3_dev;
diff --git a/drivers/misc/lis3lv02d/lis3lv02d_spi.c b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
index f664ed123730..9e40dfb60742 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_spi.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
@@ -102,7 +102,9 @@ static int lis302dl_spi_remove(struct spi_device *spi)
 	lis3lv02d_joystick_disable(lis3);
 	lis3lv02d_poweroff(lis3);
 
-	return lis3lv02d_remove_fs(&lis3_dev);
+	lis3lv02d_remove_fs(&lis3_dev);
+
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
index cc53f725c041..b183967ecfb7 100644
--- a/drivers/platform/x86/hp_accel.c
+++ b/drivers/platform/x86/hp_accel.c
@@ -349,7 +349,8 @@ static int lis3lv02d_remove(struct platform_device *device)
 	led_classdev_unregister(&hpled_led.led_classdev);
 	flush_work(&hpled_led.work);
 
-	return lis3lv02d_remove_fs(&lis3_dev);
+	lis3lv02d_remove_fs(&lis3_dev);
+	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.30.2

