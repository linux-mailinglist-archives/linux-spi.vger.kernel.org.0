Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E6515D8BC
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2020 14:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgBNNuB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Feb 2020 08:50:01 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44960 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgBNNuB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Feb 2020 08:50:01 -0500
Received: by mail-vs1-f68.google.com with SMTP id p6so5913353vsj.11;
        Fri, 14 Feb 2020 05:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uqyI02njoot2XmCZIdNUmhXwHE9v/zz94Gp6DG53kCk=;
        b=ttyMlQudUD/NIBwpvMZWuApIZRSf94LFlCQcay2XSvF2z8dXuaO5svAqb7WazigmfP
         eZTC6ziq4bwq//prNhF+xxbc9pQ6cHgUifdA8udDHgIWVZ8rqePb7c3AM3WG8S0QvcKQ
         dN1ygtCuxKRefH8ocoasDfWJTZfENfGPcqGvBOY+yo0W7OwUOqNEnPq+q9YKQ+onvd+q
         2yGMYHdJAdUIOydiE2fBf4Qd5OXQTEej3aceCsOpiy/ezZEpUjYdXcS7In2MhGkZ7QJj
         8xPjjfPTo2CKhaq6avDY0SH58louqdjtPdLzAl1xUdXhTXAPO1XHXQOoJ9vsTYKyyNo5
         NCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqyI02njoot2XmCZIdNUmhXwHE9v/zz94Gp6DG53kCk=;
        b=gOMN66P5tQfKNDCpLjX37KHw7BifLEwNyZjq2qImRS/+fguERvJvCczvHzrMplHrow
         I0Xm4hf4md+dScofE628al0vCPKxbQi4w2utSJcVE4zmyn5X0LmWxaxTHUTxSIQvGWA3
         ltsr6juZXHkDQ1PZLOL1sxpp6JhEYQK7Ov9NZPoa7GD9NT+XWMFtGbvWK3jsLJfPQYJO
         H3eT4NuLBVQflg8FlmeXqqGv/HairVnQzFNUXGakYL7X7YWTHugNMnj5ENpFHCgCL5ef
         MgzVCMaIQ+IvnZj4rSEvQLajk08FoHogsFg7PHnVS424qLZ+I7OfrGz82cTC42EwZCwm
         Wsig==
X-Gm-Message-State: APjAAAVdB3vy+teut919kbGj5bSKsO9O0m3YdDDLRxU3o7i2EXKygNRP
        TDf3KXM6fa+2eHJhOiHy9Ci1exF7LVbVsxlDsuQ=
X-Google-Smtp-Source: APXvYqx8gznJb0eroBOKXsZ3slGRJyDdgQg5k1ZyNJQC7tNmGE0gkxH8xYqUIYP2EnC0Nj7ideRVjXRyo+saG1phkyI=
X-Received: by 2002:a67:ce93:: with SMTP id c19mr1413233vse.64.1581688199935;
 Fri, 14 Feb 2020 05:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20200214114618.29704-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAAh8qsxnRSwonuEPrriuS=gUMTjt8ddUVy5HxegmoCk-FoE4qg@mail.gmail.com>
 <20200214121145.GF4827@sirena.org.uk> <CAAh8qsxmYmpyAg-FQJLnEwvKKFZYg6VQenKf83_TJ4oF0GyMsA@mail.gmail.com>
 <20200214131518.GJ4827@sirena.org.uk>
In-Reply-To: <20200214131518.GJ4827@sirena.org.uk>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date:   Fri, 14 Feb 2020 14:49:48 +0100
Message-ID: <CAAh8qswA0TLY73URB8eUYm+nFK9q08Ep4wamz3rAE_5g3fd51g@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
To:     Mark Brown <broonie@kernel.org>
Cc:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Feb 14, 2020 at 2:15 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Feb 14, 2020 at 01:50:44PM +0100, Simon Goldschmidt wrote:
>
> > So please correct me if I'm wrong, but to me it seems like if this driver won't
> > work on altera, and after merging it the currently working driver will be
> > removed, altera will be broken.
>
> I'm not seeing anything in the driver that removes whatever the current
> support is?  Unless it's just adding a duplicate driver for the same
> compatible strings which is obviously a bad idea but at least means that
> unless people enable the driver there's no risk of it colliding with the
> existing one.

It does add a duplicate driver for the same compatible strings. The current
working driver is in 'drivers/mtd/spi-nor/cadence-quadspi.c'.

In fact, the compatible string "cdns,qspi-nor" copied from the old driver to
this new driver is *only* used for altera. TI has its own compatible string,
the new Intel platform adds its own as well.

As long as that one doesn't get removed, I have nothing against this driver
here. I'm only concerned that this will get forgotten. And given that I added
altera guys to the loop in one of the previous versions, I just was surprised
they aren't on CC in this version.

I'm not familiar with whom to CC for Linux drivers, so sorry for the noise
if I'm overreacting here, just tell me.

Regards,
Simon
