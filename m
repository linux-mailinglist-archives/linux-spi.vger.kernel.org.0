Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00BF81866C7
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 09:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgCPIoP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 04:44:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44618 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgCPIoP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 04:44:15 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02G8hE44121930;
        Mon, 16 Mar 2020 03:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584348194;
        bh=kFdEoCHU6eRacjLcxiP9sKp6oWTiEshU4OrA1P2u8Fw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=J10R4vh7hYNZqb1zd6gZow5kPEKiVagRH1eiUJ7Ai5j4OV/CjC9OZ1ATS9CD8vZCh
         Dmz+cWZZ1F2ctNW1ZH2546m2n95Cyhy6bpiB+OZKsbRhSop3x8ZU5oUWHsvExpq43v
         d9LhcAc+xKrk9Z/iBMv5i33vVBCGgtWGpeMYvYig=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02G8hEn1045978;
        Mon, 16 Mar 2020 03:43:14 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Mar 2020 03:43:13 -0500
Received: from localhost.localdomain (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Mar 2020 03:43:14 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02G8gkl3068652;
        Mon, 16 Mar 2020 03:42:48 -0500
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
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <a634d733-4b88-9d5a-09a1-c9551d8a077a@ti.com>
Date:   Mon, 16 Mar 2020 10:42:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316082607.GA18510@ravnborg.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 16/03/2020 10:26, Sam Ravnborg wrote:

>> Isn't this also compatible with panel-simple bindings? 'label' is the only
>> one not in panel-simple, but that's optional and has never been used by the
>> panel driver.
> The panel is a SPI slave - which is not too obvious from the old
> binding.
> 
> The new DT Schema includes spi/spi-slave.yaml to give the binding
> proper access to the spi slave properties.
> 
> That would not be possible with panel-simple binding as no further
> properties are allowed with the panel-simple binding.
> 
> I hope this explains why there is a dedicated binding for this panel.

Hmm, but how is this different than, say, DSI panels? There are DSI panels in panel-simple bindings, 
and those might require DSI bus parameters ('reg' in the minimum).

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
