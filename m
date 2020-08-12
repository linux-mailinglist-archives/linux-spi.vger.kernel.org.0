Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EB0242BD5
	for <lists+linux-spi@lfdr.de>; Wed, 12 Aug 2020 17:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHLPBs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Aug 2020 11:01:48 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:6382 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbgHLPBr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Aug 2020 11:01:47 -0400
X-IronPort-AV: E=Sophos;i="5.76,304,1592838000"; 
   d="scan'208";a="54233345"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Aug 2020 00:01:46 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 19792400492E;
        Thu, 13 Aug 2020 00:01:43 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: [PATCH 1/2] dt-bindings: spi: renesas,rspi: Add r8a7742 to the compatible list
Date:   Wed, 12 Aug 2020 16:00:47 +0100
Message-Id: <20200812150048.27721-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812150048.27721-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200812150048.27721-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document RZ/G1H (R8A7742) SoC specific bindings. The R8A7742 qspi module
is identical to R-Car Gen2 family.

No driver change is needed due to the fallback compatible value
"renesas,qspi".

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
---
 Documentation/devicetree/bindings/spi/renesas,rspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
index c54ac059043f..0d201ce1d5da 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
@@ -25,6 +25,7 @@ properties:
 
       - items:
           - enum:
+              - renesas,qspi-r8a7742   # RZ/G1H
               - renesas,qspi-r8a7743   # RZ/G1M
               - renesas,qspi-r8a7744   # RZ/G1N
               - renesas,qspi-r8a7745   # RZ/G1E
-- 
2.17.1

