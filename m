Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EED4117D6
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 17:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbhITPKN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 11:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235441AbhITPKM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 11:10:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AA8C061574;
        Mon, 20 Sep 2021 08:08:43 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g1so69621591lfj.12;
        Mon, 20 Sep 2021 08:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zHBcy62XBnwwIXR6J0uJZFxZPjvGorUc2wPW3wjD7m8=;
        b=DO5x9hFYScnYzeAJQV+nm5mz3uSaWz+2uG8C6WGB09WCtCoEtj3VeVAULgoR7t4icc
         l3cAnhjyZdjYexiF6AvgsxL6aSGoR1Wts5KS4UY/gRg1kopMBSHCt7rDFC9rX4WUHPff
         vaJU04Zppn4ym8YDhHWpDIg1fxhHC9YxeujQoTRdw/vdOQT8nPYClU8JnTwfDn8+dB19
         opjDk1x8kg0LrnI4u+QQMWt5FvDPc9dY0yChZyohWP+NvdToQlnnLmKmxtIuxcCUmz67
         G7gynfWVZ1fyhZaCHLUza5XppEO/j6S03WiRZ2kbo6/B6rsm1rxYtBTu/HTTFZNROLzS
         LdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zHBcy62XBnwwIXR6J0uJZFxZPjvGorUc2wPW3wjD7m8=;
        b=BX1OScuPbMDeB5glkl8FbNNgYdKk8HBpImWR+e2NlJN+mQmxC+3t6ftv4NGfzODBGX
         A915W3Fr0FOpRgLeGDX9ls3mtOxDXYMvwmapy5TMPAoUCsfkg9PbfTNQ9T6gMY2UV79u
         4bYWCyiwIQ4GRl0iRDI71zh+BkNegyYkhwecom7a4+0p0Hi6fEAzJwMcvnCH0KfIfYIf
         Db7lB4ZTIsaXAnbF3mFplvLJ3bTUoZvpREVspYNHEbS3MFC+Nfd7Z4K6fbKWq7egmQNC
         C3NPs7UrTHVHkikpTL3fWfVFT4ooD6Q+fexYaS58l0jq/RSQ3P/cAPWmAFXKBQZRhjXR
         kNrw==
X-Gm-Message-State: AOAM531f+yNA2zHm/4LJs/xnLSB0wJzKv/2tcG7X7nVTsAdXOHdUoTPx
        xEWymCW5OVZPQcHDipeteKdQ+I359DPUrQ==
X-Google-Smtp-Source: ABdhPJy4OYzYqeDYcjPz6Mwx9k9+fK4xv1m5cyhQyXfKOeYKeK4hSfbYYvdWr5tpKKfZUg9/vzt5MQ==
X-Received: by 2002:a2e:8e8f:: with SMTP id z15mr22868490ljk.121.1632150414239;
        Mon, 20 Sep 2021 08:06:54 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id v26sm1319921ljv.77.2021.09.20.08.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:06:53 -0700 (PDT)
Date:   Mon, 20 Sep 2021 18:06:51 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, michael@walle.cc
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: spi-nand: Convert to DT schema
 format
Message-ID: <20210920150651.vvdhennblwhdi3jw@mobilestation>
References: <20210920142713.129295-1-a-nandan@ti.com>
 <20210920142713.129295-2-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920142713.129295-2-a-nandan@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Apurva

On Mon, Sep 20, 2021 at 07:57:12PM +0530, Apurva Nandan wrote:
> Convert spi-nand.txt binding to YAML format with an added example.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  .../devicetree/bindings/mtd/spi-nand.txt      |  5 --
>  .../devicetree/bindings/mtd/spi-nand.yaml     | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 5 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/spi-nand.yaml

Thanks for the bindings conversion patch. There are several comments
below. But before addressing them it would be better to also get a
response from Rob.

> 
> diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.txt b/Documentation/devicetree/bindings/mtd/spi-nand.txt
> deleted file mode 100644
> index 8b51f3b6d55c..000000000000
> --- a/Documentation/devicetree/bindings/mtd/spi-nand.txt
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -SPI NAND flash
> -
> -Required properties:
> -- compatible: should be "spi-nand"
> -- reg: should encode the chip-select line used to access the NAND chip
> diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> new file mode 100644
> index 000000000000..601beba8d971
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/spi-nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI NAND flash
> +
> +maintainers:
> +  - Apurva Nandan <a-nandan@ti.com>
> +
> +allOf:
> +  - $ref: "mtd.yaml#"
> +
> +properties:
> +  compatible:
> +    const: spi-nand
> +
> +  reg:
> +    maxItems: 1
> +

> +  spi-max-frequency: true
> +  spi-rx-bus-width: true
> +  spi-tx-bus-width: true
> +  rx-sample-delay-ns: true

Since it's an SPI-client device there are more than these properties
could be set for it. See the SPI-controller bindings schema:
Documentation/devicetree/bindings/spi/spi-controller.yaml
So there is two possible ways to make it more generic:
1) Detach the spi-client part from the spi-controller.yaml bindings
into a dedicated DT-schema file and refer to that new scheme from
here.
2) Forget about these controller-specific properties and let the
parental SPI-controller bindings parsing them. Of course there must be
at least one of the next properties declared for it to work:
{unevaluatedProperties, additionalProperties}.

It's up to Rob to decided which approach is better though...

> +
> +  '#address-cells': true
> +  '#size-cells': true

Aren't they always equal to 1?

> +
> +additionalProperties:
> +  type: object

I'd suggest to elaborate the way the partition sub-nodes looks
like, for instance, the node names, supported compatible names,
labels, etc.

-Sergey

> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@6 {
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            compatible = "spi-nand";
> +            reg = <0x6>;
> +            spi-max-frequency = <42000000>;
> +
> +            partitions {
> +                compatible = "fixed-partitions";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                partition@0 {
> +                    label = "boot";
> +                    reg = <0 0x200000>;
> +                };
> +
> +                partition@200000 {
> +                    label = "rootfs";
> +                    reg = <0x200000 0xce0000>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.25.1
> 
