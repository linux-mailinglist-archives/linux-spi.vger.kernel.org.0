Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E621242732F
	for <lists+linux-spi@lfdr.de>; Fri,  8 Oct 2021 23:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbhJHVt4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 Oct 2021 17:49:56 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:40786 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243487AbhJHVt4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 Oct 2021 17:49:56 -0400
Received: by mail-oi1-f175.google.com with SMTP id n63so15456961oif.7;
        Fri, 08 Oct 2021 14:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z6zpljNARaGHtMTY8U/C/Gg2k98fznp34I6cu4S6oKY=;
        b=fa5pgzT6MimRwjW0ngUewAKXLq9/49Tfls4rVy+ZKLUxBeN3BypiSsgDQ8DzefFemT
         WLKkzYdg/YREWlMzImMnPg8qGzN0IpIMeQLhwLzXFCgC0rlW51AjV/wygCrZWJVqch8M
         DIF7j08MSAsC3ncdCMeFgYu2Txyo3l1xYXr1lieWpkVheJ317NS1yzpGAjgfnrrbNGIi
         zyAuCwtdoWG323C8LHw+6u19vlCDqVSGmKSOjGOFU7I0EtY5PG9lPGNRD/b0FAm1El+z
         ipZPX7ab18ip3hIpD/04SJbThFe2vxXU0J9/o0lCjVZIMkIUEcQJ836xilPKUHUwPVVX
         MOSA==
X-Gm-Message-State: AOAM532wmMgWtcUtopE1sYf1O63djBATt/oqPku+R0adKgvJ/DPQqgYF
        sta7H46GGbv6Q31PYcz/mQ==
X-Google-Smtp-Source: ABdhPJwN6oUmR44GNmTiOfpQO6Lr/nsoWADh8JwxBTNvETEEo6KpwBwFga3dvo/t5qqpV60sNu7g0A==
X-Received: by 2002:a05:6808:bc5:: with SMTP id o5mr7019964oik.129.1633729679930;
        Fri, 08 Oct 2021 14:47:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a13sm141625oiy.9.2021.10.08.14.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:47:59 -0700 (PDT)
Received: (nullmailer pid 3372749 invoked by uid 1000);
        Fri, 08 Oct 2021 21:47:58 -0000
Date:   Fri, 8 Oct 2021 16:47:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaimeliao@mxic.com.tw,
        juliensu@mxic.com.tw,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [RFC PATCH 03/10] dt-bindings: vendor-prefixes: Update Macronix
 prefix
Message-ID: <YWC8jgI74FgTudSD@robh.at.kernel.org>
References: <20211008162228.1753083-1-miquel.raynal@bootlin.com>
 <20211008162228.1753083-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008162228.1753083-4-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 08, 2021 at 06:22:21PM +0200, Miquel Raynal wrote:
> When looking at compatible prefixes, Macronix is sometimes referred as
> mxicy:
> - mxicy,mx25r1635f
> - mxicy,mx25u6435f
> - mxicy,mx25v8035f
> - mxicy,mx25f0a-spi
> and sometimes as mxic:
> - mxic,multi-itfc-v009-nand-controller
> - mxic,enable-randomizer-otp
> 
> It looks like the more up-to-date way is mxic so declare this prefix and
> mark the other one as deprecated.

mxicy is more widely used with flash parts. There's not a single dts 
file with 'mxic' which only seems to be some nand controller.

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index b868cefc7c55..013a87850cd5 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -758,8 +758,11 @@ patternProperties:
>      description: Mundo Reader S.L.
>    "^murata,.*":
>      description: Murata Manufacturing Co., Ltd.
> +  "^mxic,.*":
> +    description: Macronix International Co., Ltd.
>    "^mxicy,.*":
>      description: Macronix International Co., Ltd.
> +    deprecated: true
>    "^myir,.*":
>      description: MYIR Tech Limited
>    "^national,.*":
> -- 
> 2.27.0
> 
> 
