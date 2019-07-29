Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F38A57881A
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2019 11:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfG2JPz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jul 2019 05:15:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46573 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfG2JPz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Jul 2019 05:15:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so60942688wru.13;
        Mon, 29 Jul 2019 02:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lX+8f/ul557VUvmKfQ5/rLyi40udmS9GdSHCWxQEpMY=;
        b=Ytr4b5inOd6rHWzdTBUm+jO64HpHkm9J6gtxtJiO0HuUOqtHqyuDJmJICItykEpa6K
         BgHwfKnnm87fYOKc4MlyOmu4AUW0xjODEQgkLp5WjmGbCK++ZtofKmdXLfaLcfc2gvhJ
         W+XrYXo/P47eSeeZYkx7AoiLsQ0vK5yCwRoiVgcIJjmwxTKXgRM3w+A6NASYHpSKH90K
         Qzgb5HHO9w+Vab0Ezs29ERQDt9ywqzn9580cWaTAljbo2f9srMFBky59DbU7si+UKBi0
         LVFJMx8pSf4tYtP735sZoCgSPG2rwZlwbfLKrhFnRMbKrvEHQDW+UZPEs7up1gB7XoFV
         Tu0w==
X-Gm-Message-State: APjAAAWq7vWYZ4sSB4uyZvUM57ObVsD02+lkUyZlT+W85SxVcV+WHcPA
        EpDQw7hpVcsPbFKSmJvdw7zD2r5iRemqLgk8a2A=
X-Google-Smtp-Source: APXvYqxGx0Im9VeJH1b6YeB64dzXITkccBaAUZ+m0f2WtWbs7Fi1L9DQElT8KAMMrGxdtE1jg7uiYwM1yPygWtq4cjE=
X-Received: by 2002:adf:cd81:: with SMTP id q1mr117458151wrj.16.1564391752564;
 Mon, 29 Jul 2019 02:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <1564108975-27423-1-git-send-email-masonccyang@mxic.com.tw> <1564108975-27423-3-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1564108975-27423-3-git-send-email-masonccyang@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 11:15:40 +0200
Message-ID: <CAMuHMdWVuQa1LLXPqrdSw6wdRzwQapAkk6Est=XrjESPF9zQwg@mail.gmail.com>
Subject: Re: [PATCH v15 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, juliensu@mxic.com.tw,
        Simon Horman <horms@verge.net.au>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

Thanks for the update!

On Fri, Jul 26, 2019 at 4:19 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Dcument the bindings used by the Renesas R-Car Gen3 RPC-IF controller.

Document

>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Reviewed-by: Rob Herring <robh@kernel.org>

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> @@ -0,0 +1,46 @@

[...]

> +- flash: should be represented by a subnode of the RPC-IF node,
> +        which "compatible" property contains "jedec,spi-nor", it presents
> +        SPI is used.

Sorry, I failed to parse the last subsentence.

> +
> +Example:
> +
> +       rpc: spi@ee200000 {
> +               compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
> +               reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
> +                     <0 0xee208000 0 0x100>;
> +               reg-names = "regs", "dirmap", "wbuf";
> +               clocks = <&cpg CPG_MOD 917>;
> +               clock-names = "rpc";
> +               power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +               resets = <&cpg 917>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               flash@0 {
> +                       compatible = "jedec,spi-nor";
> +                       reg = <0>;
> +                       spi-max-frequency = <40000000>;
> +                       spi-tx-bus-width = <1>;
> +                       spi-rx-bus-width = <1>;

Shouldn't those <1> be <4>, as this is QSPI?

> +               };
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
