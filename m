Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98A338CEB5
	for <lists+linux-spi@lfdr.de>; Fri, 21 May 2021 22:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEUUSO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 May 2021 16:18:14 -0400
Received: from tux.runtux.com ([176.9.82.136]:39598 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhEUUSN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 21 May 2021 16:18:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id A67A36F00A;
        Fri, 21 May 2021 22:16:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id iCAZBfAfgrdo; Fri, 21 May 2021 22:16:46 +0200 (CEST)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id C17A26EF63;
        Fri, 21 May 2021 22:16:45 +0200 (CEST)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 09F0246E; Fri, 21 May 2021 22:16:44 +0200 (CEST)
Date:   Fri, 21 May 2021 22:16:44 +0200
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mirko Vogt <mirko-dev|linux@nanl.de>
Subject: Re: [PATCH 1/1] spi-sun6i: Fix chipselect/clock bug
Message-ID: <20210521201644.ksjgsjvdud2wblbe@runtux.com>
References: <20210520100656.rgkdexdvrddt3upy@runtux.com>
 <20210521173011.1c602682@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521173011.1c602682@slackpad.fritz.box>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 21, 2021 at 05:30:11PM +0100, Andre Przywara wrote:
> On Thu, 20 May 2021 12:06:56 +0200
> Ralf Schlatterbeck <rsc@runtux.com> wrote:
> So if I get your last email correctly, your intention was to make this
> Mirko's patch, which you just send?

Yes.

> In this case the authorship should stay with him (git commit --amend
> --author "..."), and you add your S-o-b (his first, your's next).
> If you use git format-patch & git send-email, it will take care of
> formatting this correctly (inserting a "From" line into the body).

I was using format-patch but editing the result. Would a 'Date' line in
the body also be OK? The patch is really from 2019...

I have it correctly in my git but was unaware that additional header
lines in the body are ok.

> One formatting thing below:
> >  	sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
> > +	/* Finally enable the bus - doing so before might raise SCK to HIGH */
> > +	sun6i_spi_write(sspi, SUN6I_GBL_CTL_REG,
> > +			sun6i_spi_read(sspi, SUN6I_GBL_CTL_REG)
> > +			| SUN6I_GBL_CTL_BUS_ENABLE);
> 
> The "|" on the new line looks a bit odd. What about you utilise "reg"
> here, as the other access do, to make this more readable?
> 	reg = sun6i_spi_read(...);
> 	reg |= ...
> 	sun6i_spi_write(..., reg);

I've fixed this and will resubmit.

Thanks,
Ralf
