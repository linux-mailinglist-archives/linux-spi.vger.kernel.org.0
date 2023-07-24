Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A841775F627
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jul 2023 14:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGXMVV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jul 2023 08:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjGXMVR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jul 2023 08:21:17 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A9E10C7;
        Mon, 24 Jul 2023 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1690201274; x=1721737274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DOeO1JJC435SRC3aQ4QXuk4VjQRVy8mGR13t/2Ru9Tg=;
  b=bYEfSrNkXq0DYwU7X/r5bxllhGzd9rHVLrqnhlbqWWMbSftIwSpdTEWb
   1xbhSvZOtt3dtlJKsB0OgIPxfRlLr3V4/5HdjkS4CUfYATMCVww5//o33
   TE48RPrMqDDK1DQkJXCgwsdS7AA//gxoRaOevXiyVrFXi3mEhaO2zSMDi
   5d3Kjo7pUPimfsBfb8SHDnNMNncMw4YIgXpHbDz6R/QOUVZBg9/kCTDRN
   FsD8eWPzzU31RmryBoBYYlp6cls0ihu7b1VbYpz22Dpkb4qpNWkniSbyQ
   +qG3D5L+YXIxKlf/GRs8xaknmXQ/Oi0OFNUyFO1FMPSnyws4SMgRl8x6Q
   g==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684792800"; 
   d="scan'208";a="32081029"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Jul 2023 14:21:07 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3B69E280084;
        Mon, 24 Jul 2023 14:21:07 +0200 (CEST)
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
Subject: [PATCH v2 2/3] dt-bindings: spi: lpspi: Add power-domains
Date:   Mon, 24 Jul 2023 14:20:59 +0200
Message-Id: <20230724122101.2903318-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com>
References: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com>
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

i.MX8(X) based SoC use a power domain. Allow supplying this domain in
bindings.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* None

 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index e91425012319..727c5346b8ce 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -63,6 +63,9 @@ properties:
     maximum: 2
     default: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.34.1

