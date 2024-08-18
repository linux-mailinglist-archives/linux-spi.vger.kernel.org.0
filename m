Return-Path: <linux-spi+bounces-4207-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 275BB955EE6
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 22:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5008F1C209B8
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AACC14AD3F;
	Sun, 18 Aug 2024 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="V6jLkkeQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D2BE65;
	Sun, 18 Aug 2024 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724012769; cv=none; b=SHbzrkScS9gxvGpPSKOtj2wektbBqfCP1PduxMgGlmRa2qbWufmsbPiwhBDCcKNk/D7paaGbbpEdaQ+aNz5qb6GhhE1FjfPjtW2QpXBh/UiuttsiHbjOJRkwH5GOb8rlENTGRl4XbSFtYk8ETG3TLgMnqrpKJmFuSv9ZAKdmQEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724012769; c=relaxed/simple;
	bh=Nl30EEkHa8Nm1Yw2QyG6scgBsHgaSd+oX8FXE9X8iV0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nA9OIrkhgEET+RJ9Lflj/jMMGFysMxP85PuOcjAmji5I2yphuqgotYfHRKQRgN6hZWZMirTW2Eo4RKJk29q8LdlaKerrLKxDWeDfA66iXqGBSIS9bJmIsWXLNH65cehxzVnkp7j+dVdQWkH5kIe8ebuxwyjiRCg/gBkwp1Zh+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=V6jLkkeQ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724012764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoF+vbchm17LMfasv0YbGns6ehOlp2E0hnsjTQ7EaHg=;
	b=V6jLkkeQuGWSmeFNRiuW2DjUeJl1EXtcalhwzICuy4nk9Y/aE5uajMMzQpvlDDAarDSxWv
	PgqOnIGlIt3lh26j7ENfczvzcsWXwPjAdIbxj4on+sna1MZIaxFfDm+1IvPgSKmmlvieGm
	7hXMpRjQGEfK8XpWARWTAAr2YU7EMcnlFGiPv4UNAto0PcG1QWb66K1uWRfRPnu5cUoyaG
	m79uLxHPdFMpNbWfiAqsI06droltmBei5iJYtpgrWLsQGwY8NVkxOyDhkieKSnrxRR6Yfw
	sdSP+vdEnpUXVfH7X3LBwt8W+gL/gVROptGdNdRlIYhjGdozTwuAn2WgKF1Z3A==
Date: Sun, 18 Aug 2024 22:26:03 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Vicente Bergas <vicencb@gmail.com>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Rockchip SPI: Runtime PM usage count underflow!
In-Reply-To: <CAAMcf8CpkZHY6Awyo3LWZXfkqbZ1z3YcvF5W_08uv-XNov2j-A@mail.gmail.com>
References: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
 <d35a5c5216ee3d0321c725aea61e0326@manjaro.org>
 <CAAMcf8CFED71FKUBpRy+FZNf8XKim1fuxW1C+ErZQqLsaWm1yQ@mail.gmail.com>
 <4455b5175d3c372c15d9732f03b9eb20@manjaro.org>
 <CAAMcf8CpkZHY6Awyo3LWZXfkqbZ1z3YcvF5W_08uv-XNov2j-A@mail.gmail.com>
Message-ID: <58bcd9fad47377e4ccf203b3f11caf21@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-18 22:10, Vicente Bergas wrote:
> On Sun, Aug 18, 2024 at 9:20 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-08-18 20:55, Vicente Bergas wrote:
>> > On Sun, Aug 18, 2024 at 8:26 PM Dragan Simic <dsimic@manjaro.org>
>> > wrote:
>> >> On 2024-08-18 20:13, Vicente Bergas wrote:
>> >> > i am a user of the CONFIG_SPI_SPIDEV device.
>> >> > It stopped working between 6.8 and 6.10.5.
>> >> > The SPI bus itself reports no errors to userspace, but no devices
>> >> > appear connected to the bus.
>> >> > The platform used is RK3328.
>> >> > The only spi-related message in dmesg is:
>> >> > rockchip-spi ff190000.spi: Runtime PM usage count underflow!
>> >>
>> >> I'm working on a related patch.  Could you, please, describe your
>> >> use case for the spidev driver, i.e. what board are you using it on,
>> >> and for what purpose?
>> >
>> > The board is ROCK64 and the purpose is to update all the software that
>> > board runs, which is stored on the SPI NOR flash onboard.
>> 
>> So, if I got it right, you boot your Rock64 from the SPI chip that
>> contains all the software it runs, but you also boot Linux on it from
> 
> correct
> 
>> a microSD card, to update the contents of the SPI chip?  I'm guessing
>> it that way, because the size of an SPI chip is hardly large enough
>> for storing even an extremely size-optimized Linux system.
> 
> No, everything is in the SPI NOR flash, which is 16MB in size and it
> is enough for my application.

Thanks for the clarification.

>> Anyway, I wonder why do you have to use the spidev driver for that
>> purpose?  Why can't you use 'compatible = "jedec,spi-nor";' to access
>> the SPI chip through /dev/mtd0 under Linux?
> 
> The bug report is about the SPI bus, MTD is a service provided on top
> of the SPI bus.
> If the bus fails, then there is no MTD.
> That said, i don't use MTD. The bootloader reads the kernel, dtb and
> initramfs from the SPI flash into RAM and boots linux entirely on RAM.
> There is no persistent filesystem on top of MTD.

Alright, but you wrote initially that you use CONFIG_SPI_SPIDEV,
which means that use the spidev driver, and you also wrote that it
has stopped working.  All that meant to me that the spidev driver
no longer works for you, which is somewhat known issue.

Anyway, please let me know are the following directories present
on your Rock64 running the troublesome version of Linux kernel,
presumably 6.10.5, and if they are, please send over the listings
of their contents:

   - /sys/bus/spi
   - /sys/bus/spi/devices
   - /sys/bus/spi/drivers

>> > I have not tested this kernel version on RK3399, but it may also
>> > affect that other use case:
>> > https://gitlab.com/vicencb/kevinboot

