Return-Path: <linux-spi+bounces-5077-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CA098B7E6
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 11:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034531C2273A
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 09:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD2619CC1B;
	Tue,  1 Oct 2024 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=helene.moe header.i=@helene.moe header.b="O6MiPbSL"
X-Original-To: linux-spi@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EBE19D072
	for <linux-spi@vger.kernel.org>; Tue,  1 Oct 2024 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773615; cv=none; b=OI9IiFUm8PWIxH4mP0dIFLIRF0UtUgBMfbta89slFFh+M/gEvKtqe1JQ7D2XsTfFqtbbp43msx1v9tzoeitbfkAU7VpnVGp+PKj1eatodXSNcI+38fsvtO0Djgw5ZW6rILaxpMPBwLcXI4G1HsNsjVQaH3ISC0Ik8NXF7wV2pBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773615; c=relaxed/simple;
	bh=60kvU3f5rwL+N5NZfEw/fLwTrZWWJdK+QWDglVUKT4E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=AoOiqZ7ZSeAPmoCONqKctEEzo1T4QUDMsPo7yShQNvjaLASiPgVnPnqhN+3WZihMKUEF809rY6uYLXWkBzVjUaVApYbY+ldkXGl0P3hHuP0hAU3yIWh6JpwJJX06Uu1aFiJgj5WXxJaGz8wRKRFhas5wm2BxmbJpPWa7q9V5qmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=helene.moe; spf=pass smtp.mailfrom=helene.moe; dkim=pass (2048-bit key) header.d=helene.moe header.i=@helene.moe header.b=O6MiPbSL; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=helene.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=helene.moe
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=helene.moe; s=key1;
	t=1727773612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Zdv10SJzsReJ9cdAvKhNMK+4CSxsDOH1wiW7DwcRJU=;
	b=O6MiPbSL6N+4wvOtq6fDYRD5nneMzkq5R3ODanXsqIkxfje7mW1umGyEwwqXSzaSPW9ahp
	Ui9KT57n3axkifB34GHdZ0xQtIppAE/fdhT9+tEqQNBNwzXYW7JYqSBAggSRcoTGoWcxVV
	THchCpw4/K5KKKW2A6iHpB0l3MAZxV9D+Hytc17WHRIcFemIhsCwJelHHu1KCWV2seyMI3
	7NKiPjrrBM8tMFKvAYpWiDLY7o/sp56oFm54n5O3PjgF7IFr7SdQu4P21mKsIBKqHoiw1O
	zbn3ISnh/iGJ9arOSbHivu4elN4NbcVbUbFKsAgjcon6l4JFg/iGM0PJyKByaA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Oct 2024 11:06:49 +0200
Message-Id: <D4KCMMJN9ED4.1L7FRSI7NHU7C@helene.moe>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?utf-8?q?H=C3=A9l=C3=A8ne_Vulquin?= <oss@helene.moe>
To: "Dragan Simic" <dsimic@manjaro.org>, <linux-spi@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>
Cc: <broonie@kernel.org>, <heiko@sntech.de>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] spi: rockchip: Use dev_{err,warn}_probe() in the
 probe path
References: <cover.1727601608.git.dsimic@manjaro.org>
 <5b6bd142dab3ab93d7039db3e2fdcfea6bee2217.1727601608.git.dsimic@manjaro.org>
In-Reply-To: <5b6bd142dab3ab93d7039db3e2fdcfea6bee2217.1727601608.git.dsimic@manjaro.org>
X-Migadu-Flow: FLOW_OUT

On Sun Sep 29, 2024 at 11:21 AM CEST, Dragan Simic wrote:
> Use function dev_err_probe() in the probe path instead of dev_err() where
> appropriate, to make the code a bit more uniform and compact.  Use the ne=
w
> function dev_warn_probe() to improve error handling for the TX and RX DMA
> channel requests, which are actually optional, and tweak the logged warni=
ngs
> a bit to additionally describe their optional nature.
>
> Previously, deferred requests for the TX and RX DMA channels produced no
> debug messages, and the final error messages didn't include the error cod=
es,
> which are all highly useful when debugging permanently failed DMA channel
> requests, such as when the required drivers aren't enabled.
>
> Suggested-by: H=C3=A9lene Vulquin <oss@helene.moe>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

I can now see appropriate messages for pending probes on Rockchip SPI
devices, instead of "(reason unknown)", which is incredibly helpful
for debugging DeviceTrees and kernel configs.

Tested on 6.11 and looks like it works as intended.

Thank you for this patch!

Tested-by: H=C3=A9l=C3=A8ne Vulquin <oss@helene.moe>

