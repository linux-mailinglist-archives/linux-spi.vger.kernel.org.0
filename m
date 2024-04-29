Return-Path: <linux-spi+bounces-2578-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8488B542A
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 11:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58901F21082
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 09:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA06225D9;
	Mon, 29 Apr 2024 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYl9GtHq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84EA10A13;
	Mon, 29 Apr 2024 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382559; cv=none; b=VUTL1/JZVXyHbCsslnUqeAQtGSaJKvBwHe9JM2BnHkwGTxoO4r95Rzh6Brp/zC/g/3LK8Pv0g/qD0VFL9uAxpnGWqecesQexF2YiZg6pEB7O7c5yG96Fudorrd5d7LIpxy+KWscy5eXO7CUJQGOL9vjY6JY928nqEEjnEPmpbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382559; c=relaxed/simple;
	bh=uRso8OTIDgSi6hlihdnvz6u6dS4eEVLxFjwCiEFqXJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qV0T08GMLPw/5NRK7/B13cqWwa/qyhEWD0/JYi7CAKYBvMM/8vRfQbqzUK02jFw6IElWUvEm+pNNe1rN4ReI76cRbUh2TnRBt+oCQRZwdZKCgF2cWv/jePr7Sy8LG2fv6jHrvz7R+OdlCD1MXRuddBVr7ykm4MUTcaHEJtauHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYl9GtHq; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5709cb80b03so4109524a12.2;
        Mon, 29 Apr 2024 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714382556; x=1714987356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P06jmw+kKM6TGfkhUGkzKJO5qkuqhaUT7dHJDv+GMuM=;
        b=QYl9GtHqHxqcZCTGV88nzA/PT9NdHgOSLnoxnuv6pmqLx4YVxYEPu5MnL5BZbgGG4w
         99TC7tcwEJj1MNwp0qZxEmKi4C5VZ/jvVp0oBkFB3Ez1kr6FJt8AqHhTWFLwCkBhLXnF
         w24inzDSeJF2mrbWxmhD3gcAX60lbuxD6/RO/koQzb8x6zn4xk9FJsaSMwViTeIFJTLa
         DzxC/PXZHEwjHeRiYCSwdn8NlnLtSO0Br1O15OsGufYHZO2FgtcmwpBTBCbkdJ8UjJf+
         0vPmMwKjhBOASz7xa5kT6ue4W8W6Cp3ruYEBo/IR4DYspy7UFed743+wFbyWQJFbuLfM
         kchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714382556; x=1714987356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P06jmw+kKM6TGfkhUGkzKJO5qkuqhaUT7dHJDv+GMuM=;
        b=HBbxYYDanX+AGeyhe9LzTZw8LETiSiZk3ZeqzYeReqEK8QpevSuZbdGcrIZk3O2Y1A
         T+cgRjr8guZL7b6xzLO3NR5S7hx38Akpg/CaZE/TPkQzAVNHtsjVgb9s+SkrwZ1Xkbk/
         pSi6Ad3WazNzPvSEACeX2EZqfUu66INVRSh5etN/TaIegcDcChGPlrfGqO073UI6Vkh8
         XxmHOdJy41TWxbCaev6zwDoqUrAzaJIVmWeSd0hURx60cuwEtzdxwvzSP0p4xxMTBpSh
         4HfjCyqWWE/deCLt3bAg0mtUxbOrsljejU8CgC9Bh9oGMVP3Bgl7h9esoOhZ664AIX0S
         uYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW11lzUkO6yd4iHIVGpPfB9oLA2MfNCJAUAFgm50jZMZ1HSo3RUCWFl6RnhrbkkoV3RvpFqgLpjAapQFcG6L8Us8GaCv2weWHtiiw==
X-Gm-Message-State: AOJu0Yx4GqSf/TknK2Y5FkUDPCh0rlfuvu1PDRX2oWPliUFOjzXkJDrA
	eG5YlwUljI33l7566Y5GEFSG/Cd6zfMhDtsS/Wm8t4mDzbq/B7t1d4SpHSWDNjlCD2ObPBuB9yl
	Isfam4oDiHIgEzyvXVUuKBFy0PVM=
X-Google-Smtp-Source: AGHT+IFStgVjaSo3pk3txOTIPySLMGz7fvaU+PopoAUqYoGAO47GML5Qh3YJmt+I/+Qw5sqNYAHeoIjyd8eDLMlpUG4=
X-Received: by 2002:a17:907:1b25:b0:a58:bcad:47c0 with SMTP id
 mp37-20020a1709071b2500b00a58bcad47c0mr7806744ejc.47.1714382555636; Mon, 29
 Apr 2024 02:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714377864.git.lorenzo@kernel.org> <6c9db20505b01a66807995374f2af475a23ce5b2.1714377864.git.lorenzo@kernel.org>
In-Reply-To: <6c9db20505b01a66807995374f2af475a23ce5b2.1714377864.git.lorenzo@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 29 Apr 2024 12:21:58 +0300
Message-ID: <CAHp75Vc0=bKk+D9ULPhfbVkgHpRTST_niNBYo4Jri_71XQa+dg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] spi: airoha: add SPI-NAND Flash controller driver
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-spi@vger.kernel.org, conor@kernel.org, broonie@kernel.org, 
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org, dd@embedd.com, 
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com, 
	angelogioacchino.delregno@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:13=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.o=
rg> wrote:
>
> Introduce support for SPI-NAND driver of the Airoha NAND Flash Interface
> found on Airoha ARM SoCs.

FWIW,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

> +static void airoha_snand_cleanup(struct spi_device *spi)
> +{
> +       struct airoha_snand_dev *as_dev =3D spi_get_ctldata(spi);

> +       struct airoha_snand_ctrl *as_ctrl;
> +
> +       as_ctrl =3D spi_controller_get_devdata(spi->controller);

You may do it on one line above (the same way as for as_dev).
Ditto for other similar cases around.

> +       dma_unmap_single(as_ctrl->dev, as_dev->dma_addr,
> +                        as_dev->buf_len, DMA_BIDIRECTIONAL);
> +       spi_set_ctldata(spi, NULL);
> +}

...

> +static const struct of_device_id airoha_snand_ids[] =3D {
> +       { .compatible   =3D "airoha,en7581-snand" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, airoha_snand_ids);

No need to keep this block here, the first user is below the ->probe().

--=20
With Best Regards,
Andy Shevchenko

