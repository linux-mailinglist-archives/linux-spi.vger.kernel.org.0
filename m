Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC22634C1AC
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 04:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhC2CAO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Mar 2021 22:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhC2B77 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Mar 2021 21:59:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D170C0613BB
        for <linux-spi@vger.kernel.org>; Sun, 28 Mar 2021 18:59:59 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v10so3518683pfn.5
        for <linux-spi@vger.kernel.org>; Sun, 28 Mar 2021 18:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OWuOwB9+3ReWFmXmxu1N4MeM5oSPex95DxxWguwHB7c=;
        b=1g+V7rG7G28kn0nod+C/BTms0s5k15JGbX05bf3pJtL5Gb544w6T3dIa9emI/tIRVx
         W4SFnmrhWpz/0InMfjqGs4b1vDbsPKZ204XaQW+ifS6+0/Vi1mV8pTUHNhVQdTYpnyRP
         XwSODmn9JeI74dklkAGzn8ftIkdRjA4gc0oSuy1SHadmLiyi0iBxtY18wAZdRWcIXWLe
         ApYnfCf9vRtaWkaKIPT/hudBxKQT4wqBXPh+A52TBGMmEOsjrRZZAEdngvpMN51BTOdH
         andilDKbofX1W4frubBk248bXEPkzMOPzKbwmzmPtosgi6z2r9Dzr4Rz9LEmJrHpjLOs
         g3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OWuOwB9+3ReWFmXmxu1N4MeM5oSPex95DxxWguwHB7c=;
        b=XtIE1z+CjxsN4WCZSULTtT8Bb7XGhVieSbXyyD5sIAlxdWlBMzmPOsMikYwongNTw1
         foN7YLUUyGIaCiPXQr0/ViNz2cDZcx1xjTDP2T5Yk9HHBhwA4bo1jYRK8RzLsExQjN6m
         zh6Ob522uadPpoAjszIkz4/QmQ5lleS9C5XtwElOFVj7V4q3haNfsUSWebRU3+tLhMHd
         M+sX/3J4fNgQdeKwf6IOLx74s0AJh3sGgJ4in5WhhQfQ24Gl3n15VQhFBo3BjGAyVhrn
         gal8rI/54VZ5QBrp8dtIRRONFY8PXfJweRytfX+DSGJmwD4Feu/uIp1ZLpu/1orQES06
         eKIw==
X-Gm-Message-State: AOAM532cgxImPb9Sv/AyFNIVHUNUDnuE7tE/OoxBtMS0H31JLyHDK6g7
        BvvBs03nzW+y3VMrQMbMIgSRmw==
X-Google-Smtp-Source: ABdhPJyjFvSD33XX8uXpG9umGvJ3aF06Kn/mxJBHMyKHCqFkj2gAayfXdRo6pTZDiUht2NtAR56/Rw==
X-Received: by 2002:a62:92cc:0:b029:1fa:515d:808f with SMTP id o195-20020a6292cc0000b02901fa515d808fmr22782914pfd.43.1616983198524;
        Sun, 28 Mar 2021 18:59:58 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id w37sm14728027pgl.13.2021.03.28.18.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 18:59:58 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] dt-bindings: mmc: Add Pensando Elba SoC binding
Date:   Sun, 28 Mar 2021 18:59:34 -0700
Message-Id: <20210329015938.20316-10-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329015938.20316-1-brad@pensando.io>
References: <20210329015938.20316-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Pensando Elba ARM 64-bit SoC is integrated with this IP

Signed-off-by: Brad Larson <brad@pensando.io>
---
 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index af7442f73881..3e8eb3254b99 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -18,6 +18,7 @@ properties:
     items:
       - enum:
           - socionext,uniphier-sd4hc
+          - pensando,elba-emmc
       - const: cdns,sd4hc
 
   reg:
-- 
2.17.1

