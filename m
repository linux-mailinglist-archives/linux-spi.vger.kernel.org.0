Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5A39185E79
	for <lists+linux-spi@lfdr.de>; Sun, 15 Mar 2020 17:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgCOQ0A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 15 Mar 2020 12:26:00 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46676 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbgCOQ0A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Mar 2020 12:26:00 -0400
Received: by mail-lf1-f66.google.com with SMTP id a28so58746lfr.13
        for <linux-spi@vger.kernel.org>; Sun, 15 Mar 2020 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nro+9PxoVZONSnffKW2dU8U2CHIxPJ7gtNcInQeK1go=;
        b=lwWFiOB6SJj8mGq6jaZpWUhLXzKgZyntVMMsXYYbG/IWeiuPJEVVNIQQUuqLV+XOag
         jIcEsYhJ9dngBmxhiolW1wTbWrYHbxixuUyidbrDZhlOCC1jB661xijrMccbrifYTgDN
         GOe5fpX4obl0lMchuaxiNn1khH4/6V65MUHvL/azuwnQfi3rJLToV1PEAwpTBospAiVV
         7KeDc1cHlB8ly3k69xJkfkivVgKShZ3dNLa5P9SZa+oBg3PVmG6u+1N3uITdh03hIbM1
         YfkHNTH+cvm0g6qP8Q38WTYZ703Z3eS4zCPklWgb3DtFzrpqmgmi0L2UpOgmz8q7Vm3+
         gZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nro+9PxoVZONSnffKW2dU8U2CHIxPJ7gtNcInQeK1go=;
        b=gbrbm5eN+utrK5SViWc6z1gs+HB/ASR+U1c44hqvQ2+6OjFnkTdqRpreSqYJYbDPUe
         nZ2Bx1ruXwP6UMe8ju5YKWNxKigDLBmDYcYwpfdkFkeSCTVKCiiVPtuVhq70CLfI0QJU
         t6Bw+sTLH+Ta/jF8Q519ykDDXXiB4z+NjisgQ94ptmUAxPGFC+wj11cYZnsovXD0dGZu
         bre3rlrZAglJHL1fM4i0XC7ZK3S/SlXrRFW/b+Dce6tPsNoNgdd7+zTeuizq1MwF4R6t
         ZwdOxLuBDcJl3XaEKgRjZnvvOBUCAXQDAnxDiiX7rjIHwSQCu9ms0WDKNW0Ezj6hRC+i
         jJEQ==
X-Gm-Message-State: ANhLgQ1CuCeUi4X4t3nwpEaIElLP4ZB7n3I91Y++hcu3frfPWYNaYNTh
        8W0HNrYhJPb0+3EJH0WZWR5HIIlnV0uFB0FKKfjUuA==
X-Google-Smtp-Source: ADFU+vtZ1Lm6HpAuq9q9b7CE2xd2dh3LAwacDeOvpC1P04gdg7RXPAQFfC8FLc6e0ZBzD7T3GR5IOsj+IUxBNg+hlnA=
X-Received: by 2002:a19:a415:: with SMTP id q21mr14190800lfc.21.1584289558343;
 Sun, 15 Mar 2020 09:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200315134416.16527-1-sam@ravnborg.org> <20200315134416.16527-5-sam@ravnborg.org>
In-Reply-To: <20200315134416.16527-5-sam@ravnborg.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 15 Mar 2020 17:25:47 +0100
Message-ID: <CACRpkda6Vve_oNZ+o0A-dUy35ktgqshTE8DyEqmBD=DWry7n_w@mail.gmail.com>
Subject: Re: [PATCH v1 04/36] dt-bindings: display: convert
 arm,versatile-tft-panel to DT Schema
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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

On Sun, Mar 15, 2020 at 2:44 PM Sam Ravnborg <sam@ravnborg.org> wrote:

> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>

Thanks! :D

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
