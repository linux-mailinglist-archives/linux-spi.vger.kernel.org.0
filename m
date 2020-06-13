Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F0B1F84A2
	for <lists+linux-spi@lfdr.de>; Sat, 13 Jun 2020 20:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgFMSkw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 13 Jun 2020 14:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgFMSkw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 13 Jun 2020 14:40:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D01C03E96F
        for <linux-spi@vger.kernel.org>; Sat, 13 Jun 2020 11:40:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a26so2803088lfj.13
        for <linux-spi@vger.kernel.org>; Sat, 13 Jun 2020 11:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ioFOqkA4a9a6fr9aGiz3zoxmx46SUsrv5GXgVDo4ss=;
        b=AiRqStl64KJspJSsGdLeJ+CRipTU5MqMyxGmA7ZYRDsduWAhyz+K4Mp12yzYrW3h2Z
         kQrrSw8F36967ah7xyOErSO7C0FOe86MFfKr60ZjRX6s5EGEWBlZXQ79EY7fmj49DZ8b
         sFuWyeA+ajOyXWhp+dnjgLWr1Jwd4XFfk7VcTnfJt4yvSpMVXhNMdc7vzElaNQcHuFfF
         Yt0Jku2WBGZhPCOBWTmn7IgzLEWLn0VHKHj63Kmm0EhNDv+aFR9wyuPPBweXP5d2Riuv
         Oh1caPbdYCe5vJ1SQuUfzgGCTeC89Lr+0VZdhFc+KKf5sgqNsZZTK/V3alHABWFs5HZ/
         k/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2ioFOqkA4a9a6fr9aGiz3zoxmx46SUsrv5GXgVDo4ss=;
        b=Osftag8n5qSlwXSxngNafwrTx7rVnNDqu6T/66zgsz0UzWpVGttil17g3HoANDKDlp
         Sfo/5+IybK568dJUs0K4IzNalkAFW8IlD9Reof0qIi0YCa5YMULYZ7FgAffUvvnpLNL3
         xMIgVaDnl+IrpAlurOAYzMOQPLV/OKaISP6xDIVvb0XJLNr+wj2Lr8yAjCTRgbEGg9+o
         OAMYAOC0irPdcGcSMMaSiD/m/r1j/WJ4HadyFtHRFkXynSBkRahXQIGhVa1rCs0D9XZC
         6pg8SaFCdkMWyhx1rOhdFx4Lyfs2QMSDPZnG9cLu1MjHtAONa6DSbVUS0LwnRI8+1ZsC
         1JWg==
X-Gm-Message-State: AOAM531CDPG6A7xswfG0pqc6IC7U1HSs2cZeu+umpKG2SzW29zRydG9/
        94V3TVlYQHGMlUkm5Nf43VZtYA==
X-Google-Smtp-Source: ABdhPJyrG3RYdz2pYb8REdSpMtdT/bq1MHQ9n1xyhXYwIOLmAlDW70L8HixuJJw72laZSgiJcU939g==
X-Received: by 2002:ac2:511d:: with SMTP id q29mr9755341lfb.24.1592073650300;
        Sat, 13 Jun 2020 11:40:50 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:2e2:84d1:c335:1451:e577:e115])
        by smtp.gmail.com with ESMTPSA id v23sm2763684ljg.122.2020.06.13.11.40.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jun 2020 11:40:49 -0700 (PDT)
Subject: [PATCH v4 1/2] dt-bindings: memory: document Renesas RPC-IF bindings
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org
References: <721e5306-6dc5-4a3a-2bbb-459be6261357@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <4becbd3b-c9b9-070a-5771-48cade6651e5@cogentembedded.com>
Date:   Sat, 13 Jun 2020 21:40:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <721e5306-6dc5-4a3a-2bbb-459be6261357@cogentembedded.com>
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
Changes in version 4:
- added the SoC name comments to the RPC-IF's "compatible" prop description;
- removed a hyphen before 'enum' in the subnode description;
- removed leading 0s in the "reg" prop in the example.

Changes in version 3:
- fixed up the whitespace and added hyphens in the "compatible" prop text, also
  removed the comments;
- specified the subnode name as "flash", and used "enum" in the subnode text; 
- fixed up the SPDX-License-Identifier: tag.

Changes in version 2:
- rewrote the bindings in YAML.

 Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml |   87 ++++++++++
 1 file changed, 87 insertions(+)

Index: linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
===================================================================
--- /dev/null
+++ linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+        - renesas,r8a77980-rpc-if       # R-Car V3H
+        - renesas,r8a77995-rpc-if       # R-Car D3
+      - const: renesas,rcar-gen3-rpc-if # a generic R-Car gen3 device
+
+  reg:
+    items:
+      - description: RPC-IF registers
+      - description: direct mapping read mode area
+      - description: write buffer area
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
+  "flash@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        enum:
+          - cfi-flash
+          - jedec,spi-nor
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas-cpg-mssr.h>
+    #include <dt-bindings/power/r8a77995-sysc.h>
+
+    spi@ee200000 {
+      compatible = "renesas,r8a77995-rpc-if", "renesas,rcar-gen3-rpc-if";
+      reg = <0xee200000 0x200>,
+            <0x08000000 0x4000000>,
+            <0xee208000 0x100>;
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


