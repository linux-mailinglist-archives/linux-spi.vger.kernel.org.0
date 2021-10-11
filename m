Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678D4429186
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244412AbhJKOTU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 10:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244575AbhJKORS (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Oct 2021 10:17:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92AD060E94;
        Mon, 11 Oct 2021 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633961417;
        bh=twY86GyOFxFdM+8v8o2jtNaJsnEqp/BcidL44Qc6ln8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XlbLa+24d7z4d+g/yyhKUubw+AeO55i/OvCA6ERUbPhBREjesU755YrktjNuxeg2z
         HnWD3+7PvxxvInlYNP/qw8w/q8DrkZSXf3kZVfstpF52QgHiQ281rYdaAf/8u9Ls/R
         SMhHcOpcpZofKJs19JDNOsYbE87DJfitmVDBEXOA=
Date:   Mon, 11 Oct 2021 15:51:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 10/13] serial: max310x: Make max310x_remove() return void
Message-ID: <YWRBb9L40AMGI87z@kroah.com>
References: <20211011132754.2479853-1-u.kleine-koenig@pengutronix.de>
 <20211011132754.2479853-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011132754.2479853-11-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Oct 11, 2021 at 03:27:51PM +0200, Uwe Kleine-König wrote:
> Up to now max310x_remove() returns zero unconditionally. Make it return
> void instead which makes it easier to see in the callers that there is
> no error to handle.
> 
> Also the return value of spi remove callbacks is ignored anyway.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/max310x.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 3df0788ddeb0..6816eeb1ffef 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1426,7 +1426,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
>  	return ret;
>  }
>  
> -static int max310x_remove(struct device *dev)
> +static void max310x_remove(struct device *dev)
>  {
>  	struct max310x_port *s = dev_get_drvdata(dev);
>  	int i;
> @@ -1441,8 +1441,6 @@ static int max310x_remove(struct device *dev)
>  	}
>  
>  	clk_disable_unprepare(s->clk);
> -
> -	return 0;
>  }
>  
>  static const struct of_device_id __maybe_unused max310x_dt_ids[] = {
> @@ -1491,7 +1489,8 @@ static int max310x_spi_probe(struct spi_device *spi)
>  
>  static int max310x_spi_remove(struct spi_device *spi)
>  {
> -	return max310x_remove(&spi->dev);
> +	max310x_remove(&spi->dev);
> +	return 0

Does this compile?

