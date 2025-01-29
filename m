Return-Path: <linux-spi+bounces-6556-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C9DA21848
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 08:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2F21651E1
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jan 2025 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31248198A36;
	Wed, 29 Jan 2025 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7608BvF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A819580F;
	Wed, 29 Jan 2025 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136437; cv=none; b=I0XwJxlhXgHihoxMVtMZy5SPsZwxxkHdsaJv6SOrHfBuUpd+W4Ak88Asq6pUSUFhAxuyXyXqa5Iyx4DVe1JBsNrLs1j03EqU43F5Huhhy9loi6hpeJ6j64iytI4hyaBJnrv40pPOnvDhfwOLYkq9gH8YzgTyvDrl7A6uH5x23Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136437; c=relaxed/simple;
	bh=PyibikrF+TCXgDznh/KR1T5STcTdoGrq2A8bnRmM4IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZQ9UuVbmK8XoK/lvItxosXftdizM2zw85CmEj65eqU7N+a3+PEFMV7uUIMDm+90j0hggDEJ+GqoXTY+6Zo2tv15lxcgzd6rLhCm8KSk1xtHwt5n4AGmH3k7P5XZJlf8V2OxO3GhtbFrM+sqyvAIXd42Qe9zGflXxttcTDCThmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7608BvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F6AC4CEE0;
	Wed, 29 Jan 2025 07:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738136436;
	bh=PyibikrF+TCXgDznh/KR1T5STcTdoGrq2A8bnRmM4IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q7608BvFKrGTZLp8LKqrqqhNxpzR95qM2PeidXfImjDePFz3SiI3bZIe3NMP+LEKA
	 fDnw3rdGkQqYv1/9BTHaJ6Th1qgMOXE/j+MyaW443cz1sX3U4Y5mXTKHCK6KuRWb86
	 WIi6w5nVBUkoBAVmTYgi7QeGlrK7y3j9UDpUhAyRXnQIKsUK9i1tmLEL1HNm20K1Ho
	 bBCzH2bRmAb3lnu4pF4qkU5/4kY6qci8qNiScqHJb/hrxjQ8tzDMGKh56B2rujJRzk
	 a06LrxYoVM/+f8QqPmqKriedkJ76lItcLzyTLpb6fKfgEGwyz2RooWr1v6Ft+93TSR
	 4vj6Z0DapzDkQ==
Date: Wed, 29 Jan 2025 08:40:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: patrice.chotard@foss.st.com, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, christophe.kerello@foss.st.com
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add STM32 OSPI controller
Message-ID: <20250129-annoying-flawless-porpoise-47daed@krzk-bin>
References: <20250128081731.2284457-1-patrice.chotard@foss.st.com>
 <20250128081731.2284457-2-patrice.chotard@foss.st.com>
 <20250128-panama-manly-a753d91c297c@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250128-panama-manly-a753d91c297c@spud>

On Tue, Jan 28, 2025 at 06:02:27PM +0000, Conor Dooley wrote:
> > +  st,syscfg-dlyb:
> > +    description: phandle to syscon block
> > +      Use to set the OSPI delay block within syscon to
> > +      tune the phase of the RX sampling clock (or DQS) in order
> > +      to sample the data in their valid window and to
> > +      tune the phase of the TX launch clock in order to meet setup
> > +      and hold constraints of TX signals versus the memory clock.
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> Why do you need a phandle here? I assume looking up by compatible ain't
> possible because you have multiple controllers on the SoC? Also, I don't
> think your copy-paste "phandle to" stuff here is accurate:
>       st,syscfg-dlyb = <&syscfg 0x1000>;
> There's an offset here that you don't mention in your description.

This needs double items: and listing them with description, instead of
free form text.

Best regards,
Krzysztof


