Return-Path: <linux-spi+bounces-11586-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C562EC89805
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840043B26B4
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 11:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA1D316197;
	Wed, 26 Nov 2025 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHcYHLIX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C798248F51
	for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156389; cv=none; b=W8BFYwYIpmWRDugXeMCh5daIQSaoRlSSmNtdO/YQuC9JqQyDLaDkfcto/B1J8tJW//IodueKJFebfUkim7+A2eccoHENGe2amfEwBWW+Y9MupkooVwSpCDDBLwc1mOL0Hv+kChcpQi+oFhh9bCI6mr/DCU9HkQL1ZCQtenz+Vn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156389; c=relaxed/simple;
	bh=8MYJEKcWCXXBqMxXSe7QIFRKD3q14ks241owAbInshU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWLst2dymgf+0BR/GFX/6FHo7Gvz0PHIuB2vCPz+cnA4MbTJLN//1lPy590ybCUuZuONDToyX4kRd4OlAsA3hk791F+mPgGbLh5cdYIC/nSwXG7TAD2VbLPXo/KBMB9iLQHxcc3BgBsyltq5kndMHOWvycy331NdUeV7DxZVjWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHcYHLIX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so3829353f8f.2
        for <linux-spi@vger.kernel.org>; Wed, 26 Nov 2025 03:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764156386; x=1764761186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MYJEKcWCXXBqMxXSe7QIFRKD3q14ks241owAbInshU=;
        b=PHcYHLIXyst2tsSlv0D7deOi6qA4k4F78PQ4SVJDGs9JFgF3M4Ew8H20q++O5qJwQx
         3foyHFBRfpmO4AxMxud4jl2k7+OzPZ31Uy1+pkPK2XxBnWLJLT7ucgZP9JvuHzMTSh1x
         +AKXv0LKXDtOakzTzNrKhjKopPwn0mOoWsTmoWwlL/uCIt9zA8GOkOuU3JlQeu5iMkNJ
         AVKbkZrzgz61DTlRe3YF7MMGC0QOU9+nK7AEDCez9VmkU9Ata9sYm51DWTOwub3ogTS0
         VObd6Hssao3gscZcASGHXsIoHJFjmzsRg/0VQOi2qa+53+k5cZe4O3nKE6mRVg5lOUz7
         ZNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764156386; x=1764761186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8MYJEKcWCXXBqMxXSe7QIFRKD3q14ks241owAbInshU=;
        b=VnzjAfPhTgHz3JUzw2n5Ywjl7Bur/wt6lNuOsETc7eqogcyIrX4nBBdbplrLtFRCEY
         2u4TiP4OgZP7X9cCpcarrkCTYfX2YPYtq7iHqwcfHdI5WjHP5lJLFJRXyShmw8fxWfpy
         lubLMb/SDxppcUOyjqb4B9bWc3+S0wOrYpqnmKabX6q/lF7j5sFiXQzAcDyznVERQIZF
         Y9adQPkao4uTulK+O/v5wE8101pqqRCPRT3uwCUmc+doy51rtyy+AU78yiq1Bp/XmPmj
         eCdHic8z6hK9P5YL8y3YbxTUW6xw65E9vir+W2mjR5ew3heyNzaS2OabHBtztgA9jHYy
         q4dA==
X-Forwarded-Encrypted: i=1; AJvYcCVOyOViDvzh75MAXE9sAAK1oc87H0IlPG/EDOJcJ8zyHnD94GGyxWrVbnyqdtaA0FB1BNTKaOHpxfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYxnESU89/KTAJ5o9xFyVs0EcLyJfEdPlV8wklBI2Js6rKKAb
	sYOh0tIELEgENP1ncueb+/InkO9+s5eIAlLvOPYAN6Egiq8RYl9SOH7FD0SUt4PKnEb/p6izwX4
	3A8FvivvVbiM7n3EceGp7QToTIILIh9Q=
X-Gm-Gg: ASbGnctmvjz+r8dLsHta+PP+co0k50LndOYVrVDURz/82mi8T7rhFIzMfGLmvmYas1d
	hyaZB0D6jTvXyCPRrx5/JMMJEbxoPDT7rSpUzmq7LgH2/So6mzyK9woTYcvq7PZiVmN+8Ri4PQX
	DpqQJgaYGQl5oX7ktJPiz+EFlpmZzJYcfbxZI2vDb6/pdTdHTsbhzwgakcUSN73Uw/Fr9mhLRLY
	ftU+d4NFWjUHS6HA419vnIdYQEZ3hnwzzCsQ5jVWOHAdw8nnQ/Ut1Xm+Z2m7mObC0Hz5EY1T57/
	Yo6i8FVhYd9qYylDaTfGTq+5BXQK
X-Google-Smtp-Source: AGHT+IEfxH2gmbZjPvKqNRvwXZKBYKL2SIu7e86pEBjVM24jiUKghAqZeKz7p8L/eyLcZFzkOO7av5Wei6NJvGffvgI=
X-Received: by 2002:a5d:5e01:0:b0:42b:3e20:f1b0 with SMTP id
 ffacd0b85a97d-42cc1ac9b39mr19266519f8f.7.1764156386428; Wed, 26 Nov 2025
 03:26:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125214529.276819-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <a406ed6a-fe64-408e-92fa-e8acd5b5a4b7@sirena.org.uk>
In-Reply-To: <a406ed6a-fe64-408e-92fa-e8acd5b5a4b7@sirena.org.uk>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 26 Nov 2025 11:26:00 +0000
X-Gm-Features: AWmQ_bnQBHmpRAU8OCjX9DaZotrDkjp5pmQOqZ8wHmG8HVTaSnE831nFJrDwISk
Message-ID: <CA+V-a8vn93Y-tQPfv6kZ2uSuh4kMQwkihZeqzNZNC2RzBeabPg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/V2N SoC support
To: Mark Brown <broonie@kernel.org>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Wed, Nov 26, 2025 at 11:21=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Tue, Nov 25, 2025 at 09:45:29PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document the RSPI controller on the Renesas RZ/V2N SoC. The block is
> > compatible with the RSPI implementation found on the RZ/V2H(P) family.
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Thanks for pointing that out. I'll make a note of it for the future.

Cheers,
Prabhakar

