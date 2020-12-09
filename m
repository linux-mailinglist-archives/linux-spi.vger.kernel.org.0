Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BCD2D47E9
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 18:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbgLIR1h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 12:27:37 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44237 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732758AbgLIR11 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 12:27:27 -0500
Received: by mail-ot1-f65.google.com with SMTP id f16so2106026otl.11;
        Wed, 09 Dec 2020 09:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJcplb3slY1dsoFAl6yxoDTBG+DHfog6F6dFhpVHk9A=;
        b=JKBBhpm/xGYFLyIaJpMhYhdXoKaVBh2nhVS18ayRiDMmzVB6oSfZdOyGdKyvJLgKvm
         5is3EIYQr8SOSy85+1Y2QabXlmlYjEwtJFgh85o5yZcO0NhKQ5P/6wmvsgZT56n/VRIs
         JUb/z49cW0Y+5zVbG1HgCtulagzykvZqjDvUU2oiFAdUeW1t5HilLD+9RBSKyFM9sYpf
         13B6MCsD/XcFJwy02lw7v8jGrbc79tLxThvWoMr39PDhyTxoyMlcKy1JK918MX1+vc4M
         JneoQAuLhW9TcWfMeQJAgdkieAGcIhl4M95SQFwTTRKmLa0o051BWseRxCFAJxEfXQ7k
         uvGg==
X-Gm-Message-State: AOAM531V1XdB+YMbsMJQBUHDo+hlyEY2EuVJrPAzMmaYdo1qkwWz3P6f
        AZuA8vXkv6aRG7/KfmBjJ3LpHGILvQ==
X-Google-Smtp-Source: ABdhPJwINWASDIcbnAlPGTqU1d+qKbxekVgnOt54abWpI7enCFjTH9b++DgZI0VBTn7SapNG6EEqVw==
X-Received: by 2002:a9d:63c6:: with SMTP id e6mr2657288otl.326.1607534805803;
        Wed, 09 Dec 2020 09:26:45 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k13sm537363otl.72.2020.12.09.09.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 09:26:45 -0800 (PST)
Received: (nullmailer pid 641351 invoked by uid 1000);
        Wed, 09 Dec 2020 17:26:43 -0000
Date:   Wed, 9 Dec 2020 11:26:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/7] dt-bindings: spi: Add Tegra QSPI device tree
 binding
Message-ID: <20201209172643.GA638607@robh.at.kernel.org>
References: <1606857168-5839-1-git-send-email-skomatineni@nvidia.com>
 <1606857168-5839-3-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606857168-5839-3-git-send-email-skomatineni@nvidia.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Dec 01, 2020 at 01:12:43PM -0800, Sowjanya Komatineni wrote:
> This patch adds YAML based device tree binding document for Tegra
> QSPI driver.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../devicetree/bindings/spi/nvidia,tegra-qspi.yaml | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml
> new file mode 100644
> index 0000000..038a085
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra-qspi.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/nvidia,tegra-qspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Tegra Quad SPI Controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jonathan Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra210-qspi
> +      - nvidia,tegra186-qspi
> +      - nvidia,tegra194-qspi
> +
> +  reg:
> +    items:
> +      - description: QSPI registers

Just 'maxItems: 1'

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: qspi

Kind of a pointless name. 

> +
> +  clocks:
> +    maxItems: 1
> +
> +  reset-names:
> +    minItems: 1
> +    items:
> +      - const: qspi

Same here.

> +
> +  resets:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 2
> +
> +  dma-names:
> +    items:
> +      - const: rx
> +      - const: tx
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clock-names
> +  - clocks
> +  - reset-names
> +  - resets
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/tegra210-car.h>
> +    #include <dt-bindings/reset/tegra210-car.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spi@70410000 {
> +            compatible = "nvidia,tegra210-qspi";
> +            reg = <0x70410000 0x1000>;
> +            interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&tegra_car TEGRA210_CLK_QSPI>;
> +            clock-names = "qspi";
> +            resets = <&tegra_car 211>;
> +            reset-names = "qspi";
> +            dmas = <&apbdma 5>, <&apbdma 5>;
> +            dma-names = "rx", "tx";
> +    };
> -- 
> 2.7.4
> 
