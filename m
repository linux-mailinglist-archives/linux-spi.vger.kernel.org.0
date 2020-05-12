Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659871CFFBC
	for <lists+linux-spi@lfdr.de>; Tue, 12 May 2020 22:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbgELUpu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 May 2020 16:45:50 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33714 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbgELUpt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 May 2020 16:45:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id v17so3720943ote.0;
        Tue, 12 May 2020 13:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ROTQQRmdcUsStwRKkfy6Q00GnOxE+nfhmcwjzr4lDeg=;
        b=PSfQn1GsFdfwL/0nn8vxHeBKvMQ2Sbs53Kqok4p4VuaafUo2CxSrYLCC2INpmcfR1t
         lTMkZ/N99N52YFqDI/tVs5RA9CsTkAw9K0s8cF9pWIxutO4f+1+y2rOad/C2BfKgIE9h
         Afkpjj7z3OJDxWNeEKAWuJ8gIKQ+6nbhJ8EYB9xB8AIXLMfc1ju3DDDAgw6oS9RpGRkf
         MjlL6rBrtU7yffupoMNs232Mdg6wArVkAIZcB2wmvvt05C1NPbvaA8f6shdw+Mdo+pnE
         LtdLjOxJ3dGdNJlyyx+h6c5g2cLnrEdvHM52uY+Md59YvKBS4tXCGyvqx8eyiQfDx66O
         dCCg==
X-Gm-Message-State: AGi0PuaOtEd62yIgJPmLYBx6t7wgshDDkoRY1gbGVVXPHgBJE5anw4Mk
        w2w3t9yFqAwivQuqhBURKTj6V2k=
X-Google-Smtp-Source: APiQypJ1PDF2eDVooFvjNgsHr+joxMhIx8+O1j7KXhZ9mhhvKW9kguaFARgq2V5ZkR7s7mNGKgdPkg==
X-Received: by 2002:a05:6830:1241:: with SMTP id s1mr18607355otp.119.1589316348414;
        Tue, 12 May 2020 13:45:48 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k8sm3943792ood.24.2020.05.12.13.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 13:45:48 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 4/5] dt-bindings: ufs: ti: Add missing 'additionalProperties: false'
Date:   Tue, 12 May 2020 15:45:42 -0500
Message-Id: <20200512204543.22090-4-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512204543.22090-1-robh@kernel.org>
References: <20200512204543.22090-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The ti,j721e-ufs schema is missing an 'additionalProperties: false'. Add
that and and the missing assigned-clock properties.

Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
index b503b1a918a5..4d13e6bc1c50 100644
--- a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
@@ -25,6 +25,12 @@ properties:
   power-domains:
     maxItems: 1
 
+  assigned-clocks:
+    maxItems: 1
+
+  assigned-clock-parents:
+    maxItems: 1
+
   "#address-cells":
     const: 2
 
@@ -47,6 +53,8 @@ patternProperties:
       Documentation/devicetree/bindings/ufs/cdns,ufshc.txt for binding
       documentation of child node
 
+additionalProperties: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.20.1

