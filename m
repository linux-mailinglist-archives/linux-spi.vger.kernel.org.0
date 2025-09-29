Return-Path: <linux-spi+bounces-10339-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9667BA8AB0
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 11:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969EB3A80A2
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E632877D3;
	Mon, 29 Sep 2025 09:36:09 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3F2356B9;
	Mon, 29 Sep 2025 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138569; cv=none; b=q4uGXvKCCbC3mb0JrXB5HX+IdkuWFZBudFKjd1BQVwOD7cxSnbxcrP65iA4B9Tr+V6Vla9fTHcne0zVCwEdKYVhqpcXWCRtd6Y/IqCKeT6xv7fMrbpsGOSFmqe7aUT8hoAuOUNv+A+uQu7RwrPgcaOZS+temgIzru2LFRbSw5F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138569; c=relaxed/simple;
	bh=m75fy5agr4nOm6ZswHP3z9cSx6nGu66GnnEkQoJbIQ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/bx7sjMzRO951nQ8WPwxPTludGED1+SGnsfB4GQ6hyOjSfr1vSoefp0+aU8ZMjAyf03a8H6hNBmOZ0agiljxHrRZqgWO3Lb202V7L/MFnY9tWfcYM8i77qgwNikeaPXzfByQnS3KFkYpteQWH1SM45/vrsMfvHRhSl8IixiJ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cZwxJ3JLrz6L550;
	Mon, 29 Sep 2025 17:33:56 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 82E111402F5;
	Mon, 29 Sep 2025 17:36:03 +0800 (CST)
Received: from localhost (10.47.64.220) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Sep
 2025 10:36:01 +0100
Date: Mon, 29 Sep 2025 10:35:58 +0100
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
Subject: Re: [PATCH v2 04/16] ACPI: property: Return present device nodes
 only on fwnode interface
Message-ID: <20250929103558.000033bf@huawei.com>
In-Reply-To: <20250924074602.266292-5-sakari.ailus@linux.intel.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
	<20250924074602.266292-5-sakari.ailus@linux.intel.com>
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

On Wed, 24 Sep 2025 10:45:50 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> fwnode_graph_get_next_subnode() may return fwnode backed by ACPI device
> nodes and there has been no check these devices are present in the system,
> unlike there has been on fwnode OF backend. In order to provide consistent
> behaviour towards callers, add a check for device presence by introducing
> a new function acpi_get_next_present_subnode(), used as the
> get_next_child_node() fwnode operation that also checks device node
> presence.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

I think this is fine because of the bit in the ACPI spec that says all
bits are set if _STA is missing.   It seems much less likely we'll see
problems with hardware disappearing because _STA is there but says
the device isn't present.

Always a regression risk though :(

With the formatting changes Laurent asked for
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

