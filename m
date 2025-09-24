Return-Path: <linux-spi+bounces-10277-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3786EB99535
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 12:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDC24A4537
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 10:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A115A2DCF57;
	Wed, 24 Sep 2025 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XMBqoyBL"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4A2DC769;
	Wed, 24 Sep 2025 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708195; cv=none; b=PuT6D8ssS/sE4dr5KL7tuOZWu4EOKYw7KZliazJ0G3+dGoxjCE0IHfXlFUVT6gZeFlA/OjA+URs2XrYj3MoQo/3sxTyYmYaJ/3unbyBjaPGoXztcHHjzuPh7JdgKRqS57UQLetfQ7NZJekX+Obc2pfno0b66Q00yVMZMwUkUsZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708195; c=relaxed/simple;
	bh=PC0QeFeZ1/kXvV/VmT13PDv/bGt12X0Y7+kL+zFv/8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bT/L1B0eg2WA7nt6+oefEbvS2lubVMe8clPc2FCrxYYyPXrgWTDl3LGx0jAVOPmS7oo9WtzWp2ksH/kdtfFY+ZQ3WDK+6mS3uDHzqH7lh/dhzsQMI3clFTwghnt3waHuMcmSauaWI/nGQCp/MXlNNsDXgVZawUbbJTxNxPcufsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XMBqoyBL; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4B7671E35;
	Wed, 24 Sep 2025 12:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758708107;
	bh=PC0QeFeZ1/kXvV/VmT13PDv/bGt12X0Y7+kL+zFv/8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMBqoyBLCFx++lhVNeVXvuCMptNRpdZUngToAgep9FuI/q9PzAyp9hkAhrrU7I1IX
	 Oy1VDzUkcq90nZ0aVKAjzE8Vtjuf9AN5i97Btn01DGB0VpcVs2tB0VoOPw2RkGEoSi
	 4kT88umUDfqC0KlEa0BMy3zHr0UtW4UGt33gWX1A=
Date: Wed, 24 Sep 2025 13:02:38 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
	linux-spi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Matthias Fend <matthias.fend@emfend.at>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 12/16] media: thp7312: Use
 fwnode_for_each_child_node() instead
Message-ID: <20250924100238.GJ28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-13-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-13-sakari.ailus@linux.intel.com>

On Wed, Sep 24, 2025 at 10:45:58AM +0300, Sakari Ailus wrote:
> fwnode_for_each_child_node() is now the same as
> fwnode_for_each_available_child_node() on all backends (OF, ACPI and
> swnode). In order to remove the available variants, switch the uses to
> non-available variants.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/media/i2c/thp7312.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/thp7312.c b/drivers/media/i2c/thp7312.c
> index 775cfba188d8..86208a47f472 100644
> --- a/drivers/media/i2c/thp7312.c
> +++ b/drivers/media/i2c/thp7312.c
> @@ -2064,7 +2064,7 @@ static int thp7312_parse_dt(struct thp7312_device *thp7312)
>  		return -EINVAL;
>  	}
>  
> -	fwnode_for_each_available_child_node(sensors, node) {
> +	fwnode_for_each_child_node(sensors, node) {
>  		if (fwnode_name_eq(node, "sensor")) {
>  			if (!thp7312_sensor_parse_dt(thp7312, node))
>  				num_sensors++;

-- 
Regards,

Laurent Pinchart

