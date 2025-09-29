Return-Path: <linux-spi+bounces-10341-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 158A7BA8C5A
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 11:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7057BA06B
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 09:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E12D24BF;
	Mon, 29 Sep 2025 09:40:30 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827582D1F7B;
	Mon, 29 Sep 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138830; cv=none; b=tjDFFaLKSF3DNwMylAHU8sNmNjT7nlF7V2zFJOYUI+MDDSwNItdPwhsOGo1tMtuNi0EVIUWc7X9njHcUupTFijqlWaVrFqqHfO/wRNjy7Yn+E4qO86BPa+58uVuhixVsJvX4s0qwGbbncOe52vDi4eqOqQMSfwJwxkgpUsiAC88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138830; c=relaxed/simple;
	bh=CN3qQvxZoQhROM0ck45hiAJersJl0QgpDl6Y5jjCDh4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/tDfcw7TPkF9Pz7p5OID88DhnYovocy+s+8pu7HTmbWF2T/T7Pdb+NUp25Y5hdtUsdnQdUkUsm3C3kWNu4ywHULlMaD6ogD2nWeo5WvjR8v+regaYZ3RweN11MoRIAIS5OoIUQeKvcdv78t524vqXCRaEYBcZ/s5nb0oqo4BkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cZx4b6XPqz6L5BB;
	Mon, 29 Sep 2025 17:40:15 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 56FCF140133;
	Mon, 29 Sep 2025 17:40:26 +0800 (CST)
Received: from localhost (10.47.64.220) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Sep
 2025 10:40:24 +0100
Date: Mon, 29 Sep 2025 10:40:23 +0100
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
Subject: Re: [PATCH v2 07/16] property: Drop DEVICE_DISABLED flag in
 fwnode_graph_get_endpoint_count()
Message-ID: <20250929104023.0000647b@huawei.com>
In-Reply-To: <20250924100040.GA9827@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
	<20250924074602.266292-8-sakari.ailus@linux.intel.com>
	<20250924100040.GA9827@pendragon.ideasonboard.com>
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

On Wed, 24 Sep 2025 13:00:40 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> On Wed, Sep 24, 2025 at 10:45:53AM +0300, Sakari Ailus wrote:
> > FWNODE_GRAPH_DEVICE_DISABLED flag isn't used anywhere, drop the flag and
> > support for it in fwnode_graph_get_endpoint_count().
> > 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> 
> With 06/16 squashed into this,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
Agreed, doing them together makes the flag disappear so we don't have
to check manually that there are indeed no uses of it with the functions you
modify in patch 6. 

With that,LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

