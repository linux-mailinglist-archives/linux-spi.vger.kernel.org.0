Return-Path: <linux-spi+bounces-4438-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09748964CF4
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 19:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CD71C21FF9
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ECE1B5EC9;
	Thu, 29 Aug 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="LwDcgTLI"
X-Original-To: linux-spi@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14540870;
	Thu, 29 Aug 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953125; cv=none; b=e7L6mcDI12hhh3IplJZbqDQoGXjT9XSKVuAkMpYOuU0qbg/v4DZyj9kJKuPRxa89z65LEJFwti7lk5F8LXwmF/zt0zsuFXNSK6o0s/MKh66A+5qPyUnZ2jiZivXql8jYymRZsUa2Cb8Iz1rga8lAPKW9PrFQMFTPPfgyHbObFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953125; c=relaxed/simple;
	bh=5aKzWUxu+SgrOAXTrUwiVjJleQ8F73mD9s7RMZvo3RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ye3j70R0qrVnB1Bi2dQWtrHURsrlI2s8qAzHiCQKaaFcGjxivh7AhdS4HUXS+bhlKV3tCs4sZgoVBF0RhGqQ6/vv4hJXqtQO03ZjhmK10Itf1jnVxJKxWKN7FWf2ai/rrAyg//ZTnE1wv/b9QMlZU5/Tzg1o6lO9VCJ8oZHGNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=LwDcgTLI; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5aKzWUxu+SgrOAXTrUwiVjJleQ8F73mD9s7RMZvo3RE=; b=LwDcgTLIi5fGOlmoMDW665N4x1
	ZUt0uRX2yfTlH7Q4RcZFt1V3vRawsOhcVt56tidIQv7oiZom7qx///N/DblKCWzpImxfbpikqKDhd
	yca9Zu88gTpYQlWZFlNWuOG0J2RPk3CLBc7pe2Tn2ssE2OwEOygCozGRf993H+kicDjqBl77FmkWN
	BfUF7LmlnyQK60iKDmLS8Jbc3MfCxw55p9yt4Z7oQQ0ansje1KpoWxfuJTdNpSB9Pr1bxVCTEahvl
	YBKWAu8V1G7gD44EAJZ8JTo1TyoLW5hfwSLj2SX/7dYq8NRkZCdAR13ypLOhZTNarACbL1IMcNc1k
	ke/yY/cQ==;
Received: from i5e861916.versanet.de ([94.134.25.22] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjj6X-0005o5-KS; Thu, 29 Aug 2024 19:38:41 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
 otavio.salvador@ossystems.com.br, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor.dooley@microchip.com>
Subject:
 Re: [PATCH v2 3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not describe
 unexisting DAC device
Date: Thu, 29 Aug 2024 19:40:00 +0200
Message-ID: <1797535.7aRn1RRit1@diego>
In-Reply-To:
 <CAOMZO5AseqaMMR8au8gPE4oUkUWnhxeGO5CeZTknWck9meFmug@mail.gmail.com>
References:
 <20240719111210.1287783-1-festevam@gmail.com> <574443966.JY4mfKhWER@diego>
 <CAOMZO5AseqaMMR8au8gPE4oUkUWnhxeGO5CeZTknWck9meFmug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi Fabio,

Am Donnerstag, 29. August 2024, 19:31:58 CEST schrieb Fabio Estevam:
> On Sat, Aug 10, 2024 at 6:23=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.=
de> wrote:
>=20
> > Acked-by: Heiko Stuebner <heiko@sntech.de>
> >
> > Mark, do you want to take all 3 patches (fine by me) or just the
> > first two?
>=20
> Mark has applied the spidev patch on his for-6.11 branch:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=
=3Dfor-6.11&id=3D5f3eee1eef5d0edd23d8ac0974f56283649a1512
>=20
> Could you please apply the other two to your tree?

Actually Mark has applied patches 1+2 from v4 it seems, so I grabbed the
dts patch from there too :-)

Heiko




