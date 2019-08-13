Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1588B55D
	for <lists+linux-spi@lfdr.de>; Tue, 13 Aug 2019 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfHMKX1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Aug 2019 06:23:27 -0400
Received: from inva020.nxp.com ([92.121.34.13]:33662 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbfHMKX1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Aug 2019 06:23:27 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 407E51A0771;
        Tue, 13 Aug 2019 12:23:25 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F1FD1A0300;
        Tue, 13 Aug 2019 12:23:20 +0200 (CEST)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CFF93402EC;
        Tue, 13 Aug 2019 18:23:14 +0800 (SGT)
From:   Ashish Kumar <Ashish.Kumar@nxp.com>
To:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-next@vger.kernel.org, Ashish Kumar <Ashish.Kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: [Patch v4 2/3] dt-bindings: spi: spi-fsl-qspi: Add bindings of ls1088a and ls1012a
Date:   Tue, 13 Aug 2019 15:53:10 +0530
Message-Id: <1565691791-26167-2-git-send-email-Ashish.Kumar@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
References: <1565691791-26167-1-git-send-email-Ashish.Kumar@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Ashish Kumar <ashish.kumar@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Han Xu <han.xu@nxp.com>
---
v4:
-Rebase to spi.git,
-Add new patch to series.
-Previous versions reviewed here http://patchwork.ozlabs.org/patch/1118641/
v3:
Rebase to top
v2: 
Convert to patch series and rebasing done on top of tree

 Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index 6d7c9ec..2c2a3e9 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -6,6 +6,8 @@ Required properties:
 		 "fsl,ls1021a-qspi", "fsl,ls2080a-qspi"
 		 or
 		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
+		 "fsl,ls1012a-qspi" followed by "fsl,ls1021a-qspi"
+		 "fsl,ls1088a-qspi" followed by "fsl,ls2080a-qspi"
   - reg : the first contains the register location and length,
           the second contains the memory mapping address and length
   - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
-- 
2.7.4

