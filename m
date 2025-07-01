Return-Path: <linux-spi+bounces-8940-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B24AAEFAB9
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 15:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2AB16FAEE
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 13:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAC727781B;
	Tue,  1 Jul 2025 13:29:51 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34986277027;
	Tue,  1 Jul 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376591; cv=none; b=X9hobdVrDyJ3X5NyvajAVKp0mrchoFNNZ1mh2UzgpibXXC59W/wmeO821/KdX2O6+sD8g9fDvI04ZgmFMj+Dw8v9nR+CJd755jxyJz5cntXhtkNdoP527YPDaBUsmRvWUWzuYQF2SFGoqyFpsYnRUiQLXWePddCSTer3N9Waz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376591; c=relaxed/simple;
	bh=r85JIcQVfKAvP2MU3yy8LAWPTHXqk/NQen18K5AkxnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpWNvlZvDT6V76ucDzUw3Qw2Zrs3P0hQc8HsSsWGJhiJNuqq+Y7dw64z0iLI6keAzQwwj0ZNr6NYd4vi4UayyiXSMVpkZYnl4zNnrDGUreJn9Aw2HrQNaS0aAf8zlewQEeoge2owDVx5LNPQq0Bt3WYIRFVO9tl88f3JTrEpFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5315acf37b6so1086983e0c.2;
        Tue, 01 Jul 2025 06:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751376589; x=1751981389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvQWg/KAXE+W1cqr+mQzG6Y06+2exxkzRfAyEp6GekI=;
        b=mfXBATksMrpi6Tnc2QHh5pQVyg/zmgsCINT5rgzsNmsWsqYK1Nk4BbOEOmAGd6/4Z8
         yKG16lkumbPfG70oqjm8XGUovU7EdLWKxG2DYNzUJafrlAzEiOFJMKcg4s7GCinxY0jp
         9L3hii91aqCXrKsVjgjisSYMeZcx80sMr9ndN1Zak1LI8JpoqCM/5F/CHB26pzxvhen7
         ncZaTiowHR4kd+sRIBPBQA0D4i+nkNUgy27I5qzrQOlh/TU5mwkqqd4XGUexak3rmbp7
         B9+5RTiyoNG5ZSz2tYyWxNUV/dJGkKI/gt4FPWV0BP/q8Ikskdn6YAeStDZBcc3RLIbr
         RDAA==
X-Forwarded-Encrypted: i=1; AJvYcCUaCtAnY/coVxA7Z02jobO6HV8p+nOUpoxxsBX/FLtG+QAVzO6G7sZCu6kmY8YOpcexQ+X+bK92XHsTRcPBcZnFbvM=@vger.kernel.org, AJvYcCVO8xeNt/Su9DUzxZohPsNZg3Fy9M2ptKT6+JW5Tjs/kbhDuShzbhcYyRpKRuJ+kDyhxZLdvIrezgvy+M9k@vger.kernel.org, AJvYcCVm6yJ1Rqz3tIvgZHc4r1B7m+zyeq37RbwHOnx0FEfIF+jAjaIQrQ6Fl3Tr701OXynqqYASuppW7sEL@vger.kernel.org, AJvYcCVrmrTJrViL5A8ZAgkiUQtUWrGAx+5NnzYyoaHo3ap21VpBDLrO681CJp+119FJebj37FwhxcdebArW@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPK2XITfMMnvUDGh9zuQk3ZpPfeRnOMt/Zi3i17nRS5CP6BeK
	Anzwh+BpBcGJVCX0Sl6IVLRAkNKzZINylS4I3v/ZEytwOw6XpPhhHCbSTy8L5z1K
X-Gm-Gg: ASbGncvjuWZW9cIVY40Ev+Ecl9oXv0OBWPMHAUQ79lfDZBdu0qyozkT+VZGJ9jzy4bv
	MeXpkNelPNYmZ9Xs4xE0cKMaJzvRE+i10n4uLCPnLcR8MWIPc0WSdKBPCZNOzN7cgBj1SgwR+8/
	xtEZwATT+WBAmbRx8dDKgziCdtrxBStdgSeFGm74IgZBiHRpYa6QV7dRdIS1CcmvtMZfA0JQHVy
	FJ9z+hLd0GewTQJNsMaRVrMxAGclhDRQTGGB+++g4XlJx50mNo5Hq7mJjvea7Cz13l77sob5Pfh
	soFgX9L7n274Tx2jurRMPR7FrxdE/YUDrs9XqqLkQxGyAmt/eWjN2GPlBxhkAzeZRmCdcp4dH9R
	7K7tAk5KvDsqVgc9+5gOhqf61
X-Google-Smtp-Source: AGHT+IGofVFj5BCufNooPWH1kTgnE466noi7EZylppcdbfVi6EeCp3Yp2n33S+sBU+/27zJlgpgyiw==
X-Received: by 2002:a05:6122:2398:b0:531:2906:7519 with SMTP id 71dfb90a1353d-5330be9f389mr10622295e0c.5.1751376588832;
        Tue, 01 Jul 2025 06:29:48 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-533090ba456sm1730033e0c.17.2025.07.01.06.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 06:29:48 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4e79dde8511so643967137.0;
        Tue, 01 Jul 2025 06:29:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUW8epSqmBi4l+V6X9sgytzz29vhPI6h/FJGupEZOm/LYRa78Kz3F+E/oLQKwzG3Fkl4dfmHJ5xnn+Wp8cK@vger.kernel.org, AJvYcCWovOJ//7d1ASQWG1XqljDQELKfhsspv7qxkjw7sM4ZYA/15r2FJUqmwM9FVfuOYWtlQgp58nHfzIOKuYMgTzt0xKQ=@vger.kernel.org, AJvYcCWvBp2aLiPShfEkIJX0eHHr0KFYnpiotsMsQGv0qFEb6biDOfqEcH8VVrGv0DXxndRFoaKOZ8oJ2thq@vger.kernel.org, AJvYcCXVF3pvHHIb8wbWyOXMd4wQ4yLbm2PE/flwgKZlNdLeBHaJxEzOQ2mDPzFsDs/yn7u7kTTP1CjRwFjb@vger.kernel.org
X-Received: by 2002:a05:6102:3581:b0:4e9:9281:85ba with SMTP id
 ada2fe7eead31-4ee4f71e304mr10080851137.13.1751376587959; Tue, 01 Jul 2025
 06:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624192304.338979-1-fabrizio.castro.jz@renesas.com> <20250624192304.338979-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20250624192304.338979-3-fabrizio.castro.jz@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 1 Jul 2025 15:29:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXBgW74FFHSceMN2VmbB5cxhcr+Mgj8V9ftm92GT2Bhrg@mail.gmail.com>
X-Gm-Features: Ac12FXxXwXEv1OIWuqxs24AQl3A2GwHdZmuX_cxVZ6ujj3pPp_oEqMNjfa2euUM
Message-ID: <CAMuHMdXBgW74FFHSceMN2VmbB5cxhcr+Mgj8V9ftm92GT2Bhrg@mail.gmail.com>
Subject: Re: [PATCH 2/6] spi: dt-bindings: Document the RZ/V2H(P) RSPI
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 21:23, Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> Add dt-bindings for the RSPI IP found inside the Renesas RZ/V2H(P)
> SoC.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

