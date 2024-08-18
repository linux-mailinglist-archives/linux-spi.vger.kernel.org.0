Return-Path: <linux-spi+bounces-4203-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3490955E83
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 20:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425C92814C0
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2024 18:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD56F139580;
	Sun, 18 Aug 2024 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aTVvCkqy"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5983B67A;
	Sun, 18 Aug 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724005610; cv=none; b=KtsuC93szYhXPEgyYM/fkPUdwRuiIcynOSbwwKo27Rq6Ef+nZJzw6S8ahdismYqqCKdLmXyB8O0OVGTmn/45KPq4QjQMjUaFfCNNRmJ0zm8nvj77yunTEo02JZE/L1jisF+4N7dYKYNw1etEtDLOSTAh/3tV+W8NbqcIG6biO7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724005610; c=relaxed/simple;
	bh=tZssPprq3tdSn2ygW0rI9Glne6UKWSz/pQ2Ea/xM8f8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DwPOtb6RQB/HAiLq9au1neOMSgFz3h+oFHAcQINlwkkbUo9L3twWX8TR2h5wkXLwnHNTiXSksOy4TlMoOFLu35W4v0QQgZM8LWsLk3tkAtGxNIbLHMcKJf2x/UoEGXnYoPMDSJ7perf7VvNNbeMquYpLEnyfnTOHD34NJaJxZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aTVvCkqy; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724005599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUUDK9X8hK9InhC5RnU5PQG5JxYBI/T1toljnxF4aqo=;
	b=aTVvCkqy7jGQDw1zxlBK7UJR/oh/B0E9wwaq4kc8wOAqTIzby3WhxODCTXHX6e9xgq2WOl
	eewlge5SRL73Sz8wv7GBmku5i2OjnmvQ1lXkmHuCClUQoT+t23mRnHOcfRECTEKgOSF7L3
	2RffuKT5D2DQH1mYE/CCeawsg0V4gtTnerCdjTQNRnHOdY1f4tQNBpDeIEj+ROfXPpQDTP
	xrZO29WfQHJSzwFf2OWUjZMKHTlpG60P34u4WNgBBXiUH84I6dFPTpKbA0vMQMqSIiJ+Jm
	OjcLCi+fe97Fnt9Yte5nsBDZx5R3nvjM97/KBWaBGjYWx6HRzKh1ptfLkQW/ZQ==
Date: Sun, 18 Aug 2024 20:26:38 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Vicente Bergas <vicencb@gmail.com>
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Rockchip SPI: Runtime PM usage count underflow!
In-Reply-To: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
References: <CAAMcf8Dts3=6CxNCLZBvXsdFHpaOs9mL2NJ8TMPU5+duray6-g@mail.gmail.com>
Message-ID: <d35a5c5216ee3d0321c725aea61e0326@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Vincente,

On 2024-08-18 20:13, Vicente Bergas wrote:
> i am a user of the CONFIG_SPI_SPIDEV device.
> It stopped working between 6.8 and 6.10.5.
> The SPI bus itself reports no errors to userspace, but no devices
> appear connected to the bus.
> The platform used is RK3328.
> The only spi-related message in dmesg is:
> rockchip-spi ff190000.spi: Runtime PM usage count underflow!

I'm working on a related patch.  Could you, please, describe your
use case for the spidev driver, i.e. what board are you using it on,
and for what purpose?

