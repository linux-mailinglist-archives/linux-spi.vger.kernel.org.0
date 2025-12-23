Return-Path: <linux-spi+bounces-12084-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA23CD8AA1
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 10:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E097E300EA21
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4762E2C236D;
	Tue, 23 Dec 2025 09:48:34 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA7B3A1E8B;
	Tue, 23 Dec 2025 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766483314; cv=none; b=t3gi3ZZ9aIQFxSjZAKa19PbycXPzYgjfCATvx6R7beMLP/JE7F3RV1+7vNwubUsNh40KEz+rB9ZYsS8UCm3fjOMJ4SUMWVcasCSIwROjTlbiOQSxiu6N6MK6TxcPzaa/3BEa3KMkPQEym3kthhAkCd4YUVQfLdwm6/LYOr61DBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766483314; c=relaxed/simple;
	bh=NSK5fKc+qwzvToyUpEv21cUeZPQdVTDmi5IyXk6yn3Y=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qfR5O0RLYGf9QttHCMKwKloLh6aC31m/Swd/JgCv+TlavqtilJ+m8Qa1x6Jodf9DxS4Z5fYmpUn4w/eWtr0vQZ2TFqyDFa3lnsRZcfGH/N5vVZAaKu8ZzzzN2KceEZtPppciAqQgz/znubPhdFOoCNad/Z2HM4f7UG3SspkhI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas7t1766483303t410t46878
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.96.96])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 575001686058145555
To: "'Bartosz Golaszewski'" <brgl@kernel.org>
Cc: "'Bartosz Golaszewski'" <bartosz.golaszewski@linaro.org>,
	<andriy.shevchenko@linux.intel.com>,
	<andy@kernel.org>,
	<broonie@kernel.org>,
	<ckeepax@opensource.cirrus.com>,
	<dakr@kernel.org>,
	<david.rhodes@cirrus.com>,
	<djrscally@gmail.com>,
	<gregkh@linuxfoundation.org>,
	<heikki.krogerus@linux.intel.com>,
	<krzk@kernel.org>,
	<linus.walleij@linaro.org>,
	<linux-acpi@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-spi@vger.kernel.org>,
	<mstrozek@opensource.cirrus.com>,
	<p.zabel@pengutronix.de>,
	<patches@opensource.cirrus.com>,
	<rafael@kernel.org>,
	<rf@opensource.cirrus.com>,
	<sakari.ailus@linux.intel.com>
References: <02fd01dc73df$3b641bf0$b22c53d0$@trustnetic.com> <CAMRc=Mf2A++CHYcMdBi0bQ0DOAGLaSatQEOmu=aAEG_YjCqEWg@mail.gmail.com> <030001dc73e8$56e38330$04aa8990$@trustnetic.com> <CAMRc=Meugd9tEDefPnYHidDMTdCP+8fptVXNvqjSi1tjXPuVRA@mail.gmail.com>
In-Reply-To: <CAMRc=Meugd9tEDefPnYHidDMTdCP+8fptVXNvqjSi1tjXPuVRA@mail.gmail.com>
Subject: RE: [PATCH v7 3/9] software node: allow referencing firmware nodes
Date: Tue, 23 Dec 2025 17:48:22 +0800
Message-ID: <030101dc73f1$46a62b40$d3f281c0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIzaRfJPMiwz9071uYI3gJ0t6u2qwFWX8iGAiY76pIB9a+LsLRVe7rQ
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NG63YEgwc4yzH2s6FZiZ+v+sw7ZGl4YXG+B8TH52Xwp4o1MTGUCz/VeS
	OmdMT4fRmHwT5sai5aZEKyISsYpXXDKgwnvs8s8LKzEuM7y62eWWCYUvLGeYGUR9Mh20njk
	nJdaFKGwejxAIITrDCmG9+LCQywVrUvi9Zq+CrcKVcB+H1pRKwcw0bI3SSj/whmh7BMnSdz
	3VOUDnsOW/UDY/kYpnjtC2FyUtznGR7LE7mBBVWneck3WIja9jxjifRqXdCREj8LYKYryEB
	eqWFnUSbLfuCe4w/J0wbBtjeN8GiE7jhtXOuQ8KIObY9/v0wHDrV8OnWXKZeoSoWVSz9UVm
	fir4aVctCGlNKCVJcVw+L25B7RY5lqef68vw4WJEly52DuASlVyGdTcuNgKksv3aqaXF1Js
	5u9jmZ9HKlGNVGwScexUNvupJo3CFVLn14+BbL0M0PdkiG0v/bfyOFZ2b9OWFNi/YcmCUJL
	AP3JRw6J87IaTLsWbJNSgxlTjxuoMeDbteCSjL4MYKaxfGgJcY2DRr8EhV2hOcYUtVmKn/D
	pGzDTbMvO6QwjVx+HwFkpPMjH0Q9i3KeIJtltuYeVISv+3I/JtITynfDDeG0k7NW5sCSXOP
	VddtQYIsN6waMM20Xw0KDRtF7k/waddLcMtScihoLksYQipgKLEGDV3fa5blqeIJ4shPa7E
	XHPmwAV9yC2CVeejpdU5jqf7bkDYhihhrsFVZYcNkXbSzH57nL7JJa65kWjwlZHWqWZB3zU
	cVqwkD1/pZ233ZXJzbeq+NzL8ZrW8GJDolV0iyqKhvsrg+wpcpsTAzttQafnqYFuct/FWmx
	j25PWsgt7Bol9nK4Lv6Oz71UvAUfRUtvSEwax1X7OIMxdz4IHmAj7U72Bo5ZrVZ7FpXJzvK
	9Ob1Kmt57a/V7+FGrs0EQSaLTTYh6deXtI51fZoig9jKdXW4i3IMCjuNv7sVyBP2X90ErVa
	oBoVKBLR4g99VUBzFN9Ewae3qMd92j34Hm4yBuX9ouoBZY4+VzhnrbynAT1B6nMUrhmCqkW
	M2c3hZaAWlvHgcKtrN
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

On Tue, Dec 23, 2025 5:37 PM, Bartosz Golaszewski wrote:
> On Tue, Dec 23, 2025 at 9:44=E2=80=AFAM Jiawen Wu =
<jiawenwu@trustnetic.com> wrote:
> >
> > On Tue, Dec 23, 2025 4:09 PM, Bartosz Golaszewski wrote:
> > > On Tue, Dec 23, 2025 at 8:39=E2=80=AFAM Jiawen Wu =
<jiawenwu@trustnetic.com> wrote:
> > > >
> > > > >
> > > > >  #define SOFTWARE_NODE_REFERENCE(_ref_, ...)                  =
\
> > > > >  (const struct software_node_ref_args) {                       =
       \
> > > > > -     .node =3D _ref_,                                         =
 \
> > > > > +     .swnode =3D _Generic(_ref_,                              =
 \
> > > > > +                        const struct software_node *: _ref_, =
\
> > > > > +                        default: NULL),                      =
\
> > > > > +     .fwnode =3D _Generic(_ref_,                              =
 \
> > > > > +                        struct fwnode_handle *: _ref_,       =
\
> > > > > +                        default: NULL),                      =
\
> > > > >       .nargs =3D COUNT_ARGS(__VA_ARGS__),                      =
 \
> > > > >       .args =3D { __VA_ARGS__ },                               =
 \
> > > > >  }
> > > >
> > > > This change seems incompatible with my driver txgbe, since the =
software nodes
> > > > are registered in " struct software_node * " but not " const =
struct software_node * ".
> > > >
> > > > So when I pulled the net-next-6.19-rc1 that merged this patch, =
to probe my driver.
> > > > The error logs shows:
> > > >
> > > > [    5.243396] txgbe 0000:10:00.0 (unnamed net_device) =
(uninitialized): unable to attach SFP bus: -EINVAL
> > > > [    5.243399] txgbe 0000:10:00.0: failed to init phylink
> > > > [    5.576008] txgbe 0000:10:00.0: probe with driver txgbe =
failed with error -22
> > > > [    6.109548] txgbe 0000:10:00.1 (unnamed net_device) =
(uninitialized): unable to attach SFP bus: -EINVAL
> > > > [    6.109551] txgbe 0000:10:00.1: failed to init phylink
> > > > [    6.442044] txgbe 0000:10:00.1: probe with driver txgbe =
failed with error -22
> > > >
> > >
> > > This shouldn't have changed anything for existing software nodes - =
the
> > > pointer in struct software_node_ref_args has always been const. =
This
> > > would have failed at build-time if this was an issue. Have you
> > > bisected it to this very commit? What line is the -EINVAL assigned =
and
> > > for what reason?
> >
> > The -EINVAL is assigned software_node_get_reference_args():
> >
> >         if (ref->swnode)
> >                 refnode =3D software_node_fwnode(ref->swnode);
> >         else if (ref->fwnode)
> >                 refnode =3D ref->fwnode;
> >         else
> >                 return -EINVAL;
> >
> > I think the reason is that _Generic selection is restrictive, it =
only accept
> > exactly const struct software_node for software node references. So =
the
> > macro SOFTWARE_NODE_REFERENCE fall back to the default to set =
.swnode =3D  NULL.
> >
> > And I temporarily added this line to fix it:
> >
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index 272bfbdea7bf..e30ef23a9af3 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -371,6 +371,7 @@ struct software_node_ref_args {
> >  (const struct software_node_ref_args) {                             =
   \
> >         .swnode =3D _Generic(_ref_,                               \
> >                            const struct software_node *: _ref_, \
> > +                          struct software_node *: _ref_,       \
> >                            default: NULL),                      \
> >         .fwnode =3D _Generic(_ref_,                               \
> >                            struct fwnode_handle *: _ref_,       \
> >
>=20
> Ah I see, we'd assign struct software_node * to const struct
> software_node * and it used to work but with _Generic() we need the
> exact type. I agree with this approach, do you want to send a proper
> patch?

It might be more appropriate for you to send the patch, and could also
check if there are any other missed details, like for fwnode...
I'm not very proficient in this field. :)



