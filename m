Return-Path: <linux-spi+bounces-7491-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE32A82DD3
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 19:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4805B8822C8
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 17:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7D27602F;
	Wed,  9 Apr 2025 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSEa44w6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AE5198E8C;
	Wed,  9 Apr 2025 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744220630; cv=none; b=iKJdtF3mzfAO/Km3NVq9jMkxYSFl6iwHFLlIpbHCQ3EWi7SB6JskcMt2IW94VRtEeXfOTVB4zVvbZZSmG63A96D0gJHQk2YuX8beNPzs8wNLmZaHx3DmvAJWFMAT4cPQ6Xu/KiGwBBqs9HkrWP/ilGLbObwhFnU6AiYxN2kQ4Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744220630; c=relaxed/simple;
	bh=MtID83NVzrryWVOVO0Svs05fGH/vIbBHq9cB2N/UeCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPe0SQRDJ7sH71A82w2XuEpdz+D4Dwng2xQLHLLSyclV7mNZyivVr9hCu8p0z5HiUW+Vc7FdZtma0FWM5nCQoiF9XEHGF+vHHWY0G8sZ8IKcfHXVbHR9gwl282+l8P5GUfNP6MGP4ij90PUxPchy4SjNh/2nJnuDdq4dzyTSl5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSEa44w6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844E3C4CEED;
	Wed,  9 Apr 2025 17:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744220629;
	bh=MtID83NVzrryWVOVO0Svs05fGH/vIbBHq9cB2N/UeCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TSEa44w6B7unc/ZsNLKHX4+rhG7W+tF6t+sZbTP1gjyf+JQEmSksFeTUOp9VMkB6j
	 V5X0zENSlMCQheEBAEUkbxrwXKtQGWb6ABZmClMHbBrSR99YjvBzu/al/A8iIKyRn4
	 9g2VSHATuMz0Od+w+5uocSuDSGCczE+ktkRfXA49xHmU4jt9ibT1BIBRB2uIMZoNaO
	 2dB22BmtMmFEjCYGUpvwc7ldxg5n1+1axR2mFMGLqERXWz/PpXdRARizR1pF22CK11
	 DqtaFEY60CI0rdCfuvTzUQBQ+XwSfTXNnMCypgRxbFJcKHSen+yH+IPQ7oIOyaAmOP
	 FsMCUqCAhYdcw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so592467fac.0;
        Wed, 09 Apr 2025 10:43:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlh1bkufDY2PBYmQj+gR+5ua8nBoj5BgC5jSGo0Qb48bjHq+oLjorbh1hk76Hnya/mNWG4oF8togrl4IQ=@vger.kernel.org, AJvYcCWP9tvgoxv8StHa4+qHcZAp9KNuxIvJPn2DCctBeq3t6d8kYFqDDwFsznGIfZfIyLb4LxrNQYwqURzg@vger.kernel.org
X-Gm-Message-State: AOJu0YwWh2vBbGgWo+cPRwUV5kh+nFWNoNQ85pQLbUeHiq6Eq8iHoOR4
	fpz8/iIOVTtElQcb233oUtq0Dx/7fXvfxlD7NWMhUgPqaotFsApT/ddlIxHHThlZEfkJQMoQLSA
	cySyLuWyEKgAtnHGAOEEarrS5gk8=
X-Google-Smtp-Source: AGHT+IEPa25BLLz45O3A0aw2iD4LjOUUKGFiVDtx9bT0W1iV2DAm1cz3hWJk/Q9WFcb6+s9b/jRDJAaSzvz/wnM7boI=
X-Received: by 2002:a05:6871:50c3:b0:29e:3d2a:a4a9 with SMTP id
 586e51a60fabf-2d0ad00e7d7mr261368fac.5.1744220628802; Wed, 09 Apr 2025
 10:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327195928.680771-2-csokas.bence@prolan.hu> <20250327195928.680771-3-csokas.bence@prolan.hu>
In-Reply-To: <20250327195928.680771-3-csokas.bence@prolan.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 19:43:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jmuzvo-xzGBDhGVBbY7svbrqEdi-SeJrx5BG=qtN6ZiQ@mail.gmail.com>
X-Gm-Features: ATxdqUGGv3EHTXO2Nz1qHrCletcbUOdpHS7e7KIVtcT50Kb-Q5VhiMdKVyPZvbU
Message-ID: <CAJZ5v0jmuzvo-xzGBDhGVBbY7svbrqEdi-SeJrx5BG=qtN6ZiQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] pm: runtime: Add new devm functions
To: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Varshini Rajendran <varshini.rajendran@microchip.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexander Dahl <ada@thorsis.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Pavel Machek <pavel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 8:59=E2=80=AFPM Bence Cs=C3=B3k=C3=A1s <csokas.benc=
e@prolan.hu> wrote:
>
> Add `devm_pm_runtime_set_active_enabled()` and
> `devm_pm_runtime_get_noresume()` for simplifying common cases in drivers.
>
> Signed-off-by: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu>

I can apply this one alone if you want me to do that, but I could also
apply the other patch in the series if it got an ACK from the driver
maintainer.

> ---
>  drivers/base/power/runtime.c | 44 ++++++++++++++++++++++++++++++++++++
>  include/linux/pm_runtime.h   |  4 ++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 0e127b0329c0..205a4f8828b0 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1568,6 +1568,32 @@ void pm_runtime_enable(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_enable);
>
> +static void pm_runtime_set_suspended_action(void *data)
> +{
> +       pm_runtime_set_suspended(data);
> +}
> +
> +/**
> + * devm_pm_runtime_set_active_enabled - set_active version of devm_pm_ru=
ntime_enable.
> + *
> + * @dev: Device to handle.
> + */
> +int devm_pm_runtime_set_active_enabled(struct device *dev)
> +{
> +       int err;
> +
> +       err =3D pm_runtime_set_active(dev);
> +       if (err)
> +               return err;
> +
> +       err =3D devm_add_action_or_reset(dev, pm_runtime_set_suspended_ac=
tion, dev);
> +       if (err)
> +               return err;
> +
> +       return devm_pm_runtime_enable(dev);
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_runtime_set_active_enabled);
> +
>  static void pm_runtime_disable_action(void *data)
>  {
>         pm_runtime_dont_use_autosuspend(data);
> @@ -1590,6 +1616,24 @@ int devm_pm_runtime_enable(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(devm_pm_runtime_enable);
>
> +static void pm_runtime_put_noidle_action(void *data)
> +{
> +       pm_runtime_put_noidle(data);
> +}
> +
> +/**
> + * devm_pm_runtime_get_noresume - devres-enabled version of pm_runtime_g=
et_noresume.
> + *
> + * @dev: Device to handle.
> + */
> +int devm_pm_runtime_get_noresume(struct device *dev)
> +{
> +       pm_runtime_get_noresume(dev);
> +
> +       return devm_add_action_or_reset(dev, pm_runtime_put_noidle_action=
, dev);
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_runtime_get_noresume);
> +
>  /**
>   * pm_runtime_forbid - Block runtime PM of a device.
>   * @dev: Device to handle.
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 7fb5a459847e..756b842dcd30 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -96,7 +96,9 @@ extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device_link *link);
>  extern void pm_runtime_release_supplier(struct device_link *link);
>
> +int devm_pm_runtime_set_active_enabled(struct device *dev);
>  extern int devm_pm_runtime_enable(struct device *dev);
> +int devm_pm_runtime_get_noresume(struct device *dev);
>
>  /**
>   * pm_suspend_ignore_children - Set runtime PM behavior regarding childr=
en.
> @@ -294,7 +296,9 @@ static inline bool pm_runtime_blocked(struct device *=
dev) { return true; }
>  static inline void pm_runtime_allow(struct device *dev) {}
>  static inline void pm_runtime_forbid(struct device *dev) {}
>
> +static inline int devm_pm_runtime_set_active_enabled(struct device *dev)=
 { return 0; }
>  static inline int devm_pm_runtime_enable(struct device *dev) { return 0;=
 }
> +static inline int devm_pm_runtime_get_noresume(struct device *dev) { ret=
urn 0; }
>
>  static inline void pm_suspend_ignore_children(struct device *dev, bool e=
nable) {}
>  static inline void pm_runtime_get_noresume(struct device *dev) {}
> --
> 2.49.0
>
>

