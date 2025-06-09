Return-Path: <linux-spi+bounces-8383-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B5CAD1656
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 02:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91083168A9F
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 00:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE76BE5E;
	Mon,  9 Jun 2025 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0tiGd+r"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F2F2940D;
	Mon,  9 Jun 2025 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749429656; cv=none; b=Q/6NblVVo0OG0xQcEeemADxVnwrD4El9sMx3kaNNTyNHs46HZ3E5Ad+80BfEP/2p0aUXBcqYyddbfIhHE8DuJnUIRqXF60rwsxN/2GwilHMFUZnWukVARgvSDyEPH+3IHOIv5HcwemPm0Zem0LnWEOjW8sf23rY66BrC9V/oOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749429656; c=relaxed/simple;
	bh=NQa388CWjqMDkWx8PoNYlVQNYYmFvdWxEoKiO5JqBx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIy6pP8nJiKS9C9ImdYYTXnHqkCvS8sNWMWfkReOBU4cqX/6+mTwmeu48foNPli/2gKWDgSCFrWIIbZgZThLj99zTHkz4zH5yxf1Td2+GPd/NwJPUak/5Ep/02IT5w55wkX6hB/7gDsap6QwhrWiKUdbDEQdtQYzeA9obW1gq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0tiGd+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E57C4AF0B;
	Mon,  9 Jun 2025 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749429655;
	bh=NQa388CWjqMDkWx8PoNYlVQNYYmFvdWxEoKiO5JqBx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J0tiGd+rVfAxBVKHaqXV9aHR5kE6TpS38gQuhGcAmc9SPaS0o8LnGDtM09gTZA2Qg
	 w+jnrEzqA8p1IOIGIpkDEoUZm7S0Gh+w+AKk+GCUfh0s8/lL9KAvGJM34oxG3aF01v
	 nRzBQv3Xxz4vem8IDdpvoFjksCYUiGxdz2uFdLjeu7LzRZMldYHcFmZfWOss1spNut
	 SlxqBJYK+3fJw2hPo+mNq4/o2xDzjf8MP379XywKxbfZBdEfau81GtZpg0ap4y9g2m
	 2lJr7MgBPz2zeMK6qk+Baigbf0XBVGTKFSZ88JU8xeZIQXhvfn3gzvMsJg5wBs66qE
	 hXvlmwS6uwpdg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-551fe46934eso3951629e87.1;
        Sun, 08 Jun 2025 17:40:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1NHacFZD52TXN1c24NWLAXORfvOAs7hgsLfr8EejwBfGFs+S4jzRv/cHGkah7tuDNVyT/QIrar4NB@vger.kernel.org, AJvYcCXWyuKQT+bQsGPttpyDTT/mmQkcqo11LmKQ1b5Jq8e9GyuDjVANNXq4WPXtQuzdfKdros1W4z+ZlSsRpNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYquVVIeQeN5gcwS36AjM4JWcTEpZrjs9MEyf9ay2lhsqNmZg2
	Jkb7nKFc2QDvnOi92lPN5GcmqfEPwFn2J23dLeFG2ewysnuZpJljXu7jFefEI/3gLhLNuyhsq3c
	RsmZgO6AZ0rf4zikqAlM2Om4LFECfDlA=
X-Google-Smtp-Source: AGHT+IFYqKbp5NZGkm22RwW87sW2Cw+HB5w6DZtaRArmZyTvnBiJRC4yqEMx9CqmURD7VsiebRXaMDvAgjZv/XtxTwE=
X-Received: by 2002:a05:6512:3b20:b0:553:2912:cfdc with SMTP id
 2adb3069b0e04-55366bef559mr2967944e87.9.1749429654533; Sun, 08 Jun 2025
 17:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608142939.172108-1-chenhuacai@loongson.cn>
In-Reply-To: <20250608142939.172108-1-chenhuacai@loongson.cn>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 9 Jun 2025 09:40:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASxV5wkKCzUv9=vzV2pFzoZUfrDa=s9vL=BYS2FyD8w=Q@mail.gmail.com>
X-Gm-Features: AX0GCFv0NxWLpwGU12-O7NuiD-jBYHR2REPE-qFLgOMLXhHyPCdE4ESVnu1Y3Ts
Message-ID: <CAK7LNASxV5wkKCzUv9=vzV2pFzoZUfrDa=s9vL=BYS2FyD8w=Q@mail.gmail.com>
Subject: Re: [PATCH] spi: loongson: Fix build warnings about export.h
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: linux-kbuild@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 11:29=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> After commit a934a57a42f64a4 ("scripts/misc-check: check missing #include
> <linux/export.h> when W=3D1") and 7d95680d64ac8e836c ("scripts/misc-check=
:
> check unnecessary #include <linux/export.h> when W=3D1"), we get some bui=
ld
> warnings with W=3D1:
>
> drivers/spi/spi-loongson-core.c: warning: EXPORT_SYMBOL() is used, but #i=
nclude <linux/export.h> is missing
>
> So fix these build warnings for SPI/Loongson.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>


Thank you for your contribution.

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


--=20
Best Regards
Masahiro Yamada

