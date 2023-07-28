Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179017663EA
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 08:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjG1GIM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 02:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjG1GIL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 02:08:11 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABB6272A;
        Thu, 27 Jul 2023 23:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1690524488; x=1722060488;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JyXHrpBjZ2HNISHY+kO/sTcUhM9TK1HlabZppxy8m6M=;
  b=XCoXg/gQB9Ntw7nlojt7C7KBVRDxytEb0qJxvAaUOtfRUbh48TC5G9TJ
   GmYbqbyIrBz63DsydDPcDV/QD6muCLetk+dlbuljr12mndVm56bKHb9J4
   ESfSQLYdOpKgqsbk8d3xdqW57qnwvBr7Lo1g/JtwKAcVD3vVdm1+uLQ9N
   PYNfRHbkU6p779V2txRS0o0Ytm0aGuwe54djkqftQrFNXhsAbmoye69CK
   P8UkArA+EzSoWN5gHexghPwe/SMa81xAQ13te3Ysq0CaKG7Ab4TUv2JPJ
   yO3101lMhrbvZ2Mjcw0uOZZ/+dfxd3H9iVnwSgBaGJyYW2rWLJqPDbmFE
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684792800"; 
   d="scan'208";a="32167083"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Jul 2023 08:08:06 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 26EC5280075;
        Fri, 28 Jul 2023 08:08:06 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/1] spi: fspi: Add power-domains to the DT bindings
Date:   Fri, 28 Jul 2023 08:08:04 +0200
Message-Id: <20230728060804.22796-1-alexander.stein@ew.tq-group.com>
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

i.MX8(X) based SoC use a power domain. Allow supplying this domain in
bindings.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
index a813c971ecf65..7fd5911454800 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
@@ -45,6 +45,9 @@ properties:
       - const: fspi_en
       - const: fspi
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.34.1

