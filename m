Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B4392CE1
	for <lists+linux-spi@lfdr.de>; Thu, 27 May 2021 13:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhE0LlB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 May 2021 07:41:01 -0400
Received: from tux.runtux.com ([176.9.82.136]:44174 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233044AbhE0LlA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 27 May 2021 07:41:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id C31B96F051;
        Thu, 27 May 2021 13:39:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id KdnsqXt3na9a; Thu, 27 May 2021 13:39:22 +0200 (CEST)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id AC2A76F04A;
        Thu, 27 May 2021 13:39:21 +0200 (CEST)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id C8C8046E; Thu, 27 May 2021 13:39:20 +0200 (CEST)
Date:   Thu, 27 May 2021 13:39:20 +0200
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mirko Vogt <mirko-dev|linux@nanl.de>
Subject: Re: [PATCH 1/1] spi-sun6i: Fix chipselect/clock bug
Message-ID: <20210527113920.ncpzrpst2d6rij3t@runtux.com>
References: <20210520100656.rgkdexdvrddt3upy@runtux.com>
 <20210521173011.1c602682@slackpad.fritz.box>
 <20210521201913.2gapcmrzynxekro7@runtux.com>
 <YK0LR3077RUsSYti@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK0LR3077RUsSYti@sirena.org.uk>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 25, 2021 at 03:35:51PM +0100, Mark Brown wrote:
> On Fri, May 21, 2021 at 10:19:13PM +0200, Ralf Schlatterbeck wrote:
> > From: Mirko Vogt <mirko-dev|linux@nanl.de>
> > 
> > The current sun6i SPI implementation initializes the transfer too early,
> > resulting in SCK going high before the transfer. When using an additional
> > (gpio) chipselect with sun6i, the chipselect is asserted at a time when
> > clock is high, making the SPI transfer fail.
> 
> Please don't send new patches in reply to old threads, this makes
> it hard to follow what is going on and creates confusion as to
> what the current version of things is and means things can easily
> get missed if the earlier thread gets discarded - this goes along
> with the thing Andre mentioned about flagging the version of the
> patch in the subject line.

OK, let me know if I should repost in new thread with increased version
number in the subject.

Thanks,
Ralf
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com
