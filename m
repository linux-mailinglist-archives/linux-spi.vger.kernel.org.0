Return-Path: <linux-spi+bounces-12083-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D687CD89BA
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 10:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00D49300B90D
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 09:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45202FDC2C;
	Tue, 23 Dec 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0mtlyEY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3472D594B
	for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766482623; cv=none; b=q9ZbFRJe/BAycIX2CJJ5gzMQA38aJ7v0MrWHLTARjaOCn0takf1PUxgga2yvMYESvS804ftctmK2uNx5pRlXunN4SotgOKa9rHnZGlX4E5x+XE/6GwmBA7NVOXrPuth4Fxwx1rncLvr16INwcXFg1+5FZw4Oklu/AV0nT+nfpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766482623; c=relaxed/simple;
	bh=T7KdQjnc1uAnk0At9YIJM3OVO0ziJByUW/8OGO/MlBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L76O5eNAZhKxrCb0ThZUP7jbWS42kwdGFgHu1ylefo8tbZ1PavWe4Xq80pBgI5I2dXLzycrfVIVomf51L3OTUzI+yb9i4pmNYmdxHd83hZtHc79QWNiBtdjDeNCMkBo0IJB8E/OiPycr+L3F6MoudWOCWeI+Fl7NigsWEwlFdzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0mtlyEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDA8C113D0
	for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 09:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766482623;
	bh=T7KdQjnc1uAnk0At9YIJM3OVO0ziJByUW/8OGO/MlBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q0mtlyEYiBuWBeUMXAJByFmBy8npgy2+oi12ugdiP0o5JCAhEA3zeSKW+micYtDa6
	 7TwBW3mwlYmcUQIPmOqZ0EpXQteHWQrEXoh2CpQd/fO3C6MBcWwyOwFGXIXXP4r0ph
	 1/yZ7X9oC7OfPezZ8UozxmIyqHWPJRRv8911BfqqI//WDMliRy17DzesDncZ1uGcdc
	 jyEuCQzy2v71YIZsjeJjaav+ksZPZh+hbsc7rvZo2YLdYZfOEw10DsMhEWsG+LsCpw
	 ieJQUpSQNg+QvAS5N2u7TWsXqEckSNDq/UMLmns7irEfYYhhQC1VhvlUC9S0ngamKd
	 OZP+JopGHaDCg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5942b58ac81so4197898e87.2
        for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 01:37:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/PNPnBVqgJtBKPlyEWnYip/YKv+xOM/evIovKHH0bI0tXrS7uL+jtMRXTGg90HTpVnBSuU+dgw3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YygosMOC71dSO1jybyFkwZrYOuboVq2AYviLMTbjQyKhSc4Y1qY
	pNuCaOmsgnu4ler61Jg6T4JlM5PTrAJ+hwo2KB8aw8OOScn7Bc/mNAstulzIBcqy9S//jl2NMN9
	RIme6KEIiMz+ZsAeFJyrYojORzmK1O4KWidRYRDyuHg==
X-Google-Smtp-Source: AGHT+IFQmsuAwcJwXOY4Cft1R1mIu4P0sIxwn5FcrYQ9SfkpyCGe9lU8pbvbXq6nf2AIumojH6nvcmsXC8PZXvc1epU=
X-Received: by 2002:a05:6512:150c:20b0:59a:19dd:5225 with SMTP id
 2adb3069b0e04-59a19dd523fmr3452366e87.16.1766482621926; Tue, 23 Dec 2025
 01:37:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <02fd01dc73df$3b641bf0$b22c53d0$@trustnetic.com>
 <CAMRc=Mf2A++CHYcMdBi0bQ0DOAGLaSatQEOmu=aAEG_YjCqEWg@mail.gmail.com> <030001dc73e8$56e38330$04aa8990$@trustnetic.com>
In-Reply-To: <030001dc73e8$56e38330$04aa8990$@trustnetic.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 23 Dec 2025 10:36:49 +0100
X-Gmail-Original-Message-ID: <CAMRc=Meugd9tEDefPnYHidDMTdCP+8fptVXNvqjSi1tjXPuVRA@mail.gmail.com>
X-Gm-Features: AQt7F2qmNlXBQvP6GbuHDACTxUbNxwHE2nXemqt_etQvVh1rf8nZyb3TWDSPYLc
Message-ID: <CAMRc=Meugd9tEDefPnYHidDMTdCP+8fptVXNvqjSi1tjXPuVRA@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] software node: allow referencing firmware nodes
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, andriy.shevchenko@linux.intel.com, 
	andy@kernel.org, broonie@kernel.org, ckeepax@opensource.cirrus.com, 
	dakr@kernel.org, david.rhodes@cirrus.com, djrscally@gmail.com, 
	gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, krzk@kernel.org, 
	linus.walleij@linaro.org, linux-acpi@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org, 
	mstrozek@opensource.cirrus.com, p.zabel@pengutronix.de, 
	patches@opensource.cirrus.com, rafael@kernel.org, rf@opensource.cirrus.com, 
	sakari.ailus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 9:44=E2=80=AFAM Jiawen Wu <jiawenwu@trustnetic.com>=
 wrote:
>
> On Tue, Dec 23, 2025 4:09 PM, Bartosz Golaszewski wrote:
> > On Tue, Dec 23, 2025 at 8:39=E2=80=AFAM Jiawen Wu <jiawenwu@trustnetic.=
com> wrote:
> > >
> > > >
> > > >  #define SOFTWARE_NODE_REFERENCE(_ref_, ...)                  \
> > > >  (const struct software_node_ref_args) {                           =
   \
> > > > -     .node =3D _ref_,                                          \
> > > > +     .swnode =3D _Generic(_ref_,                               \
> > > > +                        const struct software_node *: _ref_, \
> > > > +                        default: NULL),                      \
> > > > +     .fwnode =3D _Generic(_ref_,                               \
> > > > +                        struct fwnode_handle *: _ref_,       \
> > > > +                        default: NULL),                      \
> > > >       .nargs =3D COUNT_ARGS(__VA_ARGS__),                       \
> > > >       .args =3D { __VA_ARGS__ },                                \
> > > >  }
> > >
> > > This change seems incompatible with my driver txgbe, since the softwa=
re nodes
> > > are registered in " struct software_node * " but not " const struct s=
oftware_node * ".
> > >
> > > So when I pulled the net-next-6.19-rc1 that merged this patch, to pro=
be my driver.
> > > The error logs shows:
> > >
> > > [    5.243396] txgbe 0000:10:00.0 (unnamed net_device) (uninitialized=
): unable to attach SFP bus: -EINVAL
> > > [    5.243399] txgbe 0000:10:00.0: failed to init phylink
> > > [    5.576008] txgbe 0000:10:00.0: probe with driver txgbe failed wit=
h error -22
> > > [    6.109548] txgbe 0000:10:00.1 (unnamed net_device) (uninitialized=
): unable to attach SFP bus: -EINVAL
> > > [    6.109551] txgbe 0000:10:00.1: failed to init phylink
> > > [    6.442044] txgbe 0000:10:00.1: probe with driver txgbe failed wit=
h error -22
> > >
> >
> > This shouldn't have changed anything for existing software nodes - the
> > pointer in struct software_node_ref_args has always been const. This
> > would have failed at build-time if this was an issue. Have you
> > bisected it to this very commit? What line is the -EINVAL assigned and
> > for what reason?
>
> The -EINVAL is assigned software_node_get_reference_args():
>
>         if (ref->swnode)
>                 refnode =3D software_node_fwnode(ref->swnode);
>         else if (ref->fwnode)
>                 refnode =3D ref->fwnode;
>         else
>                 return -EINVAL;
>
> I think the reason is that _Generic selection is restrictive, it only acc=
ept
> exactly const struct software_node for software node references. So the
> macro SOFTWARE_NODE_REFERENCE fall back to the default to set .swnode =3D=
  NULL.
>
> And I temporarily added this line to fix it:
>
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 272bfbdea7bf..e30ef23a9af3 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -371,6 +371,7 @@ struct software_node_ref_args {
>  (const struct software_node_ref_args) {                                \
>         .swnode =3D _Generic(_ref_,                               \
>                            const struct software_node *: _ref_, \
> +                          struct software_node *: _ref_,       \
>                            default: NULL),                      \
>         .fwnode =3D _Generic(_ref_,                               \
>                            struct fwnode_handle *: _ref_,       \
>

Ah I see, we'd assign struct software_node * to const struct
software_node * and it used to work but with _Generic() we need the
exact type. I agree with this approach, do you want to send a proper
patch?

Bart

