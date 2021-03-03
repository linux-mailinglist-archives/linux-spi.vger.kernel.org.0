Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A163932C6D7
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 02:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346714AbhCDAaJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Mar 2021 19:30:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381983AbhCCHTA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Mar 2021 02:19:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC46864E0C;
        Wed,  3 Mar 2021 07:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614755899;
        bh=oibBBAUG0mkc/tNAJlnnhJitnQ/NskrsB1wpjPpIDmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qN4NSDcWgLOTmDGj/nCGBQU2XDKeToFVV/kLxVv7kgL7dcHh1GgZm8a7B/YJ5bOo3
         AaV7R5CBFILuHM5J+qrQY12Ixf0hmiDuwXAWFIexJFWhxp0CfZ06D3KdnT0IWBuTPF
         XxpvekYWQJZegA8UbghNxhYLzYCNmNPwANqMRI3s=
Date:   Wed, 3 Mar 2021 08:18:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "luhua . xu" <luhua.xu@mediatek.com>,
        Wei Yongjun <weiyj.lk@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Axel Lin <axel.lin@ingics.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        fparent@baylibre.com
Subject: Re: [PATCH] spi: mediatek: Re-license MTK SPI driver as Dual MIT/GPL
Message-ID: <YD84OKr4vNwA7vnz@kroah.com>
References: <20210303025636.795-1-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303025636.795-1-leilk.liu@mediatek.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Mar 03, 2021 at 10:56:36AM +0800, Leilk Liu wrote:
> From: "leilk.liu" <leilk.liu@mediatek.com>
> 
> It is wanted to use MTK spi bus driver with GPL-2.0 or MIT license.
> But now it is only licensed as GPL-2.0, so re-license it as dual
> MIT/GPL.
> 
> Signed-off-by: leilk.liu <leilk.liu@mediatek.com>

Please use your name here, not an email alias for where your name goes.


> ---
>  drivers/spi/spi-mt65xx.c                 | 4 ++--
>  include/linux/platform_data/spi-mt65xx.h | 2 +-

Given that these files have been licensed under the GPL only since 2015,
all changes contributed to it have only been licensed under the GPL as
well, so have you gotten approval for all of the contributors for this
change?

Can you please get your lawyer to also sign off on this license change
patch, so that we know that you have their approval for this incase
there are questions about it in the future?

thanks,

greg k-h
