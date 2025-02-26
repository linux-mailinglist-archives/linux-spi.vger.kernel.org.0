Return-Path: <linux-spi+bounces-6950-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C6BA464F2
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 16:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368CB19C1509
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2025 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3007221D585;
	Wed, 26 Feb 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml4pa7kF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE021D00E;
	Wed, 26 Feb 2025 15:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583834; cv=none; b=GPt+rk4N5BaeB1D1rwVk3nEQzUztMU2Yu4JsAr83TXexyLzVKh1XW3pCWZFrjiSSDpBKFFXWO6MZ0R8aN+MLU5nJx6DiRCM0WKDyaUQbotzwUqTZe3oGOIxAcIGNPiVTmd+xdtb0kWbQJNjDkIZ/GuLRFKhAtzZLtvpSTkIZ6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583834; c=relaxed/simple;
	bh=jWzDbbQHO9gEeKekcUVkcixWDMvI3qej9AstFronzn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmRubPwOXD8IyCr0nuaYx3xGEhwHbe58dDSxRcBM6aXLvkL0MnBw2pytZKZX7pY/YbRz5b+UtfbrdkG9tQHq8MsLg7KWBGl76aNe4dTuLh33ZsroP3/xH6P7T67RJtnZtt/gz015U6Kz0GjAraj3NK/Tv4yhN1ZAEYb0TT4A14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml4pa7kF; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f42992f608so10781244a91.0;
        Wed, 26 Feb 2025 07:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740583832; x=1741188632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZ/QbTWZNshBxb5hC06ZzjWtL5HiviO0RmZtIpOJ43M=;
        b=ml4pa7kF+RVJA6p3sjQ4lgR5iyJTXkzanwoXWm3sGgAL8OLzpET1CivN+c6PUrxsww
         HqxbeTlORiu4n+yXdDZtOLGf5/ia2oMDTrzkHoyO9uqxp54Kx6Um+bORLI5dysbMetT0
         dWod8W+A6jfHo/5lZP2t7GnKkyNfVmexpjcXQLUhmQ5LOZnybswTBWPSJx0UU+WTWSKC
         WT4ctSgp6/+Wt4Ft/ZQirhIY/rGW/pOm/GnTPxwEXRAZ3zC26FKdXFRYgEQs+4hX9RXV
         qPwXlcZ+ZdQbZjneCZyf3xI2A4nt2xQNEql9UgGbFIwHM2qqvc1gERzBALZDyhnJ4jGk
         EZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583832; x=1741188632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZ/QbTWZNshBxb5hC06ZzjWtL5HiviO0RmZtIpOJ43M=;
        b=ZudE8EOPB1fCe7y+Ih4RJ3jlnZFPdH2zOIKZjjEFB+zDCW5TmBd6IznmU4J7O5obdc
         gChKp2z0OPhhuNxzAv5reLgWr/0ey6kT2FXZAs+kThiOwn4HYyVuqrTna+BvzOrZhSa/
         AjkOsQGdxBsEBXeYXEfah7peScsqXk6R8RgSpA52ARiMMwHMZv8doIAeBnNU2mT3YOMl
         MqqupYYYQwzs4Ni4T0hhBsap0I++F5d+ATuAf8vs0ycLLX5CIvy0oCUJ76tidNoWCVgm
         DNnD7/7J+gIB8mPm76r20m0eHe/OQYsOWNB/UxfZHJrkfaG7kxnnd7jK8oSPVf1uS5S+
         qW5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0HSiX9W1pyvP1/wo1z7qMF6yR8yfya3NHkyVU6yddBUjh8GwHu1h9fbga3d36eIdIp1JSNeK700tH0ljA@vger.kernel.org, AJvYcCWnjq9yE201frbsc1GJk2k970YcAyyYkNWeG6NuvbBRHJ2JjT1ZN4q/3rOpDbOyRYQ8nhGy/HMU0XYi@vger.kernel.org, AJvYcCWxPYKiPQtRmAsZ9oIl+F2CvYFw3cQBAR6VfRHCxVGmRhh19dEkDrjyjAv9PjBX87/LREcuKOuxnshR@vger.kernel.org
X-Gm-Message-State: AOJu0YzAH0XmyqLwHpvlSQh2W4zgWzH1m9s+//p0wU7D1qIzGNkx84+/
	SQHjJOYjKnW1wOgH4d2uSH3LsyUG+7GVNKI5QmcA0E/R8ExiMZs2DSRExHChl4xey3K0Qm/4SH0
	1sLqkcxAaeI3EaHUB8eBJYbVww4E=
X-Gm-Gg: ASbGncvszUgIv8IIymE51I/6eRe0kcPNUd0edI+S+2DKyqUlqSxz716gfSFiiintSL8
	C87RzVEc78Epn7H83rrqWYccZ39EXOUQ7YU/puuMGkE/A7p/7cpD6hvtFqn4VvgVgHf3QfR7hXu
	F20njv
X-Google-Smtp-Source: AGHT+IFo6DOoGnTsS38LlUXMIhC0H9EtIGCJVFbM5Bu56nEtT839xcPAHtRDebmakeB9TC+KDHHS0qohqRpYH+q6d2s=
X-Received: by 2002:a17:90a:c2c7:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2fe68ada148mr12284035a91.8.1740583831681; Wed, 26 Feb 2025
 07:30:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226-initial_display-v2-0-23fafa130817@gocontroll.com> <20250226-initial_display-v2-4-23fafa130817@gocontroll.com>
In-Reply-To: <20250226-initial_display-v2-4-23fafa130817@gocontroll.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 26 Feb 2025 17:32:08 +0200
X-Gm-Features: AWEUYZnVDiZ00SedBZ6EyKd9EOM22xcDBV6m1uAzMRnVUY2vdD1K52vvrRAuSvo
Message-ID: <CAEnQRZDXxuviih+o-iFOtiS6j8=JqnhUOHaZf3RhGL++fg=moA@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] arm64: dts: imx8mp: Add pinctrl config definitions
To: maudspierings@gocontroll.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 4:23=E2=80=AFPM Maud Spierings via B4 Relay
<devnull+maudspierings.gocontroll.com@kernel.org> wrote:
>
> From: Maud Spierings <maudspierings@gocontroll.com>
>
> Currently to configure each IOMUXC_SW_PAD_CTL_PAD the raw value of this
> register is written in the dts, these values are not obvious. Add defines
> which describe the fields of this register which can be or-ed together to
> produce readable settings.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
> This patch has already been sent in a different group of patches: [1]
> It was requested there to submit it along with a user, this series also
> includes some users for it.
>
> [1]: https://lore.kernel.org/all/20250218-pinctrl_defines-v2-2-c554cad0e1=
d2@gocontroll.com/
> ---
>  arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h | 27 ++++++++++++++++++++=
++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h b/arch/arm64/=
boot/dts/freescale/imx8mp-pinfunc.h
> index 0fef066471ba607be02d0ab15da5a048a8a213a7..0927ed11ec687d5b273c4a4a6=
455e8d81468f676 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
> @@ -6,6 +6,33 @@
>  #ifndef __DTS_IMX8MP_PINFUNC_H
>  #define __DTS_IMX8MP_PINFUNC_H
>
> +//Drive Strength

Please use C-style comments /* .. */

