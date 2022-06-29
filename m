Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC4155FCB0
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 11:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiF2J61 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 05:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiF2J60 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 05:58:26 -0400
X-Greylist: delayed 913 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 02:58:25 PDT
Received: from 1.mo576.mail-out.ovh.net (1.mo576.mail-out.ovh.net [178.33.251.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861B1D322
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 02:58:25 -0700 (PDT)
Received: from player786.ha.ovh.net (unknown [10.108.16.164])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4546021270
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 09:43:09 +0000 (UTC)
Received: from etezian.org (bbcs-175-223.cust.wingo.ch [178.238.175.223])
        (Authenticated sender: andi@etezian.org)
        by player786.ha.ovh.net (Postfix) with ESMTPSA id 5A7DD2C05D303;
        Wed, 29 Jun 2022 09:42:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-105G006ecb3de72-25dc-4105-8c80-3e4ff39ffe64,
                    27473AD2557E96BAE247B01472F11916F8881100) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.175.223
Date:   Wed, 29 Jun 2022 12:42:56 +0300
From:   Andi Shyti <andi@etezian.org>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] spi: s3c64xx: support custom value of internal
 clock divider
Message-ID: <YrweoNCL3BjqUNWV@jack.zhora.eu>
References: <20220628044222.152794-1-chanho61.park@samsung.com>
 <CGME20220628044432epcas2p11e6f927321c30cf5557dbd41d749ef28@epcas2p1.samsung.com>
 <20220628044222.152794-3-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628044222.152794-3-chanho61.park@samsung.com>
X-Ovh-Tracer-Id: 2210422993221847576
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudegledgudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughiucfuhhihthhiuceorghnughisegvthgviihirghnrdhorhhgqeenucggtffrrghtthgvrhhnpeejgfelgeekieffjeegveeuvdehgeelveetveejudffvedvleehvdefleehudelueenucfkpheptddrtddrtddrtddpudejkedrvdefkedrudejhedrvddvfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeekiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegrnhguihesvghtvgiiihgrnhdrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeei
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Chanho,

On Tue, Jun 28, 2022 at 01:42:20PM +0900, Chanho Park wrote:
> Modern exynos SoCs such as Exynos Auto v9 has different internal clock

/has/have/

> divider, for example "4". To support this internal value, this adds
> clk_div of the s3c64xx_spi_port_config and assign "2" as the default
> value to existing s3c64xx_spi_port_config.
> 
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index b3c50c7665fc..51a0e830441b 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -131,6 +131,7 @@ struct s3c64xx_spi_dma_data {
>   * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS register.
>   * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
>   * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
> + * @clk_div: Internal clock divider, if not specified, use 2 as the default.

is it default? Is it not specified anywhere? I think you are
assigning '2' to everyone. I would just leave it "Internal
clock divider."

[...]

> @@ -871,6 +873,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>  	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
>  	struct s3c64xx_spi_driver_data *sdd;
>  	int err;
> +	u32 div = 2;

As per Krzystof review.

>  	sdd = spi_master_get_devdata(spi->master);
>  	if (spi->dev.of_node) {
> @@ -889,22 +892,24 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>  
>  	pm_runtime_get_sync(&sdd->pdev->dev);
>  
> +	div = sdd->port_conf->clk_div;

Can you please be consistent with the data type? div is u32, but
clk_div is int.

[...]

Andi
