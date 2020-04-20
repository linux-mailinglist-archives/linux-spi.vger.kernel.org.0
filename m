Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0C51B1574
	for <lists+linux-spi@lfdr.de>; Mon, 20 Apr 2020 21:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgDTTJZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Apr 2020 15:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbgDTTJY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Apr 2020 15:09:24 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE39FC061A0C;
        Mon, 20 Apr 2020 12:09:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u16so792352wmc.5;
        Mon, 20 Apr 2020 12:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xzp810wwKqNPBd/XxF90MmmQUKarKbudjOQw99K54mY=;
        b=BKpBsOGSqwxLY0UVfFz6Sdzm+xjAmeskTWN4tZ7/S32XXeZC2UZPErViOuz4TLjbq+
         xAeg4mHVTB4DQA+90ov65a/NkVPlHyTK5VSRQGCq33/j/GPZAi6r5uZZLLIl2qmMnvfy
         rH9QZm+UowErjy7A8tuXbXbQfMeOL+QgvrntatJJ3P0k7Z5leTGr5ci8g31uHKgDrhmt
         wyJF6URFCNpr02vTIN1iluN+Pj55gd7KYJoSoQCzRbqC+ZALdnyovCiBMeEOYX9JXX3X
         DMpueO21D3K45Qbi/vPjN8urI9L+bX1PKD4Pw3vkIMhUxyonbodwDzItkxNXFU0Y5enu
         aiaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xzp810wwKqNPBd/XxF90MmmQUKarKbudjOQw99K54mY=;
        b=LkKRLd0Wu1heoJWMM7rBwNphmCVfe66pMR+Kl+DzQeRl0+5qkORfh7/SBGLO1eq13S
         O4tXVjAAnezqcSOOTGpkDHJSflz9zJkwluLOGRmkEnQqcgI6t4yQYGnKDzPkZhiM71mH
         Jf0ouLkVGJSu4sZcKwEFqy3PDTl5vpbIts3Wz/gWWI6YZCrjlEA9ZjEtUQFDCG57j/zR
         OQOBhhOXljHrUWwFfIF/b3prnjeheb0NzX5fp5BxooTUZmRLgyBKH7wNMMf1uRWyzG03
         W8aOry3qeycREZZAj0f7gNTXbG/AAPExyzcswROqpJOjAn3rbCaQKKxXX9JK87uvOC9R
         FJnA==
X-Gm-Message-State: AGi0PubMsaAwB4DJl+ZrtzHt3aVnxY14V3B9H4fz49tHywJ8oscMiJIq
        txiFaLoZAzJMqO1sD0szchs=
X-Google-Smtp-Source: APiQypIV5q8tu2hLBMNlxqmTyYAjVrwlBE5kxU4BRk6MEPWOjbXuLuwk9nFcF8a61yiVBWTjz2jcmA==
X-Received: by 2002:a1c:9891:: with SMTP id a139mr893761wme.129.1587409762792;
        Mon, 20 Apr 2020 12:09:22 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y5sm621251wru.15.2020.04.20.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:09:22 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch v3 2/9] dt: bindings: spi: Add support for mspi on brcmstb SoCs
Date:   Mon, 20 Apr 2020 15:08:46 -0400
Message-Id: <20200420190853.45614-3-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420190853.45614-1-kdasu.kdev@gmail.com>
References: <20200420190853.45614-1-kdasu.kdev@gmail.com>
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

