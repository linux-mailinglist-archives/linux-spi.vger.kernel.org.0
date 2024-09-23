Return-Path: <linux-spi+bounces-4928-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0FB97E8A1
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 11:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEC71C20CFA
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 09:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99647194ACD;
	Mon, 23 Sep 2024 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBAqoSIx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6936F2EB
	for <linux-spi@vger.kernel.org>; Mon, 23 Sep 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083689; cv=none; b=qIdl+1Qzygf0SlmrgmnR0J/5rmBAxWtt+VFR+mL1vXwvDnLPL+UV3xLg4QxntZbcK2u0JiVwH55SVNfVLw95o0qMEBPfGPEFSS3LM/64Z+SQaSiVQBKUcvtPNOUYWcmICJdV42UGkv75pr+7nVN4PlPzhWl75BiyPCdJrhdzBME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083689; c=relaxed/simple;
	bh=Y2H3lLogo29T09ZIg4O5267APGx1T56CgiRzH2uFGiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJ4RHOKuqBmt4qRD7qCWBoWxM6alrjLWE5IY7JKW2SfsQD0dRU9cMuFa6H/abqruh1C6SPCHMdQXp7xejsideo66GZ71tDmV/S/ihQPm6viBpN7z4ulJ75ZPx7IxymDnInBXuqTDXeJrPv5IsG/DNVq+F8s1Dn3wsCpnGUaln9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RBAqoSIx; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso6212354e87.2
        for <linux-spi@vger.kernel.org>; Mon, 23 Sep 2024 02:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727083686; x=1727688486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2H3lLogo29T09ZIg4O5267APGx1T56CgiRzH2uFGiY=;
        b=RBAqoSIx+RVn8QLjrhgFcTEvyiTWLGut/hdny5rdecWBShI5CYoOtYoyb+Mu/QLt58
         zKkdIKr2KQrBZXg1+yxkSQ9h42jobYliJrNsBifx6q/H8TeCNLQqWOcOmUL8u2qSKIsN
         8sywRZq/Rkvf+gb3AxVYacBLhjcqeexz5IFs6L1aEU0cwr9fj4k7LmmeBUUnOgxRrp4h
         vh0VTUAbPalneuV1+T8yHKardhv/jzSsKGdJQ9DCn42SPiPZtf1w19oy5JUql3ktBGMp
         P+XBkaQUVmIeWOkiEqcPiLnZdiIHLEQe62A8uau7Pu5z6kEtdn3k0JAJhdLhS2hZHxDf
         8YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727083686; x=1727688486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2H3lLogo29T09ZIg4O5267APGx1T56CgiRzH2uFGiY=;
        b=t8BBPUwW0psdjrW/54sFfC8yOsITXOE60FhUyvvwaIYsVgR02DEP/MZb8HD6a2CknG
         7oNCJ1Xb83h7w0rc6woq+WiFMWilozcKKuNV9W+Bdpt/Zy2Puv+OIbm1VSIxaa91md4U
         cZe0nycwICPTfRc7zbE4FzjGwfrWp3wD9lyXKDZ4uzfwnp25urlJZ2TSrBR++zY0AcxN
         ZWXgSzMg3OmluprKT/wmcdyAggu4AKnJ5AiGm4m6cU9RDifboWYrPjVyjJteJzeHw2yL
         hUzQg92TQ2PBh1uTbyrGnhMZ9PBCOI+b84rir9R0XrtK3pzF/Lm6slbJ96YM+GWjhxqH
         ilhw==
X-Forwarded-Encrypted: i=1; AJvYcCWpvTSAC+2Xoz798YcRPaL3D/OlrSxnIwv0qIPbfk9lEWfEgG2fj5hMJis0ecLz0qY6bExMMvQ+M+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDgfwR3aGfVg58wHuZODmyz5EtfDTgPzKy4LueoQiA2wdJmEcx
	tEv2+gCOG2IFrDSsgudSp4HZzHEoEInhVn40aUz+++SDYxy9q6KKLwev4lHZonxSAKHoRflTAZK
	grQO+XioQqmzGr8Ui4uwWECNvHlk0Q/Jv5OLxMQ==
X-Google-Smtp-Source: AGHT+IFqcb5VcpmKktw95t64Q/tONZlUY5uMG8agXKVRR1VFK+H/O2baR3jHivWHjY41tZ/ZQZoJrQNpCocxjyIuWM4=
X-Received: by 2002:ac2:4c4d:0:b0:533:45c9:67fe with SMTP id
 2adb3069b0e04-536ac32ef59mr6887747e87.48.1727083685755; Mon, 23 Sep 2024
 02:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
 <CAHp75Veusv=f6Xf9-gL3ctoO5Njn7wiWMw-aMN45KbZ=YB=mQw@mail.gmail.com>
 <0e3902c9a42b05b0227e767b227624c6fe8fd2bb.camel@maquefel.me> <cff6b9b6-6ede-435a-9271-829fde82550d@app.fastmail.com>
In-Reply-To: <cff6b9b6-6ede-435a-9271-829fde82550d@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 23 Sep 2024 11:27:54 +0200
Message-ID: <CACRpkda7Kef-buHQ3ou3q_xq+OD9-cONh1Ynu-KjvQf=Qx5S_Q@mail.gmail.com>
Subject: Re: [PATCH v12 00/38] ep93xx device tree conversion
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Hartley Sweeten <hsweeten@visionengravers.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Lukasz Majewski <lukma@denx.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Mark Brown <broonie@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Ralf Baechle <ralf@linux-mips.org>, Aaron Wu <Aaron.Wu@analog.com>, Lee Jones <lee@kernel.org>, 
	Olof Johansson <olof@lixom.net>, Niklas Cassel <cassel@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, 
	Netdev <netdev@vger.kernel.org>, linux-mtd@lists.infradead.org, 
	linux-ide@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-sound@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 5:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:

> I've merged the series into the for-next branch of the arm-soc
> tree now. The timing isn't great as I was still waiting for
> that final Ack, but it seem better to have it done than to keep
> respinning the series.
>
> I won't send it with the initial pull requests this week
> but hope to send this one once I get beck from LPC, provided
> there are no surprises that require a rebase.

Thanks for picking it up! This is a long awaited patch set.

Yours,
Linus Walleij

