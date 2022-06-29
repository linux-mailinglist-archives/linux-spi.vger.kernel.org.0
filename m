Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886BB55FBE0
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 11:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiF2J1F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 05:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiF2J1E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 05:27:04 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03BE38D9A
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 02:27:00 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220629092655epoutp036190c47dd84f2cdc08f6f8f720f09930~9DUIWPlAH0812608126epoutp03I
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 09:26:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220629092655epoutp036190c47dd84f2cdc08f6f8f720f09930~9DUIWPlAH0812608126epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656494815;
        bh=eFoynbtp5zQ4RqUvE/6e2kJcFhCAJ3vcUwMB/64AeFU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Ap5mOIrm9Qi/aUj5F8cIDW6wKaJkw0EV4hPpmv5S3cu07xa2w8Qy458jM0HXMJ/gJ
         RmqCzHDw1pvixPzFHmGRhhVcKOGFhowCimnFl8uySGSgRznNV7F44gBLe3ReElhmAp
         4zoUEXnRfsnaMIW8etQCFgoVylg8ToJPUJ3FCPOQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220629092654epcas2p1b485607b70aff328da403406da53ff8c~9DUHrY7Wi0873208732epcas2p18;
        Wed, 29 Jun 2022 09:26:54 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.99]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LXx1V2pD0z4x9Pq; Wed, 29 Jun
        2022 09:26:54 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        FF.38.09666.EDA1CB26; Wed, 29 Jun 2022 18:26:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220629092653epcas2p3d8090c552998591944ad9a215f0936c2~9DUGs5P-o1907319073epcas2p3o;
        Wed, 29 Jun 2022 09:26:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220629092653epsmtrp1a9cec49bce3ca0fb5cb4a63805dd3a37~9DUGr-zy20156801568epsmtrp1e;
        Wed, 29 Jun 2022 09:26:53 +0000 (GMT)
X-AuditID: b6c32a45-45bff700000025c2-f4-62bc1adeba22
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.42.08905.DDA1CB26; Wed, 29 Jun 2022 18:26:53 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220629092653epsmtip16d06c48d4a473488e40e0c294ce393fb~9DUGgVcvm2512325123epsmtip1L;
        Wed, 29 Jun 2022 09:26:53 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Andi Shyti'" <andi@etezian.org>,
        "'Mark Brown'" <broonie@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>
Cc:     "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <da86b25a-097d-63fe-083a-5600b72b0bdb@linaro.org>
Subject: RE: [PATCH v2 2/4] spi: s3c64xx: support custom value of internal
 clock divider
Date:   Wed, 29 Jun 2022 18:26:53 +0900
Message-ID: <025401d88b9a$5e94bca0$1bbe35e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHQezgfaORozkaflreY0gl9GrbVUwIO7M/nAkDRpz4CZcCB8a1Akd7g
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmue49qT1JBh+mCFs8mLeNzWLxj+dM
        FlMfPmGzmH/kHKtF34uHzBZ7X29lt9j0+BqrxYzz+5gsGj/eZLdo3XuE3YHL4/qST8wem1Z1
        snncubaHzWPzknqPvi2rGD0+b5ILYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0
        tDBXUshLzE21VXLxCdB1y8wBukxJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2Be
        oFecmFtcmpeul5daYmVoYGBkClSYkJ3Rcfssa8EZ8YpZ/VsZGxivCXUxcnJICJhInF94m6mL
        kYtDSGAHo8TTD9PZIJxPjBJHNrxkgXC+MUos+HSSHablwpJrUIm9jBL/XlyF6n/BKNF8ch4b
        SBWbgL7Ey45trCAJEYG3jBJndp8Aa2cW2Mko0TAvBsTmFLCT+PD5JROILSwQJbH74Xswm0VA
        VWLivO8sIDavgKVE+7ZlzBC2oMTJmU9YIObIS2x/O4cZ4iQFiZ9Pl7FCxEUkZne2gcVFBNwk
        GpvPs0DU7OCQ+LDetouRA8h2kTh6zBQiLCzx6vgWqM+kJF72t0HZxRJLZ30Ce0xCoIFR4vK2
        X2wQCWOJWc/aGUHmMAtoSqzfpQ8xUlniyC2oy/gkOg7/ZYcI80p0tEGDWl3iwPbpUMfISnTP
        +cw6gVFpFpK/ZiH5axaSX2Yh7FrAyLKKUSy1oDg3PbXYqMAQHtnJ+bmbGMGJVst1B+Pktx/0
        DjEycTAeYpTgYFYS4V14ZmeSEG9KYmVValF+fFFpTmrxIUZTYEhPZJYSTc4Hpvq8knhDE0sD
        EzMzQ3MjUwNzJXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1Mcd4+6yuKr7158pxbIrGpQ9Ko
        z8qWeZsC+779JYu3B1758ej8e2dpKx9vKVOXBpHp5QnTFdqVV57tclPjEbNm27P7A69548fO
        D6ydkSWTMxjfeE2L61/2aJuOR8YXR3FpTp7Swy/6trf2GnayituXcdY02f6a+uR6SMlM7Vnh
        /g9r7VmOrN31OOZr0tZNj5xXtzbv/nFQVeHzfNH/aRpn0qbIy8kpX1LzvBYRd8hwc6l7d5F1
        x1fHv1uOblR42Nq2VMjtdP6NU9Isv61DT6xeUWdw548x+/kqba2Nbq37XK0qTx1uv3ap6qEu
        f+adOS55bZMMuML6TFVvK/8IlLskJG2SLs7o9G1F5AvfBCWW4oxEQy3mouJEAD2tQIw9BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO5dqT1JBj0/lSwezNvGZrH4x3Mm
        i6kPn7BZzD9yjtWi78VDZou9r7eyW2x6fI3VYsb5fUwWjR9vslu07j3C7sDlcX3JJ2aPTas6
        2TzuXNvD5rF5Sb1H35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZXTcPstacEa8Ylb/VsYGxmtC
        XYycHBICJhIXllxj6WLk4hAS2M0osf1iKzNEQlbi2bsd7BC2sMT9liOsEEXPGCXWr7oNlmAT
        0Jd42bENLCEi8J5R4uGCS4wgDrPAXkaJ2ydvskG0fGeUOPliFQtIC6eAncSHzy+ZQGxhgQiJ
        yX/vMYLYLAKqEhPnfQer4RWwlGjftowZwhaUODnzCVicWUBb4unNp1C2vMT2t3OgblWQ+Pl0
        GStEXERidmcbWFxEwE2isfk8ywRG4VlIRs1CMmoWklGzkLQvYGRZxSiZWlCcm55bbFhgmJda
        rlecmFtcmpeul5yfu4kRHHtamjsYt6/6oHeIkYmD8RCjBAezkgjvwjM7k4R4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgquO4LfqE9e3ag8Vnpt6asF/g
        9QZDza9HLBO2yM22sFNoO3tjO6/m5L8f7mz8Y2Uz+dvOhu236oxfK19Y473364Una36cvu8x
        pbWw8ljm1XcsT9b85rO6lHTk+NTbryb2feN3bbmk+VnDs3rTosItekfUjsuwnPh7ca+i1J6a
        04evCc/lCjY4oWMfIduqMPmgX/v3C9EnEng/uwoLXWTTa/1s+/yKcGlVq/Dy3/N35PyS+mn6
        9bHjNCPNoph9FevVIw1LE+7dOciav0de7Dv/7flcv+/MSBfZba8f3OPcK/p+jfGabKdH+z++
        OMf3oZl1Q/C7Tccun/AqUn+9cN18lQ8/DzxYZb3UUdhvW6/YpU5WJZbijERDLeai4kQAmFR6
        dywDAAA=
X-CMS-MailID: 20220629092653epcas2p3d8090c552998591944ad9a215f0936c2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220628044432epcas2p11e6f927321c30cf5557dbd41d749ef28
References: <20220628044222.152794-1-chanho61.park@samsung.com>
        <CGME20220628044432epcas2p11e6f927321c30cf5557dbd41d749ef28@epcas2p1.samsung.com>
        <20220628044222.152794-3-chanho61.park@samsung.com>
        <da86b25a-097d-63fe-083a-5600b72b0bdb@linaro.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> > Modern exynos SoCs such as Exynos Auto v9 has different internal clock
> > divider, for example "4". To support this internal value, this adds
> > clk_div of the s3c64xx_spi_port_config and assign "2" as the default
> > value to existing s3c64xx_spi_port_config.
> >
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > ---
> >  drivers/spi/spi-s3c64xx.c | 28 ++++++++++++++++++++--------
> >  1 file changed, 20 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> > index b3c50c7665fc..51a0e830441b 100644
> > --- a/drivers/spi/spi-s3c64xx.c
> > +++ b/drivers/spi/spi-s3c64xx.c
> > @@ -131,6 +131,7 @@ struct s3c64xx_spi_dma_data {
> >   * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in SPI_STATUS
> register.
> >   * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS regiter.
> >   * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
> > + * @clk_div: Internal clock divider, if not specified, use 2 as the
> default.
> >   * @quirks: Bitmask of known quirks
> >   * @high_speed: True, if the controller supports HIGH_SPEED_EN bit.
> >   * @clk_from_cmu: True, if the controller does not include a clock
> > mux and @@ -148,6 +149,7 @@ struct s3c64xx_spi_port_config {
> >  	int	rx_lvl_offset;
> >  	int	tx_st_done;
> >  	int	quirks;
> > +	int	clk_div;
> >  	bool	high_speed;
> >  	bool	clk_from_cmu;
> >  	bool	clk_ioclk;
> > @@ -620,6 +622,7 @@ static int s3c64xx_spi_config(struct
> s3c64xx_spi_driver_data *sdd)
> >  	void __iomem *regs = sdd->regs;
> >  	int ret;
> >  	u32 val;
> > +	u32 div = sdd->port_conf->clk_div;
> >
> >  	/* Disable Clock */
> >  	if (!sdd->port_conf->clk_from_cmu) { @@ -668,16 +671,15 @@ static
> > int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
> >  	writel(val, regs + S3C64XX_SPI_MODE_CFG);
> >
> >  	if (sdd->port_conf->clk_from_cmu) {
> > -		/* The src_clk clock is divided internally by 2 */
> > -		ret = clk_set_rate(sdd->src_clk, sdd->cur_speed * 2);
> > +		ret = clk_set_rate(sdd->src_clk, sdd->cur_speed * div);
> >  		if (ret)
> >  			return ret;
> > -		sdd->cur_speed = clk_get_rate(sdd->src_clk) / 2;
> > +		sdd->cur_speed = clk_get_rate(sdd->src_clk) / div;
> >  	} else {
> >  		/* Configure Clock */
> >  		val = readl(regs + S3C64XX_SPI_CLK_CFG);
> >  		val &= ~S3C64XX_SPI_PSR_MASK;
> > -		val |= ((clk_get_rate(sdd->src_clk) / sdd->cur_speed / 2 - 1)
> > +		val |= ((clk_get_rate(sdd->src_clk) / sdd->cur_speed / div -
> 1)
> >  				& S3C64XX_SPI_PSR_MASK);
> >  		writel(val, regs + S3C64XX_SPI_CLK_CFG);
> >
> > @@ -871,6 +873,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
> >  	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
> >  	struct s3c64xx_spi_driver_data *sdd;
> >  	int err;
> > +	u32 div = 2;
> 
> This assignment is not effective - shortly later is being overwritten.

I forgot to remove this. I'll drop the assignment.

Best Regards,
Chanho Park

