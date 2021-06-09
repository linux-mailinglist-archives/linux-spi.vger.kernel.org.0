Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624803A0E7E
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jun 2021 10:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhFIIJ1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Jun 2021 04:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbhFIIJT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Jun 2021 04:09:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50DDC061574
        for <linux-spi@vger.kernel.org>; Wed,  9 Jun 2021 01:07:24 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1lqtFD-0008Nj-As; Wed, 09 Jun 2021 10:07:23 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1lqtFC-0005AL-TG; Wed, 09 Jun 2021 10:07:22 +0200
Date:   Wed, 9 Jun 2021 10:07:22 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v1] spi: add of_device_uevent_modalias support
Message-ID: <20210609080722.36slsf7xr36ydv2y@pengutronix.de>
References: <20210525091003.18228-1-m.felsch@pengutronix.de>
 <20210604154530.GE4045@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604154530.GE4045@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 18:00:08 up 184 days,  6:06, 38 users,  load average: 0.20, 0.25,
 0.13
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 21-06-04 16:45, Mark Brown wrote:
> On Tue, May 25, 2021 at 11:10:03AM +0200, Marco Felsch wrote:
> > Add OF support as already done for ACPI to take driver
> > MODULE_DEVICE_TABLE(of, ..) into account.
> > 
> > For example with this change a spi nor device MODALIAS changes from:
> > 
> > MODALIAS=spi:spi-nor
> > 
> > to
> > 
> > MODALIAS=of:Nspi-flashT(null)Cjedec,spi-nor
> 
> Will this break existing userspace?

No, if I understood the mechanism correctly. 

The MODULE_DEVICE_TABLE(of, ..) and the MODULE_DEVICE_TABLE(spi, ..)
should equal except for the "vendor," prefix used by the
MODULE_DEVICE_TABLE(of, ..). If a driver don't support
MODULE_DEVICE_TABLE(of, ..) we fallback to the
MODULE_DEVICE_TABLE(spi, ..).

I would instead say that it fixes at least the spi-nor usage e.g.

spi-nor@0 {
	compatible = "vendor,product", "jedec,spi-nor";
}

is a common OF usage: the compatible list goes from the exact compatible
to the least common compatible. Here I should fix my commit message
which should include this line:
"MODALIAS=of:Nspi-flashT(null)Cwinbond,w25q16dwCjedec,spi-nor".

Anyway this scenario don't work for spi-nor driver since the spi-core
only take the MODULE_DEVICE_TABLE(spi, ..) into account. So the
compatible must not include the "vendor,product" compatible.

With my change in place we can specify the 'complete' compatible list.

Regards,
  Marco

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
