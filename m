Return-Path: <linux-spi+bounces-7142-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B8A60E3E
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 11:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8297A6CB9
	for <lists+linux-spi@lfdr.de>; Fri, 14 Mar 2025 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA46A1F416D;
	Fri, 14 Mar 2025 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+Nj03o9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3631F3BA4
	for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946908; cv=none; b=tlXoOBleG7ltmTvrgCVSY0VDh5+fzfZ30sybHzHzLkNmGm84+r3HTnBc5E5Na5vr0O+kDHk1GNplFFl6GlzcGLlvMBtf/Xh3KBQf0Mh04PSR7lsnoG708fsxwhjrp/ZFdEyGqwtYK1pO+FY9mDwIVaxlhg0uOjwsIwsBGeVxM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946908; c=relaxed/simple;
	bh=Gt/9/LzPfx6RB2Ri4REYVqp1qcpJjg1U1nS59zQ5wMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0bjHm+RyjzOTCwsVvuicRlxR0dQBquvU/DIzx+cBWeO0FhGdNTA6obT9wchEpiDzpCCDcVy4UVKoNdvt4klGmzWCov9Zhe2+c5vcIRyr+2CmtgFxxDUkyQR8iCByKeU9QWQUBakqoX139X828g5kU4AgW174W1byLcYsuYHFX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+Nj03o9; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30c091b54aaso17850411fa.3
        for <linux-spi@vger.kernel.org>; Fri, 14 Mar 2025 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946905; x=1742551705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt/9/LzPfx6RB2Ri4REYVqp1qcpJjg1U1nS59zQ5wMY=;
        b=u+Nj03o9/G6Q5npypn/X5zXy0HE3LmSGtyjbWd8mdYRJwrtUgqLSPkec4dEGk/ACXL
         ooVyGaQLstHEUyYoMlCEPiIbwqiJkc7qzgG3rjA8vZ/YnO7kXSmmoJLtP6r7G0dcX3OO
         v74t5vheXTEpJbyLqpCBGk6j8eW7cgRBxv8xqQPL5KP83OqMDNpJf38npIpc63XVfEkQ
         z+HWsgdDwvT+plIZ55k7EoNcEEaq44AUxIYeiJ+O5/wU9MdyGNrStIe5r1okuenYV9OS
         tXZE/87lJTJ1IOoO2ra12tfpLsx3CbJWp2p9PrMwF1Grv3lF93Kgm3kzaitBHGnjzFit
         2d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946905; x=1742551705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt/9/LzPfx6RB2Ri4REYVqp1qcpJjg1U1nS59zQ5wMY=;
        b=ad7vhkqnK1lewMND5Uq2lbVDk9/JfbFST2aLuaqyNaxyg99ltwpoHdvLzQEilwblsI
         nQi/ueh9HHQ8YVzVxrY+bCOZrmbvZyxoxLpLe5eR4pk7W+d2+H62CbPx016h6jchx03b
         SUtWPox2BbcG677DSsJTA/b0X1lzrQLyUGio9XO2Mt0VpIxkWC5ywFTIUHwJdtZs7G/y
         +L4XskXio/YZC7QEIYaLR0gDlYbOkK0Vy+oSvzN/XrzWMf0PsRvg37dZF6cugnOaUaRx
         1ebDb/VnB7trAmUTFd+Xbuz6jT+CXyuMGFFBnhEynUuOwqOPdGJGp3EFvhGGhWCiBQSJ
         QUmA==
X-Forwarded-Encrypted: i=1; AJvYcCVvQOoCAHGptQJN2N7/OVQxSpnIpdV48A7ZxaBKyH8WjGJFUfFWfWTuyinMKcHQ7l//DS8WPzkIXj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7WPzT/LtdQBiMPkQRYdXT1oTmzbTs+nQF5qOn5nxwZH/A87Z
	bwW/sOajSjJ2LT77h6i1JVzC/rsMdNgeOIrhRH1iMTpLCJ/Fg+pYjQUarfVit5IOokOnf2SvZOX
	t4LCfgM19KWs/dQp3grTXfI/6Cu6+chjUO3fdWA==
X-Gm-Gg: ASbGncsd/s7umrqwKbCygrVqOlhOuU2ExtQ+rrzUO5eIkx7VJLfSgxT0AwUun+Cywjm
	OUgiehbb8Po6riUf5ihlDsa2pFPwduHuSuSv0m5OV8TwDtRW04pV+gbbvO8qzj2BVsYkq1kxYef
	axT/c2RPA7SJhniOH3E2Tbb48=
X-Google-Smtp-Source: AGHT+IHJo15rlSs7Va08NHOofodKMD1H1XNIRjRaa5BY0in+MTDIERdp60qoDZO21fZpfDmKsEUFpvdk8Y2VP5vuLUk=
X-Received: by 2002:a05:6512:b94:b0:545:c1e:65fb with SMTP id
 2adb3069b0e04-549c38fbccdmr671564e87.18.1741946904682; Fri, 14 Mar 2025
 03:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736522006.git.Ryan.Wanner@microchip.com> <821255840c09d8d9cebbb1f2daaedd8a7c138875.1736522006.git.Ryan.Wanner@microchip.com>
In-Reply-To: <821255840c09d8d9cebbb1f2daaedd8a7c138875.1736522006.git.Ryan.Wanner@microchip.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:08:13 +0100
X-Gm-Features: AQ5f1JqSOmT4FHz5UOAsw4lJg3-dP8L_NWpCJ5kNHWtjrkJLgD54yy-3c3bbVqU
Message-ID: <CACRpkdYYeC+2G0u0LYSUjAX_ex7MjWLhEcu7QdNXudj8BEO4PQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 2/3] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, 
	Dharma Balasubiramani <dharma.b@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 5:03=E2=80=AFPM <Ryan.Wanner@microchip.com> wrote:

> From: Dharma Balasubiramani <dharma.b@microchip.com>
>
> Add pinctrl bindings for microchip sama7d65 SoC.
>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

This patch applied to the pinctrl tree.

Yours,
Linus Walleij

