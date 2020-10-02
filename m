Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F238F2812EE
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbgJBMkt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBMkt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 2 Oct 2020 08:40:49 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1012F20644;
        Fri,  2 Oct 2020 12:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601642448;
        bh=nXdzXzeAc1yMvHsj447ukLSP4Jtd85+JIsr3gszdND0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHV8cFWzbZ7pyyl7oCJoGFe17c6E9A9b9TbOhzrfxt4VEBrTuQKBLIEHo0LciUwYl
         4yN2ho+BA6T7EsEPAw7W87B7q875GGifrzjHMtEvxgdmozD/gt2ZKGtgsOffCKmwG2
         2XnPWnXeQJ/MIWUWX9csVvb2iVJVk4Jp9bU+B/tU=
Date:   Fri, 2 Oct 2020 14:40:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] serial: max310x: rework RX interrupt handling
Message-ID: <20201002124047.GA3348062@kroah.com>
References: <20200930135137.197592-1-thomas.petazzoni@bootlin.com>
 <CAHp75VccK7hu51qCdRC4GaTO3XaSaYLD6TeuuqHLY9Tf1Tb67A@mail.gmail.com>
 <20200930165037.77813365@windsurf.home>
 <CAHp75VdU5N6dBKgDudod+0cHumAreHCHgi1+xGqXtvpkiLNz0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdU5N6dBKgDudod+0cHumAreHCHgi1+xGqXtvpkiLNz0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 30, 2020 at 05:54:15PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 30, 2020 at 5:50 PM Thomas Petazzoni
> <thomas.petazzoni@bootlin.com> wrote:
> > On Wed, 30 Sep 2020 17:24:48 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > > > On a Microchip SAMA5D3 platform that is receiving 20 bytes every 16ms
> > > > over one MAX310X UART, this patch has allowed to reduce the CPU
> > > > consumption of the interrupt handler thread from ~25% to 6-7%.
> > >
> > > Was it always like this?
> >
> > As far as I can see, yes. I guess you were thinking about a Fixes: tag
> > perhaps? I don't think a Fixes: tag really applies here, as we're not
> > fixing a performance regression.
> 
> Thanks for elaboration.
> 
> ...
> 
> > > > +       /* Reset FIFOs*/
> > >
> > > Add a space before the asterisk.
> >
> > Indeed. Let me know if a v2 is needed, or if this small typo can be
> > fixed when applying.
> 
> Greg usually doesn't touch commits, so v2 would be better.

Agreed, I don't like to edit things :)
