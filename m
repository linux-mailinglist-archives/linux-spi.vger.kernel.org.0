Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2AE99FD5
	for <lists+linux-spi@lfdr.de>; Thu, 22 Aug 2019 21:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbfHVTXA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Aug 2019 15:23:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58394 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730693AbfHVTXA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 22 Aug 2019 15:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=CR/FnPjPw9RxgXe6hqu+ANuYh3/MYIEKK4pmVfMFOyQ=; b=dRg3YZQAXNnG
        LXHfomQPnHhELOYtSDYM3S1A1dOTPzeSGSVUVJK11qBePQ6m+rLkV9nArPja00obLmhNKrrZiaKVq
        v68z7suBN9A00SfJbgHyhr9DXJNBhYTR70rAUefgX45kntxvi+qm6y7z6pUtKWC+S0mULFaN3Xo5S
        b/ZIA=;
Received: from 92.40.26.78.threembb.co.uk ([92.40.26.78] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i0sff-00080M-Q8; Thu, 22 Aug 2019 19:22:55 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id EC64ED02CB0; Thu, 22 Aug 2019 20:22:54 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Ashish Kumar <Ashish.Kumar@nxp.com>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>, broonie@kernel.org,
        devicetree@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, robh+dt@kernel.org
Subject: Applied "spi: spi-fsl-qspi: Add ls2080a compatibility string to bindings" to the spi tree
In-Reply-To:  <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190822192254.EC64ED02CB0@fitzroy.sirena.org.uk>
Date:   Thu, 22 Aug 2019 20:22:54 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   spi: spi-fsl-qspi: Add ls2080a compatibility string to bindings

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

From be28f76b7e8ffaf04690e30fd17683d8afea1fd9 Mon Sep 17 00:00:00 2001
From: Ashish Kumar <Ashish.Kumar@nxp.com>
Date: Tue, 13 Aug 2019 15:53:09 +0530
Subject: [PATCH] spi: spi-fsl-qspi: Add ls2080a compatibility string to
 bindings

There are 2 version of QSPI-IP, according to which controller registers sets
can be big endian or little endian.There are some other minor changes like
RX fifo depth etc.

The big endian version uses driver compatible "fsl,ls1021a-qspi" and
little endian version uses driver compatible "fsl,ls2080a-qspi"

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Han Xu <han.xu@nxp.com>
Link: https://lore.kernel.org/r/1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index 1b23cfd7b39b..69dc5d57b1ef 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -3,9 +3,8 @@
 Required properties:
   - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
 		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
-		 "fsl,ls1021a-qspi"
+		 "fsl,ls1021a-qspi", "fsl,ls2080a-qspi"
 		 or
-		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
 		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
   - reg : the first contains the register location and length,
           the second contains the memory mapping address and length
-- 
2.20.1

