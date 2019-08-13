Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF2458B55E
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2019 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfHMKX1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Aug 2019 06:23:27 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33948 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727632AbfHMKX1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Aug 2019 06:23:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B36F20016D;
        Tue, 13 Aug 2019 12:23:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DA86C200154;
        Tue, 13 Aug 2019 12:23:19 +0200 (CEST)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2D359402BF;
        Tue, 13 Aug 2019 18:23:14 +0800 (SGT)
From:   Ashish Kumar <Ashish.Kumar@nxp.com>
To:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-next@vger.kernel.org, Ashish Kumar <Ashish.Kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: [Patch v4 1/3] dt-bindings: spi: spi-fsl-qspi: Add ls2080a compatibility string to bindings
Date:   Tue, 13 Aug 2019 15:53:09 +0530
Message-Id: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There are 2 version of QSPI-IP, according to which controller registers sets
can be big endian or little endian.There are some other minor changes like
RX fifo depth etc.

The big endian version uses driver compatible "fsl,ls1021a-qspi" and
little endian version uses driver compatible "fsl,ls2080a-qspi"

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Han Xu <han.xu@nxp.com>
---
v4:
-Rebase to spi.git,
-Add new patch to series.
-Previous versions reviewed here http://patchwork.ozlabs.org/patch/1118639/
v3:
Rebase to top
v2: 
Convert to patch series and rebasing done on top of tree

 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index e8f1d62..6d7c9ec 100644
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
2.7.4

