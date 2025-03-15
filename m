Return-Path: <linux-spi+bounces-7156-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B99A62AD6
	for <lists+linux-spi@lfdr.de>; Sat, 15 Mar 2025 11:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57161898868
	for <lists+linux-spi@lfdr.de>; Sat, 15 Mar 2025 10:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E460F1EA7FA;
	Sat, 15 Mar 2025 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv/hH1Be"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B25C13AA27;
	Sat, 15 Mar 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742034282; cv=none; b=ka7wRbyW69HoiUYhlOzqhNeukRTJWgbOQpKyMBTUpx51ZvGooP0E+sDyy3MYFDAxHkgpqQ4v0BVaNiBx7i/8SHiWnW2vUi4ZTPZ0TmX17ogsHqgwDLwu+97bnDM9d0Zav+D9cMjNQr2a2GJXIR2V00maRKcuPZ8JTnxJ5C9a2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742034282; c=relaxed/simple;
	bh=LNxoJLVyYrjXF63+rhMSwgjS/pCvCY7BoIgaRAoLfV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=htJsfkl8sErjErxl940ySWPRUU+8m2s/YltxNuo0qG1JB1M/sxtxD+q4nvw3g67NPaw6jNluaS+PRYBywbKDH2176imKHR/y3xBm9vmTnjoBWvjq4nKlAX3Av+ZSdV5IlGPuV/z0TFUTfI+MbGA8TDl3P7RA1fEhija0SbMmJnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jv/hH1Be; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e46ebe19489so2375965276.2;
        Sat, 15 Mar 2025 03:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742034279; x=1742639079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oiz3ziDSo+o4aNWSKvDvsisAAzkwpu5YGVMle5Yw+YM=;
        b=jv/hH1BeLmQW1L1BGQcTf2WqUHhG4AwVC7L8asdlUiE4reuqoDS8BBWsfKos2WXLJ8
         zWSy2WMXjFnR20XsiZV47hieZDRxIKQNXxEw7cKP05bnmO7YBfQMOW6kkYQ32LYFxL3t
         2ntHsi5PsTNkwiHfmn9SE2yY66g54MjTHPqqRzq68kc/qN2VyuNZTeOPNOtfbbZHik1V
         nzs0OmzrPuPD9ejfsr9d8kG7wFLL2Q1X/pACR5v3t/oES6td+pL99DfnjE2EJ46XsdsA
         sR65tBgiMzgnlVb3oBZIXFcJmNAkRMZrbYbJ/ncQTvyEUdDQd248V9otNyAEuxyrrbKQ
         0RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742034279; x=1742639079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oiz3ziDSo+o4aNWSKvDvsisAAzkwpu5YGVMle5Yw+YM=;
        b=u0h7ORQMPV2Y61bXcQFCZBRodmWv1iYAEPgqFQzD73Ls/x22mFKu11uvgtGmbNujvR
         xoAdLmI+PO4NlNI0RCB/9q11WHjXGM3kFmSC/8cG/8qPems7+V74Day5oopg2RrCixpP
         SJMoWzb/vnYlmjDK/8zRyD35gXB8WfmvEr/E8QJDKcndilMLUNSEETYtlavZEbBagMec
         zGHg2vXuheBToLhJiR36iUSAlSqpBCyx0uYRPg6zgMzrCHEhsroFxzwubLpDb4tvYpnl
         z1SKi8aNSp2+7qca46dByKIg3nRZD+3VbTX/ys0QXlWyLbSMa94ceae9/5u5aWmhKRpO
         OQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8nT7rVaTJI0Y1GDVs+HF2TXXsecouGYPPT9vr3lw7FY2TzeKXAgDiEW6rNQH2N5fYSTh7DVw+wWv6@vger.kernel.org, AJvYcCWZUenQbUITsvPKvOyujyBrLJwaCVTPlBu6j14QYRN5sTIPzU70mWjdm91BewD0Gv7VJafZFGr43XwCsgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOi3J3ucjDU79C3yzduJE5kciHBri9oOQMGIRC2pjh2Xa7PI3u
	asLagMrvksnSrbXFK4qW1uwdRe6u8Zo7qO56cOfZoidqC/ONnF8poI9ZYQcLq8ihKG1jwT5tRUG
	BrATfTtHsm8XFxWndrdJEjeMD8tbq4w==
X-Gm-Gg: ASbGnctvlpTe7zVu5K2gMqcJeRQD7P6IZwrsvq6dbKf5/+ckAXRhFGYlYvZTA1nmbt3
	b9i0k2NJ99DYdnMUc0fXFSe3+zLKp0LtOrDG8GrOr+TD+RRfZpQkLd1JnUwH53HTfW1b8A66pXk
	n3JuDvFHD8Agkf+gtkf9Rnr/lK
X-Google-Smtp-Source: AGHT+IGGTelDYUH+Qgc5jfHVgsdIeReyKZT923KjVFzKr7YelITIiPvp5Ee+l/yusZIobZfS98C2RYnhOo1RSFu/5Bg=
X-Received: by 2002:a05:6902:240f:b0:e5d:cd08:12f0 with SMTP id
 3f1490d57ef6-e63f65ef030mr6619562276.44.1742034279216; Sat, 15 Mar 2025
 03:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315045936.27421-1-sperezglz@gmail.com>
In-Reply-To: <20250315045936.27421-1-sperezglz@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 15 Mar 2025 11:24:28 +0100
X-Gm-Features: AQ5f1JrnL-DUE2Ptt9EJkSQhmx-hpPWRhLMokGowxzo1gbLhNFUuYqAS8fhfiLg
Message-ID: <CAOiHx==3Qni3Jv70PV8vDM_7OBLqFG7ARBA41N+jUtV-vcu7uw@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-mux: Fix coverity issue, unchecked return value
To: Sergio Perez Gonzalez <sperezglz@gmail.com>
Cc: broonie@kernel.org, skhan@linuxfoundation.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 15, 2025 at 6:01=E2=80=AFAM Sergio Perez Gonzalez
<sperezglz@gmail.com> wrote:
>
> The return value of spi_setup() is not captured within
> spi_mux_select() and it is assumed to be always success.
>
> CID: 1638374
>
> Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> ---
>  drivers/spi/spi-mux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
> index c02c4204442f..0f45a88bfbe7 100644
> --- a/drivers/spi/spi-mux.c
> +++ b/drivers/spi/spi-mux.c
> @@ -68,9 +68,9 @@ static int spi_mux_select(struct spi_device *spi)
>
>         priv->current_cs =3D spi_get_chipselect(spi, 0);
>
> -       spi_setup(priv->spi);
> +       ret =3D spi_setup(priv->spi);
>
> -       return 0;
> +       return ret;

Maybe just do

return spi_setup(priv->spi);

Best regards,
Jonas

