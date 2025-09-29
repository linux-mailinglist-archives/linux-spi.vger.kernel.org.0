Return-Path: <linux-spi+bounces-10337-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694AABA889F
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 11:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285A617F12B
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 09:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06573280A29;
	Mon, 29 Sep 2025 09:12:06 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5A834BA41;
	Mon, 29 Sep 2025 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137125; cv=none; b=cDRoc/LdALRi+9KoAWJo0lxIylP7Y6oixzKL6TPnED5hL0m9nUWf04L3foEDZwq4e1nzO1QtXJuyhxqgt3Mhbd9583H+VCWw3yM2aSe5Vsfqzv/XViXzPl2+GOla3zVIa845mx9CX9HjLN/DHIKsv/gQv+6rsRVljJr+V4khWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137125; c=relaxed/simple;
	bh=pzjgHw1TRVEzQipbuD6sdMwfcVRo6nvQqjOx0CUKQzM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2S+Jrz7G1xVhaiWTxbSnvrnrhQt91rgordP0Cb91zO8+kkunzhoyirDDyyjC1nGRAmbaoh7JirOVfaFJZHoAcg41VaV0uy2OsqffagpYUoiedK3geI+PXkopezR5vheu/Dy/OirdPcKR80HscHQGt3GqMihiLAY7zPaLoSAUHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cZwNS5dd8z6M4jd;
	Mon, 29 Sep 2025 17:08:56 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E05CE1402F5;
	Mon, 29 Sep 2025 17:12:01 +0800 (CST)
Received: from localhost (10.47.64.220) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Sep
 2025 10:12:00 +0100
Date: Mon, 29 Sep 2025 10:11:58 +0100
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
Subject: Re: [PATCH v2 02/16] ACPI: property: Use ACPI functions in
 acpi_graph_get_next_endpoint() only
Message-ID: <20250929101158.00000709@huawei.com>
In-Reply-To: <20250924074602.266292-3-sakari.ailus@linux.intel.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
	<20250924074602.266292-3-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 24 Sep 2025 10:45:48 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> Calling fwnode_get_next_child_node() in ACPI implementation of the fwnode
> property API is somewhat problematic as the latter is used in the
> impelementation of the former. Instead of using
> fwnode_get_next_child_node() in acpi_graph_get_next_endpoint(), call
> acpi_get_next_subnode() directly instead.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Makes sense to me on simply basis of making reasoning about it a little simpler.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

