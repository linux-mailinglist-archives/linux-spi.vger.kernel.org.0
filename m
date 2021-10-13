Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D11942C815
	for <lists+linux-spi@lfdr.de>; Wed, 13 Oct 2021 19:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhJMRzc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 13 Oct 2021 13:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMRza (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Oct 2021 13:55:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735E4C061746
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 10:53:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p13so13891799edw.0
        for <linux-spi@vger.kernel.org>; Wed, 13 Oct 2021 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y88NO31n5zZQladVHGT0A7AV0jELq4UAK9M51NO2UeE=;
        b=w1IGNF93XVj3d6vSv41EXHaCmxNzDxXdWwt8nhqaMSJGhuXjRTL+sywPi/wkXjhdiW
         /AXVkKr4nhytkS6XPceL5qgwFYfze+E8eecmNwkq9g8AM9h2V4O9O64VtNXm6TJccFbj
         dxsCvWAdpZZjaaXxuzLL7q3KAjo6wb5hopEuzQ9llDbGWVoMFlZIcGCDFThBa96ymvu0
         wpDACie3VYnNC2RLh/3tOvCBYAIHYZ6Hv+ifv7/4GHYXo9omAckGf2gKBx4DhvvGE9Uz
         NWmiqBlVD+58L1fMUWDa4AxdnbHwAQTdwE/PHsQDz+a+5pB+2B8psOdxAgQXN7hFg7Ho
         JRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y88NO31n5zZQladVHGT0A7AV0jELq4UAK9M51NO2UeE=;
        b=WZCflLCYrvMRfun2xC9ut0JoEx6Yvqu9hZ5qTzWzcCf7skZXSxPhBTthkUS6RclMpr
         /Z+LuKLTcQiXQXA2j6gxil9Jnf0w9aNBxZHJ6ac4byfXAsseyzRugNkgGmJRckAjLv3+
         N0b5EECBJvxz8ODlPvdezi91KDiuxA5YJOv6+x9+QUadX777V5+I250Lv+82mVcohhAx
         Qt3MjzcCXbEcIf+NbrdW1vJweR3e3bq4nXhwZ5ZktemQwOIRe1NLGGfaQXNrlCy1eRxl
         SevKAkz/xm5hpuzTcpRgF8YTaT32adUNUqpB05kpJ5PBbvhcpEt6SEJBEouJ5FBmtZpt
         lOsQ==
X-Gm-Message-State: AOAM532y3FOGgsZvUwRCuyjnNHAoFh2u2v/erEcbTmDKFog7rF2SPbvD
        6qZyJJuuRGHiv28I8XHoHaiIDINw9hxPIHJCMc8fSA==
X-Google-Smtp-Source: ABdhPJwWSHEYE1qdximFCtCdQMTeYuMyvtTpp6Xew2luRB9ik7+nz528hEPv7ehzfXChKRNfD57kPJc8IqMJE12tkis=
X-Received: by 2002:a17:906:5343:: with SMTP id j3mr761563ejo.538.1634147605032;
 Wed, 13 Oct 2021 10:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211012153945.2651412-1-u.kleine-koenig@pengutronix.de> <20211012153945.2651412-3-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211012153945.2651412-3-u.kleine-koenig@pengutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Oct 2021 19:53:14 +0200
Message-ID: <CAMRc=MeyHwbm24fWPqKhx7yKktSXMZNaWqm24p6MW-hGCueRfw@mail.gmail.com>
Subject: Re: [PATCH v2 02/20] gpio: max730x: Make __max730x_remove() return void
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 12, 2021 at 5:39 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> An spi or i2c remove callback is only called for devices that probed
> successfully. In this case this implies that __max730x_probe() set a
> non-NULL driver data. So the check ts =3D=3D NULL is never true. With thi=
s
> check dropped, __max730x_remove() returns zero unconditionally. Make it
> return void instead which makes it easier to see in the callers that
> there is no error to handle.
>
> Also the return value of i2c and spi remove callbacks is ignored anyway.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Applied, thanks!

Bart
