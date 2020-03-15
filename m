Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E23A186091
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 00:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgCOXca (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 19:32:30 -0400
Received: from onstation.org ([52.200.56.107]:39268 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbgCOXca (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 15 Mar 2020 19:32:30 -0400
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 6D9F93E9FF;
        Sun, 15 Mar 2020 23:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1584315149;
        bh=FbK0reOI08bhfcRjNkK310nNC4o0NSk6b1rJcRSZCi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oF/o7HAUT4n4ymS9/DIilA7tqzIMjGM1yFQF1neXo/7t2YGxJuHVeR5u5QOL6QdSL
         U/Dv3n9thO0yyLZQNxtac+D36SKqRrO0wINQGj+m3E93vlBmtko23Hd37MhOJ8KYK7
         V9rzRrqwvwXC9XS1GH93hBUj/1VzXxF0rkXSoBiM=
Date:   Sun, 15 Mar 2020 19:32:26 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Alexandre Courbot <acourbot@nvidia.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
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
Subject: Re: [PATCH v1 15/36] dt-bindings: display: convert simple lg panels
 to DT Schema
Message-ID: <20200315233226.GA9344@onstation.org>
References: <20200315134416.16527-1-sam@ravnborg.org>
 <20200315134416.16527-16-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315134416.16527-16-sam@ravnborg.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 15, 2020 at 02:43:55PM +0100, Sam Ravnborg wrote:
> Add the lg panels that matches the panel-simple binding to
> panel-simple.yaml
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Brian Masney <masneyb@onstation.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>

Reviewed-by: Brian Masney <masneyb@onstation.org>
