Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D7C99FD2
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2019 21:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733213AbfHVTXD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Aug 2019 15:23:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58486 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731683AbfHVTXC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Aug 2019 15:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Jthvcsal19IOXZ8heWx5wwt/W5rsQQFGdSuSyZmBYtQ=; b=t+y9YMa5Vq9z
        X9CP6Ekoqy5sSeg4pR5RRrKUyJZMXfC3eUH0LwM2fPPXL8s+WIhb5NwSzV5a58LQmC31I+ivcVFkA
        NvmW8/ZTsmc/+OhMQYUZVDR+nfGVRadoMrnsOMC1qnF4Fe9xkTdc0T6ECkksWJlJNCoV3DMaKFo99
        74Ziw=;
Received: from 92.40.26.78.threembb.co.uk ([92.40.26.78] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i0sfi-00080S-LY; Thu, 22 Aug 2019 19:22:58 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id CF419D02CB0; Thu, 22 Aug 2019 20:22:57 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Ashish Kumar <Ashish.Kumar@nxp.com>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: Applied "spi: fsl-qspi: Enhance binding to extend example for flash entry" to the spi tree
In-Reply-To:  <1565691791-26167-3-git-send-email-Ashish.Kumar@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190822192257.CF419D02CB0@fitzroy.sirena.org.uk>
Date:   Thu, 22 Aug 2019 20:22:57 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: fsl-qspi: Enhance binding to extend example for flash entry

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From 303290e130bfd504a8230f49e545f6b91e120553 Mon Sep 17 00:00:00 2001
From: Ashish Kumar <Ashish.Kumar@nxp.com>
Date: Tue, 13 Aug 2019 15:53:11 +0530
Subject: [PATCH] spi: fsl-qspi: Enhance binding to extend example for flash
 entry

Add example for adding flash entry on various boards' dts
using flash manufacture spansion/cypress.

Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
Link: https://lore.kernel.org/r/1565691791-26167-3-git-send-email-Ashish.Kumar@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index e8f1d627d288..1b23cfd7b39b 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -34,7 +34,11 @@ qspi0: quadspi@40044000 {
 	clock-names = "qspi_en", "qspi";
 
 	flash0: s25fl128s@0 {
-		....
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl128s", "jedec,spi-nor";
+		spi-max-frequency = <50000000>;
+		reg = <0>;
 	};
 };
 
-- 
2.20.1

