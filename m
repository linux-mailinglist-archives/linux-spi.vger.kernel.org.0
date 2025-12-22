Return-Path: <linux-spi+bounces-12073-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EA7CD515F
	for <lists+linux-spi@lfdr.de>; Mon, 22 Dec 2025 09:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8518A30206B2
	for <lists+linux-spi@lfdr.de>; Mon, 22 Dec 2025 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79056314B62;
	Mon, 22 Dec 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB+rBlov"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52067314A7E
	for <linux-spi@vger.kernel.org>; Mon, 22 Dec 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766392403; cv=none; b=kdC6GOShG/ywC7i33OhaLVBVF9QausSWKtPdzg1ohtnyzbIvpmg4Nx4isaNAk1Axo0kVAzYZcWr9Jm/2laAfW6/tTLBO5tL2BnXRVFWDa4rdudM4vpnmZmUZ/Q25o5IvUD8/7Ws5jpM0OunSzZLAwdKqW9V1bdmWDu/D3XIeUjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766392403; c=relaxed/simple;
	bh=rnF5+/PRAEhxUkP81f8iZpYy3Jrx+97OUsmm0ntfnw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQCL7+ajnvoFVQ7JvrupyS0UGXdxAACLE0i8LOr+cV5UfafU9nl27awK5aIVaUnAU36AgE0fK1yWB3Lj+JmV9BOtXp00XwNtZiWuTUKtitpHVz46XWi3WTWvfGerySqSnMXZ1rFrlzq5Gem9qNp5CMUdxwar2mMG6IeIjb6mOXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB+rBlov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B96C19421
	for <linux-spi@vger.kernel.org>; Mon, 22 Dec 2025 08:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766392402;
	bh=rnF5+/PRAEhxUkP81f8iZpYy3Jrx+97OUsmm0ntfnw8=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=eB+rBlovTV4ziI+v1LW8ihA/IJbRmMiLRDpXWgTZvqVJ7k1c9UJzT/t31F1fXbqry
	 7icB2etdeKp3B5jnX1RzVFxTX/HeIQ0Y+jw+11KcXbUjdt69Bp5wVgYx74cShp1Fvl
	 Cpl3od/Vf5EyS9G6pUVcc/mM3pSPFACuqz/sGujtbeqFvxUd/jTx6sCwGiiQPk5cjo
	 TeRnkauTyR6w7ajE3ST9bVZ+DdhtliOYPqGCFg7BPUS/PKWzUlVYVz2lDt0lRZYDxe
	 DETKFemgesLM7gfcdX6a0IaJ5sqSY/8B6s4e4qx0ltJERC+hQnK4JAf6u4l7ahTkEk
	 Xvftki4aVXAkw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37a415a22ecso18840981fa.0
        for <linux-spi@vger.kernel.org>; Mon, 22 Dec 2025 00:33:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUb1SOhVlP30ssaHhAMQq0HmkpIVrfQDnfk++7VzIJty+qR8iXzmnlwIOSDxZmkSB68W8pI1zuBEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznhddN/G2hofzPW/FFcE3f/hnzqaGYmBzuigZdUjU71E2y8HaN
	jZwV6okrBlkcsD4br2TdumZZa29qGvDYcIWNL0StNKVrXedUncN1uJvPiJlZ6R0M0ptL4/49/cF
	yxczW1h86DjQca+pifpLwJ2+6CeaiW+Q=
X-Google-Smtp-Source: AGHT+IHB6OBorWsfY6+CIhWE8h0rTjrmy8Od+EzD/TbreAn6ZtgHO5Oaa3cC2BPxGnzahO2w6j9LzKizjq6i1v/7zLQ=
X-Received: by 2002:a05:651c:3050:b0:376:3792:1a9b with SMTP id
 38308e7fff4ca-38113295431mr42863951fa.21.1766392401138; Mon, 22 Dec 2025
 00:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221110513.1850535-1-wens@kernel.org>
In-Reply-To: <20251221110513.1850535-1-wens@kernel.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 22 Dec 2025 16:33:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v67NbSA8Fq16EL-zY9WKVxnYUosk6z7NrGtAXt6UY8xdMw@mail.gmail.com>
X-Gm-Features: AQt7F2qZlM3p2jvComgFcEXRa14BK_cQ9N8F1hZOpPR9GT9NbbFY1DHlKdoycxY
Message-ID: <CAGb2v67NbSA8Fq16EL-zY9WKVxnYUosk6z7NrGtAXt6UY8xdMw@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: allwinner: a523: Support SPI controllers
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>
Cc: Andre Przywara <andre.przywara@arm.com>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 7:05=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wrot=
e:
>
> Hi folks,
>
> This series adds support for the SPI controllers found in the Allwinner
> A523 SoC family. The SPI controller is almost the same as the ones in
> previous generations, except that it moved the "RX buffer count"
> register field to a separate register, and that register now reports
> the total count for RX buffer and FIFO.
>
> In practice the driver has never cared about the buffer count, but if
> any implementation were to use it, this counts as a non-backward
> compatible change.
>
> Also, one of the SPI controllers supports DBI mode, acting as a display
> interface. There is no infrastructure for DBI interface controllers in
> the kernel, so only a separate compatible is added for it.
>
> Patch 1 adds compatible strings for the new variants.
>
> Patch 2 adds driver support for the new SPI controller variant.
>
> Patch 3 adds device nodes for the SPI controllers to the dtsi file,
> along with pinmux settings for spi0 on the PC pins, a common usage for
> SPI-NOR flashes to boot from.
>
> Patch 4 enables the SPI-NOR flash found on the Radxa Cubie A5E.

As pointed out to me on IRC, this change targets the Orangepi 4A, not
the Radxa Cubie A5E. The latter has circuits for SPI-NOR, but the whole
block is left unpopulated.

ChenYu

>
> Please take a look and try it out.
>
>
> Thanks
> ChenYu
>
>
> Chen-Yu Tsai (4):
>   spi: dt-bindings: sun6i: Add compatibles for A523's SPI controllers
>   spi: sun6i: Support A523's SPI controllers
>   arm64: dts: allwinner: sun55i: Add SPI controllers
>   arm64: dts: allwinner: t527: orangepi-4a: Enable SPI-NOR flash
>
>  .../bindings/spi/allwinner,sun6i-a31-spi.yaml |  4 +
>  .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 94 +++++++++++++++++++
>  .../dts/allwinner/sun55i-t527-orangepi-4a.dts | 15 +++
>  drivers/spi/spi-sun6i.c                       | 11 ++-
>  4 files changed, 120 insertions(+), 4 deletions(-)
>
> --
> 2.47.3
>

