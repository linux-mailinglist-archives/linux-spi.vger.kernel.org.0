Return-Path: <linux-spi+bounces-11378-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6D5C73368
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 996714EA6E3
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC61313267;
	Thu, 20 Nov 2025 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="W6Q6zga1"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C613191C3
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630998; cv=none; b=cTxCK7u7sMYhJ8MN5DWeO7yVDg81Thn+a1rSmAqiFxLM/ba4fY/PWOXwhMug4/FTE0I7Pal7PzAScYCmmE2Vf2xBlBX3XlYe7nmTgN+tatL5vyRtBGAsL5tzGodh3fKH1VpNp9NoKAbtWsrEtca5tyXi8Im/DQqArDIdRqllJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630998; c=relaxed/simple;
	bh=poeIlxLS0FpBxM2bUy25CXaNVokxPqJgTzoh0f/EnWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0ctVoI8ummxPXeZDs6i7qrZbkf+teP4R3zWB1DKZmLJB22Tc7BzkqtxhkItrIMXKeTPj6RZrfetq1mhUbeOBoz8QqMKPuY56iXRtB98/7jr8240n0ZX5XpYXd/aGahYI1Zu3yTJXpISX8tXjlbE0SOs1VSzqIuY9xG/FlW5jqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=W6Q6zga1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5957e017378so604585e87.3
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 01:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763630994; x=1764235794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F43BMCizskIWSqAPN8VXOzIpXlf5+R8t0fgagseYSfo=;
        b=W6Q6zga1Ufd24U17VymP4fo/oWZ4qedMdWluIkiR3NB7mXApXha3YMlOv6hU9c2EIc
         wsPLbZ0MZOzsIMbnr4tuncWN68v+22C87DVd0z+MmPSmCyW3aubhP1hgqdlIYx4VYixX
         uLMQ2kKAUkeJAktcFYVXeIyUqGwCa3wAZNyNt4Z35CpNCYI0y/byMY8ieQln7hyClfmA
         RXBiqsDL6CiX5RfHPEaP1G6dt89ytkqb5RNxvXCNJjhV3BE2OoKcBKjI/bvqXcFH+Vv3
         8S7M1OnAYRa83PIWaKqe2sQFE3JoYJ36jivbuM05tOFkMcn0r1XPUFJQQntFY+aZW4nR
         i3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763630994; x=1764235794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F43BMCizskIWSqAPN8VXOzIpXlf5+R8t0fgagseYSfo=;
        b=vIzM9ZxJuCLy5iy18adQ5sOUsuV100e1R9Jchy73VdjLhIf0dVMlWcLkAtgfXYbixk
         IQxNP0DBJ0nY2Mlp5o7LEl3S1nCAkZWrLYFtMigCS9OHMgPGJlR8XFp4v6br15TRuc2B
         Kl+Ki7Kvp6tb1G7tknW2uMakhd6BepBSTO2YBVgNIk4riGuq2OfLqV1F683xGZ45FZuJ
         VUVEDog5qjRPhixnBPEd02etqnjtJlIkq1QDAOCS324pQd8FINDzYzlAdAnZVOhclk7x
         zrXIANHV0U+9rC1v4r5jXpeto1oTWfyIU1MpCr0wVcsV31n2k8Xo5+RM/ZpoDW8ZubLk
         MqRw==
X-Forwarded-Encrypted: i=1; AJvYcCVcNf7NFf1Ao/vK8demMFnFEMge8iro55wWLNUFYjvWIMbjKMN/FeWL8H2W2hKVu6R1zhFT2pAv0ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhZ1JmPHQzFFpi0gVBgjQ1Zcw68DO6oDXyElZXg/NDK4ZBD9B
	yYE+JYS/8Svo8lOftTWeeS6a7MtxlWFjVbbdOc8mYEfJIPrO+HV0Ydj/B5Kg63OT3oKruq1wSl0
	bZC4moH+4yQ7zZH3EOsfzjMaDtxLqaLYIwEIh7O5m8Q==
X-Gm-Gg: ASbGnct9rhpaLw8xjL9CiCS+xvyoflsp5eViYN6yVN4uNHVKHf4ih1CtIY+FoDn6Xzv
	/dspCQDkMAuWfqcBy+fjiJPP4JVOL4d5Mno++Nb44qIAXhDLotsYrHLYfJtRXXQ03z/spaFwUQR
	Ool04mloa6F0Hq5CszamvOGiLsjtOCtJRf3bBK6DgBJtwXpLskFfDeyd3m9rFNCGUBYf6WfyP7B
	uCJQJyNwvTBjiK3bmkR3YTaK8swvd1MU2AoVkuP47Ege0xur/HTv+PWrM62eWvIctkbiP9/ABxT
	kMwkfI7jKHC4+ah/+nopIsImXn+2Efq5JDbL
X-Google-Smtp-Source: AGHT+IEiliF4lCwVvA0WmrZ6kPHJQ7Sia+p4ijdZDj5zJYUowt6ZfHbNwMrUGSAkRQXUMHHfY5D6gJU1HbFuwkRDqWc=
X-Received: by 2002:a05:6512:3f18:b0:594:3570:3572 with SMTP id
 2adb3069b0e04-5969e2d5902mr816665e87.1.1763630993732; Thu, 20 Nov 2025
 01:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119164017.1115791-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20251119164017.1115791-1-ckeepax@opensource.cirrus.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 10:29:41 +0100
X-Gm-Features: AWmQ_bmMVw03zfwC17No97LHNfR1dMxjr0gnJG3u36VTu1BoWlfLSYPNdAOcAOY
Message-ID: <CAMRc=MdcL0f9aE5emAsFLmwZoN5_-qM4JCSzP6D3J8D1PrsaEg@mail.gmail.com>
Subject: Re: [PATCH] spi: cs42l43: Use actual ACPI firmware node for chip selects
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, andy@kernel.org, 
	p.zabel@pengutronix.de, linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	bartosz.golaszewski@linaro.org, linux-kernel@vger.kernel.org, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 5:40=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On some systems the cs42l43 has amplifiers attached to its SPI
> controller that are not properly defined in ACPI. Currently software
> nodes are added to support this case, however, the chip selects
> for these devices are specified using a bit of a hack. A software
> node is added with the same name as the pinctrl driver, as the look
> up was name based this caused the GPIO looks to return the pinctrl
> driver even though the swnode is not associated with the pinctrl
> driver. This was necessary as the swnodes did not support directly
> linking to real firmware nodes.
>
> Since commit e5d527be7e69 ("gpio: swnode: don't use the
> swnode's name as the key for GPIO lookup") changed the lookup to
> be fwnode based this hack will no longer find the pinctrl driver,
> resulting in the driver not probing. But other patches also add support
> for linking a swnode to a real fwnode node [1]. As such switch over to
> just passing the real fwnode for the pinctrl property to avoid any
> issues.
>
> [1] https://lore.kernel.org/linux-gpio/20251106-reset-gpios-swnodes-v6-0-=
69aa852de9e4@linaro.org/
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>
> Ok here is what I would propose to fix this one, IMPORTANT NOTE: this
> does depend on the first four patches of the linked chain which I don't
> think are merged yet. But I would argue if we are removing the name
> based look up, we should add support for fwnodes at the same time.
>

I would then suggest an ack from Mark and making it part of the larger
series coming after swnode changes but before GPIO.

If it works for you better than the ones I proposed then I'm fine with it.

>  drivers/spi/spi-cs42l43.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
> index 14307dd800b74..b7dd5f6ecc30e 100644
> --- a/drivers/spi/spi-cs42l43.c
> +++ b/drivers/spi/spi-cs42l43.c
> @@ -52,12 +52,8 @@ static struct spi_board_info amp_info_template =3D {
>         .mode                   =3D SPI_MODE_0,
>  };
>
> -static const struct software_node cs42l43_gpiochip_swnode =3D {
> -       .name                   =3D "cs42l43-pinctrl",
> -};
> -
>  static const struct software_node_ref_args cs42l43_cs_refs[] =3D {
> -       SOFTWARE_NODE_REFERENCE(&cs42l43_gpiochip_swnode, 0, GPIO_ACTIVE_=
LOW),
> +       SOFTWARE_NODE_REFERENCE(NULL, 0, GPIO_ACTIVE_LOW),
>         SOFTWARE_NODE_REFERENCE(&swnode_gpio_undefined),
>  };
>
> @@ -324,11 +320,6 @@ static void cs42l43_release_of_node(void *data)
>         fwnode_handle_put(data);
>  }
>
> -static void cs42l43_release_sw_node(void *data)
> -{
> -       software_node_unregister(&cs42l43_gpiochip_swnode);
> -}
> -
>  static int cs42l43_spi_probe(struct platform_device *pdev)
>  {
>         struct cs42l43 *cs42l43 =3D dev_get_drvdata(pdev->dev.parent);
> @@ -391,6 +382,9 @@ static int cs42l43_spi_probe(struct platform_device *=
pdev)
>         fwnode_property_read_u32(xu_fwnode, "01fa-sidecar-instances", &ns=
idecars);
>
>         if (nsidecars) {
> +               struct software_node_ref_args *args;
> +               struct property_entry *props;
> +
>                 ret =3D fwnode_property_read_u32(xu_fwnode, "01fa-spk-id-=
val", &spkid);
>                 if (!ret) {
>                         dev_dbg(priv->dev, "01fa-spk-id-val =3D %d\n", sp=
kid);
> @@ -403,17 +397,20 @@ static int cs42l43_spi_probe(struct platform_device=
 *pdev)
>                                                      "Failed to get spk-i=
d-gpios\n");
>                 }
>
> -               ret =3D software_node_register(&cs42l43_gpiochip_swnode);
> -               if (ret)
> -                       return dev_err_probe(priv->dev, ret,
> -                                            "Failed to register gpio swn=
ode\n");
> +               props =3D devm_kmemdup(priv->dev, cs42l43_cs_props, sizeo=
f(cs42l43_cs_props),
> +                                    GFP_KERNEL);
> +               if (!props)
> +                       return -ENOMEM;

You don't need to allocate it for more than the duration of this
function, device_create_managed_software_node() makes a deep copy of
the properties. They can be on the stack.

>
> -               ret =3D devm_add_action_or_reset(priv->dev, cs42l43_relea=
se_sw_node, NULL);
> -               if (ret)
> -                       return ret;
> +               args =3D devm_kmemdup(priv->dev, cs42l43_cs_refs, sizeof(=
cs42l43_cs_refs),
> +                                   GFP_KERNEL);
> +               if (!args)
> +                       return -ENOMEM;

Same here.

> +
> +               args[0].fwnode =3D fwnode;
> +               props->pointer =3D args;
>
> -               ret =3D device_create_managed_software_node(&priv->ctlr->=
dev,
> -                                                         cs42l43_cs_prop=
s, NULL);
> +               ret =3D device_create_managed_software_node(&priv->ctlr->=
dev, props, NULL);
>                 if (ret)
>                         return dev_err_probe(priv->dev, ret, "Failed to a=
dd swnode\n");
>         } else {
> --
> 2.47.3
>

This is looking good, if you post a v2 and it's reviewed, I can resend
my series with this included and maybe it'll still make v6.19.

Bart

