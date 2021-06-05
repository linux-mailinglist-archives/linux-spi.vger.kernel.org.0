Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC3639C446
	for <lists+linux-spi@lfdr.de>; Sat,  5 Jun 2021 02:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhFEAVH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 20:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhFEAVG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 20:21:06 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD8EC061766
        for <linux-spi@vger.kernel.org>; Fri,  4 Jun 2021 17:19:07 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id x8so5766062vso.5
        for <linux-spi@vger.kernel.org>; Fri, 04 Jun 2021 17:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0vbLUf0aNq8CIlyYhcbgGxZ5n0sokzL7OV8oejCBB1U=;
        b=PQhd6CGBXas8S6LrCWN1Mv/pDpT54JLFlmSt6rq8sKmCieoY6ky3jUrUuW5mQg/uRj
         z0MK9fYQN4t8wWf/3Bdcyej3r2el350DzmlRPaBxe5pAMBE2LEXYFaukyTPs1wJ2yStJ
         pI6mdKKmjVUnyJxBe5VXAdHMfT/wRxKfNnt88YdxFB9ZNhDZTVO+R/TjHLRwVWmEyfUK
         OPWMDWSU9ZxCAAJKhqBNvemnw4ZdDSrJmnutiVI8cDBVY/PBmvV3ylHDXEy2IgWwAiTz
         tUWaz5ZgFeuryWw7iRKDm7X9/RiVCDnmKWLDTa2Obltn8Rq9dq2jElzznbF521DkBO0I
         pn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0vbLUf0aNq8CIlyYhcbgGxZ5n0sokzL7OV8oejCBB1U=;
        b=TYLkKbRsS+GsjKuUsRrZrfM9WbW0B1c8pdTx79j6N31MkQq1DKZ9r8phacTJosnuwF
         sxCIH4eKB1VQqPISoUtfW0b2ebghRNF2yS8UAzKr/EWBkrF8tEKw63czfQBBZGgtMcwd
         zlI31zPLlUF7DvaUFALv0XosW46XxVfiEhfR5W945IxWM18RvBOcaYdqNuFnWnbngG4t
         G+388Q09CRxDNMLiTKfGBf2brc+hRyhCBWpwQ/LTXkPMiGd2Sy+hTkdtSCU+Duz+5Qkf
         uQ91RITwc/V+8sXFqAsfHxuyXXPzqD57iAf6GimfyM5UY13qVn4YqdShb2mOSM5ZOJ8C
         TGzg==
X-Gm-Message-State: AOAM530rBlBOz1M8tUmW7AnhXl4IlBXxg9aNhcC5R/u7LzKOufgwk6DM
        bF4Gi8KZyUwBEU4QDqbrWS9iTZpHSXBcbVgn3Wg8
X-Google-Smtp-Source: ABdhPJyAhM89H3/fMRDHSTdzSwklriEUs7T0qCo1JfZoLXrSmnztk2LrCj1qh2SHlaIPh0UN51aHI+TEdtcX/EyAiys=
X-Received: by 2002:a05:6102:512:: with SMTP id l18mr4668087vsa.33.1622852345212;
 Fri, 04 Jun 2021 17:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210531052142.695430-1-iwamatsu@nigauri.org> <20210604213326.GA3957165@robh.at.kernel.org>
In-Reply-To: <20210604213326.GA3957165@robh.at.kernel.org>
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date:   Sat, 5 Jun 2021 09:18:39 +0900
Message-ID: <CABMQnV+ZjcrzZEZpaBBvO+VW8kV_2qWXwNPE7gYCdfcqa-UFkA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: xilinx: convert to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

Thanks for your review.

2021=E5=B9=B46=E6=9C=885=E6=97=A5(=E5=9C=9F) 6:33 Rob Herring <robh@kernel.=
org>:
>
> On Mon, May 31, 2021 at 02:21:42PM +0900, Nobuhiro Iwamatsu wrote:
> > Convert SPI for Xilinx bindings documentation to YAML schemas.
> >
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > ---
> >  .../devicetree/bindings/spi/spi-xilinx.txt    | 23 ---------
> >  .../devicetree/bindings/spi/spi-xilinx.yaml   | 51 +++++++++++++++++++
> >  2 files changed, 51 insertions(+), 23 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.tx=
t
> >  create mode 100644 Documentation/devicetree/bindings/spi/spi-xilinx.ya=
ml
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Doc=
umentation/devicetree/bindings/spi/spi-xilinx.txt
> > deleted file mode 100644
> > index 5f4ed3e5c9942c..00000000000000
> > --- a/Documentation/devicetree/bindings/spi/spi-xilinx.txt
> > +++ /dev/null
> > @@ -1,23 +0,0 @@
> > -Xilinx SPI controller Device Tree Bindings
> > --------------------------------------------------
> > -
> > -Required properties:
> > -- compatible         : Should be "xlnx,xps-spi-2.00.a", "xlnx,xps-spi-=
2.00.b" or "xlnx,axi-quad-spi-1.00.a"
> > -- reg                        : Physical base address and size of SPI r=
egisters map.
> > -- interrupts         : Property with a value describing the interrupt
> > -                       number.
> > -
> > -Optional properties:
> > -- xlnx,num-ss-bits    : Number of chip selects used.
> > -- xlnx,num-transfer-bits : Number of bits per transfer. This will be 8=
 if not specified
> > -
> > -Example:
> > -     axi_quad_spi@41e00000 {
> > -                     compatible =3D "xlnx,xps-spi-2.00.a";
> > -                     interrupt-parent =3D <&intc>;
> > -                     interrupts =3D <0 31 1>;
> > -                     reg =3D <0x41e00000 0x10000>;
> > -                     xlnx,num-ss-bits =3D <0x1>;
> > -                     xlnx,num-transfer-bits =3D <32>;
> > -     };
> > -
> > diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml b/Do=
cumentation/devicetree/bindings/spi/spi-xilinx.yaml
> > new file mode 100644
> > index 00000000000000..17463151b36a02
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/spi/spi-xilinx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Xilinx SPI controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Michal Simek <michal.simek@xilinx.com>
> > +
> > +allOf:
> > +  - $ref: "spi-controller.yaml#"
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: xlnx,xps-spi-2.00.a
> > +      - const: xlnx,xps-spi-2.00.b
> > +      - const: xlnx,axi-quad-spi-1.00.a
>
> Use enum instead of oneOf+const.

OK, I will change using enum.

>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  xlnx,num-ss-bits:
> > +    description: Number of chip selects used.
>
> Constraints? 0-2^32 is good?

I will add constraints.

>
> > +
> > +  xlnx,num-transfer-bits:
> > +    description: Number of bits per transfer. This will be 8 if not sp=
ecified.
>
> Constraints?

Same above.

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
