Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635702ABF82
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 16:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgKIPPQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 10:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbgKIPPQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 10:15:16 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81FEE2083B;
        Mon,  9 Nov 2020 15:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604934915;
        bh=uFzFBI18XxshAHcL4NhF+sS3BMnRmbg8BqeNyv++o0M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2Tw+6ILFxObelRhzyGvW51nXQ9LjMct/tFT9Qbi6suDFUjer5t5bc3lXSE8PdoZ3x
         LeLEzfCfXZ7R8YRrQdeKrrUTTym3vVNuogga3ki0aQeSRZe2mQFzDoMWy98/HI0Yg1
         YUCDbERcXhErSj5WOmjH7mJdL8h8bYI65i+XCpgI=
Received: by mail-oi1-f171.google.com with SMTP id w145so10533850oie.9;
        Mon, 09 Nov 2020 07:15:15 -0800 (PST)
X-Gm-Message-State: AOAM531M6E9C5KDVahnw5nt1RW6SQLmiGahTQXUcuhPxua9sAmhndTZj
        sGv+2Y17wn8ddaaGQ+BHlr6/BepSgThKr/A5/A==
X-Google-Smtp-Source: ABdhPJwZOpxjKNbOsGNSg9idbBszbu7k/mTdWpWiUyHqU+3dbB8MLknOWOA7Fat6Wp5mRQPMoAna61QddrvPSp3GwFg=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr9550220oib.106.1604934914871;
 Mon, 09 Nov 2020 07:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030053153.5319-7-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201104220321.GB4192737@bogus> <12deb9bb-6b3b-d71b-0a6e-5b58da23e09d@linux.intel.com>
In-Reply-To: <12deb9bb-6b3b-d71b-0a6e-5b58da23e09d@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Nov 2020 09:15:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLh=zGiaVaT2nyJjRDLnryR1ZNbK2D=0+MO4Lb=q--yDw@mail.gmail.com>
Message-ID: <CAL_JsqLh=zGiaVaT2nyJjRDLnryR1ZNbK2D=0+MO4Lb=q--yDw@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        simon.k.r.goldschmidt@gmail.com, Dinh Nguyen <dinguyen@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Kim, Cheol Yong" <cheol.yong.kim@intel.com>,
        "Wu, Qiming" <qi-ming.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Nov 8, 2020 at 7:49 PM Ramuthevar, Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> Hi Rob,
>
> On 5/11/2020 6:03 am, Rob Herring wrote:
> > On Fri, Oct 30, 2020 at 01:31:53PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> >> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >>
> >> Add compatible for Intel LGM SoC.
> >>
> >> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >> ---
> >>   Documentation/devicetree/bindings/spi/cadence-quadspi.yaml | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> >> index ec22b040d804..58ecdab939df 100644
> >> --- a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> >> +++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
> >> @@ -19,6 +19,7 @@ properties:
> >>             - enum:
> >>                 - ti,k2g-qspi
> >>                 - ti,am654-ospi
> >> +              - intel,lgm-qspi
> >
> > As this change shows, you don't need 'oneOf' for Intel...
> As we you have suggested in the previous mail, I framed like below with
> 'oneOf'
>
> properties:
>    compatible:
>      oneOf:
>        - items:
>            - enum:
>                - ti,k2g-qspi
>                - ti,am654-ospi
>            - const: cdns,qspi-nor
>
>        - items:
>            - enum:
>                - intel,lgm-qspi
>                - cadence,qspi   #compatible for generic in future use

Why are you not using the documented vendor prefix 'cdns'?

In any case, adding this is pointless. Your 'generic' compatible is below.

And you still don't need 'oneOf' here. The enum contents here can be
in the first 'enum'.

>            - const: cdns,qspi-nor
>
> so that ignoring error message warning can be avoided as well, Thanks!

In the example? Fix the example!


Rob
