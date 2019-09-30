Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29598C29AA
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 00:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfI3Wgo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 30 Sep 2019 18:36:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35910 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfI3Wgo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 30 Sep 2019 18:36:44 -0400
Received: by mail-ot1-f67.google.com with SMTP id 67so9844233oto.3;
        Mon, 30 Sep 2019 15:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mpInDS2oe0Ta+ZD1qVPCII+xXIk5A6Ga/flR3rWJqyU=;
        b=osZWkurO7cz5QZfKPRLKOdz4wYZKNXU8wMmiJOYlYTJxNLGz+rFTdPQpANpSbzLD8K
         IgA+BupyzSehMhJ796jOMbcsNLDEmSWFld1mg6A/kJJTFzbNspoj+cvGUavCrbYR2459
         ig2GcnHlsXbGlT4xYrHTu0noUD+oOssSjK6to/mN6K9T4tTw9iYA5iBDkwo3Z+w5tcu/
         cZjNpYGd2TNwBm1c2+mVm9GtDl8GTyjIrS0O41EgRzO/7rA8HRQ7BT3yzkTumPMyOZgV
         j3hZEAToeZgLbpBdSZNi/4Zdd/AzJNqFIeTr8K5TzUpJTcOYh05mAj7DB6sshu9FuFZx
         SGbg==
X-Gm-Message-State: APjAAAWeMji/Dh/o0Uk3UPxItZr9UV76HKG2yNHv5paeobD7Nhy5BkaD
        mMb8AnbcXLQKuDM5FnCFDbblLU4=
X-Google-Smtp-Source: APXvYqzijfy1cYSHjSDjO5oXeKYPN9PlN7UqRR5N+7H24ZAYWjibfzSeYgmFYGi/OnM6T0RYMMEDPQ==
X-Received: by 2002:a05:6830:156:: with SMTP id j22mr16397493otp.196.1569883001835;
        Mon, 30 Sep 2019 15:36:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l30sm4127481otl.74.2019.09.30.15.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 15:36:41 -0700 (PDT)
Date:   Mon, 30 Sep 2019 17:36:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     broonie@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: Add support for cadence-qspi IP
 Intel LGM SoC
Message-ID: <20190930223640.GA18491@bogus>
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916073843.39618-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916073843.39618-2-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 16, 2019 at 03:38:42PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> On Intel Lightening Mountain(LGM) SoCs QSPI controller support
> to QSPI-NAND flash. This introduces to device tree binding
> documentation for Cadence-QSPI controller and spi-nand flash.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../devicetree/bindings/spi/cadence,qspi-nand.yaml | 84 ++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml b/Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
> new file mode 100644
> index 000000000000..9aae4c1459cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/cadence,qspi-nand.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/spi/cadence,qspi-nand.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence QSPI Flash Controller on Intel's SoC
> +
> +maintainers:
> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +description: |
> +  The Cadence QSPI is a controller optimized for communication with SPI
> +  FLASH memories, without DMA support on Intel's SoC.
> +
> +properties:
> +  compatible:
> +    const: cadence,lgm-qspi

Vendor here should be 'intel'. Perhaps the binding should be shared too 
like the driver.

Plus the vendor prefix for Cadence is cdns.

> +
> +  reg:
> +    maxItems: 1
> +
> +  fifo-depth:
> +    maxItems: 1
> +
This is vendor specific, so needs a vendor prefix, type, and 
description.

> +  fifo-width:
> +    maxItems: 1

Same

> +
> +  qspi-phyaddr:
> +    maxItems: 1

Same

> +
> +  qspi-phymask:
> +    maxItems: 1

Same

> +
> +  clocks:
> +    maxItems: 2

Need to define what each clock is when there is more than 1.

> +
> +  clocks-names:
> +    maxItems: 2

Need to define the strings.

> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - fifo-depth
> +  - fifo-width
> +  - qspi-phyaddr
> +  - qspi-phymask
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +examples:
> +  - |
> +    qspi@ec000000 {

spi@...

> +          compatible = "cadence,qspi-nand";
> +          reg = <0xec000000 0x100>;
> +          fifo-depth = <128>;
> +          fifo-width = <4>;
> +          qspi-phyaddr = <0xf4000000>;
> +          qspi-phymask = <0xffffffff>;
> +          clocks = <&cgu0 LGM_CLK_QSPI>, <&cgu0 LGM_GCLK_QSPI>;
> +          clock-names = "freq", "qspi";
> +          resets = <&rcu0 0x10 1>;
> +          reset-names = "qspi";
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          flash: flash@1 {
> +              compatible = "spi-nand";
> +              reg = <1>;
> +              spi-max-frequency = <10000000>;
> +          };
> +    };
> +
> -- 
> 2.11.0
> 
