Return-Path: <linux-spi+bounces-10969-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EF7C2974E
	for <lists+linux-spi@lfdr.de>; Sun, 02 Nov 2025 22:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 742E44E034D
	for <lists+linux-spi@lfdr.de>; Sun,  2 Nov 2025 21:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332EF1DE3A4;
	Sun,  2 Nov 2025 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="jQmS/STx"
X-Original-To: linux-spi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD4BA45;
	Sun,  2 Nov 2025 21:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119705; cv=pass; b=Jj0xSJtMgU6B+L+HzJkMkT/PXiCdPuGXUxhpH1qEKBNX40VEKTHYPYjNhmvw7wgre3ap8Nz/HKO+YPKAYaDVbfd8dIj+d++zRsEaqAPlEzFFRvVsHnsqbORrJY2TYuRqwR++7TonwQR3pU5rI174LLU/Usos755Use4g+k07vvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119705; c=relaxed/simple;
	bh=yj5jv6qws0AK+OrvvRxVe3RtYYFaSHwdmeDIuoel4+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5t9I65W6ievI3BeOwWs5wddjFnRw5Pvt6aoLoJSqKwpEAHagFuHiyVEMUsSP61vKoAozzGIpvvJqIODynIw+cgQKleCiByHYDIvaHnKRfsdTZDv0rubH4ob3mB8eBul25OGBrTX2GTvsFFcTUuy4MvECNbwSEFlJyvnTGycj5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=jQmS/STx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762119687; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ABB+56HZ7qn1KmVWZZY5LRPHfTTnj6eNeEkgHRsfVe82VYvwcgyUYOltYR3PaUD9fSb+RUqWNXNtIi/sxIMHp7x9/y01JQ6SwbyP4/0XCdnBAZJzpQlTqEE/EMfKaw1TcFBYP9iFJwPJCQXbkYd2lzEqN69KvPfFqNgt6mYctZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762119687; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=etIaDZzEoMN+1wq9IfBUL9NKOUN82tlDPPxEr6WHWuk=; 
	b=mxoGCDUziziLWkqOeajNg+AT0qnQfEeB01q/3yfFe0DHEJNgE26IitwyjRtPla9jNQLmD30ED18J6WaBbHBXAWepUhz5iDRMENRzgbx0gPX/KB9px5svtAffXtNeC2heklVDhQcMuzgJkKVZIUrJlLyj9eE90HFXnibL0hbYPhk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762119687;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=etIaDZzEoMN+1wq9IfBUL9NKOUN82tlDPPxEr6WHWuk=;
	b=jQmS/STxEIAsGCEmibOu/3+wUE84BNrhRRBFfKf9DBiv7AwryCKoRgtfogvjQxLx
	YAnf/iKlv+EQBHxA0NgzJpUxoWp/85qCGLSwrzXktL2GH30qHMbtjsVGnXIEnd9fJLd
	l1yorqzlve+Y3v8yKk0c+XSoMll8SIr1zfkUdB/8=
Received: by mx.zohomail.com with SMTPS id 1762119685630153.93783567988442;
	Sun, 2 Nov 2025 13:41:25 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 15EB4180CDA; Sun, 02 Nov 2025 22:41:15 +0100 (CET)
Date: Sun, 2 Nov 2025 22:41:15 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Cc: Lee Jones <lee@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] power: reset: sc27xx: Drop unused driver
Message-ID: <kkmidihu45exxt35wrb4r2i4vehixsfsn6vlgmcgxocqeyno4a@uwlmcrjnqsgq>
References: <20251007-sc27xx-mfd-poweroff-v1-0-89a2f919b731@abscue.de>
 <20251007-sc27xx-mfd-poweroff-v1-3-89a2f919b731@abscue.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20251007-sc27xx-mfd-poweroff-v1-3-89a2f919b731@abscue.de>
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hi,

On Tue, Oct 07, 2025 at 08:14:21PM +0200, Otto Pfl=FCger wrote:
> This driver was never actually probed because it was missing an OF matc=
h
> table and was not integrated into the MFD driver. Remove it now that th=
e
> power off functionality is handled directly in the MFD driver.
>=20
> Signed-off-by: Otto Pfl=FCger <otto.pflueger@abscue.de>

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/reset/Kconfig           |  9 ----
>  drivers/power/reset/Makefile          |  1 -
>  drivers/power/reset/sc27xx-poweroff.c | 79 ---------------------------=
--------
>  3 files changed, 89 deletions(-)
>=20
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 8248895ca90389c1db33c7b09e5f5925a9034cee..c4a28f6f04f6be13d20ce2b=
08427fd1679b1df5a 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -320,15 +320,6 @@ config SYSCON_REBOOT_MODE
>  	  register, then the bootloader can read it to take different
>  	  action according to the mode.
> =20
> -config POWER_RESET_SC27XX
> -	tristate "Spreadtrum SC27xx PMIC power-off driver"
> -	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> -	help
> -	  This driver supports powering off a system through
> -	  Spreadtrum SC27xx series PMICs. The SC27xx series
> -	  PMICs includes the SC2720, SC2721, SC2723, SC2730
> -	  and SC2731 chips.
> -
>  config NVMEM_REBOOT_MODE
>  	tristate "Generic NVMEM reboot mode driver"
>  	depends on OF
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefil=
e
> index 51da87e05ce76bc608d961485063555c3ba5d96c..cabaa0de2de68794bea5f95=
23855bb9ef0083ef0 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -37,6 +37,5 @@ obj-$(CONFIG_POWER_RESET_SYSCON_POWEROFF) +=3D syscon=
-poweroff.o
>  obj-$(CONFIG_POWER_RESET_RMOBILE) +=3D rmobile-reset.o
>  obj-$(CONFIG_REBOOT_MODE) +=3D reboot-mode.o
>  obj-$(CONFIG_SYSCON_REBOOT_MODE) +=3D syscon-reboot-mode.o
> -obj-$(CONFIG_POWER_RESET_SC27XX) +=3D sc27xx-poweroff.o
>  obj-$(CONFIG_NVMEM_REBOOT_MODE) +=3D nvmem-reboot-mode.o
>  obj-$(CONFIG_POWER_MLXBF) +=3D pwr-mlxbf.o
> diff --git a/drivers/power/reset/sc27xx-poweroff.c b/drivers/power/rese=
t/sc27xx-poweroff.c
> deleted file mode 100644
> index 90287c31992c4889f9241e82a21a1949ecca7702..00000000000000000000000=
00000000000000000
> --- a/drivers/power/reset/sc27xx-poweroff.c
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2018 Spreadtrum Communications Inc.
> - * Copyright (C) 2018 Linaro Ltd.
> - */
> -
> -#include <linux/cpu.h>
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
> -#include <linux/pm.h>
> -#include <linux/regmap.h>
> -#include <linux/syscore_ops.h>
> -
> -#define SC27XX_PWR_PD_HW	0xc2c
> -#define SC27XX_PWR_OFF_EN	BIT(0)
> -#define SC27XX_SLP_CTRL		0xdf0
> -#define SC27XX_LDO_XTL_EN	BIT(3)
> -
> -static struct regmap *regmap;
> -
> -/*
> - * On Spreadtrum platform, we need power off system through external S=
C27xx
> - * series PMICs, and it is one similar SPI bus mapped by regmap to acc=
ess PMIC,
> - * which is not fast io access.
> - *
> - * So before stopping other cores, we need release other cores' resour=
ce by
> - * taking cpus down to avoid racing regmap or spi mutex lock when powe=
roff
> - * system through PMIC.
> - */
> -static void sc27xx_poweroff_shutdown(void)
> -{
> -#ifdef CONFIG_HOTPLUG_CPU
> -	int cpu;
> -
> -	for_each_online_cpu(cpu) {
> -		if (cpu !=3D smp_processor_id())
> -			remove_cpu(cpu);
> -	}
> -#endif
> -}
> -
> -static struct syscore_ops poweroff_syscore_ops =3D {
> -	.shutdown =3D sc27xx_poweroff_shutdown,
> -};
> -
> -static void sc27xx_poweroff_do_poweroff(void)
> -{
> -	/* Disable the external subsys connection's power firstly */
> -	regmap_write(regmap, SC27XX_SLP_CTRL, SC27XX_LDO_XTL_EN);
> -
> -	regmap_write(regmap, SC27XX_PWR_PD_HW, SC27XX_PWR_OFF_EN);
> -}
> -
> -static int sc27xx_poweroff_probe(struct platform_device *pdev)
> -{
> -	if (regmap)
> -		return -EINVAL;
> -
> -	regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> -	if (!regmap)
> -		return -ENODEV;
> -
> -	pm_power_off =3D sc27xx_poweroff_do_poweroff;
> -	register_syscore_ops(&poweroff_syscore_ops);
> -	return 0;
> -}
> -
> -static struct platform_driver sc27xx_poweroff_driver =3D {
> -	.probe =3D sc27xx_poweroff_probe,
> -	.driver =3D {
> -		.name =3D "sc27xx-poweroff",
> -	},
> -};
> -module_platform_driver(sc27xx_poweroff_driver);
> -
> -MODULE_DESCRIPTION("Power off driver for SC27XX PMIC Device");
> -MODULE_AUTHOR("Baolin Wang <baolin.wang@unisoc.com>");
> -MODULE_LICENSE("GPL v2");
>=20
> --=20
> 2.50.0
>=20

