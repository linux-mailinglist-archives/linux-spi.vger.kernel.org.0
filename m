Return-Path: <linux-spi+bounces-4205-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ACA955EAA
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 21:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E471C20A90
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A998314A0B7;
	Sun, 18 Aug 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sWPyq25Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC30131E38;
	Sun, 18 Aug 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724008854; cv=none; b=Lh/yX5EmjjMFt95x+N0uHkbu8l9nKNclZurGJiVcr9KV0NA6C+KFqKR+9H2g/aaEGqiIGbgXkav4oIyBstydgrsEbNML3ROM8cVlFiX0Te6n6kgC4eftciQcX56N4gIkMk5Ok/7yOOkkXCxnvjdSk45Tuu2tQcf9K6uFp58oyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724008854; c=relaxed/simple;
	bh=iT7ZB0BVgedL4KPGPYkgafH9dBsAKWURIwy7vufCBMk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iJmsuGvM2y7/4VmPWaDV12YJPvNNREfox8OvE16yAab5k3dAN2XhYElTQ3QfdLoiXAFNOCST+fs1D4Hb8NG8+Cv1Abvbz9jayMOzQxja6LU/AbGbIe1XlrE3FRXfDoND/DalLnzVDNjj6DxQT+30Tp1EFZ8FdzOgTc4L385FCgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sWPyq25Y; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724008849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDcEJib7h92TKx63rrBQ2WzPLHrWX9q84fsh1Pm7bec=;
	b=sWPyq25Y/xptKuZdiTSpBNHBhcsGtUAMfJUASa4VBLPhh0/R6N7U3dP87RA6jls1xx4gd7
	6frBVa2FDXrGKu/NaVq8IpA4TF3aWVVQ9QgKwVUc+Y3yJzLGmvPCVEKUwQacVujU3elGU9
	I0XMX28PqK++HvE3zDIYceu+DYHEq7J4DhfsEk9RjEd7aZ3RaL/11j8FCYx4ttFuGHh91b
	EgoNigXSXi1zQHLaRwUKFEZ5blVEUCRH0EcRzw6jOpWg6uZ8A/LsiLqU3Jns+JBvG7diQd
	83e/p/gH7NYS3+Mvabr6EZYws6jbwVa4cUwwW61wr8PXv3/pWQZCs3IuBZGCuQ==
Date: Sun, 18 Aug 2024 21:20:49 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Vicente Bergas <vicencb@gmail.com>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Rockchip SPI: Runtime PM usage count underflow!
In-Reply-To: <CAAMcf8CFED71FKUBpRy+FZNf8XKim1fuxW1C+ErZQqLsaWm1yQ@mail.gmail.com>
References: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
 <d35a5c5216ee3d0321c725aea61e0326@manjaro.org>
 <CAAMcf8CFED71FKUBpRy+FZNf8XKim1fuxW1C+ErZQqLsaWm1yQ@mail.gmail.com>
Message-ID: <4455b5175d3c372c15d9732f03b9eb20@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-18 20:55, Vicente Bergas wrote:
> On Sun, Aug 18, 2024 at 8:26 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-08-18 20:13, Vicente Bergas wrote:
>> > i am a user of the CONFIG_SPI_SPIDEV device.
>> > It stopped working between 6.8 and 6.10.5.
>> > The SPI bus itself reports no errors to userspace, but no devices
>> > appear connected to the bus.
>> > The platform used is RK3328.
>> > The only spi-related message in dmesg is:
>> > rockchip-spi ff190000.spi: Runtime PM usage count underflow!
>> 
>> I'm working on a related patch.  Could you, please, describe your
>> use case for the spidev driver, i.e. what board are you using it on,
>> and for what purpose?
> 
> The board is ROCK64 and the purpose is to update all the software that
> board runs, which is stored on the SPI NOR flash onboard.

So, if I got it right, you boot your Rock64 from the SPI chip that
contains all the software it runs, but you also boot Linux on it from
a microSD card, to update the contents of the SPI chip?  I'm guessing
it that way, because the size of an SPI chip is hardly large enough
for storing even an extremely size-optimized Linux system.

Anyway, I wonder why do you have to use the spidev driver for that
purpose?  Why can't you use 'compatible = "jedec,spi-nor";' to access
the SPI chip through /dev/mtd0 under Linux?

> I have not tested this kernel version on RK3399, but it may also
> affect that other use case:
> https://gitlab.com/vicencb/kevinboot
> 
> N.B.: My name is Vicente.

Oh, I'm sorry for mistyping your first name.  Should've copy & pasted
it instead, to prevent such typing mistakes.

