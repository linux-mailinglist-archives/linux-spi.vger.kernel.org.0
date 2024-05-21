Return-Path: <linux-spi+bounces-2982-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B30658CAE95
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 14:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC05284BCF
	for <lists+linux-spi@lfdr.de>; Tue, 21 May 2024 12:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444FA74E0A;
	Tue, 21 May 2024 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fn7TJR7J"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A976F1B;
	Tue, 21 May 2024 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295917; cv=none; b=WRyXzUcnMMYJLtU4qNYUI1dA+9CpJ3eu8g3EC6cmu8zm1wKrL/2YYoPtTzIlh1bZ/oSOcAZeaPFWXuVpUBX7/SoX2yLOx1wDQKM3WEAq+s2ZtWuoMusXWGwyCwDzCJtiye9Bddl6Gimc/wEJRiX+A+bDB2lkNDjTP3A600ub/uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295917; c=relaxed/simple;
	bh=icE+zgucSAptcZJ5/Z+UxeRoHsi5nzBe52cwqZkMHr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnXuf3xaD98fGgufBivA9J9qfvXtyPMol58P9io80aidyzJDNSeZj1H6hTbCEC5Yi5aUhNl+CcHjgYgI/p6vRPDMZjru9A0q/Gw8HLudpf2H9lYXQyJmbmsR9fv4z2vjsbfM/Gzbbw7+yeMSFPOwO8hRmCgwwk+yxM6Tpc82sLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fn7TJR7J; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 755B4C0003;
	Tue, 21 May 2024 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716295906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Omcb3hmFzLM0PKq5FT4qc5DXx74BroUN9lLWyMAGIEY=;
	b=Fn7TJR7Jra9ZpK15bDB3o7qBNfTwpcPl6DSumQgmazugCe/z6ztB/P2qDSdecb5kXB7nKL
	G1yy4xnzlpow7F1p7Rpot/bSF1ozu0Ke+Wmn6plg6tUO9Y4W7b9+lxm+qXWE8GMlYNfgh6
	XJjyG85wHN8TsOucgowOWTvjT4Li7audLDxSPZP9Nq3jA6ztOVxo+H1i6wDGQeQeh42vBy
	Uvtjt9SQbm8pSD1dsZgNVQeRF1rd/TNTkXvlvbp4UFfn21HeyJTGLJVY2fXOgEqUXp8387
	oMjC2bM0amVfzhfXLVJqB/cefM0SqvskRRUr2rLzOpwZv3uSZZS2yxYxqH+/Nw==
Date: Tue, 21 May 2024 14:51:40 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 richard@nod.at, vigneshr@ti.com, manivannan.sadhasivam@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, quic_srichara@quicinc.com,
 quic_varada@quicinc.com
Subject: Re: [PATCH v6 4/8] drivers: mtd: nand: Add qpic_common API file
Message-ID: <20240521145140.5cb49946@xps-13>
In-Reply-To: <20240521105532.1537845-5-quic_mdalam@quicinc.com>
References: <20240521105532.1537845-1-quic_mdalam@quicinc.com>
	<20240521105532.1537845-5-quic_mdalam@quicinc.com>
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

Hi,

>  drivers/mtd/nand/Makefile            |    4 +-
>  drivers/mtd/nand/qpic_common.c       |  740 +++++++++++++++++
>  drivers/mtd/nand/raw/qcom_nandc.c    | 1090 +-------------------------
>  include/linux/mtd/nand-qpic-common.h |  467 +++++++++++
>  4 files changed, 1222 insertions(+), 1079 deletions(-)
>  create mode 100644 drivers/mtd/nand/qpic_common.c
>  create mode 100644 include/linux/mtd/nand-qpic-common.h
>=20
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index 19e1291ac4d5..e59106e0a3af 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -3,7 +3,9 @@
>  nandcore-objs :=3D core.o bbt.o
>  obj-$(CONFIG_MTD_NAND_CORE) +=3D nandcore.o
>  obj-$(CONFIG_MTD_NAND_ECC_MEDIATEK) +=3D ecc-mtk.o
> -
> +ifeq ($(CONFIG_MTD_NAND_QCOM),y)
> +obj-y	+=3D qpic_common.o
> +endif

Breaks if you set CONFIG_MTD_NAND_QCOM =3D m

>  obj-y	+=3D onenand/
>  obj-y	+=3D raw/
>  obj-y	+=3D spi/
> diff --git a/drivers/mtd/nand/qpic_common.c b/drivers/mtd/nand/qpic_commo=
n.c
> new file mode 100644
> index 000000000000..dfbbb5f626b6
> --- /dev/null
> +++ b/drivers/mtd/nand/qpic_common.c
> @@ -0,0 +1,740 @@
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

Didn't you say you would remove that include?

Thanks,
Miqu=C3=A8l

