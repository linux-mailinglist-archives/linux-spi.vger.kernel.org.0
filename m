Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77097455327
	for <lists+linux-spi@lfdr.de>; Thu, 18 Nov 2021 04:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242673AbhKRDN4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Nov 2021 22:13:56 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:51670 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242660AbhKRDNz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Nov 2021 22:13:55 -0500
X-IronPort-AV: E=Sophos;i="5.87,243,1631545200"; 
   d="scan'208";a="100643645"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 18 Nov 2021 12:10:54 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 657C24009F73;
        Thu, 18 Nov 2021 12:10:52 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/3] spi: dt-bindings: renesas,rspi: Document RZ/G2L SoC
Date:   Thu, 18 Nov 2021 03:10:39 +0000
Message-Id: <20211118031041.2312-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211118031041.2312-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211118031041.2312-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add RSPI binding documentation for Renesas RZ/G2L SoC.

RSPI block is identical to one found on RZ/A, so no driver changes are
required. The fallback compatible string "renesas,rspi-rz" will be used
on RZ/G2L.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1->v2
* Updated commit description
* Folded resets property check along with renesas,qspi
---
 Documentation/devicetree/bindings/spi/renesas,rspi.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
index 8397f60d80a2..76e6d9e52fc7 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
@@ -21,7 +21,8 @@ properties:
           - enum:
               - renesas,rspi-r7s72100  # RZ/A1H
               - renesas,rspi-r7s9210   # RZ/A2
-          - const: renesas,rspi-rz     # RZ/A
+              - renesas,r9a07g044-rspi # RZ/G2{L,LC}
+          - const: renesas,rspi-rz     # RZ/A and RZ/G2{L,LC}
 
       - items:
           - enum:
@@ -122,6 +123,7 @@ allOf:
           contains:
             enum:
               - renesas,qspi
+              - renesas,r9a07g044-rspi
     then:
       required:
         - resets
-- 
2.17.1

