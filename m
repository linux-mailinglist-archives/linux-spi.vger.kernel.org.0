Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6E81CAA2
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2019 16:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfENOm4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 May 2019 10:42:56 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35338 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfENOmz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 May 2019 10:42:55 -0400
Received: by mail-vk1-f196.google.com with SMTP id k1so576962vkb.2
        for <linux-spi@vger.kernel.org>; Tue, 14 May 2019 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HxDUMgya6C+pewtw7CuJTqXH1C16ghWjNPJmFKzBodw=;
        b=YnagnjO5b68039SYmxN/WdB6Ql0sRD42h+ael4hmT//KXQ86nw8uXrPU+1d9zAISK0
         B/ZPTyFXNf5dghs1EWBTX81mNIRNG38fXxm6eUqFxpimvYxcKZ/s8SzEqss7mf3T9NG9
         c6Mwmn07wSQZkXlpK4KSKMGmtVb7c83RJWuXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxDUMgya6C+pewtw7CuJTqXH1C16ghWjNPJmFKzBodw=;
        b=i6oBRvhfcUG94DgG8jA2ijR08/k0fblX4dcy6jUHTRua7IVZ31dkZ84yN5uO8WVGK/
         5/dWv/IR4HBaFgXGfsy7xvH/hcjnql1BlQs643rCCXba/rG8wdUCSaU7Ui2TdNPrWNWO
         gN88BErktwIveAktxjwpTSdtxJybdMtNUrsqaXiVOEZXJWaSuRk4r0VvxpPnqhW/vAES
         p0KIt5qua0o/efa+fBK27svPUgs5hIVYMquNYboRAA9Qtdp/I9x09sexiwl+bjehrCeH
         zNp3pTRoeDZPsc/84WAf6OJyzYOabgcl6n4GO6U3vZtPrexNEe2GEFDLQQzd19C7t8yG
         gDUg==
X-Gm-Message-State: APjAAAVDjMwCtaAVbGLoJUrtvgUHU9dzgoHFmJwBPnjnYQ5aNn0RulB7
        Du/MQvlNH78nJl+jlPPTaaOJLMUEEPg=
X-Google-Smtp-Source: APXvYqwNepLyJ2wyfS6Q93pnRA9XGSfqQdLnpM0CQ+AsOjqJVYHIy8X/bquxg39zNtqIapdPEsTiTw==
X-Received: by 2002:a1f:9bd0:: with SMTP id d199mr15717262vke.25.1557844974001;
        Tue, 14 May 2019 07:42:54 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id m39sm4476018uae.14.2019.05.14.07.42.51
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 07:42:51 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id o10so10460704vsp.12
        for <linux-spi@vger.kernel.org>; Tue, 14 May 2019 07:42:51 -0700 (PDT)
X-Received: by 2002:a67:79ca:: with SMTP id u193mr16139657vsc.20.1557844970925;
 Tue, 14 May 2019 07:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-2-dianders@chromium.org>
 <20190512073301.GC21483@sirena.org.uk> <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
 <20190514093038.GB8665@sirena.org.uk>
In-Reply-To: <20190514093038.GB8665@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 May 2019 07:42:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXhQg2CuNsTCkSe1BuEvkGMj6qeUB2iF=Qfj=Z0fLiWw@mail.gmail.com>
Message-ID: <CAD=FV=UXhQg2CuNsTCkSe1BuEvkGMj6qeUB2iF=Qfj=Z0fLiWw@mail.gmail.com>
Subject: Re: [PATCH 1/4] spi: For controllers that need realtime always use
 the pump thread
To:     Mark Brown <broonie@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, May 14, 2019 at 2:30 AM Mark Brown <broonie@kernel.org> wrote:

> On Mon, May 13, 2019 at 01:24:57PM -0700, Doug Anderson wrote:
> > On Sun, May 12, 2019 at 10:05 AM Mark Brown <broonie@kernel.org> wrote:
>
> > In my case performance is 2nd place to a transfer not getting
> > interrupted once started (so we don't break the 8ms rule of the EC).
>
> That's great but other users do care very much about performance and are
> also interested in both priority control and avoiding context thrashing.
>
> > My solution in v2 of my series is to take out the forcing in the case
> > that the controller wanted "rt" priority and then to add "force" to
> > the parameter name.  If someone wants rt priority for the thread but
> > doesn't want to force all transfers to the thread we can later add a
> > different parameter for that?
>
> I think that's going to be the common case for this.  Forcing context
> thrashing is really not something anyone else is asking for.

OK, that's fair.  Even if nobody else is asking for it, the solution
I've coded up for v2 still allows cros_ec to use the SPI core's thread
in a pretty clean way and saves a bunch of code in cros_ec.  It
shouldn't penalize any other SPI users.

...but I guess you're saying that you don't want to guarantee that the
SPI core will happen to have this thread sitting around in the future
so you'd rather add the extra complexity to cros_ec so the core can
evolve more freely?

-Doug
