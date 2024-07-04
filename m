Return-Path: <linux-spi+bounces-3748-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F826927785
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 15:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5008E2813C2
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824761AED29;
	Thu,  4 Jul 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS81/koQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11231ABC25
	for <linux-spi@vger.kernel.org>; Thu,  4 Jul 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101387; cv=none; b=jIMpohuvrAzHJPBbazhz1PpfhfW9PeU9KAppHNME86uiURUMZxL9rZ8ZFnsc3wFmQ/4xABbb4LwnLinmUPXR2OJpzhoJL2wffzcFwpbaLyhtvDKDJFFc2Zkr7ANwEo5hXXWDc9uRPDkNDcqxknexO147ZzM/QnPdi8Fg364l6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101387; c=relaxed/simple;
	bh=alnevILXBYnQ6qaFNphx6Dy2Yz05Qtrb7ewjM6f8Zvg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bPe7AglgTY38WC35BJpwCgAetO2K5rR84k8LqyyIGQ/GJeILV9GX04aBpeu4R9flFZIqoYMXVPnM2MUMZJiJEhBjKz9AgQYKbwT4Dr88aB8hMMsgYN9++zixcAlXyh5c2/bKx5sO0jN+BgQiso2FQf439B85TkByXH5aUCu88Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS81/koQ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cf4ca8904so949515e87.3
        for <linux-spi@vger.kernel.org>; Thu, 04 Jul 2024 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720101383; x=1720706183; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FCi/dfAvObnTJKfbCN6NJCqCDSOenW8Px3u8jjrChGE=;
        b=cS81/koQhUZ0vp6y4xnMKt2ApNUbta9SQd05HKXrBDtjVHqEd9Rv8H9+roYkb78w5V
         +9zSZnRf6NH/BNgubWxZrkR0AanSuMc2Mo03Kwqp6xFqIRaYPDOaURaiBXmVXlH2/3Yf
         JzLeLaUCVaaDbPLUkwHPOPlAFbxLva8FSP1RtbL5JAuFGp1hrya0+SjBpJSZMePr5e1N
         LBsKDksNKK63kbMCR9UJwvQIxGZEDgqT7SkZDSSaiayLTZFHULXs1m6KpFNFTCvptd34
         kLHubtwOl/pxmDjiRK0m3ow4PurePmoxYFJfmg3Dzoq6gKid295n0m+u8DinIWnBZwqT
         ooig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720101383; x=1720706183;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCi/dfAvObnTJKfbCN6NJCqCDSOenW8Px3u8jjrChGE=;
        b=LmSwVR+R3uaa9hC5GrZQ4ge5D1QkwI6LCGZ44TeIfpeayqAbpiR7KDzM4yjRq0zf8t
         upml+enzFkqiEIR74MdsmIZKecctNCVzZP3guXeXANe170HtsR4+N/wCeNlvturKUttm
         1WPCGuEIU9bBcY6AD1Yz4YXhmolMRHmWmq/S33Z03VKKocAj1+T5+STTsS6CaS0j7cSX
         9bZkC09+NVSDZ1cZKOGIW5Cx6Cto2t8UMtOMcPpiKIVg7tzcYxcSeWICUw3MvYGefZlC
         jOQ0H7K4XZBmw7+QXGTPY686F4wRYKhj09ULjbvZc1eDnts7jL3o/a5WqtDRj1yUBIMA
         MXpA==
X-Gm-Message-State: AOJu0Yy3osaWowAx9QAgly6ywEj5NmUPhnoVMbYxDCWa94BvkoTj4M8f
	CjKCIN8ApWK14iAW1aVmqnOEiTJSsRDbPnTFE1R0ATMRg81RvOIF
X-Google-Smtp-Source: AGHT+IEAzaPq52AhY0Mu/bNFvwP3R58iy3fFM0uV/0gjFjQMAf4WZDUFfT2CccuvqCFfT4TZIv0wSQ==
X-Received: by 2002:ac2:5e69:0:b0:52e:9d6c:4462 with SMTP id 2adb3069b0e04-52ea062e165mr1324775e87.23.1720101382562;
        Thu, 04 Jul 2024 06:56:22 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-586132502ecsm8552215a12.40.2024.07.04.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 06:56:22 -0700 (PDT)
Message-ID: <76970371e32a30b774fd6d12fc38e8355d950ca7.camel@gmail.com>
Subject: Re: [PATCH 1/4] spi: xcomm: add gpiochip support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Mark Brown <broonie@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>
Date: Thu, 04 Jul 2024 16:00:15 +0200
In-Reply-To: <3ca36d0d-581c-4e24-9466-fb30a3a22d71@sirena.org.uk>
References: <20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com>
	 <20240704-dev-spi-xcomm-gpiochip-v1-1-653db6fbef36@analog.com>
	 <3ca36d0d-581c-4e24-9466-fb30a3a22d71@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-04 at 14:53 +0100, Mark Brown wrote:
> On Thu, Jul 04, 2024 at 03:49:12PM +0200, Nuno Sa wrote:
>=20
> > +static int spi_xcomm_gpio_get_value(struct gpio_chip *chip, unsigned i=
nt
> > offset)
> > +{
> > +	struct spi_xcomm *spi_xcomm =3D gpiochip_get_data(chip);
> > +
> > +	return spi_xcomm->gpio_val;
> > +}
>=20
> It seems like the hardware doesn't support input at all so should there
> even be a get operation?=C2=A0 gpiolib appears to cope fine with omitting=
 it.

Just following recommendations :)

https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/gpio/driver=
.h#L336

- Nuno S=C3=A1

