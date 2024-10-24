Return-Path: <linux-spi+bounces-5353-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CC99ADE30
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 09:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856C21C2092E
	for <lists+linux-spi@lfdr.de>; Thu, 24 Oct 2024 07:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99719CD16;
	Thu, 24 Oct 2024 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5WsgHWn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA2171E6E;
	Thu, 24 Oct 2024 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729756331; cv=none; b=fZMLFPtlIiXM0v2IPE/6OBju90Dj2oD+H6LYjW4n0tsY7Hi2YCO8Hmclq2GKDDcBPlFQEyJEV2fv1iskEol3EVDpGPO71WxyP1+Usq1weIT4/8jd8GujrYDF1kqjxgthQxJTQ48w0+QkSDo9DhqJd80Q/atpIWUbcdV2J3KhDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729756331; c=relaxed/simple;
	bh=pn1YGm5bTJvzIAVJSwFls+B3zLaFehop00/DygkHELg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdfk6hRZv9JMbSUxyJUnmShi9K8ZjkW5heJuBqvid6Ze5e3VsC40AYhNyx6JPSVab8pNSk/JlHgI/DnL8tI7qO8+3GrB4HZFpXOXtyi/Kq2Q4P9A7x484y/2IS6TcJZ77+QQ02LBQtSKU+mCIBPeoNZbNhb/zBTUqCUtkYbE/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5WsgHWn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cb79c648c9so51826a12.3;
        Thu, 24 Oct 2024 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729756327; x=1730361127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dfJuRq/b6qwtgMPyTFyvJlc2k8o4i9OgvL9elbu5Hpc=;
        b=V5WsgHWnEqWyH4TIDrwVx7/vtLL2HSarMKtiePLg1M87QGSN5UDR0IwMcbATh7IkcO
         QSMhRz3qpTpnC0qxTcV5Z+uv0PbDskBjxhd1/2uIAszBTFE/us0jwwAgnpFaigHe5nMt
         dJ08xSF2KKTqlkj5GWsWo/NZM1mjcd4+sLQWdL+J57YilJbxwoDCbh3X69G2eigKer5/
         aY9cuaL40GCty3Nwjq9MMVlDIDT8rd7kZ3UV/x7jBQHBqmLamirffXIa7jRFj8gy3VEw
         Tim4KKS7R4Vn56S3zVhShhOgyUxVWCjeo5f+kIZ6Au9sPtVDX6X8JIUZVAv4FONEzi5Q
         Dv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729756327; x=1730361127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfJuRq/b6qwtgMPyTFyvJlc2k8o4i9OgvL9elbu5Hpc=;
        b=nFUws34I24ER1jNFb7J2crgFQxudxKLYxj1ho3ip7zmDdtBAEnkTB/FkjlhQ0cSXSx
         W4cvRUjPlBoAW1pK2xQ2U4VKh2jMgWH/WMpzBHekI7GrreHTnfqkFqXGSAQjU1etO5Mo
         J0saiyMaBo/h95qIrOL/hSwPq/j7XN5Ed+dl2Pyuo8w/lUrwboCC7nwdq+LZEG1UYPr8
         4P/HqM8/zgw1oaLqgSahrU/lXlfHnu56j6lfqOUIh0WDEr3e6/+iGTQ2387L2eKX/pm0
         vkuJfdNn1eRUts2uQub81bMH8zo26Ru4dygIGa0BQGIB3LXxElKvNiXxMCKE3+dGOorC
         ni7g==
X-Forwarded-Encrypted: i=1; AJvYcCXK7OgcT0ym0UQWxMcDj2dNsYdt6BhDeq4Yr4QpTvFRY7UGaimsJvccB+MC3YlcDn334W0QZQsxC3RongU=@vger.kernel.org, AJvYcCXuhjGX3ojXhgQ2GvVYWF0vMGOIIkeuJSw/The0sEjCQAYtH4dVArS12oYgOIVixzH7ABBBbaJfB0DC@vger.kernel.org
X-Gm-Message-State: AOJu0YxA05z3KKXo6NnXh2SB9t9kHuH9KrVdeJDOfahH9A3sn6QU/INj
	k1EtE0EV+bSgGtHWfRMRgE2ZZj9UpydlInKhpcdPBJp6Xfa2+QBvHDhtjZOe
X-Google-Smtp-Source: AGHT+IHZkWypryMqz4bOsre9+5N72ivCGvCDfFrtcuQw5at0TLFywfrbAHOiAweigPae4YmGuyaAwg==
X-Received: by 2002:a17:907:7d88:b0:a99:d6e1:6056 with SMTP id a640c23a62f3a-a9abf927d9emr232957066b.10.1729756326879;
        Thu, 24 Oct 2024 00:52:06 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d62efsm575009666b.44.2024.10.24.00.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 00:52:06 -0700 (PDT)
Date: Thu, 24 Oct 2024 10:52:03 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Heiko Stuebner <heiko@sntech.de>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
	Dhruva Gole <d-gole@ti.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	"open list:FREESCALE DSPI DRIVER" <linux-spi@vger.kernel.org>,
	"open list:FREESCALE DSPI DRIVER" <imx@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] spi: spi-fsl-dspi: Fix crash when not using GPIO
 chip select
Message-ID: <20241024075203.ifih3rxwyzl7dn4s@skbuf>
References: <20241023203032.1388491-1-Frank.Li@nxp.com>
 <20241023203032.1388491-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023203032.1388491-1-Frank.Li@nxp.com>
 <20241023203032.1388491-1-Frank.Li@nxp.com>

Hi Frank,

On Wed, Oct 23, 2024 at 04:30:32PM -0400, Frank Li wrote:
> Add check for the return value of spi_get_csgpiod() to avoid passing a NULL
> pointer to gpiod_direction_output(), preventing a crash when GPIO chip
> select is not used.
> 
> Fix below crash:
> [    4.251960] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    4.260762] Mem abort info:
> [    4.263556]   ESR = 0x0000000096000004
> [    4.267308]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    4.272624]   SET = 0, FnV = 0
> [    4.275681]   EA = 0, S1PTW = 0
> [    4.278822]   FSC = 0x04: level 0 translation fault
> [    4.283704] Data abort info:
> [    4.286583]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [    4.292074]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [    4.297130]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [    4.302445] [0000000000000000] user address but active_mm is swapper
> [    4.308805] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    4.315072] Modules linked in:
> [    4.318124] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc4-next-20241023-00008-ga20ec42c5fc1 #359
> [    4.328130] Hardware name: LS1046A QDS Board (DT)
> [    4.332832] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    4.339794] pc : gpiod_direction_output+0x34/0x5c
> [    4.344505] lr : gpiod_direction_output+0x18/0x5c
> [    4.349208] sp : ffff80008003b8f0
> [    4.352517] x29: ffff80008003b8f0 x28: 0000000000000000 x27: ffffc96bcc7e9068
> [    4.359659] x26: ffffc96bcc6e00b0 x25: ffffc96bcc598398 x24: ffff447400132810
> [    4.366800] x23: 0000000000000000 x22: 0000000011e1a300 x21: 0000000000020002
> [    4.373940] x20: 0000000000000000 x19: 0000000000000000 x18: ffffffffffffffff
> [    4.381081] x17: ffff44740016e600 x16: 0000000500000003 x15: 0000000000000007
> [    4.388221] x14: 0000000000989680 x13: 0000000000020000 x12: 000000000000001e
> [    4.395362] x11: 0044b82fa09b5a53 x10: 0000000000000019 x9 : 0000000000000008
> [    4.402502] x8 : 0000000000000002 x7 : 0000000000000007 x6 : 0000000000000000
> [    4.409641] x5 : 0000000000000200 x4 : 0000000002000000 x3 : 0000000000000000
> [    4.416781] x2 : 0000000000022202 x1 : 0000000000000000 x0 : 0000000000000000
> [    4.423921] Call trace:
> [    4.426362]  gpiod_direction_output+0x34/0x5c (P)
> [    4.431067]  gpiod_direction_output+0x18/0x5c (L)
> [    4.435771]  dspi_setup+0x220/0x334
> 
> Fixes: 9e264f3f85a5 ("spi: Replace all spi->chip_select and spi->cs_gpiod references with function call")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Sadly I do not reproduce this NULL pointer dereference. I also know from
hearsay that the GPIO consumer API is more or less NULL-tolerant. Could
you "make drivers/gpio/gpiolib.lst" and see what's at offsets 0x18 and
0x34 into gpiod_direction_output()? The first thing in that function is
the VALIDATE_DESC() macro, which does:

static int validate_desc(const struct gpio_desc *desc, const char *func)
{
	if (!desc)
		return 0;

	if (IS_ERR(desc)) {
		pr_warn("%s: invalid GPIO (errorpointer)\n", func);
		return PTR_ERR(desc);
	}

	return 1;
}

#define VALIDATE_DESC(desc) do { \
	int __valid = validate_desc(desc, __func__); \
	if (__valid <= 0) \
		return __valid; \
	} while (0)

