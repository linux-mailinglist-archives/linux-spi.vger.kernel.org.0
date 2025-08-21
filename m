Return-Path: <linux-spi+bounces-9578-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A294B2EFA9
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 09:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B76A26CF0
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59002E8E08;
	Thu, 21 Aug 2025 07:29:35 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD4A2E8E06;
	Thu, 21 Aug 2025 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755761375; cv=none; b=b5yYEWf3UTgDKCqXnIMg11OMqqii1m4XDEWKkfVq+lFpAtzz1zfCiaRI5uOfE8WqdfknaIoGHry+du1Xq+BBXdOhs/qCc2CVNqRqFk1Da+RaJcnnAVyXdMKoi2q7iEPDHnjQgP2rEeS71is/ftGY3dT1LacxQ9QRN5lg/qLTfVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755761375; c=relaxed/simple;
	bh=iV/sgvKsdc6jfoRmC3wV6sOvcmm8K914VALqkOHJAJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyQHZ+8JqWfk5qpEit1DrogSfTlapdEz1h6Cfb6XeMnSpLTPE/ZGFYovw2A4mo+DEHJAjz9U07dgTgSPTNJhppgidauiZYZZZC+uBCIQrqQ/h+zIb/RXb+dP/SlNm0Ug5YrzuooK+Z+uVOkP5enEMo71/3aOLoxq+THIA/vtx3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-53b1754a419so586457e0c.3;
        Thu, 21 Aug 2025 00:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755761373; x=1756366173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3Q9L9dp7ToLZeiw2ARDJHGLAzrOLFLICMnW+u6D2Rw=;
        b=xTCbR7mps5NbUUEJmCGxSN0mt+pbfNQoY1hlcE7kZW9JNOBOJim/UFjqMiRBWn1dp8
         q70PQHZp+arxq8atPf/IxMi3ZedbUm5gqc5HHBgetzs9WKALQkkGVcJv5H+Tx4WVwiJN
         xzGC7gvR/favIgrwPcrj7vD1k15yspaNQmrf9FSqy9qeMDfolhzE13I6lqEt+PvidJfY
         vNZeEcnC9QcW0a3tL9e+a+NJWGUxjhqvfapYzvcpDs895NtY0VJJ9RwD36Ctkdcf99St
         40bto0L5oVFhVckkdP/pOqE/I8MK5W3TgwxccaLHvbyhQ22kN1sXZ8g3ZzAjgHkAg4hR
         1KoA==
X-Forwarded-Encrypted: i=1; AJvYcCVSA2istuozV0tSCax1VWij8NIwudjo0eWvp1gOi86V12zY7Ze5Zlu72rAYJn2GPCGnUxsSXdh09k9p@vger.kernel.org, AJvYcCXGIJ5CSHQ2XEgiV92VrjAgC48uzVdw8m6oDFFSQWT/llFciPVgwc7XwBfgmZS+ChcFlPfgYRjzYD7HpH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxymgOjhmgX6WlRGqBPHHL4s1dppKuCj/xnlf1cIx1ZndHy+VCn
	SISGv8BnNO7FLmRO5tU5AoOlPCNbu0c5l0U2VMUTMUVVj5d0GZbUXeR75qKtTim1
X-Gm-Gg: ASbGnctvnd5o0QOAvcC78DdheiCQslD79D91b7IR6WbRX5R2xtvPxgmqZRJLAdT50zK
	s+Scffi2zUcv0UlIoIOPKpXaR8HyhugVFPyPdYuiVdOz60z2SpqNjET3xqoPgMT1f6w8iwuwEy9
	1MtVTdiSp6EsMsnv9zM59KRcutfj2QPLpmK641Q+youyF4UOnkwwhElMnbGFqB/NBd83X5x1b0y
	09pjeEcqWvE1jj6hFQOdWLNaminhD3J/dTN4Xuk0EozXNc0dQAu/5DwKdm0ClCByIwL8XzN7vhT
	XBOMd63upVPg7c5chZcz/B2mu+on/mG7y4tZNMiMuhiJg5TaQN5z/18dcdtnIUjQKKN0rSiRZwe
	tdcRO/sgVs78A9LMYY7us6BPcssnXy41sya0QdBn0Lhh7pbTI95Bl8AZ9i4Ue
X-Google-Smtp-Source: AGHT+IGW5DIJ6meUaMGpqvIZHGeyIB8V9KtykIzPN6bUPVovymxdCHm2i99qX5TQ1WEgvQkmWoeUKg==
X-Received: by 2002:a05:6122:1350:b0:539:3524:2138 with SMTP id 71dfb90a1353d-53c7d845b6cmr450903e0c.4.1755761372832;
        Thu, 21 Aug 2025 00:29:32 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd552c1sm3625470e0c.3.2025.08.21.00.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 00:29:32 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-890190b1aabso490299241.2;
        Thu, 21 Aug 2025 00:29:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiie51e1sRF290volOekXAtzdDO8J1Sq0pRA8F3X+/1l0A4yReS/kI1LCaimOwRXN/6W0nxaYps500Nsw=@vger.kernel.org, AJvYcCVPX02+ZWHLx2rgqTEF9wojXaZ7qRjJ8d4HE+prW2BM86Bn19J73PEna3R14Mlv9WKOiGD7z/0/Lnl8@vger.kernel.org
X-Received: by 2002:a05:6102:835c:10b0:51c:77b:297c with SMTP id
 ada2fe7eead31-51c077b2a0emr191728137.27.1755761372172; Thu, 21 Aug 2025
 00:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820180310.9605-1-rgallaispou@gmail.com>
In-Reply-To: <20250820180310.9605-1-rgallaispou@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Aug 2025 09:29:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXU6rSgdJ0z+ngWJ4F085OvkTSLJhJMx5jj29-4wqXktg@mail.gmail.com>
X-Gm-Features: Ac12FXyG__rwqKq6a2oYbz45RCyvpIcB9Sm2YdsLsERtwJw3UkULSn-9yzVLQ9A
Message-ID: <CAMuHMdXU6rSgdJ0z+ngWJ4F085OvkTSLJhJMx5jj29-4wqXktg@mail.gmail.com>
Subject: Re: [PATCH] spi: st: fix PM macros to use CONFIG_PM instead of CONFIG_PM_SLEEP
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 20:03, Raphael Gallais-Pou <rgallaispou@gmail.com> wrote:
> pm_sleep_ptr() depends on CONFIG_PM_SLEEP while pm_ptr() depends on
> CONFIG_PM.  Since ST SSC4 implements runtime PM it makes sense using
> pm_ptr() here.
>
> For the same reason replace PM macros that use CONFIG_PM.  Doing so
> prevents from using __maybe_unused attribute of runtime PM functions.
>
> Link: https://lore.kernel.org/lkml/CAMuHMdX9nkROkAJJ5odv4qOWe0bFTmaFs=Rfxsfuc9+DT-bsEQ@mail.gmail.com
> Fixes: 6f8584a4826f ("spi: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()")
>
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

