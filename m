Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94784D086A
	for <lists+linux-spi@lfdr.de>; Mon,  7 Mar 2022 21:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiCGUiq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Mar 2022 15:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiCGUiq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 15:38:46 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427502F03C;
        Mon,  7 Mar 2022 12:37:51 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id cx5so15175882pjb.1;
        Mon, 07 Mar 2022 12:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nB/kf152luZHG65VPIEl0gVLDXWs2thGY5x62Yqwyek=;
        b=UwJnBvgwGnPtRurzL3zhzWyL/A3fJTvja7gNOFWVmPt+pHTWiiTCODhFu3GDBS+Ii2
         MpNBaceJZfq+kecoMJhLzOw7lNinp8vCP+kE8liKLZ/lzWlPEaWGO0ytCC3nEvDKjpia
         NUVtsnNBJ8iX6gG5zNHd8jYlUi/v6IWPO4x6kdTJDuf/9uquLHzqE455qmFVrc9E1nTO
         YpX5T8PMRs7LQozmmigo73ASRhAP5uIqdaXPCwpjCYdMD7Bs+vIc3Wm4T7k4+A0Tx8uH
         wpL+qiZyQr8QqDeribLv+qmmKYqj7ECAT9VAZJcwbelLNAKUZK7ZRI40vaA9Ga1RDAgA
         sxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nB/kf152luZHG65VPIEl0gVLDXWs2thGY5x62Yqwyek=;
        b=QfvDO+AMRnvD37XwIEcg1IsiR3/PiqaUDaN5Zl3eywYPtOTvz7wJX0qp81RdSY9uBM
         ZjuwlfYaCJU0PiI5pLhqrxWAe6LuXP3kIa2uEGb7o2CCLD+gLPCmlejF7WGqr1xvqoIr
         rLwbBhPZhyhSpztwFJzpAZ9PAn+fGtCAtxXSD4UfchHQ/NYl87gUERM+hdbR58+fuLlF
         6ZOfS61inD97G0h5j/mM/52nw2xnjZxpxH3NS9mKsPtuogANJ57KrbVPgEDEGraCgbiK
         aeVvGW9zEINOO28Q5UXVEYhZoMQT2GO9iWsrD6eC8OG2Nkgw0tUPlf64/Ctd9OHZEorw
         W0aw==
X-Gm-Message-State: AOAM532HqBp7nfqz3V+3akDSf/zH+vNneBU71Mmjp3tw/UaVBI5Po8GV
        XDq1LnlQhWezrVbOfpW4QxYQFboZGy2MAw==
X-Google-Smtp-Source: ABdhPJzXhpIMUwRg38H6h6F7XLuUfrNyMC+l5zunysGaJc1+MYaLcRoQcalgLp9eU7o6XFo49SunDw==
X-Received: by 2002:a17:90a:74c7:b0:1bf:5532:3ae8 with SMTP id p7-20020a17090a74c700b001bf55323ae8mr844699pjl.120.1646685470620;
        Mon, 07 Mar 2022 12:37:50 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a450900b001b9b5ca299esm206323pjg.54.2022.03.07.12.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 12:37:50 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/2] dt-bindings: spi: Update clocks property for ARM pl022
Date:   Tue,  8 Mar 2022 02:07:44 +0530
Message-Id: <20220307203745.65210-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add missing minItems property to clocks in ARM pl022 bindings.

This helps in resolving below warnings:
clocks: [[4]] is too short
clock-names: ['apb_pclk'] is too short

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-pl022.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index 6d633728fc2b..7d36e15db5b3 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -34,6 +34,7 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 1
     maxItems: 2
 
   clock-names:
-- 
2.25.1

