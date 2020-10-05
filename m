Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27F82834E4
	for <lists+linux-spi@lfdr.de>; Mon,  5 Oct 2020 13:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJEL0D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 5 Oct 2020 07:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJELZy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 5 Oct 2020 07:25:54 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BFFC0613A8
        for <linux-spi@vger.kernel.org>; Mon,  5 Oct 2020 04:25:53 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id cBRq2300M4C55Sk01BRqFe; Mon, 05 Oct 2020 13:25:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kPOco-0005HY-L4; Mon, 05 Oct 2020 13:25:50 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kPOco-0005nC-IV; Mon, 05 Oct 2020 13:25:50 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: renesas,sh-msiof: Add r8a77961 support
Date:   Mon,  5 Oct 2020 13:25:47 +0200
Message-Id: <20201005112549.22222-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document R-Car M3-W+ (R8A77961) SoC bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on Salvator-XS with R-Car M3-W+ and spi-loopback-test.

 Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
index 9f7b118adcaf7d20..3d3b60ee1ca46b9d 100644
--- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
@@ -41,6 +41,7 @@ properties:
               - renesas,msiof-r8a774e1      # RZ/G2H
               - renesas,msiof-r8a7795       # R-Car H3
               - renesas,msiof-r8a7796       # R-Car M3-W
+              - renesas,msiof-r8a77961      # R-Car M3-W+
               - renesas,msiof-r8a77965      # R-Car M3-N
               - renesas,msiof-r8a77970      # R-Car V3M
               - renesas,msiof-r8a77980      # R-Car V3H
-- 
2.17.1

