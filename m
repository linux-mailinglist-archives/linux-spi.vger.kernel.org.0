Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEC128ED50
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 09:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgJOHBn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Oct 2020 03:01:43 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33902 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgJOHBn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Oct 2020 03:01:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id d28so2033693ote.1;
        Thu, 15 Oct 2020 00:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPLUR88amB7KBARO7+kMfSt7cx4viHKBRUai+VtfqT4=;
        b=psV0umtNbcGawPMDyo3RJpMjXj/nl+VmWnFSstYHKU4a/C2VtSCOfS4QE93NFU6R47
         h2wayFzj1Llw9J4XGblvKYF0LEBubogeuvnoElXd6+WJ1l8SPWtAnWn20yLxvQZTTD+R
         VIRaheYYiu40jzssOhoKQCC6DIxBfmQOAoWeTIQ4JGvrcXkaK7N15/VSOmx1sc7e9ZBh
         XNP00iW+189w3NIY2HozkxM6Z62jeuGGxwHJAsN6oEBMupZzwJN8JVo5qNK+yzmIPyUT
         m0PCSLfoutixp+BhdygOAQ7v12awtdy9mGF0ftDLQwKgJZLRuoXT7AK1PhPSQEMvVzVW
         5U0w==
X-Gm-Message-State: AOAM530TTNpxsC4gY6/IZP8VrRhLaG4GoKOpe9VZot1OPmmPs9XxPVkK
        0GJCVat9eM3qBCHmUwIYdMP81lCGHKHdwjLCceo=
X-Google-Smtp-Source: ABdhPJw/Ad6i6yr+PF7fjWW8q0TTSdHShD5ypNJBORc48VBWqXaAcZ89lIVXq4AjQaIajAOjvjZDRUmA7xIhuGKEGVA=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr1743996otb.250.1602745301068;
 Thu, 15 Oct 2020 00:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201015044443.1828-1-thunder.leizhen@huawei.com> <20201015044443.1828-2-thunder.leizhen@huawei.com>
In-Reply-To: <20201015044443.1828-2-thunder.leizhen@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Oct 2020 09:01:29 +0200
Message-ID: <CAMuHMdX6qLJbk=ik1CoqbycrLSr+vMwzpY6esnKRpXsTxaiSAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: misc: add support for both property
 names cmd-gpios and cmd-gpio
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Zhen,

Thanks for your patch!

On Thu, Oct 15, 2020 at 6:52 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> The definition "gpio_suffixes[] = { "gpios", "gpio" }" shows that both
> property names "cmd-gpios" and "cmd-gpio" are supported. But currently
> only "cmd-gpios" is allowed in this yaml, and the name used in
> mmp2-olpc-xo-1-75.dts is cmd-gpio. As a result, the following errors is
> reported.
>
> slave: 'cmd-gpios' is a required property
> slave: 'cmd-gpio' does not match any of the regexes: 'pinctrl-[0-9]+'
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> index b3c45c046ba5e37..dd549380a085709 100644
> --- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> @@ -24,15 +24,21 @@ properties:
>    compatible:
>      const: olpc,xo1.75-ec
>
> -  cmd-gpios:
> +  spi-cpha: true
> +
> +patternProperties:
> +  "^cmd-gpio[s]?$":
>      description: GPIO uspecifier of the CMD pin
>      maxItems: 1

In general, the *-gpio form is deprecated.  So why complicate the DT
bindings by adding support for deprecated properties?

  1. Explicitly allowing deprecated properties means new users may be
     added,
  2. Once all in-tree DTS files are converted, the warnings will be gone
     anyway,
  3. Out-of-tree DTB will still work, as it's very unlikely support for
     the "gpio" suffix can/will be dropped anytime soon,
  4. If anyone runs the validator on out-of-tree DTS files, the most
     probable intention is to fix any detected issues anyway, and the
     files can be updated, too,
  5. If any out-of-tree code or tooling relies on the *-gpio form, it
     may already be broken.

> -  spi-cpha: true
> -
>  required:
>    - compatible
> -  - cmd-gpios
> +
> +oneOf:
> +  - required:
> +      - cmd-gpio
> +  - required:
> +      - cmd-gpios
>
>  additionalProperties: false

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
