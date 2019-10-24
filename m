Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A127E33C9
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2019 15:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbfJXNS7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Oct 2019 09:18:59 -0400
Received: from salem.gmr.ssr.upm.es ([138.4.36.7]:38206 "EHLO
        salem.gmr.ssr.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfJXNS7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Oct 2019 09:18:59 -0400
Received: by salem.gmr.ssr.upm.es (Postfix, from userid 1000)
        id CD463AC0078; Thu, 24 Oct 2019 15:18:57 +0200 (CEST)
Date:   Thu, 24 Oct 2019 15:18:57 +0200
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] spi: set bits_per_word based on controller's
 bits_per_word_mask
Message-ID: <20191024131856.GA32609@salem.gmr.ssr.upm.es>
References: <20191024110757.25820-1-alvaro.gamez@hazent.com>
 <20191024110757.25820-4-alvaro.gamez@hazent.com>
 <20191024111300.GD5207@sirena.co.uk>
 <20191024125436.GA8878@salem.gmr.ssr.upm.es>
 <20191024131129.GE46373@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024131129.GE46373@sirena.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 24, 2019 at 02:11:29PM +0100, Mark Brown wrote:
> On Thu, Oct 24, 2019 at 02:54:37PM +0200, Alvaro Gamez Machado wrote:
> 
> > I think then the only way this would be feasible is to check if 8 bits is an
> > acceptable number for the master and, if it isn't, apply the lowest
> > available data width. I believe this cannot break anything, as it leaves 8
> > as the default unless the master can't work with that number, in which case
> > it really doesn't matter what client device wants because the hardware can't
> > provide it.
> 
> No, that still leaves the slave driver thinking it's sending 8 bits when
> really it's sending something else - the default is just 8 bits, if the
> controller can't do it then the transfer can't happen and there's an
> error.  It's not a good idea to carry on if we're likely to introduce
> data corruption.

Well, yes. But I don't think that's a software issue but a hardware one.

If you have a board that has a SPI master that cannot talk to an 8 bits
device and you expect to communicate with anything that accepts 8 bits
you're not going to be able to. Either the kernel raises an error or it
shuts up and tries its best. I understand the first option is better, but I
also think that's not a software issue, that hardware simply cannot work as
is regardless of what we do in software. The hardware devices simply can't
talk to each other.


-- 
Alvaro G. M.
