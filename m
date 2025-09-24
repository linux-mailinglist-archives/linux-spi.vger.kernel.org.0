Return-Path: <linux-spi+bounces-10272-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B20B994B1
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 12:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB613AA941
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D8C2DBF6E;
	Wed, 24 Sep 2025 10:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LF9VFVwz"
X-Original-To: linux-spi@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B012D9EFC;
	Wed, 24 Sep 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708040; cv=none; b=tLsYC8702A0a2mPK7WHJs1K/oQnIm8tcpBFA1r+4RrA2ht+7Aw4YYzNy44o97HLTrjLvtXJ+An2lkfPHvnn2fF0vpMPnXV70UscVFpbgE38oTCa3leUuyJDVrTbsqP1GTZHxbrOn6rD9Ot+zDIDL1JZDiKCsnWyf8XC0q0CdYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708040; c=relaxed/simple;
	bh=z+fwlVBh/936yHBLicaMurJ9k/AUaTgZnE8IkngmKIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRRxgnZnZQhv/CiP0gPmNnk8pyPFOqeLw7R5cuqzO7pmu8XCS2kvR7TAESTh6o9xsD9CoSmRpSGnxriZvmI05ckKBNHvSwpu7yAGFg3dYwXkkeX+QFp2IVfjesXqezs2eIXleIhL5UNotfVBGRSuKxwF739CC49OOSGj6+Nln7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LF9VFVwz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-33-231-nat.elisa-mobile.fi [85.76.33.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 4744A169;
	Wed, 24 Sep 2025 11:59:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758707949;
	bh=z+fwlVBh/936yHBLicaMurJ9k/AUaTgZnE8IkngmKIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LF9VFVwzxv8LeHj9RNKIwHLqw4VGDlQ+RrRC9TeLUjbyWDq3O9yX0oP3Ucd/pNA+t
	 mjzmJaKvgc8pPdD6TBY8lw425OyoSOtYapOmSeUIlbxWLTdpEqDwu2+IlxO0kVSTxW
	 54JR7fErTfe+F4LHPNIyTTbV1zmiAjnwa6UnNumI=
Date: Wed, 24 Sep 2025 12:59:59 +0300
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
Subject: Re: [PATCH v2 06/16] property: Drop DEVICE_DISABLED flag in
 fwnode_graph_get_endpoint_by_id()
Message-ID: <20250924095959.GF28073@pendragon.ideasonboard.com>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-7-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-7-sakari.ailus@linux.intel.com>

Hi Sakari,

Thank you for the patch.

On Wed, Sep 24, 2025 at 10:45:52AM +0300, Sakari Ailus wrote:
> No caller uses FWNODE_GRAPH_DEVICE_DISABLED flag when calling
> fwnode_graph_get_endpoint_by_id(). Drop support for the flag entirely and
> remove it from the documentation.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

You can squash this with 07/16.

> ---
>  drivers/base/property.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index b52f7b3bbf84..7fc3257f223d 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1239,9 +1239,6 @@ static bool fwnode_graph_remote_available(struct fwnode_handle *ep)
>   * has not been found, look for the closest endpoint ID greater than the
>   * specified one and return the endpoint that corresponds to it, if present.
>   *
> - * Does not return endpoints that belong to disabled devices or endpoints that
> - * are unconnected, unless FWNODE_GRAPH_DEVICE_DISABLED is passed in @flags.
> - *
>   * Return: the fwnode handle of the local endpoint corresponding the port and
>   * endpoint IDs or %NULL if not found.
>   */
> @@ -1252,13 +1249,12 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
>  	struct fwnode_handle *ep, *best_ep = NULL;
>  	unsigned int best_ep_id = 0;
>  	bool endpoint_next = flags & FWNODE_GRAPH_ENDPOINT_NEXT;
> -	bool enabled_only = !(flags & FWNODE_GRAPH_DEVICE_DISABLED);
>  
>  	fwnode_graph_for_each_endpoint(fwnode, ep) {
>  		struct fwnode_endpoint fwnode_ep = { 0 };
>  		int ret;
>  
> -		if (enabled_only && !fwnode_graph_remote_available(ep))
> +		if (!fwnode_graph_remote_available(ep))
>  			continue;
>  
>  		ret = fwnode_graph_parse_endpoint(ep, &fwnode_ep);

-- 
Regards,

Laurent Pinchart

