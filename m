Return-Path: <linux-spi+bounces-5157-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576F99955D9
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 19:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E331C25912
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F6120ADC1;
	Tue,  8 Oct 2024 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="noA4dJNN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A192520A5F9;
	Tue,  8 Oct 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409159; cv=none; b=D4diJTAdcSgTIaPCaakGt6/bxBtsmfTme2GoM/jJqffOkQ/KRroTo8uYjMAkJ80U8h0aIUQvB+dt0X+0XAUw0P68cF4Eyi42TUW6U+6RJtdDgyJoGPlc6o0auv3mE191OGXDYgTYCX+yo3wWAzYRnMsFa58PQEiGAvPteppxQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409159; c=relaxed/simple;
	bh=XEj3MXDNUlGU+Af3xEzffs5dVVKvxLbFiujuBxwl9l0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YFQFrDjcQttKgCBajlUiJfp2kIA4x31yEk6vlY/e/ZKAnJ+jaQu/Na7Kkt6IpQrzF2cixeipjHsl1+0Qln4/yMiNfoPbReqr173zkVSDZqPde3ZeWf2p4nKJeo2vxGyDNFyhoDOkHEyaiw6FlULd2EqBY/JrQHryS/Ghsk0JxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=noA4dJNN; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728409155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZsidljDWtyKSane1C8SV1rPYQ+1l87LCw+63NyRBwg=;
	b=noA4dJNNn5cf24GL/9sON9/hJOzukzJTU8aVleFwHelvpF0dUGq9dt2/Xtk4fEB+P+Ffsx
	Fq35/O5Fr1zoWPQthX66JuCSlsSQTBlzPifDTavezxdqJ71iQq6gJA3f7SfHiXYX7AJklL
	f8fRJzKTb+uEz8o96AHlp35GwsMFyja6aRbtJQOzPf5CNXr2TJF/5uM+D1q0uLEifV2xtr
	gYQxoAlUbS+rJcSLef1LJga6OV5Wtc8zAb8AoDrX4Ol8X8S18wnexD380tfr/IZpIkMAVJ
	PxM3KgEojtK8OLGsdEaLFJ76QmWPDTyGoF7oKL90BYPgKazAP4Ek4ZeuY7NhwQ==
Date: Tue, 08 Oct 2024 19:39:15 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org,
 heiko@sntech.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 oss@helene.moe, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] driver core: Add device probe log helper
 dev_warn_probe()
In-Reply-To: <ZwVt9e44jc3CQaV1@finisterre.sirena.org.uk>
References: <cover.1727601608.git.dsimic@manjaro.org>
 <2be0a28538bb2a3d1bcc91e2ca1f2d0dc09146d9.1727601608.git.dsimic@manjaro.org>
 <e8cbbf877cc0e6838afd2d6de3b7bfa1@manjaro.org>
 <ZwVlE9bgHYNT8J7J@finisterre.sirena.org.uk>
 <c4a72fcf91b30a8eae2fff851f01d10a@manjaro.org>
 <ZwVt9e44jc3CQaV1@finisterre.sirena.org.uk>
Message-ID: <3cb0eac87320587dd246c82e2d614119@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-10-08 19:37, Mark Brown wrote:
> On Tue, Oct 08, 2024 at 07:32:18PM +0200, Dragan Simic wrote:
> 
>> No worries.  I just sent the incremental patch, [1] please have a 
>> look.
>> Thanks for merging this patch series!
> 
> Oh, sorry - actually now I look again I got this confused with another
> patch and it's still in my CI so I can actually fix things up before
> merging.

Awesome, even better!

