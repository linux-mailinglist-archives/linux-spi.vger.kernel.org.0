Return-Path: <linux-spi+bounces-823-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA0F83CDA8
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 21:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8EEB2528E
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 20:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6B8137C5C;
	Thu, 25 Jan 2024 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfsJqoby"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C5913665E
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215216; cv=none; b=h7hyPpYVmIOeiSdidlG8VRg/xIMSSsLMg2Z8c4WRYd5wDFgkQ/yNBjUfnui7qL0sLL++saeOfhO1MtYOp75q2vvnmiSbalw6BmI/Liu6UjxnGSrkG3j9cNmB1uunfOGH+prRZFMjeQIvcuQDdBTcQ6Fo9jfPrVsJ33N5XkhnqVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215216; c=relaxed/simple;
	bh=3uCS+Ms9jJoeD9JltkoNsJfXW6By/UFHYI+q9qnWTVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIFtJgpvobZC0PpEiI8sFO6h8ggnzE+R5ZDreuZRBIkUEN/0RdrgGRXsLmF1ICxUsOccszsnbrKLd6btmztjTfzTMwUMi2MN0LSXSFSJ2kMgTkTFdD8GyhCv7uW+h3wmpNLIGtLJjTkBW10wn2MvgxiJ65WAjqgYAYTE/fV3pQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hfsJqoby; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso4048504a12.1
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 12:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706215214; x=1706820014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEBeUeIcJFiSK5BuQqrpysLujiRumnaXWv8mNuRLrJo=;
        b=hfsJqobyuyO2rN5tsRSL6rMS+EytQCXGV3eEkVzfzfKd8UEstneY+K3FR7Nk1XFCdl
         9qry5rx7mSAggHg0fivoxIyXxMDtPGfJxZlPjv1QfnGYzbhObc5GSRReDrgEWGeI2fjc
         4xpEUSMUByRrglpgz2q0pjbjNlY8TUAlIqDoTxEQJdXZvR46n3L7Ecx1xNgLPa/cxm4d
         pkakzRI3g+7tp/EPr49yWynvnL4GfqwAY/64Pksvx70Y5aS4lY6PoZRuqowVgHBPIVxn
         nCQFcSrHgnyO296RdQsi20IR7KXp6sD8FuYkArDUWlhQmjp/iKvRz/pjJmXLp86ghffh
         HSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215214; x=1706820014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEBeUeIcJFiSK5BuQqrpysLujiRumnaXWv8mNuRLrJo=;
        b=H/VHrlStc03fKu+reuOaXk3d9ZuAXbFPi5GYRew7sHV3hFD2kCX7Hoy30ycAwjnq89
         3cz64Ux2ey6l4R2d4ySEg95SW1XT7DJK86a6TrFxdBY0f8KNjWcrBcn2kMyL5rG3+URI
         EuU6q8IcXaeir2x2SXMLGa/jHk0qM1CweyHekAv/Ty7ZvTfZh3d/M0QVGp7BtxhIBNF0
         CEOjlx21dMoMmWZrWN79lWJDCC6uCsefnBKv6lcsFQM7kt3Y53nkPO+JAJy2s/aF3Yvo
         5BWACqr7O8yvCBB3DYgW49WupMuxkSwWmIt+Uc4xnCDQrhT9xhg1BUVOeq+jY2sdUyRH
         suXw==
X-Gm-Message-State: AOJu0YzoA+U10tgjwgfhRCVw4IFKKaNcRRx9G5H/S+V1eV9e9Zf2a18o
	5SOa5ZWECwy6yFHuFveV2XDK3+qh8jZ7O/xU4rMbg1QxT1PKP/APeXNIpmCQGPXXepmUshKeOCC
	MjVOHENNB5p7NkUypK3w93mQ4HFEVsPaPeNwVRg==
X-Google-Smtp-Source: AGHT+IHlz/5WhudAIB+4egVF5diOkk1JQEo5yr9pZiHwR0yU1NrMJrChEqIzLzfLbYdnHhGPRFfz2VJHbJy7iwHIsvQ=
X-Received: by 2002:a05:6a20:3f26:b0:19c:6db5:88a5 with SMTP id
 az38-20020a056a203f2600b0019c6db588a5mr210258pzb.14.1706215214236; Thu, 25
 Jan 2024 12:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org> <20240125145007.748295-20-tudor.ambarus@linaro.org>
In-Reply-To: <20240125145007.748295-20-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 25 Jan 2024 14:40:03 -0600
Message-ID: <CAPLW+4nU4GEKyGAt-o4zFuZ8A56MWQvkQ9NsFkK5hri4Nrz44g@mail.gmail.com>
Subject: Re: [PATCH v2 19/28] spi: s3c64xx: downgrade dev_warn to dev_dbg for
 optional dt props
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:50=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> "samsung,spi-src-clk" and "num-cs" are optional dt properties. Downgrade
> the message from warning to debug message.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 692ccb7828f8..fc5fffc019e0 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1071,14 +1071,14 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse=
_dt(struct device *dev)
>                 return ERR_PTR(-ENOMEM);
>
>         if (of_property_read_u32(dev->of_node, "samsung,spi-src-clk", &te=
mp)) {
> -               dev_warn(dev, "spi bus clock parent not specified, using =
clock at index 0 as parent\n");
> +               dev_dbg(dev, "spi bus clock parent not specified, using c=
lock at index 0 as parent\n");
>                 sci->src_clk_nr =3D 0;
>         } else {
>                 sci->src_clk_nr =3D temp;
>         }
>
>         if (of_property_read_u32(dev->of_node, "num-cs", &temp)) {
> -               dev_warn(dev, "number of chip select lines not specified,=
 assuming 1 chip select line\n");
> +               dev_dbg(dev, "number of chip select lines not specified, =
assuming 1 chip select line\n");
>                 sci->num_cs =3D 1;
>         } else {
>                 sci->num_cs =3D temp;
> --
> 2.43.0.429.g432eaa2c6b-goog
>

