Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DAD39CAE8
	for <lists+linux-spi@lfdr.de>; Sat,  5 Jun 2021 22:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFEUcy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Jun 2021 16:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFEUcw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 5 Jun 2021 16:32:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEACC061766;
        Sat,  5 Jun 2021 13:30:48 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k7so19813842ejv.12;
        Sat, 05 Jun 2021 13:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bg6i0ht+HMTqf2MEiGJ2dT2cOYKn1ScteYwQvOOu/BI=;
        b=KUfurtWGI2CyAvYaKYNKXA8d9YImp4I9JoHKPCJcuGmUi50loiQJ/8hCJB9oWbsuSi
         Gx4Wpl/gLbZqOdtVXhMBSGIHxS6EPV8ha4GsaWyHjPeVQM/Vo/QfWTWHjOH4cuytLG3l
         2O9+qO1JZ9eBTz3CHAZW6hQDOQOtyQAc9Uo6h7t+nuUv8gIe3KF93ItkfrrPlUxyjB0j
         p9vIaQwTos5HvIBa8/UFsyycvsJwfc44mEkkqlhlb9mh8noe1mNRB5XGV9ktOZUSq5Iq
         5XA8PCp7xdcuxR+KP7Er66G2zlEXwCmIB14LRo3w1hZ//kAxKdQLtoioi2KR/8Gstq7C
         nF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bg6i0ht+HMTqf2MEiGJ2dT2cOYKn1ScteYwQvOOu/BI=;
        b=GVbmwWCiHOQG3BSPe9EHgCNS+CGGBzaEIXxZLOUAYA7C82zpOHRBwGQyuyQOUjta0T
         bUs7hSx+J/35T1r39rasMO7uQG9/PQttLL2xzrmYQvbMN40mueb/qTTXuxvzBU14xM7Q
         zdDPwoy34/vMtyHgO5rvLXxDtjbR1YQytBO0KY9inKMBS6cuPwoSAdfPTZqa8EFtWfPM
         C8a+HvjtEB40nEUvJE88SLj57yy+7ZyOF+HNNGPPeYVH8ciM8w/6mxW8scO+P8da2ZFA
         +xzGudXAz3UmuHpk57jqwQMBus5NTL6fRkzhb4E0n5CEbzkiFei/j+FsD9A91aZSRBgL
         NOYg==
X-Gm-Message-State: AOAM530V9mbMT1sa+sadsKAG2t11JISjX3dCP2If7QxNCschTZGaAzGp
        UlQ0OKaZQEMss6YsS/OcD6s=
X-Google-Smtp-Source: ABdhPJyEc3sDGxfTIsX3mhX+VIkW45KefcxZqIhQFILfxm9/TYUXTvOkLL/THitEgVSj3veLwgE63g==
X-Received: by 2002:a17:906:9512:: with SMTP id u18mr10463117ejx.61.1622925042740;
        Sat, 05 Jun 2021 13:30:42 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k21sm5301351edo.41.2021.06.05.13.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Jun 2021 13:30:42 -0700 (PDT)
Subject: Re: [PATCH v3 3/8] dt-bindings: spi: spi-rockchip: add description
 for rv1126
To:     Jon Lin <jon.lin@rock-chips.com>, broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@esmil.dk
References: <20210605094659.13507-1-jon.lin@rock-chips.com>
 <20210605094659.13507-3-jon.lin@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <4d60a524-5a54-f972-7605-25db3b825cfa@gmail.com>
Date:   Sat, 5 Jun 2021 22:30:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210605094659.13507-3-jon.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jon,

Some comments. Have a look if it's useful.

===

In order to get this patch reviewed by rob+dt you must include:
robh+dt@kernel.org
devicetree@vger.kernel.org

Check your review status here:
https://patchwork.ozlabs.org/project/devicetree-bindings/list/

Get the other lists and maintainers with:
./scripts/get_maintainer.pl --noroles --norolestats --nogit-fallback
--nogit <patch1> <patch2>

===

Please try to order patches like:
(1) dt-binding - compatible addition
(2) driver patches
(3) devicetree node patches

The script below gives a warning if the wrong order is used.
./scripts/checkpatch.pl --strict <patch1> <patch2>

===

The [PATCH v3 2/8] has duplicate Signed-off-by's.

Signed-off-by: Jon Lin <jon.lin at rock-chips.com>
Signed-off-by: Jon Lin <jon.lin at rock-chips.com>

What has changed in version 3 ?
Maybe add a cover letter and a change log too?
git format-patch -v4 -8 --cover-letter HEAD
===

The commit message in [PATCH v3 4/8] has to many "applications", so
maybe restyle a bit?

Add compatible string for rv1126 to applications for potential
applications.

Adding "rockchip,rv1126-spi" to rockchip_spi_dt_match[] is strictly not
needed when using "rockchip,rk3066-spi" as fall back string.
Could a maintainer advice?

Maybe this bug of mine should revert too?? Or is it legacy? ;)
spi: rockchip: add compatible string for px30 rk3308 rk3328
https://lore.kernel.org/r/20200309151004.7780-1-jbx6244@gmail.com

===

Johan

On 6/5/21 11:46 AM, Jon Lin wrote:
> The description below will be used for rv1126.dtsi in the future
> 
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> index 1e6cf29e6388..4ed5b72a8494 100644
> --- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
> @@ -27,6 +27,7 @@ properties:
>        - items:
>            - enum:
>                - rockchip,px30-spi

> +              - rockchip,rv1126-spi

Sort alphabetically.

>                - rockchip,rk3188-spi
>                - rockchip,rk3288-spi
>                - rockchip,rk3308-spi
> 
