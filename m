Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9390A41A6C0
	for <lists+linux-spi@lfdr.de>; Tue, 28 Sep 2021 06:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhI1ErF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Sep 2021 00:47:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60682 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbhI1ErE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Sep 2021 00:47:04 -0400
Received: from [IPv6:2003:cb:8708:6596:1837:e564:ef50:8d67] (p200300cb870865961837e564ef508d67.dip0.t-ipconnect.de [IPv6:2003:cb:8708:6596:1837:e564:ef50:8d67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EA17F1F41CB0;
        Tue, 28 Sep 2021 05:45:23 +0100 (BST)
Subject: Re: [PATCH v3 2/2] spi: modify set_cs_timing parameter
To:     Mason Zhang <Mason.Zhang@mediatek.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>
References: <20210804133746.6742-1-Mason.Zhang@mediatek.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <e5691349-60df-935f-1a1a-02eef0568c05@collabora.com>
Date:   Tue, 28 Sep 2021 06:45:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210804133746.6742-1-Mason.Zhang@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 04.08.21 15:37, Mason Zhang wrote:
> This patch modified set_cs_timing parameter, no need pass in spi_delay
> to set_cs_timing callback.
> By the way, we modified the mediatek and tegra114 spi driver to fix build err.
> In mediatek spi driver, We have support set absolute time not clk_count,
> and call this function in prepare_message not user's API.
> 


Hi,
that patch cause a regression on mt8173 elm device, it produces the errors:

cros-ec-i2c-tunnel 1100a000.spi:ec@0:i2c-tunnel0: Error transferring EC i2c message -71
cros-ec-spi spi0.0: EC failed to respond in time.

Could you please write on which mediatek platform it was tested and why is it needed?


> Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
> ---
>   drivers/spi/spi-mt65xx.c   | 107 +++++++++++++++++++++----------------
>   drivers/spi/spi-tegra114.c |   8 +--
>   include/linux/spi/spi.h    |   3 +-
>   3 files changed, 66 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 6f2925118b98..bb09592bc009 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -208,6 +208,65 @@ static void mtk_spi_reset(struct mtk_spi *mdata)
>   	writel(reg_val, mdata->base + SPI_CMD_REG);
>   }
>   
> +static int mtk_spi_set_hw_cs_timing(struct spi_device *spi)
> +{
> +	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
> +	struct spi_delay *cs_setup = &spi->cs_setup;
> +	struct spi_delay *cs_hold = &spi->cs_hold;
> +	struct spi_delay *cs_inactive = &spi->cs_inactive;

I don't see where those 3 values are ever set


Thanks,
Dafna

> +	u16 setup, hold, inactive;
> +	u32 reg_val;
> +	int delay;
> +
> +	delay = spi_delay_to_ns(cs_setup, NULL);
> +	if (delay < 0)
> +		return delay;
> +	setup = (delay * DIV_ROUND_UP(mdata->spi_clk_hz, 1000000)) / 1000;
> +
> +	delay = spi_delay_to_ns(cs_hold, NULL);
> +	if (delay < 0)
> +		return delay;
> +	hold = (delay * DIV_ROUND_UP(mdata->spi_clk_hz, 1000000)) / 1000;
> +
> +	delay = spi_delay_to_ns(cs_inactive, NULL);
> +	if (delay < 0)
> +		return delay;
> +	inactive = (delay * DIV_ROUND_UP(mdata->spi_clk_hz, 1000000)) / 1000;
> +
> +	setup    = setup ? setup : 1;
> +	hold     = hold ? hold : 1;
> +	inactive = inactive ? inactive : 1;
> +
> +	reg_val = readl(mdata->base + SPI_CFG0_REG);
> +	if (mdata->dev_comp->enhance_timing) {
> +		hold = min(hold, 0xffff);
> +		setup = min(setup, 0xffff);
> +		reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
> +		reg_val |= (((hold - 1) & 0xffff)
> +			   << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
> +		reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
> +		reg_val |= (((setup - 1) & 0xffff)
> +			   << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
> +	} else {
> +		hold = min(hold, 0xff);
> +		setup = min(setup, 0xff);
> +		reg_val &= ~(0xff << SPI_CFG0_CS_HOLD_OFFSET);
> +		reg_val |= (((hold - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
> +		reg_val &= ~(0xff << SPI_CFG0_CS_SETUP_OFFSET);
> +		reg_val |= (((setup - 1) & 0xff)
> +			    << SPI_CFG0_CS_SETUP_OFFSET);
> +	}
> +	writel(reg_val, mdata->base + SPI_CFG0_REG);
> +
> +	inactive = min(inactive, 0xff);
> +	reg_val = readl(mdata->base + SPI_CFG1_REG);
> +	reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
> +	reg_val |= (((inactive - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
> +	writel(reg_val, mdata->base + SPI_CFG1_REG);
> +
> +	return 0;
> +}
> +
>   static int mtk_spi_prepare_message(struct spi_master *master,
>   				   struct spi_message *msg)
>   {
> @@ -284,6 +343,8 @@ static int mtk_spi_prepare_message(struct spi_master *master,
>   		<< SPI_CFG1_GET_TICK_DLY_OFFSET);
>   	writel(reg_val, mdata->base + SPI_CFG1_REG);
>   
> +	/* set hw cs timing */
> +	mtk_spi_set_hw_cs_timing(spi);
>   	return 0;
>   }
>   
> @@ -528,52 +589,6 @@ static bool mtk_spi_can_dma(struct spi_master *master,
>   		(unsigned long)xfer->rx_buf % 4 == 0);
>   }
>   
> -static int mtk_spi_set_hw_cs_timing(struct spi_device *spi,
> -				    struct spi_delay *setup,
> -				    struct spi_delay *hold,
> -				    struct spi_delay *inactive)
> -{
> -	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
> -	u16 setup_dly, hold_dly, inactive_dly;
> -	u32 reg_val;
> -
> -	if ((setup && setup->unit != SPI_DELAY_UNIT_SCK) ||
> -	    (hold && hold->unit != SPI_DELAY_UNIT_SCK) ||
> -	    (inactive && inactive->unit != SPI_DELAY_UNIT_SCK)) {
> -		dev_err(&spi->dev,
> -			"Invalid delay unit, should be SPI_DELAY_UNIT_SCK\n");
> -		return -EINVAL;
> -	}
> -
> -	setup_dly = setup ? setup->value : 1;
> -	hold_dly = hold ? hold->value : 1;
> -	inactive_dly = inactive ? inactive->value : 1;
> -
> -	reg_val = readl(mdata->base + SPI_CFG0_REG);
> -	if (mdata->dev_comp->enhance_timing) {
> -		reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
> -		reg_val |= (((hold_dly - 1) & 0xffff)
> -			   << SPI_ADJUST_CFG0_CS_HOLD_OFFSET);
> -		reg_val &= ~(0xffff << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
> -		reg_val |= (((setup_dly - 1) & 0xffff)
> -			   << SPI_ADJUST_CFG0_CS_SETUP_OFFSET);
> -	} else {
> -		reg_val &= ~(0xff << SPI_CFG0_CS_HOLD_OFFSET);
> -		reg_val |= (((hold_dly - 1) & 0xff) << SPI_CFG0_CS_HOLD_OFFSET);
> -		reg_val &= ~(0xff << SPI_CFG0_CS_SETUP_OFFSET);
> -		reg_val |= (((setup_dly - 1) & 0xff)
> -			    << SPI_CFG0_CS_SETUP_OFFSET);
> -	}
> -	writel(reg_val, mdata->base + SPI_CFG0_REG);
> -
> -	reg_val = readl(mdata->base + SPI_CFG1_REG);
> -	reg_val &= ~SPI_CFG1_CS_IDLE_MASK;
> -	reg_val |= (((inactive_dly - 1) & 0xff) << SPI_CFG1_CS_IDLE_OFFSET);
> -	writel(reg_val, mdata->base + SPI_CFG1_REG);
> -
> -	return 0;
> -}
> -
>   static int mtk_spi_setup(struct spi_device *spi)
>   {
>   	struct mtk_spi *mdata = spi_master_get_devdata(spi->master);
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index 5131141bbf0d..e9de1d958bbd 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -717,12 +717,12 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
>   	dma_release_channel(dma_chan);
>   }
>   
> -static int tegra_spi_set_hw_cs_timing(struct spi_device *spi,
> -				      struct spi_delay *setup,
> -				      struct spi_delay *hold,
> -				      struct spi_delay *inactive)
> +static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
>   {
>   	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
> +	struct spi_delay *setup = &spi->cs_setup;
> +	struct spi_delay *hold = &spi->cs_hold;
> +	struct spi_delay *inactive = &spi->cs_inactive;
>   	u8 setup_dly, hold_dly, inactive_dly;
>   	u32 setup_hold;
>   	u32 spi_cs_timing;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 651e19ba3415..fe027efb85c2 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -553,8 +553,7 @@ struct spi_controller {
>   	 * to configure specific CS timing through spi_set_cs_timing() after
>   	 * spi_setup().
>   	 */
> -	int (*set_cs_timing)(struct spi_device *spi, struct spi_delay *setup,
> -			     struct spi_delay *hold, struct spi_delay *inactive);
> +	int (*set_cs_timing)(struct spi_device *spi);
>   
>   	/* bidirectional bulk transfers
>   	 *
> 
