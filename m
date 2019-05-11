Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F38E1A5C2
	for <lists+linux-spi@lfdr.de>; Sat, 11 May 2019 02:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfEKAYO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 May 2019 20:24:14 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38478 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfEKAYO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 May 2019 20:24:14 -0400
Received: by mail-yw1-f66.google.com with SMTP id b74so6112338ywe.5
        for <linux-spi@vger.kernel.org>; Fri, 10 May 2019 17:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JodsC5+xYkGlp3C/I+zaQDr/2QyhiDeAmLITr9vbezE=;
        b=cfj39WapNqsIpg4SRPEiKdu6YVkoIDrti4Loe/BNhVHWrN8pYYUaUijnAd3194jYps
         KXpagcxbsXgKX/pFnmi2ulMJv2zBUzn4SEJxgQKvVI2ND6dKTavEnWDXKgcjo7r3OZu1
         i2at/NxJebvdBcPRxR4tT1JrjXRcsm/vGv31X55e/J0Iq9qsy9Wv5jG2I1qtPghJpq8W
         rvk04dQTARXwc6JwcIlIcAlSuZ6/B6aXmT7F+t4nbAflpc7VhdaD2Im/P3C7tvNjLwWq
         GkUukhXU+VMXHBZm7C1k1Npn8/+hIky761Jy37yURog/C9zC7H23zHOZz8X7GNuKnVrn
         K5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JodsC5+xYkGlp3C/I+zaQDr/2QyhiDeAmLITr9vbezE=;
        b=DAt8gI9KIN9SLPOzLaqq1YJHTpGxUf/pY/IHIUCOZSGEoR8BU+pAkBs0u4bNk3B10A
         gsK33Il/ygyBQHxbNKVmRjOoLobqDoys9YJV8e9zyIAiMa9yyY0W7dxz56Oz7JvNhAqb
         koCPkWuSMsBJ2tffGaV2h2tlASn2342MAzWgYECiTCgLYUmD7xkNaZwA69CStur0/tc2
         9jqkfZxLMg5BnRHhcGvokOwIwF8cgRQLIMmSRWUnW9IU6Ltc8vFWLibGrtE0emWmoqkK
         LXkapykJ4VKX8qkRZpkibN1IrnbgjJ1fzne6YDyVw9VBm3ue68b5FaAsZSg/uEoNKvwO
         9KDw==
X-Gm-Message-State: APjAAAXX4uZRLYrVKLTGskVMfMjqlSQb7CBQagwKW7QyE+HeWRyRKwvK
        nWvz7zvBKMD39TrlzSvLVFjJF5zwWbVzcHI6K4uRxQ==
X-Google-Smtp-Source: APXvYqxIsnyr4AxG2P4l7F9uO+kKc2KESM8Mvpv3iM6Jd8o8YMDiHtgcYyJoCntlXH20KOsKArfOPXXaURMw0bPKCqg=
X-Received: by 2002:a81:5a0b:: with SMTP id o11mr6996411ywb.444.1557534253549;
 Fri, 10 May 2019 17:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-2-dianders@chromium.org>
In-Reply-To: <20190510223437.84368-2-dianders@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 10 May 2019 17:24:02 -0700
Message-ID: <CABXOdTfaei3A8VN_-v_BvOKJD7=GPfO7pPCMY+2duOxH4FoZvA@mail.gmail.com>
Subject: Re: [PATCH 1/4] spi: For controllers that need realtime always use
 the pump thread
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>
Date: Fri, May 10, 2019 at 3:35 PM
To: Mark Brown, Benson Leung, Enric Balletbo i Serra
Cc: <linux-rockchip@lists.infradead.org>, <drinkcat@chromium.org>,
Guenter Roeck, <briannorris@chromium.org>, <mka@chromium.org>, Douglas
Anderson, <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>

> If a controller specifies that it needs high priority for sending
> messages we should always schedule our transfers on the thread.  If we
> don't do this we'll do the transfer in the caller's context which
> might not be very high priority.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/spi/spi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 8eb7460dd744..0597f7086de3 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1230,8 +1230,11 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
>                 return;
>         }
>
> -       /* If another context is idling the device then defer */
> -       if (ctlr->idling) {
> +       /*
> +        * If another context is idling the device then defer.
> +        * If we are high priority then the thread should do the transfer.
> +        */
> +       if (ctlr->idling || (ctlr->rt && !in_kthread)) {
>                 kthread_queue_work(&ctlr->kworker, &ctlr->pump_messages);
>                 spin_unlock_irqrestore(&ctlr->queue_lock, flags);
>                 return;
> --
> 2.21.0.1020.gf2820cf01a-goog
>
