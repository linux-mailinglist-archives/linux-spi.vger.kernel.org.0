Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A2C413200
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 12:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhIUK5Y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 06:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhIUK5Y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Sep 2021 06:57:24 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E10C061574
        for <linux-spi@vger.kernel.org>; Tue, 21 Sep 2021 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jW86SWYqpqUR7ChJG//j3LlKbbXi/0l9O5p16hAbQ00=; b=F8kQi5NsEDEdaGkbwkYZZwt2SM
        puLXeyh8iwZoMdcD05/JmbWeHWnfeZwEO++wqebUrLPRLQkZOct3Ho/9Oi23lzW2l6hfIlZ0umtfk
        Y5RiS050uuERi4/NLT1iPfWkkUa0bzCxHhE1AA393P0j9bHlYLrzUCALcyGvP0VowrsNIfmX4JIWu
        y1+/PQuWT6yP82m+rPt7b4JkGirN7EtwwzRYrdPlhc/4fHbjjtOtlxCmWyQdpqo3pUB1GoIcXp7A5
        va7g1tJJIV1mimpf8hK454TJuVt7KOYKvuTqii4lcE+RHar1nrAWPbL/yZvhgl4sSecty6ObiaWk9
        ka2t42hg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54700)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mSdRJ-0002Xy-58; Tue, 21 Sep 2021 11:55:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mSdRI-0003C9-Cb; Tue, 21 Sep 2021 11:55:52 +0100
Date:   Tue, 21 Sep 2021 11:55:52 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Andreas Schwab <schwab@suse.de>, linux-spi@vger.kernel.org,
        kernel@pengutronix.de, robh@kernel.org
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
Message-ID: <YUm6OI7RJ1vRSmYA@shell.armlinux.org.uk>
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
 <20210920183327.GO4192@sirena.org.uk>
 <YUji89/msWkijl+9@shell.armlinux.org.uk>
 <YUj8S5XIR5+EAk7e@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUj8S5XIR5+EAk7e@sirena.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 20, 2021 at 10:25:31PM +0100, Mark Brown wrote:
> On Mon, Sep 20, 2021 at 08:37:23PM +0100, Russell King (Oracle) wrote:
> > On Mon, Sep 20, 2021 at 07:33:27PM +0100, Mark Brown wrote:
> > > On Mon, Sep 20, 2021 at 11:20:29AM +0100, Russell King (Oracle) wrote:
> 
> > > Are you sure?  Looking at the binding document it appears that the
> > > fallback to jedec,spi-nor is mandatory in all cases - it's either one of
> > > the two items: cases both of which are lists with jedec,spi-nor in them
> > > or just the plain jedec,spi-nor fallback.  It kind of doesn't matter
> > > given that we weren't enforcing it in the past but still.
> 
> > We aren't even enforcing it today either - running the DT checker is
> > entirely optional, and it's not even carried by distros, so across
> > distro upgrades it breaks. I'd also suggest that almost no one bothers
> > to run it either, looking at the almost 6700 lines of output it
> > produces for my build - the chances of spotting anything relevant in
> > that are practically zero.
> 
> Right, good - my read of the DT binding document was correct at
> least.  Like we're both saying it doesn't really matter what was
> documented, what we were accepting is what matters.

Indeed - today's reading of the DT binding document, but that misses
the history.  See commit:

8ff16cf77ce3 ("Documentation: devicetree: m25p80: add "nor-jedec"
binding")

Originally, this driver _only_ accepted a specific device name in the
compatible. This commit added "nor-jedec". This introduced the
requirement in March 2015 for this property to be present.

8947e396a829 ("Documentation: dt: mtd: replace "nor-jedec" binding with
"jedec, spi-nor"")

In May 2015, this converted commit "nor-jedec" to the "jedec,spi-nor"
we have today, and renamed the binding file from m25p80.txt to
jedec,spi-nor.txt.

So, I don't think we can hold any DTS file to conform to the binding
document given that:
(a) the binding document originally allowed it,
(b) that the driver doesn't warn that the "jedec,spi-nor" is missing,
(c) checking of the dts files for correctness to the binding
    documentation has historically been very poor.
(d) DT is an interface we should avoid regressions, just like the
    kernel to userspace interface.

> > because, although the driver accepts devices of type "w25q32", it
> > isn't listed in the DT schema. However, the driver code itself
> > accepts that "w25q32" is used in DT - so the schema is out of step
> > with the driver and has been for ages.
> 
> Looks like it's trying to list it but not quite managing.
> Another thing to fix...

Indeed. :(

> > > This then causes issues for anything trying to bind based with DT
> > > aliases AIUI so it's just pushing the problems around to different
> > > devices.  I think ideally we should be including the fallback compat IDs
> > > that could also be matched along with the OF aliases.
> 
> > I have a different view. These patches have fixed one problem by
> > creating another problem - they have _changed_ the module alias
> > that SPI creates for DT.
> 
> > Originally, the module alias was created via of_modalias_node()
> > in of_register_spi_device():
> 
> >         /* Select device driver */
> >         rc = of_modalias_node(nc, spi->modalias,
> >                                 sizeof(spi->modalias));
> >         if (rc < 0) {
> >                 dev_err(&ctlr->dev, "cannot find modalias for %pOF\n", nc);
> >                 goto err_out;
> >         }
> 
> > However, as a result of the above two commits, the modalias that
> > is now given to userspace has changed from whatever
> > of_modalias_node() produced to whatever of_device_modalias() and
> > of_device_uevent_modalias() produces - which is something quite
> > different.
> 
> > So, IMHO the change in these two patches was _wrong_ and always
> > was wrong, and was always going to lead to this problem. Randomly
> > deciding to have a different modalias policy is always going to
> > lead to problems like this.
> 
> Hrm, right - I hadn't really registered that we were generating
> compat modaliases in quite that way (and hadn't had the bandwidth
> to dig into that properly today, should do tomorrow).  First pass
> I'd think that either SPI or probably of_device_uevent_modalias()
> ought to be generating both formats (assuming we can list
> multiple modaliases which I'm not sure on) but like I say I've
> really not dug into this properly yet at this point.
> 
> I'm reasonably sure we should be continuing to generate the old
> style modalises like a revert would, my main questions are if we
> can arrange to provide both types so that anything that won't
> match on the compat type can also work, and if there's any
> fallout that needs fixing up if we can't and end up doing the
> revert.

Initially, I thought we could possibly export two modaliases, since
it works for DT...

/sys/bus/platform/devices/f0400000.xor/uevent
OF_NAME=xor
OF_FULLNAME=/ap806/config-space@f0000000/xor@400000
OF_COMPATIBLE_0=marvell,armada-7k-xor
OF_COMPATIBLE_1=marvell,xor-v2
OF_COMPATIBLE_N=2
MODALIAS=of:NxorT(null)Cmarvell,armada-7k-xorCmarvell,xor-v2

/sys/bus/platform/devices/f0400000.xor/modalias
of:NxorT(null)Cmarvell,armada-7k-xorCmarvell,xor-v2

So, I wondered whether we combine the of: and spi: forms like this:

of:...spi:...

However, it seems we can't do that - Debian Bullseye modprobe:
root@mcbin-ss:~# modprobe -R "of:NfooTbarCatmel,24c2048"
at24
root@mcbin-ss:~# modprobe -R "spi:fooof:NfooTbarCatmel,24c2048"
modprobe: FATAL: Module spi:fooof:NfooTbarCatmel,24c2048 not found in directory /lib/modules/5.14.0+

So it looks like we're stuck with having exactly one modalias string
exported, which we can't sanely change once we've settled on one
scheme for modaliases for a bus type and firmware combination.

> It's true that the manufacturer prefixes blow stuff up for this
> particular driver especially badly without wildcards which gets
> messy...  the interaction between generic parts like flash and
> the DT aliases definitely isn't at all nice at the minute, the
> compat stuff is doing a good job of sidestepping some of the
> explosion in compatibles.

Yes, certainly true... and then there's typos as well:

arch/arm/boot/dts/keystone-k2hk-evm.dts:                compatible = "Micron,n25q128a11";
arch/arm/boot/dts/keystone-k2e-evm.dts:         compatible = "Micron,n25q128a11";

where "Micron," should of course be "micron,". The prefix is irrelevant
because that part gets discarded by of_modalias_node() in
of_register_spi_device() when generating the modalias.

Going through the list in spi-nor/core.c and checking the DTS files,
it's random what you find. Sometimes they have a valid manufacturer
prefix, sometimes they don't. Sometimes they have "jedec,spi-nor",
sometimes they don't. Sometimes they only list "jedec,spi-nor".

I haven't been through them all - I stopped at n25q064, so there are
probably more gems such as the above to be found.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
