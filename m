Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA761190D3
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 20:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLJThi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 14:37:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43473 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfLJThi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 14:37:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id 9so14681083lfq.10
        for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2019 11:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iVJKBlhEYT6S4kQZRu/hdIVpnnDPFI8gf9sf12wfx90=;
        b=CNMRtLPlIp77f0IVCJYc6IX1Y09b5Wqnv9CF96KD6ytBL4eDUSJ80kH1zFvGs0aGpB
         SkmFjdxaicjcndoWwMrAm3tQ5Vw4g1iE/Pe7QQ5xWiwGDSGnJRJHjD4QHxyhTfGIdhj3
         4ueE3qEswRNpoLloqIKeAKd6Sw4d8+IC3pPHu+5zgVcw9k8z0biTS6cvB6pjcSYuoqyG
         6RmjKc+jctS4BGy769thvk+IfJabmbWSzKC8OK5lnqhP6prbF2PTR8w1m3rWL6Rp05Fm
         2TUqqdigReR2A4kQ3NbA/klRYOF+v62hjosjyK32VddWLcz5+VcfGE1z2OQji383Hm6S
         rzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iVJKBlhEYT6S4kQZRu/hdIVpnnDPFI8gf9sf12wfx90=;
        b=mIifHmH5oBNnK7McMY4lUm0qEVkfg4G3NoUXzDPeQTkO7phc0TGYx/t8FW0F5ZZsBZ
         VsMM8TKmShBkGhekuXKvWg5yYiz/TFK21hxOXmdE9VEqZkwRh4QsvBm8K/Hp+4LEIxvB
         1hJEzxpX3fAov2DzRFC+/9jE5HoQFvgql11NomARnjKVGSmgMeBPtQWd3UGZroNXnoX8
         htNedvYJ28iXoIrvdorzJVZI/7R2EVVNDzAC1eFOa0FvKxpApW9xppk76ySh5ihC2bPc
         2cedKBlwO4cJscTmNpWpOynTy9JNZFzm0ZmXhqg67g/tJyyYu2M1Qmkxg5eNx1HtU3UG
         Bo+Q==
X-Gm-Message-State: APjAAAV2lH9H3QQezllpuwmXd71AyqiltTYEukda/tvOTkm/By8z+hwa
        Lo2LK98JXTDSfMQyFcfrhAUt+g==
X-Google-Smtp-Source: APXvYqwYZYNq7GNw2QOsd8P7bDup+PoLnIVJpWUvM2k28qn2ZLKHEDQXTHn7SBLoQSvanHoE22KBmw==
X-Received: by 2002:ac2:5dc7:: with SMTP id x7mr20113199lfq.24.1576006656477;
        Tue, 10 Dec 2019 11:37:36 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:88a:ffe6:e26c:e506:75a0:c93a])
        by smtp.gmail.com with ESMTPSA id y29sm2311376ljd.88.2019.12.10.11.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 11:37:35 -0800 (PST)
Subject: [PATCH RFC 1/2] dt-bindings: memory: document Renesas RPC-IF bindings
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>,
        linux-spi@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
References: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <bd2c82fa-b0f0-9274-8c69-d13f7cddefc5@cogentembedded.com>
Date:   Tue, 10 Dec 2019 22:37:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <cb7022c9-0059-4eb2-7910-aab42124fa1c@cogentembedded.com>
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
 Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.txt |   52 ++++++++++
 1 file changed, 52 insertions(+)

Index: linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.txt
===================================================================
--- /dev/null
+++ linux/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.txt
@@ -0,0 +1,52 @@
+Renesas Reduced Pin Count Interface (RPC-IF)
+--------------------------------------------
+
+Renesas RPC-IF allows a SPI flash or HyperFlash connected to the SoC to
+be accessed via the external address space read mode or the manual mode.
+
+Required properties:
+- compatible: should be an SoC-specific compatible value, followed by
+		"renesas,rcar-gen3-rpc-if" as a fallback.
+		supported SoC-specific values are:
+		"renesas,r8a77980-rpc-if" (R-Car V3H),
+		"renesas,r8a77995-rpc-if" (R-Car D3).
+- reg: should list 3 register areas:
+	1st for the RPC-IF registers,
+	2nd for the direct mapping read mode,
+	3rd for the write buffer area.
+- reg-names: should contain "regs", "dirmap", and "wbuf".
+- clocks: should contain the clock phandle/specifier pair for the module clock.
+- power-domains: should contain the power domain phandle/specifier pair.
+- resets: should contain the reset controller phandle/specifier pair.
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+
+The flash chip itself should be represented by a subnode of the RPC-IF node.
+The flash interface is selected based on the "compatible" property of this
+subnode:
+- if it contains "jedec,spi-nor", then SPI is used;
+- if it contains "cfi-flash", then HyperFlash is used.
+
+Example:
+
+	rpc: spi@ee200000 {
+		compatible = "renesas,r8a77995-rpc-if",
+			     "renesas,rcar-gen3-rpc-if";
+		reg = <0 0xee200000 0 0x200>,
+		      <0 0x08000000 0 0x4000000>,
+		      <0 0xee208000 0 0x100>;
+		reg-names = "regs", "dirmap", "wbuf";
+		clocks = <&cpg CPG_MOD 917>;
+		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <40000000>;
+			spi-tx-bus-width = <1>;
+			spi-rx-bus-width = <1>;
+		};
+	};
