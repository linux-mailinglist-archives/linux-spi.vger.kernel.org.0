Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED55C2F7D1
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2019 09:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfE3HRU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 May 2019 03:17:20 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38898 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfE3HRT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 May 2019 03:17:19 -0400
Received: by mail-it1-f194.google.com with SMTP id i63so3517193ita.3
        for <linux-spi@vger.kernel.org>; Thu, 30 May 2019 00:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m31V4n0Xf70QgAcOhGgYxIfnGQgroLYzf7s4K8TO7Ew=;
        b=FowKxUgPcNlyXPOJRdyksYyX9Xyr7rP8ObJo8cKGHS+tyKa4Xqq/tbCWA//yBsQJUR
         cDb1nFvILcdhPDhONg5fZt4RTL8NIcp+uwqwLVHNAePWLdXcPb1FNcPFbrCEB6q9NClh
         Rig1EOscg4fsLAakltfpa1RCagKCi/oswFaF6w4eJH2OohspwmLs3RaG9934np/4tLIR
         +a4TUsVIWtW9UfkEy6CeO8TAx+GZ5imba9CJyB8vD92yCT7qfX+L27Ewcletfixc2TJq
         TifToIurTotQ2Ieges1R4X3ScenOGhYNoLXRPJEplKw5L8c21mc9i85xaIC+hoJcXMJu
         TLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m31V4n0Xf70QgAcOhGgYxIfnGQgroLYzf7s4K8TO7Ew=;
        b=aXpGYyYtzcjbWcEh0570kWwfWzZFZTKX3Va+MqxL6KgHiUUrHfTiihC97dBEn1w0EC
         LRkSs1I5srCZw649CUm1KghFhLpVhPJmfs/VYnIiyGlQpseyIbGkrBKZ3WsZa0D5UGiE
         JkyZtXad9mBJPCETUqe3WFK3z7JIvI/fm4FWV8inLVK4H11yQj+eHPnt0/cbtWTBwnBw
         L0/nu5dUFiyOS0k1ondjNWISZyfg/+PRHbux5cSbR1Ffixn/YHtZgWpon/JacidvkGEh
         IakvY5eLfRxyuJKPtR1yv/Cf0nlDEFAXw2Pzk66B3GzR14+FsKLIlfLokHwt9gKB/O4C
         XQVw==
X-Gm-Message-State: APjAAAXLTubsLg3ivGm9dCunMWVmSHdgDLcGP5+El3x1LbRf6NP0hunO
        mBfut0GZs5CjNd7FqoI1MfSdS4igd6auI3g4WWOJ+Q==
X-Google-Smtp-Source: APXvYqwkTTzozkfVG1XyadB0VFTq9I2nZy8IFRQlqAybhUGCvbs9IKCK47cFvezUi2XN+0jlL+uzzF1OovMkAtn/GFA=
X-Received: by 2002:a24:1614:: with SMTP id a20mr1620840ita.153.1559200638719;
 Thu, 30 May 2019 00:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190528092713.10516-1-masahisa.kojima@linaro.org> <20190528092713.10516-4-masahisa.kojima@linaro.org>
In-Reply-To: <20190528092713.10516-4-masahisa.kojima@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 30 May 2019 09:16:58 +0200
Message-ID: <CAKv+Gu9pqkDoB9WKCdqab6Tcy58KcCRZJRUw_8Z9mh7KNzRT=g@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] spi: Add spi driver for Socionext Synquacer platform
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     linux-spi@vger.kernel.org,
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

On Tue, 28 May 2019 at 11:27, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> This patch adds support for controller found on synquacer platforms.
>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  drivers/spi/Kconfig         |  11 +
>  drivers/spi/Makefile        |   1 +
>  drivers/spi/spi-synquacer.c | 826 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 838 insertions(+)
>  create mode 100644 drivers/spi/spi-synquacer.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 0fba8f400c59..24a3eac72d12 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -732,6 +732,17 @@ config SPI_SUN6I
>         help
>           This enables using the SPI controller on the Allwinner A31 SoCs.
>
> +config SPI_SYNQUACER
> +       tristate "Socionext's Synquacer HighSpeed SPI controller"
> +       depends on ARCH_SYNQUACER || COMPILE_TEST
> +       select SPI_BITBANG

Do we really need this dependency?

> +       help
> +         SPI driver for Socionext's High speed SPI controller which provides
> +         various operating modes for interfacing to serial peripheral devices
> +         that use the de-facto standard SPI protocol.
> +
> +         It also supports the new dual-bit and quad-bit SPI protocol.
> +
>  config SPI_MXIC
>          tristate "Macronix MX25F0A SPI controller"
>          depends on SPI_MASTER
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index f2f78d03dc28..63dcab552bcb 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -106,6 +106,7 @@ obj-$(CONFIG_SPI_STM32_QSPI)                += spi-stm32-qspi.o
>  obj-$(CONFIG_SPI_ST_SSC4)              += spi-st-ssc4.o
>  obj-$(CONFIG_SPI_SUN4I)                        += spi-sun4i.o
>  obj-$(CONFIG_SPI_SUN6I)                        += spi-sun6i.o
> +obj-$(CONFIG_SPI_SYNQUACER)            += spi-synquacer.o
>  obj-$(CONFIG_SPI_TEGRA114)             += spi-tegra114.o
>  obj-$(CONFIG_SPI_TEGRA20_SFLASH)       += spi-tegra20-sflash.o
>  obj-$(CONFIG_SPI_TEGRA20_SLINK)                += spi-tegra20-slink.o
> diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
> new file mode 100644
> index 000000000000..27a9babaffc0
> --- /dev/null
> +++ b/drivers/spi/spi-synquacer.c
> @@ -0,0 +1,826 @@
...
> +static int synquacer_spi_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct spi_master *master;
> +       struct synquacer_spi *sspi;
> +       int ret;
> +       int rx_irq, tx_irq;
> +
> +       master = spi_alloc_master(&pdev->dev, sizeof(*sspi));
> +       if (!master)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, master);
> +
> +       sspi = spi_master_get_devdata(master);
> +       sspi->dev = &pdev->dev;
> +
> +       init_completion(&sspi->transfer_done);
> +
> +       sspi->regs = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(sspi->regs)) {
> +               ret = PTR_ERR(sspi->regs);
> +               goto put_spi;
> +       }
> +
> +       sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IHCLK; /* Default */
> +       device_property_read_u32(&pdev->dev, "socionext,ihclk-rate",
> +                                &master->max_speed_hz); /* for ACPI */
> +
> +       if (dev_of_node(&pdev->dev)) {
> +               if (device_property_match_string(&pdev->dev,
> +                                        "clock-names", "iHCLK") >= 0) {
> +                       sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IHCLK;
> +                       sspi->clk = devm_clk_get(sspi->dev, "iHCLK");
> +               } else if (device_property_match_string(&pdev->dev,
> +                                               "clock-names", "iPCLK") >= 0) {
> +                       sspi->clk_src_type = SYNQUACER_HSSPI_CLOCK_SRC_IPCLK;
> +                       sspi->clk = devm_clk_get(sspi->dev, "iPCLK");
> +               } else {
> +                       dev_err(&pdev->dev, "specified wrong clock source\n");
> +                       ret = -EINVAL;
> +                       goto put_spi;
> +               }
> +               if (IS_ERR(sspi->clk)) {

You could have received an -EPROBE_DEFER return value here, in which
case you should not print an error and just return.

> +                       dev_err(&pdev->dev, "clock not found\n");
> +                       ret = PTR_ERR(sspi->clk);
> +                       goto put_spi;
> +               }
> +
> +               ret = clk_prepare_enable(sspi->clk);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "failed to enable clock (%d)\n",
> +                               ret);
> +                       goto put_spi;
> +               }
> +
> +               master->max_speed_hz = clk_get_rate(sspi->clk);
> +       }
> +
> +       if (!master->max_speed_hz) {
> +               dev_err(&pdev->dev, "missing clock source\n");
> +               return -EINVAL;
> +       }
> +       master->min_speed_hz = master->max_speed_hz / 254;
> +
> +       sspi->aces = device_property_read_bool(&pdev->dev,
> +                                              "socionext,set-aces");
> +       sspi->rtm = device_property_read_bool(&pdev->dev, "socionext,use-rtm");
> +
> +       master->num_chipselect = SYNQUACER_HSSPI_NUM_CHIP_SELECT;
> +
> +       rx_irq = platform_get_irq(pdev, 0);
> +       if (rx_irq < 0) {

<= 0

> +               dev_err(&pdev->dev, "get rx_irq failed (%d)\n", rx_irq);
> +               ret = rx_irq;
> +               goto put_spi;
> +       }
> +       snprintf(sspi->rx_irq_name, SYNQUACER_HSSPI_IRQ_NAME_MAX, "%s-%s",

Why not just use "%s-rx" as the format string?

> +                dev_name(&pdev->dev), "rx");
> +       ret = devm_request_irq(&pdev->dev, rx_irq, sq_spi_rx_handler,
> +                               0, sspi->rx_irq_name, sspi);
> +       if (ret) {
> +               dev_err(&pdev->dev, "request rx_irq failed (%d)\n", ret);
> +               goto put_spi;
> +       }
> +
> +       tx_irq = platform_get_irq(pdev, 1);
> +       if (tx_irq < 0) {

<= 0

> +               dev_err(&pdev->dev, "get tx_irq failed (%d)\n", tx_irq);
> +               ret = tx_irq;
> +               goto put_spi;
> +       }
> +       snprintf(sspi->tx_irq_name, SYNQUACER_HSSPI_IRQ_NAME_MAX, "%s-%s",

Likewise

> +                dev_name(&pdev->dev), "tx");
> +       ret = devm_request_irq(&pdev->dev, tx_irq, sq_spi_tx_handler,
> +                               0, sspi->tx_irq_name, sspi);
> +       if (ret) {
> +               dev_err(&pdev->dev, "request tx_irq failed (%d)\n", ret);
> +               goto put_spi;
> +       }
> +
> +       master->dev.of_node = np;

please add

master->dev.fwnode = pdev->dev.fwnode;

here as well

> +       master->auto_runtime_pm = true;
> +       master->bus_num = pdev->id;
> +
> +       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_DUAL | SPI_RX_DUAL |
> +                           SPI_TX_QUAD | SPI_RX_QUAD;
> +       master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(24) |
> +                                    SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
> +
> +       master->set_cs = synquacer_spi_set_cs;
> +       master->transfer_one = synquacer_spi_transfer_one;
> +
> +       ret = synquacer_spi_enable(master);
> +       if (ret)
> +               goto fail_enable;
> +
> +       pm_runtime_set_active(sspi->dev);
> +       pm_runtime_enable(sspi->dev);
> +
> +       ret = devm_spi_register_master(sspi->dev, master);
> +       if (ret)
> +               goto disable_pm;
> +
> +       return 0;
> +
> +disable_pm:
> +       pm_runtime_disable(sspi->dev);
> +fail_enable:
> +       if (!IS_ERR(sspi->clk))

You can drop this check: clk_disable_unprepare() already ignores NULL
or ERR values.

> +               clk_disable_unprepare(sspi->clk);
> +put_spi:
> +       spi_master_put(master);
> +
> +       return ret;
> +}
> +
> +static int synquacer_spi_remove(struct platform_device *pdev)
> +{
> +       struct spi_master *master = platform_get_drvdata(pdev);
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +
> +       pm_runtime_disable(sspi->dev);
> +
> +       if (!IS_ERR(sspi->clk))
> +               clk_disable_unprepare(sspi->clk);
> +

Same here

> +       return 0;
> +}
> +
> +static int __maybe_unused synquacer_spi_suspend(struct device *dev)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +       int ret;
> +
> +       ret = spi_master_suspend(master);
> +       if (ret)
> +               return ret;
> +
> +       if (!pm_runtime_suspended(dev))
> +               if (!IS_ERR(sspi->clk))
> +                       clk_disable_unprepare(sspi->clk);
> +

... and here

> +       return ret;
> +}
> +
> +static int __maybe_unused synquacer_spi_resume(struct device *dev)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +       struct synquacer_spi *sspi = spi_master_get_devdata(master);
> +       int ret;
> +
> +       if (!pm_runtime_suspended(dev)) {
> +               /* Ensure reconfigure during next xfer */
> +               sspi->speed = 0;
> +
> +               if (!IS_ERR(sspi->clk)) {

... and here

> +                       ret = clk_prepare_enable(sspi->clk);
> +                       if (ret < 0) {
> +                               dev_err(dev, "failed to enable clk (%d)\n",
> +                                       ret);
> +                               return ret;
> +                       }
> +               }
> +
> +               ret = synquacer_spi_enable(master);
> +               if (ret) {
> +                       dev_err(dev, "failed to enable spi (%d)\n", ret);
> +                       return ret;
> +               }
> +       }
> +
> +       ret = spi_master_resume(master);
> +       if (ret < 0) {
> +               if (!IS_ERR(sspi->clk))
> +                       clk_disable_unprepare(sspi->clk);

.. and here

> +       }
> +
> +       return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(synquacer_spi_pm_ops, synquacer_spi_suspend,
> +                        synquacer_spi_resume);
> +
> +static const struct of_device_id synquacer_spi_of_match[] = {
> +       {.compatible = "socionext,synquacer-spi"},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, synquacer_spi_of_match);
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id synquacer_hsspi_acpi_ids[] = {
> +       { "SCX0004" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, synquacer_hsspi_acpi_ids);
> +#endif
> +
> +static struct platform_driver synquacer_spi_driver = {
> +       .driver = {
> +               .name = "synquacer-spi",
> +               .pm = &synquacer_spi_pm_ops,
> +               .of_match_table = synquacer_spi_of_match,
> +               .acpi_match_table = ACPI_PTR(synquacer_hsspi_acpi_ids),
> +       },
> +       .probe = synquacer_spi_probe,
> +       .remove = synquacer_spi_remove,
> +};
> +module_platform_driver(synquacer_spi_driver);
> +
> +MODULE_DESCRIPTION("Socionext Synquacer HS-SPI controller driver");
> +MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
> +MODULE_AUTHOR("Jassi Brar <jaswinder.singh@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.14.2
>

With the changes above,

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

but someone else has to review the SPI bits.
