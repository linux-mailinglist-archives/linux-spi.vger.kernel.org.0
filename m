Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23B1A18AB24
	for <lists+linux-spi@lfdr.de>; Thu, 19 Mar 2020 04:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCSDZe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 18 Mar 2020 23:25:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34184 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSDZe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 18 Mar 2020 23:25:34 -0400
Received: by mail-io1-f67.google.com with SMTP id h131so817781iof.1;
        Wed, 18 Mar 2020 20:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S5anLZMsOzXiKSI2Q9qRVRtZTctavZWErUY+Qb7ZPsA=;
        b=WVOnNaNIU3/QVeBTogfuOfWJKN6u/lEFPtCmEJXtoLZ/ho8Rx43TivxBUBA9+GQAwb
         Zj/dKoKJk+Q/LdZjUGpbMeFS0nhiiCdm75DdLPax3IF4gmD3hWuqHsxVPp1334GDwG7a
         cCjRFKGb4V8ZaCsrhGleK0GFb/P9FcvThSv57yC5bZpzo8ikCYTRG03hdyYzOkwKdXZ4
         BwREfQqdPu7GXUV+u9TdQfh3cRHg0vdtGCeyjzbzdwnHWdbYPg5grwD4cpqaWlm351co
         P72x1InXGjErg56yy5V81pFYj/wE3dnwL4g42eyjfDOR13cFlah2LanZzFaYVoxKeMah
         W4KA==
X-Gm-Message-State: ANhLgQ347JTqiqgrT1I6T6b1gugqoVvdU3EkgHCXVyN+PX2iwgcGU/H5
        bS439bLwdNhPQWbt5QtU9Q==
X-Google-Smtp-Source: ADFU+vtb+ZlxkqiuBeBUxhCr8h7Qq0fvdiDR6y3QBh9G3qX9Tx4a1iQ8P++RaCdhLuk3JsPDPmjTEA==
X-Received: by 2002:a02:ac90:: with SMTP id x16mr1231418jan.12.1584588333327;
        Wed, 18 Mar 2020 20:25:33 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t86sm335763ili.82.2020.03.18.20.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 20:25:32 -0700 (PDT)
Received: (nullmailer pid 31095 invoked by uid 1000);
        Thu, 19 Mar 2020 03:25:28 -0000
Date:   Wed, 18 Mar 2020 21:25:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Brian Masney <masneyb@onstation.org>,
        Chris Zhong <zyw@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guido Gunther <agx@sigxcpu.org>, Heiko Schocher <hs@denx.de>,
        Nikolaus Schaller <hns@goldelico.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lin Huang <hl@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, Marco Franchi <marco.franchi@nxp.com>,
        Marek Belisko <marek@goldelico.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Peter Rosin <peda@axentia.se>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sandeep Panda <spanda@codeaurora.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Werner Johansson <werner.johansson@sonymobile.com>
Subject: Re: [PATCH v1 0/36] dt-bindings: display: convert remaning panel
 bindings to DT Schema
Message-ID: <20200319032528.GL29911@bogus>
References: <20200315134416.16527-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-1-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 15, 2020 at 02:43:40PM +0100, Sam Ravnborg wrote:
> Convert remaining(*) panel bindings to DT Schema.
> 
> To prepare for the migration a few preparations
> patches was required:
> 
> - te-gpios is now added to panel-common - as this
>   property is used by a few bindings.
> 
> - The slave part of spi-controller.yaml was migrated to a
>   new file spi-slave.yaml.
>   This was done so spi slaves in panel/ could include
>   this file rather than duplicate property names.
>   => Please review this carefully!
> 
> 
> The original author of the panel bindings are listed as maintainer
> in the DT Schema. In the few cases the panel binding was also
> listed in MAINTAINERS I checked that there was a match.
> It was done manually so I may have missed someone.
> 
> All bindings pass dt_binding_check with no warnings.
> 
> - "dt-bindings: display: convert ilitek,ili9322 to DT"
>   The .txt file listed some constrains that I did not manage
>   to capture in the DT Schema.
>   And some properties looks like that could be dropped.
>   => Please take a closer look.
> 
> - "dt-bindings: display: convert sharp,lq101r1sx01 to DT Schema"  
>   The .txt file describes some constrains, as some properties
>   are mandatory for the main challen, but not allowed
>   for the secondary channel.
>   These constraints are not matched in the DT Schema.
>   => Any hints how to do this would be appreciated.
> 
> 
> Patches made on top of drm-misc-next as of today with no other patches.
> 
> (*) Two .txt files reamins:
> - display-timing.txt, points to display-timings.yaml
> - panel-dsi-cm.txt, conversion is included in another patch-set
> 
> 	Sam
> 
> Sam Ravnborg (36):
>       dt-bindings: display: add te-gpios to panel-common
>       dt-bindings: spi: support non-spi bindings as SPI slaves
>       dt-bindings: display: convert samsung,s6e63m0 to DT Schema
>       dt-bindings: display: convert arm,versatile-tft-panel to DT Schema
>       dt-bindings: display: convert boe,himax8279d to DT Schema
>       dt-bindings: display: convert ilitek,ili9322 to DT Schema
>       dt-bindings: display: convert ilitek,ili9881c to DT Schema
>       dt-bindings: display: convert feiyang,fy07024di26a30d to DT Schema
>       dt-bindings: display: convert innolux,p079zca to DT Schema
>       dt-bindings: display: convert innolux,p097pfg to DT Schema
>       dt-bindings: display: convert innolux,p120zdg-bf1 to DT Schema
>       dt-bindings: display: convert jdi,lt070me05000 to DT Schema
>       dt-bindings: display: convert kingdisplay,kd035g6-54nt to DT Schema
>       dt-bindings: display: convert kingdisplay,kd097d04 to DT Schema
>       dt-bindings: display: convert simple lg panels to DT Schema
>       dt-bindings: display: convert lg,lg4573 to DT Schema
>       dt-bindings: display: convert osddisplays,osd101t2587-53ts to DT Schema
>       dt-bindings: display: convert raydium,rm67191 to DT Schema
>       dt-bindings: display: convert rocktech,jh057n00900 to DT Schema
>       dt-bindings: display: convert samsung AMOLED to DT Schema
>       dt-bindings: display: convert samsung,s6d16d0 to DT Schema
>       dt-bindings: display: convert samsung,ld9040 to DT Schema
>       dt-bindings: display: convert samsung,s6e8aa0 to DT Schema
>       dt-bindings: display: convert toppoly panels to DT Schema
>       dt-bindings: display: convert startek,startek-kd050c to DT Schema
>       dt-bindings: display: convert sony,acx565akm to DT Schema
>       dt-bindings: display: convert sitronix,st7701 to DT Schema
>       dt-bindings: display: convert sitronix,st7789v to DT Schema
>       dt-bindings: display: drop unused simple-panel.txt
>       dt-bindings: display: convert sharp,ls043t1le01 to DT Schema
>       dt-bindings: display: convert sharp,lq101r1sx01 to DT Schema
>       dt-bindings: display: convert sharp,ls037v7dw01 to DT Schema
>       dt-bindings: display: convert sharp,lq150x1lg11 to DT Schema
>       dt-bindings: display: convert seiko,43wvf1g to DT Schema
>       dt-bindings: display: convert lgphilips,lb035q02 to DT Schema
>       dt-bindings: display: convert olimex,lcd-olinuxino to DT Schema

I've gone rather quickly thru the series. Other than what I commented 
on, the rest look fine generally. There may be a couple with similar 
comments.

Rob
