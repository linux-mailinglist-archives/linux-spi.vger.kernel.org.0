Return-Path: <linux-spi+bounces-2369-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478128A6CA7
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 15:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DDE1C20DDF
	for <lists+linux-spi@lfdr.de>; Tue, 16 Apr 2024 13:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A048E3BB30;
	Tue, 16 Apr 2024 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDvC32B8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C712C478;
	Tue, 16 Apr 2024 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274878; cv=none; b=T/mx2gOqwSyYuMODAs+l6Invb0eUZNTYvt+JNnUmXLUPLg5aBfeZWtMmzJcMxZNXdUO0xwUfQw5lDCgc0jhRHrf29fx5efWJALSvN9d13LWAxi4wXsz/hbjsKSFmwuc8babqrepKvBhZ6KGhQ+tzQKmh9lo1a2B88JCuHAJCkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274878; c=relaxed/simple;
	bh=I4SLjtsXcSq1mKSknXG1V3GeM0YtNa9G5Vt3/iZ07ZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCqY+gG40Lb3R2eEYXeYhOF9MptdyHy3Ogd/B6QgQisV5TZKzK3RSCZpF/8RXSedber20SxERT+04vAn5eLmcW2RwS7RZwtri44YJCC4qrL5w41eIesqBnSmN+r85AkQ44kn6i9aTQdttlcGDSdmCUAy85iMlNm3tJX12f9rM6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDvC32B8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a51b008b3aeso543255366b.3;
        Tue, 16 Apr 2024 06:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713274875; x=1713879675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5R6v6vWwxPOZgoG27huf8+BIvuVhK1MREomieQurDiQ=;
        b=VDvC32B86n29eE1YR+BWVemf6rPodGIG5aao81dwbKaqlR5GtRlNiwJfylBq51CK77
         PQ/5X7kGuUYmEq7UviY7Kyh8NPBIbJ9K/KHqvAcIuQpOxdNPR6Tlq8K78eb5v4TVV7O6
         XBUc9uknz1VYWHipXDhooQ0PKFJL7/g49yfA6Vg26GPANGxajEu0QbGre490jEhR28ox
         MO8LKVX2Kb/WzMspMYLuxvPGMvywibulUgqyb9eHs6YiZVnB+mhb/y1e7qVaAt8+m4e3
         LyCv1Jh4z/nCv9Rvg/5GNIPYSk4BIucn+MWCm4wCYnP8fElQebW6QZVVbr+2fGrZmwwI
         Xtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713274875; x=1713879675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5R6v6vWwxPOZgoG27huf8+BIvuVhK1MREomieQurDiQ=;
        b=Aaxy73RuePrsID/jR5evoNl05JWCnf5P1vrd+516M/iuRT/iAjeyrmokYzI36cwkLS
         a8M8kuDyZ+fCJ0nQiGkfD/puoy36IbucBnPrt9KWNt/yKM+V5DaQVaElhUYg/Vcb4sJ2
         O2zI4cBDzgzpcn3XfZKMUqO92yroBu8g9qKlwRekVAEt3ibWB6ESGuTK7x0HOhYhjZsc
         9g+22Na/ElBpx2U34V8vwVWQJh7tTzB9UOO6CVLmU63854DR5eqaVnGiULRZ/4L2uilG
         YHBe0xag/rlm4ZtTx5+QSdoV2lOFPZBm6ZVqdigFecLA8q1GUGAd42QG9r0DAEO+ZOg6
         B5BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf94CKGlmDj6D+T8oLHRpS1WiRnnbaWbS044j+aWNFqAsFye82WB6jY2tPGy+JwnFho2gJtA9SbOr9va8LaQX6MkFR77t3QzrXtxQgQJcq8PXmBWjxn4xvR6hXWzNnpZjFDolViQ==
X-Gm-Message-State: AOJu0YwkivI36Ofm4sdpNzY8k8dMgq8IqXvyRpXa1iQCma+5K/pMwrKL
	vvxcAVQc3k2wC1PNuDih8PtztKzPtLGTQoFDWqn5q9dtUhrCNpD3Z/sKNIQXvt5n71tZmBTsnia
	niCpbfcCNPO0qyOoFiW6IR171HyjCj0EC
X-Google-Smtp-Source: AGHT+IFIPAuHYlqGCmpD6zWWBm+fX7TQSs43Z9uP4cw9nQrLrkbv/TjMzLeT5vkFQxNhRXhP1OKoRcprWeqF6tC4JFo=
X-Received: by 2002:a17:906:3e4a:b0:a54:7dd7:ddc7 with SMTP id
 t10-20020a1709063e4a00b00a547dd7ddc7mr3019110eji.45.1713274875192; Tue, 16
 Apr 2024 06:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416100904.3738093-1-ckeepax@opensource.cirrus.com> <20240416100904.3738093-5-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240416100904.3738093-5-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Apr 2024 16:40:39 +0300
Message-ID: <CAHp75VeSnwqTnpVGdJq33svHk-UnpV8L0JgiRA2MC3ZQy6dA+Q@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] spi: cs42l43: Add bridged cs35l56 amplifiers
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, 
	bard.liao@intel.com, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 1:09=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> From: Maciej Strozek <mstrozek@opensource.cirrus.com>
>
> On some cs42l43 systems a couple of cs35l56 amplifiers are attached
> to the cs42l43's SPI and I2S. On Windows the cs42l43 is controlled
> by a SDCA class driver and these two amplifiers are controlled by
> firmware running on the cs42l43. However, under Linux the decision
> was made to interact with the cs42l43 directly, affording the user
> greater control over the audio system. However, this has resulted
> in an issue where these two bridged cs35l56 amplifiers are not
> populated in ACPI and must be added manually.
>
> Check for the presence of the "01fa-cirrus-sidecar-instances" property
> in the SDCA extension unit's ACPI properties to confirm the presence
> of these two amplifiers and if they exist add them manually onto the
> SPI bus.

...

> +static void cs42l43_release_sw_node(void *data)
> +{
> +       software_node_unregister(&cs42l43_gpiochip_swnode);
> +}

...

> +               ret =3D devm_add_action(priv->dev, cs42l43_release_sw_nod=
e, NULL);
> +               if (ret) {

> +                       software_node_unregister(&cs42l43_gpiochip_swnode=
);

This is not needed when you use devm_add_action_or_reset(); that's why
I mentioned that API and not simple devm_add_action(). Can be fixed
later of course, not a big deal.

> +                       return ret;
> +               }

--=20
With Best Regards,
Andy Shevchenko

