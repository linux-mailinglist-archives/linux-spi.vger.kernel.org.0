Return-Path: <linux-spi+bounces-5761-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1B79D3628
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 10:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D1B1F21C72
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CA61953BB;
	Wed, 20 Nov 2024 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO4hbBPh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27A418EFC1;
	Wed, 20 Nov 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093186; cv=none; b=Fkz0qdRhLaE27PmF2GyOVMk3Mn5Git2a852+KBNFhAgwWZ4trPClVwnEl3KARw66jZHLPVGShCAbKiWotFK0Xzb4aPqSkv5Tnmvlz7/+8YdOMi/rYB/DoVmt4jZ2FVI+5ppytAeGOcvMlgCSxOvipaHkY//+pDM0FseNRnm54Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093186; c=relaxed/simple;
	bh=OPxTtvi9bEw4jt5RVpouDO/nbmR61bu/6KIe3jgDYWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsBkQJRvuT1HIsk3+xj4Y7GK59tSEgji9UoXoRBWoBwoEDADjwMddKCX0joIVKVL7NHV+byTAo6R2BPtAKoBTka2bTW457kHq3YTuXs/J5YSxFZuss9JkYOXMiHLzA7wQC1xMlD8T4wzOZ/8hSKzpiCfZ9s9eOR7aaniLoYxfm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO4hbBPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E937BC4CED7;
	Wed, 20 Nov 2024 08:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732093186;
	bh=OPxTtvi9bEw4jt5RVpouDO/nbmR61bu/6KIe3jgDYWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LO4hbBPhN7wipq33TWL7xfJXJl7Ur+4M2+kfkGL/weB5onfT2Wt0z76ycZ5g/mvF1
	 cYoQjD/ZsUtOvIKYCxEPMcRm3VfcEyHcdEcSdbZQLVA/L0GEv1DjWoSS4x/L6mREj4
	 8eSDSoCL/mJawiZqZtKTi34YQ3eY4RmVIACVY1oGFbYRfvdlkqpGyxseIJ9LdLHhCC
	 h0LWYuthg49LxsVbi2uPGJDq/btAdCT6wTTMoyaM2XbLNxWWMusJEUnVJaauJn4WgR
	 jO9IRmr+PO1jUwnKq8IDKiAIhBfUw+M68EAWObL/AvhwUPkhEo352XTI2XXpQX3Jmr
	 AG99BupmZRLEA==
Date: Wed, 20 Nov 2024 09:59:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
	mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de, dharma.b@microchip.com, 
	mihai.sain@microchip.com, romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 03/15] dt-bindings: atmel-sysreg: add sama7d65 RAM and PIT
Message-ID: <szwayqsq3zw3nc37fb3comys2wj5vdtv6peb7icwne4cxnraeb@uzpq3oxbhj6b>
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <01cf1bbae5949cbceb2768f2044377bc2479986b.1732030972.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01cf1bbae5949cbceb2768f2044377bc2479986b.1732030972.git.Ryan.Wanner@microchip.com>

On Tue, Nov 19, 2024 at 09:40:09AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add SAMA7D65 RAM controller, PIT64 DT bindings.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

Missing SoB.

This applies to all your patches probably.

Best regards,
Krzysztof


