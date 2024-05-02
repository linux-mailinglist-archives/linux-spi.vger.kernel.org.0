Return-Path: <linux-spi+bounces-2699-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 775F18B962A
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 10:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74413B20806
	for <lists+linux-spi@lfdr.de>; Thu,  2 May 2024 08:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DFB225AF;
	Thu,  2 May 2024 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ch5h/kyy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE528DC3
	for <linux-spi@vger.kernel.org>; Thu,  2 May 2024 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637465; cv=none; b=Yhy4wQ1zCOAhHf9b1gtoFg3MnpL/+PFdXJWugNBwYQGJBCo2C5j4uxs30WYISamNV8xjUiqGTq6v1W/xvBJxPXeK5FckYHEFlfFWH3b949DfDdISiBPFqPoVguUvht3R7zdbAsdnzk8CpvAh6rqgl2+K3Zz0fG5JCe1FWJXr35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637465; c=relaxed/simple;
	bh=yhz3Hnr9ImiB4rlLSxdK37kSSIK/W5Yz2iTYfPCiW4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V21xd3A/gkIE3/ySlgSrP1GwCtONWF/uJPfFbdbjTLf6ZiiXC/xwHytui3GDyl3hcLGQ2hOitTGa+JwDC+NMAFXjxxP1+/q4tqHDyQtMUE7hWZW5k0f2kGAZSmDt3rXrGrzCrpWSkAQzw1QGvW6AYatEewziE/RbZTAKkQ5itRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ch5h/kyy; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-61df496df01so18819947b3.3
        for <linux-spi@vger.kernel.org>; Thu, 02 May 2024 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714637463; x=1715242263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhz3Hnr9ImiB4rlLSxdK37kSSIK/W5Yz2iTYfPCiW4c=;
        b=ch5h/kyylHh2JrLwyt0ns/RmnDlP9zGRCN7UFDSpQdAYuh35HElUpacFykwTGrfE/f
         Y/rydqbIxGfeRkn/uVd9bEXO0ZNUss4NWFGhRhXd9ukHQS1HT0sfhqWwIy5b6LlT0J25
         rRZA6MGv1smDetOF+9OzEp/Jrx+/GvGHKDbn/mh18bRljmuXTG8mcs0KmIz5MfPc9ito
         OTLmhYCVrDmP11UiiY8KWZ851m10ATgCPxngPavyQNtXRFUhWH05QOBQt5XJVVOo1y5T
         SMszRe14CYemMUGZWwA234oGNJKGrZND1pugCX0fwx+YbiIcJp7qvN8xXpraCaNqubVU
         wOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714637463; x=1715242263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhz3Hnr9ImiB4rlLSxdK37kSSIK/W5Yz2iTYfPCiW4c=;
        b=ED9UCJNn5wqRVxtlWhkMv2mnmYtUObuiurQkR+/FMiOrnX24uSoOyODjZC5Tyy8c3n
         OBSgcsFHWstJErAhxvPCXdlpBTqOsBcslZflqTuTqS8IxnxbOFvzwV+uJUzg0KmqOy4i
         ojC6T3OigdBx7E6sU4fIN4023aPxvGE37+j6OTQ8k1kpNuBlrikF9YgXEMVZv2LIupFY
         DGsfnkAb99uNqvjCvUZ9C9tuOTVU53gzyR+KxQe7uL99GTUEs6bECBKmkBQiz+HmFs5M
         aXuG0BPGB75yGWVfCssNTr/cxfqY4wujUQo4Wxsb+ceqpUkH3gV76e3gPOVDY5qWK52E
         ovig==
X-Forwarded-Encrypted: i=1; AJvYcCVPbVboZBb7rFrni0IEyrJkUUbznzfzPiePyun+MpluqHryr4ZV6ZIoAhiJa8ZM+3pCT/E6F9sgXtLAGmMr8dNB4lomtR4zm1WA
X-Gm-Message-State: AOJu0YzeTOK+2bBY1Dlk2O9rpubPU6ztX1FYF92WXKAKrFtwU4ikOK2r
	v3MJM8JMSaqUamOzxpG5r03OY30mFWuQIK8VEnhQr+QoSq9BQHbIFTSUct7tw7tx6fLuePnX2Hp
	spIa9tGR4lZJgA6CHbZ+NVpBm2ZXbG8FS7TBXPr2KIpWBPFtXQ1o=
X-Google-Smtp-Source: AGHT+IELqyMyqyzg09IrYvqrEqiCMUQniz6sembxGAS2bHsbIU4J3x4HWWEdOSmTklmyLQzOFUrRw0gCe4JHBOgAVy0=
X-Received: by 2002:a05:690c:e0f:b0:614:c76:26f1 with SMTP id
 cp15-20020a05690c0e0f00b006140c7626f1mr5701128ywb.21.1714637463127; Thu, 02
 May 2024 01:11:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417110334.2671228-1-andriy.shevchenko@linux.intel.com> <20240417110334.2671228-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240417110334.2671228-7-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 May 2024 10:10:52 +0200
Message-ID: <CACRpkdbNk=yMO7m4O+FohxmB5eL5bMovskjU22JV__N4VhZL4Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] spi: pxa2xx: Drop struct pxa2xx_spi_chip
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:04=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> No more users.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

