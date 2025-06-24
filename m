Return-Path: <linux-spi+bounces-8751-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6667BAE6F26
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 21:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80485A1020
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852172E7F0B;
	Tue, 24 Jun 2025 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="greaUKvA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22D2E7F18
	for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791905; cv=none; b=nC/T5CzAoWhQbWy0a1Zrcp9ixqGecevNew//tqkZLkjiwpAdJEFJ/TCFWy2jyHGsPX8mhRVb6iMUce4EqUFJvIUmYM86fCrce0M5gHmSLEFMLCrk9aZPJqGBJOY8kptJ2B2Y8Coi0LWvOeQeJUMHFu0YQeiylvwdM4RaY2r+Srg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791905; c=relaxed/simple;
	bh=mbsb9+fWnbzsLx5rxji39vFSDusnvdjQ+VlMMWao5NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mPraDtIhTBJTM1UibnUeuw19wyLVbsft27kWGZLS0dTODtJsAHVErtt8efrrXFqbSXEwun6W4Dtu2SP1PowFMCaukpdhv/yRvRnq/yBg9pxOWNbHCEpvhZx4EX1N61ZPnCI9zI37HiyR9ofgCKO8Zl++Y6GuHAWOeqiBivLg+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=greaUKvA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32b5931037eso6625031fa.2
        for <linux-spi@vger.kernel.org>; Tue, 24 Jun 2025 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750791902; x=1751396702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgrYreYVLH8FvHoQvhsa3zUNDQAJAjppKx7XORV5c4c=;
        b=greaUKvA3QPRnMukNkOtP1Rs94G9Ik3Gynpo7TPJAyRdeEM9OjvRLrU3i2BCZwhSdL
         Xf6FZTMGRCZBRaXrjV7KEvJxLjCtam936SnmNhEbi5zGwqsQ8870DKYTZnZGjs/3ATZI
         vXQkYyIL+CU2XRdapzIgeH9hWKovuYpX/ceNUtEXFAlYSw+8uCj45VudVx9pKnyLReAy
         s6JbA2D67mA3mo1H02O/adj99e34r8NpL6nnuugv8FQJc8KHJU12ZvBjVbycR+tuu9ud
         l9vWfZuSSoBh0T2sw66WaF7RUGEIvjFNrbTbwpBFr7HUtKCIwZ+o+R0gLNaI9SukfQ66
         Fgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750791902; x=1751396702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgrYreYVLH8FvHoQvhsa3zUNDQAJAjppKx7XORV5c4c=;
        b=Omr6xj9CZ90AAMM0Z+HSJyq9QZPAhwNZe+T/pVAW3+H5npH3zhZ9bP49+sHA41ZukZ
         fWEEKqe8d3ex0Z995WqKaMUUzurSey8tqIKHSmoZ9P55j/Lqh5rMmK0BEiSDhsKMSCjJ
         pihyEpEgy1WUnZ6ipkL8ydDhiQAC/GgGQlvWtFwbOTbKYVxgEWHypbEDgewNQZE0s42N
         nviWc1ttYzfcAIl7oUDrGnUpxXKOdt2R6n7xoDuCB3ySHcvZ1eSfznNUMbNXzvLIYLaq
         vPQyFIZ+aMrb3+KzhmDZxOQwSwUkOAjPlsWSkr++HCfQp77u9EhdMhd+X9bmpwPjtKqo
         2rYA==
X-Forwarded-Encrypted: i=1; AJvYcCW4kVaCs1iw3GV4L2i6RkHXER/VRpOQogURXbLpFFn/v61suCudUbsx7L2h+7yyvYXFJXqTQK8rSm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHOjm78rvP6J22mC97Q/j1nnjUXnuevhfZjhWlHxZke+CELgXm
	GqwBeZpgb0MaB0bpfgMJ7DQivad+eS2VM5lXzQh0qaw43549kFa7Dkr0Myg2odJ5kqt3OjJDPp/
	lCXDMUHA1vLexBDoEDr5m2/SvnbQjCT8De4Mp67bk4g==
X-Gm-Gg: ASbGncvGcDxruE13DsmuulLD2GQTnV3riQXdSeZnWclPpzY4z4pifnfRw3mOHZYutIV
	1I3WUGA4rs/I+19CLRLxtgrTH4o9mpu70hDW+AYoWxJU+fJXR+wfDHHfNfz8m3EQDMp6bB6JaL0
	ZOEeT3NZZR0wf8lyRK1z4lzDLn9bEDkI/CjhF8WGKoFm0=
X-Google-Smtp-Source: AGHT+IGRAdbblRlD3BsEideIncBbEmzKvsoZaeWYiP0C3/Bj6arnBv99h8pdXRsP35lURKgQ2I/vILxQ5IGPRudpng0=
X-Received: by 2002:a2e:a54c:0:b0:32b:72c8:9a5d with SMTP id
 38308e7fff4ca-32cc4d3d6f2mr2458331fa.0.1750791901594; Tue, 24 Jun 2025
 12:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 24 Jun 2025 21:04:50 +0200
X-Gm-Features: AX0GCFtEg0ndXbqdWy7FvRv-qpkhJSjku68IPxwnvAyNolU9JWUszgMqSgQ21Yk
Message-ID: <CACRpkdZhHVBc+aGA91Y3hHOe13C4TYwM1E_mH526dTECBZaP8Q@mail.gmail.com>
Subject: Re: [PATCH 00/16] MIPS: some compilation fixes for the Lantiq platform
To: Shiji Yang <yangshiji66@outlook.com>
Cc: linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	John Crispin <john@phrozen.org>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 4:54=E2=80=AFPM Shiji Yang <yangshiji66@outlook.com=
> wrote:

> This patch series fixes some MIPS Lantiq platform compilation issues
> found on the 6.12 kernel[1].

Thanks!

(...)
>   pinctrl: xway: mark xway_pinconf_group_set() as static

I already got a similar patch from Bartosz.

>   pinctrl: falcon: mark pinctrl_falcon_init() as static

Patch applied!

Yours,
Linus Walleij

