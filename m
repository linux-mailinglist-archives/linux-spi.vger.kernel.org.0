Return-Path: <linux-spi+bounces-5099-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D698FF4C
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 11:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C28282070
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11493140E50;
	Fri,  4 Oct 2024 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo3BWshq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155DD13B7B3;
	Fri,  4 Oct 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032745; cv=none; b=hjmbCnsZxq0o8yG1RdaQlQeACYkR1ilKjK1Q8J2hTkhhhGENLG4ISO7buF3MBxlWGNYR2o5lO2j75O4vf9edoHAveCjZW1ghrz0k0VfvIKn0LUMQIM86R23uwPu0lmIMDlkf5e5VzKeZVdL3wKzLAxf0Qlfojd7GzjLqP9GAwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032745; c=relaxed/simple;
	bh=/v+RmHRKOZfo9tGe2MELmqxLuPDg9FWIOOY+FSuUWw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqOMbUI/61ncLc8s9+i6XWOMH9c+F+2TUgXmk3SQyK/kuMmW/WimLiKsqcIYa4zWgx+EaYUzYG1tMa0cn9xeUpCFD+GtXq7HgkIc9Oe5jh31MsukI7u7QgIYB+/b/nsjLXo58dUkOc8QYlVBp2CYZjZ+hV6E6DmQxYSB+EgeU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eo3BWshq; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c883459b19so2141871a12.2;
        Fri, 04 Oct 2024 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728032741; x=1728637541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ulig9z8NcPhVqGwL6CNSUzcF2wRPT7yl9E653OjmFD4=;
        b=eo3BWshqakmrOEVRX6xaliDJBL4x/qdjjy9gB8P/tnyUBN9QKGupBYbGbIJY4NZAS4
         z5SBj7K0qNxQVWozZQkUVtxiycweC+LlJASmcpXtJ9S6fYn6cZ7gRM32kQD2n30vOp9f
         qFeeNsWxKAyxdKDP7mObyI0S81W/EuiRbJ88ykXsMrv1QVEnSdOcppUw1x5cO2jtC/EM
         YTuUQbN6doNIPI4xaUsM1Z7gKOYrXCQNZPMqrgjDPYC70BNZHuDiNgMUDwUIqwEgMvHR
         DPzYgGNbKfdORCneebZsWCb1BLGy90rBaa11Yt1Cpg8jdEqlcDXefWGW3hOIHHblFF2c
         52ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032741; x=1728637541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ulig9z8NcPhVqGwL6CNSUzcF2wRPT7yl9E653OjmFD4=;
        b=oHk5yO//4WoaBlI8bAl2+X6dRk2jinjTYnYE5DbVgyVr/1TY+n3F9cMErd/JnKtfmu
         0VSBiap2tpy5HcIVXWVaxHrPja2yebZWDZuq8V3Xpcnx/UeGGMNMKXGHK7T/pFFY5QDx
         1rVyBmPhKqEoa6DvmqmDMf+P6XIML/+H9bCrDC2abv7R7BE1wp3p7wRFIVBl8Dej/4jt
         qzM/2eIqJZw/2DNMMTrz/PmmYEEyjGlx/3Qrg6WDir5Gmf9ixEDZyTDZ+FtRhhKU5gAZ
         qd+rppH8RHHrEsoi4biqjKtFvQRgGIVkIv/yQ/YzVRjJym3FI+gbKe4UQR6x2nJyB0sV
         39RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBStkfJfFfnmn74ftetcUpFQg/A0FXvddpufDqXYm52mI/s2TTSWoT40Oj4AAKd9+k+8rmgtx1ciDd@vger.kernel.org, AJvYcCVGVNhd6kTpWXx8LSVWmzi7Um1uFubLEURKsmFkxrI6dseZG3fopPRWsdh7EoUG/ueabd8OK29dg1Xf+us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCYvJZm/b6EpMNnsOeHFq7zl72OngBNOItB7yCfMFHx+MttWtj
	CkSEnBKSBZvKQRSpNHLNYhA8WnXPIfPu9Boys+iub7tWOfqZAssqIAYHqVqsQQbzDAWMHf0SRaV
	y0RG8TbgxLDQf2rhdu5Awgj3P6y0=
X-Google-Smtp-Source: AGHT+IER2GadSsBs7Lnu4hsc2+Ty7XF36iHDLYqf7DOJwYWgma0rBl9oPn28YylVLhc/vwpQKHxRm808Mk/rmsG62+A=
X-Received: by 2002:a17:907:96a4:b0:a8a:af0c:dba9 with SMTP id
 a640c23a62f3a-a991bd3f93bmr147966066b.16.1728032740760; Fri, 04 Oct 2024
 02:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
 <20240926141956.2386374-2-alvinzhou.tw@gmail.com> <28ac1c39-5592-4e5c-8fce-53489e0135ee@linaro.org>
In-Reply-To: <28ac1c39-5592-4e5c-8fce-53489e0135ee@linaro.org>
From: Alvin Zhou <alvinzhou.tw@gmail.com>
Date: Fri, 4 Oct 2024 17:05:21 +0800
Message-ID: <CAPhrvRQirexA9QJzBSqjfmPnbnF62-hzg-neQ-cZX2hnkP_Zwg@mail.gmail.com>
Subject: Re: [PATCH v10 1/6] mtd: spi-nor: add Octal DTR support for Macronix flash
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pratyush@kernel.org, mwalle@kernel.org, 
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, 
	broonie@kernel.org, chengminglin@mxic.com.tw, leoyu@mxic.com.tw, 
	AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tudor,

Tudor Ambarus <tudor.ambarus@linaro.org> =E6=96=BC 2024=E5=B9=B410=E6=9C=88=
2=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:16=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 26.09.2024 17:19, AlvinZhou wrote:
> > From: AlvinZhou <alvinzhou@mxic.com.tw>
> >
> > Create Macronix specify method for enable Octal DTR mode and
> > set 20 dummy cycles to allow running at the maximum supported
> > frequency for Macronix Octal flash.
> >
> > Use number of dummy cycles which is parse by SFDP then convert
> > it to bit pattern and set in CR2 register.
> > Set CR2 register for enable octal DTR mode.
> >
> > Use Read ID to confirm that enabling/disabling octal DTR mode
> > was successful.
> >
> > Macronix ID format is A-A-B-B-C-C in octal DTR mode.
> > To ensure the successful enablement of octal DTR mode, confirm
> > that the 6-byte data is entirely correct.
> >
> > Co-developed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> > Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> > Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
> > ---
> >  drivers/mtd/spi-nor/macronix.c | 91 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> >
> > diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macro=
nix.c
> > index ea6be95e75a5..f039819a5252 100644
> > --- a/drivers/mtd/spi-nor/macronix.c
> > +++ b/drivers/mtd/spi-nor/macronix.c
> > @@ -8,6 +8,24 @@
> >
> >  #include "core.h"
> >
> > +#define MXIC_NOR_OP_RD_CR2   0x71            /* Read configuration reg=
ister 2 opcode */
> > +#define MXIC_NOR_OP_WR_CR2   0x72            /* Write configuration re=
gister 2 opcode */
> > +#define MXIC_NOR_ADDR_CR2_MODE       0x00000000      /* CR2 address fo=
r setting spi/sopi/dopi mode */
> > +#define MXIC_NOR_ADDR_CR2_DC 0x00000300      /* CR2 address for settin=
g dummy cycles */
> > +#define MXIC_NOR_REG_DOPI_EN 0x2             /* Enable Octal DTR */
> > +#define MXIC_NOR_REG_SPI_EN  0x0             /* Enable SPI */
> > +
> > +/* Convert dummy cycles to bit pattern */
> > +#define MXIC_NOR_REG_DC(p) \
> > +     ((20 - (p)) >> 1)
>
> This is unfortunate as we convert dummy cycles to bytes in mtd and then
> we convert back from bytes to cycles in spi. I had an attempt fixing
> this in the past, but couldn't allocate more time for spinning another
> version for the patch set.
>
> I won't block the patch set for this, but if someone cares to fix it,
> would be great to take over.
>
> > +
> > +/* Macronix write CR2 operations */
>
> I'll drop this comment when applying, as I can already see what the
> macro is doing from its name.

Got it, I will pay attention to it, thanks!

>
> > +#define MXIC_NOR_WR_CR2(addr, ndata, buf)                    \
> > +     SPI_MEM_OP(SPI_MEM_OP_CMD(MXIC_NOR_OP_WR_CR2, 0),       \
> > +                SPI_MEM_OP_ADDR(4, addr, 0),                 \
> > +                SPI_MEM_OP_NO_DUMMY,                         \
> > +                SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
> > +
> >  static int
> >  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
> >                           const struct sfdp_parameter_header *bfpt_head=
er,
> > @@ -185,6 +203,78 @@ static const struct flash_info macronix_nor_parts[=
] =3D {
> >       }
> >  };
> >
> > +static int macronix_nor_octal_dtr_en(struct spi_nor *nor)
> > +{
> > +     struct spi_mem_op op;
> > +     u8 *buf =3D nor->bouncebuf, i;
> > +     int ret;
> > +
> > +     /* Use dummy cycles which is parse by SFDP and convert to bit pat=
tern. */
> > +     buf[0] =3D MXIC_NOR_REG_DC(nor->params->reads[SNOR_CMD_READ_8_8_8=
_DTR].num_wait_states);
> > +     op =3D (struct spi_mem_op)MXIC_NOR_WR_CR2(MXIC_NOR_ADDR_CR2_DC, 1=
, buf);
> > +     ret =3D spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Set the octal and DTR enable bits. */
> > +     buf[0] =3D MXIC_NOR_REG_DOPI_EN;
> > +     op =3D (struct spi_mem_op)MXIC_NOR_WR_CR2(MXIC_NOR_ADDR_CR2_MODE,=
 1, buf);
> > +     ret =3D spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Read flash ID to make sure the switch was successful. */
> > +     ret =3D spi_nor_read_id(nor, 4, 4, buf, SNOR_PROTO_8_8_8_DTR);
>
> can we use nor->addr_nbytes for the second argument? Please test and
> confirm. No need to resend for this, just confirm and I can amend when
> applying.

The following is the process of spi_nor_scan()
int spi_nor_scan(...)
{
......
ret =3D spi_nor_init_params(nor);
......
ret =3D spi_nor_setup(nor, hwcaps);
......
}
First, within the spi_nor_parse_sfdp() function inside
spi_nor_init_params(): nor->params->addr_nbytes is set based on the
SFDP, while nor->addr_nbytes is not available. Therefore, the second
argument cannot use nor->addr_nbytes but can use
nor->params->addr_nbytes. Additionally, For Macronix Octal NOR Flash
in Octal DDR mode, both the address and dummy cycles are fixed at 4
in READID, so setting the second and third argument to 4 is also valid.
Moreover, nor->addr_nbytes is set within the spi_nor_setup() function.

>
> What about the third argument, the number of dummy nbytes. Can we get
> the cycles needed for READID from somewhere in SFDP?

Currently, the SFDP does not provide the number of dummy cycles for the
READID.

>
> Looks good.

Thanks,
Alvin

