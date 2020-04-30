Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5141C0884
	for <lists+linux-spi@lfdr.de>; Thu, 30 Apr 2020 22:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgD3Urb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Apr 2020 16:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgD3Urb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Apr 2020 16:47:31 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA9BC035495
        for <linux-spi@vger.kernel.org>; Thu, 30 Apr 2020 13:47:29 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y4so788431ljn.7
        for <linux-spi@vger.kernel.org>; Thu, 30 Apr 2020 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UjhaXYLb6et/pS+z2+6lWawVjIKe1ZbJB18SGIv2Zig=;
        b=pt1YMpbidL1Z1ozdpkX8BKrlWsJSeJ2uJkMUXSNQuVgDZkj/5an+ZHfkaziEH1iDPE
         hjhzvWNJNpVDFu2ZQPDqBu83kb7sI1yWqGNFc/55HZkT9E9zAHFclWy9bawyYUrBeb1T
         SMXxTcOjdRS8mMA5MOoEZnthPHvEQxZHQY+fx+Gtc7PKASP5GM41cFxI8kmwv3btzobj
         wJ9K68W93ldv1zA0IghkSmz9iSZ+UTBeKJugdDzn3/e0WnJ8b4GrP8+1VPXXDt35PetK
         nnF8eiCDr3vJWit5nbowIftHDRoSEbqtF+UcTOW3Ec2j+GGk5HqbZEOGrPTp50JHKUKH
         fApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UjhaXYLb6et/pS+z2+6lWawVjIKe1ZbJB18SGIv2Zig=;
        b=XGJ2h7v4fnX4XiIDjWOjAKnpnIIsCyQthoiISZZP3HzqfmgKUVp3qBmNX/qak+GxUz
         aCLVS4whlOPUEn4xx9dKmg45u9iLyESRKb65HOxyW31USWVdNPEd5maeGPLTUgRw7+d2
         PK1WAwOLDVs0DolJF6r8JLP60fVAH5kGbvJXtFwEsy9JyeBn/eM5C4avEjEdCPkuFBRI
         xHmg09SEqsGZd2uStjnNJ3apT2rs9+e91rArzyQzcTm9CpKI5N/rftYmPS4WY8ruKR5B
         i3sFK41iPaA58OEX/27LdNp1l0TlW6KTR5POdmgdC3wzH/xBldIubiJS1bIOj0V3fW/f
         GebA==
X-Gm-Message-State: AGi0PuZ++TyOqCsqUZXzn1IHOaNCjpLyQICWiVCZvF28SZ8zc98e4cL9
        M/9dyN+y/q6YbmVr5YC9jYpoeCZ8LE8=
X-Google-Smtp-Source: APiQypJCP49xxKtW5b689TlF/50skrJuIJ0JZ3e/wPMGDzIgLXa3cnRumRDSWkFcln5U2yB/3LulXw==
X-Received: by 2002:a2e:9785:: with SMTP id y5mr416401lji.66.1588279647576;
        Thu, 30 Apr 2020 13:47:27 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:880:89c5:86ed:91e3:4d28:af08])
        by smtp.gmail.com with ESMTPSA id t8sm640060lfe.25.2020.04.30.13.47.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 13:47:26 -0700 (PDT)
Subject: [PATCH v2 1/2] dt-bindings: memory: document Renesas RPC-IF bindings
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-mtd@lists.infradead.org
References: <812e6e58-d13f-3f44-5f55-22266b690c57@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <116683d1-d402-4d7f-3357-1c8cde807076@cogentembedded.com>
Date:   Thu, 30 Apr 2020 23:47:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <812e6e58-d13f-3f44-5f55-22266b690c57@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Renesas Reduced Pin Count Interface (RPC-IF) allows a SPI flash or
HyperFlash connected to the SoC to be accessed via the external address
space read mode or the manual mode.

Document the device tree bindings for the Renesas RPC-IF found in the R-Car
gen3 SoCs.

Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- rewrote the bindings in YAML.

 Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml |   88 ++++++++++
 1 file changed, 88 insertions(+)

Index: linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
===================================================================
--- /dev/null
+++ linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/renesas,rpc-if.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas Reduced Pin Count Interface (RPC-IF)
+
+maintainers:
+  - Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
+
+description: |
+  Renesas RPC-IF allows a SPI flash or HyperFlash connected to the SoC to
+  be accessed via the external address space read mode or the manual mode.
+
+  The flash chip itself should be represented by a subnode of the RPC-IF node.
+  The flash interface is selected based on the "compatible" property of this
+  subnode:
+  - if it contains "jedec,spi-nor", then SPI is used;
+  - if it contains "cfi-flash", then HyperFlash is used.
+
+allOf:
+  - $ref: "/schemas/spi/spi-controller.yaml#"
+
+properties:
+  compatible:
+    items:
+      - enum:
+        renesas,r8a77980-rpc-if # device is a part of R8A77980 SoC
+	renesas,r8a77995-rpc-if # device is a part of R8A77995 SoC
+      - enum:
+        renesas,rcar-gen3-rpc-if # a generic R-Car gen3 device
+
+  reg:
+    items:
+       - description: RPC-IF registers
+       - description: direct mapping read mode area
+       - description: write buffer area
+
+  reg-names:
+    items:
+      - const: regs
+      - const: dirmap
+      - const: wbuf
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        oneOf:
+          - const: cfi-flash
+          - const: jedec,spi-nor
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas-cpg-mssr.h>
+    #include <dt-bindings/power/r8a77995-sysc.h>
+
+    spi@ee200000 {
+      compatible = "renesas,r8a77995-rpc-if", "renesas,rcar-gen3-rpc-if";
+      reg = <0 0xee200000 0 0x200>,
+            <0 0x08000000 0 0x4000000>,
+            <0 0xee208000 0 0x100>;
+      reg-names = "regs", "dirmap", "wbuf";
+      clocks = <&cpg CPG_MOD 917>;
+      power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+      resets = <&cpg 917>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      flash@0 {
+        compatible = "jedec,spi-nor";
+        reg = <0>;
+        spi-max-frequency = <40000000>;
+        spi-tx-bus-width = <1>;
+        spi-rx-bus-width = <1>;
+      };
+    };
