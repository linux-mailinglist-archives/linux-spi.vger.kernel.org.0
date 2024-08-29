Return-Path: <linux-spi+bounces-4443-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06CD964DEA
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 20:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A2C1C22366
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 18:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24751B86ED;
	Thu, 29 Aug 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZzfZU8N"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4B15B13D;
	Thu, 29 Aug 2024 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956985; cv=none; b=t5cxhR1qWZHn9c5zuJeeHnJlwlarRHj/2zfkKjV91gmFkhFfMQYVLiNshphXwArgImTnhIM91pBrB2Jv6lTtufSQq10U1Jb8LEuWAuyxci13XpkhIn2dEK1S61cf5A2MFWBjrG+WiwIlvpTnld8QoyOMRX0tnFmrMVWkGNKuLCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956985; c=relaxed/simple;
	bh=aRsxTQ+z2/BcIQan4A5CUzdaVyQJyjbRmw0k512Pgc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdmMc5lpWnGvPunZxfX1jbkN9f0I/crNslGMWWpblTW5iNWQi0ZZCDhjawuCIrp7OtZsOXHjx7sFHRqBOWb+wjw3mCm/I02sd1A8FRT5mUGa90nmr6cHIjlZnsyOiePhoONrNwjAjOxW7HmaYNifahHn+Kw0TO62nULTTIVsGRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZzfZU8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196B6C4CEC6;
	Thu, 29 Aug 2024 18:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724956985;
	bh=aRsxTQ+z2/BcIQan4A5CUzdaVyQJyjbRmw0k512Pgc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nZzfZU8Nc9ogh9GburQvKebfAYSydbvClced2l0SeaoXG4zdlxWnpPztN93Br1yT/
	 2XgrG9cc8zU55zHWzcy9c2JWWyO9+j3xHCDB+oCRYG5AfJjg7sjbKgCa5q02TONz84
	 FyUE2p9dY9siDFiQM3jTvqbuB2N3kKOoMM/RKYz12TyEfC2DaiPhC8ODkEEh534lDa
	 P/nRY2K7gEBXkGgYYxzcR+w2O8Xm8Bg3o7pppaXmHhf42qFUzBkriL8yABrJ/mIPfk
	 WxhUCQv3e2uA9Op91Lw+76hwADJOSake1Bcs49WvlrZGSZ9w+OTvQShXCoGz2FqwDf
	 kn0QaCH8n8CAw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-533de5a88f8so994453e87.3;
        Thu, 29 Aug 2024 11:43:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCD9g6X9nD5qDJsUrGdNfFcN3FmHGgZq91xxVeayOOZlca9UTTQq0sFCDvVmS7T2qsxXw5BQUcwih3@vger.kernel.org, AJvYcCWkwkTHlXI7U6wk4VHShyp/y2/Aom/PSOauGVw94n1qvFqFR5lUU60EXtw2B6CumbVHmKYN5521ZlTe@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1iG8c3vkAlSKAweOZToG2hj6G5iWxax9ybA0IZrWnVg1azkH
	dyOfjRicnhKPPrAflMm7hZI28hiYdV4yc8wfxNBpol3Spdv7BM2g847vAe1g7kVKlkExPgj4QMp
	E8P4dZwoU8lOBa9otUHf2+kBC7w==
X-Google-Smtp-Source: AGHT+IEOIsXBTVW1a7P5gxxUALYyRo8u6jCniTiE/wJrT5MFBSpFvSrte1KVxGcAUEkzg2n5lOZfgI3jwMoiJbIaASA=
X-Received: by 2002:a05:6512:3d9f:b0:532:ec7d:9c68 with SMTP id
 2adb3069b0e04-5353e5c05c0mr2562280e87.55.1724956983385; Thu, 29 Aug 2024
 11:43:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829113158.3324928-1-festevam@gmail.com> <172495658983.899923.10430034751474903183.robh@kernel.org>
In-Reply-To: <172495658983.899923.10430034751474903183.robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 29 Aug 2024 13:42:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL7+5q=7rag4UqfHUR96ii-j8vDksRj2xWnWs=Y_FWU7A@mail.gmail.com>
Message-ID: <CAL_JsqL7+5q=7rag4UqfHUR96ii-j8vDksRj2xWnWs=Y_FWU7A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
To: Fabio Estevam <festevam@gmail.com>
Cc: heiko@sntech.de, broonie@kernel.org, krzk+dt@kernel.org, 
	linux-spi@vger.kernel.org, conor+dt@kernel.org, 
	otavio.salvador@ossystems.com.br, Conor Dooley <conor.dooley@microchip.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 1:41=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Thu, 29 Aug 2024 08:31:56 -0300, Fabio Estevam wrote:
> > The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> > The marking on the LCD is JG10309-01.
> >
> > Add an entry for the "elgin,jg10309-01" compatible string.
> >
> > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Acked-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > Changes since v3:
> > - Fix the series numbering version.
> >
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>   pip3 install dtschema --upgrade
>
>
> New warnings running 'make CHECK_DTBS=3Dy rockchip/rv1108-elgin-r1.dtb' f=
or 20240829113158.3324928-1-festevam@gmail.com:
>
> arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb: display@0: 'spi-cpha', 's=
pi-cpol' do not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/trivial-devices.ya=
ml#

I'd be okay if trivial-devices.yaml references spi-peripheral-props.yaml.

Rob

