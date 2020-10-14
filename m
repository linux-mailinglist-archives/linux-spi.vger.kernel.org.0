Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6FD28E1AE
	for <lists+linux-spi@lfdr.de>; Wed, 14 Oct 2020 15:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388653AbgJNNuW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Oct 2020 09:50:22 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41202 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgJNNuV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Oct 2020 09:50:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id q136so3267447oic.8;
        Wed, 14 Oct 2020 06:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T+lXWYZNK3Q/86DTyObhFOK72+nQRALeWr13HjYTpkA=;
        b=BUXkctr/cJA0sCd2qSPqBRJOSYhxRU5OKyr8UlMbAgTlXsGZJfEDNBCo6HaJAmVlyC
         3ssELGWk9iDW8aj2UIFagrn/0NqcVpYIiFR4c68YmZ4Orwl6fgt7YEI8qVcoMs1yAigz
         kQzuxYW3/B4SjqEdKkgwi5mnWGnkJXkZwThN0pVH+Xjpvn7aK9iGa80SGyjTzEH4g2dw
         /KHo5UcSzvZnSO98fuh8oDPMep7DBwWzGl0c6Tz/EDyb8fqUB3MLCBVcg6IbrvYpsk3l
         vApGAc7l0fCb2HsgIJ5qhImJH69DZwKN/xmY6L985bYWyvuZGeKmLu8un8V2j20dtNWf
         tosg==
X-Gm-Message-State: AOAM531qYP8Dfm4uejRmO7mSklg17BNV5EUfh7lSUfdoADbg2v9F+qZW
        BFxe/Yfld6dzi8BU0o2/AA==
X-Google-Smtp-Source: ABdhPJwBwzjfoCwN+5C7fXVadoxI98n+WgVzrNbDfrKV3BDTP85OLoUwNnnp9bI2euXzw7/77YIU8Q==
X-Received: by 2002:aca:54c2:: with SMTP id i185mr2099742oib.169.1602683420675;
        Wed, 14 Oct 2020 06:50:20 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h5sm1211010otb.11.2020.10.14.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 06:50:19 -0700 (PDT)
Received: (nullmailer pid 1576100 invoked by uid 1000);
        Wed, 14 Oct 2020 13:50:19 -0000
Date:   Wed, 14 Oct 2020 08:50:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>,
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
Subject: Re: [PATCH 6/6] dt-bindings: misc: correct the property name
 cmd-gpios to cmd-gpio
Message-ID: <20201014135019.GA1563910@bogus>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
 <20201013160845.1772-7-thunder.leizhen@huawei.com>
 <bda5f620-7140-51fb-fadd-6ebd3c0db935@ti.com>
 <4f5f9b55-9fad-9318-82d4-6b258643738b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f5f9b55-9fad-9318-82d4-6b258643738b@huawei.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 14, 2020 at 09:29:26AM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2020/10/14 1:32, Dan Murphy wrote:
> > Zhen
> > 
> > On 10/13/20 11:08 AM, Zhen Lei wrote:
> >> The property name used in arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts is
> >> cmd-gpio.
> >>
> >> arch/arm/boot/dts/mmp2-olpc-xo-1-75.dts:235:
> >> cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>   Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> >> index b3c45c046ba5e37..c7a06a9650db2ed 100644
> >> --- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> >> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
> >> @@ -24,7 +24,7 @@ properties:
> >>     compatible:
> >>       const: olpc,xo1.75-ec
> >>   -  cmd-gpios:
> >> +  cmd-gpio:
> > 
> > Preference is gpios not gpio. But Rob H accept or reject
> 
> Look at the search result below. It seems that the driver have not been merged into mainline.

Yes, in drivers/platform/olpc/olpc-xo175-ec.c.

Your mistake is the gpiod api takes just 'cmd' as the GPIO core handles 
both forms.

> But the property name is really used as cmd-gpio at mmp2-olpc-xo-1-75.dts:235, I don't think
> the mmp2-olpc-xo-1-75.dts can make a mistake. Otherwise, the driver will not work properly.
> Meanwhile, Both names cmd-gpios and cmd-gpio seem to be in use. But I prefer cmd-gpio, after
> all, only one gpio is assigned now. The motorola,cmd-gpios add "s" because it contains 3 gpio.

The preference is it is always '-gpios' just like it's always 
'interrupts' or 'clocks'.

However, whether to change this is really up to the OLPC folks. Given 
the driver has always supported both forms, it should be okay to change 
the dts. Though there could be other users besides the kernel.

Rob
