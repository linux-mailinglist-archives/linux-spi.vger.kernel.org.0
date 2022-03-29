Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6D74EAC71
	for <lists+linux-spi@lfdr.de>; Tue, 29 Mar 2022 13:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiC2LjI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 07:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiC2LjF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 07:39:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0F41E95E0
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 04:37:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id u26so20325201eda.12
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 04:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l0r3JgCO3FtKvN2I9Yh8k+M/10iLyA3rxE8G9DgUQqQ=;
        b=T1ZSBwbNp5/bx/hLwNmz6+X0yRzcXRob38czJiW3qJbRoOrvIbriCGq5LZXqxQinfz
         1JEJB5rxT5q+uPtzPQLQiXAdv+osQfHo7vcOUtTK9+WIuFyt4eQ9RBo7wtNyiMo7o/3/
         t2/YI3n6bcRhrawbfsDrxrNBB0qonRXDQUHbuFIbq2qH+qzHSzxYo1U8QVMXqGm9c6fY
         HfIswWeQt6aIwoT5RHztmgNOGAWv2Uq7/W0oaGC+gIzcTzt3bB1691y/bxi0cF76unoS
         P+WBL0k/XQ/7KHcaOQ7zqV6sNpSD/wtLnwm0G+5sx/gahQYbh/GFyBOLNxJJqs2vDoaZ
         6b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l0r3JgCO3FtKvN2I9Yh8k+M/10iLyA3rxE8G9DgUQqQ=;
        b=rG4P2tA+0hSdIm0N/EIB6qRZy4axfNt0jpNCpBvOEyMg2KepVGgdKcUi4qdL/y7dgz
         xLdrmv/p9s4sAmNnDbLnhLgDyyjM99nlA2sFBZUsMj3yN9QnYLVZN0CvDjtVPYl2JGH8
         4REyQ1TSU+6cPiTCk9spuAMoSvpd7f+meAVDza6R7wNZ4ll0clzQQxiqvZ0vm0m4N13w
         x34eoVEtJCs1MzuXP8JobAOtytYACH55RxZc31MWR2hlOO82IBIltWj1U3RYm5+HDWuK
         Xs0D0m/Q+tsPdbw51FAhCGZFmj7xCnvMIyqEnNgXBm0mBS7ML/tcgFqOSmyR+L+Fkk3E
         2Gvg==
X-Gm-Message-State: AOAM532/ACikAUUqCxpB6RsWEUDZixiMrQQivk0cwMO7/fvnbFlxnC90
        B1D+gCwzGHgnD10ZbJKFcFJdeQ==
X-Google-Smtp-Source: ABdhPJxpfNhBlPrjt3o8ugtryIQLLyZycfkmYvi3txadjZuDKS/h08TwobYJVRBdy50jV/oEj47AOA==
X-Received: by 2002:a05:6402:1d51:b0:418:bd81:78b3 with SMTP id dz17-20020a0564021d5100b00418bd8178b3mr3887542edb.46.1648553840951;
        Tue, 29 Mar 2022 04:37:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709066d8800b006e09a49a713sm5521002ejt.159.2022.03.29.04.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:37:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH] dt-bindings: qcom: update maintainers (drop Akash and Mukesh)
Date:   Tue, 29 Mar 2022 13:37:17 +0200
Message-Id: <20220329113718.254642-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Emails to Akash Asthana and Mukesh Savaliya bounce (550: Recipient
address rejected: User unknown in virtual alias table), so switch
maintainers to Andy and Bjorn (as Qualcomm platform maintainers).

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml  | 4 ++--
 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
index 1ca081b1664e..1bc12b6a7e01 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
@@ -7,8 +7,8 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 title: GENI Serial Engine QUP Wrapper Controller
 
 maintainers:
-  - Mukesh Savaliya <msavaliy@codeaurora.org>
-  - Akash Asthana <akashast@codeaurora.org>
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
 
 description: |
  Generic Interface (GENI) based Qualcomm Universal Peripheral (QUP) wrapper
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
index 055524fe8327..e009cb3e6dc9 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
@@ -8,8 +8,8 @@ $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 title: Qualcomm Quad Serial Peripheral Interface (QSPI)
 
 maintainers:
-  - Mukesh Savaliya <msavaliy@codeaurora.org>
-  - Akash Asthana <akashast@codeaurora.org>
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
 
 description: The QSPI controller allows SPI protocol communication in single,
   dual, or quad wire transmission modes for read/write access to slaves such
-- 
2.32.0

