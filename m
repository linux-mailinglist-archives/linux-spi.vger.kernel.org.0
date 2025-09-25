Return-Path: <linux-spi+bounces-10287-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E92B9EC5C
	for <lists+linux-spi@lfdr.de>; Thu, 25 Sep 2025 12:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99FF017D5A0
	for <lists+linux-spi@lfdr.de>; Thu, 25 Sep 2025 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F158D2F0C7F;
	Thu, 25 Sep 2025 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vmfLlyw5"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7577C2EA159;
	Thu, 25 Sep 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796820; cv=none; b=idgO0Undvv+zMLET5rnulQKSJADp2rzxVQ1LGRH7PJksL8EYd9xn2rnQ96yjLT2lO9qj1EgfMhs/da0BBrzv7z+qGHN43poKuCc7baumAscVJA2hGEsYnzaIRT3dNjTwugRed4BCyJb8JxaQGSH/u4fhquRwyfHpxcfnhoK0zSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796820; c=relaxed/simple;
	bh=GJlcEOVBYWhi8mcXRsDpHS6MLH4rtPMp1tm5JWxnzNw=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=k/Bw3/+pK+xBco6NELltZj/L/mDTA1QuZMwLaeLFB7hl0S8h3mtFLy/8gF1/3oapQwjw9Tw3oC89iilJMUJZ/pf7RKkjeSmbwnmBJbS8Ccbrz8CV2AGbJMw+U/BV+QdftL39tyQZ2pagowcUud+fxKJtiAOh1An2shP5A8v0WJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=fail (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vmfLlyw5 reason="signature verification failed"; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from neptunite.rasen.tech (unknown [IPv6:2404:7a81:160:2100:d0b0:c301:99de:3de])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 5F02C1129;
	Thu, 25 Sep 2025 12:38:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758796731;
	bh=GJlcEOVBYWhi8mcXRsDpHS6MLH4rtPMp1tm5JWxnzNw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=vmfLlyw5cfAlTmCTTXK3oU9TUODg60prrMWKYKUO6GcZfa/fxr/PoT4aIda4cAhdt
	 SSGDrPEmSPhJsS3S7+t84IG3Bs9O2u/YNcGO7ZzV3UB83Lr6M5MshP5LUaiNv6Uw9M
	 6WcdWXNyafca7QOlxdo2tsiX3+XX0kaXA8PTz1WA=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250924074602.266292-13-sakari.ailus@linux.intel.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com> <20250924074602.266292-13-sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 12/16] media: thp7312: Use fwnode_for_each_child_node() instead
From: Paul Elder <paul.elder@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-spi@vger.kernel.org, Rafael J. Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Javier Carrasco <javier.carrasco@wolfvision.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Matthias Fend <matthias.fend@emfend.at>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dum
 azet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org
Date: Thu, 25 Sep 2025 19:40:08 +0900
Message-ID: <175879680823.2756121.480253963605736427@neptunite.rasen.tech>
User-Agent: alot/0.0.0

Quoting Sakari Ailus (2025-09-24 16:45:58)
> fwnode_for_each_child_node() is now the same as
> fwnode_for_each_available_child_node() on all backends (OF, ACPI and
> swnode). In order to remove the available variants, switch the uses to
> non-available variants.
>=20
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>

> ---
>  drivers/media/i2c/thp7312.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/i2c/thp7312.c b/drivers/media/i2c/thp7312.c
> index 775cfba188d8..86208a47f472 100644
> --- a/drivers/media/i2c/thp7312.c
> +++ b/drivers/media/i2c/thp7312.c
> @@ -2064,7 +2064,7 @@ static int thp7312_parse_dt(struct thp7312_device *=
thp7312)
>                 return -EINVAL;
>         }
> =20
> -       fwnode_for_each_available_child_node(sensors, node) {
> +       fwnode_for_each_child_node(sensors, node) {
>                 if (fwnode_name_eq(node, "sensor")) {
>                         if (!thp7312_sensor_parse_dt(thp7312, node))
>                                 num_sensors++;
> --=20
> 2.47.3
>

