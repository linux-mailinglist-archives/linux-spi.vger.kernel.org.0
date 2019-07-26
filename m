Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C32E76561
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2019 14:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfGZMMh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Jul 2019 08:12:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36542 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfGZMMh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Jul 2019 08:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0JaOym/8/1xYTPj/lo5DfsfdR6OwtKMSwBUpWlF89z0=; b=hnGLPn1FdiHl
        v3Z8uQinKEdqNQGi4zdGQZwpSG/IHSsABkF/uQSQA+UwhUIDEhestFvojqz32XVGIH4jxNARq4Rkq
        EJ+NTVhZcyL809+hqpgpPt5YG1KIX6WKbI4RykYu5fUjqY9D7KOUV3w5ENCGQQrIgxK6cHZ0UmHzU
        Xs4Hk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqz5E-0001aO-3f; Fri, 26 Jul 2019 12:12:24 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 99EF52742B63; Fri, 26 Jul 2019 13:12:23 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     baolin.wang@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        sherry.zong@unisoc.com, vincent.guittot@linaro.org,
        weicx@spreadst.com, zhang.lyra@gmail.com
Subject: Applied "spi: sprd: Change the hwlock support to be optional" to the spi tree
In-Reply-To: <23d51f5d9c9cc647ad0c5a1fb950d3d9fb9c1303.1564125131.git.baolin.wang@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20190726121223.99EF52742B63@ypsilon.sirena.org.uk>
Date:   Fri, 26 Jul 2019 13:12:23 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: sprd: Change the hwlock support to be optional

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

From 70f69f481b87da0614360e57e05a3ba962d60439 Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 26 Jul 2019 15:20:53 +0800
Subject: [PATCH] spi: sprd: Change the hwlock support to be optional

No need to add hardware spinlock proctection due to add multiple
msater channel, so change it to be optional in documentation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Link: https://lore.kernel.org/r/23d51f5d9c9cc647ad0c5a1fb950d3d9fb9c1303.1564125131.git.baolin.wang@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-sprd-adi.txt          | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
index 8de589b376ce..2567c829e2dc 100644
--- a/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
@@ -25,18 +25,23 @@ data by ADI software channels at the same time, or two parallel routine of setti
 ADI registers will make ADI controller registers chaos to lead incorrect results.
 Then we need one hardware spinlock to synchronize between the multiple subsystems.
 
+The new version ADI controller supplies multiple master channels for different
+subsystem accessing, that means no need to add hardware spinlock to synchronize,
+thus change the hardware spinlock support to be optional to keep backward
+compatibility.
+
 Required properties:
 - compatible: Should be "sprd,sc9860-adi".
 - reg: Offset and length of ADI-SPI controller register space.
-- hwlocks: Reference to a phandle of a hwlock provider node.
-- hwlock-names: Reference to hwlock name strings defined in the same order
-	as the hwlocks, should be "adi".
 - #address-cells: Number of cells required to define a chip select address
 	on the ADI-SPI bus. Should be set to 1.
 - #size-cells: Size of cells required to define a chip select address size
 	on the ADI-SPI bus. Should be set to 0.
 
 Optional properties:
+- hwlocks: Reference to a phandle of a hwlock provider node.
+- hwlock-names: Reference to hwlock name strings defined in the same order
+	as the hwlocks, should be "adi".
 - sprd,hw-channels: This is an array of channel values up to 49 channels.
 	The first value specifies the hardware channel id which is used to
 	transfer data triggered by hardware automatically, and the second
-- 
2.20.1

