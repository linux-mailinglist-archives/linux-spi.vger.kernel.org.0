Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61541BEA8
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2019 22:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfEMUZL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 May 2019 16:25:11 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:35888 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfEMUZL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 May 2019 16:25:11 -0400
Received: by mail-vs1-f68.google.com with SMTP id l20so321449vsp.3
        for <linux-spi@vger.kernel.org>; Mon, 13 May 2019 13:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s5749hj+ec8qMiNkDdVTE/yv4EVBb0STJhROaexO/ow=;
        b=aSzILZh1B8qR6DUScwEycKF1nqIky18KqZ5ulbFuZ49/8VSCk0RfsYIyjXbmjOqY4+
         v5VrAMcifpVcmVKK415z2GAmJJupcK+NY5AMUX4LVVM+faq3TlPY441Jg0LvzmxT4Du8
         ghz0j7IS4/ptx8mgYUVFCZA4ip/zRO01nTshs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s5749hj+ec8qMiNkDdVTE/yv4EVBb0STJhROaexO/ow=;
        b=ef+hgnBSw1Gi0JAxCZXH4TkYbJK/vFoqnvZdnAaUhbLwyQ3+xzp/MsG6Yf/ncjTpCL
         ziFjnHverOIEIG/ybLP9p7KmGox0CWdekRS+nz6Pk6hSAK416W+ofqf97H7xJ4XXlyRx
         wqHuoSP8TiW50aEWBXvoyqBSB9vipzK+LUKtG6hHg+wNq4Fjjkj4GGI8OQJKSpsXUAhr
         0TaWgdl/Zp150MBDfjdBTfdIfEgeJFO8J8dK0WQW+aC5STTiQGsBvD0qYzsWDiYdTJAT
         MFVrDSGz3BePRCaYaWnHGE5pY/DwckZjuvglgP07hy4iuFRS2rY3LGHVLf2H7HNO81cj
         22uw==
X-Gm-Message-State: APjAAAV5bGbbYONKMXPVhrKszfHz8nQ+5jtKlcMSmWyFY2Die4JMJXk4
        fWQUm3N1r2iVbCBU28O7IK27FOEh/5c=
X-Google-Smtp-Source: APXvYqzi2ymEYPWvWFugFsZo8J8Y1Gc0wUqSTSbCVYF0/l0pLX6mC4dKvk5nWt3OdiV6C+TvGYQCEQ==
X-Received: by 2002:a67:ed44:: with SMTP id m4mr14995951vsp.112.1557779110035;
        Mon, 13 May 2019 13:25:10 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id n68sm14007880vkd.0.2019.05.13.13.25.08
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 13:25:09 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id l20so321403vsp.3
        for <linux-spi@vger.kernel.org>; Mon, 13 May 2019 13:25:08 -0700 (PDT)
X-Received: by 2002:a67:79ca:: with SMTP id u193mr13859822vsc.20.1557779108576;
 Mon, 13 May 2019 13:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-2-dianders@chromium.org>
 <20190512073301.GC21483@sirena.org.uk>
In-Reply-To: <20190512073301.GC21483@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 May 2019 13:24:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
Message-ID: <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
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

On Sun, May 12, 2019 at 10:05 AM Mark Brown <broonie@kernel.org> wrote:

> On Fri, May 10, 2019 at 03:34:34PM -0700, Douglas Anderson wrote:
> > If a controller specifies that it needs high priority for sending
> > messages we should always schedule our transfers on the thread.  If we
> > don't do this we'll do the transfer in the caller's context which
> > might not be very high priority.
>
> If performance is important you probably also want to avoid the context
> thrashing - executing in the calling context is generally a substantial
> performance boost.  I can see this causing problems further down the
> line when someone else turns up with a different requirement, perhaps in
> an application where the caller does actually have a raised priority
> themselves and just wanted to make sure that the thread wasn't lower
> than they are.  I guess it'd be nice if we could check what priority the
> calling thread has and make a decision based on that but there don't
> seem to be any facilities for doing that which I can see right now.

In my case performance is 2nd place to a transfer not getting
interrupted once started (so we don't break the 8ms rule of the EC).
My solution in v2 of my series is to take out the forcing in the case
that the controller wanted "rt" priority and then to add "force" to
the parameter name.  If someone wants rt priority for the thread but
doesn't want to force all transfers to the thread we can later add a
different parameter for that?

-Doug
