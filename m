Return-Path: <linux-spi+bounces-10285-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1D5B9B805
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 20:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E125321F8A
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 18:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1664313D5C;
	Wed, 24 Sep 2025 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtBmNeMB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287912DFA54
	for <linux-spi@vger.kernel.org>; Wed, 24 Sep 2025 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738973; cv=none; b=p2QD/LMU/lSOz82kS0VpBv4JDwvrFBF5YJECtZvIr78SgfbXdpD/khAWSvDhe+T+1eWuqRSgt0wHUVHHuG4f7cdTmlAS5sQedDP7vM1QGnwQx8czBnEiwzgEHcY3qpQVhrFZQQDPi7kiPmMKMRUZnOx54cImjtPawj1j+4wnz+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738973; c=relaxed/simple;
	bh=2aLfX7a8qrLe04EEuCsSWXOjT7NO0ExrjFnQIBlHj04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcFyAN2+1dMzti2uSybEgpCnhcDPzoMdRJCX0BkT7+PUX8CJeILcQpKMS3VC40yNqtIzgkUOT14R4VfnEFiQBbPA9a88Llf/PoLYSIpYg3OSsJ8ffoXU7zfAtDSkelc2FPumy42FhbBmKIYZm591dMEvNJwBtBHI4ZKa+kUwB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtBmNeMB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24457f581aeso1513175ad.0
        for <linux-spi@vger.kernel.org>; Wed, 24 Sep 2025 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758738971; x=1759343771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RuMDAryKyhqMDr6B+XSq4gaOR0tjLhHQ+hf5EwbyoXs=;
        b=FtBmNeMB04FY3JGB6PNvtOFMiiWfAj4garK3jVjddYu+aBCpnKJv62bLvq1W//T70a
         y4kpNyp7rAle3Axx60PHhi6UEdug4mVpmTWaiXKH7HrgfEK/PWpxCcW0GSz76SJe4Dr9
         occhHLHIxPq0kTA95Jz5yBEygNFimb1rEmkA1gh+VV5Pqlk8iMz81SJJZ0+AJISXUxZt
         wdtaeEH1wwkn7kSP5ttEoRqBmeHlsXKKhB8JQMcokPHbGgOVheMDGjqihXZULw08wYio
         ZlNFk+yeDUGN96q/XFWEIvy11lkr81KqELV2YRixghqOF9U1I8bvBJ6ZhOrkKSss3XPz
         GONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758738971; x=1759343771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuMDAryKyhqMDr6B+XSq4gaOR0tjLhHQ+hf5EwbyoXs=;
        b=WmiObosrbds8A4LzQZUasb4oecAni1EgimVVvghdbYtoWeotCjTOIpGX7e7L0ceN9q
         jVlCXHEAQ2+jHcvf0rIYzJ9oaXFyaWZJAWhoH9c8T2sn1nYMR4KpvS6bqkrgAqJVCgD+
         t2r2L0r2g+SD32WV3zisPACeeWERrSHCTUlUySLbpV9it6O5S0hLJHyc7iRUNL5IZj/Y
         R1EQ1M9bop9XPU4e9LwpmVJzYTLIPRdfnPKKnuCjRtkf1QbnmapdGHeoCiRBj8sfeRyf
         LwFDlEc7o9Aa9+PhmExVr2D2p0+kuA9DLxmuRc3EUg+8Ih3Leil7b6Q8aSDaYj/Rw95H
         3VrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuI8yDLUVmLTEJSuH7kV1p5P4KP+08VtoDG/iKWnYlQ/tlJUKM1jXw9VMM8e3nlMBh5ifBtBq85N8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyI8upxlpQx4VoaAhFWN87qd+LKpGBIcTV2DgMn+8DKvwTRLg1
	KSQf0Q1WYkE0UNKyxJqR9OK9sIYb68cmNe0GIKWOx6GJ1WYn9IXdov0c
X-Gm-Gg: ASbGncudX8WEXG8HK2Co/TPF0SYpG1/f/LBY0IHarrdlhAzXiXjYziI8lSrVBJlE3WK
	48sKjunWgPxiyrrWqtNub94DIFGfK73UkwulZJKYBktzd7ZltqBDvRs3qZLFU90WEaqX6EWRpG8
	RqhuAvCLIHiMp11sxHMgCeZIWp6iukVLSO+vQgkbezjDvIfIaLrWc+t7WODa5RYNSEB6umTZoBg
	BYcQ7BjhPJL7Nr0WDltvkH2gP7bgdnRayGjDzy3M+0j1ubmn4Lt9do5Cei6GsumXfgSPLWujOn8
	IWvurJChL3x7lE99Kc4eOilnkAlT5EfvV3qZiV47iK2OLHs582kl2DV/RwYtU6/SOY5/CGmfKIq
	z4TueC4TjFympJcnnx0nlWXs=
X-Google-Smtp-Source: AGHT+IFpCuPX+NdIWL+u5IkcBx4+VbKV/4827jy+s9/WEKKxG/dZ2BXBXewNNRlOFgtg+akJrLG03A==
X-Received: by 2002:a17:902:dac5:b0:27a:6c30:49c with SMTP id d9443c01a7336-27ed4a56ba4mr5732905ad.27.1758738971104;
        Wed, 24 Sep 2025 11:36:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f4c4:bad6:f33e:ddc9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd90367sm3096304a91.5.2025.09.24.11.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:36:10 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:36:07 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
	netdev@vger.kernel.org, linux-spi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Javier Carrasco <javier.carrasco@wolfvision.net>, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Matthias Fend <matthias.fend@emfend.at>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Paul Elder <paul.elder@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Mark Brown <broonie@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 11/16] Input: touch-overlay - Use
 fwnode_for_each_child_node() instead
Message-ID: <amnjiro7qhreys4upoh6ggqurom6gudk2gw5ayrfjhj243wqwh@o4hf6txhsm62>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-12-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-12-sakari.ailus@linux.intel.com>

On Wed, Sep 24, 2025 at 10:45:57AM +0300, Sakari Ailus wrote:
> fwnode_for_each_child_node() is now the same as
> fwnode_for_each_available_child_node() on all backends (OF, ACPI and
> swnode). In order to remove the available variants, switch the uses to
> non-available variants.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

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

-- 
Dmitry

