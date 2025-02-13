Return-Path: <linux-spi+bounces-6803-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528D3A33959
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 08:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7E91888DBF
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC6720AF6C;
	Thu, 13 Feb 2025 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quqrMz3u"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704ACBA2D;
	Thu, 13 Feb 2025 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433414; cv=none; b=WtZsEhubB8iJTsqOqBbNom2Q4+SYDyXnftKPcJ8JZR9nQM5/4+gAs47Jo1xUZ/+5GAgpQH3GzkWhmgGKHREIjtOVFznmiCxX1840btCyESZwgyDCK0YXPSaGWaytJ/dLJeeuStL5BurL0Wx0OSVCI5+9nG5GkTwW2duWbsNftRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433414; c=relaxed/simple;
	bh=Iw7l11wmjpe86HkNwFn62sRLFVZeqZaemNraot+F2wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czSOTjQUTUrZ+sYe0pvyleZJfo9tkXjVnjOtYvkHV27dKBE86kk2UP9V3zfDLjh1xJzgI4XeJV504gu6bzXXl+TOncU9aN91ELMdNhzuWJ4dRTCbLj/NZMyhMqnRqyAyBI2fiZs64Ae2fs4NLmminXhlvdjRGz3ujsan2WzeTMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quqrMz3u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A1CC4CED1;
	Thu, 13 Feb 2025 07:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739433413;
	bh=Iw7l11wmjpe86HkNwFn62sRLFVZeqZaemNraot+F2wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=quqrMz3uae0Oo1jl94HETvKATZAtuY6Grn6QVvedAs+nhmiWU8iCf+PIUUT7Iu1xw
	 7nxDal0wUQhsjviUmX1uPIMG4lyuTPZhKuZ88TJebIcXLgk0mfUHMnQ6OeeDuSEfnF
	 jB2WzNmyh+d12OSzhCxG6Ji03eMbFciaMXtvJLwzZqRwe+eudo8nI0VzWTuuODYGbK
	 0yOvGYX+kX/lOji/xeGL+dJOfCPCQesBt1gUgRJ5g9zxMwgeYFhU23A6+yE6/PlLNf
	 t/EBJx7NytUfUgxyERrzXkug8Zj9wkBpQaqtSEtk0fObmkhyR7t1XRXgkfJ6sfTwBv
	 1zK6LVJ+zIoxQ==
Date: Thu, 13 Feb 2025 08:56:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: patrice.chotard@foss.st.com
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, christophe.kerello@foss.st.com
Subject: Re: [PATCH v3 0/8] Add STM32MP25 SPI NOR support
Message-ID: <20250213-lush-rainbow-moth-0f5e18@krzk-bin>
References: <20250210131826.220318-1-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210131826.220318-1-patrice.chotard@foss.st.com>

On Mon, Feb 10, 2025 at 02:18:18PM +0100, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> This series adds SPI NOR support for STM32MP25 SoCs from STMicroelectronics,
> for that it adds support for:
>   - Octo Memory Manager driver.
>   - Octo SPI driver.
>   - yaml schema for Octo Memory Manager and Octo SPI drivers.
> 

You combined three different subsystems in one patchset and nothing here
explains why and what is the merging intention. Either split your work
or explain dependencies/merging.

Best regards,
Krzysztof


