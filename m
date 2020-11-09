Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220932AC911
	for <lists+linux-spi@lfdr.de>; Tue, 10 Nov 2020 00:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgKIXIG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 18:08:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbgKIXIG (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 18:08:06 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 657E820867;
        Mon,  9 Nov 2020 23:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604963285;
        bh=TtA6XfDWGkO1ZpolVZxKGc7rOK5jKrZrF/7cl/97B3I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M7Ruxrb4g9hCtLGGAaHn6aJyb0EILCuvhH1AjbFnKL4F3FG+OC/iSbY5xBclWesHl
         OOyS+qobcFAIyVuJnsbkCnhZRPidr4pO3ZIYxpNqKq/OMx/7rsYQv7YhDHxBkrmn0r
         FYYiSberE/DqiVodBOwh0bllkcoRO3O0RjZnBxqw=
Received: by mail-ot1-f41.google.com with SMTP id y22so10685703oti.10;
        Mon, 09 Nov 2020 15:08:05 -0800 (PST)
X-Gm-Message-State: AOAM531GXmELR7taJvX2UwLP1VrCcMcAib+9y+KOgCEwl1LXGlhW1tSh
        jnh9P/9JUHwZOUEFKftlxR9dXHQZ9QpDpb46oA==
X-Google-Smtp-Source: ABdhPJyMSwvg+BHKJ896W4R1H5ymsArUEqZd5rnKA6qYg/lKQd4xN012ccSn4YoWRqazbSj9RXxPWb/J+Nic/bsRyJM=
X-Received: by 2002:a05:6830:2f8:: with SMTP id r24mr12017928ote.129.1604963284584;
 Mon, 09 Nov 2020 15:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-7-damien.lemoal@wdc.com>
 <20201109212158.y34otj3uy2hev75c@mobilestation> <BL0PR04MB6514111AE633C1E53B6F08A3E7EA0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20201109215524.GA1819368@bogus> <BL0PR04MB6514C9D94E2098EEA0A8462FE7EA0@BL0PR04MB6514.namprd04.prod.outlook.com>
In-Reply-To: <BL0PR04MB6514C9D94E2098EEA0A8462FE7EA0@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Nov 2020 17:07:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL6GuY01Fye6U8QsGMzz+TuMiVJF9r0cGXCsNPPJzWXEw@mail.gmail.com>
Message-ID: <CAL_JsqL6GuY01Fye6U8QsGMzz+TuMiVJF9r0cGXCsNPPJzWXEw@mail.gmail.com>
Subject: Re: [PATCH 06/32] spi: dw: Add support for the Kendryte K210 SoC
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 9, 2020 at 4:00 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2020/11/10 6:55, Rob Herring wrote:
> > On Mon, Nov 09, 2020 at 09:39:19PM +0000, Damien Le Moal wrote:
> >> On 2020/11/10 6:22, Serge Semin wrote:
> >>> On Sat, Nov 07, 2020 at 05:13:54PM +0900, Damien Le Moal wrote:
> >>>> The DW SPI master of the Kendryte K210 RISC-V SoC uses the 32-bits
> >>>> ctrlr0 register format. This SoC is also quite slow and gets significant
> >>>> SD card performance improvements from using no-delay polled transfers.
> >>>> Add the dw_spi_k210_init() function tied to the
> >>>> "canaan,kendryte-k210-spi" compatible string to set the
> >>>> DW_SPI_CAP_DFS_32 and DW_SPI_CAP_POLL_NODELAY DW SPI capability fields
> >>>> for this SoC.
> >>>>
> >>>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> >>>> ---
> >>>>  drivers/spi/spi-dw-mmio.c | 9 +++++++++
> >>>>  1 file changed, 9 insertions(+)
> >>>>
> >>>> diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
> >>>> index 3f1bc384cb45..a00def6c5b39 100644
> >>>> --- a/drivers/spi/spi-dw-mmio.c
> >>>> +++ b/drivers/spi/spi-dw-mmio.c
> >>>> @@ -223,6 +223,14 @@ static int dw_spi_keembay_init(struct platform_device *pdev,
> >>>>    return 0;
> >>>>  }
> >>>>
> >>>> +static int dw_spi_k210_init(struct platform_device *pdev,
> >>>> +                      struct dw_spi_mmio *dwsmmio)
> >>>> +{
> >>>> +  dwsmmio->dws.caps = DW_SPI_CAP_DFS_32 | DW_SPI_CAP_POLL_NODELAY;
> >>>> +
> >>>> +  return 0;
> >>>> +}
> >>>> +
> >>>>  static int dw_spi_mmio_probe(struct platform_device *pdev)
> >>>>  {
> >>>>    int (*init_func)(struct platform_device *pdev,
> >>>> @@ -340,6 +348,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
> >>>>    { .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
> >>>>    { .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
> >>>>    { .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
> >>>
> >>>> +  { .compatible = "canaan,kendryte-k210-spi", .data = dw_spi_k210_init},
> >>>
> >>> Other than the comments from Sean and Mark regarding the DFS_32
> >>> feature runtime detectability, I couldn't find a patch with adding the
> >>> new new compatible string into the DW APB SSI DT schema. Have I missed
> >>> it? If I haven't could you add one to the next version of the series?
> >>
> >> Yes, I will. I forgot to change the DW DT binding doc for this. I did add a
> >> patch for the "polling" property but forgot the compatible string.
> >>
> >> In any case, I think that this new compatible string change can be dropped by
> >> switching to automatically detecting the DFS32 and using a different solution
> >> than the polling property change I sent for the RX fifo overflow problem.
> >
> > No, new SoC needs new compatible string. Especially if a new vendor.
>
> My apologies for the bad wording: I meant to say the change to the list of
> compatible strings that the DW SPI support would not be needed. So from the DW
> SPI point of view, there would be no new compatible string to add/document.

No, there is a need for a new compatible string to add/document. You
might not need it in the driver if you have a fallback.

Compatible strings should be SoC specific so you can handle quirks
without a DT change. Otherwise, it's a never ending stream of new
properties and DT updates.

> >> I am still going through all the emails trying to understand what to try next to
> >> avoid the polling "hack".
> >
> > Use compatible.
>
> Yes, that is what this patch used. Again, I think there is a chance this change
> can be dropped.

Looks to me like it used a 'polling' property...

Rob
