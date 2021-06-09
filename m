Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5865B3A1E52
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 22:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhFIUyG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 16:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhFIUyF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Jun 2021 16:54:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F24EE613EE;
        Wed,  9 Jun 2021 20:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623271931;
        bh=2xJm8+K9K3yMMtA6Yx9r/pcA3AR2W+Issga14oVL+C4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AbzkJununfgwbAGwE3AtUtr2nA57hzQFqDq6jZfslDbmgZ7UrZM38e7a6e/0NNLZE
         kVc3hq9v0BcJ1eyKCYiQoot0UDEP/qBq6yvZMYEQADfOBt5arC55BWrzX37JFASnQq
         ytRoTFR6PFv+kdilSubISa8kwUShrPT3z+c3k96e8hgX5t+ZQqroG0FFSpdYL+Z8d0
         IxC7L/72/i3QqRgPh5Qunwl4fH2RI7PrmSCRDrOUMx7ynM92sYwkLHCvfB0zddTPzZ
         e/AEFrfu9KIY6E+UyAtnOe1Gv3X0i+V556FJg2YI3fSwIN8JR/38riT1T/VrJgdGic
         XyySS5HyLbZ9g==
Received: by mail-ed1-f51.google.com with SMTP id t3so30109341edc.7;
        Wed, 09 Jun 2021 13:52:10 -0700 (PDT)
X-Gm-Message-State: AOAM533QTWckisledz3UvSFh57lHW3WTSJBo6xsBGG1eYt2q6dNqn8Wg
        QRb+4SM+ktv5OipW7amyiLAHPFC2d6ZDI9j9Ow==
X-Google-Smtp-Source: ABdhPJzrK1tDX4o4Uy/uplvx+4AlBnNvKFj8nYmtpy43TZKhYfrjC8V5LdESsaQIeFWnDzy8sshEhj8QPP1doC80iXs=
X-Received: by 2002:aa7:cd83:: with SMTP id x3mr1187447edv.373.1623271929496;
 Wed, 09 Jun 2021 13:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210609111707.9555-1-p.yadav@ti.com> <20210609111707.9555-2-p.yadav@ti.com>
In-Reply-To: <20210609111707.9555-2-p.yadav@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Jun 2021 15:51:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK5hu6NSVxiTpPvH_jHA97WTj3=DyJhDf5g1hwXXZ8MZA@mail.gmail.com>
Message-ID: <CAL_JsqK5hu6NSVxiTpPvH_jHA97WTj3=DyJhDf5g1hwXXZ8MZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: dt-bindings: add schema listing slave-specific properties
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 9, 2021 at 6:17 AM Pratyush Yadav <p.yadav@ti.com> wrote:
>
> Many SPI controllers need to add properties to slave devices. This could
> be the delay in clock or data lines, etc. These properties are
> controller specific but need to be defined in the slave node because
> they are per-slave and there can be multiple slaves attached to a
> controller.
>
> If these properties are not added to the slave binding, then the dtbs
> check emits a warning. But these properties do not make much sense in
> the slave binding because they are controller-specific and they will
> just pollute every slave binding. So this binding is added to collect
> all such properties from all such controllers. Slave bindings should
> simply refer to this binding and they should be rid of the warnings.

Thanks for working on this. I haven't thought of any better solution
than this approach.

> There are some limitations with this approach. Firstly, there is no way
> to specify required properties. The schema contains properties for all
> controllers and there is no way to know which controller is being used.

If required properties are a function of the controller and not the
controller+device, then the controller schema can list required
properties for child nodes.

> Secondly, there is no way to restrict additional properties. Since this
> schema will be used with an allOf operator, additionalProperties needs
> to be true. In addition, the slave schema will have to set
> unevaluatedProperties: false.

No issue there other than unevaluatedProperties is currently not implemented.

> Despite these limitations, this appears to be the best solution to this
> problem that doesn't involve modifying existing tools or schema specs.
>
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>
>  .../bindings/spi/cdns,qspi-nor.yaml           | 33 ------------
>  .../bindings/spi/spi-slave-props.yaml         | 52 +++++++++++++++++++

I think you need 2+ files here. A common one that's just an 'allOf' of
all the controller specific schemas and then controller specific child
node schemas.

>  2 files changed, 52 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-props.yaml
>
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index 0e7087cc8bf9..0730e6a8dc4a 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -74,39 +74,6 @@ properties:
>      items:
>        enum: [ qspi, qspi-ocp ]
>
> -# subnode's properties
> -patternProperties:
> -  "@[0-9a-f]+$":
> -    type: object
> -    description:
> -      Flash device uses the below defined properties in the subnode.
> -
> -    properties:
> -      cdns,read-delay:
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -        description:
> -          Delay for read capture logic, in clock cycles.
> -
> -      cdns,tshsl-ns:
> -        description:
> -          Delay in nanoseconds for the length that the master mode chip select
> -          outputs are de-asserted between transactions.
> -
> -      cdns,tsd2d-ns:
> -        description:
> -          Delay in nanoseconds between one chip select being de-activated
> -          and the activation of another.
> -
> -      cdns,tchsh-ns:
> -        description:
> -          Delay in nanoseconds between last bit of current transaction and
> -          deasserting the device chip select (qspi_n_ss_out).
> -
> -      cdns,tslch-ns:
> -        description:
> -          Delay in nanoseconds between setting qspi_n_ss_out low and
> -          first bit transfer.
> -
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/spi/spi-slave-props.yaml b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
> new file mode 100644
> index 000000000000..b2248e01dc43
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-slave-props.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-slave-props.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Slave-specific properties for a SPI bus.
> +
> +description: |
> +  Many SPI controllers need to add properties to slave devices. This could be
> +  the delay in clock or data lines, etc. These properties are controller
> +  specific but need to be defined in the slave node because they are per-slave
> +  and there can be multiple slaves attached to a controller.
> +
> +  If these properties are not added to the slave binding, then the dtbs check
> +  emits a warning. But these properties do not make much sense in the slave
> +  binding because they are controller-specific and they will just pollute every
> +  slave binding. So this binding is added to collect all such properties from
> +  all such controllers. Slave bindings should simply refer to this binding and
> +  they should be rid of the warnings.

I don't think this paragraph belongs in the schema.

> +
> +maintainers:
> +  - Pratyush Yadav <p.yadav@ti.com>
> +
> +properties:
> +  # cdns,qspi-nor.yaml
> +  cdns,read-delay:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Delay for read capture logic, in clock cycles.
> +
> +  cdns,tshsl-ns:
> +    description:
> +      Delay in nanoseconds for the length that the master mode chip select
> +      outputs are de-asserted between transactions.
> +
> +  cdns,tsd2d-ns:
> +    description:
> +      Delay in nanoseconds between one chip select being de-activated
> +      and the activation of another.
> +
> +  cdns,tchsh-ns:
> +    description:
> +      Delay in nanoseconds between last bit of current transaction and
> +      deasserting the device chip select (qspi_n_ss_out).
> +
> +  cdns,tslch-ns:
> +    description:
> +      Delay in nanoseconds between setting qspi_n_ss_out low and
> +      first bit transfer.
> +
> +additionalProperties: true
> --
> 2.30.0
>
