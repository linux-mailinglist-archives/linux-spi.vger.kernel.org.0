Return-Path: <linux-spi+bounces-7685-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB4FA93FEE
	for <lists+linux-spi@lfdr.de>; Sat, 19 Apr 2025 00:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7104660AA
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 22:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B6E2459C4;
	Fri, 18 Apr 2025 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+QjMtNF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6AB233128
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016134; cv=none; b=imE2HrSaIpDbI2RGIBsCyQuhDmZEQnwvhwF0D/xUfGEa6dUD8YX5uB6BIjWMGqUV5PazZAUfDIx5no33vOXOXtVy8gnKT/vkF9dAfyYXSgrTeYtxCmcNWOKRvPHq51+ZFcpnRk25AVrE+wBZT7BZfia5EP6pYOFB7P0cliFcZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016134; c=relaxed/simple;
	bh=opN4untzHb+Lc8v+ljeAAYzzabMLQwTkNpDObjZcSk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIpyBJIdxSH48QySRQeyyLPSqaxVRhcb6FFbbnbMqCMOYz6lKoPd5vm5qjfR7l5p9QXdrqC2BuUgCqZtlw3ViNRS/+cKCUrMLstZELv/YshVz52QwSRUnBkz9ZeMMADNx6wsa477ZXixAxBhpm28NE9E9xl9lQmxfNgdavSUc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+QjMtNF; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47664364628so23180621cf.1
        for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 15:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745016131; x=1745620931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd+n9kyIkHBKuhfj83slWyiHgEHta+a9XPPyPZeGBpU=;
        b=W+QjMtNFT6kmw6CyTCL8F+Zo2nwL4BloclgTtt/rM1sflGbQYGaRoizbUCHVTbE1Cr
         6kKjV5s/f232C4sGyTLCAzIcFUoDMxQnFhGHnPuYoWKwLkP6XCOkzlMJBbdHUBEAfXbr
         CFH3f/01XnMcT3SUok9eQcN7cCI8w5tmwQBk3JQ80sy5GvUkfv39KfNeCe54Xe5o/N62
         LQFftPKKaHOpgI402/jwryaLCTDwCxRanBvq17UnFEW1drpaPOFRDIzPokd3CDg2290q
         H0RT68a0dSOjBakEcpBf45TKcd+ugMylUxsu59BUQPAzp0dlzFxhtD8EFDms7iYIRyH8
         0/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745016131; x=1745620931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wd+n9kyIkHBKuhfj83slWyiHgEHta+a9XPPyPZeGBpU=;
        b=Lz5CeZ88TtDtZd6wh9cpCpzOaHRt+5XZghnl/LBWiJeLi7mHSlaPrm9BvHkYHsaynf
         Dlh31tJYykfxeSdGjVNIoTxP+PZ3AWPg/tkCT6YufHcUpG2vgMdXvaI8Z0K0NAUKwyrV
         AFtMpr28XAU2eoVyMi5pWtnGonDfyQcGA7O60wF/yQn2BzsUi3mge2s1oPqqKGYt6mZl
         1ClG3KsGgiThaV7un9Ohax1oJih+8Ud6Reb1eyztfInXhKTWwyNQPAKnnA86p/PRMnWq
         FfPaZIO5WAWCszfmRyLUdG7dUv6rGjNs0Yq/cDid0Ra1QaomLmqzegG3DdDjFBk01qgc
         empQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT/Be+udpuHD6KX5hkipDoeiWelSaYowLmXoiDDyO3G/uOsfnmi3HMTg2xAwOpuJIakUUEbEeOBsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwdMu49Pw7e8eqvHvw6mlnV5YSs5g0FumINYGB4z3dp5C9nQN2
	V9B+ZP8FABA7PlqF2CYtolz+txZx2P1efdi3ENYPdEebN/8xb09cQOdPHUJFBXak/2fPp/IS+xt
	J/575NqjuRVS5wtnPxyAbup6JpmspNvDl
X-Gm-Gg: ASbGncsav899rk9UZRJIxwMqq9I2zXfjVbXxb8NpPQ9YRYYxFx0AVC43Jy9EW0vI1A0
	xgeRLCe/NsI0ws4TpxTTxtyy7ZFwNy+EE9DKAfAlIZhIK+nWJXXfdj3OiEwodYs2LxTfMdVp0mD
	h7tNLIFC1l/E4cfDo1z3cgdfc=
X-Google-Smtp-Source: AGHT+IEtcOi9zjoXkyoK1RiLB7WMBharIU2o0yyaZ+wzwLb+h53Q71LtZMoxwZEcREbvXTjdtEZ8zD7RqtKlqnVxARY=
X-Received: by 2002:a05:622a:112:b0:471:b32e:c65d with SMTP id
 d75a77b69052e-47aec4ef32amr70777971cf.19.1745016131557; Fri, 18 Apr 2025
 15:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418223905.45402-1-andres.emb.sys@gmail.com>
In-Reply-To: <20250418223905.45402-1-andres.emb.sys@gmail.com>
From: Andres Urian <andres.emb.sys@gmail.com>
Date: Fri, 18 Apr 2025 17:42:00 -0500
X-Gm-Features: ATxdqUFUZTlsbTMuSc3CiInOpTBViqFpFmj1qSwqs-sUNwnvgdfQ0Rm2Dj0wj9c
Message-ID: <CAMihqu-hdRGBEx-g=Yn8TcFgWP+zYiuja96qQghYfUzbivNm0Q@mail.gmail.com>
Subject: Re: [PATCH] spi: offload: check for match callback when a trigger is
 being registered
To: dlechner@baylibre.com, broonie@kernel.org
Cc: skhan@linuxfoundation.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 5:39=E2=80=AFPM Andres Urian Florez
<andres.emb.sys@gmail.com> wrote:
>
> Make match a required callback when a new trigger is being registered,
> this allows that other functions like spi_offload_trigger_get() could
> safely invoke the callback when it is required
>
> In v2:
> - improve readability of the condition
>
> Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
> ---
>  drivers/spi/spi-offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
> index 6bad042fe437..21a0f3a3a176 100644
> --- a/drivers/spi/spi-offload.c
> +++ b/drivers/spi/spi-offload.c
> @@ -434,7 +434,7 @@ int devm_spi_offload_trigger_register(struct device *=
dev,
>  {
>         struct spi_offload_trigger *trigger;
>
> -       if (!info->fwnode || !info->ops)
> +       if (!info->fwnode || !info->ops || !info->ops->match)
>                 return -EINVAL;
>
>         trigger =3D kzalloc(sizeof(*trigger), GFP_KERNEL);
> --
> 2.43.0
>

Sorry, I sent the patch incorrectly

