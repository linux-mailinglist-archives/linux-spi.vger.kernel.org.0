Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ECF3C6EA2
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 12:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhGMKhe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 06:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbhGMKhX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 06:37:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB0EC0613DD
        for <linux-spi@vger.kernel.org>; Tue, 13 Jul 2021 03:34:33 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m3Fk1-0001hZ-OH; Tue, 13 Jul 2021 12:34:17 +0200
Message-ID: <b3e94d1dfe77ec53686ed0be04a17b33c3fc37fa.camel@pengutronix.de>
Subject: Re: [PATCH v15 05/12] dmaengine: dma: imx-sdma: add fw_loaded and
 is_ram_script
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>, vkoul@kernel.org,
        mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 13 Jul 2021 12:34:13 +0200
In-Reply-To: <1626201709-19643-6-git-send-email-yibin.gong@nxp.com>
References: <1626201709-19643-1-git-send-email-yibin.gong@nxp.com>
         <1626201709-19643-6-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am Mittwoch, dem 14.07.2021 um 02:41 +0800 schrieb Robin Gong:
> Add 'fw_loaded' and 'is_ram_script' to check if the script used by channel
> is ram script and it's loaded or not, so that could prevent meaningless
> following malloc dma descriptor and bd allocate in sdma_transfer_init(),
> otherwise memory may be consumed out potentially without free in case
> that spi fallback into pio while dma transfer failed by sdma firmware not
> ready(next ERR009165 patch depends on sdma RAM scripts/firmware).
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/imx-sdma.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 665ccbf..639a783 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -435,6 +435,7 @@ struct sdma_channel {
>  	enum dma_status			status;
>  	struct imx_dma_data		data;
>  	struct work_struct		terminate_worker;
> +	bool				is_ram_script;
>  };
>  
>  #define IMX_DMA_SG_LOOP		BIT(0)
> @@ -498,6 +499,7 @@ struct sdma_engine {
>  	struct sdma_buffer_descriptor	*bd0;
>  	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
>  	bool				clk_ratio;
> +	bool                            fw_loaded;
>  };
>  
>  static int sdma_config_write(struct dma_chan *chan,
> @@ -953,6 +955,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
>  	case IMX_DMATYPE_SSI_DUAL:
>  		per_2_emi = sdma->script_addrs->ssish_2_mcu_addr;
>  		emi_2_per = sdma->script_addrs->mcu_2_ssish_addr;
> +		sdmac->is_ram_script = true;
>  		break;
>  	case IMX_DMATYPE_SSI_SP:
>  	case IMX_DMATYPE_MMC:
> @@ -967,6 +970,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
>  		per_2_emi = sdma->script_addrs->asrc_2_mcu_addr;
>  		emi_2_per = sdma->script_addrs->asrc_2_mcu_addr;
>  		per_2_per = sdma->script_addrs->per_2_per_addr;
> +		sdmac->is_ram_script = true;
>  		break;
>  	case IMX_DMATYPE_ASRC_SP:
>  		per_2_emi = sdma->script_addrs->shp_2_mcu_addr;
> @@ -1363,6 +1367,11 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
>  {
>  	struct sdma_desc *desc;
>  
> +	if (!sdmac->sdma->fw_loaded && sdmac->is_ram_script) {
> +		dev_warn_once(sdmac->sdma->dev, "sdma firmware not ready!\n");
> +		goto err_out;
> +	}
> +
>  	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
>  	if (!desc)
>  		goto err_out;
> @@ -1613,6 +1622,8 @@ static int sdma_config_write(struct dma_chan *chan,
>  {
>  	struct sdma_channel *sdmac = to_sdma_chan(chan);
>  
> +	sdmac->is_ram_script = false;
> +
Again, I think this initialization should move into sdma_get_pc() to
move it into close proximity of the code where it gets overwritten to
true. This would make this flow of events much easier to see when
reading the driver code.

Regards,
Lucas

>  	if (direction == DMA_DEV_TO_MEM) {
>  		sdmac->per_address = dmaengine_cfg->src_addr;
>  		sdmac->watermark_level = dmaengine_cfg->src_maxburst *
> @@ -1792,6 +1803,8 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
>  
>  	sdma_add_scripts(sdma, addr);
>  
> +	sdma->fw_loaded = true;
> +
>  	dev_info(sdma->dev, "loaded firmware %d.%d\n",
>  			header->version_major,
>  			header->version_minor);


