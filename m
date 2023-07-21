Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD2375C5A2
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jul 2023 13:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGULMc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jul 2023 07:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjGULMQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jul 2023 07:12:16 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B08A26B3;
        Fri, 21 Jul 2023 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1689937916; x=1721473916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gO5E00ruMsfeMJ5FRX1YvzshoNJ039epUA8ZQgAhdy0=;
  b=TehoSsgclVaZnN6B6hEEH9wm0QUIMq81OGkQpsXBhB+sanYxeXa132P6
   O59aQroFoRb/Hpf8/xF/vS759yCvdU4rE9xmPtgvDZgfXJjyee2C1LI4r
   T1Q5kQ86gWv5a3RVJm8iaQvSK2ChX0jeQKvGEq/dHygPFpWAx/vHG2NiW
   IJPNPqai+dMmO31c+T/2tHx0iURnDTzUsyfV+NtA7ziWe4SAIYuRZHmQw
   McaJWEtZHm45Jx9FepFRk4QMwamurvT3wr92vTN8X9O9c08ltG3hD9o+Z
   zWnUwJS2UtLorctHs6QAyA7hsq/Y+PzdbYpbtUBwdjQ8PlrbIR/mfRO4F
   g==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684792800"; 
   d="scan'208";a="32052711"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Jul 2023 13:10:35 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1CC89280085;
        Fri, 21 Jul 2023 13:10:35 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: media: imx-jpeg: Add clocks property
Date:   Fri, 21 Jul 2023 13:10:20 +0200
Message-Id: <20230721111020.1234278-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721111020.1234278-1-alexander.stein@ew.tq-group.com>
References: <20230721111020.1234278-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

i.MX8 and i.MX8X both use two clocks for accessing the periphery.
Add clocks and clock-names properties accordingly.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../devicetree/bindings/media/nxp,imx8-jpeg.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
index 3d9d1db37040..2533e16720f2 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
@@ -46,6 +46,14 @@ properties:
     minItems: 2               # Wrapper and 1 slot
     maxItems: 5               # Wrapper and 4 slots
 
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: per
+      - const: ipg
+
 required:
   - compatible
   - reg
-- 
2.34.1

