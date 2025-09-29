Return-Path: <linux-spi+bounces-10349-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFF9BA8C51
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 11:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB77C160A84
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 09:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD72ECD28;
	Mon, 29 Sep 2025 09:53:45 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03980272810;
	Mon, 29 Sep 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139625; cv=none; b=MuZwbyaT8lX9QltIgaCXPkFhgaI87pJP/p9S67bz+GAIIfrb153CdpbZ+KzPD7mkDDIh7gSuRVTcMRrUrkvFX9RR+oeQVptvI4JNMCAJJO5WBvSa/C3wBLEd0yGB1h/qWz9tXI+3tC9LH1Ed+Tf42I7LGn2SFJljqgoSikK+HNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139625; c=relaxed/simple;
	bh=NUrQYStLI/WVF+npM9aFdjdOrIIatiNEvu0keulgX0c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l1RNOyRV8vbWy0wSs3Z/iruvUj+tyHA7C5nSFbumJYQQIjEmRhLTKiAiyKM0q0ztoE4QHZr9RntyXtARRAXb5m8hfBk4xtNtgXQHlyFZNGXdGyinpmFuYFHVAuR14lEaBfGBWEgORyGsL1tuyjkinDGaww+3uWyc5ZZ7289Nm0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cZxJX60ZXz6M4Xm;
	Mon, 29 Sep 2025 17:50:36 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 058381402FE;
	Mon, 29 Sep 2025 17:53:42 +0800 (CST)
Received: from localhost (10.47.64.220) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Sep
 2025 10:53:40 +0100
Date: Mon, 29 Sep 2025 10:53:39 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<linux-leds@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-spi@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Daniel Scally
	<djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek
	<pavel@kernel.org>, Matthias Fend <matthias.fend@emfend.at>, Chanwoo Choi
	<cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Paul Elder
	<paul.elder@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mark Brown
	<broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@kernel.org>
Subject: Re: [PATCH v2 15/16] property: Drop functions operating on
 "available" child nodes
Message-ID: <20250929105339.00004b25@huawei.com>
In-Reply-To: <20250924100429.GM28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
	<20250924074602.266292-16-sakari.ailus@linux.intel.com>
	<20250924100429.GM28073@pendragon.ideasonboard.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)


> > -/**
> > - * device_get_next_child_node - Return the next available child node handle for a device
> > + * device_get_next_child_node - Return the next available child node handle  
> 
> This last line is an unrelated change. With that fixed,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I'll assume you'll tidy that up.

Very pleased to see this go, simply for the saving in time explaining the odd difference
to people in driver reviews!

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


