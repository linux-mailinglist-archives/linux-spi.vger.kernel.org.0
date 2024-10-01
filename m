Return-Path: <linux-spi+bounces-5072-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDF698B215
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 04:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60E21F22301
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D406C848E;
	Tue,  1 Oct 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="qndyLruj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673B2CA2;
	Tue,  1 Oct 2024 02:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727749828; cv=none; b=CSbAlMO79omWUK84QuYi2mmLlbMeO7fxwUhb0N/U4JHrIZ3D1AYqxGZzoMhxlsgGJfm/N08w9P9/7jBSr2qhi6PqURnkG73fJgE3WrP7otdFi65JAEm7cpbSICg4lyE2J4gyVYa6iDz1w0gevylZA08Ai5a2BVVg2YZM+uOdCYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727749828; c=relaxed/simple;
	bh=pHtZdpH6E3OkWZne6jKOeKSBdeHF3dpFP2dAp2FNAdY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fip/8n2QZgPR0gojDEBpCLM9FzIspaW0iHeEX0yhA2L2b1aWq+Q7XO2XCBZ6dnAARST5lqq0Zu7NMIqE5H29QLsewl4Vm1YHuKVm5XWuUpBvS36azy9PfmuhJIzvsg+ljkcvTJZtksikz5XpSB8dyZ31lrxUkJHLPrjxdAcKurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=qndyLruj; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1727749817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pvkn9unYKg5jrQqXLz3IKj4eW4g7FS1Yw0ALAhtHSGI=;
	b=qndyLrujoJpXhrA3PsDJWmA2Mn5Jupk9HKInMqWbJFm7SNH2FUWsZbsKtwAdnm7X+gv9xN
	irTXR+w+OXHKApotKB0mrNBM/KhtMxzuApUBe72+kJjTP77c/t+Zn339vsSkq0xYGCxWWx
	x8PbXOuTw/JJ4h23ml5IQP4Jd8s3+LGKFDs32Exgsq/1DqHMUhsvntCoe84sZziW+5/y0f
	KL+62oseiCSsWqkM8oijpjjt5OXyKjFBEB8nrf2diRU194PJbAz4eiV9/k7YIsL79tNed7
	dXgzlVWrLE00DFt6Wq69Xp5Tam8neqR9Mz6WS8r/bV+nFV2GbAZQGiYkUbP4Tg==
Date: Tue, 01 Oct 2024 04:30:17 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-rockchip@lists.infradead.org, heiko@sntech.de, oss@helene.moe,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/5] Improve error handling in Rockchip SPI
 drivers
In-Reply-To: <D4K14E2EOSC6.1VYBGSQKSIRW1@cknow.org>
References: <cover.1727337732.git.dsimic@manjaro.org>
 <172774028424.2264837.4595727034314147956.b4-ty@kernel.org>
 <D4K14E2EOSC6.1VYBGSQKSIRW1@cknow.org>
Message-ID: <c69fef216b1a2474bbab1a146ec63450@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Diederik and Mark,

On 2024-10-01 02:05, Diederik de Haas wrote:
> On Tue Oct 1, 2024 at 1:51 AM CEST, Mark Brown wrote:
>> On Thu, 26 Sep 2024 10:38:11 +0200, Dragan Simic wrote:
>> > This is a small series that improves error handling in the probe path
>> > of the Rockchip SPI drivers, by using dev_err_probe() properly in multiple
>> > places.  It also removes one unnecessary check of a function return value,
>> > and performs a bunch of small, rather trivial code cleanups, to make the
>> > code neater and a bit easier to read.
>> >
>> > Dragan Simic (5):
>> >   spi: rockchip: Perform trivial code cleanups
>> >   spi: rockchip-sfc: Perform trivial code cleanups
>> >   spi: rockchip: Don't check for failed get_fifo_len()
>> >   spi: rockchip: Use dev_err_probe() in the probe path
>> >   spi: rockchip-sfc: Use dev_err_probe() in the probe path
>> >
>> > [...]
>> 
>> Applied to
>> 
>>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 
>> for-next

Thanks for applying a subset of the patches!

>> [1/5] spi: rockchip: Perform trivial code cleanups
>>       commit: d87ec94e48dd2da27fbe948f2dc6c8fedc98fff4
>> [2/5] spi: rockchip-sfc: Perform trivial code cleanups
>>       commit: 6c510eac1528d8939bad8b6df72c7b23ffec8c25
>> [5/5] spi: rockchip-sfc: Use dev_err_probe() in the probe path
>>       commit: 1482c40b440fa58f956bc3e1ef3426e0cdbc09e0
> 
> It looks like you applied some patches from v1 of this series while the
> current version is v3.
> 
> https://lore.kernel.org/linux-rockchip/cover.1727601608.git.dsimic@manjaro.org/

Just checked this by hand, and the three patches that were applied
are the same as the respective patches from the v3 of the series,
albeit being picked from the v1 of the series.  It's just that the
patch 5/5 from the v1 became patch 3/5 in the v3, which pushed the
patches with no dependencies earlier within the series.

