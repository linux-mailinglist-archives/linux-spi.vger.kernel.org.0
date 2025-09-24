Return-Path: <linux-spi+bounces-10271-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26762B9946D
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 11:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E76170966
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 09:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302AD2D9EFC;
	Wed, 24 Sep 2025 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="m4V6juia"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6850F2DAFA4;
	Wed, 24 Sep 2025 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707943; cv=none; b=jH7LE89Ky11hTUZTlafTIHBPlQWvORQFqgqH93y90P4cjZWTbDCy1NyCJk4lDqZRdA/hXQuyuqcZ5mPcNkGs+m3L9FsDwTzlFMSRMvc4Vi/lWoqoLFgz0m+Eq5nDoqDBaSfp+6q73YrTCYrRmxAy1covrWRvx+oR19jx5zpqELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707943; c=relaxed/simple;
	bh=EFuWWMY+RCZu4LzymC1GQ57ewcJIp+odck8dAKaG3Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9jun4H2yES5nX/pHAvrXfKTWRV984mMT7Rcj3D3yzor4VTsjsMEjqLgoCu/QGl+gUZCvKqNdKBU6iq7UtTJO2gQcG3VUtebTGsdpq7gcD/qJhLH3nzqgeChvVZWvpecOxmppSGl/VRXKRK4vZhwe9Iyg6Fh4NGOI2MbrwWwe74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=m4V6juia; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 80A881E30;
	Wed, 24 Sep 2025 11:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758707851;
	bh=EFuWWMY+RCZu4LzymC1GQ57ewcJIp+odck8dAKaG3Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4V6juiaSdSjRhKOCDkxLdkNBzZBuRfSVsdPDDo5MpFNbsIoP5sBBGllXshWqt7UZ
	 sNdNzzIzda9xwYDgzIzIEdyIT/7e+Qo6FEoWjVid2INExJyDc5YIoNjvffvsawT9F8
	 4NVHRKoobQS3QCGb2IsJAkm9zhqOjzVxc2gOlDME=
Date: Wed, 24 Sep 2025 12:58:22 +0300
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
Subject: Re: [PATCH v2 05/16] property: Move Return: section of
 fwnode_graph_get_endpoint_by_id() down
Message-ID: <20250924095822.GE28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-6-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-6-sakari.ailus@linux.intel.com>

On Wed, Sep 24, 2025 at 10:45:51AM +0300, Sakari Ailus wrote:
> Move Return: section of fwnode_graph_get_endpoint_by_id() down where it
> habitually is located.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/base/property.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index f626d5bbe806..b52f7b3bbf84 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1235,15 +1235,15 @@ static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
>   * The caller is responsible for calling fwnode_handle_put() on the returned
>   * fwnode pointer.
>   *
> - * Return: the fwnode handle of the local endpoint corresponding the port and
> - * endpoint IDs or %NULL if not found.
> - *
>   * If FWNODE_GRAPH_ENDPOINT_NEXT is passed in @flags and the specified endpoint
>   * has not been found, look for the closest endpoint ID greater than the
>   * specified one and return the endpoint that corresponds to it, if present.
>   *
>   * Does not return endpoints that belong to disabled devices or endpoints that
>   * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
> + *
> + * Return: the fwnode handle of the local endpoint corresponding the port and
> + * endpoint IDs or %NULL if not found.
>   */
>  struct fwnode_handle *
>  fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,

-- 
Regards,

Laurent Pinchart

