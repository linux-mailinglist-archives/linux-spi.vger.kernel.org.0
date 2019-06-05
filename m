Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF8136531
	for <lists+linux-spi@lfdr.de>; Wed,  5 Jun 2019 22:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFEUPM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Jun 2019 16:15:12 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:52916 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEUPM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Jun 2019 16:15:12 -0400
Received: by mail-it1-f178.google.com with SMTP id l21so5543740ita.2;
        Wed, 05 Jun 2019 13:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=THJJt/ZPhh8isKdn2NsQHGAKZfNn4iulXXsjjcZVkJk=;
        b=rWon5Fu4RCmo8tkHAvZ/U7WQ3+Q81pOXAnPrt1ch556o74O+VMy3QtBkWGoFBxmHL1
         Y7rNKrjSRLbCsDPeG/ZRmAItfj/kEG59qK+LQRrMXrrm6GWbaJm5u8s46UGem9/fXxYm
         lqgbD9l6Y4JN29WWrArmKQE6OxJeKttndgTl4K3gL5E5BbwEPACNRBK5IWaiALdCDiEv
         W+uD+T2M4UF63jtUmjE/eTPBKhWbYNgITDwg1oiuuhUrU0nE2TBS18CO9FTBfy20/w7b
         PbDvTtjV3JMz4KSZqLzFBGy20RjIK53ZmqI2Fqzeot0LYi/fR7Mr4K4X8hv5gLvNLmIc
         t3cA==
X-Gm-Message-State: APjAAAUVUIVAjWlvoNmgjVGZSWhl72nxVItqDdRwq7uRx1v/+cxhlD8D
        raOrElE8qhb60OvO+jbMbGssFQ11QfNApuFfqKA=
X-Google-Smtp-Source: APXvYqyrpsndryg2pdcv8bRbnFKvQOW5n7ws+8amqaHflUu9NqIphSTk1hfXgnbNdWzwKOBlue4Rts3JPGsdQ7vzs78=
X-Received: by 2002:a02:a001:: with SMTP id a1mr28751687jah.115.1559765710777;
 Wed, 05 Jun 2019 13:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190412105320.2924-1-kernel@esmil.dk> <20190508103358.5C7EB440010@finisterre.sirena.org.uk>
 <CANBLGcxiXR7KqKn4U-2PgefuxpBFX=yR06cw6A5GEALuqa54FA@mail.gmail.com> <20190605195511.GX2456@sirena.org.uk>
In-Reply-To: <20190605195511.GX2456@sirena.org.uk>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed, 5 Jun 2019 22:14:59 +0200
Message-ID: <CANBLGcwE_KfwJ=-FKNJ9RzrH58FVcmyxAR9niWQRubjM0pZgWA@mail.gmail.com>
Subject: Re: Applied "spi: rockchip: turn down tx dma bursts" to the spi tree
To:     Mark Brown <broonie@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-spi@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 5 Jun 2019 at 21:55, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Jun 05, 2019 at 09:36:44PM +0200, Emil Renner Berthing wrote:
> > On Wed, 8 May 2019 at 12:34, Mark Brown <broonie@kernel.org> wrote:
>
> > >    spi: rockchip: turn down tx dma bursts
>
> > I've tried looking in the for-next and for-5.x branches here, and I
> > can't seem to find this patch.
> > Am I missing something?
>
> > It fixes a problem introduced in 4.19, so it'd be nice if it could
> > make it to stable trees eventually.
>
> 47300728fb213486a830565d2af49da967c9d16a is in my tree.  When it reaches
> Linus' tree send a request to Greg for it to be backported if none of
> the stable automation picks it up.

You're absolutely right, sorry about the noise.

Thanks.
/Emil
