Return-Path: <linux-spi+bounces-10345-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CE5BA8BDF
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 11:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E41D1781F3
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53502E5B12;
	Mon, 29 Sep 2025 09:49:46 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A12E1722;
	Mon, 29 Sep 2025 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139386; cv=none; b=uVY45r9nfX3MzhGaQYBrxHTTRmDx4t2R0Rx/5vX4ea8lIlwJPbwZ5CPJ2vYA36ds7TD3i9CAX0bX20Nw9H7lJCf+TmQwRyk7rMQFKdcR+EOZvIQE/kCot+SERHjVonPhhg5RCAPjVARFsBwLRLzalOUyWX+KycWN1+TbZO/JPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139386; c=relaxed/simple;
	bh=a+fsgRg7/1J8kAf6GlWdv/0Gunn02X88JgGpxFD1uQA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K14d6MIfDBFhp9sd7gScLYu68hiPCfX1gcJOPdK1p7QZnaerDj6YFXKZpLBq49JPokrbtXB4gbruG4yaJ6BBmS5E001+lK+AIe28xqqhxG0eC5YSPVpvOP6wHCSIVdpoYW3TPFsQRH2eb9Mw5aJSs0jDG0LmXMUu1tcYG+0fK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cZxCw2hTXz6M4Vm;
	Mon, 29 Sep 2025 17:46:36 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 870AD1402F4;
	Mon, 29 Sep 2025 17:49:41 +0800 (CST)
Received: from localhost (10.47.64.220) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Sep
 2025 10:49:39 +0100
Date: Mon, 29 Sep 2025 10:49:38 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <linux-leds@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Javier Carrasco
	<javier.carrasco@wolfvision.net>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek
	<pavel@kernel.org>, Matthias Fend <matthias.fend@emfend.at>, Chanwoo Choi
	<cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Laurent
 Pinchart" <laurent.pinchart@ideasonboard.com>, Paul Elder
	<paul.elder@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mark Brown
	<broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@kernel.org>
Subject: Re: [PATCH v2 11/16] Input: touch-overlay - Use
 fwnode_for_each_child_node() instead
Message-ID: <20250929104938.000000b7@huawei.com>
In-Reply-To: <20250924074602.266292-12-sakari.ailus@linux.intel.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
	<20250924074602.266292-12-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 24 Sep 2025 10:45:57 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> fwnode_for_each_child_node() is now the same as
> fwnode_for_each_available_child_node() on all backends (OF, ACPI and
> swnode). In order to remove the available variants, switch the uses to
> non-available variants.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Another mechanical change.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/input/touch-overlay.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touch-overlay.c b/drivers/input/touch-overlay.c
> index b9fd82c4829d..7eaaaef1bd82 100644
> --- a/drivers/input/touch-overlay.c
> +++ b/drivers/input/touch-overlay.c
> @@ -82,7 +82,7 @@ int touch_overlay_map(struct list_head *list, struct input_dev *input)
>  	if (!overlay)
>  		return 0;
>  
> -	fwnode_for_each_available_child_node(overlay, fw_segment) {
> +	fwnode_for_each_child_node(overlay, fw_segment) {
>  		segment = devm_kzalloc(dev, sizeof(*segment), GFP_KERNEL);
>  		if (!segment) {
>  			fwnode_handle_put(fw_segment);


