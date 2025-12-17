Return-Path: <linux-spi+bounces-11987-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A23C9CC7DC8
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 14:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C53FE30633AB
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 13:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095133659F8;
	Wed, 17 Dec 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="G3TZwRs8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F83659E8
	for <linux-spi@vger.kernel.org>; Wed, 17 Dec 2025 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978385; cv=none; b=kX1+px01ZKzoImz0DWgvUqN5IPhhPOv6cCYrBNGQVw1tTeTArM3KP8Y9x06bNv+NmvaKvwawNcoxYzrtQMKyiDymuEZ91a1LaRxIxc0Xsx/942ZJDS8q099l58HCNI4VljNvy/MEWIwK27bEZ3Cbwro5s7K9ueCZ5hNstqDkySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978385; c=relaxed/simple;
	bh=3NxV/sdr2BZyW6Fp6jeGvfWxTA5ctLtFaPPYKmOmWzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avk0kFGVr0ql1ByUghaZUXnseRhqB9r60DtEiGc97LOkoAzNalSHHMz7T61gRdsBwzmnYQ6em70pnqWLme25Ce8xLobe/2ebczX3A/TjyU3qI6IaNDhFQfbLGVXHXUp+LNB1BFhE8g4YMbdghoAKBTNIHa+5c3u71QheTK/JKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=G3TZwRs8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64312565c10so10281608a12.2
        for <linux-spi@vger.kernel.org>; Wed, 17 Dec 2025 05:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1765978382; x=1766583182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NxV/sdr2BZyW6Fp6jeGvfWxTA5ctLtFaPPYKmOmWzs=;
        b=G3TZwRs8slika+uM8zA2b/tbxbmR9UD4zQjKjHTYFdQgFKQIvb5WcOE963ZZ02V0Mc
         qP0y3gHvcLeM0uzdbqcjgz/OUiak06hFqxxk2bqy9JyIuV+hWAOR+yfQT3/puygEdmcZ
         mSOwl2czqg7bWviUHQvoqfL2VNr6lSNSEKluYXqSdbSaAHT1yuKd6fpzL1rD93FYSdgq
         nGfR/UWTLwfs3EF6NQKalofoEucjD9bsNEEN4J8bADznJikY/0q8pziBBNcl66wb0YW6
         VefrjPLW58syX/GbFPK5ltyANGRw4PSWy3W4rvQNgVF5nVe6Cj7L6F0oCvRlAt9PVq8m
         SAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765978382; x=1766583182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3NxV/sdr2BZyW6Fp6jeGvfWxTA5ctLtFaPPYKmOmWzs=;
        b=xUe3xH1ukFh6R+dtypQT3GiYZ28DdxfUJm1iKV9daLYFj/ySPKEEWtpESIE+EikBKf
         RFgwyv7KqVlzwXYwBS4OGTmLAAbhwZutzwtjWU75o4dERmKEPo32C9QjJivt/h9eB0yL
         xQuom4U+A4T9KlAuQ3tfut7k7NfVGP9ZgGOrorpXOHI0L+16CtwxX6yl063T9HwMjJh6
         XqP7+k5hDtBGK9OTMidJC0L6X+J/yddkBO4dnYTYXEFd4tZOF7WMzDKPHGM1HS4rCf+D
         z3HmJs5a/ThFzwncBjWrvF9faserise0EpYVuPnb/1vtGW0UmhSGTfg1y8KR7yqvf7jb
         WevQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzWc914o6wCKiHTb7Agm07qQAfGn5AxqNLr1qsZTtXzH8dRuMwFEU4PBrPCmeW5q57hsGQm/YxIx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRs1Zmbkv64XPOEByxVOU4fHA56Dl72TzrYvwkKv7zOt9P/qOm
	xq5y6xSk6QlG94y9n1fmo1pWqpoRH+2K3cHfFkj8ax1OxyoZxh5oXzkxS7TH5o1f64SKRdC1WUR
	HQLErvhu+7nF9wQOvsx/qiakW59nKNi7wJtFjbg0ZLg==
X-Gm-Gg: AY/fxX4y/qVdg23Cn6yGvSCKxi+W6pyap4357hnUfmSx0pRHEhulIIWXMBLxPQ71kCi
	u5sL7PzN93wwFa/HhSLau9O27CugvCbLG/uM/WKUOeSkbeNQp3So3AyClQXsRliLv8XO3dpj/6L
	ZgvK2GB4+9u0dZ51di49GtWRvCpU5hXwT9NKTVEIjLb467dLa52dJ2sH7QzCc9KCoNuruvRjIQq
	34axVcEBIN3LI8PIHHYhePrXxWI9WRdPnXb6HJ3ZOA15Ph7u7THGTuY11cw7Ru9dsVb8clLFL6D
	/Q6jQNXbk+jQp5PNJkEt1fIUlJ5cFwjLPufcA7LGOe3/0PhpLN1C
X-Google-Smtp-Source: AGHT+IHQBmS2mrQa3fgyiBBuz2kWHV24zlBwa/1NFFHKPKgWTqO46GlqIXXFCMupFuoXyMzVWH1kl/6iZAAmZg0kVsk=
X-Received: by 2002:a17:906:c39e:b0:b7f:e709:d447 with SMTP id
 a640c23a62f3a-b7fe709d458mr591500066b.33.1765978382116; Wed, 17 Dec 2025
 05:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215163820.1584926-1-robert.marko@sartura.hr>
 <20251215163820.1584926-5-robert.marko@sartura.hr> <fe15fcce-865a-4969-9b6f-95920fcaa5c7@kernel.org>
 <CA+HBbNGNMGRL11kdg14LwkiTazXJYXOZeVCKsmW6-XF6k5+sVA@mail.gmail.com> <3d6f254c-d53f-47d9-8081-8506d202bf9d@kernel.org>
In-Reply-To: <3d6f254c-d53f-47d9-8081-8506d202bf9d@kernel.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 17 Dec 2025 14:32:49 +0100
X-Gm-Features: AQt7F2p7AtghDvAyv4NK8Ascs8BHBx___HwB1JF-DX23awYiIEMyiUo7jk7sWyI
Message-ID: <CA+HBbNEKJ2qG4s51Gq9dh0uGuSwyPDfsq+mb5w6Kry6e9N0VSg@mail.gmail.com>
Subject: Re: [PATCH v2 05/19] dt-bindings: arm: microchip: move SparX-5 to
 generic Microchip binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, Steen.Hegelund@microchip.com, 
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org, 
	linux@roeck-us.net, andi.shyti@kernel.org, lee@kernel.org, 
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linusw@kernel.org, olivia@selenic.com, 
	radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, richardcochran@gmail.com, wsa+renesas@sang-engineering.com, 
	romain.sioen@microchip.com, Ryan.Wanner@microchip.com, 
	lars.povlsen@microchip.com, tudor.ambarus@linaro.org, 
	kavyasree.kotagiri@microchip.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org, 
	netdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-clk@vger.kernel.org, mwalle@kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 2:23=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 16/12/2025 18:01, Robert Marko wrote:
> > On Tue, Dec 16, 2025 at 4:58=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 15/12/2025 17:35, Robert Marko wrote:
> >>> Now that we have a generic Microchip binding, lets move SparX-5 as we=
ll as
> >>> there is no reason to have specific binding file for each SoC series.
> >>>
> >>> The check for AXI node was dropped.
> >>
> >> Why?
> >
> > According to Conor, it is pointless [1]
>
> You have entire commit msg to explain this. It's basically my third
> question where reasoning behind changes is not explained.
>
> When you send v3, you will get the same questions...

Hi Krzysztof,
Considering that instead of merging the bindings LAN969x will be added
to Atmel instead,
this will be dropped in v3.
Sorry for the inconvenience.

Regards,
Robert
>
>
> Best regards,
> Krzysztof



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

