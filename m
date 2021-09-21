Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD8413985
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 20:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhIUSIM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Sep 2021 14:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhIUSIM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Sep 2021 14:08:12 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0976C061574
        for <linux-spi@vger.kernel.org>; Tue, 21 Sep 2021 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5W1c1qRFRxqYY5If9COhUgWHtJAj9Aevb0JCkOxZkhQ=; b=EMl8/qtRRPq9FSwNMA5Re9GMuV
        /MzSdsGe+5JwM9vmN8nAXH/PVihB9NUamUzoMDT+lPM+ZBDEruCWq009Y0zo/Xhp+j6WQLdp+4/wC
        0bm3xWKiCE/joXXdsttnj6oJs4Qy0FDJZaFLCByPtYPFDsfH6KN2xcRZJSqPN0B8CZ9C6zVSjE2PV
        OQ3Z0HUBYkaVvVKKvKA2LJ1NIh3PE9DLThMeZCaIm70kY4NWDLunhasiKiT4cN2iT1nbbMRZqs+3f
        rGxZEw4V+6azRFUiTFl/HI/d8cW6Qb+iV0ZTX2Z8zBPlaznIERQ5uRtCc51oYJzo3DMbB9GC8XSNW
        iMo0xD7A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54716)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mSkAD-0002wZ-Nz; Tue, 21 Sep 2021 19:06:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mSkAC-0003Rh-UL; Tue, 21 Sep 2021 19:06:40 +0100
Date:   Tue, 21 Sep 2021 19:06:40 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Andreas Schwab <schwab@suse.de>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH] spi: Revert modalias changes
Message-ID: <YUofMKh4enbGVwPH@shell.armlinux.org.uk>
References: <20210921173222.46514-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921173222.46514-1-broonie@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 21, 2021 at 06:32:22PM +0100, Mark Brown wrote:
> During the v5.13 cycle we updated the SPI subsystem to generate OF style
> modaliases for SPI devices, replacing the old Linux style modalises we
> used to generate based on spi_device_id which are the DT style name with
> the vendor removed.  Unfortunately this means that we start only
> reporting OF style modalises and not the old ones and there is nothing
> that ensures that drivers list every possible OF compatible string in
> their OF ID table.  The result is that there are systems which have been
> relying on loading modules based on the old style that are now broken,
> as found by Russell King with spi-nor on Macchiatobin.
> 
> spi-nor is a particularly problematic case for this, it only lists a
> single generic DT compatible jedec,spi-nor in the driver but supports a
> huge raft of device specific compatibles, with a large set of part
> numbers many of which are offered by multiple vendors.  Russell's
> searches of upstream device trees has turned up examples with vendor
> names written in non-standard ways too.  To make matters worse up until
> 8ff16cf77ce3 ("Documentation: devicetree: m25p80: add "nor-jedec"
> binding") the generic compatible was not part of the binding so there
> are device trees out there written to that binding version which don't
> list it all.  The sheer number of parts supported together with our
> previous approach of ignoring the vendor ID makes robustly fixing this
> by adding compatibles to the spi-nor driver seem problematic, the
> current DT binding document does not list all the parts supported by the
> driver at the minute (further patches will fix this).
> 
> I've also investigated supporting both formats of modalias
> simultaneously but that doesn't seem possible, especially without
> breaking our userspace ABI which is obviously not viable.
> 
> Instead revert the relevant changes for now:
> 
> e09f2ab8eecc ("spi: update modalias_show after of_device_uevent_modalias support")
> 3ce6c9e2617e ("spi: add of_device_uevent_modalias support")
> 
> This will unfortunately mean that any system which had started having
> modules autoload based on the OF compatibles for drivers that list
> things there but not in the spi_device_ids will now not have those
> modules load which is itself a regression.  Since it affects a narrower
> time window and the particularly problematic spi-nor driver may be
> critical to system boot on smaller systems this seems the best of a
> series of bad options.  I will start an audit of SPI drivers to identify
> and fix cases where things won't autoload using spi_device_id, this is
> not great but seems to be the best way forward that anyone has been able
> to identify.
> 
> Thanks to Russell for both his report and the additional diagnostic and
> analysis work he has done here, the detailed research above was his
> work.
> 
> Fixes: e09f2ab8eecc ("spi: update modalias_show after of_device_uevent_modalias support")
> Fixes: 3ce6c9e2617e ("spi: add of_device_uevent_modalias support")
> Reported-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>

This is exactly the change I have in my local tree to fix the issue,
so...

Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
