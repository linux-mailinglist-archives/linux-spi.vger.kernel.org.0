Return-Path: <linux-spi+bounces-5106-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49BA990905
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 18:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002651C220C8
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2024 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E5A1C75F0;
	Fri,  4 Oct 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQrjpq/h"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF201C7294;
	Fri,  4 Oct 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058968; cv=none; b=Za0r7k6ZZkerSJ7JLC2bUdZkOWfZFzs4FPwliC9HTFprcAx7ZpIaK/6sUiRWhAhjbn2Ak6jMdZifPtLJkYGu/lF2drMahDhaS4Uy8LMJXC+MGEqv55DaQkKZyCjRKbWuECjYI0kX2247yrbawK1GHW9DVGaVIWP4+GH438LIJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058968; c=relaxed/simple;
	bh=xb+RCijfzqEsoaGXJBRxp/a+e/bURhJaDLLJdyCduOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8+44Za75gpm7FHDz+HP3sd72GGusSwSKkK5iFE3TLpQcr5d6YUbz+2NMEbA0VDnTtLsYtlVrbUyBz43OtZoSj1KgZajt12qLzQpQ7RfQYgZvTxqLD/sSuxCwDWoh1CjSORlX3tFUuxkfxUz+fWa7YUOxfXAL6yP2iPyeIJXZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQrjpq/h; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5389917ef34so2759368e87.2;
        Fri, 04 Oct 2024 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728058965; x=1728663765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUw7Svd/aGEIiLjbnB81Ko4TPZRdd6H9VfhJ5prWRJs=;
        b=nQrjpq/hZMM5V891JeMJkERCwE7LssxgYdXbIcrw4XCv3zTpOFDHCXYG29hxeYmiJd
         VCk10H1kLcpuYnq1oz/dyZLPPy0Ms/FN18/ABnBzBECRlxPCzevTtEEkHb8tvmEe9hbz
         xzbKRqLAlrEkn19A8c3pDbNTzXywq5R1vhgHZFwajL4IgkTpwWy+LOAj9dOz3sLvB+xg
         V5AerHU29i4UGDrRT4qeuso46+NY10PAWz72Tyi714mtOEybJSxelOUP1TC5KIx1fswK
         ZiQuJCuJbhcTzJ7Wk9VwIzyriA8X2QFP78Tf09rR+PUXF69VVtwFgcnYx4tkZe1flqgo
         d8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728058965; x=1728663765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUw7Svd/aGEIiLjbnB81Ko4TPZRdd6H9VfhJ5prWRJs=;
        b=nj6dYoXK+iXKTKgamDhWM7Fpl7ghltIEKQHdIWYM4Y4gWc1NwfBicN86Glvm5eu7CB
         FnMxCLFXbXCc7wq4tZFTO8fbGtsJvrr1y5AUAhTihuJW7uL+b9AElEF53Kzu0gdzEYIm
         2BSQpsE3zA3mRXuchNJB+25lQR8q99jtbV/JhRteaGX9E1Qm6oXSINsnyuujQPgp07PD
         0etwnNI7JckkIj7QYBcjxfXWo4RrRC+hj5OdWbSdM0/GokxBjjBYRASLukw9cjk3fxD7
         qTsZXIkNHew+YQFZACfqfv+DbZk2nLSeOlX2SUnrro8+BJOyyoey7zO0ExbItF4BMXyO
         DOog==
X-Forwarded-Encrypted: i=1; AJvYcCVhktLlr8tzk7HKWvZo1yzaCA67CzQc2EDAJ3McmndXNfgdhj8mvbUUD/jX7qYmkmao7+LkahhWUK15j30=@vger.kernel.org, AJvYcCVwUx3C2z89vIeO2bYDMW3lk9+ID7GsQPmrRleveXpLkz6k8mXNt773c6/05cbsa0Sb6apQulp+yMbu@vger.kernel.org
X-Gm-Message-State: AOJu0YyAG4Sp38ruHCs6BQgrdbgLjbQX80TMqGKfuXmPz3NGhy4/+TyQ
	8TCjLnl8RH1KlWTbZHUXgpW9bEaq6jF0CciBMSjnW4jf6uAnLB5PlT6pJcqqFZ1lYTOPWDYW5Rv
	eQoXIgEWT1SWSpe0enPwS7uJy+vU=
X-Google-Smtp-Source: AGHT+IHzS6ChsWNa74YQ40xSvjV3eZhMCDko9AiWB8J2L29/c4Nmv4CywaF5hvcz5U0Lq6BJ5PXczgDNtYFLAsKe+UU=
X-Received: by 2002:a05:6512:68a:b0:539:9594:b226 with SMTP id
 2adb3069b0e04-539ab88c32emr2496877e87.34.1728058964711; Fri, 04 Oct 2024
 09:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
 <20240926141956.2386374-2-alvinzhou.tw@gmail.com> <28ac1c39-5592-4e5c-8fce-53489e0135ee@linaro.org>
 <CAPhrvRQirexA9QJzBSqjfmPnbnF62-hzg-neQ-cZX2hnkP_Zwg@mail.gmail.com> <890c1926-2778-41e3-bca6-d08a5a493708@linaro.org>
In-Reply-To: <890c1926-2778-41e3-bca6-d08a5a493708@linaro.org>
From: Alvin Zhou <alvinzhou.tw@gmail.com>
Date: Sat, 5 Oct 2024 00:22:26 +0800
Message-ID: <CAPhrvRQrugRQgQcdHBdwid3_sUkCm0mZL9zhz1=TYzXg4qUTfw@mail.gmail.com>
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
4=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:58=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
>
>
> On 10/4/24 10:05 AM, Alvin Zhou wrote:
> >>> +     /* Read flash ID to make sure the switch was successful. */
> >>> +     ret =3D spi_nor_read_id(nor, 4, 4, buf, SNOR_PROTO_8_8_8_DTR);
> >> can we use nor->addr_nbytes for the second argument? Please test and
> >> confirm. No need to resend for this, just confirm and I can amend when
> >> applying.
> > The following is the process of spi_nor_scan()
> > int spi_nor_scan(...)
> > {
> > ......
> > ret =3D spi_nor_init_params(nor);
> > ......
> > ret =3D spi_nor_setup(nor, hwcaps);
> > ......
> > }
> > First, within the spi_nor_parse_sfdp() function inside
> > spi_nor_init_params(): nor->params->addr_nbytes is set based on the
> > SFDP, while nor->addr_nbytes is not available. Therefore, the second
> > argument cannot use nor->addr_nbytes but can use
> > nor->params->addr_nbytes. Additionally, For Macronix Octal NOR Flash
>
>
> nor->addr_nbytes is set in spi_nor_setup().
> spi_nor_set_octal_dtr() is called after spi_nor_setup(), thus you can
> use nor->addr_nbytes.

I apologize for the misunderstanding. Thanks for your clarification. So
using nor->addr_nbytes as the second argument is not a problem. I
have verified, thanks!
>
> > in Octal DDR mode, both the address and dummy cycles are fixed at 4
> > in READID, so setting the second and third argument to 4 is also valid.
>
> but we don't want magic numbers or states that are not tracked, so use
> the parameters set
>
> > Moreover, nor->addr_nbytes is set within the spi_nor_setup() function.
>
> yep, use it then.

Thanks,
Alvin

