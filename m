Return-Path: <linux-spi+bounces-7330-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2492AA71D50
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 18:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7560318898B5
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A9B23BD1D;
	Wed, 26 Mar 2025 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNLiZKgm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77AE22ACD1;
	Wed, 26 Mar 2025 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010714; cv=none; b=cMxxVS2ISajpUjomQFEmEA/BTPC/st92xp99S8M5867rSjTvqnzr76QNClycr10YqL/Vvqu2ziIqIt9YdEIrfYvImf5YzKgZMGzVNNNstNxAm//R/IgA+hQEbeY+O3YQ1WkXi13iULR75Ser3gAttpQhOAHcebYVzHhsv7AUReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010714; c=relaxed/simple;
	bh=ZyxutTsVh46fH3XEd2TbSh2/N648DOeEQ0+sSrSt2iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Asemec58egtuRTClSYCLV+fxyUmoI7oUH6+tRQUuNnWf6HVlk3Pbpj25UNYoNeZar/k2UGx9gHzu1xaVnxaA/An1EyBi/khNWodEiUlu9eRiDWwYQ3m8hd27J7oJ8icKiAOe4rLYIjziKjX+aOAFfAPi2BOQTe0vfVLphlgGz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNLiZKgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B513C4CEF2;
	Wed, 26 Mar 2025 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743010714;
	bh=ZyxutTsVh46fH3XEd2TbSh2/N648DOeEQ0+sSrSt2iU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fNLiZKgmPihLdjwoInNV7fqOMOc/StItt6c3ipl+qfnrjmUIPCojqIbIqcgR3kQr2
	 QZUV1QTiYfD0eOU/hR9LUwbm5c4ZGkQZNt1LsTm6MYi+LkgedCgFQd0mgNn8Vi/RqU
	 j5s6ws2mKKQp81hDDZrpKh70ICJngD3NOB1Fe3Ttbf0MimxG64mF6bxx3ciqBoXNhS
	 8Odoew8ggFEnzscFFQbgxWZqorgkQPCi3GW7yHmrKM0n0gGEF2Xq5r0QlFZPsj7nX9
	 G89yQcs34d7wUxOtGWZGCdtqlnh5wShQKEbncOC/SnfYfRoIA5kK5l/AerhpyxHnjs
	 ko+095DmLIqzg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-600038877ebso70287eaf.0;
        Wed, 26 Mar 2025 10:38:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6XxPbL831fg9pWAv14daxpE8o+WawW9TbWmVqXtvFHkrDHc7q6aIcnjjnQGBPvObNf+1eXlSaez5L@vger.kernel.org, AJvYcCULBsBL7/5ubP/nU+8O611BEALjgMn6e6pEA3iFtXSe1B8ORy0plqNCs5DpE2Tzg1GXbtZ5JDJLYWQaOHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1egAa81CVr5fZAxzQsgtgek7ipXz1MqiBHP4hqciSORwQK39
	QXeLfbR8ZOlBj32mLfKL1wGWR5vJmBL6qGD8zYNFvaMGtiCjbJvLvUbN8E/oTmmhbyumJIEhJXc
	SB0/pC0Knz1v9cReikLc7MiwV884=
X-Google-Smtp-Source: AGHT+IGg7eH9QWYfbDrBJ2FJDudyXDT9YK3hV3X5mb5l8doONA3okbIYrYqOJiry/b3Gtou6+i/QFZ04lWY33we4Jao=
X-Received: by 2002:a05:6870:5b9b:b0:2c1:3d93:c192 with SMTP id
 586e51a60fabf-2c848221302mr204027fac.37.1743010713193; Wed, 26 Mar 2025
 10:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317093445.361821-1-csokas.bence@prolan.hu> <20250317093445.361821-2-csokas.bence@prolan.hu>
In-Reply-To: <20250317093445.361821-2-csokas.bence@prolan.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Mar 2025 18:38:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hJZBxU6SSq9C8gp2peETFWu0jbhrM82B5GvQkVXPR+9Q@mail.gmail.com>
X-Gm-Features: AQ5f1JrcLyMXU0AXf56Zv0FLxsWH5M_UdoHXg48ickDdwk4WFSdM0LXMMkgNyG4
Message-ID: <CAJZ5v0hJZBxU6SSq9C8gp2peETFWu0jbhrM82B5GvQkVXPR+9Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] pm: runtime: Add new devm functions
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

On Mon, Mar 17, 2025 at 10:35=E2=80=AFAM Bence Cs=C3=B3k=C3=A1s <csokas.ben=
ce@prolan.hu> wrote:
>
> Add `devm_pm_runtime_set_active()` and
> `devm_pm_runtime_get_noresume()` for
> simplifying common use cases in drivers.
>
> Signed-off-by: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu>
> ---
>  drivers/base/power/runtime.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/pm_runtime.h   |  4 ++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 9589ccb0fda2..821a8b4961d4 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1568,6 +1568,24 @@ void pm_runtime_enable(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(pm_runtime_enable);
>
> +static void pm_runtime_set_suspended_action(void *data)
> +{
> +       pm_runtime_set_suspended(data);
> +}
> +
> +/**
> + * devm_pm_runtime_set_active - devres-enabled version of pm_runtime_set=
_active.
> + *
> + * @dev: Device to handle.
> + */
> +int devm_pm_runtime_set_active(struct device *dev)
> +{
> +       pm_runtime_set_active(dev);
> +
> +       return devm_add_action_or_reset(dev, pm_runtime_set_suspended_act=
ion, dev);
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_runtime_set_active);

I said I didn't like it and I'm still not liking it.

The problem is that the primary role of pm_runtime_set_active() is to
prepare the device for enabling runtime PM, so in the majority of
cases it should be followed by pm_runtime_enable().  It is also not
always necessary to call pm_runtime_set_suspended() after disabling
runtime PM for a device, like when the device has been
runtime-suspended before disabling runtime PM for it.  This is not
like releasing a resource that has been allocated and using devm for
it in the above way is at least questionable.

Now, there is a reason why calling pm_runtime_set_suspended() on a
device after disabling runtime PM for it is a good idea at all.
Namely, disabling runtime PM alone does not release the device's
suppliers or its parent, so if you want to release them after
disabling runtime PM for the device, you need to do something more.
I'm thinking that this is a  mistake in the design of the runtime PM
core.

If there were functions like pm_runtime_enable_in_state() (taking an
additional state argument and acquiring all of the necessary
references on the parent and suppliers of the target device) and
pm_runtime_disable_and_forget() (that in addition to disabling runtime
PM would drop the references acquired by the former), then it would
make a perfect sense to provide a devm variant of
pm_runtime_enable_in_state() with the cleanup action pointing to
pm_runtime_disable_and_forget().

If this helps, I can do some work on providing
pm_runtime_enable_in_state() and pm_runtime_disable_and_forget() or
equivalent.

> +
>  static void pm_runtime_disable_action(void *data)
>  {
>         pm_runtime_dont_use_autosuspend(data);
> @@ -1590,6 +1608,24 @@ int devm_pm_runtime_enable(struct device *dev)
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
> index 7fb5a459847e..364355da349a 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -96,7 +96,9 @@ extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device_link *link);
>  extern void pm_runtime_release_supplier(struct device_link *link);
>
> +int devm_pm_runtime_set_active(struct device *dev);
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
> +static inline int devm_pm_runtime_set_active(struct device *dev) { retur=
n 0; }
>  static inline int devm_pm_runtime_enable(struct device *dev) { return 0;=
 }
> +static inline int devm_pm_runtime_get_noresume(struct device *dev) { ret=
urn 0; }
>
>  static inline void pm_suspend_ignore_children(struct device *dev, bool e=
nable) {}
>  static inline void pm_runtime_get_noresume(struct device *dev) {}
> --
> 2.48.1
>
>
>

