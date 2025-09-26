Return-Path: <linux-spi+bounces-10302-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70926BA3B43
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 14:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A011F7BA9A7
	for <lists+linux-spi@lfdr.de>; Fri, 26 Sep 2025 12:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887D72F5A37;
	Fri, 26 Sep 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBSfqMxl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C022F5A20
	for <linux-spi@vger.kernel.org>; Fri, 26 Sep 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891149; cv=none; b=VloikaOShsniAh2O9KDow8O1CNk5sHhqMPkf2j+6BR3oxVEiaXQzY4JIO2u0F6BbgAOQmWDTiBciXhXhwm4K6KoXVqw+TvIEUnQnJK4H64DK0RchGzav/DaKLHEcz5xoYkm48qZKMljtwahFo7h0td1seCfksQkMndfO7KhlVfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891149; c=relaxed/simple;
	bh=bgmghckL4Ny0c8O8U8NCksUJHOretkGWrQoDWo8CmCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOGrc4H1U4mJB984SjEI559sHuUWA2LTqiWJQWuwMEOKV1g/OMLMIZpwprbYJgXDsAc+JRlYhI0RYPXDtbiS3pqWNeePjPzDjZ5kU0/mWvSZY6/Xlv2Xq9SS7CXB7/Gy6vmHelAc4edOPodfkLYACvwikpAb6y9WXJT7mCQ79rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBSfqMxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056E7C19421
	for <linux-spi@vger.kernel.org>; Fri, 26 Sep 2025 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758891149;
	bh=bgmghckL4Ny0c8O8U8NCksUJHOretkGWrQoDWo8CmCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NBSfqMxlqp0pSo5pRQWnbaLm910aDdvjl4H9jyOksmG9DqM1boAdmLu4uvK5/3joo
	 A72K+YbLICgf/Z0MFLw3CqZ+MEap9smN1X9ZATw88CdfLDSAzr2qLM377UjCK9gXbW
	 W/YEMzwg498V8XGmn8sA4uCUsO7FEKkk06hTqyOrf8+qGrPMiX6MlAjI6R7RplfZ3S
	 NW4r4NaaTR1ipwPbZU0Ax9+AwPnA1qlFgN3iKviJN502VJvmxhRqYsN203JZwfmUZJ
	 1cs86+x8oXT7+3lAUiOcAACVfVr6Z7P+hcbBtUbyucBHO5mQIklzIqigjc0wpDf6xb
	 ifr7NUZtfzVig==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-353f965c048so1754509fac.2
        for <linux-spi@vger.kernel.org>; Fri, 26 Sep 2025 05:52:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX82ABfOw1kPVOOs3QzBzre9+WC6yMjpX/6WXu/Ba9D5BMffvmgl1VC+Ha9zLLhBV3KufHQeNeb+jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPTEAJK/8FeYX9snwRKSVPgiLIxSzKS7GYNp247YIYlaeIft1Q
	05Emytxz53bI1qdl/XteHIdvxFXvwqbFLo7XePa2eIgQmx4R4Se6oz+xl/j+WWvi9JbVggRPS/g
	ArPq4QDilyn569XJdWf+4u/QQSw6dPdI=
X-Google-Smtp-Source: AGHT+IFyJsbtEL/QZxEFMzNMFhjejHmQrKAGHJ2m+Cy67pO650FZ5XV0FAPVcpNkLn5AmmxpCHNcXhCPX9zROUcktt4=
X-Received: by 2002:a05:6871:79a3:b0:35c:cfec:df79 with SMTP id
 586e51a60fabf-36c4698a0f9mr1307306fac.51.1758891148064; Fri, 26 Sep 2025
 05:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0hSy9zQd6cP9B4QPSZi-6ughmkW=VoEBV-0MbUr2xcaAQ@mail.gmail.com> <aNZ9fbh8eLiPAJzR@kekkonen.localdomain>
In-Reply-To: <aNZ9fbh8eLiPAJzR@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Sep 2025 14:52:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gQ9vnT+Z8zryEausp-2xX7HocoBgwmiptxg7BGiU9C8g@mail.gmail.com>
X-Gm-Features: AS18NWDCqPA72v4-2y8V5lEmAid_UEthjaXRBCWFUzQ_Nsh-1l_6LWsoqBtdmRQ
Message-ID: <CAJZ5v0gQ9vnT+Z8zryEausp-2xX7HocoBgwmiptxg7BGiU9C8g@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Align availability checks on fwnode child node enumeration
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
	netdev@vger.kernel.org, linux-spi@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Javier Carrasco <javier.carrasco@wolfvision.net>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Matthias Fend <matthias.fend@emfend.at>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Paul Elder <paul.elder@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Fri, Sep 26, 2025 at 1:48=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Sep 24, 2025 at 12:52:12PM +0200, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Wed, Sep 24, 2025 at 9:46=E2=80=AFAM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hello everyone,
> > >
> > > Historically the fwnode property API has enumerated only available de=
vice
> > > nodes on OF whereas on ACPI, also nodes that haven't been present in =
the
> > > system have been provided. Both OF and ACPI have similar concepts of =
node
> > > availbility, on OF it's the "status" property present on device nodes=
 and
> > > on ACPI the _STA object evaluates to device present, enabled and
> > > functional bits, of which the present and functional bits are current=
ly
> > > being used to determine whether to enumerate a device.
> > >
> > > Two additional functions, fwnode_get_next_available_child_node() and
> > > fwnode_for_each_available_child_node(), have been provided to enumera=
te
> > > the available nodes only on ACPI, whereas on OF the implementation ha=
s
> > > been the same on the non-available variants. The motivation for provi=
ding
> > > these has very likely been to provide fwnode variants of the similarl=
y
> > > named functions but the difference isn't justifiable from API consist=
ency
> > > viewpoint.
> > >
> > > This set switches the users away from the "available" fwnode API func=
tions
> > > and later on removes them, aligning the functionality on all fwnode
> > > backends.
> > >
> > > since v1:
> > >
> > > - Move patch "ACPI: property: Make acpi_get_next_subnode() static" as
> > >   first.
> > >
> > > - Add missing parentheses and kernel-doc Return: section in
> > >   acpi_get_next_present_subnode() documentation and move the Return
> > >   section: of fwnode_graph_get_endpoint_by_id() to the end of the
> > >   documentation section (new patch for the latter).
> > >
> > > - Use device_get_next_child_node() instead of fwnode_get_next_child_n=
ode()
> > >   in flash LED driver drivers.
> > >
> > > - Rework iterating port nodes in acpi_graph_get_next_endpoint() as
> > >   suggested by Andy (new patch).
> >
> > I think that you really have four series here, or rather two series, a
> > collection of patches depending on them, and a follow-up cleanup.
> >
> > > Sakari Ailus (16):
> > >   ACPI: property: Make acpi_get_next_subnode() static
> > >   ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint(=
)
> > >     only
> > >   ACPI: property: Rework acpi_graph_get_next_endpoint()
> > >   ACPI: property: Return present device nodes only on fwnode interfac=
e
> >
> > So the above is one series, focused on ACPI property changes.
> >
> > They can go in via ACPI as soon as everyone is happy with them.  I
> > think I can push them for 6.18 if that helps to process the other
> > patches.
>
> If it's an option, that would be nice. But see below.
>
> >
> > >   property: Move Return: section of fwnode_graph_get_endpoint_by_id()
> > >     down
> > >   property: Drop DEVICE_DISABLED flag in
> > >     fwnode_graph_get_endpoint_by_id()
> > >   property: Drop DEVICE_DISABLED flag in
> > >     fwnode_graph_get_endpoint_count()
> >
> > The above patches are another series that doesn't depend on the first
> > one AFAICS and can go in via driver core.
>
> Agreed.
>
> >
> > >   property: Document that fwnode API returns available nodes
> > >   driver core: Use fwnode_for_each_child_node() instead
> > >   net: lan966x: Use fwnode_for_each_child_node() instead
> > >   Input: touch-overlay - Use fwnode_for_each_child_node() instead
> > >   media: thp7312: Use fwnode_for_each_child_node() instead
> > >   leds: Use fwnode_for_each_child_node() instead
> > >   leds: Use fwnode_get_next_child_node() instead
> >
> > The above can go in via respective subsystem trees when the ACPI
> > property series gets in (I'm not sure if/how they depend on the second
> > series).
> >
> > And the following one is a follow-up cleanup getting rid of code that
> > would be redundant going forward.
> >
> > >   property: Drop functions operating on "available" child nodes
> > >   spi: cadence: Remove explicit device node availability check
> >
> > Does the spi change depend on the previous patch?
>
> There's really only one dependency, apart from the direct dependency of
> fwnode_get_next_available_child_node() /
> fwnode_for_each_available_child_node() definitions removed in the second
> last patch: fwnode_get_next_child_node() and fwnode_for_each_child_node()
> may still return non-available nodes before the last of the ACPI patches =
in
> the set. So if the ACPI patches aren't merged but the rest are,
> non-available nodes could be returned.
>
> How about:
>
> 1. Merge the ACPI patches to 6.18.
>
> 2. Merge the rest, apart from the second last patch, for 6.19.
>
> 3. Once everything else is in, merge the last patch. Could wait for 6.20.

Sounds good.

> Perhaps I should split the series in three sets?

That would help I think.

> I'll send an update on the ACPI patches soon, to address a comment relate=
d
> to them.

OK

Thanks!

