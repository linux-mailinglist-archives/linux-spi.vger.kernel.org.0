Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFA73A9F06
	for <lists+linux-spi@lfdr.de>; Wed, 16 Jun 2021 17:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhFPP2m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Jun 2021 11:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234622AbhFPP2l (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 16 Jun 2021 11:28:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B163E61356;
        Wed, 16 Jun 2021 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623857195;
        bh=3xXCvaDbNEswv4P3EZDSCt8erTYvLAXzHOYMuwuz1Ww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HivM+S84zqbzmTFEAzqlT7DIlrD7ebnQZxgTFVz5lbtq+pTmi1WdNB2HTkn0yNdUt
         cG1H1f0z5m4zSfT87xw8U+wiPep2IPvNOSl4cktPPnbgnbuVwjS3n7c1p/XSBSAHqV
         JgOGUyqYTJuzAlapllhHUgY2SHDouwwNw003wFkE+vc40BCq9OOaIIIWPH+nBjEN2q
         KRKo0HECZfgWedrP9iDhhNZ7iZv4xb3ZhL/HsWMVbjWjB8mN+qzDRI8z7q1Wczz2Xj
         ZWKfXZ/KT8xJBsNv8zYXXrJiGftXDL0ZDikWgbVHRr4Qx4MoggGsWFVtaTwehnu8rA
         7rxyz+gCub2DA==
Received: by mail-ej1-f41.google.com with SMTP id g20so4652145ejt.0;
        Wed, 16 Jun 2021 08:26:35 -0700 (PDT)
X-Gm-Message-State: AOAM531m1qbsjN8eUJ+nLEQVO+OAXJhTFe8Ds5FNN6pFu/kZYNkwZylQ
        O1mENsZz5x+/n9/s1OGlJeBSL5gFIfJv1SdK0A==
X-Google-Smtp-Source: ABdhPJz8r9vTMquViBFbsmX0qPQixhx4R2ORqm9BLcnS6feAH4JsnSA0IHrStdQYLfDT+jhlfZCtJ6LSbmlkepogdvk=
X-Received: by 2002:a17:907:264b:: with SMTP id ar11mr28912ejc.525.1623857194363;
 Wed, 16 Jun 2021 08:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210607111837.31074-1-jon.lin@rock-chips.com>
 <20210615032620.24769-1-jon.lin@rock-chips.com> <20210615032620.24769-2-jon.lin@rock-chips.com>
In-Reply-To: <20210615032620.24769-2-jon.lin@rock-chips.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Jun 2021 09:26:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJWzECC_=xm6OnB63ofnTQC_4VZZO-mhkiTJDYx=93fcw@mail.gmail.com>
Message-ID: <CAL_JsqJWzECC_=xm6OnB63ofnTQC_4VZZO-mhkiTJDYx=93fcw@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: spi: spi-rockchip: add description
 for rv1126
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     Mark Brown <broonie@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jun 14, 2021 at 9:26 PM Jon Lin <jon.lin@rock-chips.com> wrote:
>
> The description below will be used for rv1126.dtsi or compatible one in
> the future
>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> ---
>
> Changes in v7:
> - Fall back "rockchip,rv1126-spi" to "rockchip,rk3066-spi"
>
> Changes in v6:
> - Consider to compatibility, the "rockchip,rk3568-spi" is removed in
>   Series-changes v5, so the commit massage should also remove the
>   corresponding information
>
> Changes in v5:
> - Change to leave one compatible id rv1126, and rk3568 is compatible
>   with rv1126
>
> Changes in v4:
> - Adjust the order patches
> - Simply commit massage like redundancy "application" content
>
> Changes in v3:
> - Fix compile error which is find by Sascha in [v2,2/8]
>
>  Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
