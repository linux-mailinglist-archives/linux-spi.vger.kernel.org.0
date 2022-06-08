Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8BE542F4A
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jun 2022 13:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiFHLg2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jun 2022 07:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbiFHLg1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jun 2022 07:36:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D390012DBE7;
        Wed,  8 Jun 2022 04:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9E0EB82725;
        Wed,  8 Jun 2022 11:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59C1C34116;
        Wed,  8 Jun 2022 11:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654688181;
        bh=dP9Oy9WgkXliN2Ot6SgwXyz2r0kt7Q/vFTkP+WlQgx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaIGMkPng8ojejS7t6MKm/Ln1HkuE+bxJhOpqA4XVLVC9p6BXaisvA/Ah/aC1T8c5
         /DjroI2fuvLlbeN0ynkfuRqaXrIGJyVZxYGvEcuW4tnAHrtf8r1jtVmX6Xrk5UdJPm
         CLQi8Nh8qaPMUwbm56W9WGQUdBzBRrIFjevoNGVY=
Date:   Wed, 8 Jun 2022 13:36:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 2/2] spi: Use device_find_first_child() instead of
 custom approach
Message-ID: <YqCJsRqrCRiIBm1P@kroah.com>
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
 <20220607202058.8304-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607202058.8304-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jun 07, 2022 at 11:20:58PM +0300, Andy Shevchenko wrote:
> We have already a helper to get the first child device, use it and
> drop custom approach.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/spi/spi.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ea09d1b42bf6..87dc8773108b 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2613,11 +2613,6 @@ int spi_slave_abort(struct spi_device *spi)
>  }
>  EXPORT_SYMBOL_GPL(spi_slave_abort);
>  
> -static int match_true(struct device *dev, void *data)
> -{
> -	return 1;
> -}
> -
>  static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
>  			  char *buf)
>  {
> @@ -2625,7 +2620,7 @@ static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
>  						   dev);
>  	struct device *child;
>  
> -	child = device_find_child(&ctlr->dev, NULL, match_true);
> +	child = device_find_first_child(&ctlr->dev);
>  	return sprintf(buf, "%s\n",
>  		       child ? to_spi_device(child)->modalias : NULL);
>  }

Horrible naming convention asside, what is this really showing?  I do
not see this documented in Documentation/ABI/ anywhere, so can it just
be dropped entirely?

Ah, it's in Documentation/spi/spi-summary.rst not where it belongs...

Looks like "any" of the child devices could match here, so it's just
finding the first one by default.  So you aren't explicitly asking for
the real first device, you could return the last one as well, and it
would still work as there is just "one" device in this list from what I
can tell.

So is does this really deserve a new driver core api call?

thanks,

greg k-h
