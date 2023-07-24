Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFDD75F624
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jul 2023 14:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjGXMVU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jul 2023 08:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjGXMVN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jul 2023 08:21:13 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0091728;
        Mon, 24 Jul 2023 05:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1690201269; x=1721737269;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/roN2fTZQ9B5pTFJzBg264zpu1jnGYtWWClK0AUlBRw=;
  b=ZLiP5ZQi+cEy63W6Y72fNShUZRLOkMGXlQaPI9WO0io3abCI9ACfGBjz
   IiN0RjYPAro1c+ipyXpDyXYoZGuV/kTXcsblBgDJ171NgoAGQVM2P/fXF
   33oAzY3nRpOcNKR12uCGRjhzRc293h3SRP5A6xszILR7gmPuuvhG2+xw3
   lDPR3l3TN2e5LV4jGVZOnNG+18jOC4dskMIeAOBtubULoQmnVYJ0XQKUZ
   kk+tNv4l29PcdKhpamxzFO5kOQUvyUGhzo+0uiUnaBrzbtVtDsRNtUnko
   lX5aJiwM8FhfHKWlq4sFsJXvdc7Sg51sq5zyIirkNRyKtCsO7l82tjcLw
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684792800"; 
   d="scan'208";a="32081028"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Jul 2023 14:21:07 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DC6AF280078;
        Mon, 24 Jul 2023 14:21:06 +0200 (CEST)
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
Subject: [PATCH v2 1/3] dt-bindings: media: amphion: Fix subnode pattern
Date:   Mon, 24 Jul 2023 14:20:58 +0200
Message-Id: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
* Fixed examples

 Documentation/devicetree/bindings/media/amphion,vpu.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/amphion,vpu.yaml b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
index a9d80eaeeeb6..c0d83d755239 100644
--- a/Documentation/devicetree/bindings/media/amphion,vpu.yaml
+++ b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
@@ -47,7 +47,7 @@ patternProperties:
     $ref: ../mailbox/fsl,mu.yaml#
 
 
-  "^vpu_core@[0-9a-f]+$":
+  "^vpu-core@[0-9a-f]+$":
     description:
       Each core correspond a decoder or encoder, need to configure them
       separately. NXP i.MX8QM SoC has one decoder and two encoder, i.MX8QXP SoC
@@ -143,7 +143,7 @@ examples:
         power-domains = <&pd IMX_SC_R_VPU_MU_2>;
       };
 
-      vpu_core0: vpu_core@2d080000 {
+      vpu_core0: vpu-core@2d080000 {
         compatible = "nxp,imx8q-vpu-decoder";
         reg = <0x2d080000 0x10000>;
         power-domains = <&pd IMX_SC_R_VPU_DEC_0>;
@@ -154,7 +154,7 @@ examples:
         memory-region = <&decoder_boot>, <&decoder_rpc>;
       };
 
-      vpu_core1: vpu_core@2d090000 {
+      vpu_core1: vpu-core@2d090000 {
         compatible = "nxp,imx8q-vpu-encoder";
         reg = <0x2d090000 0x10000>;
         power-domains = <&pd IMX_SC_R_VPU_ENC_0>;
@@ -165,7 +165,7 @@ examples:
         memory-region = <&encoder1_boot>, <&encoder1_rpc>;
       };
 
-      vpu_core2: vpu_core@2d0a0000 {
+      vpu_core2: vpu-core@2d0a0000 {
         reg = <0x2d0a0000 0x10000>;
         compatible = "nxp,imx8q-vpu-encoder";
         power-domains = <&pd IMX_SC_R_VPU_ENC_1>;
-- 
2.34.1

