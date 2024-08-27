Return-Path: <linux-spi+bounces-4329-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2563695FF99
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 05:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E4C1C2184D
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 03:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9596710A3E;
	Tue, 27 Aug 2024 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EDjaKR8j"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341F18037
	for <linux-spi@vger.kernel.org>; Tue, 27 Aug 2024 03:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727972; cv=none; b=bm25FBet+CyKmmVRs42K+Ry3JeqCA9/ZV3amiekl7TJsgpozBzsmhZP8qRGOviC94EsQ7WaxBPCb04RnSfrA/dJ+iGkGDUQ1KektFLxjtgHuwNM0g22LpkPZre3bYKF7d7SaGB8wEmLV7fIiQQbX//41OoDFGvFiWAK8zV1LxyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727972; c=relaxed/simple;
	bh=2ecYZz6GGQ2vmg8Pz7j+mi7ALBB3Pd48KzkJgv6NiT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/RdmPWXCC1CNoMiua3e7VOgTBZM7U58Iz2XcG3xov2Dff54KNSuHWGqlIxYYVMHFlbHhBN6jGNDm1hn/2+IlBgJc0hPzSNe1bz7N1ZgN9W1h86JAR0BnxEdF9htu70feGMpKZ1ZuwyS6UKWEIKEF4F3llrhRbZntSl9aiSK3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EDjaKR8j; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-714261089c1so3529326b3a.0
        for <linux-spi@vger.kernel.org>; Mon, 26 Aug 2024 20:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724727970; x=1725332770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2IxSWIgW9K+Ycy7Q1UnTr8RqMZZFrbF0akh3JGxgko=;
        b=EDjaKR8j6j2CWnY9y6oAB5gFXT94HINNbxA5Xt7NqxfSIMj/B0Wm+sXYQ321YBt+Jc
         0lLn+/rWqCXgc4TFSDfRQMVqB3nyowSiEroK8XD+w3aC1FgEKRqdfsUaVeN6t1PLqv/x
         iKGIeBxfE3eoucS/1VqzoW8TiRgAkVWzhIjyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724727970; x=1725332770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2IxSWIgW9K+Ycy7Q1UnTr8RqMZZFrbF0akh3JGxgko=;
        b=WhOIsENuQ0eGZeE2NfjJtwmlaiTTX7BFClswBMhI5eD4UoB2rjL/FQrif3Oddp96c/
         pRTPLu/Km6VkDqO930v2D694xMZUiJJj5zbIfvxkeomMGcmY6M2jpPDYo5nbB+KqRR9O
         W31/+GlzAXqBlc3nFY+6YlGDXApRqSbnNTcnCPlIqY7A0ayT0DLwefhXasPXEaVtSlwI
         2Y5WrMGg+QCzQhEtRtThscoG/ebq4T8EP3Wf7TapnK6r/eblC978BIFSZ23xixryVnZD
         TNvrcGql0MOAlIyCVZHilO8E5LrYg5w2cMGrZyWKvAY9hL0Q2qjGQv3zXuMG6pBjBqOT
         6MyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsK029HFweTz4xn+Ll3390jyn6/DNEGU6gvCQyE4S3fXeMQ4/U1bwb2LkVLHfhuiSJ0Bvbg/xwMY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34mT2mMdYIo9tzGTvXuqPozPJWvPZkyet9/pzSqrDpjetxPes
	uUvNz+5gNucVaexpfITwJzI+IaZt1YGsQAdagRKWyASjkPz33QNyJNfWtdF9amyJeghxgL0GZXo
	znw==
X-Google-Smtp-Source: AGHT+IFnCufhZKiBy1Mby5m+C0ZAt2PnMpg1V+2S7ZkYl2inRS4vj1wjWTVrBFFeMxNzypHa8usrSQ==
X-Received: by 2002:a05:6a00:3919:b0:714:13e1:1111 with SMTP id d2e1a72fcca58-715bfee8f20mr2209751b3a.1.1724727970089;
        Mon, 26 Aug 2024 20:06:10 -0700 (PDT)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com. [209.85.214.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e2c78sm7662678b3a.136.2024.08.26.20.06.09
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 20:06:09 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20260346ca1so108025ad.0
        for <linux-spi@vger.kernel.org>; Mon, 26 Aug 2024 20:06:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUl2C2mjyzyKCK0U8LyEdObVijPhOQDa2zRP4YA1myBjUW7y7FdmOjYE7uElLfQQsFBk9n7HoT/j40=@vger.kernel.org
X-Received: by 2002:a17:903:228a:b0:1fc:60f2:a089 with SMTP id
 d9443c01a7336-204e4cb920bmr1085965ad.17.1724727969099; Mon, 26 Aug 2024
 20:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825035422.900370-1-jon.lin@rock-chips.com>
In-Reply-To: <20240825035422.900370-1-jon.lin@rock-chips.com>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 26 Aug 2024 20:05:56 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOnwQ4Jrz=yo1QS-EAfTN_=FMZ1xtF=2-a8iDC6PwDBSQ@mail.gmail.com>
Message-ID: <CA+ASDXOnwQ4Jrz=yo1QS-EAfTN_=FMZ1xtF=2-a8iDC6PwDBSQ@mail.gmail.com>
Subject: Re: [PATCH] spi: rockchip: Avoid redundant clock disable in pm operation
To: Jon Lin <jon.lin@rock-chips.com>
Cc: broonie@kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

On Sat, Aug 24, 2024 at 8:55=E2=80=AFPM Jon Lin <jon.lin@rock-chips.com> wr=
ote:
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> +#ifdef CONFIG_PM_SLEEP
> +static int rockchip_spi_suspend(struct device *dev)
>  {
> +       int ret;
>         struct spi_controller *ctlr =3D dev_get_drvdata(dev);
> -       struct rockchip_spi *rs =3D spi_controller_get_devdata(ctlr);
>
> -       clk_disable_unprepare(rs->spiclk);
> -       clk_disable_unprepare(rs->apb_pclk);
> +       ret =3D spi_controller_suspend(ctlr);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Avoid redundant clock disable */
> +       if (!pm_runtime_status_suspended(dev))
> +               rockchip_spi_runtime_suspend(dev);

rockchip_spi_runtime_suspend() returns an error code. I understand
that it doesn't actually fail in practice, but you should probably
check it anyway.

> +
> +       pinctrl_pm_select_sleep_state(dev);
>
>         return 0;
>  }
>
> -static int rockchip_spi_runtime_resume(struct device *dev)
> +static int rockchip_spi_resume(struct device *dev)
>  {
>         int ret;
>         struct spi_controller *ctlr =3D dev_get_drvdata(dev);
> -       struct rockchip_spi *rs =3D spi_controller_get_devdata(ctlr);
>
> -       ret =3D clk_prepare_enable(rs->apb_pclk);
> -       if (ret < 0)
> -               return ret;
> +       pinctrl_pm_select_default_state(dev);
>
> -       ret =3D clk_prepare_enable(rs->spiclk);
> +       if (!pm_runtime_status_suspended(dev)) {
> +               ret =3D rockchip_spi_runtime_resume(dev);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       ret =3D spi_controller_resume(ctlr);
>         if (ret < 0)
> -               clk_disable_unprepare(rs->apb_pclk);
> +               rockchip_spi_runtime_suspend(dev);

I don't think this is valid error handling. AFAIK, failing the
resume() function doesn't actually "disable" the device in any way
(it's just informative at best), so we probably shouldn't disable
clocks here. Otherwise, you might leave the clock disabled while the
runtime PM framework thinks it's enabled.

Brian

>
>         return 0;
>  }
> --
> 2.34.1
>

