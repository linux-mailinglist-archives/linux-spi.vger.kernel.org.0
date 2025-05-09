Return-Path: <linux-spi+bounces-8046-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE231AB1BCB
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 19:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32082189A454
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43DD22F762;
	Fri,  9 May 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYPeF2e0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42DA8F77;
	Fri,  9 May 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746813181; cv=none; b=svWh925hHO0Gj3jxjxTnVltSXmU1HpGAIdPBqdeP9WYaGQWgPY2aByVJrqYpJkD2AFZ91bGfM5F/CLP2j/+k5akJzbg9YX8QNYPMqLusSyB2IvuCb6qVHGRO4ze5U8Cki5G2xglGR+gMEbuTzz6gqk8wsccNrsJk3M2A7J8nfD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746813181; c=relaxed/simple;
	bh=6qh1kpnXLhGMK5fFZMLx3nG4DbkRsQh2PkGfLRM08jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSbPlx+G8yCvWQksQNCiOJG+PnWc6lWyo67V5qBHZ2R1g1QzZTLRu/Zm1wV95YBOnWV/ny8cWbkXkypf1Z8V0geJNnuIu6QTRCHtLMBx4cMkGUu/s3EGfolv4GjOJIJNoeu13oVz5ps8M1ibojzccKtluHDwamimzn9cIxJQmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYPeF2e0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130EAC4CEE4;
	Fri,  9 May 2025 17:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746813181;
	bh=6qh1kpnXLhGMK5fFZMLx3nG4DbkRsQh2PkGfLRM08jc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KYPeF2e0gaLptqc4TD5jJFiiJApK2N29J/F9skd2/lbr9V/xtudvVuAtBvZwMZEsR
	 epdEd0Z3cvVwQjZ4ibniWOqrqlMMI1IBcJVNL66bzS3REij573mONEd80UkJj/UgEr
	 Q/MyJV66SUD/Fv0tr35XuNnEKpWINS/TJlM4db1LF7d81J78SgTBueme7A4bjLobFc
	 K1buvIaWFUeeUdCKeheCUflx47ZXaqX8rTS3M0HIEh3qqsu/ToMV2fl9O0guWAAsgR
	 VWWlLcnKhlWoajmnX2EpiOC7GemMQs0SC3LA3eHsf0GXcaek9ClBk373s8xABFcFeV
	 l2Mhsm+b7jfZw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6066c02cd92so1190782eaf.2;
        Fri, 09 May 2025 10:53:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuE7eevhVbmiuMhf5Mw1f3L+zwiiM33p4y1qZ74NMYomCgqL1cIVVtXM6oN34l3P0LN6sZaq6siXo9@vger.kernel.org, AJvYcCWjGclyX7yyzD/jCa/5l+UL9/V/JI/ASyoCKwbyQBRZMlRgDqPpTqxjkr6nngAD3hgc0U8OUMTd1cU=@vger.kernel.org, AJvYcCX0F9TtlZ0cCbLQTzaB2VmLCjFaiSC4IrIm/Z1fVzXbtO2HIJ1lo93hHn/buaE0Nf3vhqrac7UAijHWpIA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/l0yf6SqQHrdBcqbIARzrpikJIMd682+rUI4kBQ04n3ipBvd2
	9E7IYu0vHqeu7bJDWnwzyrtxkLVwZxjwPTid8pUxmAV6eDzHS1v+9kW7eyutpxQtLfKfbWkH6GU
	83HEdSSxFFbq8ZSbVc8bHWJtx1GI=
X-Google-Smtp-Source: AGHT+IGqAO1NwmX9K8B2d4bnSZvF3kh1DOuKLKUj/nnztQbKYPB12Z3r1lDGWnb1JX+dVefpvJ5WcHa5xsOcVI9pvtU=
X-Received: by 2002:a4a:e849:0:b0:606:42b7:2b02 with SMTP id
 006d021491bc7-6084b648663mr2808550eaf.3.1746813180338; Fri, 09 May 2025
 10:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327195928.680771-2-csokas.bence@prolan.hu>
 <20250327195928.680771-3-csokas.bence@prolan.hu> <CAJZ5v0jmuzvo-xzGBDhGVBbY7svbrqEdi-SeJrx5BG=qtN6ZiQ@mail.gmail.com>
 <b38b27d4-c3d3-450c-8634-2e07f393a76c@prolan.hu> <CAJZ5v0hRsXw45utNMEhLB=i56tsJDz8AvYfV2stPbtRHh09HUg@mail.gmail.com>
 <8dadb7ae-1a7d-48d4-8dbd-40f6d9f35a6d@prolan.hu>
In-Reply-To: <8dadb7ae-1a7d-48d4-8dbd-40f6d9f35a6d@prolan.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 19:52:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hNb8eB2tAig1BiUMHLQ3JRak3EXFid9qmHz6iWvh5q6g@mail.gmail.com>
X-Gm-Features: ATxdqUHjSbCmShDsuftLa5CYrYbxG7uxRqBhgdr3aU8tmqrjuRy1EMqjspyvarY
Message-ID: <CAJZ5v0hNb8eB2tAig1BiUMHLQ3JRak3EXFid9qmHz6iWvh5q6g@mail.gmail.com>
Subject: [GIT TAG] Power management (runtime PM) change for 6.16
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
	Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Varshini Rajendran <varshini.rajendran@microchip.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	linux-spi <linux-spi@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexander Dahl <ada@thorsis.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Pavel Machek <pavel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The tag

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
pm-runtime-devm-6.16

with top-most commit 73db799bf5efc5a04654bb3ff6c9bf63a0dfa473

 PM: runtime: Add new devm functions

on top of commit b4432656b36e5cc1d50a1f2dc15357543add530e

 Linux 6.15-rc4

is available to pull from to receive a power management (runtime PM)
change for 6.16.

It adds new devm functions for setting runtime PM status to "active"
and incrementing runtime PM usage counter (Bence Cs=C3=B3k=C3=A1s).

Thanks!

