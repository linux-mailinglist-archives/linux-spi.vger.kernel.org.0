Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D95234A50
	for <lists+linux-spi@lfdr.de>; Fri, 31 Jul 2020 19:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbgGaRii (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 31 Jul 2020 13:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733236AbgGaRih (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 31 Jul 2020 13:38:37 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FF432083B;
        Fri, 31 Jul 2020 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596217117;
        bh=ThVcK9Hvk7m9SF2um16GNyMOPFFlXYWERxYa9S07VUg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IhnygZYjOuB4e8fBhH11m1q+TmFS2ZWUv8vOBc4uVHIHAvi287Ay/CKLxsFFcZ8gn
         dN5LsV3Wzf16tQXmdLDJd7zpNyKEAD8wM/eVEu+bR3aRt/bVCDuV24pG/ouu5z0HXJ
         1hj8WiNwwWEOaqsAtIwELhY+t/dAMR+YN88Sgf9k=
Received: by mail-oi1-f171.google.com with SMTP id s144so17455720oie.3;
        Fri, 31 Jul 2020 10:38:37 -0700 (PDT)
X-Gm-Message-State: AOAM533Q6Ur7PZvk3Mh0FVY3gnU/959dBVzSrEIIr/XGaxZm0HUvQQ6Q
        nrTHFxA/YAJktbzLTlWeAyubd84nLAZk9xF9WA==
X-Google-Smtp-Source: ABdhPJyGE9R4ouWUf/7eAFYfwi5aW8aeIQseFytCl+rC5dI2vrcQrsvoB5m3JRF0dMRdAmvJ49Y6r7hnrSEVwQmilqY=
X-Received: by 2002:aca:190c:: with SMTP id l12mr3850529oii.147.1596217116807;
 Fri, 31 Jul 2020 10:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200727031513.31774-1-xiaoning.wang@nxp.com>
In-Reply-To: <20200727031513.31774-1-xiaoning.wang@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 31 Jul 2020 11:38:25 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+M0bjH6KnrT4ob6YF7VZxUtgUeAJOE84Omp4PNH2hSZQ@mail.gmail.com>
Message-ID: <CAL_Jsq+M0bjH6KnrT4ob6YF7VZxUtgUeAJOE84Omp4PNH2hSZQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] dt-bindings: lpspi: New property in document DT
 bindings for LPSPI
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>, Anson Huang <Anson.Huang@nxp.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Jul 26, 2020 at 9:15 PM Clark Wang <xiaoning.wang@nxp.com> wrote:
>
> Add "fsl,spi-only-use-cs1-sel" to fit i.MX8DXL-EVK.
> Spi common code does not support use of CS signals discontinuously.
> It only uses CS1 without using CS0. So, add this property to re-config
> chipselect value.
>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> ---
> Changes:
> V2:
>  - New patch added in the v2 patchset.
> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> index 143b94a1883a..22882e769e26 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> @@ -34,6 +34,12 @@ properties:
>        - const: per
>        - const: ipg
>
> +  fsl,spi-only-use-cs1-sel:
> +    description:
> +      spi common code does not support use of CS signals discontinuously.
> +      i.MX8DXL-EVK board only uses CS1 without using CS0. Therefore, add
> +      this property to re-config the chipselect value in the LPSPI driver.

This breaks linux-next and you didn't test with 'make dt_binding_check':

/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml:
properties:fsl,spi-only-use-cs1-sel: {'description': 'spi common code
does not support use of CS signals discontinuously. i.MX8DXL-EVK board
only uses CS1 without using CS0. Therefore, add this property to
re-config the chipselect value in the LPSPI driver.'} is not valid
under any of the given schemas (Possible causes of the failure):
 /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml:
properties:fsl,spi-only-use-cs1-sel: 'not' is a required property

The problem is you need a type definition for a vendor specific
property. In this case 'type: boolean'.

Rob
