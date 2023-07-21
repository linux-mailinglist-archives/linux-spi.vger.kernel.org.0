Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DD675C597
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jul 2023 13:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGULMF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Jul 2023 07:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGULLz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jul 2023 07:11:55 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87D830C4;
        Fri, 21 Jul 2023 04:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1689937890; x=1721473890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bg0EKrPEjTsGypZ5UK09REWMP3ov4FCmALYSfW5tDVk=;
  b=FCiVybKDrcqcOrgcWDFHvdsmk6zLZQbLC4t66Tpb2j8wFZOeX3xaABoZ
   XkfCRRmN95GhMEduz4Q4k+43ljjywNBqc6/xRZDISvyOLgjpNBbQS0Q62
   WRBt4J6y5wPiBuI9iLSrVjK1wTvdf0oKZ5Cg+Us12p/NmRFQzeIby23VA
   DOHosNU+Xcpu1tHwtjcdC82hutFJShVNWzOy0Wuhj788Cm20QkerRovwK
   7loTXMJcI7QjpMI42pL5zpL427fyk6LIQGrCuVNEXEWqjeCDONWVaGOlY
   +1b0F3rkTBoiqKWDWisRtn8RMJzESM/S3Z324jeKQDBZ91CkVzs8BydQF
   w==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684792800"; 
   d="scan'208";a="32052709"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Jul 2023 13:10:34 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 634CC280078;
        Fri, 21 Jul 2023 13:10:34 +0200 (CEST)
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
Subject: [PATCH 1/3] dt-bindings: media: amphion: Fix subnode pattern
Date:   Fri, 21 Jul 2023 13:10:18 +0200
Message-Id: <20230721111020.1234278-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
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

DT nodes use dashes instead of underscore. Adjust pattern to also fix
warnings regarding nodes in arch/arm64/boot/dts/freescale/imx8-ss-vpu.dtsi

Fixes: 38ad8b32f3af ("dt-bindings: media: amphion: add amphion video codec bindings")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/devicetree/bindings/media/amphion,vpu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/amphion,vpu.yaml b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
index a9d80eaeeeb6..90d273b9fdd7 100644
--- a/Documentation/devicetree/bindings/media/amphion,vpu.yaml
+++ b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
@@ -47,7 +47,7 @@ patternProperties:
     $ref: ../mailbox/fsl,mu.yaml#
 
 
-  "^vpu_core@[0-9a-f]+$":
+  "^vpu-core@[0-9a-f]+$":
     description:
       Each core correspond a decoder or encoder, need to configure them
       separately. NXP i.MX8QM SoC has one decoder and two encoder, i.MX8QXP SoC
-- 
2.34.1

