Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0919567CAF
	for <lists+linux-spi@lfdr.de>; Wed,  6 Jul 2022 05:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiGFDqC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Jul 2022 23:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiGFDpX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Jul 2022 23:45:23 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0CB1EAE7
        for <linux-spi@vger.kernel.org>; Tue,  5 Jul 2022 20:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657079120; x=1688615120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ge/ABfXnrM5/z7n6G4b0DuoSM+BhI8eaEOtVOhmsYv4=;
  b=GQk9QqjV4w1h6fjLakigNcL7mXmj1ioIe7ywjInFTtlCtwZ1Vj1WWa5o
   24xINSlre1AOO9M0nnSER4LUfEvTj7mQHuX/oBSkSak3G17ka+MjMqroL
   0FjkofGTo/lxgRNrlp/csYg1BYhbfICJMPgi/+ezZ5cWuwpGy469FA2Rd
   7gd2pCWzXsGyFbHUM4pDajRNokZmX1ek+hq2rNJgsHT4xUQlqyDn/VWrW
   nwv1kmIYjIHESwTAHveonH87ySDsuyAwdPqeTGM9jLffN/6xnf0HGqe7e
   vLtNZKbgd42wMwZB6NFKxk7qpOG7lziZCEQivlLLcvZjrF7vjxzKbtAzu
   w==;
X-IronPort-AV: E=Sophos;i="5.92,248,1650902400"; 
   d="scan'208";a="204942402"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2022 11:45:18 +0800
IronPort-SDR: 9QBo4LMHXHspy+UjWYwfMKYWUnNb8Oq7/OfISuE5SeTaC9k5LnggJHXar79dN/qjucRycuC2cX
 Wak44NJkRm+5GYSYgPVd596mxJO1TH+aiBTOzsrklbKLMU7JIbX1YlGjYPz9zOTWxSktuBkvdE
 MIfiBK9VdcTsB4TozbncUPfFgaQZiwEPhKeDSCCanGCWiGnQVTAo6BusYPLzY4QN/VigBDjd+q
 tTNabGRuls1d27odzyJCewnNfcQlS326gLOPvc495/GqWMnsSrv6aITv/4WDohpIPmZ8o0kT1u
 z5hzZicxYVHbUzWy3iSIwskM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jul 2022 20:02:37 -0700
IronPort-SDR: dAl0xWX4sX1EeSBfiyPQPDJXiRs/1GJsV3fOzLDq3XZ1ehlp0CzIJzL11GUszlYpwzdzvVkYmn
 J4JDOhbS7tusnJO7b9TTLZQKRLncdzO5khY/7gbJumA+ycMfYf3g+RNWvgLTYIr7GLeHLxsf5v
 lbDVkx65nPsv+AQppJbkV73XNqIJU1F65I+be8m6dXOX8DI5aUhxSwk+z/mCWY0SoLMSTu7UpA
 SFM11WmB3tPqgr5UqpkpI1hxpAAF3O7TZZhTOSAi2ANlrashW9jh2fJVLM9i8uxVRCreCembIc
 nSY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jul 2022 20:45:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Ld5656sKvz1Rwnx
        for <linux-spi@vger.kernel.org>; Tue,  5 Jul 2022 20:45:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1657079116; x=1659671117; bh=ge/ABfXnrM5/z7n6G4b0DuoSM+BhI8eaEOt
        VOhmsYv4=; b=WB3cjMwZsUuggq2VYtBWujX/fQJNZdojEJCcfq0XptimZZkxpq3
        tRok4ex2PrIlFXn0xGP+9IALyTaNOsU5S5ydhHQbnHBViWX1BK6jJUOXe+cQcjUS
        OH008kUbbhMRUl2BWy09jcE4Y6OPkXhfcaEvZ1HasNQG6cx7tjHYea80POfbYPQt
        8qC3l9ncwG7wUbwb8yPihZGe1Yw6FBe7ntxEQ/7L6U2NDT2ogl+ug7DSdfckO+RW
        m1LyNt4ecGAOh32P0rOqeQpKibogozgm+iENNShvTMWfo9UTqvtlTv8dbVEiq/7o
        ULf7TJY7YwuLurg3JatsC2Yc+8bB7HJGaRw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c8rMZav8BR8I for <linux-spi@vger.kernel.org>;
        Tue,  5 Jul 2022 20:45:16 -0700 (PDT)
Received: from [10.225.163.110] (unknown [10.225.163.110])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Ld55s01rTz1RtVk;
        Tue,  5 Jul 2022 20:45:04 -0700 (PDT)
Message-ID: <50b65a2b-49fb-41d9-d68c-af1d908ba5db@opensource.wdc.com>
Date:   Wed, 6 Jul 2022 12:45:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/9] arm: bcmbca: Replace ARCH_BCM_63XX with ARCH_BCMBCA
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, kursad.oney@broadcom.com,
        f.fainelli@gmail.com, anand.gore@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        philippe.reynes@softathome.com, dan.beygelman@broadcom.com,
        Al Cooper <alcooperx@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Conor Dooley <conor.dooley@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jan Dabros <jsd@semihalf.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Jie Deng <jie.deng@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sunil Goutham <sgoutham@marvell.com>,
        Sven Peter <sven@svenpeter.dev>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Tyrone Ting <kfting@nuvoton.com>,
        Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
References: <20220705172613.21152-1-william.zhang@broadcom.com>
 <20220705172613.21152-6-william.zhang@broadcom.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220705172613.21152-6-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 7/6/22 02:26, William Zhang wrote:
> Update ARCH_BCM_63XX in all sources to use ARCHB_BCMBCA instead.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

For the ata Kconfig change:

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


> ---
> 
>  arch/arm/Kconfig.debug         | 2 +-
>  drivers/ata/Kconfig            | 2 +-
>  drivers/char/hw_random/Kconfig | 2 +-
>  drivers/clk/bcm/Kconfig        | 4 ++--
>  drivers/i2c/busses/Kconfig     | 2 +-
>  drivers/phy/broadcom/Kconfig   | 2 +-
>  drivers/spi/Kconfig            | 2 +-
>  drivers/tty/serial/Kconfig     | 4 ++--
>  8 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 9b0aa4822d69..792796a348c3 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -271,7 +271,7 @@ choice
>  
>  	config DEBUG_BCM63XX_UART
>  		bool "Kernel low-level debugging on BCM63XX UART"
> -		depends on ARCH_BCM_63XX
> +		depends on ARCH_BCMBCA
>  
>  	config DEBUG_BERLIN_UART
>  		bool "Marvell Berlin SoC Debug UART"
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index bb45a9c00514..1c9f4fb2595d 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -148,7 +148,7 @@ config SATA_AHCI_PLATFORM
>  config AHCI_BRCM
>  	tristate "Broadcom AHCI SATA support"
>  	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP || \
> -		   ARCH_BCM_63XX || COMPILE_TEST
> +		   ARCH_BCMBCA || COMPILE_TEST
>  	select SATA_HOST
>  	help
>  	  This option enables support for the AHCI SATA3 controller found on
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index b3f2d55dc551..3da8e85f8aae 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -87,7 +87,7 @@ config HW_RANDOM_BA431
>  config HW_RANDOM_BCM2835
>  	tristate "Broadcom BCM2835/BCM63xx Random Number Generator support"
>  	depends on ARCH_BCM2835 || ARCH_BCM_NSP || ARCH_BCM_5301X || \
> -		   ARCH_BCM_63XX || BCM63XX || BMIPS_GENERIC || COMPILE_TEST
> +		   ARCH_BCMBCA || BCM63XX || BMIPS_GENERIC || COMPILE_TEST
>  	default HW_RANDOM
>  	help
>  	  This driver provides kernel-side support for the Random Number
> diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
> index ec738f74a026..77266afb1c79 100644
> --- a/drivers/clk/bcm/Kconfig
> +++ b/drivers/clk/bcm/Kconfig
> @@ -22,9 +22,9 @@ config CLK_BCM2835
>  
>  config CLK_BCM_63XX
>  	bool "Broadcom BCM63xx clock support"
> -	depends on ARCH_BCM_63XX || COMPILE_TEST
> +	depends on ARCH_BCMBCA || COMPILE_TEST
>  	select COMMON_CLK_IPROC
> -	default ARCH_BCM_63XX
> +	default ARCH_BCMBCA
>  	help
>  	  Enable common clock framework support for Broadcom BCM63xx DSL SoCs
>  	  based on the ARM architecture
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index b1d7069dd377..acf2a393bd56 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -486,7 +486,7 @@ config I2C_BCM_KONA
>  
>  config I2C_BRCMSTB
>  	tristate "BRCM Settop/DSL I2C controller"
> -	depends on ARCH_BCM2835 || ARCH_BCM4908 || ARCH_BCM_63XX || \
> +	depends on ARCH_BCM2835 || ARCH_BCM4908 || ARCH_BCMBCA || \
>  		   ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>  	default y
>  	help
> diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
> index 849c4204f550..93a6a8ee4716 100644
> --- a/drivers/phy/broadcom/Kconfig
> +++ b/drivers/phy/broadcom/Kconfig
> @@ -83,7 +83,7 @@ config PHY_NS2_USB_DRD
>  config PHY_BRCM_SATA
>  	tristate "Broadcom SATA PHY driver"
>  	depends on ARCH_BRCMSTB || ARCH_BCM_IPROC || BMIPS_GENERIC || \
> -		   ARCH_BCM_63XX || COMPILE_TEST
> +		   ARCH_BCMBCA || COMPILE_TEST
>  	depends on OF
>  	select GENERIC_PHY
>  	default ARCH_BCM_IPROC
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 2d034459e79f..8e550269d488 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -183,7 +183,7 @@ config SPI_BCM63XX
>  
>  config SPI_BCM63XX_HSSPI
>  	tristate "Broadcom BCM63XX HS SPI controller driver"
> -	depends on BCM63XX || BMIPS_GENERIC || ARCH_BCM_63XX || COMPILE_TEST
> +	depends on BCM63XX || BMIPS_GENERIC || ARCH_BCMBCA || COMPILE_TEST
>  	help
>  	  This enables support for the High Speed SPI controller present on
>  	  newer Broadcom BCM63XX SoCs.
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 8a3ee1525d80..e3279544b03c 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1100,8 +1100,8 @@ config SERIAL_TIMBERDALE
>  config SERIAL_BCM63XX
>  	tristate "Broadcom BCM63xx/BCM33xx UART support"
>  	select SERIAL_CORE
> -	depends on ARCH_BCM4908 || ARCH_BCM_63XX || BCM63XX || BMIPS_GENERIC || COMPILE_TEST
> -	default ARCH_BCM4908 || ARCH_BCM_63XX || BCM63XX || BMIPS_GENERIC
> +	depends on ARCH_BCM4908 || ARCH_BCMBCA || BCM63XX || BMIPS_GENERIC || COMPILE_TEST
> +	default ARCH_BCM4908 || ARCH_BCMBCA || BCM63XX || BMIPS_GENERIC
>  	help
>  	  This enables the driver for the onchip UART core found on
>  	  the following chipsets:


-- 
Damien Le Moal
Western Digital Research
