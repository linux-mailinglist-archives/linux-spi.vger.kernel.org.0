Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDFB36C572
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbhD0LnT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 07:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhD0LnT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Apr 2021 07:43:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E214C061574;
        Tue, 27 Apr 2021 04:42:36 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m11so747569pfc.11;
        Tue, 27 Apr 2021 04:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wpk0SlupheQG7tbcO3ObJ3Bj5cU326C9p8KvsS434dI=;
        b=kl9gXoRV3PyjeOmmdEfnAXKMGSi2g+d66eMeoMGPZlouQKiQUfxwZ7br1TxePCh6iL
         rfLMbWK3uG0/5fDD4aNjWi9MVMwXTGKh5AMWUJVHLskQZQ88igM+UFORqX7z2GPooL2B
         Zv8G9DT4xl33tofF/+bNSMJHG33lf5sRpUTi8OHJm89vaSaNTmT+OSZpqg+545wq62ZK
         CCNhOuBaZT1+sH7nzY+hN4K36zaFopAoQpfMt3wApw+IanU9EX2lcMtsU5ZoAO8srFPP
         w4P409G9KN5stmo3mD3nigfc3BlSJ6zjMF6REIkyQkyZnsReGw4XRMuCBs2nxxECyLgL
         8zuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wpk0SlupheQG7tbcO3ObJ3Bj5cU326C9p8KvsS434dI=;
        b=CuywpTrdj5JsEnLs3OttPMs1gxufK7G82AbnECI+PiYkvW1IcovTesXNXVADFlA776
         ZkXRrhCPZcz+AHSQ1olccTtH7gwL5uzgtROgNWHrEbDdbmuO02mqL67LPWvL/ti3xQ+i
         qJuEUZXrVFAFAVlj0WaKhAj39uPMQStEyRg222G9MH3QpF40GsWCc20/wh0nZ85Ap0w/
         vaOko3oR9O3eQmEDWKQGu3gIQs5F744XJoIhsjYIY7KSmNiko5tiTv3SVRK8gIn5lRtV
         6Kddq4624o9r67GZT9IuaAX1G2vRIuQuNT9RawY+vQeAmk83A4TzaLtZORwZJygGDnD7
         m++w==
X-Gm-Message-State: AOAM532xMlGrvcXrviP2tBAGfY2iELMZrJyKxBwF5sUCoGMfXx2WBuhm
        BohZo7uN0qm2mMvsu273F5cg+voHOfIrUIOaVH4=
X-Google-Smtp-Source: ABdhPJzUlO+owwhKnnkcWN+K5NzW6e5+uAtFlm6ppXR6oTfeXGvMcdFh/l3dmjGXKjl1qf6m4dcKmbgHSLqBzkB6vu8=
X-Received: by 2002:a63:a847:: with SMTP id i7mr21138054pgp.203.1619523755454;
 Tue, 27 Apr 2021 04:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210426235638.1285530-1-saravanak@google.com>
 <CAHp75VeNZ4-TgkevNF5tgmB1eU9E77RNsPWRABp6PvC6eGpQrQ@mail.gmail.com> <20210427104851.GC4605@sirena.org.uk>
In-Reply-To: <20210427104851.GC4605@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 27 Apr 2021 14:42:19 +0300
Message-ID: <CAHp75VdpC687cHezCy5nP6BRYo-dS8COYvBBvu02f6W_dS6JEg@mail.gmail.com>
Subject: Re: [PATCH] spi: Fix spi device unregister flow
To:     Mark Brown <broonie@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Apr 27, 2021 at 1:49 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Apr 27, 2021 at 09:52:48AM +0300, Andy Shevchenko wrote:
> > +Cc Lukas
>
> The cleanup callback has been in release() since the framework was
> merged AFAICT.

Yep.

Personally it feels to me wrong to require device_release() being
atomic. It might be that I missed something in documentation or
somewhere else that suggests the opposite.
But let's wait for other comments if any.

-- 
With Best Regards,
Andy Shevchenko
