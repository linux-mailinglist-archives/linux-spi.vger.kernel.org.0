Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3642AC7BC
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 22:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbgKIVz3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 16:55:29 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40270 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbgKIVz1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 16:55:27 -0500
Received: by mail-oi1-f193.google.com with SMTP id m143so11922660oig.7;
        Mon, 09 Nov 2020 13:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=04FVsg3be89rhioIr4Vul6hS9/ZyD/kx4pWYlaKleBM=;
        b=p4y/du7JxMJ2asjV9Mhfcdl+s23xxcSFJpkroK93obUaVz1zoZz3c61rSk9zl1bPz9
         xE4pCMnnHiW2FIdrL/LA1DWQ4oWkp2T8mbvHRu+J+GaorYCYC7XWvSW1GIA1l34qyQ7/
         zzkx4WQxy1o5H7Rk/ifVWEyzWAOUo2UKijrCiglbsaVDPcP0rW6S72FYGMZEth+M9Hz2
         o10W9xUUNCaOUDp9JM68HP5Z302FILAbyLZ4+WHTLKnBE4BTkPioh/9XEe7etk9JQ7T+
         amX2J2teKGD9AA1cyVoRVvFtC/v/HugCgTdZ1RiJDUO+ysDmLnpuI8GNnvEkbMkQRoK9
         cT+g==
X-Gm-Message-State: AOAM532iWfE2tSRFvtO55Onc10kcR8JSquk9W0did4JesdqLeBfgCYIG
        SP/2XpjQKjpYFb7sxCKkqg==
X-Google-Smtp-Source: ABdhPJzL2GcGme0D4867kVwep2Xa+C8mW3Fs8Qp4DkNNiQWlPr7shzCEUKfk7gGEG6DgNm+m3wq1VA==
X-Received: by 2002:a05:6808:d0:: with SMTP id t16mr797254oic.79.1604958926366;
        Mon, 09 Nov 2020 13:55:26 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c31sm2753199otb.27.2020.11.09.13.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:55:25 -0800 (PST)
Received: (nullmailer pid 1824495 invoked by uid 1000);
        Mon, 09 Nov 2020 21:55:24 -0000
Date:   Mon, 9 Nov 2020 15:55:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH 06/32] spi: dw: Add support for the Kendryte K210 SoC
Message-ID: <20201109215524.GA1819368@bogus>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-7-damien.lemoal@wdc.com>
 <20201109212158.y34otj3uy2hev75c@mobilestation>
 <BL0PR04MB6514111AE633C1E53B6F08A3E7EA0@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB6514111AE633C1E53B6F08A3E7EA0@BL0PR04MB6514.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 09, 2020 at 09:39:19PM +0000, Damien Le Moal wrote:
> On 2020/11/10 6:22, Serge Semin wrote:
> > On Sat, Nov 07, 2020 at 05:13:54PM +0900, Damien Le Moal wrote:
> >> The DW SPI master of the Kendryte K210 RISC-V SoC uses the 32-bits
> >> ctrlr0 register format. This SoC is also quite slow and gets significant
> >> SD card performance improvements from using no-delay polled transfers.
> >> Add the dw_spi_k210_init() function tied to the
> >> "canaan,kendryte-k210-spi" compatible string to set the
> >> DW_SPI_CAP_DFS_32 and DW_SPI_CAP_POLL_NODELAY DW SPI capability fields
> >> for this SoC.
> >>
> >> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> >> ---
> >>  drivers/spi/spi-dw-mmio.c | 9 +++++++++
> >>  1 file changed, 9 insertions(+)
> >>
> >> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> >> index 3f1bc384cb45..a00def6c5b39 100644
> >> --- a/drivers/spi/spi-dw-mmio.c
> >> +++ b/drivers/spi/spi-dw-mmio.c
> >> @@ -223,6 +223,14 @@ static int dw_spi_keembay_init(struct platform_device *pdev,
> >>  	return 0;
> >>  }
> >>  
> >> +static int dw_spi_k210_init(struct platform_device *pdev,
> >> +			    struct dw_spi_mmio *dwsmmio)
> >> +{
> >> +	dwsmmio->dws.caps = DW_SPI_CAP_DFS_32 | DW_SPI_CAP_POLL_NODELAY;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int dw_spi_mmio_probe(struct platform_device *pdev)
> >>  {
> >>  	int (*init_func)(struct platform_device *pdev,
> >> @@ -340,6 +348,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
> >>  	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
> >>  	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
> >>  	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
> > 
> >> +	{ .compatible = "canaan,kendryte-k210-spi", .data = dw_spi_k210_init},
> > 
> > Other than the comments from Sean and Mark regarding the DFS_32
> > feature runtime detectability, I couldn't find a patch with adding the
> > new new compatible string into the DW APB SSI DT schema. Have I missed
> > it? If I haven't could you add one to the next version of the series?
> 
> Yes, I will. I forgot to change the DW DT binding doc for this. I did add a
> patch for the "polling" property but forgot the compatible string.
> 
> In any case, I think that this new compatible string change can be dropped by
> switching to automatically detecting the DFS32 and using a different solution
> than the polling property change I sent for the RX fifo overflow problem.

No, new SoC needs new compatible string. Especially if a new vendor. 

> 
> I am still going through all the emails trying to understand what to try next to
> avoid the polling "hack".

Use compatible.

Rob
