Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8370AE0395
	for <lists+linux-spi@lfdr.de>; Tue, 22 Oct 2019 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbfJVMGN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Oct 2019 08:06:13 -0400
Received: from salem.gmr.ssr.upm.es ([138.4.36.7]:49694 "EHLO
        salem.gmr.ssr.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388305AbfJVMGN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Oct 2019 08:06:13 -0400
Received: by salem.gmr.ssr.upm.es (Postfix, from userid 1000)
        id CB1FAAC0072; Tue, 22 Oct 2019 14:06:11 +0200 (CEST)
Date:   Tue, 22 Oct 2019 14:06:11 +0200
From:   Alvaro Gamez Machado <alvaro.gamez@hazent.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: xilinx: Add DT support for selecting transfer word
 width
Message-ID: <20191022120610.GA28659@salem.gmr.ssr.upm.es>
References: <20191022090007.15147-1-alvaro.gamez@hazent.com>
 <20191022102007.GA5554@sirena.co.uk>
 <20191022102859.GA1928@salem.gmr.ssr.upm.es>
 <20191022112600.GD5554@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022112600.GD5554@sirena.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Oct 22, 2019 at 12:26:00PM +0100, Mark Brown wrote:
> On Tue, Oct 22, 2019 at 12:29:01PM +0200, Alvaro Gamez Machado wrote:
> > On Tue, Oct 22, 2019 at 11:20:07AM +0100, Mark Brown wrote:
> 
> > > Any new DT property needs documentation adding but in any case this
> 
> > Oh, ok. If this patch is of any interest, then I should provide changes to
> > the appropriate file under Documentation/, is that right?
> 
> Yes.
> 
> > I was preparing and testing a second patch to add "spi-bits-per-word"
> > property to children of the SPI driver, similar to the spi-max-frequency
> > property and others alike, to fully support AXI Quad SPI core with different
> > word widths. This also modifies the DT, so I guess it'd be better to send a
> > single patch that comprises all these changes alongside the DT
> > documentation. Would that be correct procedure?
> 
> Usually the DT changes should be a separate patch to the code changes.

Understood, thank you!
 
> > > shouldn't be set in DT, it should be set by the client driver - it's
> > > going to be a fixed property of the device, not something that varies
> > > per system.
> 
> > But this is in fact something that changes per system. When instantiating an
> > AXI Quad SPI core in a HDL design that's exactly one of the options you can
> > provide. In fact, in the board I'm working with right now, I'm instantiating
> > two SPI cores, one of them with 8 bits per word but the other one requires
> > 32 bits per word, as the devices it's going to talk to have this
> > requirement.
> 
> This is still something that should be configured by the client driver,
> if you send data with a different word size to that the client intends
> it'll just get corrupted.


The problem is that Xilinx's AXI Quad SPI core doesn't allow this. When
instantiating the core you must choose *the* transfer width, not the
*maximum* transfer width. So in my example above, no matter how I configure
my IP core, linux'll believe that its datawidth is 8. I could override it
hardcoding a 32 in spi-xilinx.c, but then what would happen with my other
IP core that needs a datawidth of 8? Client code cannot configure IP core
with a different datawidth because it simply does not allow it.


-- 
Alvaro G. M.
