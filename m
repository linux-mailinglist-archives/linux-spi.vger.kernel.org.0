Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84D7264F81
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 21:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgIJTox (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Sep 2020 15:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731299AbgIJPcj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Sep 2020 11:32:39 -0400
Received: from mail-oi1-x264.google.com (mail-oi1-x264.google.com [IPv6:2607:f8b0:4864:20::264])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED5DC06136B
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2020 08:26:05 -0700 (PDT)
Received: by mail-oi1-x264.google.com with SMTP id x69so6260635oia.8
        for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2020 08:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=N9KMfAmv5gz9m6lApSf8P0rQ6LhDYejBww8cNrHpQok=;
        b=PH7EqfcrI9gbwFUc67/qdfVoPVX/x4PJuxUjvJeXseMzxwVdhBcsyHdWLOP5cGyfx5
         7ZSBopRHdt6dSl26MJHlVEZbcs2PNDaWG3QYJWdgHtTwLu6T/ib8f2QzZMy+M/cSbnFa
         5MjLhstOsdMcqMcTFdZvluz11qF37cAKikXTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N9KMfAmv5gz9m6lApSf8P0rQ6LhDYejBww8cNrHpQok=;
        b=Lvx/MYoAcW4mRYcMGyjOjQi1NlST6ZP2rdRS7sYWNA/JrKfnQFdePmp/79tTbAMoMf
         SNbn0jIxGwchpAMnZIcQt3f0r3wauKobmUvj/Fhdz6mvjg4nAbmevlN6deM6PdRZYaLg
         48LIaV6I3AXq/6lWkqycO5HxHrVi7fy31BdcL7nkMchqqR3GY7WHrw6z4JcFCsNzJmsX
         kTh5GMybjPRT/p1sq+GWAAvV7eo8L1SuBVesn+PUVs/LjyQ7JeNSRXKMr3LbWkuXEvT+
         7wIRS0V9kU/yQX/BITh0XJB5brn6x0GTxW7nG30L0fNCVwSGWRdwyIVA79NTv0JY5FmC
         etQw==
X-Gm-Message-State: AOAM5315JnbIZuo9X/Qyoq2PvOc35cYh71gNyJp0trz/3isylGX8j4vA
        W/WlFhDLcqyHfmH2C31NtfBvht69IrdnWo507lkQCOvrpYo1
X-Google-Smtp-Source: ABdhPJxW+wUZjy6K9BKtFZv7NGBFSRSsF5MWXPbl2+IX73/JOQCBJl9BEXktjrUDKBXePb25dMK3bpyfrhPr
X-Received: by 2002:aca:b454:: with SMTP id d81mr350910oif.150.1599751563367;
        Thu, 10 Sep 2020 08:26:03 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp-relay.gmail.com with ESMTPS id h4sm943004oom.19.2020.09.10.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:26:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From:   Ray Jui <ray.jui@broadcom.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 1/4] dt-bindings: spi: Add compatible string for brcmstb SoCs
Date:   Thu, 10 Sep 2020 08:25:36 -0700
Message-Id: <20200910152539.45584-1-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add compatible string for brcmstb 7445 SoCs.

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
index f5e518d099f2..9d4d5d866fa0 100644
--- a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
@@ -32,6 +32,8 @@ Required properties:
     			     			  			    BRCMSTB  SoCs
     "brcm,spi-bcm7435-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
     			     			  			    BRCMSTB  SoCs
+    "brcm,spi-bcm7445-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
+                                                                            BRCMSTB  SoCs
     "brcm,spi-bcm7216-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
     			     			  			    BRCMSTB  SoCs
     "brcm,spi-bcm7278-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
-- 
2.17.1

