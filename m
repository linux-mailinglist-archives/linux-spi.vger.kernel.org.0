Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0200A1CFFC5
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 22:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgELUps (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 16:45:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33713 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731148AbgELUpr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 16:45:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id v17so3720863ote.0;
        Tue, 12 May 2020 13:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJvdTJ4jQBHWyFFbREMP+Lv+gPEpGjqcWga31H9+mpg=;
        b=ImCxQMsxnureHe5CwGf5mpPuX9v/ZN5Bqv3eeqwFoPBnu0LSiaKCy7pQnT8XipM6H+
         xfmikl4kYD2B5hcStuAVKT+eupiXGNj73xQu+dlJzYPlGTLkfG19a9ZG+EAVto3dj++w
         ZGf2lpZ6cilWlRX0hUBi1egPmneq38ZwsXrT8MeJDn4uH/aQIzUwwgI/OR7dSQnfdB5T
         i/95SG62mNPz9sq4WEGdagI+j7PmMpwUIKPLMAD9IRWOovFfp56/aqMKsqSD5i9ZM4BC
         wfyltEfG/lTBgyx16jg9k1zWHba/a4GLnXCvlQvw1jww8ckKqpnJMR5QzLsg/0nlcJoL
         DjLg==
X-Gm-Message-State: AGi0PuZGomrNbggTaSX9Ei/pA0eC6WoDA/Lj5dO2BPbVimBuod7V7JQV
        yyNrQTMFZwehQP2fxm7yu1nmh9g=
X-Google-Smtp-Source: APiQypJ8NoEp+WU4AqvLu3ChtOsWB5L3IyPkRqNshS1uxkH//6r9AWldVT02FIkl3//22JLPnrv+fQ==
X-Received: by 2002:a9d:6151:: with SMTP id c17mr5223055otk.219.1589316345959;
        Tue, 12 May 2020 13:45:45 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k8sm3943792ood.24.2020.05.12.13.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 13:45:45 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/5] dt-bindings: usb: ehci: Add missing 2nd register region
Date:   Tue, 12 May 2020 15:45:40 -0500
Message-Id: <20200512204543.22090-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512204543.22090-1-robh@kernel.org>
References: <20200512204543.22090-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The 'ibm,usb-ehci-440epx' compatible has a 2nd 'reg' region, but the
schema says there is only 1 region. Fix this.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack, dependency for patch 5.

 .../devicetree/bindings/usb/generic-ehci.yaml | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 848eea59bc00..37a818d72a74 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -6,19 +6,30 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: USB EHCI Controller Device Tree Bindings
 
-allOf:
-  - $ref: "usb-hcd.yaml"
-
 maintainers:
   - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 
+allOf:
+  - $ref: "usb-hcd.yaml"
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: ibm,usb-ehci-440epx
+    then:
+      properties:
+        reg:
+          maxItems: 1
+
 properties:
   compatible:
     contains:
       const: generic-ehci
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
-- 
2.20.1

