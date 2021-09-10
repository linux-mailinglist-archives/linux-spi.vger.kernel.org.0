Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534CC4067FF
	for <lists+linux-spi@lfdr.de>; Fri, 10 Sep 2021 09:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhIJHxP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Sep 2021 03:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhIJHxP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Sep 2021 03:53:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15D4C061574
        for <linux-spi@vger.kernel.org>; Fri, 10 Sep 2021 00:52:04 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mObKG-0008TF-04; Fri, 10 Sep 2021 09:51:56 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1mObKE-0003rS-CR; Fri, 10 Sep 2021 09:51:54 +0200
Date:   Fri, 10 Sep 2021 09:51:54 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mark Brown <broonie@kernel.org>,
        kernel test robot <lkp@intel.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH v1] Input: ads7846: ads7846_get_value - fix unaligned
 pointer value warning
Message-ID: <20210910075154.GF26100@pengutronix.de>
References: <20210707124115.20028-1-o.rempel@pengutronix.de>
 <YTrnUFI53iwvwxrj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTrnUFI53iwvwxrj@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:49:56 up 204 days, 11:13, 101 users,  load average: 0.19, 0.16,
 0.15
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dmitry,

On Thu, Sep 09, 2021 at 10:04:16PM -0700, Dmitry Torokhov wrote:
> Hi Oleksij,
> 
> On Wed, Jul 07, 2021 at 02:41:15PM +0200, Oleksij Rempel wrote:
> > Fix warning reported by the kernel test robot:
> > drivers/input/touchscreen/ads7846.c:705:24: warning: taking address
> > of packed member 'data' of class or structure 'ads7846_buf' may result
> > in an unaligned pointer value [-Waddress-of-packed-member]
> > 
> > Fixes: 6965eece2a89 ("Input: ads7846 - convert to one message")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  drivers/input/touchscreen/ads7846.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> > index adb4c2230c31..1987dedac94f 100644
> > --- a/drivers/input/touchscreen/ads7846.c
> > +++ b/drivers/input/touchscreen/ads7846.c
> > @@ -702,7 +702,7 @@ static int ads7846_get_value(struct ads7846_buf *buf)
> >  {
> >  	int value;
> >  
> > -	value = be16_to_cpup(&buf->data);
> > +	value = get_unaligned_be16(&buf->data);
> 
> ds7846_buf is declared as packed so I believe using be16_to_cpu(buf->data)
> will suffice.

The pointer to the data is is off by 8 bits, so it is not naturally
aligned. This is why we need to use function which is dealing with
unaligned pointers. 

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
