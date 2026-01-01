Return-Path: <linux-spi+bounces-12178-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A0CED7A2
	for <lists+linux-spi@lfdr.de>; Thu, 01 Jan 2026 23:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A33A3004C85
	for <lists+linux-spi@lfdr.de>; Thu,  1 Jan 2026 22:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36726CE11;
	Thu,  1 Jan 2026 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryZxsXkX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E32417DE
	for <linux-spi@vger.kernel.org>; Thu,  1 Jan 2026 22:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767307368; cv=none; b=C1nmZqh89GKoXjWqKpjKFmXIwni/6g83wFTsGR1T6Xuq7GCCqg9EDIWaguuwkBwEhnQPNYy4ZPOrX9z7iWMBmdZJYpQvw/6yoMwOu/sgmFWercGcbAuugvoMQLSllrdaUgsZGPJCcmZJ7brzJKngtPXE6P/uC1xicfzKLMDdo4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767307368; c=relaxed/simple;
	bh=c03Ouoop/OW3SvavreidSQNFjtJjTLM/VhWkUCy+XCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TETU+3vkE4Spja/r9dZCpDIKeZJo9MJsU49YZxud+VBfpQ0nJudlN55dLjkEr8XgqYubggVlLJ0Rl/U6lkQ+hGn8hMUj2+AWlk2iDXjqFXuFqeiUGFhop2d1e+uBh67ZTlNTOxe2c0q0aK7QpR78aB1BS0h492f3rWJOUrA2jVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryZxsXkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF5EC4CEF7
	for <linux-spi@vger.kernel.org>; Thu,  1 Jan 2026 22:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767307368;
	bh=c03Ouoop/OW3SvavreidSQNFjtJjTLM/VhWkUCy+XCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ryZxsXkX2A5BlERIpG9p4sMf7Xbu47Iqut65LWm5eoubtMgGNIUccUg6ms6KoagMJ
	 0GlUPPWrdl15h/CIYeyzFV8GziyNOl6LhZHjywiGqqkNugSfhsWCUQiHk3D3QpwkWd
	 a2v2agOk0F94oWc2GlRnZSG5PHXvq8owxhrDRrP0XdOxD26mmW6dLhoKS5Tzlsul6J
	 ArOMjy5fN/ZKU9/y3RCSRFju5Enz0uJzCX2q7qnzhrdrEXvRZ5IS4KuR3ykWzw9ig3
	 cq+ygrD/7y/MqBrQWz55srKZq1GpZm3nSqze6Fd3woh6J1lPUMLodL1+w8oJ1A7N5R
	 +B5Aki8T2hbzg==
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-640c9c85255so11532522d50.3
        for <linux-spi@vger.kernel.org>; Thu, 01 Jan 2026 14:42:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlK6Lc24289fU4LVq5Dt4XOg0bK+MqL6b2MQ1H0uYdk3P90LIOPA5jBvDeKWjoy7C9xw3sDSPtHyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIk1WoeZyqJYXVQAihyATR69ZG9Fc9Qo3Reqap95P2r9egaLdA
	GeCmXPJq6j7lUUzOE0oGj3lZWbnOxlm4E4OdjW0E2iP9/nEnge047eVp1FdJ9KXirlE0N/dLNyD
	CsVfgQm1h5Vg/4b6Z+5CHv+oV69SVbLY=
X-Google-Smtp-Source: AGHT+IGuCSdWh+iJDmbFEBp3W61sWvSWqQfdLVlCzvdLNew329ciqVsgcnUXKXJoXSwcIcnZqwOTDxMTLToTAL+paPw=
X-Received: by 2002:a53:b701:0:b0:641:f5bc:68d6 with SMTP id
 956f58d0204a3-6466a8c5275mr26057369d50.83.1767307367560; Thu, 01 Jan 2026
 14:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217-eyeq6lplus-v1-0-e9cdbd3af4c2@bootlin.com>
 <20251217-eyeq6lplus-v1-11-e9cdbd3af4c2@bootlin.com> <38f097cb-5329-4b91-b1a8-3eb5fed05ad4@kernel.org>
 <fe9e594f-9718-48b5-8208-fb567a54cae9@bootlin.com>
In-Reply-To: <fe9e594f-9718-48b5-8208-fb567a54cae9@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Jan 2026 23:42:36 +0100
X-Gmail-Original-Message-ID: <CAD++jL=7eU+jSHn0t2KKzHjipXYKoQreOdaHH8OcyriPmwHJQw@mail.gmail.com>
X-Gm-Features: AQt7F2pQQoDMhu8lNy4TdUpYluCLS90ViEjybo-mgp7DpUhoLaNeRiZuGoShcsE
Message-ID: <CAD++jL=7eU+jSHn0t2KKzHjipXYKoQreOdaHH8OcyriPmwHJQw@mail.gmail.com>
Subject: Re: [PATCH 11/13] MIPS: Add Mobileye EyeQ6Lplus evaluation board dts
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Gregory CLEMENT <gregory.clement@bootlin.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-mips@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 4:57=E2=80=AFPM Beno=C3=AEt Monin <benoit.monin@boo=
tlin.com> wrote:

> In my particular case of a microcontroller acting as an SPI "relay" on th=
e
> evaluation board, what would be the best way to describe it? It connects
> the two SPI controllers of the SoC, one is a host and one is a target, so
> it behave as an SPI target on one side and as an SPI host on the other.
>
> The trivial devices bindings seems to be dedicated to devices, thus not f=
or
> SPI hosts. Do I need a dedicated binding or did I miss something I could
> use for a trivial spidev slave?

That needs to be detailed and discussed with the SPI maintainer on the SPI
devel list. (Added.)

Can you illustrate with a picture or so what is going on here?

Yours,
Linus Walleij

