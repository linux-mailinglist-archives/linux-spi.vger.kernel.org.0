Return-Path: <linux-spi+bounces-11649-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31028C92734
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 16:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43693A91FD
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EED26E165;
	Fri, 28 Nov 2025 15:23:02 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178C2580F9
	for <linux-spi@vger.kernel.org>; Fri, 28 Nov 2025 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764343382; cv=none; b=tLvAuK7wG4ZiUCln2Zs3b/r5W4Gbffvrkp+tlVUJA94KMfcMgMvz0Af98xnMvTcbdwn4YRmyDWR/IhNbGRGdJgtIUw735W0QXBdMj1coYs5GsTDAUY8CMz+bTF0lSOyBCau8rQpZG7ipvDElHcApJWY7xPQ48adbHrzGiLdNqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764343382; c=relaxed/simple;
	bh=xGb7W+NMwzRcrT9zxij5YLN4R4sOpAUKVyDvdKtijS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oB2kboXoigxsN0/JZCtBiJxTguJOGzyr1fFsl5Z235mmOEEWaxict61KeKsx2aa/MxBSVbXXU0do9enh78P/vXKY76ZEwqgEV3v9dik2OfunVZpCHXuEf8Xadf9wSo0GvimvkaEkPyj32dgXcYuPLun5HTZTRKxEgTFKdCnj6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-935241a7a0eso1175156241.2
        for <linux-spi@vger.kernel.org>; Fri, 28 Nov 2025 07:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764343380; x=1764948180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaRd9+5Gnqr9XLwdxnI+TeUBqhhaQUEYrbZmEOL5EOw=;
        b=h+MWvOSWCgbONE5IQFejxb8E0DoBjkCXJGFarxO/4CSg5Bx8I69Qx/Wlnr4Skhi0Kr
         /7qhgUOS14sbnXU2uuE73GW1ckHn1AnbxsCPI7ToYXbUWTbr7wQlZJMild0LdZJXO/7P
         iLe42+WpDZ9nsXKV07ip6AGFvNFklVBG8LubP+8MIrCEIZco2hcjgp0tu89UCmZIfvIE
         aaJIDJYueBjtu56cOYU6qkV8Osv/CLr5XcozFl5dUaSHcJwIEZnHn3GUIt+G+me+1Jpm
         m9knACnyq9wppl5vH2l5BMPccMgOlGP1uhorvVZfoqyptoU9mZW2CiL7DICB0NTqN/SP
         Deyw==
X-Forwarded-Encrypted: i=1; AJvYcCXlccHTMbwgNBAmdQ4Dwadf0aK97nZMduHkFuLGCYXAIbvOncq+qBl9JQmffFa/t1YOuaI7xGlxlt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV1TuEuWhVrTNJAxfwyz+vVrE0iI0JeKt0TB42+hT54yyERmTQ
	8wr1NLj9tsRTD74byzT+YXlIzYQA6AJxZC1GwG7TqEDdwxnQutWPR+iVtED5i6u5
X-Gm-Gg: ASbGnct7sWmg66DsaOI2puvRWPuGcxwh8eGQ4sBLmoNKqNBSLmZgTg8TvQm64co7J6B
	f/O/kDfxiSqpW3IWUVJsmINxcqrh/kwjHQhT5ArKSwdeb/YP1bwn0ugZGWSuAfT7twAo0sIhBI+
	K+CzmrPHa4BLBaoBPfGreEEx0r8szB7LcFyl3tYRgiwQriU98qcNWbv2PTjy6oJpnu83d89Gs9Y
	90bbjN6j/qGDQuxIadoXVtH1HnjuWaT46i+FR1XTun7g8L4EOwG71BZPjgt2dDxCHFQp7tzZMs3
	rlQQrhYiu6gcgohomYq1PBBOilRRkaJ0R6o4u7X3joasxJt6Dr+v82H0OpywTsUVmNTmik/pfCJ
	PlOw+QB9IAv87eCntmW8i+gdp/weBu4a4Ao0hnhdorL5RjTfKnmfrLgtK/bIkl7bemgQNrvGkHp
	CjqR+LPKWxWsoipqs3o4MWPPYZlnLhWz+0m/5sC3EJdFaQ9b4e
X-Google-Smtp-Source: AGHT+IHv0NVGHVxuZxFurFwFM775zwt7AJQ0+a8/HCeXicZN+hnf/wc1G3nwji7K5ksE2yjxjWhmlw==
X-Received: by 2002:a05:6102:4424:b0:5db:23d4:feb1 with SMTP id ada2fe7eead31-5e1de00d78emr11156342137.2.1764343379625;
        Fri, 28 Nov 2025 07:22:59 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd76939c4sm2133873241.15.2025.11.28.07.22.58
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 07:22:58 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-93729793469so1226063241.0
        for <linux-spi@vger.kernel.org>; Fri, 28 Nov 2025 07:22:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjFSsI5SdFKT4mSvzfJdZPoPoL9lfTD38J7Pem80P6w6rO4oWHimofv65P21Vy6x93u+VBQZhHA9Y=@vger.kernel.org
X-Received: by 2002:a05:6102:54a6:b0:5de:736:71d9 with SMTP id
 ada2fe7eead31-5e1de273d4emr11133048137.28.1764343378522; Fri, 28 Nov 2025
 07:22:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251119161434.595677-14-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251119161434.595677-14-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Nov 2025 16:22:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHMMtav5Ut3E9ZLCn8ctgKPrDNS1+VH_pcAE7g1wcDnA@mail.gmail.com>
X-Gm-Features: AWmQ_bl5PKL50rYW4UUIsJnuWXmjVe8JhNsQZw71eBLgtSZKnqiykuu2HAMxZ-s
Message-ID: <CAMuHMdVHMMtav5Ut3E9ZLCn8ctgKPrDNS1+VH_pcAE7g1wcDnA@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] arm64: dts: renesas: r9a09g087: Add SPIs support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Nov 2025 at 17:16, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Add support for the four SPI peripherals on the Renesas RZ/N2H Soc.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.20.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

