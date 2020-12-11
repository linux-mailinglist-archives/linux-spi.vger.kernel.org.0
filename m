Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E86D2D713E
	for <lists+linux-spi@lfdr.de>; Fri, 11 Dec 2020 09:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392004AbgLKINu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 11 Dec 2020 03:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391820AbgLKINl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 11 Dec 2020 03:13:41 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72FAC0613D6
        for <linux-spi@vger.kernel.org>; Fri, 11 Dec 2020 00:13:00 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id x23so9906033lji.7
        for <linux-spi@vger.kernel.org>; Fri, 11 Dec 2020 00:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VoXnCBthI2L/2T3Qana/I/DjOclhIB0/A35c/8G8Po=;
        b=mUq4n+bJwCZqwf4PRpv9TSTHLn5Xh6AZxE3lMXQ4ciL18s5orA99dqvWnn7wTo2aPM
         ilUo+uRzl7qZO2wwCgl/41qrAZm9TuIx5hqfcp+b4MaWADO9pSYo8JNuQ2GPoMjL4RRM
         mV9oY+FKvwCDWjRuusoE8PlyrGiUeqePIM0+DR3LWpMAsEND/nYsuYvc/hduFjLWY1n/
         HTD9aZNRUvof5nPHL5CN5tWG+vvdtZ+Np1aUb9R/6sZG6XBHtheDpYQ5BwuZjh08OtZu
         ksEh29nDYnWFQj5F2sXzMySjhLZUm5EqIvPEAu6I2ddc+aBpzicZThurRD023Lq3tArf
         o79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VoXnCBthI2L/2T3Qana/I/DjOclhIB0/A35c/8G8Po=;
        b=aeMKPG/MOXtqgNzFaFwVb4MkrlufIsgE8yMFXquS/icIIRC55zIAuklJaXIvhsdhuZ
         DAxrnekza3oh5jJgLXE/tb9Q6xLo74QE9w739T0As5f0OsiEvixGGJ73vmmUd99m8OAC
         UxGII3pRJRwYCgMKHIwHnIrYpf3kERqO5+v14By8w7rqg7J9PNrOGPiI02xZFC7bISMO
         +pHXdbW3TeNKl6MwEJAr3oKj00PJISLN96LfOzpGVpAqv/k1ncbmn99N9TLO/anDIQFe
         prRt+c+X5UXy66DhJAQIQ6lPQVc3EOz/bGkkEKY7t0sxGcYC8O7sepkX1rGPtqBs/pgT
         tuJw==
X-Gm-Message-State: AOAM530JZZ2dmNjgBiOYyJil4l/Pw0j6b0r3ysP50L4gEGhx5khSBks4
        T3JhYZOslqFV87F0kq3/9FjWPLXbm934iPsUVGN0ow==
X-Google-Smtp-Source: ABdhPJxWdWW3zxwdcNB575NyJ4L2g2+cRdR3mY7ME+FqxN3f0TeXt3uzd+Mb9qPY6xHM3BwWTSwfFHObZ+sgW3lHWNE=
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr1220648ljo.368.1607674379166;
 Fri, 11 Dec 2020 00:12:59 -0800 (PST)
MIME-Version: 1.0
References: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com>
In-Reply-To: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Dec 2020 09:12:48 +0100
Message-ID: <CACRpkdZkopTef1KhcD+u=G9nn=pYN+jOsgJRdmKo3VSF5mG4HQ@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high and
 gpio descriptors
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Dec 9, 2020 at 11:01 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> Behavior of CS signal in combination of spi-cs-high and gpio descriptors
> is not clearly defined and documented. So clarify the documentation
>
> Cc: linus.walleij@linaro.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

This is good because it is helpful to users.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

In cases like this I would actually consider to write a bit in the
bindings saying "this is inconsistent because we screwed up
so be careful", standard bodies usually try to avoid that kind of
statements because they have all kind of prestige involved
with their work, but we don't so we can just as well admit it.

Yours,
Linus Walleij
