Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BD3412A82
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 03:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhIUBm5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 21:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbhIUBjG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 21:39:06 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B4BC01AE55
        for <linux-spi@vger.kernel.org>; Mon, 20 Sep 2021 12:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SyYHElO//RFrqLgD5SU2b7gosmKO+zs8qSHZUgC15LA=; b=YPIbCsPHzsWdDEZwF0huERz7wy
        /xQh1cZRoBWIu5uK8RErricQYseDKzhTy9R6pH5OXoAuNwn4B5pMcHyTXxdj2dzrKJVu5DgAlX7Nt
        WDqDax1bDz43hP1efBRR9xaMkotCrCd2PxKe0MBrwQMkclrBKO+HWHNEWCLSgu39zcTG7/rN/rqP3
        Y0LPtJE09McCc95xw+8d2QE0vHSdrPeIhVtPEZ2C7OlEtg4jIjXKb9NO7JTrdku2HAIOdq4PCUX+G
        ag8N/os1XylmqR5nmU/8Q7LIi/xFx1nWd0yIdX7DA7hJU80bqaPqtB+m1+idhXGRrT72GAu/ZIwjS
        JaYHIrEQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54680)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mSP6S-0001zj-5Y; Mon, 20 Sep 2021 20:37:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mSP6R-0002Wx-DC; Mon, 20 Sep 2021 20:37:23 +0100
Date:   Mon, 20 Sep 2021 20:37:23 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Andreas Schwab <schwab@suse.de>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, robh@kernel.org
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
Message-ID: <YUji89/msWkijl+9@shell.armlinux.org.uk>
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
 <20210920183327.GO4192@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920183327.GO4192@sirena.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 20, 2021 at 07:33:27PM +0100, Mark Brown wrote:
> On Mon, Sep 20, 2021 at 11:20:29AM +0100, Russell King (Oracle) wrote:
> 
> > spi-flash@0 {
> >         compatible = "st,w25q32";
> 
> > which is entirely legal according to the binding documentation in
> > Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml.
> 
> Are you sure?  Looking at the binding document it appears that the
> fallback to jedec,spi-nor is mandatory in all cases - it's either one of
> the two items: cases both of which are lists with jedec,spi-nor in them
> or just the plain jedec,spi-nor fallback.  It kind of doesn't matter
> given that we weren't enforcing it in the past but still.

We aren't even enforcing it today either - running the DT checker is
entirely optional, and it's not even carried by distros, so across
distro upgrades it breaks. I'd also suggest that almost no one bothers
to run it either, looking at the almost 6700 lines of output it
produces for my build - the chances of spotting anything relevant in
that are practically zero.

Nevertheless:

arch/arm64/boot/dts/marvell/armada-8040-mcbin.dt.yaml:0:0: /cp1/config-space@f4000000/spi@700680/spi-flash@0: failed to match any schema with compatible: ['st,w25q32']

because, although the driver accepts devices of type "w25q32", it
isn't listed in the DT schema. However, the driver code itself
accepts that "w25q32" is used in DT - so the schema is out of step
with the driver and has been for ages.

        /*
         * Entries that were used in DTs without "jedec,spi-nor" fallback and
         * should be kept for backward compatibility.
         */
        {"at25df321a"}, {"at25df641"},  {"at26df081a"},
        {"mx25l4005a"}, {"mx25l1606e"}, {"mx25l6405d"}, {"mx25l12805d"},
        {"mx25l25635e"},{"mx66l51235l"},
        {"n25q064"},    {"n25q128a11"}, {"n25q128a13"}, {"n25q512a"},
        {"s25fl256s1"}, {"s25fl512s"},  {"s25sl12801"}, {"s25fl008k"},
        {"s25fl064k"},
        {"sst25vf040b"},{"sst25vf016b"},{"sst25vf032b"},{"sst25wf040"},
        {"m25p40"},     {"m25p80"},     {"m25p16"},     {"m25p32"},
        {"m25p64"},     {"m25p128"},
        {"w25x80"},     {"w25x32"},     {"w25q32"},     {"w25q32dw"},
        {"w25q80bl"},   {"w25q128"},    {"w25q256"},

> > MODALIAS=of:Nspi-flashT(null)Cst,w25q32
> 
> > However, the spi-nor module only supports these "of" modaliases:
> 
> > alias:          of:N*T*Cjedec,spi-norC*
> > alias:          of:N*T*Cjedec,spi-nor
> 
> > but supports _way_ more "spi" modaliases, including "spi:w25q32".
> 
> > Therefore, this change breaks module autoloading.
> 
> Ugh, right.  This sort of stuff is why I really dislike not listing all
> the compatibles in driver like some of the SoC vendors seem allergic to,
> I keep having to fight for that.  
> 
> > Hence there are two commits that may need to be reverted:
> 
> > e09f2ab8eecc ("spi: update modalias_show after of_device_uevent_modalias support")
> > 3ce6c9e2617e ("spi: add of_device_uevent_modalias support")
> 
> This then causes issues for anything trying to bind based with DT
> aliases AIUI so it's just pushing the problems around to different
> devices.  I think ideally we should be including the fallback compat IDs
> that could also be matched along with the OF aliases.

I have a different view. These patches have fixed one problem by
creating another problem - they have _changed_ the module alias
that SPI creates for DT.

Originally, the module alias was created via of_modalias_node()
in of_register_spi_device():

        /* Select device driver */
        rc = of_modalias_node(nc, spi->modalias,
                                sizeof(spi->modalias));
        if (rc < 0) {
                dev_err(&ctlr->dev, "cannot find modalias for %pOF\n", nc);
                goto err_out;
        }

However, as a result of the above two commits, the modalias that
is now given to userspace has changed from whatever
of_modalias_node() produced to whatever of_device_modalias() and
of_device_uevent_modalias() produces - which is something quite
different.

So, IMHO the change in these two patches was _wrong_ and always
was wrong, and was always going to lead to this problem. Randomly
deciding to have a different modalias policy is always going to
lead to problems like this.

> > Alternatively, we need to add _all_ the flash types that the spi-nor
> > driver supports to the DT table, which sounds like a recipe for
> > disaster waiting to happen as it means maintaining two large tables of
> > flash devices, one for the SPI aliases with the flash information and
> > one for the DT aliases.
> 
> That doesn't seem particularly hard TBH, and if we're going to be
> listing any compatibles we really ought to be including them all rather
> than just a random one.

Looking at the shere number of combinations given the regexp in
the DT binding document, I think someone would need to script its
generation - expanding just the first set leads to:

micron,m25p40
micron,m25p80
micron,m25p16
micron,m25p32
micron,m25p64
micron,m25p128
spansion,m25p40
spansion,m25p80
spansion,m25p16
spansion,m25p32
spansion,m25p64
spansion,m25p128
st,m25p40
st,m25p80
st,m25p16
st,m25p32
st,m25p64
st,m25p128
m25p40
m25p80
m25p16
m25p32
m25p64
m25p128

And then you have a similar set for n25q*. Once all of that regexp
has been expanded, one then needs to add the list for "backward
compatibility" with all the different manufacturer prefixes that
of_modalias_node() stripped off.

Are you really sure this is a solution you wish to require?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
