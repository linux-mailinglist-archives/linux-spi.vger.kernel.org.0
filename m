Return-Path: <linux-spi+bounces-10284-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A6B9B7ED
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 20:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55BCC3225D3
	for <lists+linux-spi@lfdr.de>; Wed, 24 Sep 2025 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BD11FDD;
	Wed, 24 Sep 2025 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efsmGQUS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A5231830
	for <linux-spi@vger.kernel.org>; Wed, 24 Sep 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758738783; cv=none; b=EP/u4EV3bub3SSRKuGNlqSw4UgCDs/pfojz83i2uLz4LqZDkkZS7gArwX57X3TIX7TrPN1EqvynI/nBeeCH3OsxJTCUe9iEtS+EadNZyBIGDYpOcSBDNHpW08OZq3KGA1WZOWijVK6exLTn2U6/EgXfoPrB7qmSDjogkxv5w2AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758738783; c=relaxed/simple;
	bh=BPmp7/HZwCEN2P3jkfww+6QmR4v0glh9O0ulkchMmyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gr9XYltIde6G58KDkHFQbdLv6MHB9Zhw5UoDUbTEOmbEn2pp6b9xDVNvVzX+eTG/ueGKj8c5MJgnrIaU0JtEioPQqRlLzsrxYGZgA2KtCYvFQbkDRytt09eOVebs8xQ5IdHQShxCRoB+G39sZeC5KJtQBEwrgPAK2Ojcitj41Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efsmGQUS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so142833a91.2
        for <linux-spi@vger.kernel.org>; Wed, 24 Sep 2025 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758738780; x=1759343580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZiGUngEg1bz9RIGYOxgVE+7eeU9JAJ9lijyiP/taFE=;
        b=efsmGQUSpeAlPhYHne6mC9XC+C9cNzm6ws/4Ul28qA1tV22MQq/u+/O0JouKGUlWsB
         Wg8aQR3IWtavWeaibMajUZYpQ73rb5v4O6F0KOmCFAq5Gz6PwNetVK7bWKp8Tw6mPL7E
         5ZuAfkeO8xgdBah+Js9Z3uVhESeJZWIqvVbPgx3uF/xguI+WgG4yLngOl9cmHZTTn6Ng
         LS/WfY3SG3CVQ37ATQh/qhypJX5s+AoKuctiUHKPWFvEPbAOkCNNC8g8OLLCR3UZ23Ka
         g8HLw1zh61PvqSya2YzFZyovay2iCDkNmu+7zp5GQKFxoSswiC8LBZczkewG1LArYuuk
         HlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758738780; x=1759343580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZiGUngEg1bz9RIGYOxgVE+7eeU9JAJ9lijyiP/taFE=;
        b=T/nmKug9wTGBWUwetNNxXU6PPPTDvhKGhUnkUymPlJLIIy2GwEpoZZx7t8SsH8wdAE
         U83/OgFRO7AkZ+9w9g0aJf4vkc5BZ9+F/1S+AY2SBNP+k14I8lFImoGXOazUGYM6NK1f
         EgmMic8AAFD4PNWFC9e+R6MZ5wCxw60G4seER04ThUXd6iucGkq1dQxzP9BMYys9M9sK
         GRI0rTbaH4Tw/L/mpoVYNuiAGzSKO45z8D5UFcjtnftCl+llrGlXYGxWYPCN7+GxeY3z
         jgufx+sk2Nd4rgudTIqe/3tK8BxgXz2MpIgWduSxVNvYliexnoYmJgbl8wzJp+ERJ2/2
         p1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWFXLP7XZ7lIYVHW+TUIOqeRA+1n7/oXl5zmv6ok5eLL4MqIqBfnUatYByVY6kKXvD1FlNZZ3TmVvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1eiEUpJdg1X4XkbQbgw2wg+6a6WKKh0f94pM6lPZO7PH0x5Zo
	EvbtvbNCEulSlv1taGMMS8lkUmCcpYtH3AnP1UQINWbU7KLjorArvDcA
X-Gm-Gg: ASbGncts6LeW4Q4TqiY2eeC8O5VFRLNwPQQ946bR9cb2PB11P7YtVuVUml9K0f4Nk4W
	2l00bARti0pCj2LhPgK3PQ7YOmVG8JVeaaSOkT8edYmr3y/1j4XbBAmM2GHUDkv4/M2Ojnr85/Z
	622WTodNqRCRT5/vtlnydHJ122OWOazGydh2Yd6L94Ucd3SDTsEbll2b0qk+wAxQ+e+sbZZkAMe
	CWCHmXquIvmm8972QkLRAAJCZvieDk+zmuvNnCSGX77zttZcwe9K9Kkn9/v9IhP+ofYKbI9c/DX
	onWqg80TPKaASjPCpDd8sfpDEu7fem+O+seS6FKPu2IJubns7f/Aw0cfhOw8ITcdrqxMJZXBaKq
	jxoQYuToWathBoMj/7XuJzLg=
X-Google-Smtp-Source: AGHT+IGjh8GHJkW4HrCxPM3eBOhaOjfwbgk4g/556B0RsOzYugb+CgPT02LHWIyv3xFJhWkcNdv5fA==
X-Received: by 2002:a17:90b:3d4b:b0:32d:d4fa:4c3 with SMTP id 98e67ed59e1d1-3342a2ef04fmr506703a91.31.1758738780237;
        Wed, 24 Sep 2025 11:33:00 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f4c4:bad6:f33e:ddc9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bda06ccsm3113092a91.7.2025.09.24.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:32:59 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:32:56 -0700
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
Subject: Re: [PATCH v2 02/16] ACPI: property: Use ACPI functions in
 acpi_graph_get_next_endpoint() only
Message-ID: <iqfarpvf72l7qbhfinopjb27qvfm7wg77d4yhuy5qyubcwtcd2@exmcuvgqr353>
References: <20250924074602.266292-1-sakari.ailus@linux.intel.com>
 <20250924074602.266292-3-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924074602.266292-3-sakari.ailus@linux.intel.com>

Hi Sakari,

On Wed, Sep 24, 2025 at 10:45:48AM +0300, Sakari Ailus wrote:
> Calling fwnode_get_next_child_node() in ACPI implementation of the fwnode
> property API is somewhat problematic as the latter is used in the

How exactly is this problematic?

> impelementation of the former. Instead of using
> fwnode_get_next_child_node() in acpi_graph_get_next_endpoint(), call
> acpi_get_next_subnode() directly instead.

I think we are moving into the world of mixed fwnode types with software
nodes/secondary fwnodes, so I do not think this is a step in right
direction.

Thanks.

-- 
Dmitry

