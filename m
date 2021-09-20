Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C27411762
	for <lists+linux-spi@lfdr.de>; Mon, 20 Sep 2021 16:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbhITOqr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 10:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbhITOqr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 10:46:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B3FC061574;
        Mon, 20 Sep 2021 07:45:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b15so50440996lfe.7;
        Mon, 20 Sep 2021 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tuWyQBqXiUuLdjTaM4+1NWtk+RRPTol/u+OTKXZEEAY=;
        b=oitbjIV4r+cBWkH8uYuxmdfenP8UlTJpPo0TfTMbhgJdYc2TbwElWgAbosJI4TXzjY
         i6DaUpIqI0dSJD2+65Tpvvho3zD4Q4X0XnfqzbSOLgzuvZDHDaAgLVgGBLZ0pMCefTgZ
         Cvw6uOXrAvAfJXoxiPLvtbTfH2xrisGIA6Eh6yc393WWrwU55BPP1T2IsTGRj1opgGlA
         lEb0S2ONSc09GTiiqqCx3JPGraOGycK/D8eFVgFdiroBgBbLG9pG/sGmucWLwSFBpGTg
         HECYyVroTzhNrxzfb/poWpH1+6atchPDdA1zjySS3ohE9H8hhEAyoi7kbUrL2C4QIXjS
         9mBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tuWyQBqXiUuLdjTaM4+1NWtk+RRPTol/u+OTKXZEEAY=;
        b=I7avxgW1/wKXW6Yd4zY+vUjLcnwsf+g1rSYcT2FtEAHkSh98T7QrTI0r40aSRyyvqE
         owlRGcqnvnazqFnFPGz4eJvX1ntjLmY2VFBO4ugTqPxILURSX1wUhNOMLdry81tC758E
         oogjcgnkb6YYG5ZCYVVdKEvPkcRSv+HedtTkwGMajk7Z0N0UVQobGqfacp2/OAHBuo4R
         FTmFepXyEmkSXqOqhfW+Dz/d0voArHuzru+ErvG43sR4xx0YYVbHy631qnRx9zrOGq0I
         vv1VzbCahG9IfkkmjWbo0RrdFdQbl5E/C2zbmbvc9C83RXbyst80tnieQgSWFNA/1JYw
         Zshg==
X-Gm-Message-State: AOAM532KHN7/1TQB0Zxf2UwqV0EqRWt6hkgQKIRE6ylSUSL1G3sqW3zf
        b6uAAjhR4FQN5Gs/+uNAUds=
X-Google-Smtp-Source: ABdhPJwK0I9hP+SKpzutXB8R+blwaxUiqjIYiFSudus+Eh+S13Gs3cj38UFOVT0hJkL6cK5oZ4MuKg==
X-Received: by 2002:ac2:4c81:: with SMTP id d1mr19042396lfl.340.1632149047925;
        Mon, 20 Sep 2021 07:44:07 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id y17sm1286651lfh.73.2021.09.20.07.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 07:44:07 -0700 (PDT)
Date:   Mon, 20 Sep 2021 17:44:04 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, michael@walle.cc
Subject: Re: [PATCH v2 2/2] dt-bindings: snps,dw-apb-ssi: Use 'flash' node
 name instead of 'spi-flash' in example
Message-ID: <20210920144404.5vhynfdfukabxgav@mobilestation>
References: <20210920142713.129295-1-a-nandan@ti.com>
 <20210920142713.129295-3-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920142713.129295-3-a-nandan@ti.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 20, 2021 at 07:57:13PM +0530, Apurva Nandan wrote:
> Change the nodename in the example with spi-nand from 'spi-flash@1'
> to 'flash@1' to make the schema uniform with both spi-nand and spi-nor
> flashes. jedec,spi-nor.yaml uses 'flash@' nodename for spi-nor flashes,
> so make the spi-nand examples in dt-bindings use it too for uniformity.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Seems reasonable.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index ca91201a9926..d7e08b03e204 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -171,7 +171,7 @@ examples:
>        cs-gpios = <&gpio0 13 0>,
>                   <&gpio0 14 0>;
>        rx-sample-delay-ns = <3>;
> -      spi-flash@1 {
> +      flash@1 {
>          compatible = "spi-nand";
>          reg = <1>;
>          rx-sample-delay-ns = <7>;
> -- 
> 2.25.1
> 
