Return-Path: <linux-spi+bounces-2742-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969BA8BB429
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 21:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358881F2257E
	for <lists+linux-spi@lfdr.de>; Fri,  3 May 2024 19:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB722158219;
	Fri,  3 May 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt5Hvd6a"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EE5158866
	for <linux-spi@vger.kernel.org>; Fri,  3 May 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764908; cv=none; b=C2+z80r7VFQT3R1s/mlr192bAvH/yOkg8L1cfbTlKsGrx7Hi9DAGrE6Md9eQemaaZ0Y6QughGPrKoc0jPPFB3DNgAoSaKWCGsOdqRHS6sBskgjRHV6S2eX/uWPw4cJ3Ets+2NMxCHD/L6/Nq2ObUJXQ9slHwH3r1CPPjPyQ+B4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764908; c=relaxed/simple;
	bh=L0lw0cBkOhhKUJEvP62sNxBoMOIpva142Ewskrk+njA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apEnx5tRRyWr3CVaIVEVIBfx9in1Ul1+j3VSAfsQQxEis50VOakYjS4AiGBV/9EkEXDxMqj6ezciAE4zQ+m5e1u9xXkioGBGXZlsIDzlVR4yLUljQQtbUHuj6BNqzXFBFuoql3T0kjWVXe2XSkCRdWCAAUKyeUV0auntnJGjwnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt5Hvd6a; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a0e4b773so54400966b.2
        for <linux-spi@vger.kernel.org>; Fri, 03 May 2024 12:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714764906; x=1715369706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjAkei58wJvFFlPWyfua2OaT4jx0fRDkJvV2tXHS720=;
        b=Mt5Hvd6ahwOd53GXushfAKT5QUMmhP2FmXOIzm10fB9h3bTLjmFPDiA50UANKrHKpQ
         ar/q6C5zehsXKAN7zuZLwDguIbrb7sNHvwq9R8rxfrZyWjdu5QUSiF1A1Y/ptvzKUnch
         SzSVrFj4VT3GSkRog+edpV3GGvm5o/iA7oeI1zHvovpj83E5h9rUMR8T2cSEwE13zzQP
         74SK9ZIqvWXdrgQhIsCy2tlxrC+hTEjVGiUFGhEqwEG9dYYS96GNHaWv4TsJklBAkDXW
         uW7ml2+RjHJ7gYU+XXE70pfGItRSDzU+d9FZC1L+woX4spkmFqjc2+dtmEpVr0C+Hdkh
         yC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764906; x=1715369706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjAkei58wJvFFlPWyfua2OaT4jx0fRDkJvV2tXHS720=;
        b=cMh3r8DhJbQCv8zmmtHA+Lo0fvk1y0Gzd6DPzheHj/qLkOvRQtDR7otNn02tydGSHM
         AIX0o96B+x5ABFpHPiUzwjL1eH51Ej4Z+RxM9BwWu4cmXNjLq94L+lw/HF1cPWCpXTdr
         NVplKE9BSeU63/Yoy1/HVDjUCbnloZ83lRVbEh/OI/ttway+oo2jZWLYf7UIaRqs77e9
         d9t3uYqOz2LrsI/ahysRRW3IcLaYJONyGafhjA0BWWOOSva4CjEKNe+xFT9w1J6w1Tdn
         MWpTXcT5SCDGiWeubPL5C0IgfnI9KFoiIuUp1M7XTXu1tmt6vPwDGeka/nmaV0GpH9vW
         DX6w==
X-Gm-Message-State: AOJu0Yyv2MIIYyRMGxDv10KyRScfJSS8EjM/OH+G3eKK8n1E9uZiu0VK
	TJA1vZbqXk1iKDKD3e+6qD89nqbV187RqTNQFpjQ0mjrIQREOjWg5monWhF5zlt5DvKrtDwGORV
	bxQCrqw9I4bt73K5L/qT4I4Hrnc4=
X-Google-Smtp-Source: AGHT+IENm7OuT1IWqqI4pPKnJbLEBycsH4TY5eK4w4Hs4hcxXtDzUEyFzjJXej42IaqZKBgmQPOImk/tiNGBYTE2H+o=
X-Received: by 2002:a17:906:60d0:b0:a51:fa56:4fc7 with SMTP id
 f16-20020a17090660d000b00a51fa564fc7mr1924847ejk.21.1714764905603; Fri, 03
 May 2024 12:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <580665ed95340031d0d42d1a4a16f7fcd5d150d7.1714755642.git.lorenzo@kernel.org>
In-Reply-To: <580665ed95340031d0d42d1a4a16f7fcd5d150d7.1714755642.git.lorenzo@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 3 May 2024 22:34:28 +0300
Message-ID: <CAHp75VdkjMrUTWGxzeFkzVi8LUTD7npL5RLon8BXjt8dzWPAfw@mail.gmail.com>
Subject: Re: [PATCH] spi: airoha: initialize as_ctrl at pointer declaration
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-spi@vger.kernel.org, broonie@kernel.org, 
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 8:03=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.org=
> wrote:
>
> This patch introduces just two cosmetic changes to airoha spi-nand driver=
:

"Introduce just..."

> - move airoha_snand_ids definition after airoha_snand_probe routine

airoha_snand_probe()

> - always initialize airoha_snand_ctrl pointer similar to
>   airoha_snand_dev one

With split to two (Mark might ask you to split these to two) or as a single=
 one,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

