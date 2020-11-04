Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158322A701A
	for <lists+linux-spi@lfdr.de>; Wed,  4 Nov 2020 23:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbgKDWCr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Nov 2020 17:02:47 -0500
Received: from mail-oo1-f67.google.com ([209.85.161.67]:42244 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbgKDWCo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Nov 2020 17:02:44 -0500
Received: by mail-oo1-f67.google.com with SMTP id l26so9504oop.9;
        Wed, 04 Nov 2020 14:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VDlYs9n7jp3BkABO++FRUphY3QSzFMD8WBO0XVDWXfk=;
        b=ucnx0akGyoPYU+vOtvCeI4x/RTyPzFnELdIchPkIBePBMmNyJyo0yU3xhfGZr9lxhf
         orqlOVAKKaw5ovguwbCPM+zPjqmPmE3Cg/KqE1ukv6qDuAReApITgUSoNcnYQdTCtZHy
         WK11HK+ER9ACyFIHaZM4MntUOUQTzPyghxH5Ye6wXFxzukT7zSjZWGgjcp1vq8sfPc8V
         y9TsDFPyWWeacZjfOXBvdGackzbOZdIAJkdxbvSrVD0UrNrZcvNqq/XbmZGgGEkWSjfl
         MTqeT4MqM68XBMs8hw4CdIr8LaXmcYhbmARQlBZsvTzSEU3D/cc4awZuXZnUqccvUpLK
         5wbQ==
X-Gm-Message-State: AOAM533zDKLxxABFQG3sehV+FrRe4L7WdPGk0zh0oIxF5SsKCKcWMoyT
        5vEgh/hw9YvqmMg6tUr5IA==
X-Google-Smtp-Source: ABdhPJw3lztNesCSTmOBj3NmKNBGvLCXlWnNHcO3ktPxftYN54oBueW17S3m8c54UDmKm7JdyPFDEQ==
X-Received: by 2002:a4a:4203:: with SMTP id h3mr205139ooj.0.1604527363404;
        Wed, 04 Nov 2020 14:02:43 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q7sm764304oig.42.2020.11.04.14.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 14:02:42 -0800 (PST)
Received: (nullmailer pid 5906 invoked by uid 1000);
        Wed, 04 Nov 2020 22:02:41 -0000
Date:   Wed, 4 Nov 2020 16:02:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v6 5/6] dt-bindings: spi: Convert cadence-quadspi.txt to
 cadence-quadspi.yaml
Message-ID: <20201104220241.GA4192737@bogus>
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030053153.5319-6-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030151837.GA3854035@bogus>
 <a49505e9-500a-1c88-b5b5-1f6ea5e94c86@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a49505e9-500a-1c88-b5b5-1f6ea5e94c86@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 02, 2020 at 01:59:41PM +0800, Ramuthevar, Vadivel MuruganX wrote:
> Hi Rob,
> 
> Thank you for the review comments...
> 
> On 30/10/2020 11:18 pm, Rob Herring wrote:
> > On Fri, Oct 30, 2020 at 01:31:52PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> > > From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> > > 
> > > Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
> > > remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/
> > > 
> > > Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> > > ---
> > >   .../devicetree/bindings/spi/cadence-quadspi.txt    |  67 ---------
> > >   .../devicetree/bindings/spi/cadence-quadspi.yaml   | 149 +++++++++++++++++++++
> > >   2 files changed, 149 insertions(+), 67 deletions(-)
> > >   delete mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> > >   create mode 100644 Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> > > deleted file mode 100644
> > > index 945be7d5b236..000000000000
> > > --- a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
> > > +++ /dev/null
> > > @@ -1,67 +0,0 @@
> > > -* Cadence Quad SPI controller
> > > -
> > > -Required properties:
> > > -- compatible : should be one of the following:
> > > -	Generic default - "cdns,qspi-nor".
> > > -	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
> > > -	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
> > > -- reg : Contains two entries, each of which is a tuple consisting of a
> > > -	physical address and length. The first entry is the address and
> > > -	length of the controller register set. The second entry is the
> > > -	address and length of the QSPI Controller data area.
> > > -- interrupts : Unit interrupt specifier for the controller interrupt.
> > > -- clocks : phandle to the Quad SPI clock.
> > > -- cdns,fifo-depth : Size of the data FIFO in words.
> > > -- cdns,fifo-width : Bus width of the data FIFO in bytes.
> > > -- cdns,trigger-address : 32-bit indirect AHB trigger address.
> > > -
> > > -Optional properties:
> > > -- cdns,is-decoded-cs : Flag to indicate whether decoder is used or not.
> > > -- cdns,rclk-en : Flag to indicate that QSPI return clock is used to latch
> > > -  the read data rather than the QSPI clock. Make sure that QSPI return
> > > -  clock is populated on the board before using this property.
> > > -
> > > -Optional subnodes:
> > > -Subnodes of the Cadence Quad SPI controller are spi slave nodes with additional
> > > -custom properties:
> > > -- cdns,read-delay : Delay for read capture logic, in clock cycles
> > > -- cdns,tshsl-ns : Delay in nanoseconds for the length that the master
> > > -                  mode chip select outputs are de-asserted between
> > > -		  transactions.
> > > -- cdns,tsd2d-ns : Delay in nanoseconds between one chip select being
> > > -                  de-activated and the activation of another.
> > > -- cdns,tchsh-ns : Delay in nanoseconds between last bit of current
> > > -                  transaction and deasserting the device chip select
> > > -		  (qspi_n_ss_out).
> > > -- cdns,tslch-ns : Delay in nanoseconds between setting qspi_n_ss_out low
> > > -                  and first bit transfer.
> > > -- resets	: Must contain an entry for each entry in reset-names.
> > > -		  See ../reset/reset.txt for details.
> > > -- reset-names	: Must include either "qspi" and/or "qspi-ocp".
> > > -
> > > -Example:
> > > -
> > > -	qspi: spi@ff705000 {
> > > -		compatible = "cdns,qspi-nor";
> > > -		#address-cells = <1>;
> > > -		#size-cells = <0>;
> > > -		reg = <0xff705000 0x1000>,
> > > -		      <0xffa00000 0x1000>;
> > > -		interrupts = <0 151 4>;
> > > -		clocks = <&qspi_clk>;
> > > -		cdns,is-decoded-cs;
> > > -		cdns,fifo-depth = <128>;
> > > -		cdns,fifo-width = <4>;
> > > -		cdns,trigger-address = <0x00000000>;
> > > -		resets = <&rst QSPI_RESET>, <&rst QSPI_OCP_RESET>;
> > > -		reset-names = "qspi", "qspi-ocp";
> > > -
> > > -		flash0: n25q00@0 {
> > > -			...
> > > -			cdns,read-delay = <4>;
> > > -			cdns,tshsl-ns = <50>;
> > > -			cdns,tsd2d-ns = <50>;
> > > -			cdns,tchsh-ns = <4>;
> > > -			cdns,tslch-ns = <4>;
> > > -		};
> > > -	};
> > > diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> > > new file mode 100644
> > > index 000000000000..ec22b040d804
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> > > @@ -0,0 +1,149 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/spi/cadence-quadspi.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Cadence Quad SPI controller
> > > +
> > > +maintainers:
> > > +  - Vadivel Murugan <vadivel.muruganx.ramuthevar@intel.com>
> > > +
> > > +allOf:
> > > +  - $ref: "spi-controller.yaml#"
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > 
> > You don't need 'oneOf' if there is only one entry...
> > 
> > So you've dropped 'cdns,qspi-nor' alone being valid. Granted, the txt
> > file was fuzzy as to whether or not that was valid. So you have to look
> > at all the dts files and see. I prefer we don't allow that and require a
> > more specific compatible, but if there's a bunch then we should allow
> > for it. The commit message should summarize what you decide.
> we need bunch of compatibles as below, TI, Altera and Intel uses different
> compatible's so we added 'oneOf'.

Then you add oneOf when you need it. You don't for what you wrote, 
but once it is correct you will as Altera uses 'cdns,qspi-nor' alone. 

> cdns,qspi-nor can be dropped instead I can add cadence,qspi ,because this
> driver suuports qspi-nor and qspi-nand as well.

No, you can't change it because it is an ABI.

> 
> Sure, let me go through other documentation files for reference.
> 
> > 
> > > +          - enum:
> > > +              - ti,k2g-qspi
> > > +              - ti,am654-ospi
> > > +          - const: cdns,qspi-nor
> > 
> > > +examples:
> > > +  - |
> > > +    qspi: spi@ff705000 {
> > > +      compatible = "cadence,qspi","cdns,qpsi-nor";
> > 
> > And you missed fixing this.
> Yes, fixed by "cadence,qspi" keeping alone, need to remove cdns,qspi-nor,
> thanks!

Nope!

Rob
