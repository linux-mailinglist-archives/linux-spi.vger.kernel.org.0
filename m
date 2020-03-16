Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23C91865FF
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 08:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgCPH7P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 03:59:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37992 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgCPH7O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 03:59:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02G7w7AE022983;
        Mon, 16 Mar 2020 02:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584345487;
        bh=mcWkbNPWh/2PXHoPkSBYQddXrK0IplJSV8yBDgZQONc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aFoHnLg7MQVVpkBH9fmdutDs1yHubfYsBf3X/Iak0rSvTCog+Qt+DHUxw4U90YvzU
         QOsEILyOVIU2TPr0zXQESD9qAmpmXiO2UFfFeDJLKWeYxZH+wjYwa+LhcSBxkOjhoE
         sV2L/RN7gogC/iK1ROKLg0EQ6yuwkGpK5Um19ohw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02G7w7Ut122468
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Mar 2020 02:58:07 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Mar 2020 02:58:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Mar 2020 02:58:06 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02G7vw2o049089;
        Mon, 16 Mar 2020 02:57:58 -0500
Subject: Re: [PATCH v1 35/36] dt-bindings: display: convert lgphilips,lb035q02
 to DT Schema
To:     Sam Ravnborg <sam@ravnborg.org>, <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>
CC:     Alexandre Courbot <acourbot@nvidia.com>,
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
        <linux-spi@vger.kernel.org>, Marco Franchi <marco.franchi@nxp.com>,
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
        Tony Lindgren <tony@atomide.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        Werner Johansson <werner.johansson@sonymobile.com>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-36-sam@ravnborg.org>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <a73da9d3-43b2-3ce7-85e9-8135dbf48e98@ti.com>
Date:   Mon, 16 Mar 2020 09:57:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200315134416.16527-36-sam@ravnborg.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sam,

On 15/03/2020 15:44, Sam Ravnborg wrote:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>   .../display/panel/lgphilips,lb035q02.txt      | 33 ------------
>   .../display/panel/lgphilips,lb035q02.yaml     | 54 +++++++++++++++++++
>   2 files changed, 54 insertions(+), 33 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt
>   create mode 100644 Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt b/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt
> deleted file mode 100644
> index 1a1e653e5407..000000000000
> --- a/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.txt
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -LG.Philips LB035Q02 Panel
> -=========================
> -
> -Required properties:
> -- compatible: "lgphilips,lb035q02"
> -- enable-gpios: panel enable gpio
> -
> -Optional properties:
> -- label: a symbolic name for the panel
> -
> -Required nodes:
> -- Video port for DPI input

Isn't this also compatible with panel-simple bindings? 'label' is the only one not in panel-simple, 
but that's optional and has never been used by the panel driver.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
