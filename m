Return-Path: <linux-spi+bounces-3536-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B41891304E
	for <lists+linux-spi@lfdr.de>; Sat, 22 Jun 2024 00:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 981EEB20AFA
	for <lists+linux-spi@lfdr.de>; Fri, 21 Jun 2024 22:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500B116F0DD;
	Fri, 21 Jun 2024 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAUgaXIc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0216DEBD;
	Fri, 21 Jun 2024 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719008779; cv=none; b=ZgntGv1/hs/cEcLOvxn6cOL/04MLgZKLx+aVdbkbOI0FQDb78nbM4lbm6S+HreBQYYu0hONkexTscIwdYHw5aDmUBA7Ox8Hx25UUK7f8NG9KZUw6N+SO1Gl4kq4p1Oh0qS4BiGgNPb3PicMDmyA0QCG8266dMaylZs/6GqgESOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719008779; c=relaxed/simple;
	bh=7V2AV6gMML4TYmsRjYb5X9NDqDOEzLcM8OjThqwlX2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZkrGbHNo8aOzqVUl0sdC/A6U1y2KuZVZkiU+XmoPMau0t6bu2VkYvZKqzJKs7yVwLu173fRBbwfTC29zivOZcuzYktKb7NcAOHavnTwudhZZUmglRk2ldtcKQClJW+hntCBE6LlYaLtS3BkEgVGPKveHPLFRFvifsPZqN3xldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAUgaXIc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9d9b57b90so16299645ad.0;
        Fri, 21 Jun 2024 15:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719008777; x=1719613577; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A/oMLkGRAuHveOGoBUIAcexGzHKYwSyRCCoVkHqIRHs=;
        b=FAUgaXIc+o4bmxEiIpeWG+B/98GLU8VeiK+3q208oJPfYmZQYn5sA6nXQG2/mUP2M1
         HI/B1w4OuwUf4tsCqWwYX2BriJRvSJcGSNXEZ9PkZ4XL8BMXS+9NP9dXQ2s88r7uQI2R
         nnFjymfF78FpYFKiupu3appMxXnkAKwTc2s7Y9+UPfh1Y6/YjVImKk3de56nG+B69pFM
         6CpTC/6wFBEGLpyMfsD3830XN3605ybfwConQZ/9jbVCu7HiuwKY99fwAft59ED22Fqr
         1W6lr7KiWfMat8R7orn8G765bn/azvYbkCmnZsYtZY28jqkU5smC48WWbfWcqAeEpc/S
         2W3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719008777; x=1719613577;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A/oMLkGRAuHveOGoBUIAcexGzHKYwSyRCCoVkHqIRHs=;
        b=LICyyjlcBzsNgIwPi/wdmi8PVfss0EXVvBfCgFhJdhvIxKGi6XOu1VMFW/ZRYBJOqo
         KrrRr3YrLLaXxgvslCLOaXafN26RBY1J52Gga+U6zTrrSfHZZemxyZJ7+paIwrdRhKIm
         E3vBKJgRBnkHuW4S6jQ5aPsSCcMD6H6KRVXNYVshXd1UJS6/tsprCQUxRrZwf/MKjGmj
         Vcd+Yfdv99WYWIX0wC8RwRQZdDbn3GI4AVTc/KB86Jof7Wmk4s96mJiK4LrNLmeL/qwk
         EyCX+PtmApMb06F0ri9PiJPMvxMTpWKk07oyuXOSEtyP0z6mruVoiDda9X4lMWH6aF35
         aiQw==
X-Forwarded-Encrypted: i=1; AJvYcCW1zkLxWXGjpOoTrazTLAvYFGu5uyJ3JpT+MEigbM3Af8CaVlKj5CrlVn/AzGTQVNsoCXItWnXEwjCyrW9cQtR0ri3kBPb0zPf29BC+1D/P/GIGvpat9nNN9FBbO/irofu9kCmSe9P+o9HqfWKXy1oCimq/RhL4PQFnJY/z944HvqIG
X-Gm-Message-State: AOJu0Yz94lQ+DdPSPt37DzAYhXqgpiciiboFAIw68zuQrMFwN6nKmvSi
	k8SKrYFCIYFx3tryZ6C/Sg5gFPVnB7M9SyXVHhuYLsAUCohUAptXdYavPA==
X-Google-Smtp-Source: AGHT+IE+oAAlNIWdbMvSh2ltAuh+aqhb5dx31ZRjlQ45hp03kkn60gGTd6b0wPKm1eDTlWvgQdoOmQ==
X-Received: by 2002:a17:902:a503:b0:1f8:393e:8b9a with SMTP id d9443c01a7336-1f9aa3faf67mr86173915ad.33.1719008776842;
        Fri, 21 Jun 2024 15:26:16 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:30ae:a791:227a:a35f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb589dsm18957885ad.269.2024.06.21.15.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 15:26:16 -0700 (PDT)
Date: Fri, 21 Jun 2024 15:26:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: spitz: Use software nodes for the ADS7846
 touchscreen
Message-ID: <ZnX-Bs1dSQZS8sMP@google.com>
References: <20240430-gpio-leds-miscarm-v1-0-9c94d7711f6c@linaro.org>
 <20240430-gpio-leds-miscarm-v1-3-9c94d7711f6c@linaro.org>
 <CACRpkdbY2R_DzCx48OdGBFh6Lgytt_+VN1QK1pRq+9dDB=zw9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbY2R_DzCx48OdGBFh6Lgytt_+VN1QK1pRq+9dDB=zw9w@mail.gmail.com>

On Thu, May 02, 2024 at 10:13:44AM +0200, Linus Walleij wrote:
> On Tue, Apr 30, 2024 at 9:04 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > Convert the Spitz to use software nodes for SPI CS and the
> > ADS7846 touchscreen following the pattern used in the TI
> > platforms.
> >
> > The Spitz is the only user of the wait_for_sync() callback in
> > the platform data, so define that this is a separate GPIO
> > in the device tree bindings (previous patch) and handle this
> > directly inside the ADS7846 driver instead.
> >
> > Add some infrastructure to the PXA boardfile common code to
> > handle software nodes attached to the SPI bus instead of
> > platform data.
> >
> > The SPI core will investigate the numner of GPIO handles to
> > figure out the number of chipselects used on the platform, so
> > no explicit encoding of the number of the number of chipselects
> > is needed.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Andy's patch series makes the Spitz SPI much cleaner to begin
> with so I will hold this off and rebase on top of Andy's stuff once
> that is in.

I dropped spitz parts from the patch leaving only the new hsync gpio
handling (and keeping the old legacy way of doing hsync) and applied.

There's an immutable branch ib/ads6746-hsync in my tree to help us
iterate on spitz changes.

Thanks.

-- 
Dmitry

