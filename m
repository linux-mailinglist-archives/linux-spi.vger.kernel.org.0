Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61422AA59B
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 14:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgKGN6i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 08:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgKGN6h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 08:58:37 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4BFC0613CF;
        Sat,  7 Nov 2020 05:58:37 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id m65so2843395qte.11;
        Sat, 07 Nov 2020 05:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mKXTudmPumKd/Vq1ydHeQjGEim1IQ7qfp6k1HeQN0Bk=;
        b=lGq5R1g1LMr8mx0koJwiR3IFPPB5ugL0o1TEjpmtcy8HIoNKLpO8DWVZNqB46jkAE3
         feLKXxfucPp7HXIl5IZO78f06F7T/iZbh4zR58uc4iS5LeqPFw4kcK65y/8rTHrlML+y
         cDHxZdCad+hz+T7FyHjdcJvAyYwjgEFTVDjIDBtMH7dSpnIv+5iCb7vHVXzlK9j9BSLo
         oJtifz0J8go8Y+R7BuftxNqFLxTORYMEjb8I+Y23072VHWAj2bpXWTjQk92fwaqUk21S
         DO/KUwcKXkaPk4tKdLCsHgITWbbzieXHT9EoxtCw/fD9+8kPBzdN1LoEnm6hghDg3oQ0
         ZZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mKXTudmPumKd/Vq1ydHeQjGEim1IQ7qfp6k1HeQN0Bk=;
        b=ge8s3eaWMaiDtHGNfSesxruMF4vUEDv1M0HiC/+dCBY0eNKGvyHvHX4AWIIwnkQj3J
         2oezrvnL775mYph6htdJh2mHdhRnh+imqTDzfOIx9HNamK37YTV2QErP78dg1aaYDyrp
         yPHWHq0zftmnjNt3Y8F6DcCMaXW8L3MiInx98PfrxqmtlKB+KHSb7b/ZBMxiiv2fmBEq
         JaERECB49yShtKOyuDqgO/wudyUkCzSWBiztto610grY7lwWRPWnzzDWDq9CMW1gvJhh
         RDm1gQLWXKG18GSNN/7OpXVmV4uEGjRVgt3wlpVLj51o0DqIZqiJh1STvEtIo5oPLmGs
         Gzqw==
X-Gm-Message-State: AOAM532YEM+s7yEbljd0tvxIWhoZwO+a7VwGI/vAuRJKmvWWFSVqn1MF
        zuUnV4sGlg1kKZdtGxlA8r0=
X-Google-Smtp-Source: ABdhPJx5E3bQF35sPhBmBst17OQ/U+eVoba1nWe0B0FupCLdzrJTM7WfOCgSnz7EdtduetmJWx5m6w==
X-Received: by 2002:aed:308e:: with SMTP id 14mr6025577qtf.275.1604757516851;
        Sat, 07 Nov 2020 05:58:36 -0800 (PST)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id z20sm2512421qtb.31.2020.11.07.05.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 05:58:36 -0800 (PST)
Subject: Re: [PATCH 19/32] riscv: Add Kendryte K210 SoC reset controller
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-20-damien.lemoal@wdc.com>
From:   Sean Anderson <seanga2@gmail.com>
Autocrypt: addr=seanga2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFe74PkBCACoLC5Zq2gwrDcCkr+EPGsT14bsxrW07GiYzQhLCgwnPdEpgU95pXltbFhw
 46GfyffABWxHKO2x+3L1S6ZxC5AiKbYXo7lpnTBYjamPWYouz+VJEVjUx9aaSEByBah5kX6a
 lKFZWNbXLAJh+dE1HFaMi3TQXXaInaREc+aO1F7fCa2zNE75ja+6ah8L4TPRFZ2HKQzve0/Y
 GXtoRw97qmnm3U36vKWT/m2AiLF619F4T1mHvlfjyd9hrVwjH5h/2rFyroXVXBZHGA9Aj8eN
 F2si35dWSZlIwXkNu9bXp0/pIu6FD0bI+BEkD5S7aH1G1iAcMFi5Qq2RNa041DfQSDDHABEB
 AAG0K1NlYW4gR2FsbGFnaGVyIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT6JAVcEEwEK
 AEECGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSQYR1bzo1I0gPoYCg+6I/stKEQ
 bgUCXT+S2AUJB2TlXwAKCRA+6I/stKEQbhNOB/9ooea0hU9Sgh7PBloU6CgaC5mlqPLB7NTp
 +JkB+nh3Fqhk+qLZwzEynnuDLl6ESpVHIc0Ym1lyF4gT3DsrlGT1h0Gzw7vUwd1+ZfN0CuIx
 Rn861U/dAUjvbtN5kMBqOI4/5ea+0r7MACcIVnKF/wMXBD8eypHsorT2sJTzwZ6DRCNP70C5
 N1ahpqqNmXe0uLdP0pu55JCqhrGw2SinkRMdWyhSxT56uNwIVHGhLTqH7Q4t1N6G1EH626qa
 SvIJsWlNpll6Y3AYLDw2/Spw/hqieS2PQ/Ky3rPZnvJt7/aSNYsKoFGX0yjkH67Uq8Lx0k1L
 w8jpXnbEPQN3A2ZJCbeM
Message-ID: <ef434057-052a-4232-8625-5405ced41044@gmail.com>
Date:   Sat, 7 Nov 2020 08:58:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201107081420.60325-20-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 11/7/20 3:14 AM, Damien Le Moal wrote:
> Add a reset controller driver for the Kendryte K210 SoC. This driver
> relies on its syscon compatible parent node for its register mapping.
> Automatically select this driver for compilation when the SOC_KENDRYTE
> option is selected.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  arch/riscv/Kconfig.socs    |   3 +
>  drivers/reset/Kconfig      |   9 ++
>  drivers/reset/Makefile     |   1 +
>  drivers/reset/reset-k210.c | 186 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 199 insertions(+)
>  create mode 100644 drivers/reset/reset-k210.c
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index a4c851ffc6b0..4d8e66d0556a 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -31,6 +31,9 @@ config SOC_KENDRYTE
>  	select SIFIVE_PLIC
>  	select SOC_K210
>  	select CLK_K210
> +	select ARCH_HAS_RESET_CONTROLLER
> +	select RESET_CONTROLLER
> +	select RESET_K210
>  	help
>  	  This enables support for Kendryte K210 SoC platform hardware.
>  
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 07d162b179fc..c943051b5fc8 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -245,6 +245,15 @@ config RESET_ZYNQ
>  	help
>  	  This enables the reset controller driver for Xilinx Zynq SoCs.
>  
> +config RESET_K210
> +	bool "Reset controller driver for Kendryte K210 SoC"
> +	depends on RISCV && SOC_KENDRYTE
> +	depends on OF && MFD_SYSCON
> +	help
> +	  Support for the Kendryte K210 RISC-V SoC reset controller. If
> +          Say Y if you want to control reset signals provided by this
> +	  controller.
> +
>  source "drivers/reset/sti/Kconfig"
>  source "drivers/reset/hisilicon/Kconfig"
>  source "drivers/reset/tegra/Kconfig"
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 16947610cc3b..1730a31e6871 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -33,4 +33,5 @@ obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>  obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
>  obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
>  obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
> +obj-$(CONFIG_RESET_K210) += reset-k210.o
>  
> diff --git a/drivers/reset/reset-k210.c b/drivers/reset/reset-k210.c
> new file mode 100644
> index 000000000000..b6401aef2923
> --- /dev/null
> +++ b/drivers/reset/reset-k210.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
> + */
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/mfd/k210-sysctl.h>
> +#include <dt-bindings/reset/k210-rst.h>
> +
> +struct k210_rst {
> +	struct regmap *map;
> +	u32 offset;
> +	u32 mask;
> +	u32 assert_high;
> +	struct reset_controller_dev rcdev;
> +};
> +
> +static inline struct k210_rst *
> +to_k210_rst(struct reset_controller_dev *rcdev)
> +{
> +	return container_of(rcdev, struct k210_rst, rcdev);
> +}
> +
> +static inline int k210_rst_assert(struct reset_controller_dev *rcdev,
> +				  unsigned long id)
> +{
> +	struct k210_rst *ksr = to_k210_rst(rcdev);
> +	u32 bit = BIT(id);
> +
> +	if (!(bit & ksr->mask)) {
> +		dev_err(rcdev->dev, "Invalid assert id %lu\n", id);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(rcdev->dev, "assert %s %lu\n",
> +		ksr->assert_high ? "high" : "low", id);
> +
> +	regmap_update_bits(ksr->map, ksr->offset, bit,
> +			   ksr->assert_high ? bit : 0);
> +
> +	return 0;
> +}
> +
> +static inline int k210_rst_deassert(struct reset_controller_dev *rcdev,
> +				    unsigned long id)
> +{
> +	struct k210_rst *ksr = to_k210_rst(rcdev);
> +	u32 bit = BIT(id);
> +
> +	if (!(bit & ksr->mask)) {
> +		dev_err(rcdev->dev, "Invalid deassert id %lu\n", id);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(rcdev->dev, "deassert %s %lu\n",
> +		ksr->assert_high ? "high" : "low", id);
> +
> +	regmap_update_bits(ksr->map, ksr->offset, bit,
> +			   ksr->assert_high ? 0 : bit);
> +
> +	return 0;
> +}
> +
> +static int k210_rst_reset(struct reset_controller_dev *rcdev,
> +			  unsigned long id)
> +{
> +	struct k210_rst *ksr = to_k210_rst(rcdev);
> +	int ret;
> +
> +	dev_dbg(rcdev->dev, "reset %s %lu\n",
> +		ksr->assert_high ? "high" : "low", id);
> +
> +	ret = k210_rst_assert(rcdev, id);
> +	if (ret == 0) {
> +		udelay(10);
> +		ret = k210_rst_deassert(rcdev, id);
> +	}
> +
> +	return ret;
> +}
> +
> +static int k210_rst_status(struct reset_controller_dev *rcdev,
> +			   unsigned long id)
> +{
> +	struct k210_rst *ksr = to_k210_rst(rcdev);
> +	u32 reg, bit = BIT(id);
> +	int ret;
> +
> +	if (!(bit & ksr->mask)) {
> +		dev_err(rcdev->dev, "Invalid reset %lx\n", id);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(ksr->map, ksr->offset, &reg);
> +	if (ret)
> +		return ret;
> +
> +	if (ksr->assert_high)
> +		return ret & bit;
> +
> +	return !(ret & bit);
> +}
> +
> +static const struct reset_control_ops k210_rst_ops = {
> +	.assert		= k210_rst_assert,
> +	.deassert	= k210_rst_deassert,
> +	.reset		= k210_rst_reset,
> +	.status		= k210_rst_status,
> +};
> +
> +static int __init k210_rst_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct k210_rst *ksr;
> +	int ret, nr_resets;
> +
> +	dev_info(dev, "K210 reset controller\n");
> +
> +	ksr = devm_kzalloc(dev, sizeof(*ksr), GFP_KERNEL);
> +	if (!ksr)
> +		return -ENOMEM;
> +
> +	ksr->map = syscon_regmap_lookup_by_phandle(dev->of_node, "regmap");
> +	if (IS_ERR(ksr->map)) {
> +		ksr->map = syscon_node_to_regmap(dev->parent->of_node);
> +		if (IS_ERR(ksr->map)) {
> +			dev_err(dev, "get register map failed\n");
> +			return PTR_ERR(ksr->map);
> +		}
> +	}
> +
> +	ret = of_property_read_u32(dev->of_node, "offset", &ksr->offset);
> +	ret = of_property_read_u32(dev->of_node, "assert-high",
> +				   &ksr->assert_high);
> +	if (ret) {
> +		dev_err(dev, "unable to read 'offset' and 'assert-high'\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32(dev->of_node, "mask", &ksr->mask);
> +	if (ret) {
> +		/* Use default mask */
> +		ksr->mask = 0x27FFFFFF;
> +	}
> +	nr_resets = fls(ksr->mask);
> +	if (!nr_resets) {
> +		dev_err(dev, "Invalid mask 0x%08x\n", ksr->mask);
> +		return -EINVAL;
> +	}
> +
> +	ksr->rcdev.owner = THIS_MODULE;
> +	ksr->rcdev.dev = dev;
> +	ksr->rcdev.of_node = dev->of_node;
> +	ksr->rcdev.nr_resets = nr_resets;
> +	ksr->rcdev.ops = &k210_rst_ops;
> +
> +	return devm_reset_controller_register(dev, &ksr->rcdev);
> +}
> +
> +static const struct of_device_id k210_rst_dt_ids[] = {
> +	{ .compatible = "kendryte,k210-rst" },
> +};
> +
> +static struct platform_driver k210_rst_driver = {
> +	.probe	= k210_rst_probe,
> +	.driver = {
> +		.name		= "k210-rst",
> +		.of_match_table	= k210_rst_dt_ids,
> +	},
> +};
> +
> +/*
> + * Most devices on the K210 SoC need reset as part of their initialization.
> + * So initialize this driver early as part of the post core initialization.
> + */
> +static int __init k210_rst_init(void)
> +{
> +	return platform_driver_register(&k210_rst_driver);
> +}
> +postcore_initcall(k210_rst_init);
> 

Reviewed-by: Sean Anderson <seanga2@gmail.com>
