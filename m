Return-Path: <linux-spi+bounces-2696-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EDC8B9622
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 10:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6C6B20C6D
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 08:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7028DC9;
	Thu,  2 May 2024 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9tshFK8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B2F225AF
	for <linux-spi@vger.kernel.org>; Thu,  2 May 2024 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637360; cv=none; b=eZEZDHrgbkA4+V81V1LQSZ2PNE0/nuwZOkgVKcXGC1krrLzGFhZvKk3MbHcz4B1mldOX375JGq3sufFY+2puwHFdsRjyBC6h4YIkEg9so3/26Jo431auGQEM1koyLr45xhlDq6Rcf3NsQs89B2pLsD7/RboRK5l9Hds5DhdArnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637360; c=relaxed/simple;
	bh=Sjztd/AEEsHzWwLJl6J9JnPAwaAhLzUKRpha1EEYYs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7x4PvUnn5YFZ70OFDfW8tTbgmlxsMlKDvsWr1nqNy1vN1/wAovKTIrkiO0F3owRl6HXYwe1DMUwKC+l2ECyh6Hq301LYWtEmu28kFbpRaghBOnscfDSrxX4FD7zmpGbwL7UCy8lfY9q4QTLbOin66517TDA3Uk7xiJ4rxks0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9tshFK8; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de61424f478so2848768276.0
        for <linux-spi@vger.kernel.org>; Thu, 02 May 2024 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637358; x=1715242158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sjztd/AEEsHzWwLJl6J9JnPAwaAhLzUKRpha1EEYYs4=;
        b=Z9tshFK87SbRiTwDeygO8yO7cHAY1pAOhzSj/KQBacW9LqQt+FIHqm1sOQd/+PEvCw
         oFdBonAPw9iDsWmAu644gj2scoLbp6EtBLjLU2VDIqy3K6Q7VTSJCz/xKr4T9QX3ohsB
         35Doh2XueZ3KIbAIFvKQOxMqrVtlw/L1+0I+txddf0idcx1PBlGXR4PpmLBxhrQw2RXg
         vOH5I21Xf+n9JiMyF0d6ehw6Pzhrmq22vw7FgkC8TtlwRUCjAWpkR9hRDWIzsQBcIiDD
         CfIFmYdH8lguyNwMUiqHo6gmecQXG8ztLmDBUslScoygol6cRyw5dLJO8npMZOY7TKHM
         OFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637358; x=1715242158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sjztd/AEEsHzWwLJl6J9JnPAwaAhLzUKRpha1EEYYs4=;
        b=CcQeIGiBIqVSPjRE4CvOeQuiqqe5tfe37aN/16b2eN+jyfTlLD3oQR1jpp8MPTPTHB
         hS5C4k7EKTcmBVkzdzLV7Ze1773sJ1NSKPndqfaN8mXEl855BhJapGWMUkYg36Rsex/n
         zVzvYOuYkClbIWPASL/b+lIphDyIb+eI8iGY31KfWyWGL0IYpWIvclrUIZ8rcM444MMj
         D6+xv4LH15haGDyTS5MAct6f22iMqbmEo92pZdIc9C7B+w+N7Fs9B4bFuVkyNlfaqoM4
         s34dssX1j/S7HABtbfVqY16w0w/n6qH6ynLeO1+nnELYDm0M6YvX6MI/g0icNmBfJBpa
         TraA==
X-Forwarded-Encrypted: i=1; AJvYcCXCkakeYA3SsniWkPJ9xMhLlePTREadVPUnGBbTGreqlwVZh4NN9+B8lk+jlzXNTc0auuxJpS9Og46UPyz8yTw6U7qvtYuCz1Sa
X-Gm-Message-State: AOJu0YybK+Ekp0RsYJpVQvLefmH35HUPQiIfZr8XXOqzyd48iFoZ7Ma2
	VUn+McVT8OU2UVrUi3WAez79uEGK6EKnqRdOqsmp+PsHzoVswOMbZJ+Vb1Z81l+FXmRMvVhgqcr
	Jfsakg8MGeZ6gXZgIPq0jqoNeRwHIbnQ/A3LYDw==
X-Google-Smtp-Source: AGHT+IFdvWhwA1ZYTzco96EAOdeC0xLJcCq6vRj1sRjAbmCKU93uYpsI0zIL2k7GwvtfJO8gvoSmeuLSZMJjniozd1k=
X-Received: by 2002:a05:6902:1b12:b0:de4:6122:9fae with SMTP id
 eh18-20020a0569021b1200b00de461229faemr5681806ybb.64.1714637356240; Thu, 02
 May 2024 01:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-4-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:09:05 +0200
Message-ID: <CACRpkdb94Nz=WwVNAJ5KSu_m8H7_or_+dL3xdsw_4d0=rHxMsA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] spi: pxa2xx: Move contents of linux/spi/pxa2xx_spi.h
 to a local one
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There is no user of the linux/spi/pxa2xx_spi.h. Move its contents
> to the drivers/spi/spi-pxa2xx.h.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

