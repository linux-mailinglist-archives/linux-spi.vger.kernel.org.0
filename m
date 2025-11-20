Return-Path: <linux-spi+bounces-11376-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0AFC7310B
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 10:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6AD1F3025B
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 09:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC6B312817;
	Thu, 20 Nov 2025 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="r8Xwz5FB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4543093DD
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629977; cv=none; b=dyYWupb6bNlNS9yeHP5vbiKgC1uUdANuJYF7BoGO5++WFxLeJmgrxYFwUPmmqlSZRSFHGq3k/xv/8du47ELEvTZL20YpE3dF7bGe40xjTK8hcPUgCIbHj6wqybm9IMGcYIXlQsjlbOoYQ8avOEd06i02Roj4P7HJdzRRqYS3QUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629977; c=relaxed/simple;
	bh=TUX+GFFIqD3F1wNgRxudb9AfkaouE2DTUx7l6rSlY2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pb11o9K45AiAQyvIEktOpkWF13oP/1q6dfhz6WYp9lXqxrlwnIDQB7vqLfdBy6dP2yUs5nmFRM7bjCkHDBRkGwK5o4qY/18Mu2NtU0r8aOelPNm98vpFW6UVJrHbZrtoJQE2BC02++gqByCgoJmjEQsRrIBPLDFS4jnWC6Ael7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=r8Xwz5FB; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5959d9a8eceso659655e87.3
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 01:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763629974; x=1764234774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUX+GFFIqD3F1wNgRxudb9AfkaouE2DTUx7l6rSlY2U=;
        b=r8Xwz5FBLP73YCTzzF7q4ICl8/9g0XnxhEnsPPjS97KHGZrVtY5Kb14TavHDmMpSLT
         PC87lHUBGWfwKh+6R6jVoL5roScE4++OoIuh1OBS6f2YVw6GBKU+T81eZ58mgPuotGSG
         CUd6YjTtalDoDTvnOOtDyIjp479A9RysKAwS8lrdgqkthSk06KAFzG8ItDs/3bQvEadn
         tgPmO3R+TLJaQB+qFYC3EikjTMQ2Tv3T8rF92TYtUGfSQvnVKiA1VuacTao3Kc7lPp9G
         8lnxFHsDcGjfUhvZltGOFyk+hOinhJeRa4ibizNjvyBOWAeh1aRm8gAZE6fXZ9uP4S7M
         WIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763629974; x=1764234774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TUX+GFFIqD3F1wNgRxudb9AfkaouE2DTUx7l6rSlY2U=;
        b=pbL0xHuizQOi/ePgcJhwbA4koJbYAlFxPsNlRWgJp5nEPSwM4ZhyDo4MT9NftlGafq
         5xm8aQEEvwce+QoLvi4WW38ImKZ3taiaPp+tdwOPe4H/d2j/dHHpCazR64H0cuoXwL8l
         2fiQ3rkwFM+NxXCoLexEjH1gDj9yDhN+AyvlNiFHLeGyowonJcnDUI1pCZRbhcJsorJm
         mdUnBXN+l8uXq3vbN4saeGQnDkpVoEyyBqdNHNqwdpLMcW+dS24NuREqvVVbsk8ao075
         8BJfvi4aGeJ5NNT4dHKqOuObnb6zgrUV7H1Tha81vxzKhJAkja1sF2rDqNPM7pUpvPgt
         sJHw==
X-Forwarded-Encrypted: i=1; AJvYcCXEdWxDcU9bS5TBqDsicjI6ChIOhwMjUKCFX1dZX+VLutV44KzCULhvtc67Vv13hmTah+Gy6g+yRQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTuFQsWQYfWNkuwfoSv+LMiRgxPpqTbH+En3qK5cqUqm9zT6wE
	gV+AAIvLhGAIX5nKJ6cD+EdOe86EGW9cAkNaaU8FGe78lRlWOhYeI4Sc0OEFlZl9HSA2amffXBS
	3qXx6jcH2ksJMD5hRI0/PDN/q0s5PFjEnIybOM67klg==
X-Gm-Gg: ASbGncsOmaIRaL2qYO2Gkvj6p7hCWms7CwsD521JSZ+CZzf0taDAkVkSsl8WMMVm8wB
	ssdXXjtqvnFtDfvRz/ffDko2kA4wT6PynRiWorfdkyIhawWNltOndN7mC51fOVnk/PaAlfvinIO
	JJUvd/vbU9QSs+O9TNV04K4VtXDd5EjbO9STBeVxiige/yZqxozUZkzZigOJ3yPhyfQMIDHKuDU
	vCEyrHuxeo7A4lU2xc1ARJ2KL3eHBZFiAv/bSZu9ZpljODvf63VNLnzqtq0Gd5RqTXlQiiRoLxc
	MS4AhJrYCd00C4blFhQOTutqtA==
X-Google-Smtp-Source: AGHT+IFrewKFpB97Jzc2s0X378rdQOV2UUV8z2iMGg1v1GytRO5AynAxifiX0eMqYfLL7nDCf4V6gEHjRJpWwGUb4ow=
X-Received: by 2002:a05:6512:114f:b0:595:90ee:f480 with SMTP id
 2adb3069b0e04-5969e2da8d2mr778584e87.16.1763629973838; Thu, 20 Nov 2025
 01:12:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aR2o2R30TbVOcqZe@opensource.cirrus.com> <CAMRc=MciO0WYejOYZduqE73U4OVTxcaMfe6Sv1VXWJWL2FFNmw@mail.gmail.com>
 <aR29uKW7yLxws9jA@opensource.cirrus.com> <CAMRc=MdXNXQhE9zi=i0x0yGCi0fKQNU8_tn2_Uy24TAhxG7BRA@mail.gmail.com>
 <aR3FnUNO4DyCdiLD@opensource.cirrus.com> <CAMRc=MfuQSGPbt3x366j5c9Sg-mgu=TfmD6X25Dk5Rmu0JiiEw@mail.gmail.com>
 <CAHp75VdLfkcrmaGBPu_YLDReyX5Gvu9pE6BXweArA5PmM3MQnQ@mail.gmail.com>
 <CAMRc=Mf9djJ77ob8L1OKa6HHBx_JxR_sajWH1mFGz=V+hMDbmw@mail.gmail.com>
 <CAHp75Vf_+WzMn+pmwK4zhLEZtG3Uat4FrdFMCMtPmmX82E3Wzg@mail.gmail.com>
 <CAMRc=MdbgeJOMoHDm_z04ko1pdKed06GP4=M+VsPaD3YOEvs6Q@mail.gmail.com> <aR4qxiR7pzrPdaUz@smile.fi.intel.com>
In-Reply-To: <aR4qxiR7pzrPdaUz@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Nov 2025 10:12:39 +0100
X-Gm-Features: AWmQ_blF7SCFHaFnDxpXYsYnTfe94q6BczdWGttvnUDgwBN9XkCciWPbXJH8NKw
Message-ID: <CAMRc=Me-DXN9kx+5bqDb9doMG9MX2EiRJiC=_QqDc0q3gOz8wA@mail.gmail.com>
Subject: Re: [PATCH RFT/RFC] mfd: cs42l43: setup true links with software nodes
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linus.walleij@linaro.org>, Maciej Strozek <mstrozek@opensource.cirrus.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 9:38=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 19, 2025 at 03:30:46PM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 19, 2025 at 3:24=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > > > My idea was to mark the fwnode with __private and fix the (ab)use=
rs,
> > > > > should not be so many. Can somebody mock up a coccinelle script t=
o
> > > > > find all dereferences of fwnode from struct device?
> > > >
> > > > I think you're underestimating the level of complexity. What about =
the
> > > > concept of dev_fwnode()? It literally makes no sense if we switch t=
o a
> > > > list of fwnodes.
> > >
> > > Why not? It will return the pointer to the primary node. You can look
> > > for example how the list of the DMA descriptors is done in
> > > drivers/dma/dw/core.c. Not the best solution, but gives you an idea o=
f
> > > how it may look.
> >
> > What even is a primary node though? You can have auxiliary devices
> > without an ACPI or OF node.
>
> The one which gives the main set of the properties for the device.
> The devices that don't have it, simply have a list of fwnodes empty.
>

Well, what *is* the *main* set of properties? Who declares that? I
agree, it's easy for device-tree - the OF node is the main one, but
then what if a sub-device inherits the OF node of the parent while we
also add a software node? It's not that straightforward and we'll run
into issues for sure just like what we're seeing now with secondary
fwnodes.

> > Only with software nodes. Which one is the
> > primary? The first one we add?
>
> Yes. The problem here might be if we add the SW node before the actual FW=
 node
> appear (it can be if we created some devices before the actual FW based
> enumeration happens. It would probably need to have some kind of weight
> (or priority value) and list should be sorted based on that number.
>

Ugh, please no. Firmware node priority?? With magic numbers?

> > > > For it to make sense we'd have to have a kind of "dynamic" firmware
> > > > node attached to a device which we'd fill with an aggregation of al=
l
> > > > properties from firmware nodes in the list.
> > >
> > > "Dynamic" is just a node in the list. The only potential problem here
> > > is prioritisation. Should we add to the head, tail or insert? But
> > > converting current approach will be straightforward.
> >
> > What I have in my mind is not another firmware node in the list in
> > struct device but rather a new firmware node implementation, that
> > would be assigned to the device via a dedicated pointer and would be
> > filled with a logical OR of properties from other firmware nodes added
> > to the list.
>
> Oh no, this won't work in corner cases. What if we actually need to "fix"
> an existing primary node (there were discussions long time ago about inve=
rting
> primary/secondary in some corner cases, but it didn't appear so far as
> it most likely will give tons of issues in the _current_ design)?
>

What do you mean by "fix"? Like repair? Or fix in place? I'm not following.

> > Then dev_fwnode() would return this rather than any one
> > of the firmware nodes from the list. Think of it as the "master
> > fwnode" of a struct device.
>
> fwnode should not be in any relations to the device, I mean when we do fw=
nodes,
> we should not assume that it's backing the device. In the idea you shared=
 it
> won't be possible ("dedicated pointer") in mine it is (just a list of som=
ething
> that may belong to the device, or to another object, doesn't matter).
>

That's not true, we expect fwnodes to back real devices all the time.
Look at all the find_device_by_fwnode() functions we have everywhere.

The crux of the problem Charles identified is the fact that the
secondary fwnode is a field of struct fwnode_handle and not of a
struct device. This really doesn't make sense as we see where multiple
devices use a single "real" fwnode but want to have different
secondary software nodes.

Moving the secondary fwnode to struct device would already help a lot
but if we're doing that then we may as well switch to a list of
fwnodes.

Bart

