Return-Path: <linux-spi+bounces-10283-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF35B997ED
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 12:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E4B326DF1
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B822E1F1C;
	Wed, 24 Sep 2025 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG8VUQLE"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290C2E1F01
	for <linux-spi@vger.kernel.org>; Wed, 24 Sep 2025 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758711146; cv=none; b=ogw/NUyQhRqFLEnG7QiR22K8K6Qqmw9mRhYTdwtYw8x7YgUDsd9fgWgHkt5IoNIxsH8R2hbXbYA+3tqfNJXdU8KDfIcApNwDAfzpUliDt7qDYGgCYogPIv3XmQ9dsL/F0UEJ8sDFu1r1WmnbFAMW+8oGq/hVKrAuDjhvH93R6aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758711146; c=relaxed/simple;
	bh=xCDPc5y7d7WCp3lQou1gJLzgPsjIpA8s9dbP+kcvNIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eP2PwyZXXr5GbBr1Gdle0p+DC6amqz80bhsZHrN2l8w7D1kqPHHuvwW23o8/4RV8nAO7mk73hCd/GvJlJOtLvuuSjp/fzAX1rKzt0rl6aYLQu0hPI/Ht3LZRjxMB5TfwcJZjSmimkWvrUcU+8wXJBFsefDmI5mHgDUwq4Cv/gow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dG8VUQLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9D1C4AF09
	for <linux-spi@vger.kernel.org>; Wed, 24 Sep 2025 10:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758711146;
	bh=xCDPc5y7d7WCp3lQou1gJLzgPsjIpA8s9dbP+kcvNIg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dG8VUQLEQO6rumXUWPyuJMbAWM35Bj7FP4hq3VC6xyhrgmfldUcvL3iGQJbeF6q7l
	 9xFhsmEJ3RUeZyCOnMIofh4uneMMaAIRZjh9gO30VdH73LsYfmVCYujLqm/C0p7t5G
	 NjSWwgRC/7BEliaM1n5JKfEPzDHaHwpMIYpz6Jy5AaIUyWb3f5540+I1OjGVpi0+eF
	 LntdgaY81sDWTrir4C5kEe6qPIHYy33EzYCtlGC0sBTtVqOENfYREQpK1CTRHcgbhj
	 4obidwdHgVuT1qQqDyHPWG2VHg4F6yALwIKdb2ay4gGBkpmVTSISzAV5d5s9SwOF9E
	 LxKMTw1mtDcPA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-35c80c1dc3fso65805fac.3
        for <linux-spi@vger.kernel.org>; Wed, 24 Sep 2025 03:52:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW2Vh0WZLqVt7PnyA+lXOSPw7altBfezYsUvGsRlTVYTaSavfA2TTTzX+PUUnzKH5++KiOnZIrJq3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNpaEkO2oWH/RqH9O5vKr7e+FQui6ABnWRT2MM4DTnwUJ2Ul85
	/mw1SSwlUSTCZKaUHrK7k26/4TNvTbxkgePlmiAoXfXKCwyHmH/2k4XCOuI4+DJIl90uJGAVUnq
	vvax4/0ZFjRQ5fVeXuC+L66fbcROx1hM=
X-Google-Smtp-Source: AGHT+IGEgSAb7PwthMT480H5j0SYdHpLlRhlrtZ+iuewQGA9Jkcl/bfStgYc/Gc6s4+VwKbrFzCE17TX9oVZJW6wMhs=
X-Received: by 2002:a05:6871:758a:b0:314:b6a6:6894 with SMTP id
 586e51a60fabf-34c835413d5mr3060169fac.40.1758711145254; Wed, 24 Sep 2025
 03:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Sep 2025 12:52:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hSy9zQd6cP9B4QPSZi-6ughmkW=VoEBV-0MbUr2xcaAQ@mail.gmail.com>
X-Gm-Features: AS18NWB0nF3M_Qh13bpf9jNMtOHP6GaQKliTE12EO3NKN8SlzbsSaUYuu04ZXT8
Message-ID: <CAJZ5v0hSy9zQd6cP9B4QPSZi-6ughmkW=VoEBV-0MbUr2xcaAQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] Align availability checks on fwnode child node enumeration
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, netdev@vger.kernel.org, 
	linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
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

On Wed, Sep 24, 2025 at 9:46=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hello everyone,
>
> Historically the fwnode property API has enumerated only available device
> nodes on OF whereas on ACPI, also nodes that haven't been present in the
> system have been provided. Both OF and ACPI have similar concepts of node
> availbility, on OF it's the "status" property present on device nodes and
> on ACPI the _STA object evaluates to device present, enabled and
> functional bits, of which the present and functional bits are currently
> being used to determine whether to enumerate a device.
>
> Two additional functions, fwnode_get_next_available_child_node() and
> fwnode_for_each_available_child_node(), have been provided to enumerate
> the available nodes only on ACPI, whereas on OF the implementation has
> been the same on the non-available variants. The motivation for providing
> these has very likely been to provide fwnode variants of the similarly
> named functions but the difference isn't justifiable from API consistency
> viewpoint.
>
> This set switches the users away from the "available" fwnode API function=
s
> and later on removes them, aligning the functionality on all fwnode
> backends.
>
> since v1:
>
> - Move patch "ACPI: property: Make acpi_get_next_subnode() static" as
>   first.
>
> - Add missing parentheses and kernel-doc Return: section in
>   acpi_get_next_present_subnode() documentation and move the Return
>   section: of fwnode_graph_get_endpoint_by_id() to the end of the
>   documentation section (new patch for the latter).
>
> - Use device_get_next_child_node() instead of fwnode_get_next_child_node(=
)
>   in flash LED driver drivers.
>
> - Rework iterating port nodes in acpi_graph_get_next_endpoint() as
>   suggested by Andy (new patch).

I think that you really have four series here, or rather two series, a
collection of patches depending on them, and a follow-up cleanup.

> Sakari Ailus (16):
>   ACPI: property: Make acpi_get_next_subnode() static
>   ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint()
>     only
>   ACPI: property: Rework acpi_graph_get_next_endpoint()
>   ACPI: property: Return present device nodes only on fwnode interface

So the above is one series, focused on ACPI property changes.

They can go in via ACPI as soon as everyone is happy with them.  I
think I can push them for 6.18 if that helps to process the other
patches.

>   property: Move Return: section of fwnode_graph_get_endpoint_by_id()
>     down
>   property: Drop DEVICE_DISABLED flag in
>     fwnode_graph_get_endpoint_by_id()
>   property: Drop DEVICE_DISABLED flag in
>     fwnode_graph_get_endpoint_count()

The above patches are another series that doesn't depend on the first
one AFAICS and can go in via driver core.

>   property: Document that fwnode API returns available nodes
>   driver core: Use fwnode_for_each_child_node() instead
>   net: lan966x: Use fwnode_for_each_child_node() instead
>   Input: touch-overlay - Use fwnode_for_each_child_node() instead
>   media: thp7312: Use fwnode_for_each_child_node() instead
>   leds: Use fwnode_for_each_child_node() instead
>   leds: Use fwnode_get_next_child_node() instead

The above can go in via respective subsystem trees when the ACPI
property series gets in (I'm not sure if/how they depend on the second
series).

And the following one is a follow-up cleanup getting rid of code that
would be redundant going forward.

>   property: Drop functions operating on "available" child nodes
>   spi: cadence: Remove explicit device node availability check

Does the spi change depend on the previous patch?

