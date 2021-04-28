Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9743436D03D
	for <lists+linux-spi@lfdr.de>; Wed, 28 Apr 2021 03:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhD1BX0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 21:23:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:1118 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhD1BX0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Apr 2021 21:23:26 -0400
IronPort-SDR: TJSgNjW95VOrT+TjB6iXhwUlrCK0RgPtnWFUe7R5zR/GlAlUVMgPkZuGA9IWMsQBd36w2i9A5x
 4MH7OXmSTGIA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="184109759"
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="184109759"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 18:22:41 -0700
IronPort-SDR: zqdYmHv53wWaS4cLF4xLmDdGSFN+iJOUiLqqKppY13IYinUgGhvxOVOvwd4uHtmoPF5ldosiJ0
 DmMdjunzmDIA==
X-IronPort-AV: E=Sophos;i="5.82,256,1613462400"; 
   d="scan'208";a="423299558"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 18:22:41 -0700
Date:   Tue, 27 Apr 2021 18:24:05 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Geert Uytterhoeven <geert+renesas@glider.be>
cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: altera: Make SPI_ALTERA_CORE invisible
In-Reply-To: <f0cb8e66baba4506db6f42fca74dc51b76883507.1619534253.git.geert+renesas@glider.be>
Message-ID: <alpine.DEB.2.22.394.2104271823010.1678102@rhweight-WRK1>
References: <f0cb8e66baba4506db6f42fca74dc51b76883507.1619534253.git.geert+renesas@glider.be>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Geert,

Thanks for the fix!

Matthew

Acked-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>

On Tue, 27 Apr 2021, Geert Uytterhoeven wrote:

> The SPI_ALTERA_CORE config symbol controls compilation of the Altera SPI
> Controller core code.  It is already selected by all of its users, so
> there is no reason to make it visible, unless compile-testing.
>
> Fixes: b0c3d9354de1f87e ("spi: altera: separate core code from platform code")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> drivers/spi/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 7f03d1e50361ea94..17a55214e66ad928 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -65,7 +65,7 @@ config SPI_ALTERA
> 	  This is the driver for the Altera SPI Controller.
>
> config SPI_ALTERA_CORE
> -	tristate "Altera SPI Controller core code"
> +	tristate "Altera SPI Controller core code" if COMPILE_TEST
> 	select REGMAP
> 	help
> 	  "The core code for the Altera SPI Controller"
> -- 
> 2.25.1
>
>
