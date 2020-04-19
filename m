Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2D51AFD66
	for <lists+linux-spi@lfdr.de>; Sun, 19 Apr 2020 21:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgDST0W (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Apr 2020 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgDST0W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Apr 2020 15:26:22 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F65C061A0C;
        Sun, 19 Apr 2020 12:26:22 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t9so1465168pjw.0;
        Sun, 19 Apr 2020 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xzp810wwKqNPBd/XxF90MmmQUKarKbudjOQw99K54mY=;
        b=uU1/h+e4Tu8GhOJrjhNVK3l6jI6c5OxQX5WtPck6Ir8Cxe1/OjaiqVHA5DIpFxkoPz
         6lzQhMq3YiElde2rzHAHgsDhfhLoOg/ytrNerf6bGLeHAR0OvYt0BSk1h/5khqiAWzyB
         IMAiDTc51ZCC8q7IP1spHcwD1CPpO02Yks1/vpgTuYjT6SclFmSIiFnlPw/pUXxG9p4Z
         tykP160OKtbUozQbGIbqY7TZPQ7Mg+9qv8WU5z/M65N3sx29NQBVlE7JRT99Cu3j2UQb
         iByB35zXi8gvtTdEPOuN4EHVe1aECzhuYI/aBGXTz+M/3DqzQET8F+OkQmRYqfFQtOvy
         kXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xzp810wwKqNPBd/XxF90MmmQUKarKbudjOQw99K54mY=;
        b=bn2Z3CUNI1P7492hfKLrJX0Ys/zt6PeX3KG/LoXH99YxNFw4pR7UaEISNyHOqKKh9y
         IBY6NTz9QPi+W6InQDv+Paq2ZpSJkYdRSmXyC266qVySoybCIFoLAkrZ62/gTuIUIPHa
         ihgdnWR3+51oVzH9zbASaEWHAejjFXZ0HV9dI96iVCvU6dF7RQnQVe+v4L3CWJLR7efv
         j0fI9L3idObR2pROKKO4XACt+RjhR5ejNzG2HtrnFZ7hLW9ojhhQnjTB/fgryQblbdvb
         Ag9QmKjFNnC0A2MEWjIUEycGmoLYyl7cW7eAh3HGgBlEJ07DTX34o9SOTLcdymlPwxeA
         UMeg==
X-Gm-Message-State: AGi0PubwUA+fHSqE6Dw6+nv4FwN9RlDRcOeh12nhcNUWXExT1PL5K+UL
        qECYenGiQ4r0g9zULV4npuI=
X-Google-Smtp-Source: APiQypLCj5swmAT59SvYzUJwoG8kioFRnbEIXH/0sE49tFuKvUVTUzyeiHx8m93ZfwccNIibVBGOXQ==
X-Received: by 2002:a17:90a:2b8f:: with SMTP id u15mr18131941pjd.137.1587324381718;
        Sun, 19 Apr 2020 12:26:21 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id x16sm22724383pfm.146.2020.04.19.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:26:21 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v2 2/9] dt: bindings: spi: Add support for mspi on brcmstb SoCs
Date:   Sun, 19 Apr 2020 15:23:31 -0400
Message-Id: <20200419192339.32023-3-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200419192339.32023-1-kdasu.kdev@gmail.com>
References: <20200419192339.32023-1-kdasu.kdev@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Added documentation for compatibility for brcmstb SoCs :
7425, 7429, 7435, 7216, 7278

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 .../devicetree/bindings/spi/brcm,spi-bcm-qspi.txt      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
index ad7ac80a3841..f5e518d099f2 100644
--- a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.txt
@@ -26,6 +26,16 @@ Required properties:
     "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-qspi" : MSPI+BSPI on BRCMSTB SoCs
     "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
 						   BRCMSTB  SoCs
+    "brcm,spi-bcm7425-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
+    			     			  			    BRCMSTB  SoCs
+    "brcm,spi-bcm7429-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
+    			     			  			    BRCMSTB  SoCs
+    "brcm,spi-bcm7435-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
+    			     			  			    BRCMSTB  SoCs
+    "brcm,spi-bcm7216-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
+    			     			  			    BRCMSTB  SoCs
+    "brcm,spi-bcm7278-qspi", "brcm,spi-bcm-qspi", "brcm,spi-brcmstb-mspi" : Second Instance of MSPI
+    			     			  			    BRCMSTB  SoCs
     "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi"     : MSPI+BSPI on Cygnus, NSP
     "brcm,spi-bcm-qspi", "brcm,spi-ns2-qspi"     : NS2 SoCs
 
-- 
2.17.1

