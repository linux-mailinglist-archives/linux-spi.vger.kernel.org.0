Return-Path: <linux-spi+bounces-12082-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5F5CD87AD
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 09:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80949303DD1B
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 08:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0878B320CA7;
	Tue, 23 Dec 2025 08:44:47 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751E2F1FFE;
	Tue, 23 Dec 2025 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479486; cv=none; b=JHwFh3xDdsuDmtPxCOnSHmyF4apTzutY5/egFZ4F5YPRHJOY0MffSGaBrfwax6IaHLZBel/wj1BmZWW2CxAUC8k9VW//xd6K8ELHNCO/4orNJtPZwoukVCyQg1iHMWFIevnRL6/iR64DquJ+iG7krTCHgDKnI80aO5MFbUhQTjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479486; c=relaxed/simple;
	bh=oFi2nxnCewGPylNCvxQMquEVKuQMCWP9UyrGraUnpL8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ULzPnTGRL02jTuVV53BBKQbdAb8olgA4w9zLqmFy+KRchTuax/MrvLZOvkKXmGxMhX0agEZtcWQctuCu0F8mbcdJQW5roX+u8MrwaRGzAo2mKg+9jVnVwyvqq86p55w86A8sLjnV1OeaCdh7HWjVKKbqItFIPJ0AusrBptlY0YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1766479465t119t59354
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.96.96])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 17626968613264636015
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
	<sakari.ailus@linux.intel.com>,
	"'Bartosz Golaszewski'" <bartosz.golaszewski@linaro.org>,
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
References: <02fd01dc73df$3b641bf0$b22c53d0$@trustnetic.com> <CAMRc=Mf2A++CHYcMdBi0bQ0DOAGLaSatQEOmu=aAEG_YjCqEWg@mail.gmail.com>
In-Reply-To: <CAMRc=Mf2A++CHYcMdBi0bQ0DOAGLaSatQEOmu=aAEG_YjCqEWg@mail.gmail.com>
Subject: RE: [PATCH v7 3/9] software node: allow referencing firmware nodes
Date: Tue, 23 Dec 2025 16:44:24 +0800
Message-ID: <030001dc73e8$56e38330$04aa8990$@trustnetic.com>
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
Thread-Index: AQIzaRfJPMiwz9071uYI3gJ0t6u2qwFWX8iGtHZH4jA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MvW0gkkpO9JeFtVjdVa1+SpOwqq900ECLu3BLYhs38W31bdJcfaViU6r
	l56zs+kzvafi9X2VCFlL422JvWRTESXOe0s/XRg56m0LZSDwcTf7AZaZOYxx9qd2F1sg1x3
	1Uc/rgR7Si/rRI9nZ1kG3XX0coZCVUUkTfQQUgSYVgNhtehQatQzdJSd7UDz73YDjyNGkBO
	AWFWoWT4J5aUGbvNH6J96jn2VZxqP0Zm5Gt69QPf/4qwASQlPMDnupR+5ygxOmf7ZuKy9RR
	lQvl8fZKLC9Xk2i0ZGFOP1Cx5tQ9nh+eGYp/bKsYrLZMYq6lFop/4Ssk15HEDxulemqCs4/
	1N7hNgFd66EQS/CAgbydG0MImpnWg01ra7ooEus5+VTweBq+3erCGl9Hm1KXYHb1YOVu1qv
	jj2t3KbBfmuN6hlayzZyK4IP5g2iRlzy5XDyh5pNk1fzmUiJZpsX9N6W/EKOZMre+hDmtKe
	OErR63+iX99F3thIpbaChHV6Ydc4ELzJaLKmAH8TA+J0CbcDZmaXc1ZN6BsMSJtF3pjaIg6
	Xh9y9fmvS2EosGEMGbMzIpaWujEQ2u0HULB3CMAyCbA5umNwaE0EoXd76IdJ6KRomgvweCK
	3yfzC4ZiPFujFisFHmc5xAvs5PSrBdhna/NKe54kwPmukVIMfU3IVfhJnc8dWDDtJY5aolr
	+66C3Hi4zt2/X0KaK2Jd1zJ5w/0Hr/cEDIvIZw+upgUKt6+sBny5MlLJTix9LpFpOk3Zd+f
	AYuBTfv/gte9zRN/azmy+h/G0NJxGSVWV6h1Fi7ojq4gYrDj0F3+t2OIIuIKtntq7Zr1HcY
	ZluLtKZnxnl97S9RHLXtqednBiMoR5+8QJ2xuUIWo0g8pEgJDUag+lMteEnY4eP8ddqe6s+
	MG09HLmhNoWXb9e8fgUdtw5cZboYnsENHKHtxbYu6obEm7aY9z1fFA/sIYBR4nzPmAKCkj2
	5E33UliLnnqVlbazooskmwZWbC/w6rbA14M7ZGpQc1uSrTEtze5hunSw/f5yaQy+vmPmdo4
	doeMpBJwUJVPlqw1Lo
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On Tue, Dec 23, 2025 4:09 PM, Bartosz Golaszewski wrote:
> On Tue, Dec 23, 2025 at 8:39=E2=80=AFAM Jiawen Wu =
<jiawenwu@trustnetic.com> wrote:
> >
> > >
> > >  #define SOFTWARE_NODE_REFERENCE(_ref_, ...)                  \
> > >  (const struct software_node_ref_args) {                           =
   \
> > > -     .node =3D _ref_,                                          \
> > > +     .swnode =3D _Generic(_ref_,                               \
> > > +                        const struct software_node *: _ref_, \
> > > +                        default: NULL),                      \
> > > +     .fwnode =3D _Generic(_ref_,                               \
> > > +                        struct fwnode_handle *: _ref_,       \
> > > +                        default: NULL),                      \
> > >       .nargs =3D COUNT_ARGS(__VA_ARGS__),                       \
> > >       .args =3D { __VA_ARGS__ },                                \
> > >  }
> >
> > This change seems incompatible with my driver txgbe, since the =
software nodes
> > are registered in " struct software_node * " but not " const struct =
software_node * ".
> >
> > So when I pulled the net-next-6.19-rc1 that merged this patch, to =
probe my driver.
> > The error logs shows:
> >
> > [    5.243396] txgbe 0000:10:00.0 (unnamed net_device) =
(uninitialized): unable to attach SFP bus: -EINVAL
> > [    5.243399] txgbe 0000:10:00.0: failed to init phylink
> > [    5.576008] txgbe 0000:10:00.0: probe with driver txgbe failed =
with error -22
> > [    6.109548] txgbe 0000:10:00.1 (unnamed net_device) =
(uninitialized): unable to attach SFP bus: -EINVAL
> > [    6.109551] txgbe 0000:10:00.1: failed to init phylink
> > [    6.442044] txgbe 0000:10:00.1: probe with driver txgbe failed =
with error -22
> >
>=20
> This shouldn't have changed anything for existing software nodes - the
> pointer in struct software_node_ref_args has always been const. This
> would have failed at build-time if this was an issue. Have you
> bisected it to this very commit? What line is the -EINVAL assigned and
> for what reason?

The -EINVAL is assigned software_node_get_reference_args():

	if (ref->swnode)
		refnode =3D software_node_fwnode(ref->swnode);
	else if (ref->fwnode)
		refnode =3D ref->fwnode;
	else
		return -EINVAL;

I think the reason is that _Generic selection is restrictive, it only =
accept
exactly const struct software_node for software node references. So the
macro SOFTWARE_NODE_REFERENCE fall back to the default to set .swnode =
=3D  NULL.

And I temporarily added this line to fix it:

diff --git a/include/linux/property.h b/include/linux/property.h
index 272bfbdea7bf..e30ef23a9af3 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -371,6 +371,7 @@ struct software_node_ref_args {
 (const struct software_node_ref_args) {                                =
\
        .swnode =3D _Generic(_ref_,                               \
                           const struct software_node *: _ref_, \
+                          struct software_node *: _ref_,       \
                           default: NULL),                      \
        .fwnode =3D _Generic(_ref_,                               \
                           struct fwnode_handle *: _ref_,       \


