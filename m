Return-Path: <linux-spi+bounces-12469-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B01D38E4A
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 12:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0801530092BC
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jan 2026 11:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4093128A3;
	Sat, 17 Jan 2026 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvUx9qF3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A79271457;
	Sat, 17 Jan 2026 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768650096; cv=none; b=REBqS/3cIsBa3dtWhzNA67ejn/pRYOzdagHU3O4JnYH7SYz/TC6m/01jJIl+nX+5J2auxHwEmLDQ9uPj7zP5DkTA0VqVpaejCX4LLZ1NIbi+nkP4KXkbAJLdGmHiAnZ0nMVngmITUTJw1mkJ4LtTXhOjyHuKMws/WOmewwcLg80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768650096; c=relaxed/simple;
	bh=EN4w6fHkkzoF8VBfe/UUIVNrkadCi2VHk54LmzRusYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dt/ar1DUr/BknUB9gfpSrjuMQ0I6efjFNYaiIomtsvFQ8Mjv0/tqx0GAwCYVcWuGyu8us7fD6U83MFmgwjmQFFO0sMmUWba4qLDCBOo8PeSgqYMAJQk/HeidQOkykSTLgX34iu0Hc9HQk0A9KYg/xoo8mCHd6N0RQNtq6NyJZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvUx9qF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B106AC4CEF7;
	Sat, 17 Jan 2026 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768650096;
	bh=EN4w6fHkkzoF8VBfe/UUIVNrkadCi2VHk54LmzRusYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvUx9qF3hvnb3/Q/mfpJM59biZ7WYrRxHlItmeM8adSbMfxNjwKfQH0Z9OmyX8k9i
	 tFDqAEeJRZANJD3LqIE9PRvwJcewc+ebK+uvXJt+xRD6Q8af1dsZHxg85oDSqB7wbC
	 8l/dMevV3LrzEtjE/VTnvHAmCG0Kwnw0rz+fuPH4As4bdKl+yCjGEd1I68n/OaEgeP
	 +tEQOrg71A9AXaF4GjTdyhJguKIrdnOtz0TFlAAKQgG7vIThJY9Ld3Xhtcz5vJTQSR
	 JZOWKDOQD810chHMstzwskLLBmKrZZ3MkrAqTivKUrR0MYCSyaJ79xpqkU0TablI1N
	 Uh5qFKXP4+b1A==
Date: Sat, 17 Jan 2026 12:41:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Andrew Lunn <andrew@lunn.ch>, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] spi: dt-bindings: xilinx: make interrupts optional
Message-ID: <20260117-polar-rat-of-current-adce4f@quoll>
References: <20260117012136.265220-1-abdurrahman@nexthop.ai>
 <20260117012136.265220-4-abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260117012136.265220-4-abdurrahman@nexthop.ai>

On Sat, Jan 17, 2026 at 01:21:36AM +0000, Abdurrahman Hussain wrote:
> This makes the driver work on platforms where interrupts are either not
> provided or broken.

Please slow down with your patchset. One patchset per 24h so you will
actually give people chance to review them. I just posted comments for
your v1.

Also one more note (please address v1 comments first):
Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94

Best regards,
Krzysztof


