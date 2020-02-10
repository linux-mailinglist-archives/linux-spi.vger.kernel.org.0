Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7A89157D93
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2020 15:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgBJOmI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Feb 2020 09:42:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:18244 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgBJOmH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 Feb 2020 09:42:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 06:42:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="226213719"
Received: from ykatsuma-mobl1.gar.corp.intel.com (HELO [10.251.140.95]) ([10.251.140.95])
  by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2020 06:42:06 -0800
Subject: Re: [alsa-devel] [PATCH] spi: pxa2xx: Enable support for
 compile-testing
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-spi@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200210093027.6672-1-geert@linux-m68k.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <abf31c4f-638c-0732-6dc3-957a903e8d56@linux.intel.com>
Date:   Mon, 10 Feb 2020 08:21:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210093027.6672-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2/10/20 3:30 AM, Geert Uytterhoeven wrote:
> m68k/allmodconfig:
> 
>      WARNING: unmet direct dependencies detected for SPI_PXA2XX
>        Depends on [n]: SPI [=y] && SPI_MASTER [=y] && (ARCH_PXA || ARCH_MMP || PCI [=n] || ACPI)
>        Selected by [m]:
>        - SND_SOC_INTEL_BDW_RT5677_MACH [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && SND_SOC_INTEL_MACH [=y] && (SND_SOC_INTEL_HASWELL [=n] || SND_SOC_SOF_BROADWELL [=m]) && I2C [=m] && (I2C_DESIGNWARE_PLATFORM [=m] || COMPILE_TEST [=y]) && (GPIOLIB [=y] || COMPILE_TEST [=y]) && (X86_INTEL_LPSS || COMPILE_TEST [=y]) && SPI_MASTER [=y]
> 
> This happens because SND_SOC_INTEL_BDW_RT5677_MACH selects SPI_PXA2XX,
> and the former depends on COMPILE_TEST, while the latter does not.
> 
> Fix this by enabling compile-testing for SPI_PXA2XX.
> 
> Fixes: 630db1549356f644 ("ASoC: Intel: bdw-rt5677: fix Kconfig dependencies")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Makes sense.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   drivers/spi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ee96708aa3a77156..2e1c3a575f7a6cc3 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -557,7 +557,7 @@ config SPI_PPC4xx
>   
>   config SPI_PXA2XX
>   	tristate "PXA2xx SSP SPI master"
> -	depends on (ARCH_PXA || ARCH_MMP || PCI || ACPI)
> +	depends on ARCH_PXA || ARCH_MMP || PCI || ACPI || COMPILE_TEST
>   	select PXA_SSP if ARCH_PXA || ARCH_MMP
>   	help
>   	  This enables using a PXA2xx or Sodaville SSP port as a SPI master
> 
