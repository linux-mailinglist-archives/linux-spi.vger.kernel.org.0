Return-Path: <linux-spi+bounces-2698-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AF98B9628
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 10:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F311F22C34
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 08:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67C28DC3;
	Thu,  2 May 2024 08:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJLOaKWQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28BC286BD
	for <linux-spi@vger.kernel.org>; Thu,  2 May 2024 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637440; cv=none; b=MEYl+lRB2GIaTPREFnrA19D3loKcvzlIH0Vc5FmTk4JOPavk3askZdgG3+eKDFetj0CFkHxIf346KnaHADoD2ew3T91jyW+/llGGKSpuAXm7Cq9licUsBoEOb9yrNMEoI8TPqLj6pF9jZmB3HyXXmkNt+MjPA8jMUubK/DMtyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637440; c=relaxed/simple;
	bh=RAwNolerGirdCR1O3ec7omBj85ZhFthPcHqaPU5XEeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GvlfJTD3BWgTkWO9Wc3JnqLX68rpQe2DYAHC5YK0hIDwtFQnX/9O99cM5I3hhcHnkI0tETwtM1mLwl21syD2TOWaa253XAJcBqBpivh4N2WgavSp0fF1wT0ZYiopEOrzGRfrttcgPyIZQ8sWT/elFT61q9rJGHCt1/nw6rikv94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gJLOaKWQ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61500da846fso55042367b3.1
        for <linux-spi@vger.kernel.org>; Thu, 02 May 2024 01:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637438; x=1715242238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAwNolerGirdCR1O3ec7omBj85ZhFthPcHqaPU5XEeo=;
        b=gJLOaKWQAWJ/36u/h3lhrbG5SWpixSQZuJu/Od0hXFcdO8RDoPZO/6M4pY0w+1rRxT
         whA0lY1UHiCInibw7taGY2AiS3G2yrbdiKEnTPZy4r9BBMX/k+qTIxvWgPJG7eRRg+ah
         eZL73H7SbjxpkKR1KwEYupFX+ycA3NbLtR2hrxkrACdq+jpEKk4bC8xrtKjZpImAH1gQ
         1Ax73lfJGxxk8KoisZ0FE3TCfqLpUGezeJdt+KnSEkVe2eDh1BXLQOmVJn0GA8jYHD3S
         mxHlbIEPAx6A8b/6cuI2lo7OomupID5L2D7DxBKMJ3aFrph5W4FRVovrhzBr+z4JBz+o
         5sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637438; x=1715242238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAwNolerGirdCR1O3ec7omBj85ZhFthPcHqaPU5XEeo=;
        b=TSrryDGNf96T1hnGLnn8+v3PpCJOXYExv/cRK8Wi0a53x/RSkYayPffyHtKWpxpXA4
         DSMheW1zuJVf9KQIswhR345PBcHV9y5IJ5EIi25xAdpCJss72uChlEFj8Km9yhFTL4E/
         a1mcFVZeFs7N7lCa35NyZ2nRZkhR6BExtARS/A9N/0oKctU7i09j2XP0kHz3yx+TaYfL
         xtwTwTRqaM+qdCaVIFhjqGteUYx7lmykNlLmfaKh3oCcxoxjpgyMrBur3ZBi206svlVH
         wHrBIFVq6Om8e+EK7uvWKdxXcqQBvrvOszskKAy93PzWYakwMgT/kuceRA/omf6Xc7h5
         1xbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1JTkgcSLJsKHcY7krzZN1Ty9DQR07T/51M6Bzw1UZh0P6/rvzGdFT66j4mvrU/lOtj0JBFHcYugV88to3AYs7k4hWI/VLAaQY
X-Gm-Message-State: AOJu0Yy+IiYhOzetaactblK/KM0H73mg/qeJziD4UDTen1KMwjYps5HT
	P7u+Xmc16PI8ZizFB/Uz3R61Ew8aO5f3Ayr3B23lGPwfaM4YMcGnPSFL6WBa2ozvL3MVPzhWuVh
	4MZ7KnigLs3IvGtLgio9ZiL3uotE32LSb4tfe9g==
X-Google-Smtp-Source: AGHT+IFW5rtqDg07w/xR35suGneJPXY4vzLGzaxkYgyhDIm1iKnkcxkh1FzOlJx/Rdd8m8d3MmLRxKntnFEh60J9qQg=
X-Received: by 2002:a05:690c:6309:b0:615:a86:f77b with SMTP id
 ho9-20020a05690c630900b006150a86f77bmr1472850ywb.26.1714637437876; Thu, 02
 May 2024 01:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-6-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:10:27 +0200
Message-ID: <CACRpkdZ3K=_Vj9SXqHjBPfw0PFLVOyUCvuT-O4qw5T=TZedVsw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] spi: pxa2xx: Don't use "proxy" headers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Update header inclusions to follow IWYU (Include What You Use)
> principle.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Didn't scrutinize, but I trust you more than myself on this one.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

