Return-Path: <linux-spi+bounces-5999-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCB19EC08E
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 01:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1144169C5C
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 00:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BE82451F9;
	Wed, 11 Dec 2024 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcZxQyQn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB929429;
	Wed, 11 Dec 2024 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876123; cv=none; b=AIJHW1W0+G3q2YWUIIz03L+DKcXB4VPI/t2MxVAK2mhpvw5jnbxtlneUyh/uZkBsxG9KbnUOJIAJtjqluZtiVgzJhBFN33f0DLJFQ+fuXpWnR1O0zDGcjBNkYuap4/1tV+kp4bmScO6q51pVh3cfOQKX6AnYSOTZzQ3QeVJ7bOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876123; c=relaxed/simple;
	bh=dGg+vBlN2/227YFWWZ5lxQQNKHiuZJtH1L6qz8F0oog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb41r3OvbvRiKR0ckV/egEo+4b/kgBVn7jMSPWPadZRipGpmgIX2JEH2IDbquo/kGzZcNikGxrNKb6v9q6opdRE4AcaVF4f71U+EJCndycY/Wjv/Ap22pTI1W/kj+PaW+jIz+SUHsiQ+404r1iCXyx/J3wtvjlpvpmhefvnzRfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcZxQyQn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so4898496a91.0;
        Tue, 10 Dec 2024 16:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733876121; x=1734480921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kYyY/eAjCLfnO1ga0kM6bbWLwR3rL+BViXn0zTn5BM8=;
        b=jcZxQyQnldshISt2C7S9Tu+W5LiXpku3siuwKYDH4f8QmarZNgU9XXZ3WVBa0D4NaN
         HEie6E0a++7L0fa5FifCrnxHKNqgiR7czzf3nvHm/5OuGerBBr18sqsXk1yQSjFeWg2x
         TTAxzwTgpltq/OAsKQXlEN3hqULBMZT4raXbYliYizBYQM5na6cled9oI6cwT0/mI1JJ
         RauyhnsPeQDepByKgl0OErvFjGxcD2U6e4sgTGHn54899fJsJTy0IFtS7tYo4KWTKjHb
         LyOqmT6SDwBeyT6ELkf3e7O+KEFJz/p510wknYKGuKWylA+hj9Bn96BQtZT3ptPTaoMS
         NEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733876121; x=1734480921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYyY/eAjCLfnO1ga0kM6bbWLwR3rL+BViXn0zTn5BM8=;
        b=hf5IOpIVFahtZKL++ROLbWK/IUpg+Spyh7ZFAzSjnr5HrTjkpDb2Isb3SRsr1sfntR
         KObP82p7aIlpqbj7ukF9P+nRobd6/kvdKcEC6a+P/RyHYxClZ7XF8+KMDubNjhHyoDnL
         qHJGuMwDsSJB31fy7z4+auChE4Q5TQuTziO7hosGb25gpcrBdSb79ve/hYvRre8IIcEP
         SE0dLGrWncSPWTZcjlxKsxeCGT3PywIdJdG72p4cn+/YxFwn1D/Pm+DHMJWzEQI6OGwt
         c3n0FLO73KgPIUDmOcAlyLgHjEHIMcpLlKsKQCyV89xKwF1pgA3ltFwi2E9qJ8nMEpp7
         gYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgLKG8MJ1RvJar3VCJiLz3CuCMws/AJF0GEfHYHGrnpCyaNyFBLmU3/p+DFrou4Z0Z7DF/R1dXN1dt@vger.kernel.org, AJvYcCWof9mY7QiZGoz2akLZSPCOb+ShXAyvgcD0ju5CJeZC5tVjvUq9raqNC9E0fKHev+2CBGU/BvRAhBKZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SJR7YV7wPVw8wi2KD66kQUz31ZvFRERwZnYlzWx/MgQt3eU8
	S3cEEkTU5ulqdcXliZcSZTGQojNn7Pk5I+d0vQg9xO5c5f6dHlM6
X-Gm-Gg: ASbGncshvFi7ohF+aFirWp97q6zCJOyQyREEzSS+z8Ykcs2z2ygFGOJOaJsrdyIU/mi
	o8a6yLWZ9QGZA6u6hLbE971mXktde4YKmIYWm41Bk7vCR5DfGg1VE7VXI7nh1j4GYXRXkngsKJ1
	tYrWqXavSSbm2DyF/nuVmxo2jeCF8TdEqPDykmSqyWGebVGoBShzGQ5kBlvfMBjcOMOtAQ0CpE9
	oaftUqIAJ9B9ThsmGZ2BPWr/G4Yn9if2oSVEqAlv6FH+SvWCBOHjls=
X-Google-Smtp-Source: AGHT+IERMFesUj9YuS+KayK8BhZgeSmODJ2S6t8QwfxBKZgQuHLXCFTk9mpxELWOBJ9kfjx1a2s/Ig==
X-Received: by 2002:a17:90b:3803:b0:2ee:9d36:6821 with SMTP id 98e67ed59e1d1-2f12802a560mr1297495a91.27.1733876121454;
        Tue, 10 Dec 2024 16:15:21 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:adc0:9d23:2d12:1822])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27078b03sm13470360a91.38.2024.12.10.16.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 16:15:20 -0800 (PST)
Date: Tue, 10 Dec 2024 16:15:18 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 1/3] gpio: swnode: Add ability to specify native chip
 selects for SPI
Message-ID: <Z1jZliSoXziuLt1u@google.com>
References: <20240326141108.1079993-1-ckeepax@opensource.cirrus.com>
 <20240326141108.1079993-2-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326141108.1079993-2-ckeepax@opensource.cirrus.com>

On Tue, Mar 26, 2024 at 02:11:06PM +0000, Charles Keepax wrote:
> SPI devices can specify a cs-gpios property to enumerate their
> chip selects. Under device tree, a zero entry in this property can
> be used to specify that a particular chip select is using the SPI
> controllers native chip select, for example:
> 
>         cs-gpios = <&gpio1 0 0>, <0>;
> 
> Here the second chip select is native. However, when using swnodes
> there is currently no way to specify a native chip select. The
> proposal here is to register a swnode_gpio_undefined software node,
> that can be specified to allow the indication of a native chip
> select. For example:
> 
> static const struct software_node_ref_args device_cs_refs[] = {
> 	{
> 		.node  = &device_gpiochip_swnode,
> 		.nargs = 2,
> 		.args  = { 0, GPIO_ACTIVE_LOW },
> 	},
> 	{
> 		.node  = &swnode_gpio_undefined,
> 		.nargs = 0,
> 	},
> };

I am sorry, I am very late to the party, but wouldn't it all work by
simply setting ".node" to NULL? As far as I can see we have in
software_node_get_reference_args():

	...

	if (index * sizeof(*ref) >= prop->length)
		return -ENOENT;

	ref_array = prop->pointer;
	ref = &ref_array[index];

	refnode = software_node_fwnode(ref->node);
	if (!refnode)
		return -ENOENT;

if ref->node is NULL then software_node_fwnode(ref->node) will return
NULL and we'll get -ENOENT which will bubble up to
gpiod_get_index_optional() in SPI core.

Thanks.

-- 
Dmitry

