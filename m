Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF1B223E
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2019 16:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbfIMOg3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Sep 2019 10:36:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37278 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbfIMOg3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Sep 2019 10:36:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id s28so29685626otd.4;
        Fri, 13 Sep 2019 07:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=6mdxbSnWKNEAwVfvLxB2FfniJx8A4oxY0hM22xopaEM=;
        b=SRdh1/SXprYgx6EGtc1mDfIlNaJ7wWNH5Nd11yJyopLIlEZkZfr6NmVrZsMiCSWNl2
         BCfHSdayYALVh1nyU4scC+5qiLzVJESQXmi768vN7idtfbg3vCBaN6OwQBLEHv917iwf
         WSCMBm8Xb33tfb2UkTybNMRBUet59Geoo+OcTZ9u3LPPxQZ/DQGNMKk5XH2J96GbJ2ZJ
         eAWXbwiCGiKSvfT+OdOv9Q7A/8rslMh2OPoupV/pTZ2lGjr4W6V9ag4ZGtMZn72dSNTr
         0LH3PkFhqmb/WNZGPfDK3OwL90lGhBQrkhXmoB34huctGhnrTbgRdg/lKWnIX1FS8jgK
         qfrw==
X-Gm-Message-State: APjAAAXS5wPkR/J3NUsNqbZBtyOuwNAEKGurfmI/BnZrVCh1ENrkvQCT
        bk5Fx5YqVQ37WfZ8vx9Hiw==
X-Google-Smtp-Source: APXvYqzn+6nvNXJy1guR0eNWhQFcmEFwvOR5OJ3M+fz3f5Pzd7rqZacnsC89vhMVWQUfRbYFCcPn+Q==
X-Received: by 2002:a05:6830:2306:: with SMTP id u6mr16025354ote.0.1568385388075;
        Fri, 13 Sep 2019 07:36:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v6sm913853oie.4.2019.09.13.07.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:36:27 -0700 (PDT)
Message-ID: <5d7ba96b.1c69fb81.edf8e.655e@mx.google.com>
Date:   Fri, 13 Sep 2019 15:36:26 +0100
From:   Rob Herring <robh@kernel.org>
To:     Pragnesh Patel <pragnesh.patel@sifive.com>
Cc:     palmer@sifive.com, paul.walmsley@sifive.com,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: Convert spi-sifive binding to
 json-schema
References: <1568098996-4180-1-git-send-email-pragnesh.patel@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568098996-4180-1-git-send-email-pragnesh.patel@sifive.com>
X-Mutt-References: <1568098996-4180-1-git-send-email-pragnesh.patel@sifive.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 10, 2019 at 12:32:51PM +0530, Pragnesh Patel wrote:
> Convert the spi-sifive binding to DT schema format.
> 
> Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
> ---
>  .../devicetree/bindings/spi/spi-sifive.txt         | 37 ----------
>  .../devicetree/bindings/spi/spi-sifive.yaml        | 86 ++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.yaml


> diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.yaml b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
> new file mode 100644
> index 0000000..368f5d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-sifive.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive SPI controller
> +
> +maintainers:
> +  - Pragnesh Patel <pragnesh.patel@sifive.com>
> +  - Paul Walmsley  <paul.walmsley@sifive.com>
> +  - Palmer Dabbelt <palmer@sifive.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sifive,fu540-c000-spi
> +      - const: sifive,spi0
> +
> +    description:
> +      Should be "sifive,<chip>-spi" and "sifive,spi<version>".
> +      Supported compatible strings are -
> +      "sifive,fu540-c000-spi" for the SiFive SPI v0 as integrated
> +      onto the SiFive FU540 chip, and "sifive,spi0" for the SiFive
> +      SPI v0 IP block with no chip integration tweaks.
> +      Please refer to sifive-blocks-ip-versioning.txt for details
> +
> +      SPI RTL that corresponds to the IP block version numbers can be found here -
> +      https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/spi
> +
> +  reg:
> +    maxItems: 1
> +
> +    description:
> +      Physical base address and size of SPI registers map
> +      A second (optional) range can indicate memory mapped flash
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +    description:
> +      Must reference the frequency given to the controller
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

These 2 are covered by spi-controller.yaml, so you can drop them.

> +
> +  sifive,fifo-depth:
> +    description:
> +      Depth of hardware queues; defaults to 8

default: 8

What are valid values?

> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Will need to be under 'allOf' with the above constraints.

> +
> +  sifive,max-bits-per-word:
> +    description:
> +      Maximum bits per word; defaults to 8
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Same comments here.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +examples:
> +  - |
> +    spi: spi@10040000 {
> +      compatible = "sifive,fu540-c000-spi", "sifive,spi0";
> +      reg = <0x0 0x10040000 0x0 0x1000 0x0 0x20000000 0x0 0x10000000>;
> +      interrupt-parent = <&plic>;
> +      interrupts = <51>;
> +      clocks = <&tlclk>;
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      sifive,fifo-depth = <8>;
> +      sifive,max-bits-per-word = <8>;
> +    };
> +
> +...
> -- 
> 2.7.4
> 

