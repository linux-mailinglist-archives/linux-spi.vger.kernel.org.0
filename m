Return-Path: <linux-spi+bounces-3926-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C08C939627
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jul 2024 00:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FAB1F22618
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCD37FBDD;
	Mon, 22 Jul 2024 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LDhFbtcb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E850A6D
	for <linux-spi@vger.kernel.org>; Mon, 22 Jul 2024 22:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685695; cv=none; b=SXoSsPozaokdRgHeXQjJ4xrcxp/AhP6vgpay0Ie8j1rCs1u4JhftieecIrWQNyFcF+a94TkcErbF0z3jmNFFBsI555ZyoCtnsuLOXNqlPP5LBzgLZurDRqXP02TxSbfyiSVV34nM4En1stikcmlxh4sF+gpkzh4OUSo7PmevTjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685695; c=relaxed/simple;
	bh=g+xF9JlXpviiMNJmjaApOysuZnb3kQE42/SlQHNRfAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRgetcAwIRFmO0cvWoRZYUMTlSHz5ng7fIojgvre0HXZeT/jUK00VUJjvDGDKJU03b/nmb9XA1wXzuu4TQ2eDoyKwuGkS/XK8f4kT2MwHGrr3ngV5PV39QyXKqh6yVvnp2qX/XErmXFsNQmzNpnHlly8GLcK95w4I4/yyupX0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LDhFbtcb; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70445bb3811so2236435a34.1
        for <linux-spi@vger.kernel.org>; Mon, 22 Jul 2024 15:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721685690; x=1722290490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jiC0bL0wy9+AlsO7Q0mhlDRo68Cb9JVUn8nn5AwBW8=;
        b=LDhFbtcbgALgFGlMfZjjOK8pY/dai09kwgByRoj9kjRG7x0h0cNCS437oImM2aA6Mq
         rcjLJZLiGwNNzIaMI1nul4Pd2ggC2PJbCM/YKdGg//jxYiEIJfPFEcCMOzTGiu3FDMfV
         cVeYH4jO7Ej4e776hHVbRJb+VCRriGfON29oPD/KwtPEgtgjzXdvGnWQ2NOToyqGH9Ip
         fllOo0je5d0JQ30A0hWV+ffjLUEgJSNdYymUsV83rz+3xYzGfvwQ6d3pynbxbifn9fdC
         GruBzpBgE4Y7Uv9Uj8KgEYTrx1OdSO1gKC3MwF+kHiJPcRawZWZubayUNtdKKCskuXM4
         lM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685690; x=1722290490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jiC0bL0wy9+AlsO7Q0mhlDRo68Cb9JVUn8nn5AwBW8=;
        b=Waxdq6DHxISnsgG5glKmJcjEbe4tLQOurbGhIGSswgXtVu6/F5JE8itNtybo+SeIVQ
         Gls+fiNS7xSOEGCfF+udur/ubQ4XPeOQDAYfKkxEq6fGl35MukvEiiluJtVpawznn+/B
         l2DSi218ROXh/3k0iflnZCwW1tzLk7tmLCkWqnxqv5a8ZXZo15pQFC37zrvsRlVBuUy6
         LGGtAIctRbPZGbZU/IbUrfl0y3xvu4dMTFhKmKKLL+bg0mR3xLBCiMJpU/X9ZhU8MnpJ
         vFr4r1kntewpg4N6IXx35YvdIkzqRWtiOPbB2ZVF9ly5zrEZPbPuycKRjE6GTNQsJAxY
         VWtg==
X-Forwarded-Encrypted: i=1; AJvYcCW+LuNz+Cw0H/1VYq+0AGL/fJF1JNERp2IV+54OCAVjCN2mX0wxBC4zUFcCnNafw6PzLbzHUh4qkAjNigI/BCxBMBvy/dkJB5C3
X-Gm-Message-State: AOJu0Ywx6gBhDlIAyUso/5SZYNJFcYQHPxMK3kHoMt31or0zMzVsKpr6
	e80i8JxQ+HztYq/ttMtoqyuwjceWx5QKb1uskzSktgXmdDQ45/PXvWaCVG0cIQ8=
X-Google-Smtp-Source: AGHT+IGs64wd91EwVV4Q/LZEgMoFqhXFy69BoOg7X1dR3lfIoah1e8xmfwOiIrdKEkWIZnK/5Kjetg==
X-Received: by 2002:a05:6830:388d:b0:703:6477:460a with SMTP id 46e09a7af769-709009cd848mr6822618a34.29.1721685690446;
        Mon, 22 Jul 2024 15:01:30 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708f60a55e1sm1719911a34.11.2024.07.22.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:01:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH RFC v3 5/9] spi: dt-bindings: axi-spi-engine: document spi-offloads
Date: Mon, 22 Jul 2024 16:57:12 -0500
Message-ID: <20240722-dlech-mainline-spi-engine-offload-2-v3-5-7420e45df69b@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
References: <20240722-dlech-mainline-spi-engine-offload-2-v3-0-7420e45df69b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

The AXI SPI Engine has support for hardware offloading capabilities.
There can be up to 32 offload instances per SPI controller, so the
bindings limit the value accordingly.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

RFC: I have a few questions about this one...

1.  The trigger-source properties are borrowed from the leds bindings.
    Do we want to promote this to a generic binding that can be used by
    any type of device?

2.  Some folks are working on adding DMA to TX stream support to the
    AXI SPI Engine hardware. I assume that the `dmas` property is like
    others where the order/index in the phandle array matters. So this
    would mean that for device that only uses 1 out of the 32 offloads
    and only uses 1 TX DMA channel, we would have to have 32 <0>s for
    each of the possible RX dmas in the array. Any way to do some kind
    of mapping to avoid this?

3.  In v2, we discussed about having some sort of data processing unit
    between the AXI SPI Engine RX stream interface and the DMA channel
    interface on the DMA controller. I haven't included this in the
    bindings yet because we don't have a user yet. But it was suggested
    that we could use the graph bindings for this. So here is what that
    might look like:

    Additional property for the AXI SPI Engine controller bindings:

        out-ports:
            $ref: /schemas/graph.yaml#/properties/ports
            unevaluatedProperties: false
            patternProperties:
            "^port@1?[0-9a-f]$":
                $ref: /schemas/graph.yaml#/properties/port
                unevaluatedProperties: false

    And this would be connected to a device node similar to this:

        ip-block@3000 {
            // Something similar to, but not exactly like
            // http://analogdevicesinc.github.io/hdl/library/util_extract/index.html
            compatible = "adi,crc-check";
            // clock that runs this IP block
            clocks = <&sysclk 15>;
            // interrupt raised on bad CRC
            interrupts = <&intc 99>;
            interrupt-names = "crc";
            // output stream with CRC byte removed piped to DMA
            dmas = <&adc_dma 0>;
            dma-names = "rx";

            port {
                adc_crc_check: endpoint {
                    remote-endpoint: <&offload0_rx>;
                };
            };
        };

    Does this sound reasonable?

v3 changes:
* Added #spi-offload-cells property.
* Added properties for triggers and RX data stream connected to DMA.

v2 changes:

This is basically a new patch. It partially replaces "dt-bindings: iio:
offload: add binding for PWM/DMA triggered buffer".

The controller no longer has an offloads object node and the
spi-offloads property is now a standard SPI peripheral property.
---
 .../bindings/spi/adi,axi-spi-engine.yaml           | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
index d48faa42d025..ec18eabb993a 100644
--- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
+++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
@@ -41,6 +41,42 @@ properties:
       - const: s_axi_aclk
       - const: spi_clk
 
+  '#spi-offload-cells':
+    description: The cell value is the offload instance number.
+    const: 1
+
+  trigger-sources:
+    description:
+      An array of trigger source phandles for offload instances. The index in
+      the array corresponds to the offload instance number.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  dmas:
+    description:
+      DMA channels connected to the output stream interface of an offload instance.
+    minItems: 1
+    maxItems: 32
+
+  dma-names:
+    minItems: 1
+    maxItems: 32
+    items:
+      pattern: "^offload(?:[12]?[0-9]|3[01])-rx$"
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+    $ref: spi-peripheral-props.yaml
+    additionalProperties: true
+    properties:
+      spi-offloads:
+        description:
+          An array of 1 or more offload instance numbers assigned to this
+          peripheral.
+        items:
+          minimum: 0
+          maximum: 31
+
 required:
   - compatible
   - reg
@@ -59,6 +95,11 @@ examples:
         clocks = <&clkc 15>, <&clkc 15>;
         clock-names = "s_axi_aclk", "spi_clk";
 
+        #spi-offload-cells = <1>;
+        trigger-sources = <&trigger_clock>;
+        dmas = <&dma 0>;
+        dma-names = "offload0-rx";
+
         #address-cells = <1>;
         #size-cells = <0>;
 

-- 
2.43.0


