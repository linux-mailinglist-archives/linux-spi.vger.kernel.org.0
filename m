Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099F93734C9
	for <lists+linux-spi@lfdr.de>; Wed,  5 May 2021 07:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhEEFtg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 May 2021 01:49:36 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:46205 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhEEFtg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 May 2021 01:49:36 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id B2FEC100DA1A0;
        Wed,  5 May 2021 07:48:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7CA8D50D4A; Wed,  5 May 2021 07:48:38 +0200 (CEST)
Date:   Wed, 5 May 2021 07:48:38 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel-team@android.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] spi: Don't have controller clean up spi device before
 driver unbind
Message-ID: <20210505054838.GA22603@wunner.de>
References: <20210505031416.30128-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505031416.30128-1-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 04, 2021 at 08:14:16PM -0700, Saravana Kannan wrote:
> @@ -415,6 +421,7 @@ static int spi_remove(struct device *dev)
>  				 ERR_PTR(ret));
>  	}
>  
> +	spi_cleanup(to_spi_device(dev));
>  	dev_pm_domain_detach(dev, true);
>  
>  	return 0;

Unfortunately this doesn't look right:  spi_remove() is run on
driver unbind of the spi_device.  With the above change,
->setup is called on spi_device addition and ->cleanup is called
on unbind, which is obviously assymetric.  What can happen
here is that a slave-specific controller_state is allocated on
spi_device addition, then on unbind that controller_state is freed
and on a subsequent rebind it won't be recreated because ->setup
isn't run on spi_device ->probe.

As I've written yesterday, calling spi_cleanup() in
spi_unregister_device() should be fine if you move it to the end
of the function, but before the final put_device().  For that,
you need to open code the calls to device_del() and put_device()
that happen in device_unregister() so far.

Thanks,

Lukas
