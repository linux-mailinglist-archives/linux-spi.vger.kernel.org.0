Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D7355FCCB
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 12:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiF2KEN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 06:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiF2KEM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 06:04:12 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5344D3DA45
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 03:04:10 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220629100408epoutp020b9e2534f15875ded4009cd2a82fc3b2~9D0n--yoi3104931049epoutp02T
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 10:04:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220629100408epoutp020b9e2534f15875ded4009cd2a82fc3b2~9D0n--yoi3104931049epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656497048;
        bh=mfXEZIav+lKQ3SITbiYkNMcxmeLkUSvRgV44KIZ63jk=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=XPLiNjTyO4Phxi6rozCqvwgUVNjH0oDMro2OC+dy5l7iwfY0m2FU2oigIwVEvqaMS
         hIb/B9h9008wBYllY3ruN8Dwp7/K8DQyzWhC+cqq5upK7fR4n+S3b+Q2dsvocJjAqX
         rHgHQlXygfe+x8uFyBAT0bxSZZUE78i1jBfTkfHs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220629100408epcas2p24a1e56738e4247bbe8576ff8a4e2a36b~9D0nniifj0830208302epcas2p2g;
        Wed, 29 Jun 2022 10:04:08 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LXxrR58xRz4x9Q7; Wed, 29 Jun
        2022 10:04:07 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E4.17.09666.7932CB26; Wed, 29 Jun 2022 19:04:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220629100407epcas2p3bb2c41e89024cafceff5a3d9b646d3a0~9D0m_Vfsw1681316813epcas2p3d;
        Wed, 29 Jun 2022 10:04:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220629100407epsmtrp2ba2e88fa8f9d295274010eacc1d528ac~9D0m9gowy2437224372epsmtrp2F;
        Wed, 29 Jun 2022 10:04:07 +0000 (GMT)
X-AuditID: b6c32a45-471ff700000025c2-f8-62bc23970e14
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.A5.08905.7932CB26; Wed, 29 Jun 2022 19:04:07 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220629100407epsmtip12886762af6bfe594a56d4457d31b8593~9D0mwmmJB1085110851epsmtip1F;
        Wed, 29 Jun 2022 10:04:07 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Andi Shyti'" <andi@etezian.org>
Cc:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Mark Brown'" <broonie@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Alim Akhtar'" <alim.akhtar@samsung.com>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
In-Reply-To: <YrweoNCL3BjqUNWV@jack.zhora.eu>
Subject: RE: [PATCH v2 2/4] spi: s3c64xx: support custom value of internal
 clock divider
Date:   Wed, 29 Jun 2022 19:04:07 +0900
Message-ID: <026801d88b9f$91f01180$b5d03480$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHQezgfaORozkaflreY0gl9GrbVUwIO7M/nAkDRpz4Cfbaemq0/2M+g
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmue505T1JBp8a1C0ezNvGZrH4x3Mm
        i6kPn7BZzD9yjtWi78VDZou9r7eyW2x6fI3VYsb5fUwWjR9vslu07j3C7sDlcX3JJ2aPTas6
        2TzuXNvD5rF5Sb1H35ZVjB6fN8kFsEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
        WpgrKeQl5qbaKrn4BOi6ZeYAXaakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAv
        0CtOzC0uzUvXy0stsTI0MDAyBSpMyM64/1au4KFoxbKvK5gbGK8KdjFyckgImEjs2f6XvYuR
        i0NIYAejxOp9TWwQzidGiT1relkhnG+MEl82vWfuYuQAa5n/SwsivpdRomNfI1THC0aJZ2d3
        soDMZRPQl3jZsY0VxBYRUJVY+ngmWBGzQCOzxJa9O5lBEpwCuhJ7Ti9mBLGFBaIkdj98zwRi
        swA1dK5bDmbzClhKnDizgBHCFpQ4OfMJ2AJmAXmJ7W/nMEM8oSDx8+kyVoi4iMTszjZmiMVu
        En/bnoM9JyGwlkNi0YPfbBANLhJbbn2FsoUlXh3fwg5hS0l8frcXKl4ssXTWJyaI5gZGicvb
        fkEljCVmPWtnBIUFs4CmxPpd+pBgUZY4cgvqNj6JjsOgQAUJ80p0tAlBNKpLHNg+nQXClpXo
        nvOZdQKj0iwkn81C8tksJN/MQti1gJFlFaNYakFxbnpqsVGBITyyk/NzNzGCE62W6w7GyW8/
        6B1iZOJgPMQowcGsJMK78MzOJCHelMTKqtSi/Pii0pzU4kOMpsCwnsgsJZqcD0z1eSXxhiaW
        BiZmZobmRqYG5krivF4pGxKFBNITS1KzU1MLUotg+pg4OKUamBhDmBtTfDZbRC/56Lczvfd5
        zf/umd/u9bw/HxutsNHyzNEbk09uk/g864OpwGL9o1Y2R1rL53x70DWPsb3jaE6M+81dN5Je
        5N4z2Gr9aLJLZEM1+8zt5yo7Sy61VX0q60lc2/zI8ouCwDM572cve8zDHnLVVS7ikfzPeLZw
        /4/ACcqf86dZPCjKD7QVfhMXrqfn4r9XWf5t5N4t4qYSfZ/2a7b7GM7Y2/DK+WrFN12lvTs2
        LOtc+HEtW7N71d24i+KPPFRjLqt8X6OsPPVfTe6HDxa8odNOG85kcvFhjJ6wk2kRR7Tza3M9
        pfca83cX8Z6+/y3ZUk9a9cVimyuN/+4likvYxJw9VOE+xdnbUomlOCPRUIu5qDgRALtarTY9
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSnO505T1JBhfm8Fk8mLeNzWLxj+dM
        FlMfPmGzmH/kHKtF34uHzBZ7X29lt9j0+BqrxYzz+5gsGj/eZLdo3XuE3YHL4/qST8wem1Z1
        snncubaHzWPzknqPvi2rGD0+b5ILYIvisklJzcksSy3St0vgyrj/Vq7goWjFsq8rmBsYrwp2
        MXJwSAiYSMz/pdXFyMUhJLCbUWJh6zbmLkZOoLisxLN3O9ghbGGJ+y1HWCGKnjFKzH7azQaS
        YBPQl3jZsY0VxBYRUJVY+ngmG0gRs0A7s8StS+fAEmAds1bWgticAroSe04vZgSxhQUiJCb/
        vQdmswA1d65bzgRi8wpYSpw4s4ARwhaUODnzCQuIzSygJ7F+/RxGCFteYvvbOVCXKkj8fLqM
        FSIuIjG7s40Z4iA3ib9tz9knMArPQjJqFpJRs5CMmoWkfQEjyypGydSC4tz03GLDAsO81HK9
        4sTc4tK8dL3k/NxNjOCY09Lcwbh91Qe9Q4xMHIyHGCU4mJVEeBee2ZkkxJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA5OLgr22IcsEMY3bB9vtcrZcVNKI
        T1ML9Nsc+FW4iDWzQLUy/07EqoUylt+XaF8xPp94WuLTIWXfx5f+v7+dySvQ9W3KRvULW2WD
        a3Ln91XpL7xqeoSr8yHXxDv7+b5788wMLd17IGXphSWf1f3f+T+M3/7v/6I8p+NWx9ik3Te+
        sjzvmOzaEWLM5PxKS+zrDPubl5M2lUdvsZtcILeG069jkrHu3atRj5q/xhe+k79ZzG3bdEmh
        0urG/gdb7vbJ21oY2Zc9VQjeJNCQO1F0Zm/xtqDboibrV2/ITci8sYlrvhjjCctLVzmyPx17
        GLzCVs4vgLcupLJ61lHbOXFTXz9Vzq85IDZ3bWjVgkn/LZVYijMSDbWYi4oTAbr550IoAwAA
X-CMS-MailID: 20220629100407epcas2p3bb2c41e89024cafceff5a3d9b646d3a0
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
        <YrweoNCL3BjqUNWV@jack.zhora.eu>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy,
Thanks for your reviews :)

> -----Original Message-----
> From: Andi Shyti <andi@etezian.org>
> Sent: Wednesday, June 29, 2022 6:43 PM
> To: Chanho Park <chanho61.park@samsung.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Andi Shyti
> <andi@etezian.org>; Mark Brown <broonie@kernel.org>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
<alim.akhtar@samsung.com>;
> devicetree@vger.kernel.org; linux-spi@vger.kernel.org; linux-samsung-
> soc@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 2/4] spi: s3c64xx: support custom value of internal
> clock divider
> 
> Hi Chanho,
> 
> On Tue, Jun 28, 2022 at 01:42:20PM +0900, Chanho Park wrote:
> > Modern exynos SoCs such as Exynos Auto v9 has different internal clock
> 
> /has/have/

I'll correct it.

> 
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
> >   * @rx_lvl_offset: Bit offset of RX_FIFO_LVL bits in SPI_STATUS
regiter.
> >   * @tx_st_done: Bit offset of TX_DONE bit in SPI_STATUS regiter.
> > + * @clk_div: Internal clock divider, if not specified, use 2 as the
> default.
> 
> is it default? Is it not specified anywhere? I think you are assigning '2'
> to everyone. I would just leave it "Internal clock divider."

It has not been removed since v1.

> 
> [...]
> 
> > @@ -871,6 +873,7 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
> >  	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
> >  	struct s3c64xx_spi_driver_data *sdd;
> >  	int err;
> > +	u32 div = 2;
> 
> As per Krzystof review.
> 
> >  	sdd = spi_master_get_devdata(spi->master);
> >  	if (spi->dev.of_node) {
> > @@ -889,22 +892,24 @@ static int s3c64xx_spi_setup(struct spi_device
> > *spi)
> >
> >  	pm_runtime_get_sync(&sdd->pdev->dev);
> >
> > +	div = sdd->port_conf->clk_div;
> 
> Can you please be consistent with the data type? div is u32, but clk_div
> is int.

It should be int to be matched with any other types of
s3c64xx_spi_port_config.

Best Regards,
Chanho Park

