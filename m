Return-Path: <linux-spi+bounces-9851-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21CBB3FA24
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 11:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5474E170F
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8A02EA15E;
	Tue,  2 Sep 2025 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFs5Qbbh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB6E2EA147;
	Tue,  2 Sep 2025 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804933; cv=none; b=XvaxVNYZjIuJMKMwrcl4osBbavDu+EMhoWjua79dSMHRYhA5JtMFQXyR3znICUVQuro+xgsHbV3RVb5fSlr9Giv4w5uy0Vy7Tnke42xcZs9OsV+3tkNZiJF/Aa5egVAY66S2xcQIQxJK6lxC0cY9QShLGzM7Norst9YRJ6rTGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804933; c=relaxed/simple;
	bh=rM31RXJJr6DeW9yhEfdBtfaLiZoooERixCvWjFfrTO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STbssmEfRJi3Frk/za5NnJCLiG9p239Yywu2ziFa1X1nX4E5OiSK1u6UGf6z+RGxpRs+AKGhRlSiICIrjQyjj2yXKVst8Yr6frrobgdqJumrGSa1afHHN+DQjuYGRB03bX0+75XgDJRd8Don+1EI2uvfDJzkEulPjOU6cMpQ6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFs5Qbbh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAACC4CEF8;
	Tue,  2 Sep 2025 09:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756804932;
	bh=rM31RXJJr6DeW9yhEfdBtfaLiZoooERixCvWjFfrTO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFs5QbbhMSDnCPFllEOadz1HJ5RLmSZgvrHM6+FBoqxAKE3DC++1XAnYAVcL0q8+u
	 YEG9fDdTvAkqAPxUggQQ44F7UB2vwgVH2ZyBfGgVPK0IzBqoUJlVviInMT91Gysrrk
	 zBSX58E0phh6b8KfF0XLCW8JoKPo7exvSLev/rMUT1yj8ddl3VQrTuLITvCTYW9ASR
	 J1AQ6qYEJ9DdrHu5SbO2SMPhIuA3ZhIA0keW/g6sxCtkCqAyIS99YcDWDu06I6x0Oc
	 hxHqeA09d6STD4rN5IGYrm2PkP7XoPlsU0ZT5WvlVq8a4q/vZrI789crFGmkw8+9kz
	 94L3haWzPupMg==
Date: Tue, 2 Sep 2025 11:22:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: atmel,quadspi: Document sam9x7 QSPI
Message-ID: <20250902-bulky-chachalaca-of-superiority-d5caaf@kuoka>
References: <20250902-microchip-qspi-v1-0-37af59a0406a@microchip.com>
 <20250902-microchip-qspi-v1-1-37af59a0406a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902-microchip-qspi-v1-1-37af59a0406a@microchip.com>

On Tue, Sep 02, 2025 at 11:22:18AM +0530, Dharma Balasubiramani wrote:
> Document the sam9x75 quad spi that supports interface to serial memories
> operating in
> 
> - Single-bit SPI, Dual SPI, Quad SPI and Octal SPI
> - Single Data Rate or Double Data Rate modes

And I forgot - wrong subject prefixes.

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

Best regards,
Krzysztof


