Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7779D98AD
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2019 19:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbfJPRpE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Oct 2019 13:45:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35152 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfJPRpE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Oct 2019 13:45:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id x3so20804814oig.2
        for <linux-spi@vger.kernel.org>; Wed, 16 Oct 2019 10:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z/8Pjhr4Nf54oGisM02MkdmG++fDC7JWpnRqCZFl6sU=;
        b=QujAVNH6ta1gYwt38oJZD6idtx8FqAjjAk5FQsV0WeFfZc7o9s78inrpE6f1Qh9R3J
         kixlxJBedNzdBVrYt/fT/s+LlhOZkwmZFn5Ie/iw8Us18e2TbOFBbWgTsUvSAh4pAl5b
         hsy9Izjro29ySmUQhX/ev4gnzn04vJvJ82rNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z/8Pjhr4Nf54oGisM02MkdmG++fDC7JWpnRqCZFl6sU=;
        b=KuDln0GnaVG994qNuYvDcViCEiQ/oy6JatBCJ/4pKX9rDhGHG+/k6gvK0ov8u0rVer
         TAuOlGseQzNVhtPcDnX5HnzXXXPZjQFEYf/NFBY/YvI8vM/U6AsIjCVqUthkpm7yt+DJ
         t/31e2nTh69PC2hWd87MIw//8aMoCmSOcvi2fk/scMBpG6EZ1M0NA7TYUHmOE+6ilgmW
         uNEKVZIycW+i7y2xffAsBCBX5QHs6xPxESS+uws7hJtXI0YYM/C4hUtd9rUmzeYjovzG
         poL1Pn0U1MVgQaAgMSNvppY1XHcEggRhKYAhkIEww1vGCNbASblJ+OwQTt1w520wQF9c
         UBhg==
X-Gm-Message-State: APjAAAXg10wud72Lou/EchIVYIY4lzpNanRUSw2J99uFSuVDnHLxWVVW
        Y2mayT7FlUTeiP7NoG6EYiRtEq0tXaCYeQ0zmfsQ8g==
X-Google-Smtp-Source: APXvYqxZYdmxgbdlybjRfz/Cf6CXvYTEylx4rUPP+us/XBo2REqUB1uhyGky3zzfreRwj5OYAQumALxRm2wZDMTiVTk=
X-Received: by 2002:aca:e046:: with SMTP id x67mr4218651oig.101.1571247903874;
 Wed, 16 Oct 2019 10:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190719155916.62465-1-noralf@tronnes.org> <20190719155916.62465-6-noralf@tronnes.org>
 <20191015143236.GA5363@smile.fi.intel.com> <253aec49-e51c-b35b-4e7d-53a8a948655d@tronnes.org>
 <20191015155720.GQ11828@phenom.ffwll.local> <20191016161300.GW32742@smile.fi.intel.com>
In-Reply-To: <20191016161300.GW32742@smile.fi.intel.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 16 Oct 2019 19:44:51 +0200
Message-ID: <CAKMK7uEp39uvLtgyTTj31u-GYVoPiVJDTVbUThtn7NU_EoKk3A@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] drm/tinydrm: Remove tinydrm_spi_max_transfer_size()
To:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Lechner <david@lechnology.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 16, 2019 at 6:13 PM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Oct 15, 2019 at 05:57:20PM +0200, Daniel Vetter wrote:
> > On Tue, Oct 15, 2019 at 05:41:53PM +0200, Noralf Tr=C3=B8nnes wrote:
> > > Den 15.10.2019 16.32, skrev Andy Shevchenko:
> > > > On Fri, Jul 19, 2019 at 05:59:10PM +0200, Noralf Tr=C3=B8nnes wrote=
:
> > > >> spi-bcm2835 can handle >64kB buffers now so there is no need to ch=
eck
> > > >> ->max_dma_len. The tinydrm_spi_max_transfer_size() max_len argumen=
t is
> > > >> not used by any callers, so not needed.
> > > >>
> > > >> Then we have the spi_max module parameter. It was added because
> > > >> staging/fbtft has support for it and there was a report that someo=
ne used
> > > >> it to set a small buffer size to avoid popping on a USB soundcard =
on a
> > > >> Raspberry Pi. In hindsight it shouldn't have been added, I should =
have
> > > >> waited for it to become a problem first. I don't know it anyone is
> > > >> actually using it, but since tinydrm_spi_transfer() is being moved=
 to
> > > >> mipi-dbi, I'm taking the opportunity to remove it. I'll add it bac=
k to
> > > >> mipi-dbi if someone complains.
> > > >>
> > > >> With that out of the way, spi_max_transfer_size() can be used inst=
ead.
> > > >>
> > > >> The chosen 16kB buffer size for Type C Option 1 (9-bit) interface =
is
> > > >> somewhat arbitrary, but a bigger buffer will have a miniscule impa=
ct on
> > > >> transfer speed, so it's probably fine.
> > > >
> > > > This breaks the SPI PXA2xx case I'm using. The world is not a Pi:e.
> > > >
> > > > [  388.445752] mi0283qt spi-PRP0001:01: DMA disabled for transfer l=
ength 153600 greater than 65536
> > > > [  388.634437] mi0283qt spi-PRP0001:01: DMA disabled for transfer l=
ength 153600 greater than 65536
> > > > [  388.822933] mi0283qt spi-PRP0001:01: DMA disabled for transfer l=
ength 153600 greater than 65536
> > > >
> > > > The crucial thing is to check the transfer size against maximum DMA=
 length
> > > > of the master.
> > > >
> > >
> > > Isn't this a spi controller driver problem?
> > > spi_max_transfer_size() tells the client what the maximum transfer
> > > length is. The controller driver can use ctlr->max_transfer_size if i=
t
> > > has restrictions.
> > > AFAIUI max_dma_len is used when splitting up the buffer for the sg ta=
ble
> > > in spi_map_buf().
> >
> > Something like this, as a test patch.
>
> max_transfer_size should be a function. In that case it works.

Why do you want to make it a function? At least from my reading of the
code, the dma vs pio decision seems to be done once. So no need to
change this at runtime. Changing at runtime would also be a pretty big
surprise I think for users of spi.

> However I'm not sure it's the best approach, thus, Cc to SPI PXA people.

Hm didn't spot the pxa people, added them. Mark, should I just go
ahead and bake this into a proper patch for discussion? Or
fundamentally wrong approach?
-Daniel

> > diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> > index bb6a14d1ab0f..f77201915033 100644
> > --- a/drivers/spi/spi-pxa2xx.c
> > +++ b/drivers/spi/spi-pxa2xx.c
> > @@ -1707,6 +1707,7 @@ static int pxa2xx_spi_probe(struct platform_devic=
e *pdev)
> >               } else {
> >                       controller->can_dma =3D pxa2xx_spi_can_dma;
> >                       controller->max_dma_len =3D MAX_DMA_LEN;
> > +                     controller->max_transfer_size =3D MAX_DMA_LEN;
> >               }
> >       }
> >
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
