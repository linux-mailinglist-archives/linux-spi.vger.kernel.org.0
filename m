Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658C118678F
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 10:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgCPJMm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 05:12:42 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58130 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbgCPJMm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 05:12:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02G9Bh1S128532;
        Mon, 16 Mar 2020 04:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584349903;
        bh=BRFzpuMCnG0xdJJBx3HV4nOkWF/JKYLqvn+omLsF8yg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=d1to8fGLuhLhKXAixyw2Z3iuYaFWUh1GPlGJyscMNEg1onSB+0DEe/F1EUaNldVb0
         YQ9Q9dXPK8t7YxO+0zPbuJV466ixMVoNxz3XX3It44IJc7CH+qLarj6NkbYVhipELH
         0g2Vl/5yLBpswY147CMrGOUgM4HtFkJ4iQK5OO1Y=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02G9BhVR082753
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Mar 2020 04:11:43 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Mar 2020 04:11:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Mar 2020 04:11:42 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02G9BGFN086028;
        Mon, 16 Mar 2020 04:11:18 -0500
Subject: Re: [PATCH v1 35/36] dt-bindings: display: convert lgphilips,lb035q02
 to DT Schema
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
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
 <a73da9d3-43b2-3ce7-85e9-8135dbf48e98@ti.com>
 <20200316082607.GA18510@ravnborg.org>
 <a634d733-4b88-9d5a-09a1-c9551d8a077a@ti.com>
 <20200316085311.GA19201@ravnborg.org>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <3bf96f0e-90a8-1513-800f-0168d912fd9f@ti.com>
Date:   Mon, 16 Mar 2020 11:11:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316085311.GA19201@ravnborg.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 16/03/2020 10:53, Sam Ravnborg wrote:

> We have panel-simple-dsi for DSI simple based panels.
> This binding includes the reg property.
> 
> If we have included DSI panels in panel-simple.yaml, and we likely have
> by accident, then they should be moved to panel-simple-dsi.yaml.
> 
> If they requires anything else then they shall have their
> own binding.
> 
> panel-simple.yaml and panel-simple.dsi.yaml are on purpose
> only for the simple panels and they have:
> "additionalProperties: false" to avoid that a lot
> of extra sneaks in.
> 
> I actually considered shortly a panel-simple-spi.yaml,
> but the few panels I looked at had different names
> for the power-supply so that did not fly.
> I did not check them all - we have today (with this patch-set)
> 9 bindings that references spi-slave.yaml.

Okay, I understand now. Makes sense.

panel-simple.c has dsi_of_match, which lists DSI panels. I was looking at that when I said 
panel-simple binding has DSI panels. At least auo,b080uan01 and osddisplays,osd101t2045-53ts are 
there, and earlier in this series you moved osddisplays,osd101t2587-53ts to panel-simple bindings.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
