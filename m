Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5064C39BBD1
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jun 2021 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhFDP2w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Jun 2021 11:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFDP2w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Jun 2021 11:28:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E65C061766;
        Fri,  4 Jun 2021 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=zEOGLELAotxFe8keo94CwRJObWeO1jWMUHLzFzUPC9M=; b=HMC8aAzvTE/km1vWl6Zjsq0InJ
        jjLCXFaub81w1mHxlV8xDcIyCKZ3fWHxxoi4AGBzWyoFCZC7jtfwCxmqD+YS+vQahLDUjlozxZAo4
        6hg6Pd1Xz33i5ItCw1MNd/ea13C3lAjx+B84J/cU6z+5VjbCZoAjKQK9FkwWp/yoQxoZGzypWBltX
        lLX5GZopgODrLSciIRA00zYep2ww9jzuz7dHOrm4bDdDO1Q8TYvMhP7s/vJrpX2RB+VJJrlIM8K/D
        SJ+PZLjGv3E5yW5xqP00GPqaN316Yo/yobY7dojtFhAW1zUA496lBsYTYUMAswFFGpixVwn/OFgW/
        wE5UAdpw==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpBix-00E9tx-Lo; Fri, 04 Jun 2021 15:27:03 +0000
Subject: Re: [PATCH] spi: stm32-qspi: Fix W=1 build warning
To:     patrice.chotard@foss.st.com, Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com
References: <20210604075009.25914-1-patrice.chotard@foss.st.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <49902b8a-c16a-423a-d528-3d35cac402bc@infradead.org>
Date:   Fri, 4 Jun 2021 08:27:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210604075009.25914-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 6/4/21 12:50 AM, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Fix the following compilation warning using W=1 build:
> arm-linux-gnueabi-ld: drivers/spi/spi-stm32-qspi.o: in function `stm32_qspi_poll_status':
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

This is a build error, not a warning. The complete message is:

ld: drivers/spi/spi-stm32-qspi.o: in function `stm32_qspi_poll_status':
spi-stm32-qspi.c:(.text+0x661): undefined reference to `spi_mem_supports_op'


Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


thanks.

> ---
>  drivers/spi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index f4481fe48bf0..e71a4c514f7b 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -806,6 +806,7 @@ config SPI_STM32_QSPI
>  	tristate "STMicroelectronics STM32 QUAD SPI controller"
>  	depends on ARCH_STM32 || COMPILE_TEST
>  	depends on OF
> +	depends on SPI_MEM
>  	help
>  	  This enables support for the Quad SPI controller in master mode.
>  	  This driver does not support generic SPI. The implementation only
> 


-- 
~Randy

