Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66C94F8A52
	for <lists+linux-spi@lfdr.de>; Fri,  8 Apr 2022 00:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiDGVDR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 17:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiDGVDQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 17:03:16 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A4616A697;
        Thu,  7 Apr 2022 14:01:14 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9E56783CD8;
        Thu,  7 Apr 2022 23:01:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1649365272;
        bh=KVa0TB5KRW3+rYxYiVmwiy/UGOgcAL0M7kFkPIFnFKU=;
        h=From:To:Cc:Subject:Date:From;
        b=T7JxgYorIKmgXKL60OXWSLmwzXlVstp6kwEhyHL4QBFF980XwsPg8s3wf37+/By23
         v9EyNsWA6uWXFO+XLOHy1VKTREvt9oBcG1r0CgDCC3FugwkezM0ZM2a6TbZ9dgjwWn
         SXrAr0IbNVcFk0RDiFXJPCY/xh1hgsxK3gjLynQFzO49RQsXrMvXWGKjg2OZqAwUiG
         lYrUj0zBZmJ0GyogJaAgnd00OXaZ5/OZN0Yk72YpHVrNo47izNadGd5QYhpYBXaBXl
         xpn59UqVyJ4pkGi7SbvHSyc3b7ddeXeLF1z31riTNVxF6fgT3MccpqQTDauu+AYkwn
         0tn1N1xxyX7GQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] dt-bindings: trivial-devices: Document CPLD on DH electronics boards
Date:   Thu,  7 Apr 2022 23:01:06 +0200
Message-Id: <20220407210106.256027-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The CPLD on DH electronics boards is used to model arbitrary custom
glue logic, however it does have SPI interface. Document the CPLD DT
binding as trivial SPI device.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: NXP Linux Team <linux-imx@nxp.com>
To: linux-spi@vger.kernel.org
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 550a2e5c9e05d..b2801b666078c 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -87,6 +87,8 @@ properties:
           - devantech,srf08
             # Devantech SRF10 ultrasonic ranger
           - devantech,srf10
+            # DH electronics GmbH on-board CPLD trivial SPI device
+          - dh,dhcom-board
             # DA9053: flexible system level PMIC with multicore support
           - dlg,da9053
             # DA9063: system PMIC for quad-core application processors
-- 
2.35.1

