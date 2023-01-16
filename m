Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08866BDAB
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jan 2023 13:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjAPMTD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Jan 2023 07:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjAPMS1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Jan 2023 07:18:27 -0500
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E91F5F3
        for <linux-spi@vger.kernel.org>; Mon, 16 Jan 2023 04:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=kicherer.org; h=from:to
        :cc:subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=k1; bh=i1CIHKrWalhSQJZfn0n6FaQ71uG
        qhcTFcPj+Qh2DMWk=; b=BuIy6qzw48TJ+Dw2uaTfD2/zBNMTkjn3EZW4zZkPOId
        nfZGOI72TcSIswHex5rD/pIY2kV50sN7GXca4/qIhdbVKqyl6X2W4gyvhTtpjG5k
        GsbfJlX1MnAK4x/SHAh8IYGMGCo2uY51MFjHsk/XsJs0L7JadyKKxVa4Yf9kEN1I
        =
Received: (qmail 669724 invoked from network); 16 Jan 2023 12:51:34 +0100
Received: by mail.zeus06.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Jan 2023 12:51:34 +0100
X-UD-Smtp-Session: l3s6476p2@KVj+M2Dy0crCtAHJ
From:   Mario Kicherer <dev@kicherer.org>
To:     linux-spi@vger.kernel.org
Cc:     han.xu@nxp.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Mario Kicherer <dev@kicherer.org>
Subject: [PATCH 1/2] spi: dt-bindings: spi-fsl-qspi: add optional sampling-delay
Date:   Mon, 16 Jan 2023 12:50:49 +0100
Message-Id: <20230116115050.2983406-2-dev@kicherer.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116115050.2983406-1-dev@kicherer.org>
References: <20230116115050.2983406-1-dev@kicherer.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add optional sampling-delay property to delay the internal sampling point for
incoming data.

Signed-off-by: Mario Kicherer <dev@kicherer.org>
---
 Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index e58644558412..7952a4be938b 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -54,6 +54,12 @@ properties:
       - const: qspi_en
       - const: qspi
 
+  fsl,qspi-sampling-delay:
+    description: delay sampling of incoming data by this number of half cycles
+    minimum: 0
+    maximum: 3
+    default: 0
+
 required:
   - compatible
   - reg
-- 
2.34.1

