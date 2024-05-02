Return-Path: <linux-spi+bounces-2702-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217918B9632
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 10:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CACB01F24639
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E30E28E11;
	Thu,  2 May 2024 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oPCHjVV6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87191286BD
	for <linux-spi@vger.kernel.org>; Thu,  2 May 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637544; cv=none; b=Qg5JDZ2DjEOyCg+rlnxGNbDMxjHMNwWEsUWw/+0a+uvrnO9UTRNcYMkqMe53LG86sc62HJstzxsYCd+xdpfTyk2LMLiS8mClerJJe+n0uBJQmNXSWdckAFwPXlNSZmkdtYjwruBVJXCQf396yZh0HdMzGG478wuJU3RkYCywHyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637544; c=relaxed/simple;
	bh=wb3LX5vahpx/rd816iu/ui5vqsK5KsZzBjV0cje8jHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1dVd2x7T1nRdFuZxj6rgz37C7Xcbb5jwG9zP30KiK8wPEj+O4buKbJAEQmD8mSyrclXOIogaVSmzTH0TY2n+H8rz3EJEuNUyC6AY1tPsX7WyEBxl+x1JhAnoCS3GQTJwwQcgywJ0HE2jyYmhUCKPeZWfeoFJtQlmxpP3+YJmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oPCHjVV6; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de6074a464aso3587034276.0
        for <linux-spi@vger.kernel.org>; Thu, 02 May 2024 01:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637542; x=1715242342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wb3LX5vahpx/rd816iu/ui5vqsK5KsZzBjV0cje8jHg=;
        b=oPCHjVV6xufvCmOrjd8XH25kzdv2cUfoWJv6QG1k0EKQ0FQZQluIEUwRow9p/u/pa3
         k9yoNEgf8D2kUtXL6y05tLsteICbRx0DbggyEbByKMPM2oCwCRxJGn07J2A2P5ejKG/e
         90l3lBSA9qTI04lXSms574toBSgzqkR76588Gtu7eGIh0Rd9c7G0YdYBcygc3JURsQ9y
         ffQ6jDdUwOuGmqYW/XOBaeWL2cnQpTYQ8XpumXfFPw2rIspOY2OjdIT2Ho4ME87aZv3B
         +pKPHngNq+oMCvxFAHpT2UWPGWwFj1wKBt6nmBEbLRk9ZDzzEiwdr2UqOnzYOS65VFUY
         cVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637542; x=1715242342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wb3LX5vahpx/rd816iu/ui5vqsK5KsZzBjV0cje8jHg=;
        b=czqIsfG7FxfMWYqCsewpwIVAbgCk+Dqer67Cofu6MCRS+yl803mrcOhZCWkXabQdah
         tkyidCTvdlx8upb84QVoaTuoqXICngrlv25HfrEfJQDaAgUOOo/7SWh0umSI6M44OAgC
         gPunmnRdCppTcK/n9QNux14EdWyMSmCZ23hefU4L4C+ZBHUjvF7h+mf+9enHpkVZvVbe
         /nKa/kajhPIR/ekCoKMNEwBLkzJd+g6m2kBumGA9M/gzHFF4N8EDoQX8WgzsqoJQItSP
         e3b82m7kQ6t4dhIs5ul6Rx/5TsE36slEBnOiJQxvo2frEV1wh1Ml1eBE0Eu9pQbUALRJ
         k3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrN3pYtlFKrJtJoj4Qwu1+vP3Ijpz0xBJucUEXSVrhVY3vpztHwHXOb/zPbB/ImLB+Ow+/u9Kq72ockh9sUFtWrWB4bw8p7t9D
X-Gm-Message-State: AOJu0YxkKp5FQv2adyclN2BZl9NLIYdzzzvokDUEk8599cNV2qBaT9lz
	stkDRI9AVq/BTaxRX7kncDG053EryfXhahIigKj5w8Aauf4KzkdoBvwt6hGxo/PcyCpPodDHoqa
	ywGRgPPFSlFtRJhf8Ix/h/36ssBlC6rUEIRW6YrENlsvmXP4WwYo=
X-Google-Smtp-Source: AGHT+IGLKzyB+YZkE9uQws1DXu7KI6tBzhmXigQBA2PcTyA8yFz1MOY/h5s8kLI1LQHzH2r62g7N6C3hpZhGXaNnsIw=
X-Received: by 2002:a25:6b01:0:b0:de6:dcd:20ae with SMTP id
 g1-20020a256b01000000b00de60dcd20aemr5048683ybc.27.1714637542546; Thu, 02 May
 2024 01:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-10-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-10-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:12:11 +0200
Message-ID: <CACRpkdaPnO=Xcj-aYwBA3MfdmCk2EEfbvHyy4UJsjxsZbWmWfg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] spi: pxa2xx: Don't provide struct chip_data for others
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:05=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Now the struct chip_data is local to spi-pxa2xx.c, move
> its definition to the C file. This will slightly speed up
> a build and also hide badly named data type (too generic).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

