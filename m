Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310EB43DBED
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 09:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhJ1H2r (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 03:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1H2q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 03:28:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1C8C061570;
        Thu, 28 Oct 2021 00:26:20 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i13so2054855lfe.4;
        Thu, 28 Oct 2021 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=An+PWLgm9KGN3ZMc6V12HECPGYxxsybsWas2GAbfS9c=;
        b=LcKx75XoCzDyv0KsxRa8EIVtTggERMVMVW374pW7DAVBNZ33LF7adCQ9RGECxrFB+w
         yJHwxBiT2dYqM4p8BPRy9nKSkAl5p3Uo7C42tASPiUJ72SrmzFH7CQVs1k+qVXC3F1VF
         skPF9xEF8L8upTlOi5AWdiT5t4piblTAtqXzFgrleKRlndDTTv4OreEfSdkUNXvrTS7s
         K5DWdozMtt9tMGFKDYXJLPmnrp7lFA+s2nf4OoIyF/wisNVGYbvA/2hYTbLPICeMfK+J
         ooFNAR7Z3lBu41WoefUsrnQoi1N9x2aBlQ+zKCwfMrBSBYijUsRnxyiV1YbF3on7iE9u
         bkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=An+PWLgm9KGN3ZMc6V12HECPGYxxsybsWas2GAbfS9c=;
        b=XFD4KFESWl4dSZm5s1G2tfo3XpVQ0PUnEBw0ZnMTzpx/oZJgWfKyLUOGBt7AByMrs2
         IVRmMWUy6iQnYt2amynx4tJtFdrczmiK2677PHxAPKIYqYadGvRNfWCzUC/R5hdoONl+
         VYCsyZU3vdG0XSbo3GYoLai0wO4fZzuTcs0+YbL+G+iuq8SqcDgBLd5qzFbsLQ8dNj12
         iYXBP1XzKuhDeDD8ForZp52rV8GloGWweKOtxNajofkVlGIByZwjBSHKbT3NOP2vfwnC
         jJ6bCEPER8ZV+M8QntmpA7wDxLkrKt2n8nzwZGPKwPpvQGC4LwdRaDZ4OISCYueDpuLF
         xx+A==
X-Gm-Message-State: AOAM532pj1D/7Jog1MUrK0Hrc8+/FX7FcsQyzizWDnxSxMHXFv2Uu+fZ
        o4yAq8Yj+s54068vBgKhmV0=
X-Google-Smtp-Source: ABdhPJyfOzJGwTUDwgcZTLmFS1lc6/QeQ+Ig43q40Kd5rQQFpKZziM4sJzXi3z7oppp69E6pL9tIPQ==
X-Received: by 2002:a05:6512:3501:: with SMTP id h1mr2607048lfs.446.1635405978604;
        Thu, 28 Oct 2021 00:26:18 -0700 (PDT)
Received: from mobilestation ([95.79.132.211])
        by smtp.gmail.com with ESMTPSA id r7sm226300lfc.106.2021.10.28.00.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 00:26:18 -0700 (PDT)
Date:   Thu, 28 Oct 2021 10:26:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] dt-bindings: spi: Add compatible for Pensando
 Elba SoC
Message-ID: <20211028072616.p3mazud3vi5jgynk@mobilestation>
References: <20211025015156.33133-1-brad@pensando.io>
 <20211025015156.33133-5-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025015156.33133-5-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Brad

The patch name "dt-bindings: spi: Add compatible for Pensando Elba
SoC" doesn't mention to what bindings it is referring to. For the sake
of having a more representative git log I'd suggest at least to add
"cdns" vendor name in the title, like: "dt-bindings: spi: cdns: Add ..."
Otherwise it's impossible to understand to what bindings you're adding
a new compatibility especially seeing you are doing the similar thing
for the DW SPI in the next patch.

-Sergey

On Sun, Oct 24, 2021 at 06:51:49PM -0700, Brad Larson wrote:
> Document the cadence qspi controller compatible for Pensando Elba SoC
> boards.  The Elba qspi fifo size is 1024.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> index 0e7087cc8bf9..d4413eced17a 100644
> --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> @@ -20,6 +20,7 @@ properties:
>                - ti,k2g-qspi
>                - ti,am654-ospi
>                - intel,lgm-qspi
> +              - pensando,elba-qspi
>            - const: cdns,qspi-nor
>        - const: cdns,qspi-nor
>  
> @@ -38,7 +39,7 @@ properties:
>      description:
>        Size of the data FIFO in words.
>      $ref: "/schemas/types.yaml#/definitions/uint32"
> -    enum: [ 128, 256 ]
> +    enum: [ 128, 256, 1024 ]
>      default: 128
>  
>    cdns,fifo-width:
> -- 
> 2.17.1
> 
