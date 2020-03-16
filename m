Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523C0187436
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 21:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbgCPUra (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 16:47:30 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37656 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732612AbgCPUra (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Mar 2020 16:47:30 -0400
Received: by mail-pj1-f65.google.com with SMTP id ca13so9316107pjb.2
        for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2020 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfmXc3xr7dDVUscjphZ9PfgG1CkRdszrgoIMj+cYGiM=;
        b=m0zS/nz+dh5DzW7OJtY1OyEysBJG0asBfU/zhzlY3bVTir7wJr8IvHqzL2txO7u8OP
         TwCkv0SgavWRtAimFcwroX34kVJs0fx7PJqKmCrABErjMKZa0rezx/rliFEMdBF3BhM0
         LpUHV4yhDEXst5xYr3keONwo+bCtPHQ/IdU0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfmXc3xr7dDVUscjphZ9PfgG1CkRdszrgoIMj+cYGiM=;
        b=QpiNWqiw4ZAn/GqdvLb0P5xsMRSvhfnKxRHHmFU6Qlly/YgXCfO+gQXdZFTTc1Jmbp
         qgUws+j9psMceRmHeysNwab2eC+FPauqcmd2H/gAvo4OThF9pS2yK6K6+/qMuepTKSKs
         KX6OW9nRPuJ/yVM/0syECqkxyG6C2IYN3mfaHMYmx6Tdd+hQKtoFnDPfHcuT9f7E3ZIJ
         4nwFBt3+YOFPE6mifB4Oqx9n4Wp56IG6vgomTDSxgw5chhaMSB8DMRowzg5mCZtwBrbo
         mx5VOpTqoZoFCkpmhWdimvizctVoZ92a8Oy3b2JNpkZk7Ow0/4l4RSU+54mjlTcXp52j
         gFqw==
X-Gm-Message-State: ANhLgQ0CopadOlJMvzLZj1Tm+5iLfxU5ey4N4D0yKxUFq1NhE662tElN
        Q6li3Q/P9RVkGv4eWeEs806rp2iABjw=
X-Google-Smtp-Source: ADFU+vt7JbiJARk1wg/fvNDttQPvT5vOZAMu2FPWJs6t+7BYZWwxYs8uQgvCvltpqDZwvt4A3rJfQA==
X-Received: by 2002:a17:902:7003:: with SMTP id y3mr1039116plk.122.1584391648215;
        Mon, 16 Mar 2020 13:47:28 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id c128sm754188pfa.11.2020.03.16.13.47.27
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 13:47:27 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id x7so10402556pgh.5
        for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2020 13:47:27 -0700 (PDT)
X-Received: by 2002:a05:6102:7c7:: with SMTP id y7mr1256780vsg.198.1584391271488;
 Mon, 16 Mar 2020 13:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200315134416.16527-1-sam@ravnborg.org> <20200315134416.16527-12-sam@ravnborg.org>
In-Reply-To: <20200315134416.16527-12-sam@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 16 Mar 2020 13:41:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U--vZ7bZ-RMGVbqxwpo9C8pBDtbmU2moUcu73kBHqm-A@mail.gmail.com>
Message-ID: <CAD=FV=U--vZ7bZ-RMGVbqxwpo9C8pBDtbmU2moUcu73kBHqm-A@mail.gmail.com>
Subject: Re: [PATCH v1 11/36] dt-bindings: display: convert
 innolux,p120zdg-bf1 to DT Schema
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Brian Masney <masneyb@onstation.org>,
        Chris Zhong <zyw@rock-chips.com>,
        Guido Gunther <agx@sigxcpu.org>, Heiko Schocher <hs@denx.de>,
        Nikolaus Schaller <hns@goldelico.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lin Huang <hl@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marco Franchi <marco.franchi@nxp.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Sun, Mar 15, 2020 at 6:44 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Sandeep Panda <spanda@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../display/panel/innolux,p120zdg-bf1.txt     | 22 ----------
>  .../display/panel/innolux,p120zdg-bf1.yaml    | 43 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 22 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
