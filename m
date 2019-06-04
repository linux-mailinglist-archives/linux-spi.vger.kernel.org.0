Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67E633E28
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2019 07:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfFDFCy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jun 2019 01:02:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43353 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfFDFCy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jun 2019 01:02:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id 16so4780736ljv.10
        for <linux-spi@vger.kernel.org>; Mon, 03 Jun 2019 22:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMYe0p+e9Kkw3BfylIsXUOqTQEA3ePC1+CBBvaZ2WJU=;
        b=MP/lSyH92f8vhnVXrZ08CG4PcRZbZHIfFoXbFbwJaP+j0hNmz5PEu+yGQZwjpCHMu0
         rv4dow6At2fI1UyXqnX7Y5wgyp95+XrdWBpA0OeWTgPODLnnHxQRfqKj0jThKya7ufEa
         GyDihIoppuQlpupZSLJnh25NmwMKxGTHnu4fhgDe8g1I1a2xSptEDHDC9dJm/Z5XuA4p
         KCn7ELUrWFCwBJ3XqTlZhaqXjhfHAXzVy1RNQ6RgkyJPOjta4YU833+6bpzd5QgyLb0A
         G1jD7Asu2r3IjJ7NhPTufhvKdAEgTuPp5WUi0yVx08WDy73eZtvy7DWsPeLBzYNPL+Ri
         rHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMYe0p+e9Kkw3BfylIsXUOqTQEA3ePC1+CBBvaZ2WJU=;
        b=I+MAEUuxW5ZbpqdGwWu6bJ9qbhQMgOOW0SLbNY3cqC1m6jdIb0WgilgsuFB5QltGGO
         vM8rkEMZMn3GkJZ7oK1o7J8uNl+gdB3reuVtd0WBKQ7cw9yv3RZqXKxTCYEN2uELbUg1
         yEA0vK61q65RVH9x4iMWzdbSmkppd1b2IahfxJnqwjp3S7CNLkRrwRhxMYw714tYrsTg
         3rbP7qvepp4AaSK7NQLfWMy1VPF2wdxbWsCMfHI151pTFdXA2X798MqhHMfVujcqnyeW
         301sJHR8SxrqwvJZvP4/A3KC55ZYxPeDMJ3y9jbIGegD4iTc13wm4TUC7GtSPx+xJP4R
         LZZw==
X-Gm-Message-State: APjAAAUhFsoqLkEECGJJx5ilZYIvHFfxNf2Xj/vSclCJHhStVY2t2iwK
        t3z6WVI6/aGUuxb/mhzo4TCDMWjyuTd2iraMETgeqw==
X-Google-Smtp-Source: APXvYqxtH+xSJeyp0gGIEgfiX327aO2hTpJ/NzUv79ohxo63kVM5Ye2NpQKRmMOOZOOy6DmRfp1nMNNsTR+E1QkvLx4=
X-Received: by 2002:a2e:9581:: with SMTP id w1mr16100574ljh.88.1559624571016;
 Mon, 03 Jun 2019 22:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190528092713.10516-1-masahisa.kojima@linaro.org>
 <20190528092713.10516-4-masahisa.kojima@linaro.org> <CAKv+Gu9pqkDoB9WKCdqab6Tcy58KcCRZJRUw_8Z9mh7KNzRT=g@mail.gmail.com>
In-Reply-To: <CAKv+Gu9pqkDoB9WKCdqab6Tcy58KcCRZJRUw_8Z9mh7KNzRT=g@mail.gmail.com>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Tue, 4 Jun 2019 14:02:38 +0900
Message-ID: <CADQ0-X-fvi7A67KO65QCOYCMKGMPWY0dmoS_vFQR-YHtGyDWHg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] spi: Add spi driver for Socionext Synquacer platform
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaswinder Singh <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Satoru Okamoto <okamoto.satoru@socionext.com>,
        Yoshitoyo Osaki <osaki.yoshitoyo@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Ard,

Thank you for your comments.

On Thu, 30 May 2019 at 16:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 28 May 2019 at 11:27, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > This patch adds support for controller found on synquacer platforms.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> > ---
> >  drivers/spi/Kconfig         |  11 +
> >  drivers/spi/Makefile        |   1 +
> >  drivers/spi/spi-synquacer.c | 826 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 838 insertions(+)
> >  create mode 100644 drivers/spi/spi-synquacer.c
> >
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index 0fba8f400c59..24a3eac72d12 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -732,6 +732,17 @@ config SPI_SUN6I
> >         help
> >           This enables using the SPI controller on the Allwinner A31 SoCs.
> >
> > +config SPI_SYNQUACER
> > +       tristate "Socionext's Synquacer HighSpeed SPI controller"
> > +       depends on ARCH_SYNQUACER || COMPILE_TEST
> > +       select SPI_BITBANG
>
> Do we really need this dependency?

No, I remove dependency to SPI_BITBANG.

I will also fix other comments.

> > +       help
> > +         SPI driver for Socionext's High speed SPI controller which provides
> > +         various operating modes for interfacing to serial peripheral devices
> > +         that use the de-facto standard SPI protocol.
> > +
> > +         It also supports the new dual-bit and quad-bit SPI protocol.
> > +
> >  config SPI_MXIC
> >          tristate "Macronix MX25F0A SPI controller"
> >          depends on SPI_MASTER
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> > index f2f78d03dc28..63dcab552bcb 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -106,6 +106,7 @@ obj-$(CONFIG_SPI_STM32_QSPI)                += spi-stm32-qspi.o
> >  obj-$(CONFIG_SPI_ST_SSC4)              += spi-st-ssc4.o
> >  obj-$(CONFIG_SPI_SUN4I)                        += spi-sun4i.o
> >  obj-$(CONFIG_SPI_SUN6I)                        += spi-sun6i.o
> > +obj-$(CONFIG_SPI_SYNQUACER)            += spi-synquacer.o
> >  obj-$(CONFIG_SPI_TEGRA114)             += spi-tegra114.o
> >  obj-$(CONFIG_SPI_TEGRA20_SFLASH)       += spi-tegra20-sflash.o
> >  obj-$(CONFIG_SPI_TEGRA20_SLINK)                += spi-tegra20-slink.o
> > diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
> > new file mode 100644
> > index 000000000000..27a9babaffc0
> > --- /dev/null
> > +++ b/drivers/spi/spi-synquacer.c
> > @@ -0,0 +1,826 @@
> ...
> > +static int synquacer_spi_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *np = pdev->dev.of_node;
> > +       struct spi_master *master;
> > +       struct synquacer_spi *sspi;
> > +       int ret;
> > +       int rx_irq, tx_irq;
> > +
> > +       master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
> > +       if (!master)
> > +               return -ENOMEM;
> > +
> > +       platform_set_drvdata(pdev, master);
> > +
> > +       sspi = spi_master_get_devdata(master);
> > +       sspi->dev = &pdev->dev;
> > +
> > +       init_completion(&sspi->transfer_done);
> > +
> > +       sspi->regs = devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(sspi->regs)) {
> > +               ret = PTR_ERR(sspi->regs);
> > +               goto put_spi;
> > +       }
> > +
> > +       sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IHCLK; /* Default */
> > +       device_property_read_u32(&pdev->dev, "socionext,ihclk-rate",
> > +                                &master->max_speed_hz); /* for ACPI */
> > +
> > +       if (dev_of_node(&pdev->dev)) {
> > +               if (device_property_match_string(&pdev->dev,
> > +                                        "clock-names", "iHCLK") >= 0) {
> > +                       sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IHCLK;
> > +                       sspi->clk = devm_clk_get(sspi->dev, "iHCLK");
> > +               } else if (device_property_match_string(&pdev->dev,
> > +                                               "clock-names", "iPCLK") >= 0) {
> > +                       sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IPCLK;
> > +                       sspi->clk = devm_clk_get(sspi->dev, "iPCLK");
> > +               } else {
> > +                       dev_err(&pdev->dev, "specified wrong clock source\n");
> > +                       ret = -EINVAL;
> > +                       goto put_spi;
> > +               }
> > +               if (IS_ERR(sspi->clk)) {
>
> You could have received an -EPROBE_DEFER return value here, in which
> case you should not print an error and just return.
>
> > +                       dev_err(&pdev->dev, "clock not found\n");
> > +                       ret = PTR_ERR(sspi->clk);
> > +                       goto put_spi;
> > +               }
> > +
> > +               ret = clk_prepare_enable(sspi->clk);
> > +               if (ret) {
> > +                       dev_err(&pdev->dev, "failed to enable clock (%d)\n",
> > +                               ret);
> > +                       goto put_spi;
> > +               }
> > +
> > +               master->max_speed_hz = clk_get_rate(sspi->clk);
> > +       }
> > +
> > +       if (!master->max_speed_hz) {
> > +               dev_err(&pdev->dev, "missing clock source\n");
> > +               return -EINVAL;
> > +       }
> > +       master->min_speed_hz = master->max_speed_hz / 254;
> > +
> > +       sspi->aces = device_property_read_bool(&pdev->dev,
> > +                                              "socionext,set-aces");
> > +       sspi->rtm = device_property_read_bool(&pdev->dev, "socionext,use-rtm");
> > +
> > +       master->num_chipselect = SYNQUACER_HSSPI_NUM_CHIP_SELECT;
> > +
> > +       rx_irq = platform_get_irq(pdev, 0);
> > +       if (rx_irq < 0) {
>
> <= 0
>
> > +               dev_err(&pdev->dev, "get rx_irq failed (%d)\n", rx_irq);
> > +               ret = rx_irq;
> > +               goto put_spi;
> > +       }
> > +       snprintf(sspi->rx_irq_name, SYNQUACER_HSSPI_IRQ_NAME_MAX, "%s-%s",
>
> Why not just use "%s-rx" as the format string?
>
> > +                dev_name(&pdev->dev), "rx");
> > +       ret = devm_request_irq(&pdev->dev, rx_irq, sq_spi_rx_handler,
> > +                               0, sspi->rx_irq_name, sspi);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "request rx_irq failed (%d)\n", ret);
> > +               goto put_spi;
> > +       }
> > +
> > +       tx_irq = platform_get_irq(pdev, 1);
> > +       if (tx_irq < 0) {
>
> <= 0
>
> > +               dev_err(&pdev->dev, "get tx_irq failed (%d)\n", tx_irq);
> > +               ret = tx_irq;
> > +               goto put_spi;
> > +       }
> > +       snprintf(sspi->tx_irq_name, SYNQUACER_HSSPI_IRQ_NAME_MAX, "%s-%s",
>
> Likewise
>
> > +                dev_name(&pdev->dev), "tx");
> > +       ret = devm_request_irq(&pdev->dev, tx_irq, sq_spi_tx_handler,
> > +                               0, sspi->tx_irq_name, sspi);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "request tx_irq failed (%d)\n", ret);
> > +               goto put_spi;
> > +       }
> > +
> > +       master->dev.of_node = np;
>
> please add
>
> master->dev.fwnode = pdev->dev.fwnode;
>
> here as well
>
> > +       master->auto_runtime_pm = true;
> > +       master->bus_num = pdev->id;
> > +
> > +       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL |
> > +                           SPI_TX_QUAD | SPI_RX_QUAD;
> > +       master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(24) |
> > +                                    SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
> > +
> > +       master->set_cs = synquacer_spi_set_cs;
> > +       master->transfer_one = synquacer_spi_transfer_one;
> > +
> > +       ret = synquacer_spi_enable(master);
> > +       if (ret)
> > +               goto fail_enable;
> > +
> > +       pm_runtime_set_active(sspi->dev);
> > +       pm_runtime_enable(sspi->dev);
> > +
> > +       ret = devm_spi_register_master(sspi->dev, master);
> > +       if (ret)
> > +               goto disable_pm;
> > +
> > +       return 0;
> > +
> > +disable_pm:
> > +       pm_runtime_disable(sspi->dev);
> > +fail_enable:
> > +       if (!IS_ERR(sspi->clk))
>
> You can drop this check: clk_disable_unprepare() already ignores NULL
> or ERR values.
>
> > +               clk_disable_unprepare(sspi->clk);
> > +put_spi:
> > +       spi_master_put(master);
> > +
> > +       return ret;
> > +}
> > +
> > +static int synquacer_spi_remove(struct platform_device *pdev)
> > +{
> > +       struct spi_master *master = platform_get_drvdata(pdev);
> > +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> > +
> > +       pm_runtime_disable(sspi->dev);
> > +
> > +       if (!IS_ERR(sspi->clk))
> > +               clk_disable_unprepare(sspi->clk);
> > +
>
> Same here
>
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused synquacer_spi_suspend(struct device *dev)
> > +{
> > +       struct spi_master *master = dev_get_drvdata(dev);
> > +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> > +       int ret;
> > +
> > +       ret = spi_master_suspend(master);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (!pm_runtime_suspended(dev))
> > +               if (!IS_ERR(sspi->clk))
> > +                       clk_disable_unprepare(sspi->clk);
> > +
>
> ... and here
>
> > +       return ret;
> > +}
> > +
> > +static int __maybe_unused synquacer_spi_resume(struct device *dev)
> > +{
> > +       struct spi_master *master = dev_get_drvdata(dev);
> > +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> > +       int ret;
> > +
> > +       if (!pm_runtime_suspended(dev)) {
> > +               /* Ensure reconfigure during next xfer */
> > +               sspi->speed = 0;
> > +
> > +               if (!IS_ERR(sspi->clk)) {
>
> ... and here
>
> > +                       ret = clk_prepare_enable(sspi->clk);
> > +                       if (ret < 0) {
> > +                               dev_err(dev, "failed to enable clk (%d)\n",
> > +                                       ret);
> > +                               return ret;
> > +                       }
> > +               }
> > +
> > +               ret = synquacer_spi_enable(master);
> > +               if (ret) {
> > +                       dev_err(dev, "failed to enable spi (%d)\n", ret);
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       ret = spi_master_resume(master);
> > +       if (ret < 0) {
> > +               if (!IS_ERR(sspi->clk))
> > +                       clk_disable_unprepare(sspi->clk);
>
> .. and here
>
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(synquacer_spi_pm_ops, synquacer_spi_suspend,
> > +                        synquacer_spi_resume);
> > +
> > +static const struct of_device_id synquacer_spi_of_match[] = {
> > +       {.compatible = "socionext,synquacer-spi"},
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, synquacer_spi_of_match);
> > +
> > +#ifdef CONFIG_ACPI
> > +static const struct acpi_device_id synquacer_hsspi_acpi_ids[] = {
> > +       { "SCX0004" },
> > +       { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, synquacer_hsspi_acpi_ids);
> > +#endif
> > +
> > +static struct platform_driver synquacer_spi_driver = {
> > +       .driver = {
> > +               .name = "synquacer-spi",
> > +               .pm = &synquacer_spi_pm_ops,
> > +               .of_match_table = synquacer_spi_of_match,
> > +               .acpi_match_table = ACPI_PTR(synquacer_hsspi_acpi_ids),
> > +       },
> > +       .probe = synquacer_spi_probe,
> > +       .remove = synquacer_spi_remove,
> > +};
> > +module_platform_driver(synquacer_spi_driver);
> > +
> > +MODULE_DESCRIPTION("Socionext Synquacer HS-SPI controller driver");
> > +MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
> > +MODULE_AUTHOR("Jassi Brar <jaswinder.singh@linaro.org>");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.14.2
> >
>
> With the changes above,
>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> but someone else has to review the SPI bits.
