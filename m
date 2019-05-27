Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78A2B66D
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2019 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfE0NbY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 May 2019 09:31:24 -0400
Received: from muru.com ([72.249.23.125]:51266 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfE0NbX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 May 2019 09:31:23 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4249E80F3;
        Mon, 27 May 2019 13:31:42 +0000 (UTC)
Date:   Mon, 27 May 2019 06:31:19 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <notro@tronnes.org>
Cc:     Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net,
        merlijn@wizzup.org,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: 5.2-rc1 on droid4: spi crash
Message-ID: <20190527133119.GK5447@atomide.com>
References: <20190523090926.GA9106@amd>
 <20190523093325.6si5jpvrvyktpax6@earth.universe>
 <20190527055343.GG5447@atomide.com>
 <c741aa5b9d366b231b5c40899b1ef814@webmail.domeneshop.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c741aa5b9d366b231b5c40899b1ef814@webmail.domeneshop.no>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

* Noralf Trønnes <notro@tronnes.org> [190527 13:16]:
> 
> 
> Den 2019-05-27 07:53, skrev Tony Lindgren:
> > Hi,
> > 
> > * Sebastian Reichel <sre@kernel.org> [190523 09:33]:
> > > Hi,
> > > 
> > > On Thu, May 23, 2019 at 11:09:26AM +0200, Pavel Machek wrote:
> > > > This was greeting me overnight... I don't yet know how reproducible it
> > > > is, it happened once so far.
> > > 
> > > Please pipe the stacktrace into ./scripts/decode_stacktrace.sh
> > > to get a readable stacktrace, otherwise this is pretty much useless.
> > > FWIW the only SPI device in the Droid 4 is the PMIC.
> > 
> > I've seen this too, and looks like reverting commit c9ba7a16d0f1
> > ("spi: Release spi_res after finalizing message") fixes it based
> > several days of testing.
> > 
> > Noralf and Mark, any ideas what needs to be fixed here?
> 
> Mark has a revert in his for-5.2 branch:
> spi: Fix Raspberry Pi breakage
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-5.2&id=0ed56252c9567351344cb7b5cff6140e1bcec943

Oh OK good to hear.

> I don't know when or if he has sent a pull request.
> Sorry about the breakage.

No worries, thanks for the update.

Regards,

Tony
