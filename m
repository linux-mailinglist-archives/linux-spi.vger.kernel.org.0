Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCB534C3FB
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 08:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhC2Gsl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 02:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhC2GsY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 29 Mar 2021 02:48:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3B9A61477;
        Mon, 29 Mar 2021 06:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617000504;
        bh=h/GwI4je/YXpz4hXP9RoUzOScRxDivdynZC4pYA87lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p7PSQ3PL3rGnjcHpBzXguJXeMXQMF6Jb8aDMhETkcC8D+Z76b3Ljn1RUr68ftdJTr
         bQFniod4V7RyREQLJ7iTkS0ZReQakkZ9n4lyJUmLMgTuLCZWSLf5TFoom6zP0ZfRgT
         k0Ybj8elR9zQl6q4lKMeuvKvJQYPDyO2K1y9Qsmk=
Date:   Mon, 29 Mar 2021 08:48:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] gpio: Use linux/gpio/driver.h
Message-ID: <YGF4Ns8+S9I9Za33@kroah.com>
References: <20210329015938.20316-1-brad@pensando.io>
 <20210329015938.20316-14-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329015938.20316-14-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 28, 2021 at 06:59:38PM -0700, Brad Larson wrote:
> New drivers should include <linux/gpio/driver.h> instead
> of legacy <linux/gpio.h>.
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
>  drivers/gpio/gpio-elba-spics.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-elba-spics.c b/drivers/gpio/gpio-elba-spics.c
> index 351bbaeea033..c0dce5333f35 100644
> --- a/drivers/gpio/gpio-elba-spics.c
> +++ b/drivers/gpio/gpio-elba-spics.c
> @@ -6,11 +6,10 @@
>   */
>  
>  #include <linux/err.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/module.h>
>  #include <linux/io.h>
>  #include <linux/init.h>
> -//#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> -- 
> 2.17.1
> 

This should be part of patch 1/13, do not add a problem and then fix it
up in the same patch series.

thanks,

greg k-h
