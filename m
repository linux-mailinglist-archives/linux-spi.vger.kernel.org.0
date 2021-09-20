Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91842412A83
	for <lists+linux-spi@lfdr.de>; Tue, 21 Sep 2021 03:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhIUBm6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Sep 2021 21:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhIUBj0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Sep 2021 21:39:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DF7C0430C0
        for <linux-spi@vger.kernel.org>; Mon, 20 Sep 2021 12:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/6c42fYE/7lG3/aFbd19OPysq1saJXw7nUgcW7B0RDU=; b=sjCOkjPZGIuvzzAlsoD/ELiIXJ
        Hx7ykvm4FEeByip3j14PT3TbflLSI9T9UGXFJRh8KRvTA9gO+A3IN3VxWhXiRMCOThJ30arFtYE2x
        Rxq1oj3Gs2zMH0sPZGBRFTzRflRVbHfX+4exUfDn2y9Oue4jmWNwnJgKbrwPISXnJWQFz/BM61uBM
        FhZvJhYfwKN69yK6vBfDCHYqWJUrkC3aT2jPee5Htmxdnctuq7JDaeseWU5ws82f8lIH15cdQeFX9
        7nIcLhiA/5++X1AuwV041BaiK6KEZ4+Rl5h9xC48KiioD1LzN84/qQrTVFv0qCliN+ctOZEbGHxz4
        hVqM9gcw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54682)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mSPI2-00020K-Rm; Mon, 20 Sep 2021 20:49:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mSPI1-0002Xw-WD; Mon, 20 Sep 2021 20:49:22 +0100
Date:   Mon, 20 Sep 2021 20:49:21 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andreas Schwab <schwab@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     broonie@kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: REGRESSION: "spi: add of_device_uevent_modalias support" and
 following "fix" breaks Macchiatobin
Message-ID: <YUjlwaRdmFMZHJYO@shell.armlinux.org.uk>
References: <YUhgbW8CiYI/rm+y@shell.armlinux.org.uk>
 <871r5j6nlw.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r5j6nlw.fsf@igel.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Sep 20, 2021 at 09:41:47PM +0200, Andreas Schwab wrote:
> On Sep 20 2021, Russell King (Oracle) wrote:
> 
> > Therefore, this change breaks module autoloading.
> 
> Reverting this change breaks module autoloading.

No.

Module autoloading worked before. Then someone probably noticed a
problem, and thought they'd fix it by changing how the module alias
strings SPI provides are produced. In fixing it, they broke existing
setups that have worked for years.

If you think it's acceptable to break existing setups to fix a bug
you need to be reminded of Linus' rant:

  https://lkml.org/lkml/2018/8/3/621

"  Bugs happen. That's a fact of life. Arguing that "we had to break
   something because we were fixing a bug" is completely insane. We fix
   tens of bugs every single day, thinking that "fixing a bug" means
   that we can break something is simply NOT TRUE."

It seems that is exactly what has happened here: a change was
introduced to fix an apparently module autoloading bug that has
caused _another_ module autoloading bug that wasn't originally
there.

That is not fixing a bug at all.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
