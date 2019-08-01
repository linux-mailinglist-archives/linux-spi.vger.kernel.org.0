Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C19C7DC4B
	for <lists+linux-spi@lfdr.de>; Thu,  1 Aug 2019 15:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbfHANLO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Aug 2019 09:11:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54986 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731683AbfHANK7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Aug 2019 09:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EqDX8e2thuVXATx0vdil8WYAE4YTgcex551s5XdQ6eo=; b=vmlePwupjBvb
        VfI3ehuL8JQjTAOCtn//7Rn5+f+A4ojEXjtapGtYwvthbixVcLfIT7fRGPopAvSp6ohBPqf8JDRJK
        iMqTAKbK4wSVThixN2qtqCk87XmmqA5BNmEwktQ8xMVN7RJrAgqHEGdqKrhJGKaCKSn4ZYNP1/lEe
        XCXTk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htArA-0004kD-Az; Thu, 01 Aug 2019 13:10:56 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id CB19E2742C48; Thu,  1 Aug 2019 14:10:55 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: core: Use DEVICE_ATTR_RW() for SPI slave control sysfs attribute" to the spi tree
In-Reply-To: <20190731124738.14519-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Message-Id: <20190801131055.CB19E2742C48@ypsilon.sirena.org.uk>
Date:   Thu,  1 Aug 2019 14:10:55 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: core: Use DEVICE_ATTR_RW() for SPI slave control sysfs attribute

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From cc8b4659491d23577eb8992449d82c7f4f4fc170 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 31 Jul 2019 14:47:38 +0200
Subject: [PATCH] spi: core: Use DEVICE_ATTR_RW() for SPI slave control sysfs
 attribute

Convert the SPI slave control sysfs attribute from DEVICE_ATTR() to
DEVICE_ATTR_RW(), to reduce boilerplate.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20190731124738.14519-1-geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 75ac046cae52..9fd7926e80c0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2105,8 +2105,8 @@ static int match_true(struct device *dev, void *data)
 	return 1;
 }
 
-static ssize_t spi_slave_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
+static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
 {
 	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
 						   dev);
@@ -2117,9 +2117,8 @@ static ssize_t spi_slave_show(struct device *dev,
 		       child ? to_spi_device(child)->modalias : NULL);
 }
 
-static ssize_t spi_slave_store(struct device *dev,
-			       struct device_attribute *attr, const char *buf,
-			       size_t count)
+static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct spi_controller *ctlr = container_of(dev, struct spi_controller,
 						   dev);
@@ -2157,7 +2156,7 @@ static ssize_t spi_slave_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(slave, 0644, spi_slave_show, spi_slave_store);
+static DEVICE_ATTR_RW(slave);
 
 static struct attribute *spi_slave_attrs[] = {
 	&dev_attr_slave.attr,
-- 
2.20.1

