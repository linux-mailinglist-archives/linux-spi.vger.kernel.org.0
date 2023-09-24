Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CC37ACB66
	for <lists+linux-spi@lfdr.de>; Sun, 24 Sep 2023 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjIXSjU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 Sep 2023 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXSjT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 Sep 2023 14:39:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4D3A6;
        Sun, 24 Sep 2023 11:39:13 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c571029a36so5019255ad.1;
        Sun, 24 Sep 2023 11:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695580752; x=1696185552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CeptK0gjsxrs/rUO0yPAiUg8fDonAYbrR2ASWjNYk1Q=;
        b=iifVM7WE2PSxPpiY76BOJCW7+2dQc/4LEVr29mzP9eckpqg9y+MLbefQbPcQPu93hm
         dQaRqRudoNlnjWvVQlb+2h16Rs0yYmu/GtUT3sSCROJdhOwGIT+UlSjAHfTrDCquRksm
         /6yiv9+O/7dTurIyCdlez2+VCfRma82xugfFGhg8yKCBr0MUAlp23srfpqfaZQhQiZlU
         9xV0vX1H2cCBhSG2CugZmSg7MUEFV04k7xS/iXbQmrE+hSiQUDKre75Mhk3P3mqbMlDV
         WRSvAmACUVqFgfZzWjcT5ohctDPyYRBtpULrilvHe/xH0yfHv0I/uuz/Xm0QVKe5+5Hv
         MviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695580752; x=1696185552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CeptK0gjsxrs/rUO0yPAiUg8fDonAYbrR2ASWjNYk1Q=;
        b=P/2KNhlUNN1FQpt2iMG8UKvaQlC7EeYgalkDCAYJmAwpoIqfgLClSZQ7SHyx8p+BlR
         niZrVaMZNFNc0Mn5lo1zcO+coepnBnoe/TaU/FpVZGvqE0Cc2kulpvCR2XPCANzRPOKG
         ZN0NtquV6EqzLU/Pw4VvDR1wpcVmEIK7G0pTgzlAKnCjCZW7N/o/Dc+27BhH+W/wPPnE
         tZWOXhi3R141f7NHRvIlVj554Uf2/lbsef+NH7P1aw/53a1cj/B2m+vcWDIaFBoShDqe
         /tMB9P7NHu4iubW1bHnqolgl7ONQ7s15GWf6qVaerupo41Ha6qN81E0Uat1aprH7C/Ba
         FNPQ==
X-Gm-Message-State: AOJu0YwAhHQdr3l8d3PjynvigKVrMCsh2MN3rLanDZZ+exXtHAsD9bo2
        OLbRBlp9NQ437fsKlZcRUxk6UsTZiwI=
X-Google-Smtp-Source: AGHT+IHNRApLXOPTiy9nlrVoBjIdngPUCfgvtwWsO+QYVIkzQ7PEU24yqcgtB+d0jQLw7KMXghuz1w==
X-Received: by 2002:a17:903:2348:b0:1c3:4073:bf80 with SMTP id c8-20020a170903234800b001c34073bf80mr6572778plh.0.1695580752400;
        Sun, 24 Sep 2023 11:39:12 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:24bc:448c:a18c:2275])
        by smtp.gmail.com with ESMTPSA id v7-20020a170902b7c700b001c61073b064sm1312433plz.69.2023.09.24.11.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 11:39:11 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] dt-bindings: spi: fsl-imx-cspi: Document missing entries
Date:   Sun, 24 Sep 2023 15:39:04 -0300
Message-Id: <20230924183904.752415-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

The imx25, imx50, imx51 and imx53 SPIs are compatible with the imx35.

Document them accordingly.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
index 2f593c7225e5..14cac0e6e0a1 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
@@ -22,6 +22,13 @@ properties:
       - const: fsl,imx35-cspi
       - const: fsl,imx51-ecspi
       - const: fsl,imx53-ecspi
+      - items:
+          - enum:
+              - fsl,imx25-cspi
+              - fsl,imx50-cspi
+              - fsl,imx51-cspi
+              - fsl,imx53-cspi
+          - const: fsl,imx35-cspi
       - items:
           - const: fsl,imx8mp-ecspi
           - const: fsl,imx6ul-ecspi
-- 
2.34.1

