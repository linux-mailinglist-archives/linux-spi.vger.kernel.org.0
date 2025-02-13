Return-Path: <linux-spi+bounces-6804-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9301A33963
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 08:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4075818895CC
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 07:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EE120B7F3;
	Thu, 13 Feb 2025 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuCe6YmM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1920B7E9;
	Thu, 13 Feb 2025 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433457; cv=none; b=PAEPNk4Uz5DBiMBCNj8cVzCz32olke1SDEBabnQYSXYkSTphv2Yu4tqKE4v7F1nEXLbTr3xu7S/A9g9eYsHkAMv+EL5mFC1XBBJcNN7aFAfMmHTnNeKM2/iA2Zpy6JyIwsy9dnbQPDAHcy4W+lSBS3epGyAtjR2bAQqxV0ml3ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433457; c=relaxed/simple;
	bh=zAmZ9xhiq8AXtyaFiGG3zq+eLh9vDaybujcV5FJePmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXRB+jvLQDMw+GimSzUByTcTZnlbbjgM/1q+9pbVl//aLd3HkkWGBuR+2Y3lJILo2EjG8e+ccy4mO1GBQlNPM45I5JI/kQliSuKtI59jEzuGD1WAAJE5A3C5nSMlGgkVbvM7VZU6EkUUVx+jyPA+9k/SMgV+R8Q1yGWgGgnsowk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuCe6YmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563A1C4CEE6;
	Thu, 13 Feb 2025 07:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739433457;
	bh=zAmZ9xhiq8AXtyaFiGG3zq+eLh9vDaybujcV5FJePmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YuCe6YmMraQeOLhCTzFKEp7FsiwxtYMnMqqqQczqDqPoZfQIIGYw4rWgT0XHnefHM
	 uJzMxTRF7rAdEDhsQhWUbnHzUfwhexTt1bQ6gI5sQc4FBDcS9znLTeOlbpNP6mo/qv
	 HGb5lJI4iw3u/dplus1e1lwAb103VFGxntzBF08kjwymvR+NLO4Vv7OCuIbGdObrYH
	 kArN1GuZWIP20JbAanqGNj13PEcqHyMs/NWgKXTZ+JKiMSx9fvm5KBbuTiDE4Gx871
	 4yJNcxl8388GkxH5MCTOJiW1ouB4Sg57ojJIfHQZUsUfvv9KYzLFFYYFuxf3A30i2s
	 85XLrVRZt02lw==
Date: Thu, 13 Feb 2025 08:57:33 +0100
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
Subject: Re: [PATCH v3 1/8] dt-bindings: spi: Add STM32 OSPI controller
Message-ID: <20250213-tuscan-coot-of-enrichment-5ae952@krzk-bin>
References: <20250210131826.220318-1-patrice.chotard@foss.st.com>
 <20250210131826.220318-2-patrice.chotard@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250210131826.220318-2-patrice.chotard@foss.st.com>

On Mon, Feb 10, 2025 at 02:18:19PM +0100, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
>=20
> Add device tree bindings for the STM32 OSPI controller.
>=20
> Main features of the Octo-SPI controller :
>   - support sNOR / sNAND / HyperRAM=E2=84=A2 and HyperFlash=E2=84=A2 devi=
ces.
>   - Three functional modes: indirect, automatic-status polling,

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


