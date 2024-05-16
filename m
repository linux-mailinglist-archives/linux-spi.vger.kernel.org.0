Return-Path: <linux-spi+bounces-2863-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D308C7697
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 14:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8FE281175
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2024 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915F4145B0B;
	Thu, 16 May 2024 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y8vovFk3"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E2C1E511;
	Thu, 16 May 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863082; cv=none; b=jcg/Plctlgno473CLODoApPyJ2d1a9Ioh0Z/SIwTeh433vGBwFPD7mrnbMjnHwKDVOchB3ZghJ8GqAlIINf03XyX/zwVlGZlXxfMTgF4yBLa77EdOIdQUWKAk5jXBBfvGv/isvvPoKSDgJ/ai10204lay3bUS0LwD5mf8R1/d/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863082; c=relaxed/simple;
	bh=GBIWyZ3c4f4UnYM7hn+XFJ9uS7Ayf/152KOhFezWhn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQFGKRy0XF7erdkQJF5YPQiwsFVsXKbHhqUb7DbkLGZvtWWLm8QkqucwEfXi0J9RzCO1GUfaJk535GdSCiHkLTBaEohfVBizYWKCdLRKSyBCXIHYZS9cDYXShJOXGoLLKKJolnSDxfdBC/qlVUx+4KG+J6nYB0vSxRWQ+DZ6Djk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y8vovFk3; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EC60B24000E;
	Thu, 16 May 2024 12:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715863071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2IJp/lOWwL7BaonI5QmnyhkYo/GQ2MhT9mFOjFAyKo=;
	b=Y8vovFk3HOSEwSLHAci+g/leO4eYGpTKlxO3HSM0Bc4rI4WhmVHdF1xjJ7BVx5vFJZqCnG
	TMMC3gi3cOZj3yN92T9Ho5Ub8cxzO5G8AaeTxv755Ih4s8uipRi78fKXzbkJMm0D1M3ure
	RDxdyw9NUbPlWUabLN9VJQilSj0J1i3gDRtvWBmuo5w62qtuqrsLm8JvKiucWc8IClHve5
	B88JH/AX5p7YWuIv2OcnU9nZYrp1zWmlc2MEL8Y60dEV9f25b9+DGFHWF9BlV3RGjgLI6j
	A2queElZnkS3uUKXom5FI7PgMpGfhCgvTIeosHsRrYPhzs+5HUNadmSNxSeAvA==
Date: Thu, 16 May 2024 14:37:48 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 richard@nod.at, vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, quic_srichara@quicinc.com,
 quic_varada@quicinc.com, Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: Re: [PATCH v5 4/7] drivers: mtd: nand: Add qpic_common API file
Message-ID: <20240516143748.2aa6de80@xps-13>
In-Reply-To: <20240508083637.3744003-5-quic_mdalam@quicinc.com>
References: <20240508083637.3744003-1-quic_mdalam@quicinc.com>
	<20240508083637.3744003-5-quic_mdalam@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -61,6 +61,14 @@ config MTD_NAND_ECC_MEDIATEK
>  	help
>  	  This enables support for the hardware ECC engine from Mediatek.
> =20
> +config QPIC_COMMON
> +	tristate "QPIC common api file"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  This enables support for common api for qpic nand controller.
> +	  common apis will be used by both raw nand driver and serial nand
> +	  driver.

This should probably not be a standalone selectable item. Make it
automatically selected by the users including the common header.

> +
>  endmenu
> =20
>  endmenu
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index 19e1291ac4d5..c0c1f8bd0220 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -3,6 +3,7 @@
>  nandcore-objs :=3D core.o bbt.o
>  obj-$(CONFIG_MTD_NAND_CORE) +=3D nandcore.o
>  obj-$(CONFIG_MTD_NAND_ECC_MEDIATEK) +=3D ecc-mtk.o
> +obj-$(CONFIG_QPIC_COMMON) +=3D qpic_common.o
> =20
>  obj-y	+=3D onenand/
>  obj-y	+=3D raw/
> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_commo=
n.c
> new file mode 100644
> index 000000000000..d48892141365
> --- /dev/null
> +++ b/drivers/mtd/nand/qpic_common.c
> @@ -0,0 +1,741 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
> + */
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma/qcom_adm.h>
> +#include <linux/dma/qcom_bam_dma.h>
> +#include <linux/module.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/rawnand.h>

No raw NAND include in the common file. If there is something raw NAND
specific, it should not be here.

> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/mtd/nand-qpic-common.h>

Thanks,
Miqu=C3=A8l

