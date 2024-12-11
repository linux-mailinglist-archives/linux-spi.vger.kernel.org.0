Return-Path: <linux-spi+bounces-6010-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8E99ED11C
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 17:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55AF168752
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 16:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F251DBB21;
	Wed, 11 Dec 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbLOeWps"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B624635F;
	Wed, 11 Dec 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733933809; cv=none; b=s6lEfcD0rSCGQ7isYEowkjjgWfP7GM0qJ9lAfsxYZAjPLm1QwTqQRdoq31u7iKOhYwcOYQh2JC6wf6KsGVetSW1c/WPN32pCSebkCA7QnVvLSlT/1QTo3PwSJnAe6hVqYshjzN8vIO98zsXiwDgWGUdHgbmFqr1XfT0eM+EhCJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733933809; c=relaxed/simple;
	bh=Fmred6fUcb7TjJVoN8NQW5ty6Zr9ba4jWUa9fBGMiL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8UBvLV5Bu+L9IfXedSYcdR8Y+gu4OvzIx6oMX8imcQnxEmOF4rW5EwGUQLILnZ3jnNTgJFDyGpGqDSmCe2J8HaSomiXxNE+51CGhNczopKMRyHwD7L1U+UmGZXqQv90FjOKZR40cwbRFFLrsbmUZdKIQDHtv+FWTszKFOUycDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbLOeWps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E77C4CED2;
	Wed, 11 Dec 2024 16:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733933808;
	bh=Fmred6fUcb7TjJVoN8NQW5ty6Zr9ba4jWUa9fBGMiL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbLOeWpsMoHd2n5mf6AXEQnTPJqARwZoXiZ+itBu93QX6acM6YS8Z13p4EOCUUGua
	 C9Wz9s2hD6habHNUzA7S5zfQHx4HSp1KzRVHa59O5UNC2NxOW9N10jA6epPY0v9+bE
	 tUvrREm9OAZ51OsfKiB1798C+AWQlC9Fff8juSJgwLeE8upMEpVGJDV1i0ih8jt4Kj
	 rm9jO+KyvjQvocbjw0/+Cdgr37RWSHCmCo2oZpF9aZ+1brOUT6c2QIBVNIrvrsN1iW
	 DFmoowtrd0Hs40SO0ZN5yCtUCgKtOb+oxcAZetWskreuvViEN5UY/sfrO/MWd0/5yd
	 QhjiungYNnMYQ==
Date: Wed, 11 Dec 2024 10:16:45 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: sboyd@kernel.org, krzk+dt@kernel.org, claudiu.beznea@tuxon.dev,
	romain.sioen@microchip.com, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
	alexandre.belloni@bootlin.com, varshini.rajendran@microchip.com,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	dharma.b@microchip.com, linux-spi@vger.kernel.org,
	linux-gpio@vger.kernel.org, mturquette@baylibre.com,
	mihai.sain@microchip.com, arnd@arndb.de, devicetree@vger.kernel.org,
	nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 05/13] dt-bindings: pinctrl: at91-pio4: add
 microchip,sama7d65-pinctrl
Message-ID: <173393380185.3240760.14016997587827186442.robh@kernel.org>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <b41307089b72fd92f8e2d314e4750194df9c888a.1733505542.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41307089b72fd92f8e2d314e4750194df9c888a.1733505542.git.Ryan.Wanner@microchip.com>


On Fri, 06 Dec 2024 12:59:50 -0700, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add pinctrl bindings for microchip sama7d65 SoC.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  .../devicetree/bindings/pinctrl/atmel,at91-pio4-pinctrl.txt      | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


