Return-Path: <linux-spi+bounces-2240-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6448089D2D9
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 09:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADDDB21B9D
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 07:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC6377620;
	Tue,  9 Apr 2024 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCAyqF97"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF366E5EF
	for <linux-spi@vger.kernel.org>; Tue,  9 Apr 2024 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712646736; cv=none; b=UAdrkfxH4VTaFOdYKrVd4V4gbY7kwg1blAuHLpl1y8l4T2WEuOJZ6vn9KleJvpp0gTDqcXx0nKNHaCQQ9w/cYgnKkshNL6mEgkUexl9KQ95Ol5oeOja7TfjfKy+w44N1MvfX6r+tzNeqUJLdPm0IltzJS36RRXHEM6KaYUOXySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712646736; c=relaxed/simple;
	bh=7k2kwrD+6dkxa0Jp5JiZOG2oLIzIdChr8NsQEX492TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6Bmj4oJv0tfquu0mketArSFuogO2S4PhDv6WpkcBBlogihX4NtcMf1ktQAjmnLZ4SkIzFxuw00s4Fg8l0XohQ72p+YotOtzfvHOZuN2rOOHmLJXTcRR1P9ZANCkfSc/cYHa3V0diumkUSIqoSQOmMsDinj9YQtf72/Q49uyxCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iCAyqF97; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-617e6c873f3so29352977b3.2
        for <linux-spi@vger.kernel.org>; Tue, 09 Apr 2024 00:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712646733; x=1713251533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tiescK9NNjrWaswI2dTbql6lo1cCUF+evpx7dXZ6iw=;
        b=iCAyqF97upmQiLt+WKUZOJ431mWwCRSzXMrmDboKn1+fkoTMi72sRP7jv2VoKNqHtR
         Szf/2fXU0sVZidhKdlh7QXNZyFx+VS6aEu5F6Et9J3FWva03J4F1w0pkgwzUAKiu9fpn
         GuUdL2EumX8Ut+494gfxel21fdZu8Vcp9Dxk+afHnPQZyOJ19ino5cnxu80QZrw5O1TM
         WF2CsSpz1fkvDvuFCprn1Lhpmpo9jec659g7HSvDIaXAtXQz+EaqC4Nm/vn5UOINjScl
         Q7vShyyPEOLiTJk8YF0QiNAW0tELOMYvpwa7Hft2pMOWIypZzQQd86r3iIUKZXv0MTo/
         l15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712646733; x=1713251533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tiescK9NNjrWaswI2dTbql6lo1cCUF+evpx7dXZ6iw=;
        b=P9eFgwfuKNb4P1yrIPVaMEh4T96/rX70Zk6YBeLhGYH5Ord5NEIiMc/m3CZ5cc5LQH
         MTVM7SmZnSlMvtFmF3Os69Xlj5/XeKw6sFgsZ2IzgAKbdIdtEtBtTNzaoXDuYVgdiYsW
         RgzUoiVLutx70i52z77dETuq7dddKeAUBClDz7qOo5ISVKdVC3hV5P+JWmhpj4LKnxVn
         93yQCCAX0uc61DDhNRK2onbTKdSQtNT/FP6WkmtIqjbY09RLjVL0R68CIJrvRx8eqlg+
         yo329aFY742kmRVWcv6vwjph6FljXYaTg+beLCDClPHq/kzzyOQaX51wDsCxhKdYWb9u
         xj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU96jp7puNAJ4+EPMvCErguWyXlvIPm2YnGg8Y6xqj9vIvTUnj8qQf2OOgely0i6kWIUeMDNvGNVGY7PcnHCtiNiGQK/n2lYf8n
X-Gm-Message-State: AOJu0YxDvxidvnUTals0YMw/NHhSTbQimQ83+6By/E2XJ7Gz/QnJNTTx
	Gtqimy2gXWD+XQL2Caq0Xt0Dz+3P2h7cMVtEXce/TpKtGdMEq0H5iJ/0V0zIJx39ndRSlJZVG4L
	XF52MBkM9ncxm0l0ChmyblNJ+/NaaL7uEsR829A==
X-Google-Smtp-Source: AGHT+IGEK2Xj+dHjqiAUu27AtZmeqL/hwR/FjaVb1jfrwvY1S0MafUhiePMSOX3+YMW2y8o36YzLWHrXgKm7qo8ElqI=
X-Received: by 2002:a25:df97:0:b0:de0:e3aa:e61 with SMTP id
 w145-20020a25df97000000b00de0e3aa0e61mr6801877ybg.37.1712646733510; Tue, 09
 Apr 2024 00:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326141108.1079993-1-ckeepax@opensource.cirrus.com>
 <20240326141108.1079993-2-ckeepax@opensource.cirrus.com> <CACRpkdZP_9y-Z=eZcbQe=ZF2ejutP6gD2ofTxXNvGTh7CUfwFg@mail.gmail.com>
 <ZhPvW46kGeOnG++E@ediswmail9.ad.cirrus.com>
In-Reply-To: <ZhPvW46kGeOnG++E@ediswmail9.ad.cirrus.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 9 Apr 2024 09:12:01 +0200
Message-ID: <CACRpkdZQNrDt35d30xJSRz=03rhs6vOODWorpqMsJ=Lo4huJmQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpio: swnode: Add ability to specify native chip
 selects for SPI
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 3:21=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
> On Thu, Apr 04, 2024 at 10:16:35AM +0200, Linus Walleij wrote:
> > On Tue, Mar 26, 2024 at 3:11=E2=80=AFPM Charles Keepax
> > <ckeepax@opensource.cirrus.com> wrote:
> > > +const struct software_node swnode_gpio_undefined =3D {
> > > +       .name =3D "gpio-internal-undefined",
> > > +};
> > > +EXPORT_SYMBOL_GPL(swnode_gpio_undefined);
> >
> > This needs a comment in the code telling exactly why this is here.
> > It is also taking up space and code here on systems that have no use
> > for it, so I wonder if it is possible to make this optional.
> >
>
> Happy to add the comment, less sure about how to make it
> optional. I could ifdef it based the SPI config, but whilst that
> is the current user the mechanism feels like it is more generic
> than that and could be used in other bindings as well.

That's a fair point.
Maybe a new bool Kconfig symbol that the SPI drivers or
other potential users can select?

Yours,
Linus Walleij

