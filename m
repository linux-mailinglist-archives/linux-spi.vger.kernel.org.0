Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4447C1ACEEA
	for <lists+linux-spi@lfdr.de>; Thu, 16 Apr 2020 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgDPRna (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Apr 2020 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbgDPRn3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Apr 2020 13:43:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1BCC061A0C;
        Thu, 16 Apr 2020 10:43:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z6so5891483wml.2;
        Thu, 16 Apr 2020 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xzp810wwKqNPBd/XxF90MmmQUKarKbudjOQw99K54mY=;
        b=DKwO1bPFHPvvMFBTU8JvDGcfCggBHgUUGQDZwQy69Cv/VWAvOlkUf5f/VQcSPF/7CV
         EfIu2+DIDl2+/d8XJ1jpDlGogvP2xB/uuZDeZWfiWcgT2f1f6CPlbGQdf0UnSwKwpU/z
         01ATQJUMEj5BPflvnI38K/PcvJlnOPBCz11BfJps86tdwzKCAxYzNVkzlWcYRm+3SeZl
         ovLOUhEq/EoGlNE+3e/EvY1GFtnC222PY/Pg1LrtB4m1rMWmb9cUORGpxTuoN75OEN6w
         aRsPaPXHQKsjekkFjtdgmQLPT6F1IPAD3676XP952lo9O6Gm0BkIrKouGIYTqoKuIeOA
         s5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xzp810wwKqNPBd/XxF90MmmQUKarKbudjOQw99K54mY=;
        b=HY1Ka9Q43Xxy3q9znLNmILfNtXLQdK4+hi+u9H5N3/FBUNeA55yz+dgG8egebmjF/U
         pAVBNEYAviaaND3LhGPCEqexfFyuK4y9tM42zpzEYSIHt5Uc3Vgi9iEodjjLcCTQJWSu
         HmQkqyaJC68sC8il98zn9C/b+0Qmv02thENQv1bd3y48/gwD8KXXO1H3FKea6ZdKYl4J
         TybZ6MFJByLvbtY+9uFqrqYB7IZbL8Pk1AzWNR6ipqUnrYWDbfJ35XiTFGfJA4cF+5RE
         a7D2uIEMHJ/u5tRKgRdVNzn3MGb2JjfPsc1NVcTYpdjUD4g9HafLIvd1/2U0sHRjzNnP
         KykA==
X-Gm-Message-State: AGi0PubkVg1VHTzSLRi2ARL+DO7NCDY0ENItIefwGWIMZcvCnhMXJ3Vd
        CVqz5HKznXDGUplB92wAOgM=
X-Google-Smtp-Source: APiQypK9c36KsWLZ1dqEBikbcbA0aVNuTc/rhtVbF2X+ZIXredLS5QQYBppcegCaUd3dwmxZ6+pR3w==
X-Received: by 2002:a1c:4603:: with SMTP id t3mr5882686wma.103.1587059008176;
        Thu, 16 Apr 2020 10:43:28 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p7sm28736296wrf.31.2020.04.16.10.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:43:27 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch 2/9] dt: bindings: spi: Add support for mspi on brcmstb SoCs
Date:   Thu, 16 Apr 2020 13:43:02 -0400
Message-Id: <20200416174309.34044-2-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416174309.34044-1-kdasu.kdev@gmail.com>
References: <20200416174309.34044-1-kdasu.kdev@gmail.com>
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

