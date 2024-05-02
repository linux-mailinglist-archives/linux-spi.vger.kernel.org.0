Return-Path: <linux-spi+bounces-2700-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5958B962D
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 10:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69EF1C20D33
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5C628DC9;
	Thu,  2 May 2024 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkGiVaBK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B171527BD
	for <linux-spi@vger.kernel.org>; Thu,  2 May 2024 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637494; cv=none; b=kw4RFO7Wg4qcVPRJlLf7t89Usfr9iufebjLsIeBIPrg6MY9p7uzWQrWIG2GvAN1zlriEpgwKVs7Pgc6Qd+/ZqSK1+H7R65ttgzl35h0bOiOH8bc//DF66w7Z0km0uuGa9mnx130eycQ6P9M9xFMaeGlYJRcCfskgU6yjMQ/wVtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637494; c=relaxed/simple;
	bh=LjOeatHXKMKJgpcc6m/ycg9syrS0e2IivHidp1e5BOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ip3aYd5QIUcj67nWeO9zOSUzMKATJIwE4gqgnXxcpEl9LI32MVinAwsO9LkaxH2KOS/aFNxYqJx8vOZnyoyETUiZA5gKZw+WOLiH8LyVa3d43S391KPCrxP4p2M0Qu2XwCjCaBBQQq3upPR0VZVfLjUhKLoDEP+7j6A/ZEoOsKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xkGiVaBK; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61e0f733e8aso4234507b3.0
        for <linux-spi@vger.kernel.org>; Thu, 02 May 2024 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637492; x=1715242292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjOeatHXKMKJgpcc6m/ycg9syrS0e2IivHidp1e5BOA=;
        b=xkGiVaBKDK5u7G580ARNDNS1EM6b7ZspYJ/e+HhjwFQmOzqeGfQZyuqB8NxaXqfSCM
         ornvYRHORBKv/3IbdUz+dT0uOR/jRzcSgFwmXhjS0LpUAx97TAItsCOdBWzytX25moxE
         ehP95XT5aLJ76OUBPJTXBX53XtxNqrIpflrR0z3+EJasFu2Ae8sQt5p6bVLzJVeJVZwZ
         3ePw0doOtQFQ5yopqddxWtbvbbmbTSnDIjGQYqvqPlltW+DJPjDxL8E9K865zROIesec
         sBXQPn5ItZEaAtysx/7yMuKL8vntOAOtIX/Zo0wnN3+oq0efdDxnAaZ/ZJlvM9nIWDmo
         Dz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637492; x=1715242292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjOeatHXKMKJgpcc6m/ycg9syrS0e2IivHidp1e5BOA=;
        b=ePZZX8KNQ/rTFJHJX/LglgI7FCH30uvKZA4dfutxIvTXiQ89OCnVAcfSL0yf98VfLu
         qwa7IsCp3g/nyw9sHFzM1xM9S7kyMuUl6S2kuJyfXmNu1/EoVaCUykEDgtQqO+EtW+gg
         7hGiP6vol21VG0G74CO2U2e8arNVwl45xyxfF51iWdD/+/GsYBFy/D84ZIlvXeMfJ+lv
         r6ewOPctJo1G+hJQOId11TD06pkW3stK+Cw4Mw9K+ExVQnDgmmACWf/aCarQFCqxJMmv
         MX0dM/4DAzoCT/NAyRX+VFC+oNY25zkjXudFXTdR/5G8YiCZ+Ov666gwoyjznEb45Ycf
         t9RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvy3rOFh4J6rAKGuiOwXBOQeS7hOr2BSdctVdie+8nWo23RlbhKygwzSIV9Q6pRA1JUWAWoaZAjSzGU7PqHtkf+RtROhwA//O+
X-Gm-Message-State: AOJu0YyMY2HME4k+MpiBZk77M7YnunThDtb9cRBQnshAowPzSe48uFa4
	7ohqnPiPfAm65wYQFOX8de29g5+ZAadfGZwY7l8EB2Zq8TX5kGAhjBu4/tiVGll7NspyY3SGPPy
	67uAZwTtxzQ2SXBkPakaIjQ9EVQqNuHMs4HiKkA==
X-Google-Smtp-Source: AGHT+IGJEzfIms6U83mdPxNB0s5B5gCFDCfp/MgRqjTkJukEUjEtA/OkOokFTrnWEWA6mQH0+cqMlQNnK3DN2nD+cxc=
X-Received: by 2002:a05:690c:6c0f:b0:61b:d8:c5de with SMTP id
 ir15-20020a05690c6c0f00b0061b00d8c5demr5292651ywb.19.1714637492101; Thu, 02
 May 2024 01:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-8-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-8-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:11:21 +0200
Message-ID: <CACRpkdbacr96P4jBjJ5BSYCJkA=0cDp=MJwsoNtLgy7n0Vk8Rg@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] spi: pxa2xx: Remove DMA parameters from struct chip_data
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The DMA related fields are set once and never modified. It effectively
> repeats the content of the same fields in struct pxa2xx_spi_controller.
> With that, remove DMA parameters from struct chip_data.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

