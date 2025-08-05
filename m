Return-Path: <linux-spi+bounces-9284-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD259B1AF7B
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 09:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E043B0175
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 07:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E87F1D5AB7;
	Tue,  5 Aug 2025 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d5fdpwAk"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC68A3234
	for <linux-spi@vger.kernel.org>; Tue,  5 Aug 2025 07:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754379696; cv=none; b=FBparF9UfuvAPvIGh41wNefW+VwBQm6kCMehJY3bxESiLmgUbPtVziMsIyZy/hMJ6Q4K0iCwxFtC8RO3Xca48AqHcSJpT5zgHSxSgthL5xFpo8j3ktrMD6C3YtyPyQ4L9adcmEIZICHtNG+YW6VE0TyILJgq1Hmz6IuqD6079vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754379696; c=relaxed/simple;
	bh=VbiIMj938tUa1mZQFX/VZ8OhpKv5RTlGxLI5Glq6c88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ddencARs+u0Xp5XsGuZ0KK2pKmPU2AOUJVHIJc+XdW+Ob1VGWJw1Cjj+SzcSTBj9MaJfbVcvpyx/bRfBG4jp/oy3wvBCXDSWO93FPiI05PJvZwO0Ho2QEolvUrTLsYobLsCzZRxMjugNVq9oY6PAp0tYDssbNAm+lnU5oRzVYYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d5fdpwAk; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F25A744333;
	Tue,  5 Aug 2025 07:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754379687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbiIMj938tUa1mZQFX/VZ8OhpKv5RTlGxLI5Glq6c88=;
	b=d5fdpwAkZQvHoELp2d+SOimVJhkQwqAa9Qwc7oCyP+fiEz8B0DJSeQj7/LVT+3UiT15GFJ
	QU6quqivpYfYLKEffETxdGqm6DohTX0ZH14HmpaGKA8hfJbJ0iEGnOWqX3vwDF+n0WXrOZ
	h6c7E9sHZpAvpSO3Vd6DzUBPcpANtToRyfrXs+fKlkQB2c4GJYmWrUbtLTE2N40a/FGX5t
	pv1oyuXZqm/NE+3w5BxDvWjNHslvpxrnR/800q/0C5n2cfKA9Ob1MVjHYM42/853sIIt2C
	2+yX9Ak5THXBtLriNBcsAZbOGUgnjVm07jVDxdJ0GWkMYAJ87rRuEep8fyY2hg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tianyu Xu <xtydtc@gmail.com>
Cc: broonie@kernel.org,  linux-spi@vger.kernel.org,  Tianyu Xu
 <tianyxu@cisco.com>
Subject: Re: [PATCH] spi: spi-mem: add spi_mem_adjust_op_freq() in
 spi_mem_supports_op()
In-Reply-To: <20250805015403.43928-1-tianyxu@cisco.com> (Tianyu Xu's message
	of "Tue, 5 Aug 2025 09:54:03 +0800")
References: <20250805015403.43928-1-tianyxu@cisco.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 05 Aug 2025 09:41:26 +0200
Message-ID: <8734a6jjvd.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudegiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepgihthiguthgtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtihgrnhihgihusegtihhstghordgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 05/08/2025 at 09:54:03 +08, Tianyu Xu <xtydtc@gmail.com> wrote:

> The function spi_mem_adjust_op_freq() within spi_mem_exec_op() adjusts
> the op->max_freq, which will informs the SPI controller of the maximum
> frequency for each operation. This adjustment is based on combined
> information from the SPI device and the board's wiring conditions.
> Similarly, spi_mem_supports_op() will check the capabilities of the SPI
> controller. It also requires the combined information before it can
> accurately determine whether the SPI controller supports a given operatio=
n.
>
> Signed-off-by: Tianyu Xu <tianyxu@cisco.com>

That's correct.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

