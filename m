Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD50175B1C
	for <lists+linux-spi@lfdr.de>; Mon,  2 Mar 2020 14:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgCBNDS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Mar 2020 08:03:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52273 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgCBNDS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Mar 2020 08:03:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so11100496wmc.2;
        Mon, 02 Mar 2020 05:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5W1+VDAgXwgm27HM/dSDLhd13oiMZYWRhU39zs/56E=;
        b=VL/p5u5MxrqPbpsnUeJsGg2+zaymsNPsSrtX5LtlbBRHPR76xpwAIdpoQHUrT6O4V1
         pX1Rx+/fXWiSwINUtEK0K/8KGG2HELuv/iC7xs3o+eTJFwTP/4LWzlV6RsIea8jnx7At
         1pSkBdZN9ts1P1uRZfp6QGYYpPM9Duws82fEKXb2768hofcvnzC4HKu54ZPghM1mEUsS
         l1082Gy8362KF11dmaJXhzbvtYPLadAcMDEfAePw4SjI/TjhEINjpF3gS5GIBzhSNCV+
         gZS6LnQ/Lmowm4Tr5hRtPbgompWe8tdEEmI+rfhByH2LGl2hnYhZxb/Tav/6Ik6onMXm
         yy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5W1+VDAgXwgm27HM/dSDLhd13oiMZYWRhU39zs/56E=;
        b=b9W/LU6i+69t2wQ+3+S5fBw0TUCUfLo3rukCua0AxwyStI2WvVUUa4r8unNaoMqEsd
         ZYlfccs1a9U1MpsM9vyDz7LgjRhQja3bzOL6Tin5e8TeYjvEKpaDvJaip8/kNocxCcgu
         JFpxCdp2X8VWjoQJWmhxHRxJm+6R5Xsv9yvFdJmy2VkXdU/FlENeFbRq6g2wWO6EKWoq
         c/00WqMgSnr2F5ALI8MvMz/j5sO9M08ut7yZNZ/Quef1VEZEt+h8gndRGX++9IPszi+z
         10ltwG+/4wgFX127vr2S3/3jzarpxxe8027Kb0zd/ji6YM8D9OGNoFSRpaifCnSnTjXT
         +LXw==
X-Gm-Message-State: APjAAAVKh67ZHt5HdIZ3XkdHokXjer8mtSzVfGMGyo/LkFcJ+Yw60Aef
        0F3l2ZZkWjnbrTWkgicEv736pL42qSDzBtoj4Z4=
X-Google-Smtp-Source: APXvYqz6WKuyVy/9PnCleaCMggOFDoRnbRnI+UO7wa56fEel46cxxunC5R0QhS7cAoxr0JV2ipGv7rbIhc+DRETlFzU=
X-Received: by 2002:a05:600c:2c13:: with SMTP id q19mr20166181wmg.144.1583154195913;
 Mon, 02 Mar 2020 05:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20200228213838.7124-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200228213838.7124-1-christophe.jaillet@wanadoo.fr>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 2 Mar 2020 14:03:04 +0100
Message-ID: <CAOiHx=me0H6xjz__bJthvF0=MGJfTcRyxd8mM1SD0fwjXpVERw@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: Really keep pll clk enabled
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mark Brown <broonie@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-spi@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 28 Feb 2020 at 22:38, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The purpose of commit 0fd85869c2a9 ("spi/bcm63xx-hsspi: keep pll clk enabled")
> was to keep the pll clk enabled through the lifetime of the device.
>
> In order to do that, some 'clk_prepare_enable()'/'clk_disable_unprepare()'
> calls have been added in the error handling path of the probe function, in
> the remove function and in the suspend and resume functions.
>
> However, a 'clk_disable_unprepare()' call has been unfortunately left in
> the probe function. So the commit seems to be more or less a no-op.
>
> Axe it now, so that the pll clk is left enabled through the lifetime of
> the device, as described in the commit.

Good catch!

Acked-by: Jonas Gorski <jonas.gorski@gmail.com>

>
> Fixes: 0fd85869c2a9 ("spi/bcm63xx-hsspi: keep pll clk enabled")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> To be honest, I don't see why we need to keep pll clk, or hsspi clk
> enabled during the lifetime of the driver. My understanding of the code is
> that it is only used to get the 'speed_hz' value in the probe function.
> This value is never refreshed afterwards.
> I don't see the point in enabling/disabling the clks. I think that they
> both could be disabled in the probe function, without the need to keep
> track in the bcm63xx_hsspi structure, neither during pm cycles or the
> remove fucntion.

The hsspi clock is actually gated, so it needs to stay on during use.
The pll clock is only used to convey the rate, but is not gate-able.
These used to be the same (that's why it checks for the rate of the
hsspi clock first), but were split to make it easier to move to common
clock framework (since we can just use the generic gated and
fixed-rate clock implementations).

Incidentally these are AFAIK also two inputs, so it even happens to
match the hardware more closely.

Since the pll clock isn't gated, we don't need to keep it enabled - we
don't even need to enable it in theory, but IIRC the common clock
system will complain if you try to get the rate of a non-enabled
clock. And if we do enable it, then we can also just keep it enabled
over the lifetime of the device.

Regards
Jonas
