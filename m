Return-Path: <linux-spi+bounces-12360-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D25CD1D555
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 10:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51D923014D54
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA3D381715;
	Wed, 14 Jan 2026 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuNa2oNa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30C3803D2;
	Wed, 14 Jan 2026 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381209; cv=none; b=T/vWiS+QWpueSVFX4KOhXq7k6zhp027YfDhPVHLr42dqeasnYF1mmysqTD6fdogmzDWUwwJU0nKxS1REde7/u1VKDbCpZNkWFiQ+UxB7vfV6N74Q8YaEmn6jVEVfzXbFH8VEEoeQZd13XvTOgEQikLUWYGuUTLEJxpAc3YVL/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381209; c=relaxed/simple;
	bh=cMA2KZasj9r0FQVnNn9r02j58aCYrjJl3jl/KgqA7M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTTNDuNM97RLVnATsnYgjEB9eW+KFu6ybNQ6XvWgBQ2+PV51MMWr1UkNN5jydqzjMohja/VXWFOTdE4CKfuU7PF+lfJOPg/atmXqibfu1D5X/8m2QmbWxfo44dDbjh6OQy3SoB5HPJEb2fhRL5waji0gFNWb6NAb6aYFKh8XtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuNa2oNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945EBC4CEF7;
	Wed, 14 Jan 2026 09:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768381209;
	bh=cMA2KZasj9r0FQVnNn9r02j58aCYrjJl3jl/KgqA7M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SuNa2oNauyr+ScYJaHb2S1v4DJxGFZTR0WEmaD6W7Sz7wSs6lXrRCytqj3CZJjm0M
	 1Gyo8KJ9JRwfIWNptp1FxJ4L9KYoOvl7QuDHmXKbU+xjiJd7IcXZyoalteTcy+fEvJ
	 g/5nUYP3zcVO69OKsGsADDrAjgUJvcdMMKvcInPk9J++2TOAnX/12oDHjRlo6EDYkm
	 /5+6REsrX5NBlpt7uCUefSV8Qmh4oqBJVbhJfh3U5yhifjzlqrLc+ffcay1bDdkm/o
	 Rg60ayJvZvG+dogQUPk6p7sVsN7sDLnlDIVepvxGj6yKz/bsRocXrM2oJWi9Izbvtu
	 0dPFLjdTOTHbw==
Date: Wed, 14 Jan 2026 10:00:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org, dmitry.baryshkov@oss.qualcomm.com, 
	andersson@kernel.org, bjorn.andersson@oss.qualcomm.com, 
	prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com, quic_vtanuku@quicinc.com, 
	aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
Subject: Re: [PATCH v1 0/4] Enable SPI on SA8255p Qualcomm platforms
Message-ID: <20260114-truthful-just-boobook-16494b@quoll>
References: <20260112190134.1526646-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260112190134.1526646-1-praveen.talari@oss.qualcomm.com>

On Tue, Jan 13, 2026 at 12:31:30AM +0530, Praveen Talari wrote:
> The Qualcomm automotive SA8255p SoC relies on firmware to configure
> platform resources, including clocks, interconnects and TLMM.
> The driver requests resources operations over SCMI using power
> and performance protocols.
> 
> The SCMI power protocol enables or disables resources like clocks,
> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
> such as resume/suspend, to control power states(on/off).
> 
> The SCMI performance protocol manages SPI frequency, with each
> frequency rate represented by a performance level. The driver uses
> geni_se_set_perf_opp() API to request the desired frequency rate.
> 
> As part of geni_se_set_perf_opp(), the OPP for the requested frequency
> is obtained using dev_pm_opp_find_freq_floor() and the performance
> level is set using dev_pm_opp_set_opp().
> 
> Dependencies:
> This series depends on Enable I2C on SA8255p Qualcomm platforms
> https://lore.kernel.org/all/20260112104722.591521-1-praveen.talari@oss.qualcomm.com/

It should not because it means it cannot be easily applied by
maintainers.

Why can't you decouple the dependencies?

Best regards,
Krzysztof


