Return-Path: <linux-spi+bounces-2544-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 556798B38DE
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 15:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 751EBB21C48
	for <lists+linux-spi@lfdr.de>; Fri, 26 Apr 2024 13:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DC3147C90;
	Fri, 26 Apr 2024 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk0g9Fde"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38B147C89;
	Fri, 26 Apr 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139336; cv=none; b=SbXP5aYoakstMjFICAEWTpmgzg1XUL9fxnN45n7LIXpLP0q49YdH+kRKbN7hWjC8eoRxJU593CD3S5KSkaPvmsY5val//osX5O3bQaN2lBhG6oz02kofSBJVEvsIWd6PFJTSO26haHBYeZKtlzOyA5goV/u2S7Y02r8SMED6YLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139336; c=relaxed/simple;
	bh=XGz6YY0Bp5dGkGV4VgQ73QIqDCU348LxdOjAeb2gKm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4k5ZECGVKZROEOzu1Wq70voErwLjkLdmofnWXxKv6b3rYRUMtpgJW3+XrLmSTjEYhtXyQh9+PIvhomeDmCs6nrSEo/yXdlh/D33XWV+9dQBobg5tdkB5FiXtlNcWxtUz/o1h/IVzkc0rc+QsFxBxBYAi9wupJI9SViKm+zCYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk0g9Fde; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a58872c07d8so592135666b.0;
        Fri, 26 Apr 2024 06:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714139332; x=1714744132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJdAcO7XC0+SgZfZqPVonbe2+mkV4H7piEMPwaJ8D7U=;
        b=Zk0g9FdePAThk8FRnkeTvqHxiLAALuq2iC/NTOLdYOHfDCOXbwGrJlcdTajt2G6G3s
         YUpqYVZLMHHQFB06lmA3rFW307zJjvEePa8TVNPYmyOmFzhOQTziLzh4L98Sf+7HugT/
         QzZ8SDk+NbB4plgljusM4nnbFFsKtEXUsS+w3nMeJLDBZGDMhXW1TA8Q3MXWDEVIr13s
         7zzQzxuDQ7Ywt4nJ039Pm+gz0UDU3xAg7hOVrunMf4bK2tyQjBoRLKSqZ+MNQbEONMmI
         vn1KxOYlyG40sr0tGPoxKCeUpT9FVDhkNzB7d2k4sApowqlZsZ40MwCO37Y6qZjKu6Jw
         ENTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714139332; x=1714744132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJdAcO7XC0+SgZfZqPVonbe2+mkV4H7piEMPwaJ8D7U=;
        b=AqGBxDFCCMsH757+QgmbFBgoTH/9NFS05418aK/UIUBkPrlyGUUeRhudpg8OFwXHF8
         Cuh9UKlPDC3vHeVjkkFPvZq8Jp7KSxzdqs2SdBAui7cfzM6Dr7eAakZuDtkcO/6bMAOX
         XkQGFGKW/cm0swhjpCpjv3tfjBkYmDi9ttNN5GV2U7usmL4oCL2I4RjY5Cist51s/XlM
         nvq654sy6oKb1hz8OO1fNtg+pChfgmVWRCx6c0UvCdQAA6Qi1JeSSpMWcnTNmbY3lm49
         fgcCgWSwRLjVdphJeqEnYaPtG8HRPeuG/rVCuKgc1NDb3F6He2fWl9tVTPp6J2fBoyW+
         Wb7A==
X-Forwarded-Encrypted: i=1; AJvYcCUbHFZssSg0KDOdmQrrDDpbEEpAo3ZTqhn5UvBxls7FET0Rhwrdv7zWIUu0mGGZ6dKDRrD4OLWuw2sAS2wILyF1cQkOQItifmd4lg==
X-Gm-Message-State: AOJu0YzHM9GiUigEbvrC1g6fazH13VlLA8xUldjZU8lO2d+9i3ziiov6
	ngK5jziykBsNHh50pJ1ci8rZ4uS5DVJ8B80pPmDy0Q+vtaeT5BmKZXk+L6xcj/JY1g/aY4UUuuP
	D7P/oaxfi5Sg3lTbww/5KLOV5nFc=
X-Google-Smtp-Source: AGHT+IEL8x/mqBY0RP9nLfwNToqUktPhCjQiYDudfoh/+vSYGnK5VwKc9GW8OTQRYx+wgODhSHqg9AwqaZ0LGJGytdQ=
X-Received: by 2002:a17:906:57d7:b0:a52:a25:2077 with SMTP id
 u23-20020a17090657d700b00a520a252077mr5209863ejr.14.1714139332466; Fri, 26
 Apr 2024 06:48:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714119615.git.lorenzo@kernel.org> <2047e9c8372b51dc263178a12e194b8826f1abe7.1714119615.git.lorenzo@kernel.org>
In-Reply-To: <2047e9c8372b51dc263178a12e194b8826f1abe7.1714119615.git.lorenzo@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 26 Apr 2024 16:48:15 +0300
Message-ID: <CAHp75Vd5VSMNy-bYQmcmRA47uTn567QiKmvDJGEkRUgVCk5PAQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] spi: airoha: add SPI-NAND Flash controller driver
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-spi@vger.kernel.org, conor@kernel.org, broonie@kernel.org, 
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, nbd@nbd.name, john@phrozen.org, dd@embedd.com, 
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com, 
	angelogioacchino.delregno@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 11:31=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.o=
rg> wrote:
>
> Introduce support for SPI-NAND driver of the Airoha NAND Flash Interface
> found on Airoha ARM SoCs.

...

> +#include <asm-generic/unaligned.h>

No driver should include asm-generic, basically 99.9% of the kernel
code must not do that. I.o.w. asm-generic is very special.

> +#include <linux/bitfield.h>
> +#include <linux/clk.h>

+ delay.h

> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>

+ errno.h

> +#include <linux/types.h>

Can you make it ordered (I noticed this after a while)?

+ limits.h

> +#include <linux/math.h>

+ minmax.h

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/sizes.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>

+ types.h

Also note, we usually place headers from more generic to less, hence
linux/* followed by asm/* and not vice versa.

...

> +struct airoha_snand_dev {
> +       size_t buf_len;
> +
> +       u8 *txrx_buf;
> +       dma_addr_t dma_addr;
> +
> +       u64 cur_page_num;
> +       bool data_need_update;
> +};

...

> +               /* quad io / quad out */

io --> in ?

...

> +               /* dual io / dual out */

Ditto.

...

> +       case SPI_MEM_DATA_OUT:
> +               /* check dummy cycle first */
> +               if (op->dummy.nbytes)
> +                       return false;
> +
> +               /* program load quad out */
> +               if (op->addr.buswidth =3D=3D 1 && op->data.buswidth =3D=
=3D 4)
> +                       return true;
> +
> +               /* standard spi */
> +               if (op->addr.buswidth =3D=3D 1 && op->data.buswidth =3D=
=3D 1)
> +                       return true;

> +       default:
> +               break;
> +       }
> +
> +       return false;

Why not return false directly from the default case?

...

> +               op->data.nbytes =3D min_t(size_t, op->data.nbytes, 160 - =
len);

You probably wanted clamp(). It's discouraged to use min_t() for unsigned t=
ypes.

...

> +       err =3D regmap_read_poll_timeout(as_ctrl->regmap_nfi, REG_SPI_NFI=
_INTR,
> +                                      val, (val & SPI_NFI_AHB_DONE), 0,
> +                                      USEC_PER_SEC);

Perhaps
  1 * USEC_PER_SEC
?

Easy to read plain numbers like this to get the idea "this is 1 SEC
timeout". Also editors highlight plain integers with a different
colour.

...

> +       /* addr part */
> +       cmd =3D opcode =3D=3D SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
> +       put_unaligned_be64(op->addr.val, data);

> +       for (i =3D 0; i < op->addr.nbytes; i++) {
> +               err =3D airoha_snand_write_data(as_ctrl, cmd,
> +                                             &data[8 - op->addr.nbytes +=
 i],

Now you can update a for loop to make this prettier, right?

> +                                             sizeof(data[0]));
> +               if (err)
> +                       return err;
> +       }

       for (i =3D 8 - op->addr.nbytes; i < 8; i++) {
               err =3D airoha_snand_write_data(as_ctrl, cmd, &data[i],
                                             sizeof(data[0]));
               ...
       }

Note, 8 can be replaced by sizeof() / ARRAY_SIZE() but I'm not insisting.

...

> +       devm_kfree(as_ctrl->dev, as_dev->txrx_buf);
> +       devm_kfree(as_ctrl->dev, as_dev);

Why?! Using devm_*free() explicitly hints about either
misunderstanding of devm concept, or object's lifetime.

...

> +       spi_set_ctldata(spi, NULL);

Seems there is no consensus on NULLifying this (when, if even needed),
but it's fine.

...

> +       base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);

How is 'res' being used exactly?

> +       if (IS_ERR(base))
> +               return PTR_ERR(base);

...

> +       base =3D devm_platform_get_and_ioremap_resource(pdev, 1, &res);

Ditto.

> +       if (IS_ERR(base))
> +               return PTR_ERR(base);


...

> +       ctrl->dev.of_node =3D dev->of_node;

Use device_set_node() instead.
You might need dev_fwnode() from property.h.

--=20
With Best Regards,
Andy Shevchenko

