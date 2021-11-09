Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED9B44B195
	for <lists+linux-spi@lfdr.de>; Tue,  9 Nov 2021 17:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbhKIQ60 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Nov 2021 11:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240354AbhKIQ6Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Nov 2021 11:58:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BA2C061764;
        Tue,  9 Nov 2021 08:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/LP3FeLpReckN2Ti3pmtMSKae4B2ROfz/QTjyFEgT8g=; b=UUbPzHamBevNC7YhZAa/Mt6Xth
        fs7WalY/LpPoaemtx+DheoGFE7fewrGZLsvgyp7Xx9Hwcm8pxpgv0QwGHLLo+ykEeMjOFI43uFHlX
        fHYjcJtFZ5/jFMFhyxQOV/UtZqtGI71sXfSWlVHCRZFKiMbYudxhgYUNblKFvAzD2wG3/A3Y7K0po
        F6qoBbkiv6zYkmyR+iwyHfqgC8z0kV41GpVqGprGXeOz0IEGwvKw9HWojHprSBTI+ykfaMn8BO+5j
        ls0cKgjfPDZQzVL2ipL4BGi6O5svTiVZpOT+Kr424G21/jEqMWDRt+VtCcuxzfrjWYtawwY7gIyPn
        z18v8zqg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by merlin.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkUP3-008oAQ-KD; Tue, 09 Nov 2021 16:55:22 +0000
Subject: Re: [PATCH v2 1/2] SPI: Add SPI driver for Sunplus SP7021
To:     "LH.Kuo" <lhjeff911@gmail.com>, p.zabel@pengutronix.de,
        broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-1-git-send-email-lh.kuo@sunplus.com>
 <1636448488-14158-2-git-send-email-lh.kuo@sunplus.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1b034b0b-d1ac-5bbe-4384-d0be9bd47710@infradead.org>
Date:   Tue, 9 Nov 2021 08:55:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1636448488-14158-2-git-send-email-lh.kuo@sunplus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11/9/21 1:01 AM, LH.Kuo wrote:
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 596705d..30ce0ed 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -866,6 +866,17 @@ config SPI_SUN6I
>   	help
>   	  This enables using the SPI controller on the Allwinner A31 SoCs.
>   
> +config SPI_SUNPLUS_SP7021
> +	tristate "Sunplus SP7021 SPI controller"
> +	depends on SOC_SP7021
> +	help
> +	  This enable Sunplus SP7021 spi controller driver on the SP7021 SoCs.

	       enables the Sunplus SP021 SPI

> +	  This driver can also be built as a module. If so, the module will be
> +	  called as spi-sunplus-sp7021.
> +
> +	  If you have a  Sunplus SP7021 platform say Y here.

	         have a Sunplus
(i.e., drop one space)

> +	  If unsure, say N.


-- 
~Randy
