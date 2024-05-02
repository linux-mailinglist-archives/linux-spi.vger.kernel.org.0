Return-Path: <linux-spi+bounces-2697-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2B18B9625
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 10:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DCB1F228F8
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 08:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30792E85E;
	Thu,  2 May 2024 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brYtJ8R6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33699225AF
	for <linux-spi@vger.kernel.org>; Thu,  2 May 2024 08:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637382; cv=none; b=FPCaoaWqTH99S3wSKXTDW6dcoj5jfik8boUwi6JTEAGqxxbgs7MV4FKE/EdH0lFWyBXM4lYvdhojfI0NKgKoKpkEJYICH5oYcanYE1NGKOYFTQmjiimUr6ZkU0BL07YmpjNFXtIkOKNWtJ77UYDtE8P9NIzUA7Tom/AHODkQbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637382; c=relaxed/simple;
	bh=arWodmRQt8BTMsudQ7mKMBFSFOLZxXEvmY+VBtmcYWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VadkngEl7zj6VnZ2RK2Ci0VpK+/E5NEydV+dmuVEIIZmRdxEJySh02ThefYDY7hgm5hOAE/lgbmVaWZw+47J/lzWfDwQloCoKHGJyzJM2XKXYt3sJcgY6xW4PkHxdwzN1aHokXRGDK5vJxlpqBicQ5uNaoeT7pRMz2JWBHw1BOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=brYtJ8R6; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so8104067276.1
        for <linux-spi@vger.kernel.org>; Thu, 02 May 2024 01:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637380; x=1715242180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arWodmRQt8BTMsudQ7mKMBFSFOLZxXEvmY+VBtmcYWQ=;
        b=brYtJ8R6Y6jBSj+dRQfmc8DLR2HfAMjDOhJXDBvfTJSRN4ne+eB6IDymBOHrMSUQ23
         fbbq1+kHmBvqejh/jB7cDm1hppkx7OkivUddvXdHWlemokGSsSzEiyQ1419rQhL3P2y5
         d4Z4Y35vrFC3XIPhWEtJuCu49BkI6n9OOZjMWyJCWz3QmHV70A6Jt8hKzSnuxs0FQdYB
         Y54Dle0G9BQO3opm0geMIo9Xr2Ey1qOSIEyzi9j9tiOeb6gaNhwRG1dDTd5ceDUvpf+2
         Gyt3B3ldoSeRS9vlEd+WJRiQFOo5+/d3qmXXzO0Sm74yKnOuPBlW9egWRPzrJaTykq9y
         EGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637380; x=1715242180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arWodmRQt8BTMsudQ7mKMBFSFOLZxXEvmY+VBtmcYWQ=;
        b=iJFYr52jNwrzQ1sLKJcB22x7Ul8jTOBdaEm8Vzvp9Rt78g3DgGl8DB6xenJaOWrUnV
         Df4hNjopm0xwgE6cGlXNcDdOdJnvJd6uIgN4gPJAg9PbquBvumEdVuWxBkgkTmbokZTM
         4p6YZpdT6W5emVHd3xKo8ROQkYvvfVzQOvQzEzvj/DxcqXKlzgcgiO8GYnquZjnJZ5oG
         HOC8AXvV7V+rJOt4CIB3Hx8Ynlfy8m6maAlICZ4NIt2qyl0agaHLi2MaaQY+D0erXqtB
         x1ZJyiYAwWX6nad6A0UE6T6gbYqKifvp7juaR4Vwfou06ijtj1O+L9iYZBT2d7gH+5b+
         jfRg==
X-Forwarded-Encrypted: i=1; AJvYcCXzmbFnx3r9AIe6g9GS6IwkXO/jKqA60AeVF5CyKHjDoHg7P+FPaggWXGu6Nbh5dJgz3PoO1n1kGZSwWeuCvjOj0y3F3JGZLLua
X-Gm-Message-State: AOJu0YyzJUg0gMjY83VJpU6gMCDTTVohie6ILRWbtmr2eSZdL/MZn0Q1
	tBP542sJITsfH4cltsRmUfZLVbOb3pfer0X15RAbXCQTJZ2MqBWeBgRlHoU2JTYxZtyzKr2+jwH
	IFiAJ/she/L7AEme/seejky24oZrsa8gTLn4yVQ==
X-Google-Smtp-Source: AGHT+IHKrpohsKXBOozgDWcLAULi3t9vpnfK/zzXTOHgpMX2dpa+QwhZN6Pr7wodgIcBDkNJ2eKnp1WLdJlSgtpWOLo=
X-Received: by 2002:a5b:d0a:0:b0:de1:1b21:4f8 with SMTP id y10-20020a5b0d0a000000b00de11b2104f8mr4629460ybp.62.1714637380290;
 Thu, 02 May 2024 01:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-5-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:09:29 +0200
Message-ID: <CACRpkdYf_qNFkmAo-C5w-sef_mOc62w8nj1kv61frK05yrF+eg@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] spi: pxa2xx: Remove outdated documentation
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The documentation is referring to the legacy enumeration of the SPI
> host controllers and target devices. It has nothing to do with the
> modern way, which is the only supported in kernel right now. Hence,
> remove outdated documentation file.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

