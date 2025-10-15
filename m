Return-Path: <linux-spi+bounces-10687-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C55BE09DD
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 22:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E79D4E1998
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 20:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5941547C9;
	Wed, 15 Oct 2025 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0USLYG7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B829AAFD
	for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760559625; cv=none; b=Z9E1GjC0N7YWUN0rXLSFeKSROwP/1UieKqQ2vyCvUqgFqHAAwuGwE3KVxI7BnVKQ9254ROwdTQqefbrwDIG0Q0+SVeh+/PyHW09uEMN4YeQfdntZ2zCilVDy2vP8cu+OmUVdEwSRTow5bryOOhPY9aMEdQ+BMRgjSL5scQVc7cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760559625; c=relaxed/simple;
	bh=W5lL+7clCIuimE2JZ8XP6AYfpvpiK8gFacYRPIHJLgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkhYR4nPrPQhKrH1HhkdO9GlyUKtt9aF/L4V+x049xM0wA2MGmKH55jnxXH24L6VA6+IQlbXNHbMGvDxVSI6ocUp8p9nILAIq4BjNLU0C6mNhj7PURHheeB7DGVH47ZDW8x+PYxtHx3mZavHlKpp38A+1qkZVXfMEweMILHIj2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0USLYG7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7811a02316bso17388b3a.3
        for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760559623; x=1761164423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=95gcM031oDoREK3NrLaeDpeIxgdfvAPsa65KxdRg+ks=;
        b=M0USLYG7rUyAgUurL2h04e/V1EqNNSdzSyAhWbOIWIUzbwrgQwFk7gInAPhBx5bV87
         O5kHGaOVCHfcp/qc9YKMpHQ5WQtkzrg4pBRAC2pMjcOzN63hTYmWzuNYpWtXoQ2zy+x+
         atk+kv8u0l55hq2ycBKbEChrSlNb6has74FBUMhcX05gM91i/e25Vhj9cJewKB/GleIo
         mnSq17a/61qKK4/q/PMJ6IPE3JGJj3FfnXKzRXq2e3vEf/+B60IDSX4KBVJcjd+LGJbM
         GdAmZRrL5LA+eK5RDPqGPtAipr52YRKMV8rgYbqb8plXn36YXcMUBBCAzrL1GdbH3q1p
         0LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760559623; x=1761164423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95gcM031oDoREK3NrLaeDpeIxgdfvAPsa65KxdRg+ks=;
        b=BrRhhfE/KyQ3cDPEKZ5cXbCBLSC8DhfSJHDf+hUKraCLFK1O71H+OK+E9CP0cXChHp
         zGPo1/LM8MHi4Uf0koGHte8EE9Meg6RWI5d3R0poElRor/Z2/XTfYLaI1fgAkehJ+oBi
         FuJGBozq6kebh9KFuzIV+gEhq/TdE4sz2/g6HsBPOPYVJwKm2OcEhPdxXvdboINGLXSh
         UtGTwLsOXdYLiLSPagZC1MYRSHofrfIVxZlk52wCa7TCwqFg8rEeiPvK1Y8H7eMm4dAQ
         Gg4nLv44OpeZ5/56VVCc5QCyejO+zXgfA1iM+19wlKHwDca6r687sny36ABykpX8OSDV
         WzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOmXSto8Sm/K4acfM1WYjoue8oFkjR03viRkaB7uBkZQu2kJQUUxH15LWKSKW8+whDZ9a3P25JD5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfq/vjc2/Str8GRusFSyC4xy+97Jz3UrY57wvm4muoJWkzz0el
	u/vP/w1nhaFmZHXv1koHEkveO1V7lzITLSWFhN6R2968kKXMLOqEQu3PYcepKnp0
X-Gm-Gg: ASbGnctU/5dcLUbZM03iS2pQN1gBUXZJygveRtOdHqnJO2Dc1qwFUYKSYQbLmvkuieM
	StGOZls46lMaIj4TkJlUa/4omH+ZV8apxwMldICxIp+8Bpnew49ZcHtmD+Q4Bc01HMziFlYXUw9
	5pWEro+uoDDgqWU9vOJuqTauJabe2n0qbx1+i9nQbmV3UXduiX4Iml+LdKXIGT0WmJDBpJ1Eq7h
	tmc3gahzMlqVzWRfffttP1oO/VRANKk19kjxKFAzkaM84zgB7LS3EhHD77IoKt0GlNOG6i/I5pq
	5fKbjajcZbknTHKUSvdT7cagblgyeXi4VXUSykD0tjvOmEV9pOtAlFY84MpZwzweQOr7Gdz7lNF
	pyWWOQbD2h37uxHZVzmk+gBRI06RxKM8tgOAyPt3JgwiMykoj94sxHR6Ggl4ft//C0sS52SZ3lp
	WavfjFgIJVieIEP59g2CSERCLbBB7hBS4=
X-Google-Smtp-Source: AGHT+IF0EKTCjT3naae1xA/PAZLLqfv/YtCN9ndqoHWsu9/x7DQfDR8VhO2uGork8o9ktOC/MruXJA==
X-Received: by 2002:a05:6a00:2d8f:b0:781:2538:bfb4 with SMTP id d2e1a72fcca58-79385ce2724mr34350286b3a.10.1760559623239;
        Wed, 15 Oct 2025 13:20:23 -0700 (PDT)
Received: from localhost ([2804:30c:402b:1a00:ec78:db53:a246:207a])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-79cf0a052b8sm11363661b3a.67.2025.10.15.13.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:20:22 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:21:26 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/6] spi: add multi_bus_mode field to struct spi_transfer
Message-ID: <aPACRllAorjG47L7@debian-BULLSEYE-live-builder-AMD64>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>

On 10/14, David Lechner wrote:
> Add a new multi_bus_mode field to struct spi_transfer to allow
> peripherals that support multiple SPI buses to be used with a single
> SPI controller.
> 
> This requires both the peripheral and the controller to have multiple
> serializers connected to separate data buses. It could also be used with
> a single controller and multiple peripherals that are functioning as a
> single logical device (similar to parallel memories).
> 
> The possible values for this field have the following semantics:
> 
> - SPI_MULTI_BUS_MODE_SINGLE: Only use the first bus. This means that it
>     it is operating just like a conventional SPI bus. It is the default
>     value so that existing drivers do not need to be modified.
> 
>     Example:
>         tx_buf[0] = 0x88;
> 
>         struct spi_transfer xfer = {
>             .tx_buf = tx_buf,
>             .len = 1,
>         };
> 
>         spi_sync_transfer(spi, &xfer, 1);
> 
>         controller    > data bits >     peripheral
>         ----------   ----------------   ----------
>             SDO 0    0-0-0-1-0-0-0-1    SDI 0
> 
> - SPI_MULTI_BUS_MODE_MIRROR: Send a single data word over all of the
>     buses at the same time. This only makes sense for writes and not
>     for reads.
> 
>     Example:
>         tx_buf[0] = 0x88;
> 
>         struct spi_transfer xfer = {
>             .tx_buf = tx_buf,
>             .len = 1,
>             .multi_bus_mode = SPI_MULTI_BUS_MODE_MIRROR,
>         };
> 
>         spi_sync_transfer(spi, &xfer, 1);
> 
>         controller    > data bits >     peripheral
>         ----------   ----------------   ----------
>             SDO 0    0-0-0-1-0-0-0-1    SDI 0
>             SDO 1    0-0-0-1-0-0-0-1    SDI 1
> 
> - SPI_MULTI_BUS_MODE_STRIPE: Send or receive two different data words at
>     the same time, one on each bus.
> 
>     Example:
>         struct spi_transfer xfer = {
>             .rx_buf = rx_buf,
>             .len = 2, /* must be multiple of number of buses */
>             .multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE,
>         };
> 
>         spi_sync_transfer(spi, &xfer, 1);
> 
>         controller    < data bits <     peripheral
>         ----------   ----------------   ----------
>             SDI 0    0-0-0-1-0-0-0-1    SDO 0
>             SDI 1    1-0-0-0-1-0-0-0    SDO 1
> 
>         After the transfer, rx_buf[0] == 0x11 (word from SDO 0) and
>         rx_buf[1] == 0x88 (word from SDO 1). If the transfer was longer,
>         the data would continue in an alternating fashion.
> 
Can the above explanation be added to the documentation?
Maybe spi-summary.rst or a new file?

> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Nevertheless,
Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

