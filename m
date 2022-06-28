Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30155DD99
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jun 2022 15:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbiF1Bv6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jun 2022 21:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242822AbiF1Bv5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 21:51:57 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37271131
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 18:51:55 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220628015153epoutp0173138e9c74cf22bd95131bc4849d988a~8pdjhoDE53117031170epoutp01V
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 01:51:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220628015153epoutp0173138e9c74cf22bd95131bc4849d988a~8pdjhoDE53117031170epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656381113;
        bh=zfGvcH4lBVwI5LXKh5eqEwAFrZzlrW51lWexTf6mm8A=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=CRWHoJOvjCjyjq+sY7opNGyUV+TgY7hswphgS8wKn7j9jOYL58e7HgO74QyFKUK02
         qtuU4on1kt65TIDRRELSZJSNKPviU8CvMN0jNIthFes6UUMAdxJ5wvamTBas07e4ZK
         3f/JBxfNzL/S81exif3DVbNNX+3y6gOxCz0uHj10=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220628015153epcas2p1910561790e05c686a032671895ddaabb~8pdjEHgqf2601626016epcas2p1B;
        Tue, 28 Jun 2022 01:51:53 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LX6yx088Gz4x9Pw; Tue, 28 Jun
        2022 01:51:53 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        10.44.09642.8BE5AB26; Tue, 28 Jun 2022 10:51:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220628015152epcas2p4e5963a774006e7b26bc6fb1d1090a539~8pdiCFu_c2768427684epcas2p4Y;
        Tue, 28 Jun 2022 01:51:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220628015152epsmtrp2d84aff7512dd5e32c192fa985ea166a2~8pdiAl85h1556515565epsmtrp2c;
        Tue, 28 Jun 2022 01:51:52 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-ce-62ba5eb8b81f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5F.3D.08905.8BE5AB26; Tue, 28 Jun 2022 10:51:52 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220628015152epsmtip12f92b43e8580fd9ecd5dc046a727b743~8pdh0X8eb2072620726epsmtip1W;
        Tue, 28 Jun 2022 01:51:52 +0000 (GMT)
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
In-Reply-To: <3a7f2faa-0d42-02e6-fb1a-216be1120ff3@linaro.org>
Subject: RE: [PATCH 3/5] spi: s3c64xx: support custom value of internal
 clock divider
Date:   Tue, 28 Jun 2022 10:51:52 +0900
Message-ID: <000201d88a91$a33d3c60$e9b7b520$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKd8jrOeLz5V8oX+q+XomvWydQZVADtCDevAliT4PYCn6r7K6uqE8tA
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmqe6OuF1JBkt2m1k8mLeNzWLxj+dM
        FlMfPmGzmH/kHKtF34uHzBZ7X29lt9j0+BqrxYzz+5gsGj/eZLdo3XuE3YHL4/qST8wem1Z1
        snncubaHzWPzknqPvi2rGD0+b5ILYIvKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0
        tDBXUshLzE21VXLxCdB1y8wBukxJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2Be
        oFecmFtcmpeul5daYmVoYGBkClSYkJ1x+d5ZloJdAhW/ntxkbGDs5+1i5OSQEDCRmLvpLTuI
        LSSwg1HiyTJnCPsTo8TiI2pdjFxA9jdGiQW71zHDNBx+dYwdIrGXUeLL778sEM4LRom9x/ez
        glSxCehLvOzYxgqSEBF4yyhxZvcJsB3MAjsZJRrmxYDYnAJ2Ertub2QEsYUFwiWuPJnKBmKz
        CKhKXNp1kwnE5hWwlPj5bCULhC0ocXLmExaIOfIS29/OgTpJQeLn02Vgi0UE3CTO7fvIDFEj
        IjG7s40Z5AgJgT0cEr09/VANLhLfnh2BsoUlXh3fwg5hS0l8freXDcIullg66xMTRHMDo8Tl
        bb+gEsYSs561A13NAbRBU2L9Ln0QU0JAWeLILajb+CQ6Dv9lhwjzSnS0CUE0qksc2D6dBcKW
        leie85l1AqPSLCSfzULy2SwkH8xC2LWAkWUVo1hqQXFuemqxUYExPLKT83M3MYITrZb7DsYZ
        bz/oHWJk4mA8xCjBwawkwrvwzM4kId6UxMqq1KL8+KLSnNTiQ4ymwLCeyCwlmpwPTPV5JfGG
        JpYGJmZmhuZGpgbmSuK8XikbEoUE0hNLUrNTUwtSi2D6mDg4pRqYRGSNBIVufeRd+uZrzp+O
        i0c2qAWkfeL+Yrqo1i+h/MqFW/I6XSdsPiwvnt47Z4OxE5eOFOevj+2rzVdYSm1f/sfh4U2z
        lAX/Pm/Y/GkW11qh+qfzI/MZ2dew+T30KNo03zxmV7jJv7+fDpi2tIYk7v91cW5BaejXffIP
        Q9VUFu6qUPZO7L8kNaN78ac3//zXuh1cMeFh/tIzC5671/OJpivr3b1yPHfVR4611gI/Cjv9
        raNZv53klf/1OX6J3GYJ3++F697rmZuvL593/rpo/eYXpsvidgX4SCu//8p4g3kmW/eb5ABx
        cbXDvIyvRDvjaq9bLA45yf3SKTZxzQ9JzzrnlITER3vD3ylsCCp6rsRSnJFoqMVcVJwIAMw/
        Qu49BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO6OuF1JBmt6uCwezNvGZrH4x3Mm
        i6kPn7BZzD9yjtWi78VDZou9r7eyW2x6fI3VYsb5fUwWjR9vslu07j3C7sDlcX3JJ2aPTas6
        2TzuXNvD5rF5Sb1H35ZVjB6fN8kFsEVx2aSk5mSWpRbp2yVwZVy+d5alYJdAxa8nNxkbGPt5
        uxg5OSQETCQOvzrG3sXIxSEksJtR4uulVlaIhKzEs3c72CFsYYn7LUdYIYqeMUq0ndjIBpJg
        E9CXeNmxDSwhIvCeUeLhgkuMIA6zwF5Gidsnb7JBtHxnlJjQcoEZpIVTwE5i1+2NjCC2sECo
        xJKbR1lAbBYBVYlLu24ygdi8ApYSP5+tZIGwBSVOznwCZjMLaEv0PmxlhLDlJba/ncMMcZ+C
        xM+ny8DuFhFwkzi37yMzRI2IxOzONuYJjMKzkIyahWTULCSjZiFpWcDIsopRMrWgODc9t9iw
        wDAvtVyvODG3uDQvXS85P3cTIzj2tDR3MG5f9UHvECMTB+MhRgkOZiUR3oVndiYJ8aYkVlal
        FuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwGS3kbcxOvf844k51SqZ
        4atSp07mU+c44rA1vGFH7dmb2oaaDt92OaUlaeptkOxnM396xvbv7luRu7vXvYldN9fyrErq
        MWvtyrvTk+OmGDUke3dKJbe9WvTZ92pbiF6w5zH/jpXnd13Y62dU31HzUd7pyaFbmR6nXlkn
        fbnUX1XFvIxvk4v2sVl8IjNTwlxU3VTy6iNLHmdsON98Ofv4XD2N5kdZV3yWfIyeNet868l3
        xxVUk3ZkuuvvVVfRPvDdQendYR2/g539fvNWHblpMM0znuGW/fFDzLyX6ve1/xczn/ni84LL
        zopC01dVbkvyF2v1XXZiyls1/8lHzRY8OJXhtuZDaPP8yvg9KRkXfyqxFGckGmoxFxUnAgCm
        1kp9LAMAAA==
X-CMS-MailID: 20220628015152epcas2p4e5963a774006e7b26bc6fb1d1090a539
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627064931epcas2p2e1dc352f41895b294d7945c2239de362
References: <20220627064707.138883-1-chanho61.park@samsung.com>
        <CGME20220627064931epcas2p2e1dc352f41895b294d7945c2239de362@epcas2p2.samsung.com>
        <20220627064707.138883-4-chanho61.park@samsung.com>
        <3a7f2faa-0d42-02e6-fb1a-216be1120ff3@linaro.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

> Subject: Re: [PATCH 3/5] spi: s3c64xx: support custom value of internal
> clock divider
> 
> On 27/06/2022 08:47, Chanho Park wrote:
> > Modern exynos SoCs such as Exynos Auto v9 has different internal clock
> > divider, for example "4". To support this internal value, this adds
> > clk_div of the s3c64xx_spi_port_config and use it if it is specified.
> > Otherwise, use "2" which is the previous default value.
> >
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > ---
> >  drivers/spi/spi-s3c64xx.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> > index e17c74c0d7de..dd5fc8570bce 100644
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
> > +	u32 div = sdd->port_conf->clk_div ? sdd->port_conf->clk_div : 2;
> 
> I would prefer to explicitly set '2' as clk_div for existing variants.
> Such assignments in the code are usually trickier to find/read.

Make sense. It can be more clear what value is using.
I'll apply it next patchset.

Best Regards,
Chanho Park

